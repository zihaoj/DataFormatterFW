------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

library work;
use work.data_formatter_constants.all;
library unisim;
use unisim.vcomponents.all;

entity df_internallink_output is
  generic ( NO_SWITCH_MODE : integer := 0);  
  port (
    MAIN_CLK : in std_logic;
    
    DATA_IN : in  DF_ILO_IN_DATA_ARRAY;
    WEN_IN  : in  std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0);
    RDY_OUT : out std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0);
    
    INTERNALLINK_TX_DATA   : out DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
    INTERNALLINK_TX_DVALID : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_TX_RDY    : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    
    CENTRAL_SWITCH_OUT_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
    CENTRAL_SWITCH_OUT_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    CENTRAL_SWITCH_OUT_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    
    INTERNALLINK_OUTPUT_SWITCH_OUT_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
    INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    
    INTERNALLINK_OUTPUT_SWITCH_IN_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
    INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;        
    
    CENTRAL_SWITCH_RESET    : in  std_logic;
    CENTRAL_SWITCH_IN_RESET : out std_logic;
    INTERNALLINK_DESTINATION_WORD_ADDER_RESET   : in  std_logic;
    INTERNALLINK_DESTINATION_WORD_REMOVER_RESET : in  std_logic;
    INTERNALLINK_FORCE_READY : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_DESTINATION_WORDS : in DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY;
    
    CENTRAL_SWITCH_FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
    INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX
    );
end df_internallink_output;

architecture logic of df_internallink_output is
  
  component df_switch_matrix_32x32
    generic (
      -- could be used only in intermediate switch (i.e. CENTRAL SWITCH)
      USE_RANDOM_COUNTER_IN_HEADER : boolean := false);
    port (
      -- common clock
      CLK : in std_logic;
      RST : in std_logic;
      IN_RST : out std_logic;
      -- input port
      INPUT_DIN : in  DATA32_32X32_SWITCH_MATRIX_PORTS;
      INPUT_DEN : in  FLAGS_32X32_SWITCH_MATRIX_PORTS;
      INPUT_RDY : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      -- output port
      OUTPUT_DOUT : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_DEN  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_RDY  : in  FLAGS_32X32_SWITCH_MATRIX_PORTS;
      -- FIFO MONITORING
      FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX      
      );
  end component;
  
  component add_df_internallink_destination_word is
    generic ( LANE_ID : integer );
    port
      ( MAIN_CLK : in  std_logic;
        RESET_IN : in  std_logic;
        
        -- <input>
        DATA_IN   : in  std_logic_vector(31 downto 0);
        DEN_IN    : in  std_logic;
        READY_OUT : out std_logic;
        
        -- <output>
        DATA_OUT : out std_logic_vector(31 downto 0);
        WEN_OUT  : out std_logic;
        XOFF_IN  : in  std_logic;
        
        -- configuration / monitoring port
        --LOCAL_DESTINATION_WORD      : in  std_logic_vector(15 downto 0);
        INTERNALLINK_DESTINATION_WORDS : in DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY;
        
        STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
        );
  end component;
  
  component remove_df_internallink_destination_word
    port
      ( MAIN_CLK : in  std_logic;
        RESET_IN : in  std_logic;
        
        -- <input>
        DATA_IN   : in  std_logic_vector(31 downto 0);
        DEN_IN    : in  std_logic;
        READY_OUT : out std_logic;
        
        -- <output>
        DATA_OUT : out std_logic_vector(31 downto 0);
        WEN_OUT  : out std_logic;
        XOFF_IN  : in  std_logic;
        
        -- configuration / monitoring port
        STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
        );
  end component;
  
  signal central_switch_input_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS := (others => (others=> '0'));
  signal central_switch_input_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '0');
  signal central_switch_input_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '1');
  
  signal central_switch_output_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS := (others => (others=> '0'));
  signal central_switch_output_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '0');
  signal central_switch_output_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '1');
  
  signal internallink_output_switch_input_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS := (others => (others=> '0'));
  signal internallink_output_switch_input_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '0');
  signal internallink_output_switch_input_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '1');
  
  signal internallink_output_switch_output_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS := (others => (others=> '0'));
  signal internallink_output_switch_output_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '0');
  signal internallink_output_switch_output_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '1');  
  
