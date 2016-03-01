------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.FmcConstants.all;
use work.data_formatter_constants.all;

library unisim;
use unisim.vcomponents.all;

entity df_top is
  generic (
    EXAMPLE_SIM_GTRESET_SPEEDUP : string    := "TRUE";    -- Set to TRUE to speed up sim reset        
    SIMULATION : integer := 0;
    NO_SWITCH_MODE : integer := 0; -- TO BE CONFIGURED PROPERLY WRT TESTING PURPOSE
    common_clk_frequency : real :=200.00;
    USE_4K_SPY_BUFFER             : std_logic := '1'; -- '0' 1K spybuffer 
                                                      -- '1' 4k spybuffer
    SAMPLE_INTERNALLINK_INPUT     : std_logic := '1';
    SAMPLE_FMCIN_FRONT_DATA       : std_logic := '0'; -- if needed, please turn-on
    SAMPLE_SPYOUT_AT_FMCCOMMONCLK : std_logic := '0');
  port (  
    -- SYSCLK
    SYSCLK_P : in std_logic;
    SYSCLK_N : in std_logic;
    
    -- I2C
    FB_SCL : inout std_logic;
    FB_SDA : inout std_logic;
    
    -- LED
    LED0 : out std_logic;
    LED1 : out std_logic;
    LED2 : out std_logic;
    LED3 : out std_logic;
    
    -- IPBUS
    ETH_GTREFCLK_N_IN : in std_logic;
    ETH_GTREFCLK_P_IN : in std_logic;
    ETH_GT_TXP        : out std_logic;
    ETH_GT_TXN        : out std_logic;
    ETH_GT_RXP        : in std_logic;
    ETH_GT_RXN        : in std_logic;
    
    -- <FB1> 
    FB1_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB1_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB1_CLK0_P : in std_logic;
    FB1_CLK0_N : in std_logic;
    FB1_CLK1_P : in std_logic;
    FB1_CLK1_N : in std_logic;
    FB1_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB1_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB1_TX_FWD_CLK_P : out std_logic;
    FB1_TX_FWD_CLK_N : out std_logic;
    FB1_SOFT_RESET0_P : out std_logic;
    FB1_SOFT_RESET0_N : out std_logic;
    FB1_SOFT_RESET1_P : out std_logic;
    FB1_SOFT_RESET1_N : out std_logic;    

    -- <FB2> 
    FB2_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB2_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB2_CLK0_P : in std_logic;
    FB2_CLK0_N : in std_logic;
    FB2_CLK1_P : in std_logic;
    FB2_CLK1_N : in std_logic;
    FB2_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB2_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB2_TX_FWD_CLK_P : out std_logic;
    FB2_TX_FWD_CLK_N : out std_logic;
    FB2_SOFT_RESET0_P : out std_logic;
    FB2_SOFT_RESET0_N : out std_logic;
    FB2_SOFT_RESET1_P : out std_logic;
    FB2_SOFT_RESET1_N : out std_logic;
    
    -- <FB3> 
    FB3_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB3_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB3_CLK0_P : in std_logic;
    FB3_CLK0_N : in std_logic;
    FB3_CLK1_P : in std_logic;
    FB3_CLK1_N : in std_logic;
    FB3_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB3_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB3_TX_FWD_CLK_P : out std_logic;
    FB3_TX_FWD_CLK_N : out std_logic;
    FB3_SOFT_RESET0_P : out std_logic;
    FB3_SOFT_RESET0_N : out std_logic;
    FB3_SOFT_RESET1_P : out std_logic;
    FB3_SOFT_RESET1_N : out std_logic;
    
    -- <FB4> 
    FB4_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB4_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB4_CLK0_P : in std_logic;
    FB4_CLK0_N : in std_logic;
    FB4_CLK1_P : in std_logic;
    FB4_CLK1_N : in std_logic;
    FB4_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB4_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB4_TX_FWD_CLK_P : out std_logic;
    FB4_TX_FWD_CLK_N : out std_logic;
    FB4_SOFT_RESET0_P : out std_logic;
    FB4_SOFT_RESET0_N : out std_logic;
    FB4_SOFT_RESET1_P : out std_logic;
    FB4_SOFT_RESET1_N : out std_logic;    
    
    GTREFCLK_N_IN : in std_logic_vector(NUMBER_OF_GT_REFCLKS-1 downto 0);
    GTREFCLK_P_IN : in std_logic_vector(NUMBER_OF_GT_REFCLKS-1 downto 0);
    
    SLINK_LSC_RXN_IN  : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    SLINK_LSC_RXP_IN  : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    SLINK_LSC_TXN_OUT : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    SLINK_LSC_TXP_OUT : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    
    INTERNALLINK_RXN_IN  : in   std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_RXP_IN  : in   std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_TXN_OUT : out  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_TXP_OUT : out  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0)
    );  
end df_top;    

