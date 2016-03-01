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

entity df_main is
  generic (
    NO_INTERNAL_LINK_MODE : integer := 0; -- TO BE CONFIGURED PROPERLY WRT TESTING PURPOSE
    NO_OUTPUT_DATA_OPERATOR_MODE : integer := 0; -- TO BE CONFIGURED PROPERLY WRT TESTING PURPOSE    
    NO_SWITCH_MODE        : integer := 0; -- TO BE CONFIGURED PROPERLY WRT TESTING PURPOSE
    NO_EVENT_SORTING_MODE : integer := 0; -- TO BE CONFIGURED PROPERLY WRT TESTING PURPOSE
    USE_SHORT_FRAME_FIFO_FOR_DEBUGGING : std_logic := '1';
    --With this option '1', one event stuck at slink_packer_v2 (most probably waiting
    --module data for long) will be immediately propagate from output data operator to input data operator.
    --i.e. next event will not come on the board 
    --(maybe useful even for real operation)
    USE_INPUT_EVENT_ALIGNMENT_LOGIC : std_logic := '1';
    common_clk_frequency  : real :=200.00;
    SAMPLE_SPYOUT_AT_FMCCOMMONCLK : std_logic := '0');
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
    FMCIN_CONFIG_FIFO_FULL_COUNT   : out DF_INPUT_DATA_ARRAY;    
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
    FMCIN_BUSY_THRESHOLD      : in  std_logic_vector(31 downto 0);
    FMCIN_FIFO_WR_DATA : out DF_FMC_WR_DATA_ARRAY;
    FMCOUT_CONFIG_SPY_FREEZE_TO_IM : in std_logic;
    FMCIN_FRONT_DATA_SPYOUT : out data_type_for_fullwidth_data_from_imfpga_t; --@FMC_COMMON_CLK
    FMCIN_RX_DATA_SPYOUT : out DF_INPUT_DATA_ARRAY; --@FMC_COMMON_CLK
    FMCIN_RX_CTRL_SPYOUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
    FMCIN_RX_RDY_SPYOUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
    FMCIN_RX_DEN_SPYOUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
    
    SELECTED_FMC_FPGA    : in std_logic_vector(4 downto 0);
    
    -- <IDO>
    INPUT_LUT_RESET             : in std_logic;
    INPUT_SINGLE_SWITCH_RESET   : in std_logic;
    ENABLE_FMC_LANES_MASK       : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    INPUT_LUT_FRAME_DOUT_LANEID : in  integer range 0 to NUMBER_OF_FMC_INPUT_LANES-1;
    INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_IDO : in  std_logic_vector(31 downto 0);
    IDO_INTERNAL_EVENT_COUNTER : out DF_INPUT_DATA_ARRAY;
    IDO_INTERNAL_STATUS_MONITOR: out DF_INPUT_DATA_ARRAY;
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
    --INPUT_LUT_STATE_MACHINE_ERROR_MONITOR : out DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY;
    INPUT_LUT_EXPECTED_NUM_OF_MODULE      : in  DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY;

    --IDO_STATE_MACHINE_STATE_MONITOR_SCT0 : out std_logic_vector(31 downto 0);
    --IDO_STATE_MACHINE_STATE_MONITOR_SCT1 : out std_logic_vector(31 downto 0);      
    --IDO_STATE_MACHINE_STATE_MONITOR_PIX0 : out std_logic_vector(31 downto 0);
    --IDO_STATE_MACHINE_STATE_MONITOR_PIX1 : out std_logic_vector(31 downto 0);      
    --IDO_STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0);

    
    -- <ODO>
    ODO_PIXMOD2FTKPLANE_ADDR_CONFIN  : in  DF_PIXMOD2FTKPLANE_ADDR_ARRAY;
    ODO_PIXMOD2FTKPLANE_DATA_CONFIN  : in  DF_PIXMOD2FTKPLANE_DATA_ARRAY;
    ODO_PIXMOD2FTKPLANE_WEN_CONFIN   : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    ODO_PIXMOD2FTKPLANE_DATA_CONFOUT : out DF_PIXMOD2FTKPLANE_DATA_ARRAY;
    ODO_PIXMOD2TOWER_ADDR_CONFIN     : in  DF_PIXMOD2TOWER_ADDR_ARRAY;
    ODO_PIXMOD2TOWER_DATA_CONFIN     : in  DF_PIXMOD2TOWER_DATA_ARRAY;
    ODO_PIXMOD2TOWER_WEN_CONFIN      : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    ODO_PIXMOD2TOWER_DATA_CONFOUT    : out DF_PIXMOD2TOWER_DATA_ARRAY;
    ODO_PIXMOD2DUPLICATION_ADDR_CONFIN: in DF_PIXMOD2DUPLICATION_ADDR_ARRAY;
    ODO_PIXMOD2DUPLICATION_DATA_CONFIN: in DF_PIXMOD2DUPLICATION_DATA_ARRAY;
    ODO_PIXMOD2DUPLICATION_WEN_CONFIN: in std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
    ODO_PIXMOD2DUPLICATION_DATA_CONFOUT    : out DF_PIXMOD2DUPLICATION_DATA_ARRAY;
    ODO_SCTMOD2FTKPLANE_ADDR_CONFIN  : in  DF_SCTMOD2FTKPLANE_ADDR_ARRAY;
    ODO_SCTMOD2FTKPLANE_DATA_CONFIN  : in  DF_SCTMOD2FTKPLANE_DATA_ARRAY;
    ODO_SCTMOD2FTKPLANE_WEN_CONFIN   : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    ODO_SCTMOD2FTKPLANE_DATA_CONFOUT : out DF_SCTMOD2FTKPLANE_DATA_ARRAY;
    ODO_SCTMOD2TOWER_ADDR_CONFIN     : in  DF_SCTMOD2TOWER_ADDR_ARRAY;
    ODO_SCTMOD2TOWER_DATA_CONFIN     : in  DF_SCTMOD2TOWER_DATA_ARRAY;
    ODO_SCTMOD2TOWER_WEN_CONFIN      : in  std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
    ODO_SCTMOD2TOWER_DATA_CONFOUT    : out DF_SCTMOD2TOWER_DATA_ARRAY;
    ODO_SCTMOD2DUPLICATION_ADDR_CONFIN: in  DF_SCTMOD2DUPLICATION_ADDR_ARRAY;
    ODO_SCTMOD2DUPLICATION_DATA_CONFIN: in  DF_SCTMOD2DUPLICATION_DATA_ARRAY;
    ODO_SCTMOD2DUPLICATION_WEN_CONFIN: in std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
    ODO_SCTMOD2DUPLICATION_DATA_CONFOUT    : out DF_SCTMOD2DUPLICATION_DATA_ARRAY;
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

    MERGER_1_OUTPUT_PORT_DATA_MONITOR : out DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
    MERGER_1_OUTPUT_PORT_DEN_MONITOR  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
    
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
    CENTRAL_SWITCH_RESET     : in  std_logic;
    CENTRAL_SWITCH_IN_RESET  : out std_logic;
    INTERNALLINK_DESTINATION_WORD_ADDER_RESET   : in  std_logic;
    INTERNALLINK_DESTINATION_WORD_REMOVER_RESET : in  std_logic;
    INTERNALLINK_FORCE_READY : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_DESTINATION_WORDS : in DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY;
    
    INTERNALLINK_CENTRAL_SWITCH_FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
    INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX

    
    );
