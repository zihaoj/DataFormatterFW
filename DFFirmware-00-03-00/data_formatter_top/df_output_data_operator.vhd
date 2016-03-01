------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

library work;
use work.data_formatter_constants.all;
library unisim;
use unisim.vcomponents.all;

entity df_output_data_operator is
  generic ( NO_SWITCH_MODE : integer := 0;
            NO_EVENT_SORTING_MODE : integer := 0);
  port (
    MAIN_CLK : in  std_logic;    
    
    DATA_IN   : in  DF_ODO_IN_DATA_ARRAY;
    DEN_IN    : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    READY_OUT : out std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    
    FRAME_DATA_IN  : in  std_logic_vector(31 downto 0);
    FRAME_WEN_IN   : in  std_logic;
    FRAME_CTRL_IN  : in  std_logic;      
    FRAME_XOFF_OUT : out std_logic;
    
    SLINK_UD       : out DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
    SLINK_UWEN_N   : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    SLINK_UCTRL_N  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    SLINK_LFF_N    : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    SLINK_LDOWN_N  : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    
    PIXMOD2FTKPLANE_ADDR_CONFIN  : in  DF_PIXMOD2FTKPLANE_ADDR_ARRAY;
    PIXMOD2FTKPLANE_DATA_CONFIN  : in  DF_PIXMOD2FTKPLANE_DATA_ARRAY;
    PIXMOD2FTKPLANE_WEN_CONFIN   : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    PIXMOD2FTKPLANE_DATA_CONFOUT : out DF_PIXMOD2FTKPLANE_DATA_ARRAY;
    PIXMOD2TOWER_ADDR_CONFIN     : in  DF_PIXMOD2TOWER_ADDR_ARRAY;
    PIXMOD2TOWER_DATA_CONFIN     : in  DF_PIXMOD2TOWER_DATA_ARRAY;
    PIXMOD2TOWER_WEN_CONFIN      : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    PIXMOD2TOWER_DATA_CONFOUT    : out DF_PIXMOD2TOWER_DATA_ARRAY;
    PIXMOD2DUPLICATION_ADDR_CONFIN:in  DF_PIXMOD2DUPLICATION_ADDR_ARRAY;
    PIXMOD2DUPLICATION_DATA_CONFIN:in  DF_PIXMOD2DUPLICATION_DATA_ARRAY;
    PIXMOD2DUPLICATION_WEN_CONFIN :in  std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
    PIXMOD2DUPLICATION_DATA_CONFOUT: out DF_PIXMOD2DUPLICATION_DATA_ARRAY;
    
    SCTMOD2FTKPLANE_ADDR_CONFIN  : in  DF_SCTMOD2FTKPLANE_ADDR_ARRAY;
    SCTMOD2FTKPLANE_DATA_CONFIN  : in  DF_SCTMOD2FTKPLANE_DATA_ARRAY;
    SCTMOD2FTKPLANE_WEN_CONFIN   : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    SCTMOD2FTKPLANE_DATA_CONFOUT : out DF_SCTMOD2FTKPLANE_DATA_ARRAY;
    SCTMOD2TOWER_ADDR_CONFIN     : in  DF_SCTMOD2TOWER_ADDR_ARRAY;
    SCTMOD2TOWER_DATA_CONFIN     : in  DF_SCTMOD2TOWER_DATA_ARRAY;
    SCTMOD2TOWER_WEN_CONFIN      : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    SCTMOD2TOWER_DATA_CONFOUT    : out DF_SCTMOD2TOWER_DATA_ARRAY;
    SCTMOD2DUPLICATION_ADDR_CONFIN:in  DF_SCTMOD2DUPLICATION_ADDR_ARRAY;
    SCTMOD2DUPLICATION_DATA_CONFIN:in  DF_SCTMOD2DUPLICATION_DATA_ARRAY;
    SCTMOD2DUPLICATION_WEN_CONFIN :in  std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
    SCTMOD2DUPLICATION_DATA_CONFOUT: out DF_SCTMOD2DUPLICATION_DATA_ARRAY;
    
    FTKPLANE_STATE_MACHINE_ERROR_MONITOR     : out DF_ODO_IN_STATE_MACHINE_ERROR_MONITOR_ARRAY;

    SLINK_PACKER_STATE_MACHINE_ERROR_MONITOR : out DF_ERROR_MONITOR_GT_FOR_SLINK_OUTPUT_LANE_ARRAY;
    SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES  : in  DF_GT_FOR_SLINK_OUTPUT_LANES_INTEGER_ARRAY;

    -- for monitoring purpose <>
    OUTPUT_SWITCH_IN_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
    OUTPUT_SWITCH_IN_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    OUTPUT_SWITCH_IN_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    
    OUTPUT_SWITCH_OUT_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
    OUTPUT_SWITCH_OUT_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    OUTPUT_SWITCH_OUT_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
    
    OUTPUT_FORCE_READY         : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    FTKPLANE_WORD_ADDER_RESET  : in  std_logic;
    OUTPUT_SWITCH_MERGER_RESET : in  std_logic;
    OUTPUT_SWITCH_RESET        : in  std_logic;
    DUPLICATOR_RESET           : in  std_logic;
    SLINK_PACKER_RESET         : in  std_logic;
    OUTPUT_SWITCH_IN_RESET     : out std_logic
    );
