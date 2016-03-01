--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use work.data_formatter_constants.all;

entity df_internal_link_buffer_switch is
  port (
    -- common clock
    CLK : in std_logic;
    RST : in std_logic;
    -- input port
    INPUT_PORT_DIN : in  std_logic_vector(31 downto 0);
    INPUT_PORT_DEN : in  std_logic;
    INPUT_PORT_RDY : out std_logic;
    -- output port
    OUTPUT_PORT1_DOUT : out std_logic_vector(31 downto 0);
    OUTPUT_PORT1_DEN  : out std_logic;
    OUTPUT_PORT1_RDY  : in  std_logic;
    OUTPUT_PORT2_DOUT : out std_logic_vector(31 downto 0);
    OUTPUT_PORT2_DEN  : out std_logic;
    OUTPUT_PORT2_RDY  : in  std_logic;
    -- OUTPUT MASK (CONFIGURABLE if needed)
    OUTPORT1_MASK : in std_logic_vector(31 downto 0);
    OUTPORT2_MASK : in std_logic_vector(31 downto 0)
    );
end df_internal_link_buffer_switch;

architecture logic of df_internal_link_buffer_switch is
  
  component fwft_cc_w36_d512_my_wrapper
    port (
      rst : in std_logic;
      clk : in std_logic;      
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      empty : out std_logic;
      prog_full : out std_logic
      );
  end component;
  
  signal input_port_empty_i : std_logic;
  signal input_port_full_i : std_logic;
  signal input_port_dout_i : std_logic_vector(31 downto 0);
  
  signal input_go_next_if_exist_i : std_logic;
  
  -- 
  type state_machine_t is (WAIT_SAMPLE_HEADER,
                           WAIT_SAMPLE_DESTINATION_BIT_IF_EXIST_AND_SEND_HEADER,
                           WAIT_SEND_DESTINATION_BIT,
                           WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER);
  
  signal current_state_i : state_machine_t := WAIT_SAMPLE_HEADER;
  
  signal output_lanes_i : std_logic_vector(2 downto 1);
  
  signal din_i : std_logic_vector(31 downto 0);
  signal den_i : std_logic;
  signal allow_read_fifo_at_next_cycle : std_logic;
  signal header_buffer_i : std_logic_vector(31 downto 0) := (others => '0');
  signal dest_outport1_i : std_logic_vector(31 downto 0);
  signal dest_outport2_i : std_logic_vector(31 downto 0);

  signal float_port  : std_logic_vector(3 downto 0);
  
  type outbuf_2lanes_t is array(2 downto 1) of std_logic_vector(32 downto 0);
  signal output_buf_i : outbuf_2lanes_t := (others => (others => '0'));
  constant idle_word : std_logic_vector(32 downto 0) := '0'&X"00000000";
  signal link_ready : std_logic;
  constant data_valid : std_logic := '1';
  constant MAX_MODULE_COUNT_IN_A_ROW : integer := 15;
  signal module_count_in_a_row : integer range 0 to MAX_MODULE_COUNT_IN_A_ROW;
  