architecture logic of df_top is
  
  component df_main
    generic (
      NO_SWITCH_MODE : integer := 0; -- TO BE CONFIGURED PROPERLY WRT TESTING PURPOSE
      common_clk_frequency : real :=200.00;
      SAMPLE_SPYOUT_AT_FMCCOMMONCLK : std_logic := SAMPLE_SPYOUT_AT_FMCCOMMONCLK);
    port (
      MAIN_CLK       : in std_logic;
      FMC_COMMON_CLK : in std_logic;
      
      -- <FMC IO ports>
      -- <FB1>
      FB1_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB1_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB1_CLK0_P : in std_logic;
      FB1_CLK0_N : in std_logic;
      FB1_CLK1_P : in std_logic;
      FB1_CLK1_N : in std_logic;
      FB1_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      FB1_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      FB1_TX_FWD_CLK_P : out std_logic;
      FB1_TX_FWD_CLK_N : out std_logic;

      -- <FB2>
      FB2_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB2_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB2_CLK0_P : in std_logic;
      FB2_CLK0_N : in std_logic;
      FB2_CLK1_P : in std_logic;
      FB2_CLK1_N : in std_logic;
      FB2_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      FB2_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      FB2_TX_FWD_CLK_P : out std_logic;
      FB2_TX_FWD_CLK_N : out std_logic;
      
      -- <FB3>
      FB3_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB3_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB3_CLK0_P : in std_logic;
      FB3_CLK0_N : in std_logic;
      FB3_CLK1_P : in std_logic;
      FB3_CLK1_N : in std_logic;
      FB3_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      FB3_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      FB3_TX_FWD_CLK_P : out std_logic;
      FB3_TX_FWD_CLK_N : out std_logic;
      
      -- <FB4>
      FB4_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB4_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB4_CLK0_P : in std_logic;
      FB4_CLK0_N : in std_logic;
      FB4_CLK1_P : in std_logic;
      FB4_CLK1_N : in std_logic;
      FB4_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      FB4_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      FB4_TX_FWD_CLK_P : out std_logic;
      FB4_TX_FWD_CLK_N : out std_logic;
      
      -- <SLINK IO>
      SLINK_LSC_UD       : out DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
      SLINK_LSC_UCTRL_N  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_UWEN_N   : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_LFF_N    : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_LDOWN_N  : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      
      -- <INTERNAL LINK IO>
      INTERNALLINK_TX_DATA   : out DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
      INTERNALLINK_TX_DVALID : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_TX_RDY    : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_DATA   : in  DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
      INTERNALLINK_RX_DVALID : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_BUSY   : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      
      -- <Configuration>
      -- <FMCIN>
      FMCIN_CONFIG_CHANNELDELAY_DIR : in data_type_for_imfpga_input_lanes_t;
      FMCIN_CONFIG_CHANNELDELAY_CE  : in data_type_for_imfpga_input_lanes_t;
      FMCIN_CONFIG_DELAY_RESET      : in std_logic;
      FMCIN_CONFIG_FIFO_RESET   : in  std_logic;
      FMCIN_CONFIG_FIFO_FULL    : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_FIFO_ERROR   : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_XOFF         : out std_logic_vector(2*num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_FRAME_RESET  : in  std_logic;
      FMCIN_CONFIG_CLOCK_SYNC_RESET : in  std_logic;
      FMCIN_CONFIG_SYNC_DONE  : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_SYNC_ERROR : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_CLK_INV      : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_CLKDELAY_DIR : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_CLKDELAY_CE  : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);      
      FMCIN_CONFIG_PATCHECK     : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); -- sync to FMC_COMMON_CLK
      FMCIN_BUFFER_CONFIG_RESET : in  std_logic;
      FMCIN_BUFFER_CONFIG_FULL  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      FMCOUT_CONFIG_SPY_FREEZE_TO_IM : in std_logic;
      FMCIN_FRONT_DATA_SPYOUT : out data_type_for_fullwidth_data_from_imfpga_t; --@FMC_COMMON_CLK
      FMCIN_RX_DATA_SPYOUT : out DF_INPUT_DATA_ARRAY; --@FMC_COMMON_CLK
      FMCIN_RX_CTRL_SPYOUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
      FMCIN_RX_RDY_SPYOUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
      FMCIN_RX_DEN_SPYOUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
      
      -- <IDO>
      INPUT_LUT_RESET             : in std_logic;
      INPUT_SINGLE_SWITCH_RESET   : in std_logic;
      ENABLE_FMC_LANES_MASK       : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_FRAME_DOUT_LANEID : in  integer range 0 to NUMBER_OF_FMC_INPUT_LANES-1;
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_IDO : in  std_logic_vector(31 downto 0);
      IDO_INTERNAL_EVENT_COUNTER : out DF_INPUT_DATA_ARRAY;
      MODDATA_WEN_SWITCH_IN_MONITOR  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      MODDATA_RDY_SWITCH_IN_MONITOR  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      MODDATA_DATA_SWITCH_IN_MONITOR : out DF_INPUT_DATA_ARRAY;
      IDOOUT_FRAME_DATA_MONITOR : out std_logic_vector(31 downto 0);
      IDOOUT_FRAME_WEN_MONITOR  : out std_logic;
      IDOOUT_FRAME_CTRL_MONITOR : out std_logic;      
      IDOOUT_FRAME_XOFF_MONITOR : out std_logic;
      INPUT_LUT_MOD2IDX_ADDR_CONFIN   : in  DF_INPUT_MOD2IDX_ADDR_ARRAY;
      INPUT_LUT_MOD2IDX_DATA_CONFIN   : in  DF_INPUT_MOD2IDX_DATA_ARRAY;
      INPUT_LUT_MOD2IDX_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_MOD2IDX_DATA_CONFOUT  : out DF_INPUT_MOD2IDX_DATA_ARRAY;
      INPUT_LUT_IDX2MOD_ADDR_CONFIN   : in  DF_INPUT_IDX2MOD_ADDR_ARRAY;
      INPUT_LUT_IDX2MOD_DATA_CONFIN   : in  DF_INPUT_IDX2MOD_DATA_ARRAY;
      INPUT_LUT_IDX2MOD_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_IDX2MOD_DATA_CONFOUT  : out DF_INPUT_IDX2MOD_DATA_ARRAY;
      INPUT_LUT_PIXMOD2DST_ADDR_CONFIN   : in  DF_INPUT_PIXMOD2DST_ADDR_ARRAY;
      INPUT_LUT_PIXMOD2DST_DATA_CONFIN   : in  DF_INPUT_PIXMOD2DST_DATA_ARRAY;
      INPUT_LUT_PIXMOD2DST_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_PIXMOD2DST_DATA_CONFOUT  : out DF_INPUT_PIXMOD2DST_DATA_ARRAY;
      INPUT_LUT_SCTMOD2DST_ADDR_CONFIN   : in  DF_INPUT_SCTMOD2DST_ADDR_ARRAY;
      INPUT_LUT_SCTMOD2DST_DATA_CONFIN   : in  DF_INPUT_SCTMOD2DST_DATA_ARRAY;
      INPUT_LUT_SCTMOD2DST_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_SCTMOD2DST_DATA_CONFOUT  : out DF_INPUT_SCTMOD2DST_DATA_ARRAY;
      INPUT_LUT_STATE_MACHINE_ERROR_MONITOR : out DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY;
      INPUT_LUT_EXPECTED_NUM_OF_MODULE      : in  DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY;
      
      -- <ODO>
      ODO_PIXMOD2FTKPLANE_ADDR_CONFIN  : in  DF_PIXMOD2FTKPLANE_ADDR_ARRAY;
      ODO_PIXMOD2FTKPLANE_DATA_CONFIN  : in  DF_PIXMOD2FTKPLANE_DATA_ARRAY;
      ODO_PIXMOD2FTKPLANE_WEN_CONFIN   : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
      ODO_PIXMOD2FTKPLANE_DATA_CONFOUT : out DF_PIXMOD2FTKPLANE_DATA_ARRAY;
      ODO_PIXMOD2TOWER_ADDR_CONFIN     : in  DF_PIXMOD2TOWER_ADDR_ARRAY;
      ODO_PIXMOD2TOWER_DATA_CONFIN     : in  DF_PIXMOD2TOWER_DATA_ARRAY;
      ODO_PIXMOD2TOWER_WEN_CONFIN      : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
      ODO_PIXMOD2TOWER_DATA_CONFOUT    : out DF_PIXMOD2TOWER_DATA_ARRAY;
      ODO_PIXMOD2DUPLICATION_ADDR_CONFIN  : in DF_PIXMOD2DUPLICATION_ADDR_ARRAY;
      ODO_PIXMOD2DUPLICATION_DATA_CONFIN  : in DF_PIXMOD2DUPLICATION_DATA_ARRAY;
      ODO_PIXMOD2DUPLICATION_WEN_CONFIN   : in std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
      ODO_PIXMOD2DUPLICATION_DATA_CONFOUT : out DF_PIXMOD2DUPLICATION_DATA_ARRAY;
      ODO_SCTMOD2FTKPLANE_ADDR_CONFIN  : in  DF_SCTMOD2FTKPLANE_ADDR_ARRAY;
      ODO_SCTMOD2FTKPLANE_DATA_CONFIN  : in  DF_SCTMOD2FTKPLANE_DATA_ARRAY;
      ODO_SCTMOD2FTKPLANE_WEN_CONFIN   : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
      ODO_SCTMOD2FTKPLANE_DATA_CONFOUT : out DF_SCTMOD2FTKPLANE_DATA_ARRAY;
      ODO_SCTMOD2TOWER_ADDR_CONFIN     : in  DF_SCTMOD2TOWER_ADDR_ARRAY;
      ODO_SCTMOD2TOWER_DATA_CONFIN     : in  DF_SCTMOD2TOWER_DATA_ARRAY;
      ODO_SCTMOD2TOWER_WEN_CONFIN      : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
      ODO_SCTMOD2TOWER_DATA_CONFOUT    : out DF_SCTMOD2TOWER_DATA_ARRAY;
      ODO_SCTMOD2DUPLICATION_ADDR_CONFIN  : in  DF_SCTMOD2DUPLICATION_ADDR_ARRAY;
      ODO_SCTMOD2DUPLICATION_DATA_CONFIN  : in  DF_SCTMOD2DUPLICATION_DATA_ARRAY;
      ODO_SCTMOD2DUPLICATION_WEN_CONFIN   : in std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
      ODO_SCTMOD2DUPLICATION_DATA_CONFOUT : out DF_SCTMOD2DUPLICATION_DATA_ARRAY;
      
      ODO_FTKPLANE_STATE_MACHINE_ERROR_MONITOR     : out DF_ODO_IN_STATE_MACHINE_ERROR_MONITOR_ARRAY;
      ODO_SLINK_PACKER_STATE_MACHINE_ERROR_MONITOR : out DF_ERROR_MONITOR_GT_FOR_SLINK_OUTPUT_LANE_ARRAY;
      ODO_SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES  : in  DF_GT_FOR_SLINK_OUTPUT_LANES_INTEGER_ARRAY;
      ODO_OUTPUT_FORCE_READY         : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      ODO_FTKPLANE_WORD_ADDER_RESET  : in  std_logic;
      ODO_OUTPUT_SWITCH_MERGER_RESET : in  std_logic;
      ODO_OUTPUT_SWITCH_RESET        : in  std_logic;
      ODO_DUPLICATOR_RESET           : in  std_logic;
      ODO_SLINK_PACKER_RESET         : in  std_logic;
      ODO_OUTPUT_SWITCH_IN_RESET     : out std_logic;

      -- <For MONITORING PURPOSE ODO INPUT>
      ODOIN_DATA_MONITOR : out DF_ODO_IN_DATA_ARRAY;
      ODOIN_DEN_MONITOR  : out std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
      ODOIN_RDY_MONITOR  : out std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
      
      -- <For MONITORING PURPOSE ILO INPUT>
      ILOIN_DATA_MONITOR : out DF_ILO_IN_DATA_ARRAY;
      ILOIN_DEN_MONITOR  : out std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0);
      ILOIN_RDY_MONITOR  : out std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0);
      
      -- <For MONITORING at SWITCH IO>
      OUTPUT_SWITCH_IN_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_IN_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_IN_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      OUTPUT_SWITCH_OUT_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_OUT_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_OUT_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      EVENT_SORTER_IN_DATA_MONITOR : out DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
      EVENT_SORTER_IN_DEN_MONITOR  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      EVENT_SORTER_IN_RDY_MONITOR  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);

      OUTPUT_SWITCH_FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
      
      CENTRAL_SWITCH_OUT_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      CENTRAL_SWITCH_OUT_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      CENTRAL_SWITCH_OUT_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;

      INTERNALLINK_OUTPUT_SWITCH_OUT_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      INTERNALLINK_OUTPUT_SWITCH_IN_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      -- <Internal Link Input>
      INTERNALLINK_INPUT_BUFFER_RESET : in std_logic;
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_ILI : in  std_logic_vector(31 downto 0);
      
      -- <Internal Link Output>
      CENTRAL_SWITCH_RESET    : in  std_logic;
      CENTRAL_SWITCH_IN_RESET : out std_logic;
      INTERNALLINK_DESTINATION_WORD_ADDER_RESET   : in  std_logic;
      INTERNALLINK_DESTINATION_WORD_REMOVER_RESET : in  std_logic;
      INTERNALLINK_FORCE_READY : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_DESTINATION_WORDS : in DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY;
      
      INTERNALLINK_CENTRAL_SWITCH_FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
      INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX          
      );
  end component;
  
  component user_interface_df_top
    generic (
      USE_4K_SPY_BUFFER             : std_logic := USE_4K_SPY_BUFFER;
      SAMPLE_INTERNALLINK_INPUT     : std_logic := SAMPLE_INTERNALLINK_INPUT;
      SAMPLE_FMCIN_FRONT_DATA       : std_logic := SAMPLE_FMCIN_FRONT_DATA;
      SAMPLE_SPYOUT_AT_FMCCOMMONCLK : std_logic := SAMPLE_SPYOUT_AT_FMCCOMMONCLK);
    port (
      -- IPBUS
      REFCLK_P        : in std_logic;
      REFCLK_N        : in std_logic;
      GT_TXP          : out std_logic;
      GT_TXN          : out std_logic;
      GT_RXP          : in std_logic;
      GT_RXN          : in std_logic;
      
      MAIN_CLK  : in std_logic;
      CLK50           : in std_logic;
      CLK200          : in std_logic;
      FMC_COMMON_CLK : in std_logic;
      DELAY_REFCLK : in std_logic;

      -- I2C
      FB_SCL : inout std_logic; -- (OK)
      FB_SDA : inout std_logic; -- (OK)    
      
      FMCOUT_CONFIG_USER_TRIGGER     : out std_logic; -- (OK)
      FMCOUT_CONFIG_MEZZANINE_RESET  : out std_logic; -- (OK)    
      
      -- <Configuration>
      -- <FMCIN>
      FMCIN_CONFIG_CHANNELDELAY_DIR : out data_type_for_imfpga_input_lanes_t; --(OK)
      FMCIN_CONFIG_CHANNELDELAY_CE  : out data_type_for_imfpga_input_lanes_t; --(OK)
      FMCIN_CONFIG_DELAY_RESET      : out std_logic; --(OK)
      FMCIN_CONFIG_FIFO_RESET   : out  std_logic; --(OK)
      FMCIN_CONFIG_FIFO_FULL    : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0); --(OK)
      FMCIN_CONFIG_FIFO_ERROR   : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0); --(OK)
      FMCIN_CONFIG_XOFF         : in std_logic_vector(2*num_fpga_for_each_mainfpga-1 downto 0); --(OK)
      FMCIN_CONFIG_FRAME_RESET  : out  std_logic; --(OK)
      FMCIN_CONFIG_CLOCK_SYNC_RESET : out  std_logic; --(OK)
      FMCIN_CONFIG_SYNC_DONE  : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0); --(OK)
      FMCIN_CONFIG_SYNC_ERROR : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0); --(OK)
      FMCIN_CONFIG_CLK_INV      : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0); --(OK)
      FMCIN_CONFIG_CLKDELAY_DIR : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0); --(OK)
      FMCIN_CONFIG_CLKDELAY_CE  : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0); --(OK)
      FMCIN_CONFIG_PATCHECK     : in std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); -- sync to FMC_COMMON_CLK
      FMCIN_BUFFER_CONFIG_RESET : out  std_logic; --(OK)
      FMCIN_BUFFER_CONFIG_FULL  : in std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --(OK)
      FMCOUT_CONFIG_SPY_FREEZE_TO_IM : out std_logic; --(OK)
      FMCIN_FRONT_DATA_SPYOUT : in data_type_for_fullwidth_data_from_imfpga_t; --@FMC_COMMON_CLK--(NC!!)
      FMCIN_RX_DATA_SPYOUT : in DF_INPUT_DATA_ARRAY; --@FMC_COMMON_CLK--(OK)
      FMCIN_RX_CTRL_SPYOUT : in std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK--(OK)
      FMCIN_RX_RDY_SPYOUT  : in std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
      FMCIN_RX_DEN_SPYOUT  : in std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK--(OK)
      
      -- <IDO>
      INPUT_LUT_RESET             : out std_logic; --(OK)
      INPUT_SINGLE_SWITCH_RESET   : out std_logic; --(OK)
      ENABLE_FMC_LANES_MASK       : out  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --(OK)
      INPUT_LUT_FRAME_DOUT_LANEID : out  integer range 0 to NUMBER_OF_FMC_INPUT_LANES-1; --(OK)
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_IDO : out  std_logic_vector(31 downto 0); --(OK)
      IDO_INTERNAL_EVENT_COUNTER : in DF_INPUT_DATA_ARRAY;
      MODDATA_WEN_SWITCH_IN_MONITOR  : in std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      MODDATA_RDY_SWITCH_IN_MONITOR  : in std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      MODDATA_DATA_SWITCH_IN_MONITOR : in DF_INPUT_DATA_ARRAY;
      IDOOUT_FRAME_DATA_MONITOR : in std_logic_vector(31 downto 0);
      IDOOUT_FRAME_WEN_MONITOR  : in std_logic;
      IDOOUT_FRAME_CTRL_MONITOR : in std_logic;      
      IDOOUT_FRAME_XOFF_MONITOR : in std_logic;
      INPUT_LUT_MOD2IDX_ADDR_CONFIN   : out  DF_INPUT_MOD2IDX_ADDR_ARRAY; --(OK)
      INPUT_LUT_MOD2IDX_DATA_CONFIN   : out  DF_INPUT_MOD2IDX_DATA_ARRAY; --(OK)
      INPUT_LUT_MOD2IDX_WEN_CONFIN    : out  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --(OK)
      INPUT_LUT_MOD2IDX_DATA_CONFOUT  : in DF_INPUT_MOD2IDX_DATA_ARRAY; --(OK)
      INPUT_LUT_IDX2MOD_ADDR_CONFIN   : out  DF_INPUT_IDX2MOD_ADDR_ARRAY; --(OK)
      INPUT_LUT_IDX2MOD_DATA_CONFIN   : out  DF_INPUT_IDX2MOD_DATA_ARRAY; --(OK)
      INPUT_LUT_IDX2MOD_WEN_CONFIN    : out  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --(OK)
      INPUT_LUT_IDX2MOD_DATA_CONFOUT  : in DF_INPUT_IDX2MOD_DATA_ARRAY; --(OK)
      INPUT_LUT_PIXMOD2DST_ADDR_CONFIN   : out  DF_INPUT_PIXMOD2DST_ADDR_ARRAY; --(OK)
      INPUT_LUT_PIXMOD2DST_DATA_CONFIN   : out  DF_INPUT_PIXMOD2DST_DATA_ARRAY; --(OK)
      INPUT_LUT_PIXMOD2DST_WEN_CONFIN    : out  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --(OK)
      INPUT_LUT_PIXMOD2DST_DATA_CONFOUT  : in DF_INPUT_PIXMOD2DST_DATA_ARRAY; --(OK)
      INPUT_LUT_SCTMOD2DST_ADDR_CONFIN   : out  DF_INPUT_SCTMOD2DST_ADDR_ARRAY; --(OK)
      INPUT_LUT_SCTMOD2DST_DATA_CONFIN   : out  DF_INPUT_SCTMOD2DST_DATA_ARRAY; --(OK)
      INPUT_LUT_SCTMOD2DST_WEN_CONFIN    : out  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --(OK)
      INPUT_LUT_SCTMOD2DST_DATA_CONFOUT  : in DF_INPUT_SCTMOD2DST_DATA_ARRAY; --(OK)
      INPUT_LUT_STATE_MACHINE_ERROR_MONITOR : in DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY; --(NC)
      INPUT_LUT_EXPECTED_NUM_OF_MODULE      : out  DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY; --(OK)
      
      -- <ODO>
      ODO_PIXMOD2FTKPLANE_ADDR_CONFIN  : out  DF_PIXMOD2FTKPLANE_ADDR_ARRAY; --(OK)
      ODO_PIXMOD2FTKPLANE_DATA_CONFIN  : out  DF_PIXMOD2FTKPLANE_DATA_ARRAY; --(OK)
      ODO_PIXMOD2FTKPLANE_WEN_CONFIN   : out  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0); --(OK)
      ODO_PIXMOD2FTKPLANE_DATA_CONFOUT : in DF_PIXMOD2FTKPLANE_DATA_ARRAY; --(OK)
      ODO_PIXMOD2TOWER_ADDR_CONFIN     : out  DF_PIXMOD2TOWER_ADDR_ARRAY; --(OK)
      ODO_PIXMOD2TOWER_DATA_CONFIN     : out  DF_PIXMOD2TOWER_DATA_ARRAY; --(OK)
      ODO_PIXMOD2TOWER_WEN_CONFIN      : out  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0); --(OK)
      ODO_PIXMOD2TOWER_DATA_CONFOUT    : in DF_PIXMOD2TOWER_DATA_ARRAY; --(OK)
      ODO_PIXMOD2DUPLICATION_ADDR_CONFIN  : out DF_PIXMOD2DUPLICATION_ADDR_ARRAY;
      ODO_PIXMOD2DUPLICATION_DATA_CONFIN  : out DF_PIXMOD2DUPLICATION_DATA_ARRAY;
      ODO_PIXMOD2DUPLICATION_WEN_CONFIN   : out std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
      ODO_PIXMOD2DUPLICATION_DATA_CONFOUT : in  DF_PIXMOD2DUPLICATION_DATA_ARRAY;
      ODO_SCTMOD2FTKPLANE_ADDR_CONFIN  : out  DF_SCTMOD2FTKPLANE_ADDR_ARRAY; --(OK)
      ODO_SCTMOD2FTKPLANE_DATA_CONFIN  : out  DF_SCTMOD2FTKPLANE_DATA_ARRAY; --(OK)
      ODO_SCTMOD2FTKPLANE_WEN_CONFIN   : out  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0); --(OK)
      ODO_SCTMOD2FTKPLANE_DATA_CONFOUT : in DF_SCTMOD2FTKPLANE_DATA_ARRAY; --(OK)
      ODO_SCTMOD2TOWER_ADDR_CONFIN     : out  DF_SCTMOD2TOWER_ADDR_ARRAY; --(OK)
      ODO_SCTMOD2TOWER_DATA_CONFIN     : out  DF_SCTMOD2TOWER_DATA_ARRAY; --(OK)
      ODO_SCTMOD2TOWER_WEN_CONFIN      : out  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0); --(OK)
      ODO_SCTMOD2TOWER_DATA_CONFOUT    : in DF_SCTMOD2TOWER_DATA_ARRAY; --(OK)
      ODO_SCTMOD2DUPLICATION_ADDR_CONFIN  : out  DF_SCTMOD2DUPLICATION_ADDR_ARRAY;
      ODO_SCTMOD2DUPLICATION_DATA_CONFIN  : out  DF_SCTMOD2DUPLICATION_DATA_ARRAY;
      ODO_SCTMOD2DUPLICATION_WEN_CONFIN   : out  std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
      ODO_SCTMOD2DUPLICATION_DATA_CONFOUT : in   DF_SCTMOD2DUPLICATION_DATA_ARRAY;
      ODO_FTKPLANE_STATE_MACHINE_ERROR_MONITOR     : in DF_ODO_IN_STATE_MACHINE_ERROR_MONITOR_ARRAY; --(NC!!)
      ODO_SLINK_PACKER_STATE_MACHINE_ERROR_MONITOR : in DF_ERROR_MONITOR_GT_FOR_SLINK_OUTPUT_LANE_ARRAY; --(NC!!)
      ODO_SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES  : out  DF_GT_FOR_SLINK_OUTPUT_LANES_INTEGER_ARRAY; --(OK)
      ODO_OUTPUT_FORCE_READY         : out  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      ODO_FTKPLANE_WORD_ADDER_RESET  : out  std_logic; --(OK)
      ODO_OUTPUT_SWITCH_MERGER_RESET : out  std_logic; --(OK)
      ODO_OUTPUT_SWITCH_RESET        : out  std_logic; --(OK)
      ODO_DUPLICATOR_RESET           : out  std_logic;
      ODO_SLINK_PACKER_RESET         : out  std_logic; --(OK)
      ODO_OUTPUT_SWITCH_IN_RESET     : in std_logic; -- (NC!!)

      -- <For MONITORING PURPOSE ODO INPUT>
      ODOIN_DATA_MONITOR : in  DF_ODO_IN_DATA_ARRAY;
      ODOIN_DEN_MONITOR  : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
      ODOIN_RDY_MONITOR  : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
      
      -- <For MONITORING PURPOSE ILO INPUT>
      ILOIN_DATA_MONITOR : in  DF_ILO_IN_DATA_ARRAY;
      ILOIN_DEN_MONITOR  : in  std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0);
      ILOIN_RDY_MONITOR  : in  std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0);

      -- <For MONITORING PURPOSE ILO OUTPUT>
      ILOOUT_DATA_MONITOR   : in  DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
      ILOOUT_DEN_MONITOR    : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      ILOOUT_RDY_MONITOR    : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);

      -- <For MONITORING PURPOSE ILO OUTPUT>
      ILIOUT_DATA_MONITOR   : in  DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
      ILIOUT_DEN_MONITOR    : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      ILIOUT_BUSY_MONITOR   : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);      
      
      -- <For MONITORING at SWITCH IO>
      OUTPUT_SWITCH_IN_DATA_MONITOR : in DATA32_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_IN_DEN_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_IN_RDY_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      OUTPUT_SWITCH_OUT_DATA_MONITOR : in DATA32_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_OUT_DEN_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_OUT_RDY_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      EVENT_SORTER_IN_DATA_MONITOR : in DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
      EVENT_SORTER_IN_DEN_MONITOR  : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      EVENT_SORTER_IN_RDY_MONITOR  : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      
      OUTPUT_SWITCH_FIFO_MONITORING : in FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;      
      
      CENTRAL_SWITCH_OUT_DATA_MONITOR : in DATA32_32X32_SWITCH_MATRIX_PORTS;
      CENTRAL_SWITCH_OUT_DEN_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      CENTRAL_SWITCH_OUT_RDY_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;

      INTERNALLINK_OUTPUT_SWITCH_OUT_DATA_MONITOR : in DATA32_32X32_SWITCH_MATRIX_PORTS;
      INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      INTERNALLINK_OUTPUT_SWITCH_IN_DATA_MONITOR : in DATA32_32X32_SWITCH_MATRIX_PORTS;
      INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR  : in FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      -- <XCVR/SLINK>
      PLL_RESET           : out std_logic;
      TRANSCEIVER_RESET   : out std_logic; --(OK)
      LINK_RESET          : out std_logic; --(OK)
      SLINK_PATGEN_RESET  : out std_logic;
      SLINK_PATGEN_ENABLE : out std_logic;
      
      SLINK_LSC_UD            : in DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY; --(OK)
      SLINK_LSC_UCTRL_N       : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_UWEN_N        : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)      
      SLINK_LSC_URESET_N      : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_UTEST_N       : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_LFF_N         : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_LRL           : in DF_RETURN_LINE_SLINK_OUTPUT_ARRAY; --(OK)
      SLINK_LSC_LDOWN_N       : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(NC!!)
      SLINK_LSC_TESTLED_N     : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_LDERRLED_N    : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_LUPLED_N      : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_FLOWCTLLED_N  : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_ACTIVITYLED_N : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_GT_TX_RESET_DONE : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_GT_RX_RESET_DONE : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_GT_RXBYTEISALIGNED : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_GT_PLL_LOCK   : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_GT_RXPOLARITY : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_GT_TXPOLARITY : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
      SLINK_LSC_TOSENDARREAV  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)

      INTERNALLINK_TX_URL    : out DF_RETURN_LINE_INTERNALLINK_ARRAY;
      INTERNALLINK_RX_LRL    : in  DF_RETURN_LINE_INTERNALLINK_ARRAY;
      INTERNALLINK_BUFFER_CLR : out std_logic; -- new
      INTERNALLINK_RX_ENABLE  : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --new
      INTERNALLINK_TX_ENABLE  : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --new
      INTERNALLINK_RX_ENABLE_BERT : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --
      INTERNALLINK_TX_ENABLE_BERT : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_BERT_COUNTER_RESET : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_BERT_TOTAL_COUNT : in DF_DATA_GT_FOR_INTERNALLINK_ARRAY; --32bit_counter_out
      INTERNALLINK_RX_BERT_ERROR_COUNT : in DF_DATA_GT_FOR_INTERNALLINK_ARRAY; --32bit_counter_out
      INTERNALLINK_RX_BERT_COMPARISON_VALID : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      --INTERNALLINK_RX_LOCK   : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      --INTERNALLINK_RX_ERROR  : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_TX_RESET_DONE : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_RX_RESET_DONE : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_RXBYTEISALIGNED: in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_PLL_LOCK       : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_RXPOLARITY : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_TXPOLARITY : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      
      
      INTERNALLINK_INPUT_BUFFER_RESET : out std_logic;
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_ILI : out  std_logic_vector(31 downto 0); --(OK)
      
      -- <Internal Link Output>
      CENTRAL_SWITCH_RESET    : out std_logic;
      CENTRAL_SWITCH_IN_RESET : in  std_logic; -- NC!!
      INTERNALLINK_DESTINATION_WORD_ADDER_RESET   : out std_logic;
      INTERNALLINK_DESTINATION_WORD_REMOVER_RESET : out std_logic;
      INTERNALLINK_FORCE_READY : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_DESTINATION_WORDS : out DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY;
      
      INTERNALLINK_CENTRAL_SWITCH_FIFO_MONITORING : in FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
      INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING : in FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX       
      );
  end component;

  component pulsar2_sysclk_125
  --component pulsar2_sysclk_100
  --component pulsar2_sysclk
    port
      (CLK_IN1_P         : in     std_logic;
       CLK_IN1_N         : in     std_logic;
       MAIN_LOGIC_CLK    : out    std_logic;
       FMC_COMMON_CLK    : out    std_logic;
       CLK125            : out    std_logic;
       CLK50             : out    std_logic;
       RESET             : in     std_logic;
       LOCKED            : out    std_logic
       );
  end component;
  
  component df_transceiver
    generic (
      EXAMPLE_SIM_GTRESET_SPEEDUP : string := EXAMPLE_SIM_GTRESET_SPEEDUP;    -- Set to TRUE to speed up sim reset    
      SIMULATION       : integer := SIMULATION;
      ALTERA_XILINX    : integer :=    0; -- 1=Altera 0=Xilinx
      ACTIVITY_LENGTH  : integer :=   15; -- ACTLED duration
      FIFODEPTH        : integer :=  512; -- only powers of 2 (USE 512 !!)
      LOG2DEPTH        : integer :=    9; -- 2log of depth (USE 9 !!)
      FULLMARGIN_LSC   : integer :=   16  -- words left when LFF_N
      );
    port (
      --
      MAIN_CLK   : in std_logic;
      DRP_CLK_IN : in std_logic;

      PLL_RESET           : in std_logic;      
      TRANSCEIVER_RESET   : in std_logic;
      LINK_RESET          : in std_logic;
      SLINK_PATGEN_RESET  : in std_logic;
      SLINK_PATGEN_ENABLE : in std_logic;
      
      -- GT interface
      GTREFCLK_N_IN : in std_logic_vector(NUMBER_OF_GT_REFCLKS-1 downto 0);
      GTREFCLK_P_IN : in std_logic_vector(NUMBER_OF_GT_REFCLKS-1 downto 0);
      
      -- <LSC>
      SLINK_LSC_UD            : in DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
      SLINK_LSC_URESET_N      : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_UTEST_N       : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_UCTRL_N       : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_UWEN_N        : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_LFF_N         : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_LRL           : out DF_RETURN_LINE_SLINK_OUTPUT_ARRAY;
      SLINK_LSC_LDOWN_N       : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      
      SLINK_LSC_TESTLED_N     : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_LDERRLED_N    : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_LUPLED_N      : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_FLOWCTLLED_N  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_ACTIVITYLED_N : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);    
      
      SLINK_LSC_GT_TX_RESET_DONE_OUT : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_GT_RX_RESET_DONE_OUT : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_GT_RXBYTEISALIGNED_OUT : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_GT_PLL_LOCK_OUT        : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_GT_RXPOLARITY_IN : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_GT_TXPOLARITY_IN : in std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_RXN_IN  : in   std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_RXP_IN  : in   std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_TXN_OUT : out  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      SLINK_LSC_TXP_OUT : out  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      
      -- NOT USED <for the compatibility with 32bit version>
      SLINK_LSC_TOSENDARREAV  : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0) := (others => '0');
      
      -- <INTERNALLINK>
      INTERNALLINK_TX_URL    : in  DF_RETURN_LINE_INTERNALLINK_ARRAY;
      INTERNALLINK_RX_LRL    : out DF_RETURN_LINE_INTERNALLINK_ARRAY;
      INTERNALLINK_TX_DATA   : in  DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
      INTERNALLINK_TX_DVALID : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_TX_RDY    : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_DATA   : out DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
      INTERNALLINK_RX_DVALID : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_BUSY   : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_BUFFER_CLR : in std_logic; -- new
      INTERNALLINK_RX_ENABLE  : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --new
      INTERNALLINK_TX_ENABLE  : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --new
      INTERNALLINK_RX_ENABLE_BERT : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --
      INTERNALLINK_TX_ENABLE_BERT : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_BERT_COUNTER_RESET : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_BERT_TOTAL_COUNT : out DF_DATA_GT_FOR_INTERNALLINK_ARRAY; --32bit_counter_out
      INTERNALLINK_RX_BERT_ERROR_COUNT : out DF_DATA_GT_FOR_INTERNALLINK_ARRAY; --32bit_counter_out
      INTERNALLINK_RX_BERT_COMPARISON_VALID : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      --INTERNALLINK_RX_LOCK   : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      --INTERNALLINK_RX_ERROR  : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_TX_RESET_DONE_OUT : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_RX_RESET_DONE_OUT : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_RXBYTEISALIGNED_OUT: out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_PLL_LOCK_OUT       : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_RXPOLARITY_IN : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_GT_TXPOLARITY_IN : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RXN_IN  : in   std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RXP_IN  : in   std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_TXN_OUT : out  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_TXP_OUT : out  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0)
      );
  end component;
  
  signal clk50_i  : std_logic;
  signal clk125_i  : std_logic;
  signal clk200_i : std_logic;
  signal main_clk_i : std_logic;
  signal fmc_common_clk_i : std_logic;  
  
  -- <FMCIN>
  signal fmcin_config_channeldelay_dir_i : data_type_for_imfpga_input_lanes_t;
  signal fmcin_config_channeldelay_ce_i  : data_type_for_imfpga_input_lanes_t;
  signal fmcin_config_delay_reset_i      : std_logic;
  signal fmcin_config_fifo_reset_i   :  std_logic;
  signal fmcin_config_fifo_full_i    : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_config_fifo_error_i   : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_config_xoff_i         : std_logic_vector(2*num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_config_frame_reset_i  :  std_logic;
  signal fmcin_config_clock_sync_reset_i : std_logic;
  signal fmcin_config_sync_done_i  : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_config_sync_error_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_config_clk_inv_i      : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_config_clkdelay_dir_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_config_clkdelay_ce_i  : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_config_patcheck_i     : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); -- sync to FMC_COMMON_CLK  
  signal fmcin_buffer_config_reset_i : std_logic;
  signal fmcin_buffer_config_full_i  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal fmcin_front_data_spyout_i : data_type_for_fullwidth_data_from_imfpga_t; --@FMC_COMMON_CLK
  signal fmcin_rx_data_spyout_i : DF_INPUT_DATA_ARRAY; --@FMC_COMMON_CLK
  signal fmcin_rx_ctrl_spyout_i : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
  signal fmcin_rx_rdy_spyout_i  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK  
  signal fmcin_rx_den_spyout_i  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK  
  --
  signal fmcout_config_spy_freeze_to_im_i : std_logic;
  --
  signal fmc_config_l1a_trigger_i     : std_logic;
  signal fmc_config_mezzanine_reset_i : std_logic;
  signal fmc_config_fb1_soft_reset0_out : std_logic;
  signal fmc_config_fb1_soft_reset1_out : std_logic;
  signal fmc_config_fb2_soft_reset0_out : std_logic;
  signal fmc_config_fb2_soft_reset1_out : std_logic;
  signal fmc_config_fb3_soft_reset0_out : std_logic;
  signal fmc_config_fb3_soft_reset1_out : std_logic;
  signal fmc_config_fb4_soft_reset0_out : std_logic;
  signal fmc_config_fb4_soft_reset1_out : std_logic;      
  
  signal input_lut_reset_i             : std_logic;
  signal input_single_switch_reset_i   : std_logic;
  signal enable_fmc_lanes_mask_i       : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_frame_dout_laneid_i : integer range 0 to NUMBER_OF_FMC_INPUT_LANES-1 := 0;
  signal input_single_switch_this_board_mask_ido_i : std_logic_vector(31 downto 0);
  signal ido_internal_event_counter_i : DF_INPUT_DATA_ARRAY;
  
  signal moddata_wen_switch_in_monitor_i  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal moddata_rdy_switch_in_monitor_i  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal moddata_data_switch_in_monitor_i : DF_INPUT_DATA_ARRAY;

  signal ido_frame_data_out_i : std_logic_vector(31 downto 0) := (others => '0');
  signal ido_frame_wen_out_i  : std_logic := '0';
  signal ido_frame_ctrl_out_i : std_logic := '0';
  signal ido_frame_xoff_in_i  : std_logic := '0';
  
  signal input_lut_mod2idx_addr_confin_i   : DF_INPUT_MOD2IDX_ADDR_ARRAY := (others => (others => '0'));
  signal input_lut_mod2idx_data_confin_i   : DF_INPUT_MOD2IDX_DATA_ARRAY := (others => (others => '0'));
  signal input_lut_mod2idx_wen_confin_i    : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '0');
  signal input_lut_MOD2IDX_data_confout_i  : DF_INPUT_MOD2IDX_DATA_ARRAY;
  signal input_lut_idx2mod_addr_confin_i   : DF_INPUT_IDX2MOD_ADDR_ARRAY := (others => (others => '0'));
  signal input_lut_idx2mod_data_confin_i   : DF_INPUT_IDX2MOD_DATA_ARRAY := (others => (others => '0'));
  signal input_lut_idx2mod_wen_confin_i    : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '0');
  signal input_lut_idx2mod_data_confout_i  : DF_INPUT_IDX2MOD_DATA_ARRAY;
  signal input_lut_pixmod2dst_addr_confin_i   : DF_INPUT_PIXMOD2DST_ADDR_ARRAY := (others => (others => '0'));
  signal input_lut_pixmod2dst_data_confin_i   : DF_INPUT_PIXMOD2DST_DATA_ARRAY := (others => (others => '0'));
  signal input_lut_pixmod2dst_wen_confin_i    : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '0');
  signal input_lut_pixmod2dst_data_confout_i  : DF_INPUT_PIXMOD2DST_DATA_ARRAY;
  signal input_lut_sctmod2dst_addr_confin_i   : DF_INPUT_SCTMOD2DST_ADDR_ARRAY := (others => (others => '0'));
  signal input_lut_sctmod2dst_data_confin_i   : DF_INPUT_SCTMOD2DST_DATA_ARRAY := (others => (others => '0'));
  signal input_lut_sctmod2dst_wen_confin_i    : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '0');
  signal input_lut_sctmod2dst_data_confout_i  : DF_INPUT_SCTMOD2DST_DATA_ARRAY;
  signal input_lut_state_machine_error_monitor_i : DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY;
  signal input_lut_expected_num_of_module_i      : DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY;
  -- upto here for IDO
  
  signal output_pixmod2ftkplane_addr_confin_i  : DF_PIXMOD2FTKPLANE_ADDR_ARRAY := (others => (others => '0'));
  signal output_pixmod2ftkplane_data_confin_i  : DF_PIXMOD2FTKPLANE_DATA_ARRAY := (others => (others => '0'));
  signal output_pixmod2ftkplane_wen_confin_i   : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0):= (others => '0');
  signal output_pixmod2ftkplane_data_confout_i : DF_PIXMOD2FTKPLANE_DATA_ARRAY;
  signal output_pixmod2tower_addr_confin_i     : DF_PIXMOD2TOWER_ADDR_ARRAY := (others => (others => '0'));
  signal output_pixmod2tower_data_confin_i     : DF_PIXMOD2TOWER_DATA_ARRAY := (others => (others => '0'));
  signal output_pixmod2tower_wen_confin_i      : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0) := (others => '0');
  signal output_pixmod2tower_data_confout_i    : DF_PIXMOD2TOWER_DATA_ARRAY;
  signal output_pixmod2duplication_addr_confin_i  : DF_PIXMOD2DUPLICATION_ADDR_ARRAY;
  signal output_pixmod2duplication_data_confini   : DF_PIXMOD2DUPLICATION_DATA_ARRAY;
  signal output_pixmod2duplication_wen_confin_i   : std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
  signal output_pixmod2duplication_data_confout_i : DF_PIXMOD2DUPLICATION_DATA_ARRAY;
  
  signal output_sctmod2ftkplane_addr_confin_i  : DF_SCTMOD2FTKPLANE_ADDR_ARRAY := (others => (others => '0'));
  signal output_sctmod2ftkplane_data_confin_i  : DF_SCTMOD2FTKPLANE_DATA_ARRAY := (others => (others => '0'));
  signal output_sctmod2ftkplane_wen_confin_i   : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0):= (others => '0');
  signal output_sctmod2ftkplane_data_confout_i : DF_SCTMOD2FTKPLANE_DATA_ARRAY;
  signal output_sctmod2tower_addr_confin_i     : DF_SCTMOD2TOWER_ADDR_ARRAY := (others => (others => '0'));
  signal output_sctmod2tower_data_confin_i     : DF_SCTMOD2TOWER_DATA_ARRAY := (others => (others => '0'));
  signal output_sctmod2tower_wen_confin_i      : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0):= (others => '0');
  signal output_sctmod2duplication_addr_confin_i  : DF_SCTMOD2DUPLICATION_ADDR_ARRAY;
  signal output_sctmod2duplication_data_confini   : DF_SCTMOD2DUPLICATION_DATA_ARRAY;
  signal output_sctmod2duplication_wen_confin_i   : std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
  signal output_sctmod2duplication_data_confout_i : DF_SCTMOD2DUPLICATION_DATA_ARRAY;
  signal output_sctmod2tower_data_confout_i    : DF_SCTMOD2TOWER_DATA_ARRAY;    
  signal output_ftkplane_state_machine_error_monitor_i     : DF_ODO_IN_STATE_MACHINE_ERROR_MONITOR_ARRAY;
  signal output_slink_packer_state_machine_error_monitor_i : DF_ERROR_MONITOR_GT_FOR_SLINK_OUTPUT_LANE_ARRAY;
  signal output_slink_packer_number_of_expected_modules_i  : DF_GT_FOR_SLINK_OUTPUT_LANES_INTEGER_ARRAY;
  signal output_ftkplane_word_adder_reset_i  : std_logic;
  signal output_switch_merger_reset_i : std_logic;
  signal output_switch_reset_i        : std_logic;
  signal output_duplicator_reset_i    : std_logic;
  signal output_slink_packer_reset_i  : std_logic;
  signal output_switch_in_reset_i     : std_logic;
  
  signal output_force_ready_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0) := (others => '0');
  signal internallink_input_buffer_reset_i : std_logic;
  signal input_single_switch_this_board_mask_ili_i : std_logic_vector(31 downto 0);
  
  signal lsc_ud_i      : DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
  signal lsc_uctrl_n_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_uwen_n_i  : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  
  signal lsc_lff_n_i    : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0) := (others => '1');
  signal lsc_ldown_n_i  : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0) := (others => '1');
  signal lsc_lrl_i      : DF_RETURN_LINE_SLINK_OUTPUT_ARRAY;
  signal lsc_ureset_n_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0):=(others => '1');
  signal lsc_utest_n_i  : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0):=(others => '1');
  signal lsc_testled_n_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_lderrled_n_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_lupled_n_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_flowctlled_n_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_activityled_n_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);

  signal pll_reset_i           : std_logic;  
  signal transceiver_reset_i   : std_logic;
  signal link_reset_i          : std_logic;
  signal slink_patgen_reset_i  : std_logic;
  signal slink_patgen_enable_i : std_logic;
  
  signal lsc_gt_tx_reset_done_out_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_gt_rx_reset_done_out_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_gt_rxbyteisaligned_out_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_gt_pll_lock_out_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal lsc_gt_rxpolarity_in_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0) := (others => '0');
  signal lsc_gt_txpolarity_in_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0) := (others => '0');
  signal lsc_tosendarreav_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0) := (others => '0');
  
  signal internallink_tx_data_i   : DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
  signal internallink_tx_dvalid_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_tx_rdy_i    : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_rx_data_i   : DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
  signal internallink_rx_dvalid_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_rx_busy_i   : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  
  signal internallink_buffer_clr_i : std_logic; -- new
  signal internallink_rx_enable_i  : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --new
  signal internallink_tx_enable_i  : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --new
  signal internallink_rx_enable_bert_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --
  signal internallink_tx_enable_bert_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_rx_bert_counter_reset_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_rx_bert_total_count_i : DF_DATA_GT_FOR_INTERNALLINK_ARRAY; --32bit_counter_out
  signal internallink_rx_bert_error_count_i : DF_DATA_GT_FOR_INTERNALLINK_ARRAY; --32bit_counter_out
  signal internallink_rx_bert_comparison_valid_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);  
  --signal internallink_rx_lock_i   : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  --signal internallink_rx_error_i  : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_gt_tx_reset_done_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_gt_rx_reset_done_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_gt_rxbyteisaligned_i: std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_gt_pll_lock_i       : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_gt_rxpolarity_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_gt_txpolarity_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_tx_url_i    : DF_RETURN_LINE_INTERNALLINK_ARRAY;
  signal internallink_rx_lrl_i    : DF_RETURN_LINE_INTERNALLINK_ARRAY;
  
  -- <Internal Link Output>
  signal central_switch_reset_i    : std_logic;
  signal central_switch_in_reset_i : std_logic;
  signal internallink_destination_word_adder_reset_i   : std_logic;
  signal internallink_destination_word_remover_reset_i : std_logic;
  signal internallink_force_ready_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_destination_words_i : DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY;
  
  signal internallink_central_switch_fifo_monitoring_i : FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
  signal internallink_output_switch_fifo_monitoring_i  : FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;

  -- <ODO MONITOR>
  signal odo_in_data_monitor_i : DF_ODO_IN_DATA_ARRAY;
  signal odo_in_den_monitor_i  : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_in_rdy_monitor_i  : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  
  -- <ILO MONITOR>
  signal ilo_in_data_monitor_i : DF_ILO_IN_DATA_ARRAY;
  signal ilo_in_den_monitor_i  : std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0);
  signal ilo_in_rdy_monitor_i  : std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0);

  -- <For MONITORING at SWITCH IO>
  signal output_switch_input_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS;
  signal output_switch_input_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal output_switch_input_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  
  signal output_switch_output_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS;
  signal output_switch_output_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal output_switch_output_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  
  signal event_sorter_input_data_i : DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
  signal event_sorter_input_den_i  : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal event_sorter_input_rdy_i  : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);

  signal output_switch_fifo_monitoring_i : FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;      
  
  signal central_switch_output_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS;
  signal central_switch_output_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal central_switch_output_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;

  signal internallink_output_switch_input_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS;
  signal internallink_output_switch_input_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal internallink_output_switch_input_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  
  signal internallink_output_switch_output_data_i : DATA32_32X32_SWITCH_MATRIX_PORTS;
  signal internallink_output_switch_output_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal internallink_output_switch_output_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  
