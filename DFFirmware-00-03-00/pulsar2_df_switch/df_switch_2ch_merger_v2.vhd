--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use work.data_formatter_constants.all;

entity df_switch_2ch_merger is
  generic (
    input_port1_use_short_fifo : std_logic := '0';
    input_port2_use_short_fifo : std_logic := '0');
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
    -- for module start control
    INPUT_PORT1_NEW_MOD_RDY : out std_logic;
    INPUT_PORT2_NEW_MOD_RDY : out std_logic;
    -- output port
    OUTPUT_PORT_DOUT : out std_logic_vector(31 downto 0);
    OUTPUT_PORT_DEN  : out std_logic;
    OUTPUT_PORT_RDY  : in  std_logic;
    -- for monitoring
    INPUT_PORT1_EMPTY_MON : out std_logic;
    INPUT_PORT2_EMPTY_MON : out std_logic;
    INPUT_PORT1_FULL_MON : out std_logic;
    INPUT_PORT2_FULL_MON : out std_logic;    
    OUTPUT_PORT_RDY_MON   : out std_logic;
    INPUT_PORT1_SELECTED_MON : out std_logic;
    INPUT_PORT2_SELECTED_MON : out std_logic
    );
end df_switch_2ch_merger;

architecture logic of df_switch_2ch_merger  is
  
  component fwft_cc_w36_d512_my_wrapper
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
  
  component short_fwft_fifo
    generic (
      AddressWidth : integer := 6 );
    port (
      clk : in std_logic;
      rst : in std_logic;
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      empty : out std_logic;
      ready_for_new_module : out std_logic;
      prog_full : out std_logic
      );
  end component;
  
  component short_fwft_fifo_d64_w32 is
    port (
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      din : in STD_LOGIC_VECTOR ( 31 downto 0 );
      wr_en : in STD_LOGIC;
      rd_en : in STD_LOGIC;
      dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
      full : out STD_LOGIC;
      empty : out STD_LOGIC;
      prog_full : out STD_LOGIC
      );
  end component;

  component short_fwft_fifo_d32_w32 is
    port (
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      din : in STD_LOGIC_VECTOR ( 31 downto 0 );
      wr_en : in STD_LOGIC;
      rd_en : in STD_LOGIC;
      dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
      full : out STD_LOGIC;
      empty : out STD_LOGIC;
      prog_full : out STD_LOGIC
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
                           WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER);
  
  signal current_state_i : state_machine_t := DECIDE_LANE_AS_PREPARATION;
  signal source_lane_i  : integer range 2 downto 1;
  
  type data_2lanes_t is array(2 downto 1) of std_logic_vector(31 downto 0);
  signal din_i : data_2lanes_t := (others => (others => '0'));
  signal den_i : std_logic_vector(2 downto 1);
  signal allow_read_fifo_at_next_cycle : std_logic;
  signal input_port1_selected : std_logic;
  signal input_port2_selected : std_logic;  
  signal dest_outport_i  : std_logic_vector(31 downto 0);
  
  signal float_port2 : std_logic_vector(3 downto 0);
  signal float_port1 : std_logic_vector(3 downto 0);
  
  signal output_buf_i : std_logic_vector(32 downto 0) := (others => '0');
  constant idle_word  : std_logic_vector(32 downto 0) := '0'&X"00000000";
  signal link_ready     : std_logic;
  constant data_valid   : std_logic := '1';
  constant MAX_MODULE_COUNT_IN_A_ROW : integer := 15;
  signal module_count_in_a_row : integer range 0 to MAX_MODULE_COUNT_IN_A_ROW;
  
  -- for DFF input
  signal input_port1_din_i : std_logic_vector(31 downto 0);
  signal input_port2_din_i : std_logic_vector(31 downto 0);
  signal input_port1_den_i : std_logic;
  signal input_port2_den_i : std_logic;  

  signal input_port1_ready_fo_new_module_i : std_logic := '1';
  signal input_port2_ready_fo_new_module_i : std_logic := '1';

  attribute mark_debug : string;
  attribute mark_debug of current_state_i : signal is "true";
  attribute mark_debug of din_i : signal is "true";
  attribute mark_debug of den_i : signal is "true";  
  