begin
  
  -- input port1
  INPUT_PORT_RDY <= '0' when input_port_empty_i='0' and input_port_full_i='1' else '1';
  
  INPUT_PORT : fwft_cc_w36_d512_my_wrapper
    port map (
      rst    => RST,
      clk    => CLK,
      din(31 downto 0)  => INPUT_PORT_DIN,
      din(35 downto 32) => (others => '0'),
      wr_en  => INPUT_PORT_DEN,
      rd_en  => input_go_next_if_exist_i,
      dout(31 downto 0)  => input_port_dout_i,
      dout(35 downto 32) => float_port,
      empty  => input_port_empty_i,
      prog_full => input_port_full_i
      );
  
  input_go_next_if_exist_i <= link_ready and allow_read_fifo_at_next_cycle;
  den_i <= not input_port_empty_i;
  din_i <= input_port_dout_i;
  
  OUTPUT_PORT1_DOUT <= output_buf_i(1)(31 downto 0);
  OUTPUT_PORT2_DOUT <= output_buf_i(2)(31 downto 0);
  OUTPUT_PORT1_DEN  <= output_buf_i(1)(32);
  OUTPUT_PORT2_DEN  <= output_buf_i(2)(32);

  process (CLK)
  begin
    if (CLK'event and CLK='1') then
      if (output_lanes_i="11") then
        link_ready <= OUTPUT_PORT1_RDY and OUTPUT_PORT2_RDY;
      elsif (output_lanes_i(1)='1') then
        link_ready <= OUTPUT_PORT1_RDY;
      elsif (output_lanes_i(2)='1') then
        link_ready <= OUTPUT_PORT2_RDY;
      else
        link_ready <= OUTPUT_PORT1_RDY and OUTPUT_PORT2_RDY;
      end if;
             
    end if;
  end process;
  
  -- State Machine
  process (CLK, RST)
  begin
    if    (RST='1') then
      -- signals category (1)
      -- to be updated according to the next state
      current_state_i <= WAIT_SAMPLE_HEADER;
      allow_read_fifo_at_next_cycle <= '0';
      -- NOTE THIS VARIABLE should be updated when
      -- current_state_i updated
      
      -- others 
      output_lanes_i <= "00";
      header_buffer_i <= (others => '0');
      dest_outport1_i <= (others => '0');
      dest_outport2_i <= (others => '0');
      
      -- signals category (2)
      output_buf_i(1) <= idle_word;
      output_buf_i(2) <= idle_word;

      module_count_in_a_row <= 0;
      
    elsif (CLK'event and CLK='1') then
      case current_state_i is 
        
        when WAIT_SAMPLE_HEADER =>
          -- READ is required to go to next step
          output_buf_i(1) <= idle_word;
          output_buf_i(2) <= idle_word;
          
          if (input_go_next_if_exist_i='1' and den_i='1') then
            current_state_i <= WAIT_SAMPLE_DESTINATION_BIT_IF_EXIST_AND_SEND_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            header_buffer_i <= din_i;
          else
            current_state_i <= WAIT_SAMPLE_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
          end if;
          
        when WAIT_SAMPLE_DESTINATION_BIT_IF_EXIST_AND_SEND_HEADER =>
          -- READ is required to go to next step
          -- detemine the destination lanes
          
          if (input_go_next_if_exist_i='1' and den_i='1') then
            current_state_i <= WAIT_SEND_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            
            -- for output lane 1
            if ( or_reduce(din_i and OUTPORT1_MASK) = '1' ) then
              output_lanes_i(1) <= '1';
              output_buf_i(1) <= data_valid & header_buffer_i;
              dest_outport1_i <= din_i and OUTPORT1_MASK;
            else
              output_lanes_i(1) <= '0';
              output_buf_i(1) <= idle_word;
            end if;
            
            -- for output lane 2
            if ( or_reduce(din_i and OUTPORT2_MASK) = '1' ) then
              output_lanes_i(2) <= '1';
              output_buf_i(2) <= data_valid & header_buffer_i;
              dest_outport2_i <= din_i and OUTPORT2_MASK;
            else
              output_lanes_i(2) <= '0';
              output_buf_i(2) <= idle_word;
            end if;
            
          else
            current_state_i <= WAIT_SAMPLE_DESTINATION_BIT_IF_EXIST_AND_SEND_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            output_buf_i(1) <= idle_word;
            output_buf_i(2) <= idle_word;
          end if;
          
        when WAIT_SEND_DESTINATION_BIT =>
          -- Send is required (link to be established) to go to next step
          -- NO READ
          
          
          if (link_ready='1') then
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            
            if (output_lanes_i(1)='1') then output_buf_i(1)<=data_valid & dest_outport1_i;
            else output_buf_i(1) <= idle_word; end if;
            
            if (output_lanes_i(2)='1') then output_buf_i(2)<=data_valid & dest_outport2_i;
            else output_buf_i(2) <= idle_word; end if;
            
          else
            current_state_i <= WAIT_SEND_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            output_buf_i(1) <= idle_word;
            output_buf_i(2) <= idle_word;            
          end if;
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER =>
          -- READ is required to go to next step
          -- if the current sampling data is Trailer word
          -- the state will be shifted
          
          
          if (input_go_next_if_exist_i='1' and den_i='1') then
            
            if (output_lanes_i(1)='1') then output_buf_i(1)<=data_valid & din_i;
            else output_buf_i(1) <= idle_word; end if;
            
            if (output_lanes_i(2)='1') then output_buf_i(2)<=data_valid & din_i;
            else output_buf_i(2) <= idle_word; end if;
            
            if (din_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_TRAILER) then
              current_state_i <= WAIT_SAMPLE_HEADER;
              allow_read_fifo_at_next_cycle <= '1';
            end if;
            
          else
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            output_buf_i(1) <= idle_word;
            output_buf_i(2) <= idle_word;
          end if;
          
      end case;
      
    end if;
  end process;
end logic;