end df_main;

architecture logic of df_main is
  
  component df_fmc_interface
    generic (
      common_clk_frequency : real := common_clk_frequency;
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
      
      -- <OUTPUT / FWFT FIFO running at MAIN_CLK>
      BUFFER_DATA_OUT : out DF_INPUT_DATA_ARRAY;
      BUFFER_CTRL_OUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      BUFFER_DV_OUT   : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      BUFFER_REN_IN   : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      
      -- <CONFIGURATTION PARAMTER>
      -- <FOR CONFIGURATION/MONITORING FMC - INPUT>
      FMCIN_CONFIG_CHANNELDELAY_DIR : in data_type_for_imfpga_input_lanes_t;
      FMCIN_CONFIG_CHANNELDELAY_CE  : in data_type_for_imfpga_input_lanes_t;
      FMCIN_CONFIG_DELAY_RESET      : in std_logic;
      FMCIN_CONFIG_FIFO_RESET   : in  std_logic;
      FMCIN_CONFIG_FIFO_FULL    : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_FIFO_ERROR   : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_XOFF         : out std_logic_vector(2*num_fpga_for_each_mainfpga-1 downto 0);
      FMCIN_CONFIG_FIFO_FULL_COUNT   : out DF_INPUT_DATA_ARRAY;
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
      FMCIN_BUSY_THRESHOLD      : in  std_logic_vector(31 downto 0);
      FMCIN_FIFO_WR_DATA : out DF_FMC_WR_DATA_ARRAY;
      
      FMCOUT_CONFIG_SPY_FREEZE_TO_IM : in std_logic;

      -- <FOR SPY BUFFER MONITORING>
      FMCIN_FRONT_DATA_SPYOUT : out data_type_for_fullwidth_data_from_imfpga_t; --@FMC_COMMON_CLK
      FMCIN_RX_DATA_SPYOUT : out DF_INPUT_DATA_ARRAY; --@FMC_COMMON_CLK
      FMCIN_RX_CTRL_SPYOUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
      FMCIN_RX_RDY_SPYOUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
      FMCIN_RX_DEN_SPYOUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
                                                                                         --
      SELECTED_FMC_FPGA    : in std_logic_vector(4 downto 0)
      );
  end component;

  component df_input_data_operator
    generic (
      USE_INPUT_EVENT_ALIGNMENT_LOGIC : std_logic := USE_INPUT_EVENT_ALIGNMENT_LOGIC);
    port (
      MAIN_CLK : in  std_logic;
      
      -- <OUTPUT / FWFT FIFO running at MAIN_CLK>
      DATA_IN : in  DF_INPUT_DATA_ARRAY;
      CTRL_IN : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      DV_IN   : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      REN_OUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      
      -- <output event header / traier>
      FRAME_DATA_OUT : out std_logic_vector(31 downto 0);
      FRAME_WEN_OUT  : out std_logic;
      FRAME_CTRL_OUT : out std_logic;      
      FRAME_XOFF_IN  : in  std_logic;
      
      -- <output (1)>
      MODDATA_DATA_OUTPUTSW_OUT : out DF_DATA_POST_IDO_ARRAY;
      MODDATA_WEN_OUTPUTSW_OUT  : out std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0);
      MODDATA_RDY_OUTPUTSW_IN   : in  std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0);
      
      -- <output (2)>
      MODDATA_DATA_DATASHARINGSW_OUT : out DF_DATA_POST_IDO_ARRAY;
      MODDATA_WEN_DATASHARINGSW_OUT  : out std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0);
      MODDATA_RDY_DATASHARINGSW_IN   : in  std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0);    
      
      INPUT_LUT_RESET             : in std_logic;
      INPUT_SINGLE_SWITCH_RESET   : in std_logic;
      ENABLE_FMC_LANES_MASK       : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_FRAME_DOUT_LANEID : in  integer range 0 to NUMBER_OF_FMC_INPUT_LANES-1;
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK : in  std_logic_vector(31 downto 0);
      
      INTERNAL_EVENT_COUNTER : out DF_INPUT_DATA_ARRAY;
      INTERNAL_STATUS_MONITOR: out DF_INPUT_DATA_ARRAY;
      
      -- <module data monitoring before switch>
      MODDATA_WEN_SWITCH_IN_MONITOR  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      MODDATA_RDY_SWITCH_IN_MONITOR  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      MODDATA_DATA_SWITCH_IN_MONITOR : out DF_INPUT_DATA_ARRAY;      
      
      -- <configuration / monitoring port>
      INPUT_LUT_MOD2IDX_ADDR_CONFIN   : in  DF_INPUT_MOD2IDX_ADDR_ARRAY;
      INPUT_LUT_MOD2IDX_DATA_CONFIN   : in  DF_INPUT_MOD2IDX_DATA_ARRAY;
      INPUT_LUT_MOD2IDX_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_MOD2IDX_DATA_CONFOUT  : out DF_INPUT_MOD2IDX_DATA_ARRAY;
      
      -- <configuration / monitoring port>
      INPUT_LUT_IDX2MOD_ADDR_CONFIN   : in  DF_INPUT_IDX2MOD_ADDR_ARRAY;
      INPUT_LUT_IDX2MOD_DATA_CONFIN   : in  DF_INPUT_IDX2MOD_DATA_ARRAY;
      INPUT_LUT_IDX2MOD_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_IDX2MOD_DATA_CONFOUT  : out DF_INPUT_IDX2MOD_DATA_ARRAY;
      
      -- <configuration / monitoring port>
      INPUT_LUT_PIXMOD2DST_ADDR_CONFIN   : in  DF_INPUT_PIXMOD2DST_ADDR_ARRAY;
      INPUT_LUT_PIXMOD2DST_DATA_CONFIN   : in  DF_INPUT_PIXMOD2DST_DATA_ARRAY;
      INPUT_LUT_PIXMOD2DST_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_PIXMOD2DST_DATA_CONFOUT  : out DF_INPUT_PIXMOD2DST_DATA_ARRAY;
      
      INPUT_LUT_SCTMOD2DST_ADDR_CONFIN   : in  DF_INPUT_SCTMOD2DST_ADDR_ARRAY;
      INPUT_LUT_SCTMOD2DST_DATA_CONFIN   : in  DF_INPUT_SCTMOD2DST_DATA_ARRAY;
      INPUT_LUT_SCTMOD2DST_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
      INPUT_LUT_SCTMOD2DST_DATA_CONFOUT  : out DF_INPUT_SCTMOD2DST_DATA_ARRAY;
      
      --INPUT_LUT_STATE_MACHINE_ERROR_MONITOR : out DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY;
      INPUT_LUT_EXPECTED_NUM_OF_MODULE      : in  DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY

      --IDO_STATE_MACHINE_STATE_MONITOR_SCT0 : out std_logic_vector(31 downto 0);
      --IDO_STATE_MACHINE_STATE_MONITOR_SCT1 : out std_logic_vector(31 downto 0);      
      --IDO_STATE_MACHINE_STATE_MONITOR_PIX0 : out std_logic_vector(31 downto 0);
      --IDO_STATE_MACHINE_STATE_MONITOR_PIX1 : out std_logic_vector(31 downto 0);      
      --IDO_STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
      
      );
  end component;

  component df_output_data_operator
    generic ( USE_SHORT_FRAME_FIFO_FOR_DEBUGGING : std_logic := USE_SHORT_FRAME_FIFO_FOR_DEBUGGING;
              NO_SWITCH_MODE : integer := NO_SWITCH_MODE;
              NO_EVENT_SORTING_MODE : integer := NO_EVENT_SORTING_MODE);
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
      
      OUTPUT_SWITCH_IN_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_IN_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_IN_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      OUTPUT_SWITCH_OUT_DATA_MONITOR : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_OUT_DEN_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_SWITCH_OUT_RDY_MONITOR  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      
      EVENT_SORTER_IN_DATA_MONITOR : out DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
      EVENT_SORTER_IN_DEN_MONITOR  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      EVENT_SORTER_IN_RDY_MONITOR  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);

      MERGER_1_OUTPUT_PORT_DATA_MONITOR : out DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY;
      MERGER_1_OUTPUT_PORT_DEN_MONITOR  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);

      OUTPUT_SWITCH_FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
      
      OUTPUT_FORCE_READY         : in  std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
      FTKPLANE_WORD_ADDER_RESET  : in  std_logic;
      OUTPUT_SWITCH_MERGER_RESET : in  std_logic;
      OUTPUT_SWITCH_RESET        : in  std_logic;
      DUPLICATOR_RESET           : in  std_logic;
      SLINK_PACKER_RESET         : in  std_logic;
      OUTPUT_SWITCH_IN_RESET     : out std_logic
      );
  end component;
  
  --
  component df_internallink_input
    port (
      MAIN_CLK : in std_logic;
      RST      : in std_logic;
      INTERNALLINK_RX_DATA   : in  DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
      INTERNALLINK_RX_DVALID : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      INTERNALLINK_RX_BUSY   : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
      
      DATA_OUTPUTSW_OUT      : out DF_DATA_POST_ILI_ARRAY;
      WEN_OUTPUTSW_OUT       : out std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0);
      RDY_OUTPUTSW_IN        : in  std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0);
      
      DATA_DATASHARINGSW_OUT : out DF_DATA_POST_ILI_ARRAY;
      WEN_DATASHARINGSW_OUT  : out std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0);
      RDY_DATASHARINGSW_IN   : in  std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0);    
      
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK : in  std_logic_vector(31 downto 0)
      );
  end component;
  
  component df_internallink_output
    generic ( NO_SWITCH_MODE : integer := NO_SWITCH_MODE);
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
  end component;
  
  -- <FMC>
  signal fmcin_buffer_data_out_i : DF_INPUT_DATA_ARRAY;
  signal fmcin_buffer_ctrl_out_i : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal fmcin_buffer_dv_out_i   : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal fmcin_buffer_ren_in_i   : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '1');
  
  -- <IDO>
  signal ido_frame_data_out_i : std_logic_vector(31 downto 0) := (others => '0');
  signal ido_frame_wen_out_i  : std_logic := '0';
  signal ido_frame_ctrl_out_i : std_logic := '0';
  signal ido_frame_xoff_in_i  : std_logic := '0';
  signal ido_moddata_data_outputsw_out_i : DF_DATA_POST_IDO_ARRAY := (others => (others => '0'));
  signal ido_moddata_wen_outputsw_out_i  : std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0) := (others => '0');
  signal ido_moddata_rdy_outputsw_in_i   : std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0) := (others => '1');
  signal ido_moddata_data_datasharingsw_out_i : DF_DATA_POST_IDO_ARRAY := (others => (others => '0'));
  signal ido_moddata_wen_datasharingsw_out_i  : std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0) := (others => '0');
  signal ido_moddata_rdy_datasharingsw_in_i   : std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0) := (others => '1');
  signal ili_moddata_data_outputsw_out_i : DF_DATA_POST_ILI_ARRAY := (others => (others => '0'));
  signal ili_moddata_wen_outputsw_out_i  : std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0) := (others => '0');
  signal ili_moddata_rdy_outputsw_in_i   : std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0) := (others => '1');
  signal ili_moddata_data_datasharingsw_out_i : DF_DATA_POST_ILI_ARRAY := (others => (others => '0'));
  signal ili_moddata_wen_datasharingsw_out_i  : std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0) := (others => '0');
  signal ili_moddata_rdy_datasharingsw_in_i   : std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0) := (others => '1');    
  
  -- <ODO>
  signal odo_in_data_in_i : DF_ODO_IN_DATA_ARRAY := (others => (others=>'0'));
  signal odo_in_den_in_i  : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0) := (others => '0');
  signal odo_in_rdy_in_i  : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0) := (others => '1');

  -- <ILO>
  signal ilo_in_data_in_i : DF_ILO_IN_DATA_ARRAY := (others => (others=>'0'));
  signal ilo_in_den_in_i  : std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0) := (others => '0');
  signal ilo_in_rdy_in_i  : std_logic_vector(NUMBER_OF_ILO_IN_LANES-1 downto 0) := (others => '1');
  