begin
  
  -- Red LED not yet implemented
  -- all turn off is as expected
  LED0 <= fmcin_config_fifo_reset_i; -- FIFO INPUT DISABLE
  LED1 <= fmcin_config_clock_sync_reset_i;
  LED2 <= (fmcin_config_frame_reset_i or fmcin_buffer_config_reset_i);
  LED3 <= fmcout_config_spy_freeze_to_im_i;
  
  clk200_i<=fmc_common_clk_i;
  CLKBUFFER : pulsar2_sysclk_125
  --CLKBUFFER : pulsar2_sysclk_100
  --CLKBUFFER : pulsar2_sysclk
    port map (
      CLK_IN1_P=>SYSCLK_P, CLK_IN1_N=>SYSCLK_N,
      FMC_COMMON_CLK=>fmc_common_clk_i, CLK125=>clk125_i, CLK50=>clk50_i, MAIN_LOGIC_CLK=>main_clk_i,
      RESET=>'0', LOCKED=>open);  
  
  -- ============================================================================================
  fmc_config_fb1_soft_reset0_out <= fmc_config_mezzanine_reset_i xor swap_mask_fmc1_soft_reset0;
  FB1_SOFT_RESET0_TX : OBUFDS
    generic map (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map (I=>fmc_config_fb1_soft_reset0_out, O=>FB1_SOFT_RESET0_P, OB=>FB1_SOFT_RESET0_N); 
  
  fmc_config_fb2_soft_reset0_out <= fmc_config_mezzanine_reset_i xor swap_mask_fmc2_soft_reset0;
  FB2_SOFT_RESET0_TX : OBUFDS
    generic map (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map (I=>fmc_config_fb2_soft_reset0_out, O=>FB2_SOFT_RESET0_P, OB=>FB2_SOFT_RESET0_N);
  
  fmc_config_fb3_soft_reset0_out <= fmc_config_mezzanine_reset_i xor swap_mask_fmc3_soft_reset0;
  FB3_SOFT_RESET0_TX : OBUFDS
    generic map (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map (I=>fmc_config_fb3_soft_reset0_out, O=>FB3_SOFT_RESET0_P, OB=>FB3_SOFT_RESET0_N);

  fmc_config_fb4_soft_reset0_out <= fmc_config_mezzanine_reset_i xor swap_mask_fmc4_soft_reset0;
  FB4_SOFT_RESET0_TX : OBUFDS
    generic map (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map (I=>fmc_config_fb4_soft_reset0_out, O=>FB4_SOFT_RESET0_P, OB=>FB4_SOFT_RESET0_N);    
  -- ============================================================================================
  
  FTK_IM_INST : if USE_FTKIM='1' generate
  begin
    fmc_config_fb1_soft_reset1_out <= fmc_config_mezzanine_reset_i xor swap_mask_fmc1_soft_reset1;
    fmc_config_fb2_soft_reset1_out <= fmc_config_mezzanine_reset_i xor swap_mask_fmc2_soft_reset1;
    fmc_config_fb3_soft_reset1_out <= fmc_config_mezzanine_reset_i xor swap_mask_fmc3_soft_reset1;
    fmc_config_fb4_soft_reset1_out <= fmc_config_mezzanine_reset_i xor swap_mask_fmc4_soft_reset1;    
  end generate;
  
  FNAL_TEST_MEZZANINE_INST : if USE_FTKIM='0' generate
  begin
    fmc_config_fb1_soft_reset1_out <= fmc_config_l1a_trigger_i xor swap_mask_fmc1_soft_reset1;
    fmc_config_fb2_soft_reset1_out <= fmc_config_l1a_trigger_i xor swap_mask_fmc2_soft_reset1;
    fmc_config_fb3_soft_reset1_out <= fmc_config_l1a_trigger_i xor swap_mask_fmc3_soft_reset1;
    fmc_config_fb4_soft_reset1_out <= fmc_config_l1a_trigger_i xor swap_mask_fmc4_soft_reset1;
  end generate;
  
  -- ============================================================================================
  
  FB1_SOFT_RESET1_TX : OBUFDS
    generic map (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map (I=>fmc_config_fb1_soft_reset1_out, O=>FB1_SOFT_RESET1_P, OB=>FB1_SOFT_RESET1_N);
  
  FB2_SOFT_RESET1_TX : OBUFDS
    generic map (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map (I=>fmc_config_fb2_soft_reset1_out, O=>FB2_SOFT_RESET1_P, OB=>FB2_SOFT_RESET1_N);
    
  FB3_SOFT_RESET1_TX : OBUFDS
    generic map (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map (I=>fmc_config_fb3_soft_reset1_out, O=>FB3_SOFT_RESET1_P, OB=>FB3_SOFT_RESET1_N);

  FB4_SOFT_RESET1_TX : OBUFDS
    generic map (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map (I=>fmc_config_fb4_soft_reset1_out, O=>FB4_SOFT_RESET1_P, OB=>FB4_SOFT_RESET1_N);
  -- ============================================================================================
  
  MY_DF_MAIN : df_main
    port map (
      MAIN_CLK=>main_clk_i, FMC_COMMON_CLK=>fmc_common_clk_i,
      
      FB1_RX_LVDS_P=>FB1_RX_LVDS_P, FB1_RX_LVDS_N=>FB1_RX_LVDS_N,
      FB1_CLK0_P=>FB1_CLK0_P, FB1_CLK0_N=>FB1_CLK0_N, FB1_CLK1_P=>FB1_CLK1_P, FB1_CLK1_N=>FB1_CLK1_N,
      FB1_TX_LVDS_P=>FB1_TX_LVDS_P, FB1_TX_LVDS_N=>FB1_TX_LVDS_N,
      FB1_TX_FWD_CLK_P=>FB1_TX_FWD_CLK_P, FB1_TX_FWD_CLK_N=>FB1_TX_FWD_CLK_N,
      
      FB2_RX_LVDS_P=>FB2_RX_LVDS_P, FB2_RX_LVDS_N=>FB2_RX_LVDS_N,
      FB2_CLK0_P=>FB2_CLK0_P, FB2_CLK0_N=>FB2_CLK0_N, FB2_CLK1_P=>FB2_CLK1_P, FB2_CLK1_N=>FB2_CLK1_N,
      FB2_TX_LVDS_P=>FB2_TX_LVDS_P, FB2_TX_LVDS_N=>FB2_TX_LVDS_N,
      FB2_TX_FWD_CLK_P=>FB2_TX_FWD_CLK_P, FB2_TX_FWD_CLK_N=>FB2_TX_FWD_CLK_N,
      
      FB3_RX_LVDS_P=>FB3_RX_LVDS_P, FB3_RX_LVDS_N=>FB3_RX_LVDS_N,
      FB3_CLK0_P=>FB3_CLK0_P, FB3_CLK0_N=>FB3_CLK0_N, FB3_CLK1_P=>FB3_CLK1_P, FB3_CLK1_N=>FB3_CLK1_N,
      FB3_TX_LVDS_P=>FB3_TX_LVDS_P, FB3_TX_LVDS_N=>FB3_TX_LVDS_N,
      FB3_TX_FWD_CLK_P=>FB3_TX_FWD_CLK_P, FB3_TX_FWD_CLK_N=>FB3_TX_FWD_CLK_N,
      
      FB4_RX_LVDS_P=>FB4_RX_LVDS_P, FB4_RX_LVDS_N=>FB4_RX_LVDS_N,
      FB4_CLK0_P=>FB4_CLK0_P, FB4_CLK0_N=>FB4_CLK0_N, FB4_CLK1_P=>FB4_CLK1_P, FB4_CLK1_N=>FB4_CLK1_N,
      FB4_TX_LVDS_P=>FB4_TX_LVDS_P, FB4_TX_LVDS_N=>FB4_TX_LVDS_N,
      FB4_TX_FWD_CLK_P=>FB4_TX_FWD_CLK_P, FB4_TX_FWD_CLK_N=>FB4_TX_FWD_CLK_N,      
      
      -- <SLINK IO>
      SLINK_LSC_UD=>lsc_ud_i,
      SLINK_LSC_UCTRL_N=>lsc_uctrl_n_i,
      SLINK_LSC_UWEN_N=>lsc_uwen_n_i,
      SLINK_LSC_LFF_N=>lsc_lff_n_i,
      SLINK_LSC_LDOWN_N=>lsc_ldown_n_i,
      
      -- <INTERNAL LINK IO>
      INTERNALLINK_TX_DATA=>internallink_tx_data_i,
      INTERNALLINK_TX_DVALID=>internallink_tx_dvalid_i,
      INTERNALLINK_TX_RDY=>internallink_tx_rdy_i,
      INTERNALLINK_RX_DATA=>internallink_rx_data_i,
      INTERNALLINK_RX_DVALID=>internallink_rx_dvalid_i,
      INTERNALLINK_RX_BUSY=>internallink_rx_busy_i,
      
      -- <Configuration>
      -- <FMCIN>
      FMCIN_CONFIG_CHANNELDELAY_DIR=>fmcin_config_channeldelay_dir_i,
      FMCIN_CONFIG_CHANNELDELAY_CE=>fmcin_config_channeldelay_ce_i,
      FMCIN_CONFIG_DELAY_RESET=>fmcin_config_delay_reset_i,
      FMCIN_CONFIG_FIFO_RESET=>fmcin_config_fifo_reset_i,
      FMCIN_CONFIG_FIFO_FULL=>fmcin_config_fifo_full_i,
      FMCIN_CONFIG_FIFO_ERROR=>fmcin_config_fifo_error_i,
      FMCIN_CONFIG_XOFF=>fmcin_config_xoff_i,
      FMCIN_CONFIG_FRAME_RESET=>fmcin_config_frame_reset_i,
      FMCIN_CONFIG_CLOCK_SYNC_RESET=>fmcin_config_clock_sync_reset_i,
      FMCIN_CONFIG_SYNC_DONE=>fmcin_config_sync_done_i,
      FMCIN_CONFIG_SYNC_ERROR=>fmcin_config_sync_error_i,
      FMCIN_CONFIG_CLK_INV=>fmcin_config_clk_inv_i,
      FMCIN_CONFIG_CLKDELAY_DIR=>fmcin_config_clkdelay_dir_i,
      FMCIN_CONFIG_CLKDELAY_CE=>fmcin_config_clkdelay_ce_i,
      FMCIN_CONFIG_PATCHECK=>fmcin_config_patcheck_i, -- sync to FMC_COMMON_CLK      
      FMCIN_BUFFER_CONFIG_RESET=>fmcin_buffer_config_reset_i,
      FMCIN_BUFFER_CONFIG_FULL=>fmcin_buffer_config_full_i,
      FMCOUT_CONFIG_SPY_FREEZE_TO_IM=>fmcout_config_spy_freeze_to_im_i,
      FMCIN_FRONT_DATA_SPYOUT => fmcin_front_data_spyout_i,
      FMCIN_RX_DATA_SPYOUT => fmcin_rx_data_spyout_i,
      FMCIN_RX_CTRL_SPYOUT => fmcin_rx_ctrl_spyout_i,
      FMCIN_RX_RDY_SPYOUT  => fmcin_rx_rdy_spyout_i,
      FMCIN_RX_DEN_SPYOUT  => fmcin_rx_den_spyout_i,
      
      -- <IDO>
      INPUT_LUT_RESET=>input_lut_reset_i,
      INPUT_SINGLE_SWITCH_RESET=>input_single_switch_reset_i,
      ENABLE_FMC_LANES_MASK=>enable_fmc_lanes_mask_i,
      INPUT_LUT_FRAME_DOUT_LANEID=>input_lut_frame_dout_laneid_i,
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_IDO=>input_single_switch_this_board_mask_ido_i,
      IDO_INTERNAL_EVENT_COUNTER=>ido_internal_event_counter_i,
      MODDATA_WEN_SWITCH_IN_MONITOR=>moddata_wen_switch_in_monitor_i,
      MODDATA_RDY_SWITCH_IN_MONITOR=>moddata_rdy_switch_in_monitor_i,
      MODDATA_DATA_SWITCH_IN_MONITOR=>moddata_data_switch_in_monitor_i,
      IDOOUT_FRAME_DATA_MONITOR=>ido_frame_data_out_i,
      IDOOUT_FRAME_WEN_MONITOR=>ido_frame_wen_out_i,
      IDOOUT_FRAME_CTRL_MONITOR=>ido_frame_ctrl_out_i,
      IDOOUT_FRAME_XOFF_MONITOR=>ido_frame_xoff_in_i,
      INPUT_LUT_MOD2IDX_ADDR_CONFIN=>input_lut_mod2idx_addr_confin_i,
      INPUT_LUT_MOD2IDX_DATA_CONFIN=>input_lut_mod2idx_data_confin_i,
      INPUT_LUT_MOD2IDX_WEN_CONFIN=>input_lut_mod2idx_wen_confin_i,
      INPUT_LUT_MOD2IDX_DATA_CONFOUT=>input_lut_mod2idx_data_confout_i,
      INPUT_LUT_IDX2MOD_ADDR_CONFIN=>input_lut_idx2mod_addr_confin_i,
      INPUT_LUT_IDX2MOD_DATA_CONFIN=>input_lut_idx2mod_data_confin_i,
      INPUT_LUT_IDX2MOD_WEN_CONFIN=>input_lut_idx2mod_wen_confin_i,
      INPUT_LUT_IDX2MOD_DATA_CONFOUT=>input_lut_idx2mod_data_confout_i,
      INPUT_LUT_PIXMOD2DST_ADDR_CONFIN=>input_lut_pixmod2dst_addr_confin_i,
      INPUT_LUT_PIXMOD2DST_DATA_CONFIN=>input_lut_pixmod2dst_data_confin_i,
      INPUT_LUT_PIXMOD2DST_WEN_CONFIN=>input_lut_pixmod2dst_wen_confin_i,
      INPUT_LUT_PIXMOD2DST_DATA_CONFOUT=>input_lut_pixmod2dst_data_confout_i,
      INPUT_LUT_SCTMOD2DST_ADDR_CONFIN=>input_lut_sctmod2dst_addr_confin_i,
      INPUT_LUT_SCTMOD2DST_DATA_CONFIN=>input_lut_sctmod2dst_data_confin_i,
      INPUT_LUT_SCTMOD2DST_WEN_CONFIN=>input_lut_sctmod2dst_wen_confin_i,
      INPUT_LUT_SCTMOD2DST_DATA_CONFOUT=>input_lut_sctmod2dst_data_confout_i,
      INPUT_LUT_STATE_MACHINE_ERROR_MONITOR=>input_lut_state_machine_error_monitor_i,
      INPUT_LUT_EXPECTED_NUM_OF_MODULE=>input_lut_expected_num_of_module_i,
      
      -- <ODO>
      ODO_PIXMOD2FTKPLANE_ADDR_CONFIN=>output_pixmod2ftkplane_addr_confin_i,
      ODO_PIXMOD2FTKPLANE_DATA_CONFIN=>output_pixmod2ftkplane_data_confin_i,
      ODO_PIXMOD2FTKPLANE_WEN_CONFIN=>output_pixmod2ftkplane_wen_confin_i,
      ODO_PIXMOD2FTKPLANE_DATA_CONFOUT=>output_pixmod2ftkplane_data_confout_i,
      ODO_PIXMOD2TOWER_ADDR_CONFIN=>output_pixmod2tower_addr_confin_i,
      ODO_PIXMOD2TOWER_DATA_CONFIN=>output_pixmod2tower_data_confin_i,
      ODO_PIXMOD2TOWER_WEN_CONFIN=>output_pixmod2tower_wen_confin_i,
      ODO_PIXMOD2TOWER_DATA_CONFOUT=>output_pixmod2tower_data_confout_i,
      ODO_PIXMOD2DUPLICATION_ADDR_CONFIN=>output_pixmod2duplication_addr_confin_i,
      ODO_PIXMOD2DUPLICATION_DATA_CONFIN=>output_pixmod2duplication_data_confini,
      ODO_PIXMOD2DUPLICATION_WEN_CONFIN=>output_pixmod2duplication_wen_confin_i,
      ODO_PIXMOD2DUPLICATION_DATA_CONFOUT=>output_pixmod2duplication_data_confout_i,
      ODO_SCTMOD2FTKPLANE_ADDR_CONFIN=>output_sctmod2ftkplane_addr_confin_i,
      ODO_SCTMOD2FTKPLANE_DATA_CONFIN=>output_sctmod2ftkplane_data_confin_i,
      ODO_SCTMOD2FTKPLANE_WEN_CONFIN=>output_sctmod2ftkplane_wen_confin_i,
      ODO_SCTMOD2FTKPLANE_DATA_CONFOUT=>output_sctmod2ftkplane_data_confout_i,
      ODO_SCTMOD2TOWER_ADDR_CONFIN=>output_sctmod2tower_addr_confin_i,
      ODO_SCTMOD2TOWER_DATA_CONFIN=>output_sctmod2tower_data_confin_i,
      ODO_SCTMOD2TOWER_WEN_CONFIN=>output_sctmod2tower_wen_confin_i,
      ODO_SCTMOD2TOWER_DATA_CONFOUT=>output_sctmod2tower_data_confout_i,
      ODO_SCTMOD2DUPLICATION_ADDR_CONFIN=>output_sctmod2duplication_addr_confin_i,
      ODO_SCTMOD2DUPLICATION_DATA_CONFIN=>output_sctmod2duplication_data_confini,
      ODO_SCTMOD2DUPLICATION_WEN_CONFIN=>output_sctmod2duplication_wen_confin_i,
      ODO_SCTMOD2DUPLICATION_DATA_CONFOUT=>output_sctmod2duplication_data_confout_i,
      ODO_FTKPLANE_STATE_MACHINE_ERROR_MONITOR=>output_ftkplane_state_machine_error_monitor_i,
      ODO_SLINK_PACKER_STATE_MACHINE_ERROR_MONITOR=>output_slink_packer_state_machine_error_monitor_i,
      ODO_SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES=>output_slink_packer_number_of_expected_modules_i,
      ODO_FTKPLANE_WORD_ADDER_RESET=>output_ftkplane_word_adder_reset_i,      
      ODO_OUTPUT_FORCE_READY=>output_force_ready_i,
      ODO_OUTPUT_SWITCH_MERGER_RESET=>output_switch_merger_reset_i,
      ODO_OUTPUT_SWITCH_RESET=>output_switch_reset_i,
      ODO_DUPLICATOR_RESET=>output_duplicator_reset_i,
      ODO_SLINK_PACKER_RESET=>output_slink_packer_reset_i,
      ODO_OUTPUT_SWITCH_IN_RESET=>output_switch_in_reset_i,
      
      -- <For MONITORING PURPOSE ODO INPUT>
      ODOIN_DATA_MONITOR => odo_in_data_monitor_i,
      ODOIN_DEN_MONITOR  => odo_in_den_monitor_i,
      ODOIN_RDY_MONITOR  => odo_in_rdy_monitor_i,
      
      -- <For MONITORING PURPOSE ILO INPUT>
      ILOIN_DATA_MONITOR => ilo_in_data_monitor_i,
      ILOIN_DEN_MONITOR  => ilo_in_den_monitor_i,
      ILOIN_RDY_MONITOR  => ilo_in_rdy_monitor_i,
      
      -- <For MONITORING at SWITCH IO>
      OUTPUT_SWITCH_IN_DATA_MONITOR => output_switch_input_data_i,
      OUTPUT_SWITCH_IN_DEN_MONITOR  => output_switch_input_den_i,
      OUTPUT_SWITCH_IN_RDY_MONITOR  => output_switch_input_rdy_i,
      
      OUTPUT_SWITCH_OUT_DATA_MONITOR => output_switch_output_data_i,
      OUTPUT_SWITCH_OUT_DEN_MONITOR  => output_switch_output_den_i,
      OUTPUT_SWITCH_OUT_RDY_MONITOR  => output_switch_output_rdy_i,

      EVENT_SORTER_IN_DATA_MONITOR => event_sorter_input_data_i,
      EVENT_SORTER_IN_DEN_MONITOR  => event_sorter_input_den_i,
      EVENT_SORTER_IN_RDY_MONITOR  => event_sorter_input_rdy_i,

      OUTPUT_SWITCH_FIFO_MONITORING => output_switch_fifo_monitoring_i,
      
      CENTRAL_SWITCH_OUT_DATA_MONITOR => central_switch_output_data_i,
      CENTRAL_SWITCH_OUT_DEN_MONITOR  => central_switch_output_den_i,
      CENTRAL_SWITCH_OUT_RDY_MONITOR  => central_switch_output_rdy_i,
      
      INTERNALLINK_OUTPUT_SWITCH_IN_DATA_MONITOR => internallink_output_switch_input_data_i,
      INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR  => internallink_output_switch_input_den_i,
      INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR  => internallink_output_switch_input_rdy_i,
      
      INTERNALLINK_OUTPUT_SWITCH_OUT_DATA_MONITOR => internallink_output_switch_output_data_i,
      INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR  => internallink_output_switch_output_den_i,
      INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR  => internallink_output_switch_output_rdy_i,
      
      -- <Internal Link Input>
      INTERNALLINK_INPUT_BUFFER_RESET=>internallink_input_buffer_reset_i,
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_ILI=>input_single_switch_this_board_mask_ili_i,

      CENTRAL_SWITCH_RESET=>central_switch_reset_i,
      CENTRAL_SWITCH_IN_RESET=>central_switch_in_reset_i,
      INTERNALLINK_DESTINATION_WORD_ADDER_RESET=>internallink_destination_word_adder_reset_i,
      INTERNALLINK_DESTINATION_WORD_REMOVER_RESET=>internallink_destination_word_remover_reset_i,
      INTERNALLINK_FORCE_READY=>internallink_force_ready_i,
      INTERNALLINK_DESTINATION_WORDS=>internallink_destination_words_i,
      
      INTERNALLINK_CENTRAL_SWITCH_FIFO_MONITORING=>internallink_central_switch_fifo_monitoring_i,
      INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING=>internallink_output_switch_fifo_monitoring_i      
      );
  
  MY_USER_INTERFACE : user_interface_df_top
    port map (
      REFCLK_P=>ETH_GTREFCLK_P_IN,
      REFCLK_N=>ETH_GTREFCLK_N_IN,
      GT_TXP=>ETH_GT_TXP,
      GT_TXN=>ETH_GT_TXN,
      GT_RXP=>ETH_GT_RXP,
      GT_RXN=>ETH_GT_RXN,
      
      --MAIN_CLK=>main_clk_i,
      MAIN_CLK=>clk125_i,
      CLK50=>clk50_i,
      CLK200=>clk200_i,
      FMC_COMMON_CLK=>fmc_common_clk_i,
      DELAY_REFCLK=>fmc_common_clk_i,
      
      FB_SCL=>FB_SCL, FB_SDA=>FB_SDA,
      
      FMCOUT_CONFIG_USER_TRIGGER=>fmc_config_l1a_trigger_i,
      FMCOUT_CONFIG_MEZZANINE_RESET=>fmc_config_mezzanine_reset_i, 
      
      -- <Configuration>
      -- <FMCIN>
      FMCIN_CONFIG_CHANNELDELAY_DIR=>fmcin_config_channeldelay_dir_i,
      FMCIN_CONFIG_CHANNELDELAY_CE=>fmcin_config_channeldelay_ce_i,
      FMCIN_CONFIG_DELAY_RESET=>fmcin_config_delay_reset_i,
      FMCIN_CONFIG_FIFO_RESET=>fmcin_config_fifo_reset_i,
      FMCIN_CONFIG_FIFO_FULL=>fmcin_config_fifo_full_i,
      FMCIN_CONFIG_FIFO_ERROR=>fmcin_config_fifo_error_i,
      FMCIN_CONFIG_XOFF=>fmcin_config_xoff_i,
      FMCIN_CONFIG_FRAME_RESET=>fmcin_config_frame_reset_i,
      FMCIN_CONFIG_CLOCK_SYNC_RESET=>fmcin_config_clock_sync_reset_i,
      FMCIN_CONFIG_SYNC_DONE=>fmcin_config_sync_done_i,
      FMCIN_CONFIG_SYNC_ERROR=>fmcin_config_sync_error_i,
      FMCIN_CONFIG_CLK_INV=>fmcin_config_clk_inv_i,
      FMCIN_CONFIG_CLKDELAY_DIR=>fmcin_config_clkdelay_dir_i,
      FMCIN_CONFIG_CLKDELAY_CE=>fmcin_config_clkdelay_ce_i,
      FMCIN_CONFIG_PATCHECK=>fmcin_config_patcheck_i, -- sync to FMC_COMMON_CLK      
      FMCIN_BUFFER_CONFIG_RESET=>fmcin_buffer_config_reset_i,
      FMCIN_BUFFER_CONFIG_FULL=>fmcin_buffer_config_full_i,
      FMCOUT_CONFIG_SPY_FREEZE_TO_IM=>fmcout_config_spy_freeze_to_im_i,
      FMCIN_FRONT_DATA_SPYOUT => fmcin_front_data_spyout_i,
      FMCIN_RX_DATA_SPYOUT => fmcin_rx_data_spyout_i,
      FMCIN_RX_CTRL_SPYOUT => fmcin_rx_ctrl_spyout_i,
      FMCIN_RX_RDY_SPYOUT  => fmcin_rx_rdy_spyout_i,
      FMCIN_RX_DEN_SPYOUT  => fmcin_rx_den_spyout_i,
      
      -- <IDO>
      INPUT_LUT_RESET=>input_lut_reset_i,
      INPUT_SINGLE_SWITCH_RESET=>input_single_switch_reset_i,
      ENABLE_FMC_LANES_MASK=>enable_fmc_lanes_mask_i,
      INPUT_LUT_FRAME_DOUT_LANEID=>input_lut_frame_dout_laneid_i,
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_IDO=>input_single_switch_this_board_mask_ido_i,
      IDO_INTERNAL_EVENT_COUNTER=>ido_internal_event_counter_i,
      MODDATA_WEN_SWITCH_IN_MONITOR=>moddata_wen_switch_in_monitor_i,
      MODDATA_RDY_SWITCH_IN_MONITOR=>moddata_rdy_switch_in_monitor_i,
      MODDATA_DATA_SWITCH_IN_MONITOR=>moddata_data_switch_in_monitor_i,
      IDOOUT_FRAME_DATA_MONITOR=>ido_frame_data_out_i,
      IDOOUT_FRAME_WEN_MONITOR=>ido_frame_wen_out_i,
      IDOOUT_FRAME_CTRL_MONITOR=>ido_frame_ctrl_out_i,
      IDOOUT_FRAME_XOFF_MONITOR=>ido_frame_xoff_in_i,
      INPUT_LUT_MOD2IDX_ADDR_CONFIN=>input_lut_mod2idx_addr_confin_i,
      INPUT_LUT_MOD2IDX_DATA_CONFIN=>input_lut_mod2idx_data_confin_i,
      INPUT_LUT_MOD2IDX_WEN_CONFIN=>input_lut_mod2idx_wen_confin_i,
      INPUT_LUT_MOD2IDX_DATA_CONFOUT=>input_lut_mod2idx_data_confout_i,
      INPUT_LUT_IDX2MOD_ADDR_CONFIN=>input_lut_idx2mod_addr_confin_i,
      INPUT_LUT_IDX2MOD_DATA_CONFIN=>input_lut_idx2mod_data_confin_i,
      INPUT_LUT_IDX2MOD_WEN_CONFIN=>input_lut_idx2mod_wen_confin_i,
      INPUT_LUT_IDX2MOD_DATA_CONFOUT=>input_lut_idx2mod_data_confout_i,
      INPUT_LUT_PIXMOD2DST_ADDR_CONFIN=>input_lut_pixmod2dst_addr_confin_i,
      INPUT_LUT_PIXMOD2DST_DATA_CONFIN=>input_lut_pixmod2dst_data_confin_i,
      INPUT_LUT_PIXMOD2DST_WEN_CONFIN=>input_lut_pixmod2dst_wen_confin_i,
      INPUT_LUT_PIXMOD2DST_DATA_CONFOUT=>input_lut_pixmod2dst_data_confout_i,
      INPUT_LUT_SCTMOD2DST_ADDR_CONFIN=>input_lut_sctmod2dst_addr_confin_i,
      INPUT_LUT_SCTMOD2DST_DATA_CONFIN=>input_lut_sctmod2dst_data_confin_i,
      INPUT_LUT_SCTMOD2DST_WEN_CONFIN=>input_lut_sctmod2dst_wen_confin_i,
      INPUT_LUT_SCTMOD2DST_DATA_CONFOUT=>input_lut_sctmod2dst_data_confout_i,
      INPUT_LUT_STATE_MACHINE_ERROR_MONITOR=>input_lut_state_machine_error_monitor_i,
      INPUT_LUT_EXPECTED_NUM_OF_MODULE=>input_lut_expected_num_of_module_i,
      
      -- <ODO>
      ODO_PIXMOD2FTKPLANE_ADDR_CONFIN=>output_pixmod2ftkplane_addr_confin_i,
      ODO_PIXMOD2FTKPLANE_DATA_CONFIN=>output_pixmod2ftkplane_data_confin_i,
      ODO_PIXMOD2FTKPLANE_WEN_CONFIN=>output_pixmod2ftkplane_wen_confin_i,
      ODO_PIXMOD2FTKPLANE_DATA_CONFOUT=>output_pixmod2ftkplane_data_confout_i,
      ODO_PIXMOD2TOWER_ADDR_CONFIN=>output_pixmod2tower_addr_confin_i,
      ODO_PIXMOD2TOWER_DATA_CONFIN=>output_pixmod2tower_data_confin_i,
      ODO_PIXMOD2TOWER_WEN_CONFIN=>output_pixmod2tower_wen_confin_i,
      ODO_PIXMOD2TOWER_DATA_CONFOUT=>output_pixmod2tower_data_confout_i,
      ODO_PIXMOD2DUPLICATION_ADDR_CONFIN=>output_pixmod2duplication_addr_confin_i,
      ODO_PIXMOD2DUPLICATION_DATA_CONFIN=>output_pixmod2duplication_data_confini,
      ODO_PIXMOD2DUPLICATION_WEN_CONFIN=>output_pixmod2duplication_wen_confin_i,
      ODO_PIXMOD2DUPLICATION_DATA_CONFOUT=>output_pixmod2duplication_data_confout_i,      
      ODO_SCTMOD2FTKPLANE_ADDR_CONFIN=>output_sctmod2ftkplane_addr_confin_i,
      ODO_SCTMOD2FTKPLANE_DATA_CONFIN=>output_sctmod2ftkplane_data_confin_i,
      ODO_SCTMOD2FTKPLANE_WEN_CONFIN=>output_sctmod2ftkplane_wen_confin_i,
      ODO_SCTMOD2FTKPLANE_DATA_CONFOUT=>output_sctmod2ftkplane_data_confout_i,
      ODO_SCTMOD2TOWER_ADDR_CONFIN=>output_sctmod2tower_addr_confin_i,
      ODO_SCTMOD2TOWER_DATA_CONFIN=>output_sctmod2tower_data_confin_i,
      ODO_SCTMOD2TOWER_WEN_CONFIN=>output_sctmod2tower_wen_confin_i,
      ODO_SCTMOD2TOWER_DATA_CONFOUT=>output_sctmod2tower_data_confout_i,
      ODO_SCTMOD2DUPLICATION_ADDR_CONFIN=>output_sctmod2duplication_addr_confin_i,
      ODO_SCTMOD2DUPLICATION_DATA_CONFIN=>output_sctmod2duplication_data_confini,
      ODO_SCTMOD2DUPLICATION_WEN_CONFIN=>output_sctmod2duplication_wen_confin_i,
      ODO_SCTMOD2DUPLICATION_DATA_CONFOUT=>output_sctmod2duplication_data_confout_i,
      ODO_FTKPLANE_STATE_MACHINE_ERROR_MONITOR=>output_ftkplane_state_machine_error_monitor_i,
      ODO_SLINK_PACKER_STATE_MACHINE_ERROR_MONITOR=>output_slink_packer_state_machine_error_monitor_i,
      ODO_SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES=>output_slink_packer_number_of_expected_modules_i,
      ODO_FTKPLANE_WORD_ADDER_RESET=>output_ftkplane_word_adder_reset_i,      
      ODO_OUTPUT_FORCE_READY=>output_force_ready_i,
      ODO_OUTPUT_SWITCH_MERGER_RESET=>output_switch_merger_reset_i,
      ODO_OUTPUT_SWITCH_RESET=>output_switch_reset_i,
      ODO_DUPLICATOR_RESET=>output_duplicator_reset_i,
      ODO_SLINK_PACKER_RESET=>output_slink_packer_reset_i,
      ODO_OUTPUT_SWITCH_IN_RESET=>output_switch_in_reset_i,

      -- <XCVR/SLINK>
      PLL_RESET=>pll_reset_i,   
      TRANSCEIVER_RESET=>transceiver_reset_i,
      LINK_RESET=>link_reset_i,
      SLINK_PATGEN_RESET=>slink_patgen_reset_i,
      SLINK_PATGEN_ENABLE=>slink_patgen_enable_i,      
      
      SLINK_LSC_UD=>lsc_ud_i,
      SLINK_LSC_UCTRL_N=>lsc_uctrl_n_i,
      SLINK_LSC_UWEN_N=>lsc_uwen_n_i,
      SLINK_LSC_URESET_N=>lsc_ureset_n_i,
      SLINK_LSC_UTEST_N=>lsc_utest_n_i,
      SLINK_LSC_LFF_N=>lsc_lff_n_i,
      SLINK_LSC_LRL=>lsc_lrl_i,
      SLINK_LSC_LDOWN_N=>lsc_ldown_n_i,
      SLINK_LSC_TESTLED_N=>lsc_testled_n_i,
      SLINK_LSC_LDERRLED_N=>lsc_lderrled_n_i,
      SLINK_LSC_LUPLED_N=>lsc_lupled_n_i,
      SLINK_LSC_FLOWCTLLED_N=>lsc_flowctlled_n_i,
      SLINK_LSC_ACTIVITYLED_N=>lsc_activityled_n_i,
      SLINK_LSC_GT_TX_RESET_DONE=>lsc_gt_tx_reset_done_out_i,
      SLINK_LSC_GT_RX_RESET_DONE=>lsc_gt_rx_reset_done_out_i,
      SLINK_LSC_GT_RXBYTEISALIGNED=>lsc_gt_rxbyteisaligned_out_i,
      SLINK_LSC_GT_PLL_LOCK=>lsc_gt_pll_lock_out_i,
      SLINK_LSC_GT_RXPOLARITY=>lsc_gt_rxpolarity_in_i,
      SLINK_LSC_GT_TXPOLARITY=>lsc_gt_txpolarity_in_i,
      SLINK_LSC_TOSENDARREAV=>lsc_tosendarreav_i,

      INTERNALLINK_TX_URL=>internallink_tx_url_i,
      INTERNALLINK_RX_LRL=>internallink_rx_lrl_i,
      --
      INTERNALLINK_BUFFER_CLR=>internallink_buffer_clr_i,
      INTERNALLINK_RX_ENABLE=>internallink_rx_enable_i,
      INTERNALLINK_TX_ENABLE=>internallink_tx_enable_i,
      INTERNALLINK_RX_ENABLE_BERT=>internallink_rx_enable_bert_i,
      INTERNALLINK_TX_ENABLE_BERT=>internallink_tx_enable_bert_i,
      INTERNALLINK_RX_BERT_COUNTER_RESET=>internallink_rx_bert_counter_reset_i,
      INTERNALLINK_RX_BERT_TOTAL_COUNT=>internallink_rx_bert_total_count_i,
      INTERNALLINK_RX_BERT_ERROR_COUNT=>internallink_rx_bert_error_count_i,
      INTERNALLINK_RX_BERT_COMPARISON_VALID=>internallink_rx_bert_comparison_valid_i,      
      --INTERNALLINK_RX_LOCK=>internallink_rx_lock_i,
      --INTERNALLINK_RX_ERROR=>internallink_rx_error_i,
      INTERNALLINK_GT_TX_RESET_DONE=>internallink_gt_tx_reset_done_i,
      INTERNALLINK_GT_RX_RESET_DONE=>internallink_gt_rx_reset_done_i,
      INTERNALLINK_GT_RXBYTEISALIGNED=>internallink_gt_rxbyteisaligned_i,
      INTERNALLINK_GT_PLL_LOCK=>internallink_gt_pll_lock_i,
      INTERNALLINK_GT_RXPOLARITY=>internallink_gt_rxpolarity_i,
      INTERNALLINK_GT_TXPOLARITY=>internallink_gt_txpolarity_i,
      
      -- <For MONITORING PURPOSE ODO INPUT>
      ODOIN_DATA_MONITOR => odo_in_data_monitor_i,
      ODOIN_DEN_MONITOR  => odo_in_den_monitor_i,
      ODOIN_RDY_MONITOR  => odo_in_rdy_monitor_i,
      
      -- <For MONITORING PURPOSE ILO INPUT>
      ILOIN_DATA_MONITOR => ilo_in_data_monitor_i,
      ILOIN_DEN_MONITOR  => ilo_in_den_monitor_i,
      ILOIN_RDY_MONITOR  => ilo_in_rdy_monitor_i,
      
      -- <For MONITORING PURPOSE ILO OUTPUT>
      ILOOUT_DATA_MONITOR=>internallink_tx_data_i,
      ILOOUT_DEN_MONITOR=>internallink_tx_dvalid_i,
      ILOOUT_RDY_MONITOR=>internallink_tx_rdy_i,
      
      -- <For MONITORING PURPOSE ILI OUTPUT>
      ILIOUT_DATA_MONITOR =>internallink_rx_data_i,
      ILIOUT_DEN_MONITOR  =>internallink_rx_dvalid_i,
      ILIOUT_BUSY_MONITOR =>internallink_rx_busy_i,      
      
      -- <For MONITORING at SWITCH IO>
      OUTPUT_SWITCH_IN_DATA_MONITOR => output_switch_input_data_i,
      OUTPUT_SWITCH_IN_DEN_MONITOR  => output_switch_input_den_i,
      OUTPUT_SWITCH_IN_RDY_MONITOR  => output_switch_input_rdy_i,
      
      OUTPUT_SWITCH_OUT_DATA_MONITOR => output_switch_output_data_i,
      OUTPUT_SWITCH_OUT_DEN_MONITOR  => output_switch_output_den_i,
      OUTPUT_SWITCH_OUT_RDY_MONITOR  => output_switch_output_rdy_i,
      
      EVENT_SORTER_IN_DATA_MONITOR => event_sorter_input_data_i,
      EVENT_SORTER_IN_DEN_MONITOR  => event_sorter_input_den_i,
      EVENT_SORTER_IN_RDY_MONITOR  => event_sorter_input_rdy_i,

      OUTPUT_SWITCH_FIFO_MONITORING => output_switch_fifo_monitoring_i,
      
      CENTRAL_SWITCH_OUT_DATA_MONITOR => central_switch_output_data_i,
      CENTRAL_SWITCH_OUT_DEN_MONITOR  => central_switch_output_den_i,
      CENTRAL_SWITCH_OUT_RDY_MONITOR  => central_switch_output_rdy_i,

      INTERNALLINK_OUTPUT_SWITCH_IN_DATA_MONITOR => internallink_output_switch_input_data_i,
      INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR  => internallink_output_switch_input_den_i,
      INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR  => internallink_output_switch_input_rdy_i,
      
      INTERNALLINK_OUTPUT_SWITCH_OUT_DATA_MONITOR => internallink_output_switch_output_data_i,
      INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR  => internallink_output_switch_output_den_i,
      INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR  => internallink_output_switch_output_rdy_i,      
      
      -- <internal link>
      INTERNALLINK_INPUT_BUFFER_RESET=>internallink_input_buffer_reset_i,
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_ILI=>input_single_switch_this_board_mask_ili_i,
      
      CENTRAL_SWITCH_RESET=>central_switch_reset_i,
      CENTRAL_SWITCH_IN_RESET=>central_switch_in_reset_i,
      INTERNALLINK_DESTINATION_WORD_ADDER_RESET=>internallink_destination_word_adder_reset_i,
      INTERNALLINK_DESTINATION_WORD_REMOVER_RESET=>internallink_destination_word_remover_reset_i,
      INTERNALLINK_FORCE_READY=>internallink_force_ready_i,
      INTERNALLINK_DESTINATION_WORDS=>internallink_destination_words_i,
      
      INTERNALLINK_CENTRAL_SWITCH_FIFO_MONITORING=>internallink_central_switch_fifo_monitoring_i,
      INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING=>internallink_output_switch_fifo_monitoring_i
      );
  
  my_df_transceiver : df_transceiver
    port map (
      --
      MAIN_CLK=>main_clk_i,
      DRP_CLK_IN=>clk50_i,
      
      PLL_RESET=>pll_reset_i,
      TRANSCEIVER_RESET=>transceiver_reset_i,
      LINK_RESET=>link_reset_i,
      SLINK_PATGEN_RESET=>slink_patgen_reset_i,
      SLINK_PATGEN_ENABLE=>slink_patgen_enable_i,
      
      -- GT interface
      GTREFCLK_N_IN=>GTREFCLK_N_IN,
      GTREFCLK_P_IN=>GTREFCLK_P_IN, 
      
      -- <XCVR/SLINK>
      SLINK_LSC_UD=>lsc_ud_i, SLINK_LSC_UCTRL_N=>lsc_uctrl_n_i, SLINK_LSC_UWEN_N=>lsc_uwen_n_i,
      SLINK_LSC_URESET_N=>lsc_ureset_n_i, SLINK_LSC_UTEST_N=>lsc_utest_n_i, 
      SLINK_LSC_LFF_N=>lsc_lff_n_i, SLINK_LSC_LRL=>lsc_lrl_i, SLINK_LSC_LDOWN_N=>lsc_ldown_n_i,
      SLINK_LSC_TESTLED_N=>lsc_testled_n_i, SLINK_LSC_LDERRLED_N=>lsc_lderrled_n_i, SLINK_LSC_LUPLED_N=>lsc_lupled_n_i, 
      SLINK_LSC_FLOWCTLLED_N=>lsc_flowctlled_n_i, SLINK_LSC_ACTIVITYLED_N=>lsc_activityled_n_i,
      SLINK_LSC_GT_TX_RESET_DONE_OUT=>lsc_gt_tx_reset_done_out_i, 
      SLINK_LSC_GT_RX_RESET_DONE_OUT=>lsc_gt_rx_reset_done_out_i,
      SLINK_LSC_GT_RXBYTEISALIGNED_OUT=>lsc_gt_rxbyteisaligned_out_i,
      SLINK_LSC_GT_PLL_LOCK_OUT=>lsc_gt_pll_lock_out_i,
      SLINK_LSC_GT_RXPOLARITY_IN=>lsc_gt_rxpolarity_in_i,
      SLINK_LSC_GT_TXPOLARITY_IN=>lsc_gt_txpolarity_in_i,
      SLINK_LSC_TOSENDARREAV=>lsc_tosendarreav_i,
      
      SLINK_LSC_RXN_IN=>SLINK_LSC_RXN_IN, SLINK_LSC_RXP_IN=>SLINK_LSC_RXP_IN,
      SLINK_LSC_TXN_OUT=>SLINK_LSC_TXN_OUT, SLINK_LSC_TXP_OUT=>SLINK_LSC_TXP_OUT,
      
      INTERNALLINK_TX_URL=>internallink_tx_url_i,
      INTERNALLINK_RX_LRL=>internallink_rx_lrl_i,
      INTERNALLINK_TX_DATA=>internallink_tx_data_i,
      INTERNALLINK_TX_DVALID=>internallink_tx_dvalid_i,
      INTERNALLINK_TX_RDY=>internallink_tx_rdy_i,
      INTERNALLINK_RX_DATA=>internallink_rx_data_i,
      INTERNALLINK_RX_DVALID=>internallink_rx_dvalid_i,
      INTERNALLINK_RX_BUSY=>internallink_rx_busy_i,
      INTERNALLINK_BUFFER_CLR=>internallink_buffer_clr_i,
      INTERNALLINK_RX_ENABLE=>internallink_rx_enable_i,
      INTERNALLINK_TX_ENABLE=>internallink_tx_enable_i,
      INTERNALLINK_RX_ENABLE_BERT=>internallink_rx_enable_bert_i,
      INTERNALLINK_TX_ENABLE_BERT=>internallink_tx_enable_bert_i,
      INTERNALLINK_RX_BERT_COUNTER_RESET=>internallink_rx_bert_counter_reset_i,
      INTERNALLINK_RX_BERT_TOTAL_COUNT=>internallink_rx_bert_total_count_i,
      INTERNALLINK_RX_BERT_ERROR_COUNT=>internallink_rx_bert_error_count_i,
      INTERNALLINK_RX_BERT_COMPARISON_VALID=>internallink_rx_bert_comparison_valid_i,
      --INTERNALLINK_RX_LOCK=>internallink_rx_lock_i,
      --INTERNALLINK_RX_ERROR=>internallink_rx_error_i,

      INTERNALLINK_GT_TX_RESET_DONE_OUT=>internallink_gt_tx_reset_done_i,
      INTERNALLINK_GT_RX_RESET_DONE_OUT=>internallink_gt_rx_reset_done_i,
      INTERNALLINK_GT_RXBYTEISALIGNED_OUT=>internallink_gt_rxbyteisaligned_i,
      INTERNALLINK_GT_PLL_LOCK_OUT=>internallink_gt_pll_lock_i,
      INTERNALLINK_GT_RXPOLARITY_IN=>internallink_gt_rxpolarity_i,
      INTERNALLINK_GT_TXPOLARITY_IN=>internallink_gt_txpolarity_i,
      INTERNALLINK_RXN_IN=>INTERNALLINK_RXN_IN, INTERNALLINK_RXP_IN=>INTERNALLINK_RXP_IN,
      INTERNALLINK_TXN_OUT=>INTERNALLINK_TXN_OUT, INTERNALLINK_TXP_OUT=>INTERNALLINK_TXP_OUT
      );
  
end logic;