begin
  
  -- input line assignment
  INTERNALLINK_INPUT_LANES : for iLane in 0 to NUMBER_OF_ILO_IN_LANES-1 generate
  begin
    central_switch_input_data_i(iLane) <= DATA_IN(iLane);
    central_switch_input_den_i(iLane)  <= WEN_IN(iLane);
    RDY_OUT(iLane)                     <= central_switch_input_rdy_i(iLane);
  end generate;

  CENTRAL_SWTICH_INST : if NO_SWITCH_MODE = 0 generate
  begin
    CENTRAL_SWITCH : df_switch_matrix_32x32
      generic map (
        -- could be used only in intermediate switch (i.e. CENTRAL SWITCH)
        USE_RANDOM_COUNTER_IN_HEADER => true)
      port map (
        CLK => MAIN_CLK,
        RST => CENTRAL_SWITCH_RESET,
        IN_RST => CENTRAL_SWITCH_IN_RESET,
        -- input port
        INPUT_DIN => central_switch_input_data_i,
        INPUT_DEN => central_switch_input_den_i,
        INPUT_RDY => central_switch_input_rdy_i,
        -- output port
        OUTPUT_DOUT => central_switch_output_data_i,
        OUTPUT_DEN  => central_switch_output_den_i,
        OUTPUT_RDY  => central_switch_output_rdy_i,
        -- FIFO MONITORING
        FIFO_MONITORING => CENTRAL_SWITCH_FIFO_MONITORING        
        );
  end generate;

  NO_CENTRAL_SWTICH_INST : if NO_SWITCH_MODE /= 0 generate
    central_switch_output_data_i <= central_switch_input_data_i;
    central_switch_output_den_i  <= central_switch_input_den_i;
    central_switch_input_rdy_i   <= central_switch_output_rdy_i;
  end generate;
  
  process (MAIN_CLK)
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      CENTRAL_SWITCH_OUT_DATA_MONITOR <= central_switch_output_data_i;
      CENTRAL_SWITCH_OUT_DEN_MONITOR  <= central_switch_output_den_i;
      CENTRAL_SWITCH_OUT_RDY_MONITOR  <= central_switch_output_rdy_i;
    end if;
  end process;
  
  CENTRAL_SWITCH_OUTPUT_LANES : for iLane in 0 to NUMBER_OF_CENTRALSWITCH_OUTPUT_LANES-1 generate
    signal data_buf : std_logic_vector(31 downto 0);
    signal wen_buf  : std_logic;
    signal rdy_buf  : std_logic;
    signal xoff     : std_logic;
    constant ilosw_lane : integer := MAPPING_CONF_CENTRALSW2INTERNALLINKOUTPUTSW(iLane);
  begin
    
    process (MAIN_CLK) is
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        data_buf <= central_switch_output_data_i(iLane);
        wen_buf  <= central_switch_output_den_i(iLane);
        central_switch_output_rdy_i(iLane) <= rdy_buf;
      end if;
    end process;
    
    my_port_assignment : add_df_internallink_destination_word
      generic map ( LANE_ID => iLane)
      port map
      ( MAIN_CLK => MAIN_CLK,
        RESET_IN => INTERNALLINK_DESTINATION_WORD_ADDER_RESET,
        DATA_IN   => data_buf,
        DEN_IN    => wen_buf,
        READY_OUT => rdy_buf,
        DATA_OUT  => internallink_output_switch_input_data_i(ilosw_lane),
        WEN_OUT   => internallink_output_switch_input_den_i(ilosw_lane),
        XOFF_IN   => xoff,
        INTERNALLINK_DESTINATION_WORDS => INTERNALLINK_DESTINATION_WORDS,
        STATE_MACHINE_ERROR_MONITOR => open
        );
    xoff <= not internallink_output_switch_input_rdy_i(ilosw_lane);
    
  end generate;
  
  OUTPUT_SWTICH_INST : if NO_SWITCH_MODE = 0 generate
  begin
    INTERNALLINK_OUTPUT_SWITCH : df_switch_matrix_32x32
      port map (
        CLK => MAIN_CLK,
        RST => CENTRAL_SWITCH_RESET,
        IN_RST => CENTRAL_SWITCH_IN_RESET,
        -- input port
        INPUT_DIN => internallink_output_switch_input_data_i,
        INPUT_DEN => internallink_output_switch_input_den_i,
        INPUT_RDY => internallink_output_switch_input_rdy_i,
        -- output port
        OUTPUT_DOUT => internallink_output_switch_output_data_i,
        OUTPUT_DEN  => internallink_output_switch_output_den_i,
        OUTPUT_RDY  => internallink_output_switch_output_rdy_i,
        -- FIFO MONITORING
        FIFO_MONITORING => INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING
        );
  end generate;

  NO_OUTPUT_SSWITCH_INST : if NO_SWITCH_MODE /= 0 generate
  begin
    internallink_output_switch_output_data_i <= internallink_output_switch_input_data_i;
    internallink_output_switch_output_den_i  <= internallink_output_switch_input_den_i;
    internallink_output_switch_input_rdy_i   <= internallink_output_switch_output_rdy_i;
  end generate;
  
  process (MAIN_CLK)
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      INTERNALLINK_OUTPUT_SWITCH_IN_DATA_MONITOR <= internallink_output_switch_input_data_i;
      INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR  <= internallink_output_switch_input_den_i;
      INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR  <= internallink_output_switch_input_rdy_i;
      
      INTERNALLINK_OUTPUT_SWITCH_OUT_DATA_MONITOR <= internallink_output_switch_output_data_i;
      INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR  <= internallink_output_switch_output_den_i;
      INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR  <= internallink_output_switch_output_rdy_i;      
    end if;
  end process;

  INTERNALLINK_OUTPUT_LANES : for iGtLane in 0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 generate
    constant ilosw_ch : integer := MAPPING_CONF_INTERNALLINKCH2INTERNALLINKOUTPUTSW(iGtLane);
    signal   xoff_i   : std_logic;
    signal   data_i   : std_logic_vector(31 downto 0);
    signal   den_i    : std_logic;
    signal   rdy_i    : std_logic;
  begin    
    
    process (MAIN_CLK) is
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        data_i                                            <= internallink_output_switch_output_data_i(ilosw_ch);
        den_i                                             <= internallink_output_switch_output_den_i(ilosw_ch);
        internallink_output_switch_output_rdy_i(ilosw_ch) <= rdy_i;
                
      end if;
    end process;
    
    remover_local_destination_word : remove_df_internallink_destination_word
      port map
      ( MAIN_CLK => MAIN_CLK,
        RESET_IN => INTERNALLINK_DESTINATION_WORD_REMOVER_RESET,
        
        -- <input>
        DATA_IN   => data_i,
        DEN_IN    => den_i,
        READY_OUT => rdy_i,
        
        -- <output>
        DATA_OUT => INTERNALLINK_TX_DATA(iGtLane),
        WEN_OUT  => INTERNALLINK_TX_DVALID(iGtLane),
        XOFF_IN  => xoff_i,
        
        -- configuration / monitoring port
        STATE_MACHINE_ERROR_MONITOR => open
        );
    xoff_i <= (not INTERNALLINK_TX_RDY(iGtLane)) and (not INTERNALLINK_FORCE_READY(iGtLane));
    
  end generate;
  
end logic;
