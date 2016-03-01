--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use work.data_formatter_constants.all;

entity df_switch_element is
  port (
    -- common clock
    CLK : in std_logic;
    RST : in std_logic;
    -- input port
    INPUT_PORT1_DIN : in  std_logic_vector(31 downto 0);
    INPUT_PORT1_DEN : in  std_logic;
    INPUT_PORT1_RDY : out std_logic;
    INPUT_PORT2_DIN : in  std_logic_vector(31 downto 0);
    INPUT_PORT2_DEN : in  std_logic;
    INPUT_PORT2_RDY : out std_logic;
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
end df_switch_element;

architecture logic of df_switch_element  is

  component short_fwft_fifo
    port (
      clk : in std_logic;
      rst : in std_logic;
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      empty : out std_logic;
      prog_full : out std_logic
      );
  end component;
  
  signal input_port1_empty_i : std_logic;
  signal input_port1_full_i : std_logic;
  signal input_port1_dout_i : std_logic_vector(31 downto 0);
  
  signal input_port2_empty_i : std_logic;
  signal input_port2_full_i : std_logic;
  signal input_port2_dout_i : std_logic_vector(31 downto 0);

  signal input_go_next_if_exist_i : std_logic_vector(2 downto 1);
  
  -- 
  type state_machine_t is (DECIDE_LANE_AS_PREPARATION,
                           WAIT_SAMPLE_HEADER,
                           WAIT_SAMPLE_DESTINATION_BIT_IF_EXIST_AND_SEND_HEADER,
                           WAIT_SEND_DESTINATION_BIT,
                           WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER);
  
  signal current_state_i : state_machine_t := DECIDE_LANE_AS_PREPARATION;
  
  signal source_lane_i  : integer range 2 downto 1;
  signal output_lanes_i : std_logic_vector(2 downto 1);
  
  type data_2lanes_t is array(2 downto 1) of std_logic_vector(31 downto 0);
  signal din_i : data_2lanes_t := (others => (others => '0'));
  signal den_i : std_logic_vector(2 downto 1);
  signal allow_read_fifo_at_next_cycle : std_logic;
  signal input_port1_selected : std_logic;
  signal input_port2_selected : std_logic;  
  signal header_buffer_i : std_logic_vector(31 downto 0) := (others => '0');
  signal dest_outport1_i : std_logic_vector(31 downto 0);
  signal dest_outport2_i : std_logic_vector(31 downto 0);

  signal float_port2 : std_logic_vector(3 downto 0);
  signal float_port1 : std_logic_vector(3 downto 0);

  type outbuf_2lanes_t is array(2 downto 1) of std_logic_vector(32 downto 0);
  signal output_buf_i : outbuf_2lanes_t := (others => (others => '0'));
  constant idle_word : std_logic_vector(32 downto 0) := '0'&X"00000000";
  signal link_ready : std_logic;
  constant data_valid : std_logic := '1';
  constant MAX_MODULE_COUNT_IN_A_ROW : integer := 15;
  signal module_count_in_a_row : integer range 0 to MAX_MODULE_COUNT_IN_A_ROW;

  -- for DFF input
  signal input_port1_din_i : std_logic_vector(31 downto 0);
  signal input_port2_din_i : std_logic_vector(31 downto 0);
  signal input_port1_den_i : std_logic;
  signal input_port2_den_i : std_logic;  
  
begin
  
  -- input port1 / port2
  process (CLK) is
  begin
    if (CLK'event and CLK='1') then
      input_port1_din_i <= INPUT_PORT1_DIN;
      input_port1_den_i <= INPUT_PORT1_DEN;
      
      input_port2_din_i <= INPUT_PORT2_DIN;
      input_port2_den_i <= INPUT_PORT2_DEN;
      
      if (input_port1_empty_i='0' and input_port1_full_i='1') then
        INPUT_PORT1_RDY <= '0';
      else
        INPUT_PORT1_RDY <= '1';
      end if;
      
      if (input_port2_empty_i='0' and input_port2_full_i='1') then
        INPUT_PORT2_RDY <= '0';
      else
        INPUT_PORT2_RDY <= '1';
      end if;            
    end if;
  end process;
  
  INPUT_PORT1 : short_fwft_fifo 
    port map (
      clk => CLK,
      rst => RST,
      din(31 downto  0) => input_port1_din_i,
      din(35 downto 32) => (others => '0'),
      wr_en => input_port1_den_i,
      rd_en => input_go_next_if_exist_i(1),
      dout(31 downto  0) => input_port1_dout_i,
      dout(35 downto 32) => float_port1,
      empty => input_port1_empty_i,
      prog_full => input_port1_full_i
      );
  
  INPUT_PORT2 : short_fwft_fifo 
    port map (
      clk => CLK,
      rst => RST,
      din(31 downto  0) => input_port2_din_i,
      din(35 downto 32) => (others => '0'),
      wr_en => input_port2_den_i,
      rd_en => input_go_next_if_exist_i(2),
      dout(31 downto  0) => input_port2_dout_i,
      dout(35 downto 32) => float_port2,      
      empty => input_port2_empty_i,
      prog_full => input_port2_full_i
      );
  
  input_go_next_if_exist_i(1) <= link_ready and allow_read_fifo_at_next_cycle and input_port1_selected;
  input_go_next_if_exist_i(2) <= link_ready and allow_read_fifo_at_next_cycle and input_port2_selected;
  den_i(1)   <= not input_port1_empty_i;
  den_i(2)   <= not input_port2_empty_i;
  din_i(1)  <= input_port1_dout_i;
  din_i(2)  <= input_port2_dout_i;
  
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
      current_state_i <= DECIDE_LANE_AS_PREPARATION;
      allow_read_fifo_at_next_cycle <= '0';
      -- NOTE THIS VARIABLE should be updated when
      -- current_state_i updated
      
      -- others 
      input_port1_selected <= '0';
      input_port2_selected <= '0';
      source_lane_i  <= 2;
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
        when DECIDE_LANE_AS_PREPARATION =>
          -- NO READ NO SEND but only check without updating the data
          -- if there is valid date and detemine the sampling input lane
          output_buf_i(1) <= idle_word;
          output_buf_i(2) <= idle_word;          
          
          if (den_i(1)='0' and den_i(2)='0') then
            current_state_i <= DECIDE_LANE_AS_PREPARATION;
            allow_read_fifo_at_next_cycle <= '0';
            
          elsif (den_i(1)='1' and den_i(2)='1') then
            current_state_i <= WAIT_SAMPLE_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            -- both of them empty
            if ( CONV_INTEGER( din_i(1)(DFIF_EVID_LAST downto DFIF_EVID_FIRST) ) =
                 CONV_INTEGER( din_i(2)(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) ) then
              -- event ID is the same
              if (source_lane_i=2) then
                module_count_in_a_row <= 0;
                source_lane_i <= 1;
                input_port1_selected <= '1';
                input_port2_selected <= '0';
              else
                module_count_in_a_row <= 0;
                source_lane_i <= 2;
                input_port1_selected <= '0';
                input_port2_selected <= '1';
              end if;

            elsif module_count_in_a_row=MAX_MODULE_COUNT_IN_A_ROW then
              if (source_lane_i=2) then
                module_count_in_a_row <= 0;
                source_lane_i <= 1;
                input_port1_selected <= '1';
                input_port2_selected <= '0';
              else
                module_count_in_a_row <= 0;
                source_lane_i <= 2;
                input_port1_selected <= '0';
                input_port2_selected <= '1';
              end if;              
              
            elsif ( (( CONV_INTEGER( din_i(1)(DFIF_EVID_LAST downto DFIF_EVID_FIRST) ) -
                       CONV_INTEGER( din_i(2)(DFIF_EVID_LAST downto DFIF_EVID_FIRST) ) + MAX_EVT_ID ) mod MAX_EVT_ID) >
                    (( CONV_INTEGER( din_i(2)(DFIF_EVID_LAST downto DFIF_EVID_FIRST) ) -
                       CONV_INTEGER( din_i(1)(DFIF_EVID_LAST downto DFIF_EVID_FIRST) ) + MAX_EVT_ID ) mod MAX_EVT_ID) ) then
              -- EVENT #1 < EVENT #2
              module_count_in_a_row <= module_count_in_a_row + 1;
              source_lane_i <= 1;
              input_port1_selected <= '1';
              input_port2_selected <= '0';              
            else
              module_count_in_a_row <= module_count_in_a_row + 1;
              source_lane_i <= 2;
              input_port1_selected <= '0';
              input_port2_selected <= '1';
            end if;
            
          elsif (den_i(1)='1') then
            current_state_i <= WAIT_SAMPLE_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            source_lane_i <= 1;
            input_port1_selected <= '1';
            input_port2_selected <= '0';
          else
            current_state_i <= WAIT_SAMPLE_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            source_lane_i <= 2;
            input_port1_selected <= '0';
            input_port2_selected <= '1';            
          end if;

        when WAIT_SAMPLE_HEADER =>
          -- READ is required to go to next step
          output_buf_i(1) <= idle_word;
          output_buf_i(2) <= idle_word;
          
          if (input_go_next_if_exist_i(source_lane_i)='1' and den_i(source_lane_i)='1') then
            current_state_i <= WAIT_SAMPLE_DESTINATION_BIT_IF_EXIST_AND_SEND_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            header_buffer_i <= din_i(source_lane_i);
          else
            current_state_i <= WAIT_SAMPLE_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
          end if;
          
        when WAIT_SAMPLE_DESTINATION_BIT_IF_EXIST_AND_SEND_HEADER =>
          -- READ is required to go to next step
          -- detemine the destination lanes
          
          if (input_go_next_if_exist_i(source_lane_i)='1' and den_i(source_lane_i)='1') then
            current_state_i <= WAIT_SEND_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            
            -- for output lane 1
            if ( or_reduce(din_i(source_lane_i) and OUTPORT1_MASK) = '1' ) then
              output_lanes_i(1) <= '1';
              output_buf_i(1) <= data_valid & header_buffer_i;
              dest_outport1_i <= din_i(source_lane_i) and OUTPORT1_MASK;
            else
              output_lanes_i(1) <= '0';
              output_buf_i(1) <= idle_word;
            end if;
            
            -- for output lane 2
            if ( or_reduce(din_i(source_lane_i) and OUTPORT2_MASK) = '1' ) then
              output_lanes_i(2) <= '1';
              output_buf_i(2) <= data_valid & header_buffer_i;
              dest_outport2_i <= din_i(source_lane_i) and OUTPORT2_MASK;
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
          
          
          if (input_go_next_if_exist_i(source_lane_i)='1' and den_i(source_lane_i)='1') then
            
            if (output_lanes_i(1)='1') then output_buf_i(1)<=data_valid & din_i(source_lane_i);
            else output_buf_i(1) <= idle_word; end if;
            
            if (output_lanes_i(2)='1') then output_buf_i(2)<=data_valid & din_i(source_lane_i);
            else output_buf_i(2) <= idle_word; end if;
            
            if (din_i(source_lane_i) (DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_TRAILER) then
              current_state_i <= DECIDE_LANE_AS_PREPARATION;
              allow_read_fifo_at_next_cycle <= '0';
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

----------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.std_logic_arith.all;
    
entity GrayAddressCounter is
    generic (
      COUNTER_WIDTH :integer := 4
    );
    port (                                  --'Gray' code count output.
      GrayCount_out   :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      -- "NEXT" Binary Counter Out
      BinaryCount_out :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      Enable_in       :in  std_logic;       -- Count enable.
      Clear_in        :in  std_logic;       -- Count reset.
      clk             :in  std_logic        -- Input clock
    );  
end GrayAddressCounter;

architecture rtl of GrayAddressCounter is
  signal BinaryCount :std_logic_vector (COUNTER_WIDTH-1 downto 0) := conv_std_logic_vector(0, COUNTER_WIDTH);
begin
  BinaryCount_out <= BinaryCount; 
  process (clk, Clear_in)
  begin
    if (Clear_in = '1') then
      --Gray count begins @ '1' with
      BinaryCount   <= conv_std_logic_vector(1, COUNTER_WIDTH);  
      GrayCount_out <= (others=>'0');
      
    elsif (clk'event and clk='1') then
      -- first 'Enable_in'.
      if (Enable_in = '1') then
        BinaryCount   <= BinaryCount + 1;
        GrayCount_out <= (BinaryCount(COUNTER_WIDTH-1) & 
                          (BinaryCount(COUNTER_WIDTH-2 downto 0) xor 
                           BinaryCount(COUNTER_WIDTH-1 downto 1)));
      end if;
    end if;
  end process;
  
end rtl;


----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity short_fwft_fifo is
  port (
    clk : in std_logic;
    rst : in std_logic;
    din : in std_logic_vector ( 35 downto 0 );
    wr_en : in std_logic;
    rd_en : in std_logic;
    dout : out std_logic_vector ( 35 downto 0 );
    empty : out std_logic;
    prog_full : out std_logic
    );
end short_fwft_fifo;

architecture logic of short_fwft_fifo is
  
  constant AddressWidth : integer := 6;
  constant NStage       : integer := 2**AddressWidth;
  
  type short_buffer_t is array (0 to NStage-1) of std_logic_vector (35 downto 0);
  signal buf        : short_buffer_t := (others => (others => '0'));
  signal raddr      : std_logic_vector (AddressWidth-1 downto 0);
  signal raddr_inc  : std_logic := '0';
  signal waddr      : std_logic_vector (AddressWidth-1 downto 0);
  signal raddr_bin  : std_logic_vector (AddressWidth-1 downto 0);
  signal waddr_bin  : std_logic_vector (AddressWidth-1 downto 0);  
  signal empty_buf  : std_logic := '1';
  
  component GrayAddressCounter
    generic (
      COUNTER_WIDTH :integer := AddressWidth
      );
    port (                                  --'Gray' code count output.
      GrayCount_out   :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      -- "NEXT" Binary Counter Out
      BinaryCount_out :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      Enable_in       :in  std_logic;       -- Count enable.
      Clear_in        :in  std_logic;       -- Count reset.
      clk             :in  std_logic        -- Input clock
      );  
  end component;
  
begin
  
  WriteAddress : GrayAddressCounter
    port map (
      GrayCount_out=>waddr, BinaryCount_out=>waddr_bin, Enable_in =>wr_en, Clear_in =>rst, clk=>clk);
  
  ReadAddress : GrayAddressCounter
    port map (
      GrayCount_out=>raddr, BinaryCount_out=>raddr_bin, Enable_in =>raddr_inc, Clear_in =>rst, clk=>clk);  
  
  dout <= buf(CONV_INTEGER(raddr));
  
  FullHandler : process (clk, rst)
  begin
    if    (rst='1') then
      prog_full <= '1';
    elsif (clk'event and clk='1') then
      if ((CONV_INTEGER(waddr_bin)+NStage-CONV_INTEGER(raddr_bin)) mod NStage) > NStage-7 then
        prog_full <= '1';
      else
        prog_full <= '0';
      end if;
    end if;
  end process;
  
  empty     <= empty_buf;
  raddr_inc <= '1' when ((empty_buf='0') and (rd_en='1')) else '0';
  EmptyHandler : process (clk, rst)
  begin
    if    (rst='1') then
      empty_buf <= '1';
    elsif (clk'event and clk='1') then
      if (empty_buf = '1') then
        if (wr_en='1') then
          empty_buf <= '0';
        end if;
      else 
        if (rd_en='1' and wr_en='0' and raddr_bin+1=waddr_bin) then
        --if (wr_en='0' and raddr_bin+1=waddr_bin) then
          empty_buf <= '1';
        end if;
      end if;
    end if;
  end process;  
  
  WriteOperator : process (clk)
  begin
    if (clk'event and clk='1') then
      if (wr_en='1') then
        buf(CONV_INTEGER(waddr)) <= din;
      end if;
    end if;
  end process;

end logic;