begin
  
  INPUT_PORT1_EMPTY_MON <= input_port1_empty_i;
  INPUT_PORT2_EMPTY_MON <= input_port2_empty_i;
  INPUT_PORT1_FULL_MON <= input_port1_full_i;
  INPUT_PORT2_FULL_MON <= input_port2_full_i;
  OUTPUT_PORT_RDY_MON   <= link_ready;
  INPUT_PORT1_SELECTED_MON <= input_port1_selected;
  INPUT_PORT2_SELECTED_MON <= input_port2_selected;
  
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
      
      INPUT_PORT1_NEW_MOD_RDY <= input_port1_ready_fo_new_module_i;
      INPUT_PORT2_NEW_MOD_RDY <= input_port2_ready_fo_new_module_i;
      
    end if;
  end process;
  
  -- input port1
  PORT1_LONG_FIFO_INST : if input_port1_use_short_fifo='0' generate
  begin
    INPUT_PORT1 : fwft_cc_w36_d512_my_wrapper
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
  end generate;

  PORT1_SHORT_FIFO_INST : if input_port1_use_short_fifo='1' generate
  begin
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
        ready_for_new_module => input_port1_ready_fo_new_module_i,        
        prog_full => input_port1_full_i
        );
    
    --INPUT_PORT1 : short_fwft_fifo_d64_w32
    --  port map (
    --    clk => CLK,
    --    rst => RST,
    --    din => input_port1_din_i,
    --    wr_en => input_port1_den_i,
    --    rd_en => input_go_next_if_exist_i(1),
    --    dout => input_port1_dout_i,
    --    empty => input_port1_empty_i,
    --    prog_full => input_port1_full_i
    --    );
    
  end generate;
  
  -- input port2
  PORT2_LONG_FIFO_INST : if input_port2_use_short_fifo='0' generate
  begin
    INPUT_PORT2 : fwft_cc_w36_d512_my_wrapper
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
  end generate;
  
  PORT2_SHORT_FIFO_INST : if input_port2_use_short_fifo='1' generate
  begin
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
        ready_for_new_module => input_port2_ready_fo_new_module_i,
        prog_full => input_port2_full_i
        );

    --INPUT_PORT2 : short_fwft_fifo_d64_w32
    --  port map (
    --    clk => CLK,
    --    rst => RST,
    --    din => input_port2_din_i,
    --    wr_en => input_port2_den_i,
    --    rd_en => input_go_next_if_exist_i(2),
    --    dout => input_port2_dout_i,
    --    empty => input_port2_empty_i,
    --    prog_full => input_port2_full_i
    --    );    
    
  end generate;
  
  link_ready <= OUTPUT_PORT_RDY;
  
  input_go_next_if_exist_i(1) <= link_ready and allow_read_fifo_at_next_cycle and input_port1_selected;
  input_go_next_if_exist_i(2) <= link_ready and allow_read_fifo_at_next_cycle and input_port2_selected;
  den_i(1)   <= not input_port1_empty_i;
  den_i(2)   <= not input_port2_empty_i;
  din_i(1)  <= input_port1_dout_i;
  din_i(2)  <= input_port2_dout_i;
  
  OUTPUT_PORT_DOUT <= output_buf_i(31 downto 0);
  OUTPUT_PORT_DEN  <= output_buf_i(32);
  
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
      dest_outport_i  <= (others => '0');
      
      -- signals category (2)
      output_buf_i    <= idle_word;
      module_count_in_a_row <= 0;
      
    elsif (CLK'event and CLK='1') then
      case current_state_i is 
        when DECIDE_LANE_AS_PREPARATION =>
          -- NO READ NO SEND but only check without updating the data
          -- if there is valid date and detemine the sampling input lane
          output_buf_i <= idle_word;
          
          if (den_i(1)='0' and den_i(2)='0') then
            current_state_i <= DECIDE_LANE_AS_PREPARATION;
            allow_read_fifo_at_next_cycle <= '0';
            
          elsif (den_i(1)='1' and den_i(2)='1') then
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            
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
            
          elsif (den_i(1)='1') then
            module_count_in_a_row <= 0;
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            source_lane_i <= 1;
            input_port1_selected <= '1';
            input_port2_selected <= '0';
          else
            module_count_in_a_row <= 0;
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            source_lane_i <= 2;
            input_port1_selected <= '0';
            input_port2_selected <= '1';            
          end if;
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER =>
          
          if (input_go_next_if_exist_i(source_lane_i)='1' and den_i(source_lane_i)='1') then                        
            
            if (din_i(source_lane_i) (DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_TRAILER) then
              output_buf_i<=data_valid & din_i(source_lane_i);
              current_state_i <= DECIDE_LANE_AS_PREPARATION;
              allow_read_fifo_at_next_cycle <= '0';
            else
              output_buf_i<=data_valid & din_i(source_lane_i);              
              current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
              allow_read_fifo_at_next_cycle <= '1';              
            end if;
            
          else
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            output_buf_i <= idle_word;
          end if;
          
      end case;
      
    end if;
  end process;
  
end logic;