end df_output_data_operator;

architecture logic of df_output_data_operator is
  component df_output_preparation
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
        PIXMOD2FTKPLANE_ADDR_CONFIN  : in  std_logic_vector(10 downto 0);
        PIXMOD2FTKPLANE_DATA_CONFIN  : in  std_logic_vector(11 downto 0);
        PIXMOD2FTKPLANE_WEN_CONFIN   : in  std_logic;
        PIXMOD2FTKPLANE_DATA_CONFOUT : out std_logic_vector(11 downto 0);
        
        PIXMOD2TOWER_ADDR_CONFIN  : in  std_logic_vector(10 downto 0);
        PIXMOD2TOWER_DATA_CONFIN  : in  std_logic_vector(1 downto 0);
        PIXMOD2TOWER_WEN_CONFIN   : in  std_logic;
        PIXMOD2TOWER_DATA_CONFOUT : out std_logic_vector(1 downto 0);
        
        SCTMOD2FTKPLANE_ADDR_CONFIN  : in  std_logic_vector(12 downto 0);
        SCTMOD2FTKPLANE_DATA_CONFIN  : in  std_logic_vector(11 downto 0);
        SCTMOD2FTKPLANE_WEN_CONFIN   : in  std_logic;
        SCTMOD2FTKPLANE_DATA_CONFOUT : out std_logic_vector(11 downto 0);
        
        SCTMOD2TOWER_ADDR_CONFIN  : in  std_logic_vector(12 downto 0);
        SCTMOD2TOWER_DATA_CONFIN  : in  std_logic_vector(1 downto 0);
        SCTMOD2TOWER_WEN_CONFIN   : in  std_logic;
        SCTMOD2TOWER_DATA_CONFOUT : out std_logic_vector(1 downto 0);
        
        STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
        );
  end component;
  
  component df_switch_matrix_32x32
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
      OUTPUT_RDY  : in  FLAGS_32X32_SWITCH_MATRIX_PORTS
      );
  end component;
  
  component df_switch_2ch_merger
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
      OUTPUT_PORT_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT_DEN  : out std_logic;
      OUTPUT_PORT_RDY  : in  std_logic
      );
  end component;
  
  component df_output_slink_packer
    port (
      -- common clock
      MAIN_CLK : in std_logic;
      RESET_IN : in std_logic;
      -- input port
      MODDATA_DIN : in  std_logic_vector(31 downto 0);
      MODDATA_DEN : in  std_logic;
      MODDATA_RDY : out std_logic;
      -- input port
      FRAME_DATA_IN  : in  std_logic_vector(31 downto 0);
      FRAME_WEN_IN   : in  std_logic;
      FRAME_CTRL_IN  : in  std_logic;      
      FRAME_XOFF_OUT : out std_logic;      
      -- output port
      SLINK_UD       : out std_logic_vector(31 downto 0);
      SLINK_UWEN_N   : out std_logic;
      SLINK_UCTRL_N  : out std_logic;
      SLINK_LFF_N    : in  std_logic;
      SLINK_LDOWN_N  : in  std_logic;
      -- send back to input of switch
      SEND_BACK_PORT_DOUT : out std_logic_vector(31 downto 0);
      SEND_BACK_PORT_DEN  : out std_logic;
      SEND_BACK_PORT_RDY  : in  std_logic;

      -- <configure / monitor>
      NUMBER_OF_EXPECTED_MODULES  : in  integer;
      STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
      );
  end component;

  component df_output_duplicator
    port
      ( MAIN_CLK : in  std_logic;
        RESET_IN : in  std_logic;
        
        -- <input>
        DATA_IN   : in  std_logic_vector(31 downto 0);
        DEN_IN    : in  std_logic;
        READY_OUT : out std_logic;
        
        -- <output>
        PORT0_DATA_OUT : out std_logic_vector(31 downto 0);
        PORT0_WEN_OUT  : out std_logic;
        PORT0_XOFF_IN  : in  std_logic;
        
        PORT1_DATA_OUT : out std_logic_vector(31 downto 0);
        PORT1_WEN_OUT  : out std_logic;
        PORT1_XOFF_IN  : in  std_logic;      
        
        -- configuration / monitoring port
        PIXMOD2DUPLICATION_ADDR_CONFIN  : in  std_logic_vector(10 downto 0);
        PIXMOD2DUPLICATION_DATA_CONFIN  : in  std_logic_vector(1 downto 0);
        PIXMOD2DUPLICATION_WEN_CONFIN   : in  std_logic;
        PIXMOD2DUPLICATION_DATA_CONFOUT : out std_logic_vector(1 downto 0);
        
        SCTMOD2DUPLICATION_ADDR_CONFIN  : in  std_logic_vector(12 downto 0);
        SCTMOD2DUPLICATION_DATA_CONFIN  : in  std_logic_vector(1 downto 0);
        SCTMOD2DUPLICATION_WEN_CONFIN   : in  std_logic;
        SCTMOD2DUPLICATION_DATA_CONFOUT : out std_logic_vector(1 downto 0);            
        
        STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
        );
  end component;
  
  signal frame_xoff_out_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0) := (others=>'0');
  
  signal output_switch_input_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS := (others => (others=> '0'));
  signal output_switch_input_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '0');
  signal output_switch_input_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '1');
  
  signal output_switch_output_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS := (others => (others=> '0'));
  signal output_switch_output_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '0');
  signal output_switch_output_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS := (others => '1');  

  signal slink_packer_input_data_i : DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
  signal slink_packer_input_den_i  :std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal slink_packer_input_rdy_i  :std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  
  signal lut_data_out_i : DF_ODO_IN_DATA_ARRAY := (others => (others=> '0'));
  signal lut_den_out_i  : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0) := (others => '0');
  signal lut_out_xoff_i : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0) := (others => '0');
  signal merger_rdy_out_lut_i  : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0) := (others => '1');
  
  --signal too_early_data_back_data_i  : DF_ODO_IN_DATA_ARRAY := (others => (others=> '0'));
  --signal too_early_data_back_den_i   : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0) := (others => '0');
  --signal merger_rdy_out_eventsoter_i : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0) := (others => '1');
  