begin
  
  INST_INTERNAL_LINK_INPUT : if NO_INTERNAL_LINK_MODE=0 generate
  begin
    my_internallink_input : df_internallink_input
      port map (
        MAIN_CLK=>MAIN_CLK, RST=>INTERNALLINK_INPUT_BUFFER_RESET,
        INTERNALLINK_RX_DATA=>INTERNALLINK_RX_DATA, 
        INTERNALLINK_RX_DVALID=>INTERNALLINK_RX_DVALID,
        INTERNALLINK_RX_BUSY=>INTERNALLINK_RX_BUSY,
        
        DATA_OUTPUTSW_OUT=>ili_moddata_data_outputsw_out_i,
        WEN_OUTPUTSW_OUT=>ili_moddata_wen_outputsw_out_i,
        RDY_OUTPUTSW_IN=>ili_moddata_rdy_outputsw_in_i,
        
        DATA_DATASHARINGSW_OUT=>ili_moddata_data_datasharingsw_out_i,
        WEN_DATASHARINGSW_OUT=>ili_moddata_wen_datasharingsw_out_i,
        RDY_DATASHARINGSW_IN=>ili_moddata_rdy_datasharingsw_in_i,
        
        INPUT_SINGLE_SWITCH_THIS_BOARD_MASK=>INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_ILI
        );
  end generate;
  
  my_fmc_interface : df_fmc_interface
    port map (
      MAIN_CLK=>MAIN_CLK, FMC_COMMON_CLK=>FMC_COMMON_CLK, 
      
      -- <FB1 IO>
      FB1_RX_LVDS_P=>FB1_RX_LVDS_P, FB1_RX_LVDS_N=>FB1_RX_LVDS_N,
      FB1_CLK0_P=>FB1_CLK0_P, FB1_CLK0_N=>FB1_CLK0_N,
      FB1_CLK1_P=>FB1_CLK1_P, FB1_CLK1_N=>FB1_CLK1_N,
      FB1_TX_LVDS_P=>FB1_TX_LVDS_P, FB1_TX_LVDS_N=>FB1_TX_LVDS_N,
      FB1_TX_FWD_CLK_P=>FB1_TX_FWD_CLK_P, FB1_TX_FWD_CLK_N=>FB1_TX_FWD_CLK_N,
      
      -- <FB2 IO>
      FB2_RX_LVDS_P=>FB2_RX_LVDS_P, FB2_RX_LVDS_N=>FB2_RX_LVDS_N,
      FB2_CLK0_P=>FB2_CLK0_P, FB2_CLK0_N=>FB2_CLK0_N,
      FB2_CLK1_P=>FB2_CLK1_P, FB2_CLK1_N=>FB2_CLK1_N,
      FB2_TX_LVDS_P=>FB2_TX_LVDS_P, FB2_TX_LVDS_N=>FB2_TX_LVDS_N,
      FB2_TX_FWD_CLK_P=>FB2_TX_FWD_CLK_P, FB2_TX_FWD_CLK_N=>FB2_TX_FWD_CLK_N,
      
      -- <FB3 IO>
      FB3_RX_LVDS_P=>FB3_RX_LVDS_P, FB3_RX_LVDS_N=>FB3_RX_LVDS_N,
      FB3_CLK0_P=>FB3_CLK0_P, FB3_CLK0_N=>FB3_CLK0_N,
      FB3_CLK1_P=>FB3_CLK1_P, FB3_CLK1_N=>FB3_CLK1_N,
      FB3_TX_LVDS_P=>FB3_TX_LVDS_P, FB3_TX_LVDS_N=>FB3_TX_LVDS_N,
      FB3_TX_FWD_CLK_P=>FB3_TX_FWD_CLK_P, FB3_TX_FWD_CLK_N=>FB3_TX_FWD_CLK_N,

      -- <FB4 IO>
      FB4_RX_LVDS_P=>FB4_RX_LVDS_P, FB4_RX_LVDS_N=>FB4_RX_LVDS_N,
      FB4_CLK0_P=>FB4_CLK0_P, FB4_CLK0_N=>FB4_CLK0_N,
      FB4_CLK1_P=>FB4_CLK1_P, FB4_CLK1_N=>FB4_CLK1_N,
      FB4_TX_LVDS_P=>FB4_TX_LVDS_P, FB4_TX_LVDS_N=>FB4_TX_LVDS_N,
      FB4_TX_FWD_CLK_P=>FB4_TX_FWD_CLK_P, FB4_TX_FWD_CLK_N=>FB4_TX_FWD_CLK_N,
      
      -- <OUTPUT / FWFT FIFO running at MAIN_CLK>
      BUFFER_DATA_OUT=>fmcin_buffer_data_out_i,
      BUFFER_CTRL_OUT=>fmcin_buffer_ctrl_out_i,
      BUFFER_DV_OUT=>fmcin_buffer_dv_out_i,
      BUFFER_REN_IN=>fmcin_buffer_ren_in_i,
      
      -- <CONFIGURATTION PARAMTER>
      -- <FOR CONFIGURATION/MONITORING FMC - INPUT>
      FMCIN_CONFIG_CHANNELDELAY_DIR=>FMCIN_CONFIG_CHANNELDELAY_DIR,
      FMCIN_CONFIG_CHANNELDELAY_CE=>FMCIN_CONFIG_CHANNELDELAY_CE,
      FMCIN_CONFIG_DELAY_RESET=>FMCIN_CONFIG_DELAY_RESET,
      FMCIN_CONFIG_FIFO_RESET=>FMCIN_CONFIG_FIFO_RESET,
      FMCIN_CONFIG_FIFO_FULL=>FMCIN_CONFIG_FIFO_FULL,
      FMCIN_CONFIG_FIFO_ERROR=>FMCIN_CONFIG_FIFO_ERROR,
      FMCIN_CONFIG_XOFF=>FMCIN_CONFIG_XOFF,
      FMCIN_CONFIG_FIFO_FULL_COUNT=> FMCIN_CONFIG_FIFO_FULL_COUNT,
      FMCIN_CONFIG_FRAME_RESET=>FMCIN_CONFIG_FRAME_RESET,
      FMCIN_CONFIG_CLOCK_SYNC_RESET=>FMCIN_CONFIG_CLOCK_SYNC_RESET,
      FMCIN_CONFIG_SYNC_DONE=>FMCIN_CONFIG_SYNC_DONE,
      FMCIN_CONFIG_SYNC_ERROR=>FMCIN_CONFIG_SYNC_ERROR,
      FMCIN_CONFIG_CLK_INV=>FMCIN_CONFIG_CLK_INV,
      FMCIN_CONFIG_CLKDELAY_DIR=>FMCIN_CONFIG_CLKDELAY_DIR,
      FMCIN_CONFIG_CLKDELAY_CE=>FMCIN_CONFIG_CLKDELAY_CE,
      FMCIN_CONFIG_PATCHECK=>FMCIN_CONFIG_PATCHECK, -- sync to FMC_COMMON_CLK      
      FMCIN_BUFFER_CONFIG_RESET=>FMCIN_BUFFER_CONFIG_RESET,
      FMCIN_BUFFER_CONFIG_FULL=>FMCIN_BUFFER_CONFIG_FULL,
      FMCIN_BUSY_THRESHOLD=>FMCIN_BUSY_THRESHOLD,
      FMCIN_FIFO_WR_DATA=>FMCIN_FIFO_WR_DATA,
      FMCOUT_CONFIG_SPY_FREEZE_TO_IM=>FMCOUT_CONFIG_SPY_FREEZE_TO_IM,
      
      -- <FOR SPY BUFFER MONITORING>
      FMCIN_FRONT_DATA_SPYOUT=>FMCIN_FRONT_DATA_SPYOUT,
      FMCIN_RX_DATA_SPYOUT=>FMCIN_RX_DATA_SPYOUT,
      FMCIN_RX_CTRL_SPYOUT=>FMCIN_RX_CTRL_SPYOUT,
      FMCIN_RX_RDY_SPYOUT=>FMCIN_RX_RDY_SPYOUT,
      FMCIN_RX_DEN_SPYOUT=>FMCIN_RX_DEN_SPYOUT,

      SELECTED_FMC_FPGA=>SELECTED_FMC_FPGA
      );
  
  my_input_data_operator : df_input_data_operator
    port map (
      MAIN_CLK=>MAIN_CLK,
      
      DATA_IN=>fmcin_buffer_data_out_i,
      CTRL_IN=>fmcin_buffer_ctrl_out_i,
      DV_IN=>fmcin_buffer_dv_out_i,
      REN_OUT=>fmcin_buffer_ren_in_i,
      
      -- <output event header / traier>
      FRAME_DATA_OUT=>ido_frame_data_out_i,
      FRAME_WEN_OUT=>ido_frame_wen_out_i,
      FRAME_CTRL_OUT=>ido_frame_ctrl_out_i,
      FRAME_XOFF_IN=>ido_frame_xoff_in_i,
      
      -- <output (1)>
      MODDATA_DATA_OUTPUTSW_OUT=>ido_moddata_data_outputsw_out_i,
      MODDATA_WEN_OUTPUTSW_OUT=>ido_moddata_wen_outputsw_out_i,
      MODDATA_RDY_OUTPUTSW_IN=>ido_moddata_rdy_outputsw_in_i,
      
      -- <output (2)>
      MODDATA_DATA_DATASHARINGSW_OUT=>ido_moddata_data_datasharingsw_out_i,
      MODDATA_WEN_DATASHARINGSW_OUT=>ido_moddata_wen_datasharingsw_out_i,
      MODDATA_RDY_DATASHARINGSW_IN=>ido_moddata_rdy_datasharingsw_in_i, 
      
      INPUT_LUT_RESET=>INPUT_LUT_RESET,
      INPUT_SINGLE_SWITCH_RESET=>INPUT_SINGLE_SWITCH_RESET,
      ENABLE_FMC_LANES_MASK=>ENABLE_FMC_LANES_MASK,
      INPUT_LUT_FRAME_DOUT_LANEID=>INPUT_LUT_FRAME_DOUT_LANEID,
      INPUT_SINGLE_SWITCH_THIS_BOARD_MASK=>INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_IDO,
      INTERNAL_EVENT_COUNTER=>IDO_INTERNAL_EVENT_COUNTER,
      INTERNAL_STATUS_MONITOR=>IDO_INTERNAL_STATUS_MONITOR,
      MODDATA_WEN_SWITCH_IN_MONITOR=>MODDATA_WEN_SWITCH_IN_MONITOR,
      MODDATA_RDY_SWITCH_IN_MONITOR=>MODDATA_RDY_SWITCH_IN_MONITOR,
      MODDATA_DATA_SWITCH_IN_MONITOR=>MODDATA_DATA_SWITCH_IN_MONITOR,
      INPUT_LUT_MOD2IDX_ADDR_CONFIN=>INPUT_LUT_MOD2IDX_ADDR_CONFIN,
      INPUT_LUT_MOD2IDX_DATA_CONFIN=>INPUT_LUT_MOD2IDX_DATA_CONFIN,
      INPUT_LUT_MOD2IDX_WEN_CONFIN=>INPUT_LUT_MOD2IDX_WEN_CONFIN,
      INPUT_LUT_MOD2IDX_DATA_CONFOUT=>INPUT_LUT_MOD2IDX_DATA_CONFOUT,
      INPUT_LUT_IDX2MOD_ADDR_CONFIN=>INPUT_LUT_IDX2MOD_ADDR_CONFIN,
      INPUT_LUT_IDX2MOD_DATA_CONFIN=>INPUT_LUT_IDX2MOD_DATA_CONFIN,
      INPUT_LUT_IDX2MOD_WEN_CONFIN=>INPUT_LUT_IDX2MOD_WEN_CONFIN,
      INPUT_LUT_IDX2MOD_DATA_CONFOUT=>INPUT_LUT_IDX2MOD_DATA_CONFOUT,
      INPUT_LUT_PIXMOD2DST_ADDR_CONFIN=>INPUT_LUT_PIXMOD2DST_ADDR_CONFIN,
      INPUT_LUT_PIXMOD2DST_DATA_CONFIN=>INPUT_LUT_PIXMOD2DST_DATA_CONFIN,
      INPUT_LUT_PIXMOD2DST_WEN_CONFIN=>INPUT_LUT_PIXMOD2DST_WEN_CONFIN,
      INPUT_LUT_PIXMOD2DST_DATA_CONFOUT=>INPUT_LUT_PIXMOD2DST_DATA_CONFOUT,
      INPUT_LUT_SCTMOD2DST_ADDR_CONFIN=>INPUT_LUT_SCTMOD2DST_ADDR_CONFIN,
      INPUT_LUT_SCTMOD2DST_DATA_CONFIN=>INPUT_LUT_SCTMOD2DST_DATA_CONFIN,
      INPUT_LUT_SCTMOD2DST_WEN_CONFIN=>INPUT_LUT_SCTMOD2DST_WEN_CONFIN,
      INPUT_LUT_SCTMOD2DST_DATA_CONFOUT=>INPUT_LUT_SCTMOD2DST_DATA_CONFOUT,
      --INPUT_LUT_STATE_MACHINE_ERROR_MONITOR=>INPUT_LUT_STATE_MACHINE_ERROR_MONITOR,
      --IDO_STATE_MACHINE_STATE_MONITOR_SCT0 => IDO_STATE_MACHINE_STATE_MONITOR_SCT0,
      --IDO_STATE_MACHINE_STATE_MONITOR_SCT1 => IDO_STATE_MACHINE_STATE_MONITOR_SCT1,
      --IDO_STATE_MACHINE_STATE_MONITOR_PIX0 => IDO_STATE_MACHINE_STATE_MONITOR_PIX0,
      --IDO_STATE_MACHINE_STATE_MONITOR_PIX1 => IDO_STATE_MACHINE_STATE_MONITOR_PIX1,
      --IDO_STATE_MACHINE_ERROR_MONITOR => IDO_STATE_MACHINE_ERROR_MONITOR,
      INPUT_LUT_EXPECTED_NUM_OF_MODULE=>INPUT_LUT_EXPECTED_NUM_OF_MODULE
      );
  
  -- <For MONITORING PURPOSE ODO INPUT>
  process (MAIN_CLK)
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      ODOIN_DATA_MONITOR <= odo_in_data_in_i;
      ODOIN_DEN_MONITOR  <= odo_in_den_in_i;
      ODOIN_RDY_MONITOR  <= odo_in_rdy_in_i;
      
      IDOOUT_FRAME_DATA_MONITOR <= ido_frame_data_out_i;
      IDOOUT_FRAME_WEN_MONITOR  <= ido_frame_wen_out_i;
      IDOOUT_FRAME_CTRL_MONITOR <= ido_frame_ctrl_out_i;
      IDOOUT_FRAME_XOFF_MONITOR <= ido_frame_xoff_in_i;
    end if;
  end process;

  IDO2_OUTPUT_LANES : for iLane in 0 to NUMBER_OF_LANES_POST_IDO-1 generate
    constant odo_lane : integer := MAPPING_CONF_IDO2ODO(iLane);
  begin
    -- connection with output_sw
    odo_in_data_in_i(odo_lane)  <= ido_moddata_data_outputsw_out_i(iLane);
    odo_in_den_in_i(odo_lane)   <= ido_moddata_wen_outputsw_out_i(iLane);
    ido_moddata_rdy_outputsw_in_i(iLane) <= odo_in_rdy_in_i(odo_lane);
  end generate;
  
  IIL2_OUTPUT_LANES : for iLane in 0 to NUMBER_OF_LANES_POST_ILI-1 generate
    constant odo_lane : integer := MAPPING_CONF_ILI2ODO(iLane);
  begin
    -- connection with output_sw
    odo_in_data_in_i(odo_lane)  <= ili_moddata_data_outputsw_out_i(iLane);
    odo_in_den_in_i(odo_lane)   <= ili_moddata_wen_outputsw_out_i(iLane);
    ili_moddata_rdy_outputsw_in_i(iLane) <= odo_in_rdy_in_i(odo_lane);
  end generate;  
  
  INST_OUTPUT_DATA_OPERATOR : if NO_OUTPUT_DATA_OPERATOR_MODE=0 generate
  begin
    my_output_data_operator : df_output_data_operator
      port map (
        MAIN_CLK =>MAIN_CLK, 
        
        DATA_IN=>odo_in_data_in_i, DEN_IN=>odo_in_den_in_i, READY_OUT=>odo_in_rdy_in_i,
        FRAME_DATA_IN=>ido_frame_data_out_i, FRAME_WEN_IN=>ido_frame_wen_out_i,
        FRAME_CTRL_IN=>ido_frame_ctrl_out_i, FRAME_XOFF_OUT=>ido_frame_xoff_in_i, 
        
        SLINK_UD=>SLINK_LSC_UD,
        SLINK_UWEN_N=>SLINK_LSC_UWEN_N,
        SLINK_UCTRL_N=>SLINK_LSC_UCTRL_N,
        SLINK_LFF_N=>SLINK_LSC_LFF_N,
        SLINK_LDOWN_N=>SLINK_LSC_LDOWN_N,
        
        PIXMOD2FTKPLANE_ADDR_CONFIN=>ODO_PIXMOD2FTKPLANE_ADDR_CONFIN,
        PIXMOD2FTKPLANE_DATA_CONFIN=>ODO_PIXMOD2FTKPLANE_DATA_CONFIN,
        PIXMOD2FTKPLANE_WEN_CONFIN=>ODO_PIXMOD2FTKPLANE_WEN_CONFIN,
        PIXMOD2FTKPLANE_DATA_CONFOUT=>ODO_PIXMOD2FTKPLANE_DATA_CONFOUT,
        PIXMOD2TOWER_ADDR_CONFIN=>ODO_PIXMOD2TOWER_ADDR_CONFIN,
        PIXMOD2TOWER_DATA_CONFIN=>ODO_PIXMOD2TOWER_DATA_CONFIN,
        PIXMOD2TOWER_WEN_CONFIN=>ODO_PIXMOD2TOWER_WEN_CONFIN,
        PIXMOD2TOWER_DATA_CONFOUT=>ODO_PIXMOD2TOWER_DATA_CONFOUT,
        PIXMOD2DUPLICATION_ADDR_CONFIN=>ODO_PIXMOD2DUPLICATION_ADDR_CONFIN,
        PIXMOD2DUPLICATION_DATA_CONFIN=>ODO_PIXMOD2DUPLICATION_DATA_CONFIN,
        PIXMOD2DUPLICATION_WEN_CONFIN=>ODO_PIXMOD2DUPLICATION_WEN_CONFIN,
        PIXMOD2DUPLICATION_DATA_CONFOUT=>ODO_PIXMOD2DUPLICATION_DATA_CONFOUT,
        
        SCTMOD2FTKPLANE_ADDR_CONFIN=>ODO_SCTMOD2FTKPLANE_ADDR_CONFIN,
        SCTMOD2FTKPLANE_DATA_CONFIN=>ODO_SCTMOD2FTKPLANE_DATA_CONFIN,
        SCTMOD2FTKPLANE_WEN_CONFIN=>ODO_SCTMOD2FTKPLANE_WEN_CONFIN,
        SCTMOD2FTKPLANE_DATA_CONFOUT=>ODO_SCTMOD2FTKPLANE_DATA_CONFOUT,
        SCTMOD2TOWER_ADDR_CONFIN=>ODO_SCTMOD2TOWER_ADDR_CONFIN,
        SCTMOD2TOWER_DATA_CONFIN=>ODO_SCTMOD2TOWER_DATA_CONFIN,
        SCTMOD2TOWER_WEN_CONFIN=>ODO_SCTMOD2TOWER_WEN_CONFIN,
        SCTMOD2TOWER_DATA_CONFOUT=>ODO_SCTMOD2TOWER_DATA_CONFOUT,
        SCTMOD2DUPLICATION_ADDR_CONFIN=>ODO_SCTMOD2DUPLICATION_ADDR_CONFIN,
        SCTMOD2DUPLICATION_DATA_CONFIN=>ODO_SCTMOD2DUPLICATION_DATA_CONFIN,
        SCTMOD2DUPLICATION_WEN_CONFIN=>ODO_SCTMOD2DUPLICATION_WEN_CONFIN,
        SCTMOD2DUPLICATION_DATA_CONFOUT=>ODO_SCTMOD2DUPLICATION_DATA_CONFOUT,
        
        FTKPLANE_STATE_MACHINE_ERROR_MONITOR=>ODO_FTKPLANE_STATE_MACHINE_ERROR_MONITOR,
        SLINK_PACKER_STATE_MACHINE_ERROR_MONITOR=>ODO_SLINK_PACKER_STATE_MACHINE_ERROR_MONITOR,
        SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES=>ODO_SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES,
        FTKPLANE_WORD_ADDER_RESET=>ODO_FTKPLANE_WORD_ADDER_RESET,
        
        OUTPUT_SWITCH_IN_DATA_MONITOR => OUTPUT_SWITCH_IN_DATA_MONITOR,
        OUTPUT_SWITCH_IN_DEN_MONITOR  => OUTPUT_SWITCH_IN_DEN_MONITOR,
        OUTPUT_SWITCH_IN_RDY_MONITOR  => OUTPUT_SWITCH_IN_RDY_MONITOR,
        OUTPUT_SWITCH_OUT_DATA_MONITOR => OUTPUT_SWITCH_OUT_DATA_MONITOR,
        OUTPUT_SWITCH_OUT_DEN_MONITOR  => OUTPUT_SWITCH_OUT_DEN_MONITOR,
        OUTPUT_SWITCH_OUT_RDY_MONITOR  => OUTPUT_SWITCH_OUT_RDY_MONITOR,
        EVENT_SORTER_IN_DATA_MONITOR => EVENT_SORTER_IN_DATA_MONITOR,
        EVENT_SORTER_IN_DEN_MONITOR  => EVENT_SORTER_IN_DEN_MONITOR,
        EVENT_SORTER_IN_RDY_MONITOR  => EVENT_SORTER_IN_RDY_MONITOR,

        MERGER_1_OUTPUT_PORT_DATA_MONITOR => MERGER_1_OUTPUT_PORT_DATA_MONITOR,
        MERGER_1_OUTPUT_PORT_DEN_MONITOR => MERGER_1_OUTPUT_PORT_DEN_MONITOR,

        OUTPUT_SWITCH_FIFO_MONITORING => OUTPUT_SWITCH_FIFO_MONITORING,
        
        OUTPUT_FORCE_READY=>ODO_OUTPUT_FORCE_READY,
        OUTPUT_SWITCH_MERGER_RESET=>ODO_OUTPUT_SWITCH_MERGER_RESET,
        OUTPUT_SWITCH_RESET=>ODO_OUTPUT_SWITCH_RESET,
        DUPLICATOR_RESET=>ODO_DUPLICATOR_RESET,
        SLINK_PACKER_RESET=>ODO_SLINK_PACKER_RESET,
        OUTPUT_SWITCH_IN_RESET=>ODO_OUTPUT_SWITCH_IN_RESET
        );
  end generate;
  
  -- <For MONITORING PURPOSE ILO INPUT>
  process (MAIN_CLK)
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      ILOIN_DATA_MONITOR <= ilo_in_data_in_i;
      ILOIN_DEN_MONITOR  <= ilo_in_den_in_i;
      ILOIN_RDY_MONITOR  <= ilo_in_rdy_in_i;
    end if;
  end process;
  
  IDO2_INTERNALLINK_LANES : for iLane in 0 to NUMBER_OF_LANES_POST_IDO-1 generate
    constant ilo_lane : integer := MAPPING_CONF_IDO2ILO(iLane);
  begin
    -- connection with output_sw
    ilo_in_data_in_i(ilo_lane)  <= ido_moddata_data_datasharingsw_out_i(iLane);
    ilo_in_den_in_i(ilo_lane)   <= ido_moddata_wen_datasharingsw_out_i(iLane);
    ido_moddata_rdy_datasharingsw_in_i(iLane) <= ilo_in_rdy_in_i(ilo_lane);
  end generate;
  
  IIL2_INTERNALLINK_LANES : for iLane in 0 to NUMBER_OF_LANES_POST_ILI-1 generate
    constant ilo_lane : integer := MAPPING_CONF_ILI2ILO(iLane);
  begin
    -- connection with output_sw
    ilo_in_data_in_i(ilo_lane)  <= ili_moddata_data_datasharingsw_out_i(iLane);
    ilo_in_den_in_i(ilo_lane)   <= ili_moddata_wen_datasharingsw_out_i(iLane);
    ili_moddata_rdy_datasharingsw_in_i(iLane) <= ilo_in_rdy_in_i(ilo_lane);
  end generate;  
  
  INST_INTERNAL_LINK_OUTPUT : if NO_INTERNAL_LINK_MODE=0 generate
  begin
    my_internal_link_output : df_internallink_output
      port map (
        MAIN_CLK=>MAIN_CLK,
        
        DATA_IN=>ilo_in_data_in_i,
        WEN_IN=>ilo_in_den_in_i,
        RDY_OUT=>ilo_in_rdy_in_i,
        
        INTERNALLINK_TX_DATA=>INTERNALLINK_TX_DATA,
        INTERNALLINK_TX_DVALID=>INTERNALLINK_TX_DVALID,
        INTERNALLINK_TX_RDY=>INTERNALLINK_TX_RDY,
        
        CENTRAL_SWITCH_OUT_DATA_MONITOR => CENTRAL_SWITCH_OUT_DATA_MONITOR,
        CENTRAL_SWITCH_OUT_DEN_MONITOR  => CENTRAL_SWITCH_OUT_DEN_MONITOR,
        CENTRAL_SWITCH_OUT_RDY_MONITOR  => CENTRAL_SWITCH_OUT_RDY_MONITOR,

        INTERNALLINK_OUTPUT_SWITCH_OUT_DATA_MONITOR => INTERNALLINK_OUTPUT_SWITCH_OUT_DATA_MONITOR,
        INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR  => INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR,
        INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR  => INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR,
        
        INTERNALLINK_OUTPUT_SWITCH_IN_DATA_MONITOR => INTERNALLINK_OUTPUT_SWITCH_IN_DATA_MONITOR,
        INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR  => INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR,
        INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR  => INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR,
        
        CENTRAL_SWITCH_RESET=>CENTRAL_SWITCH_RESET,
        CENTRAL_SWITCH_IN_RESET=>CENTRAL_SWITCH_IN_RESET,
        INTERNALLINK_DESTINATION_WORD_ADDER_RESET=>INTERNALLINK_DESTINATION_WORD_ADDER_RESET,
        INTERNALLINK_DESTINATION_WORD_REMOVER_RESET=>INTERNALLINK_DESTINATION_WORD_REMOVER_RESET,
        INTERNALLINK_FORCE_READY=>INTERNALLINK_FORCE_READY,
        INTERNALLINK_DESTINATION_WORDS=>INTERNALLINK_DESTINATION_WORDS,
        
        CENTRAL_SWITCH_FIFO_MONITORING=>INTERNALLINK_CENTRAL_SWITCH_FIFO_MONITORING,
        INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING=>INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING
        );
  end generate;
  
end logic;