begin
  
  --- DFF for output
  process (MAIN_CLK, SLINK_PACKER_RESET)
  begin
    if (SLINK_PACKER_RESET='1') then
      FRAME_XOFF_OUT <= '1';
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      FRAME_XOFF_OUT <= or_reduce(frame_xoff_out_i);
    end if;
  end process;
  
  OUTPUT_SWITCH_INPUT_LANES : for iLane in 0 to NUMBER_OF_ODO_IN_LANES-1 generate
  begin
    OUTPUT_SW_PREPARATION : df_output_preparation
      port map 
      ( MAIN_CLK => MAIN_CLK, RESET_IN => FTKPLANE_WORD_ADDER_RESET,
        
        -- <input>
        DATA_IN   => DATA_IN(iLane),
        DEN_IN    => DEN_IN(iLane),
        READY_OUT => READY_OUT(iLane),
        
        -- <output>
        DATA_OUT => lut_data_out_i(iLane),
        WEN_OUT  => lut_den_out_i(iLane),
        XOFF_IN  => lut_out_xoff_i(iLane),
        
        PIXMOD2FTKPLANE_ADDR_CONFIN  => PIXMOD2FTKPLANE_ADDR_CONFIN(iLane),
        PIXMOD2FTKPLANE_DATA_CONFIN  => PIXMOD2FTKPLANE_DATA_CONFIN(iLane),
        PIXMOD2FTKPLANE_WEN_CONFIN   => PIXMOD2FTKPLANE_WEN_CONFIN(iLane),
        PIXMOD2FTKPLANE_DATA_CONFOUT => PIXMOD2FTKPLANE_DATA_CONFOUT(iLane),
        
        PIXMOD2TOWER_ADDR_CONFIN  => PIXMOD2TOWER_ADDR_CONFIN(iLane),
        PIXMOD2TOWER_DATA_CONFIN  => PIXMOD2TOWER_DATA_CONFIN(iLane),
        PIXMOD2TOWER_WEN_CONFIN   => PIXMOD2TOWER_WEN_CONFIN(iLane),
        PIXMOD2TOWER_DATA_CONFOUT => PIXMOD2TOWER_DATA_CONFOUT(iLane),
        
        SCTMOD2FTKPLANE_ADDR_CONFIN  => SCTMOD2FTKPLANE_ADDR_CONFIN(iLane),
        SCTMOD2FTKPLANE_DATA_CONFIN  => SCTMOD2FTKPLANE_DATA_CONFIN(iLane),
        SCTMOD2FTKPLANE_WEN_CONFIN   => SCTMOD2FTKPLANE_WEN_CONFIN(iLane),
        SCTMOD2FTKPLANE_DATA_CONFOUT => SCTMOD2FTKPLANE_DATA_CONFOUT(iLane),
        
        SCTMOD2TOWER_ADDR_CONFIN  => SCTMOD2TOWER_ADDR_CONFIN(iLane),
        SCTMOD2TOWER_DATA_CONFIN  => SCTMOD2TOWER_DATA_CONFIN(iLane),
        SCTMOD2TOWER_WEN_CONFIN   => SCTMOD2TOWER_WEN_CONFIN(iLane),
        SCTMOD2TOWER_DATA_CONFOUT => SCTMOD2TOWER_DATA_CONFOUT(iLane),        
        
        STATE_MACHINE_ERROR_MONITOR => FTKPLANE_STATE_MACHINE_ERROR_MONITOR(iLane)
        );

    -- to make it simple
    --lut_out_xoff_i(iLane) <= not merger_rdy_out_lut_i(iLane);
    --MERGER : df_switch_2ch_merger
    --  port map (
    --    CLK => MAIN_CLK, 
    --    RST => OUTPUT_SWITCH_MERGER_RESET,
    --    INPUT_PORT1_DIN => lut_data_out_i(iLane),
    --    INPUT_PORT1_DEN => lut_den_out_i(iLane),
    --    INPUT_PORT1_RDY => merger_rdy_out_lut_i(iLane),
    --    INPUT_PORT2_DIN => too_early_data_back_data_i(iLane),
    --    INPUT_PORT2_DEN => too_early_data_back_den_i(iLane),
    --    INPUT_PORT2_RDY => merger_rdy_out_eventsoter_i(iLane),
    --    OUTPUT_PORT_DOUT => output_switch_input_data_i(iLane),
    --    OUTPUT_PORT_DEN  => output_switch_input_den_i(iLane),
    --    OUTPUT_PORT_RDY  => output_switch_input_rdy_i(iLane)
    --    );
    
    lut_out_xoff_i(iLane) <= (not output_switch_input_rdy_i(iLane));
    output_switch_input_data_i(iLane) <= lut_data_out_i(iLane);
    output_switch_input_den_i(iLane)  <= lut_den_out_i(iLane);
    
  end generate;
  
  process (MAIN_CLK)
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      OUTPUT_SWITCH_IN_DATA_MONITOR <= output_switch_input_data_i;
      OUTPUT_SWITCH_IN_DEN_MONITOR  <= output_switch_input_den_i;
      OUTPUT_SWITCH_IN_RDY_MONITOR  <= output_switch_input_rdy_i;
      
      OUTPUT_SWITCH_OUT_DATA_MONITOR <= output_switch_output_data_i;
      OUTPUT_SWITCH_OUT_DEN_MONITOR  <= output_switch_output_den_i;
      OUTPUT_SWITCH_OUT_RDY_MONITOR  <= output_switch_output_rdy_i;
    end if;
  end process;
  
  -- ================================================================================
  SWTICH_INST : if NO_SWITCH_MODE = 0 generate
  begin
    -- OUTPUT SWITCH
    OUTPUT_SWITCH : df_switch_matrix_32x32
      port map (
        CLK => MAIN_CLK,
        RST => OUTPUT_SWITCH_RESET,
        IN_RST => OUTPUT_SWITCH_IN_RESET,
        -- input port
        INPUT_DIN => output_switch_input_data_i,
        INPUT_DEN => output_switch_input_den_i,
        INPUT_RDY => output_switch_input_rdy_i,
        -- output port
        OUTPUT_DOUT => output_switch_output_data_i,
        OUTPUT_DEN  => output_switch_output_den_i,
        OUTPUT_RDY  => output_switch_output_rdy_i
        );
  end generate;

  -- ================================================================================
  NO_SWITCH_INST : if NO_SWITCH_MODE /= 0 generate
  begin
    output_switch_output_data_i <= output_switch_input_data_i;
    output_switch_output_den_i  <= output_switch_input_den_i;
    output_switch_input_rdy_i   <= output_switch_output_rdy_i;
    OUTPUT_SWITCH_IN_RESET      <= '0';
  end generate;  

  -- ================================================================================
  SSB_LANES : for iLane in 0 to NUMBER_OF_SSB_OUTPUT-1 generate
    constant outputsw_channel : integer := MAPPING_CONF_SSBCH2OUTPUTSW(iLane);
    constant slinkch          : integer := MAPPING_CONF_SSBCH2SLINKOUTCH(iLane);
  begin
    slink_packer_input_data_i(slinkch) <= output_switch_output_data_i(outputsw_channel);
    slink_packer_input_den_i(slinkch)  <= output_switch_output_den_i(outputsw_channel);
    output_switch_output_rdy_i(outputsw_channel) <= slink_packer_input_rdy_i(slinkch);
  end generate;
  
  -- ================================================================================
  AUX_LANES : for iLane in 0 to NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 generate
    constant outputsw_channel : integer := MAPPING_CONF_AUXCH2OUTPUTSW(iLane);
    constant port0_slinkch    : integer := MAPPING_CONF_AUXCH2PORT0SLINKOUTCH(iLane);
    constant port1_slinkch    : integer := MAPPING_CONF_AUXCH2PORT1SLINKOUTCH(iLane);
    signal xoff_port0 : std_logic;
    signal xoff_port1 : std_logic;
  begin
    
    xoff_port0 <= (not slink_packer_input_rdy_i(port0_slinkch));
    xoff_port1 <= (not slink_packer_input_rdy_i(port1_slinkch));
    
    my_duplicator : df_output_duplicator
      port map
      ( MAIN_CLK => MAIN_CLK,
        RESET_IN => DUPLICATOR_RESET,
        
        DATA_IN   => output_switch_output_data_i(outputsw_channel),
        DEN_IN    => output_switch_output_den_i(outputsw_channel),
        READY_OUT => output_switch_output_rdy_i(outputsw_channel),
        
        PORT0_DATA_OUT => slink_packer_input_data_i(port0_slinkch),
        PORT0_WEN_OUT  => slink_packer_input_den_i(port0_slinkch),
        PORT0_XOFF_IN  => xoff_port0,
        
        PORT1_DATA_OUT => slink_packer_input_data_i(port1_slinkch),
        PORT1_WEN_OUT  => slink_packer_input_den_i(port1_slinkch),
        PORT1_XOFF_IN  => xoff_port1,
        
        PIXMOD2DUPLICATION_ADDR_CONFIN  => PIXMOD2DUPLICATION_ADDR_CONFIN(iLane),
        PIXMOD2DUPLICATION_DATA_CONFIN  => PIXMOD2DUPLICATION_DATA_CONFIN(iLane),
        PIXMOD2DUPLICATION_WEN_CONFIN   => PIXMOD2DUPLICATION_WEN_CONFIN(iLane),
        PIXMOD2DUPLICATION_DATA_CONFOUT => PIXMOD2DUPLICATION_DATA_CONFOUT(iLane),
        
        SCTMOD2DUPLICATION_ADDR_CONFIN  => SCTMOD2DUPLICATION_ADDR_CONFIN(iLane),
        SCTMOD2DUPLICATION_DATA_CONFIN  => SCTMOD2DUPLICATION_DATA_CONFIN(iLane),
        SCTMOD2DUPLICATION_WEN_CONFIN   => SCTMOD2DUPLICATION_WEN_CONFIN(iLane),
        SCTMOD2DUPLICATION_DATA_CONFOUT => SCTMOD2DUPLICATION_DATA_CONFOUT(iLane),
        
        STATE_MACHINE_ERROR_MONITOR => open
        );
  end generate;

  -- ================================================================================
  OUTPUT_SLINK_OUT : for iLane in 0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 generate
    signal slink_lff_n_i   : std_logic;
    signal slink_ldown_n_i : std_logic;
  begin  
    slink_lff_n_i   <= OUTPUT_FORCE_READY(iLane) or SLINK_LFF_N(iLane);
    slink_ldown_n_i <= OUTPUT_FORCE_READY(iLane) or SLINK_LDOWN_N(iLane);
    
    -- <TO BE IMPROVED !!>
    SLINK_PACKER : df_output_slink_packer
      port map (
        MAIN_CLK => MAIN_CLK, RESET_IN => SLINK_PACKER_RESET,
        -- input port
        MODDATA_DIN => slink_packer_input_data_i(iLane),
        MODDATA_DEN => slink_packer_input_den_i(iLane),
        MODDATA_RDY => slink_packer_input_rdy_i(iLane),
        -- input port
        FRAME_DATA_IN  => FRAME_DATA_IN,
        FRAME_WEN_IN   => FRAME_WEN_IN,
        FRAME_CTRL_IN  => FRAME_CTRL_IN,
        FRAME_XOFF_OUT => frame_xoff_out_i(iLane),
        -- output port
        SLINK_UD       => SLINK_UD(iLane),
        SLINK_UWEN_N   => SLINK_UWEN_N(iLane),
        SLINK_UCTRL_N  => SLINK_UCTRL_N(iLane),
        SLINK_LFF_N    => slink_lff_n_i,
        SLINK_LDOWN_N  => slink_ldown_n_i,
        -- send back to input of switch
        --SEND_BACK_PORT_DOUT => too_early_data_back_data_i(iLane),
        --SEND_BACK_PORT_DEN  => too_early_data_back_den_i(iLane),
        --SEND_BACK_PORT_RDY  => merger_rdy_out_eventsoter_i(iLane),
        SEND_BACK_PORT_DOUT => open,
        SEND_BACK_PORT_DEN  => open,
        SEND_BACK_PORT_RDY  => '1',
        
        -- <configure / monitor>
        NUMBER_OF_EXPECTED_MODULES  => SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES(iLane),
        STATE_MACHINE_ERROR_MONITOR => SLINK_PACKER_STATE_MACHINE_ERROR_MONITOR(iLane)
        );
  end generate;
  
end logic;
