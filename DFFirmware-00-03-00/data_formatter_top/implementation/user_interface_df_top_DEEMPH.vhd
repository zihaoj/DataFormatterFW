-- transition from SPI to IPBUS
-- modified into fully 32 bit Data bus

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;
use work.SpybufferConstants.all;
use work.FmcConstants.all;

use work.ipbus.all;
use work.ipbus_trans_decl.all;

use work.data_formatter_constants.all;

entity user_interface_df_top is
  generic (
    USE_4K_SPY_BUFFER             : std_logic := '0'; -- '0' 1K spybuffer
                                                      -- '1' 4K spybuffer
    SAMPLE_INTERNALLINK_INPUT     : std_logic := '0';
    SAMPLE_FMCIN_FRONT_DATA       : std_logic := '0';
    SAMPLE_SPYOUT_AT_FMCCOMMONCLK : std_logic := '0');
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
    FMCIN_FRONT_DATA_SPYOUT : in data_type_for_fullwidth_data_from_imfpga_t; --@FMC_COMMON_CLK--(OK)
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
    IDO_INTERNAL_EVENT_COUNTER     : in DF_INPUT_DATA_ARRAY;
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
    
    -- <For MONITORING PURPOSE ILI OUTPUT>
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
    PLL_RESET               : out std_logic; --(OK)
    TRANSCEIVER_RESET       : out std_logic; --(OK)
    LINK_RESET              : out std_logic; --(OK)
    SLINK_PATGEN_RESET      : out std_logic;
    SLINK_PATGEN_ENABLE     : out std_logic;    
    
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
    SLINK_LSC_GT_TXPOSTCURSOR : out DF_SLINK_LSC_GT_DEEMPH_ARRAY;
    SLINK_LSC_GT_TXPRECURSOR  : out DF_SLINK_LSC_GT_DEEMPH_ARRAY;
                                          
    
    SLINK_LSC_TOSENDARREAV  : out std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0); --(OK)
    
    --INTERNALLINK_RX_LOCK    : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    --INTERNALLINK_RX_ERROR   : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_BUFFER_CLR : out std_logic; -- new
    INTERNALLINK_RX_ENABLE  : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --new
    INTERNALLINK_TX_ENABLE  : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --new
    INTERNALLINK_RX_ENABLE_BERT : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0); --
    INTERNALLINK_TX_ENABLE_BERT : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_RX_BERT_COUNTER_RESET : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_RX_BERT_TOTAL_COUNT : in DF_DATA_GT_FOR_INTERNALLINK_ARRAY; --32bit_counter_out
    INTERNALLINK_RX_BERT_ERROR_COUNT : in DF_DATA_GT_FOR_INTERNALLINK_ARRAY; --32bit_counter_out
    INTERNALLINK_RX_BERT_COMPARISON_VALID : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);    
    INTERNALLINK_TX_URL     : out DF_RETURN_LINE_INTERNALLINK_ARRAY;
    INTERNALLINK_RX_LRL     : in  DF_RETURN_LINE_INTERNALLINK_ARRAY;
    INTERNALLINK_GT_TX_RESET_DONE : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_GT_RX_RESET_DONE : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_GT_RXBYTEISALIGNED: in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_GT_PLL_LOCK       : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_GT_RXPOLARITY : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_GT_TXPOLARITY : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    
    
    -- <internal link>
    INTERNALLINK_INPUT_BUFFER_RESET : out std_logic;
    INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_ILI : out std_logic_vector(31 downto 0);
    
    -- <Internal Link Output> -- (to be connected !!)
    CENTRAL_SWITCH_RESET    : out std_logic;
    CENTRAL_SWITCH_IN_RESET : in  std_logic; -- NC!!
    INTERNALLINK_DESTINATION_WORD_ADDER_RESET   : out std_logic;
    INTERNALLINK_DESTINATION_WORD_REMOVER_RESET : out std_logic;
    INTERNALLINK_FORCE_READY : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_DESTINATION_WORDS : out DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY;
    
    INTERNALLINK_CENTRAL_SWITCH_FIFO_MONITORING : in  FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
    INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING : in  FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX    
    );
end user_interface_df_top;

architecture logic of user_interface_df_top is
  
  signal clk125_fr, clk125, clk100, ipb_clk, eth_locked: std_logic;
  signal rst_125, rst_ipb, rst_eth, onehz: std_logic;
  signal mac_tx_data, mac_rx_data: std_logic_vector(7 downto 0);
  signal mac_tx_valid, mac_tx_last, mac_tx_error, mac_tx_ready, mac_rx_valid, mac_rx_last, mac_rx_error: std_logic;
  signal ipb_master_out : ipb_wbus;
  signal ipb_master_in : ipb_rbus;
  signal mac_addr: std_logic_vector(47 downto 0);
  signal ip_addr: std_logic_vector(31 downto 0);
  signal ilink_spy_tx_monitoring : integer range 0 to 11 := 0;
  signal ilink_spy_rx_monitoring : integer range 0 to 11 := 0;
  signal pkt_rx, pkt_tx, pkt_rx_led, pkt_tx_led, sys_rst: std_logic;	
  -- KH
  signal sysbuf_clk, clkwiz_clk, clkwiz_locked, clkwiz_rst,clkwiz_fb: std_logic;
  signal n_buf125_clk, buf125_clk, clean125_clk : std_logic;
  
  signal clk50_i  : std_logic;
  signal clk200_i : std_logic;
  
  constant register_addr_width : integer := 7;
  --constant NSLV: positive := 6;
  --signal reg_1_q : std_logic_vector(31 downto 0);
  signal inj_stat : std_logic_vector(2 ** register_addr_width * 32 - 1 downto 0);
  signal inj_ctrl : std_logic_vector(2 ** register_addr_width * 32 - 1 downto 0);
  --signal ipbw: ipb_wbus_array(NSLV-1 downto 0);
  --signal ipbr, ipbr_d: ipb_rbus_array(NSLV-1 downto 0);  
  
  component my_readonly_register
    port (d    : in  std_logic_vector(31 downto 0);
          dout : out std_logic_vector(31 downto 0));
  end component;  

  component my_writable_register
    port (q    : out std_logic_vector(31 downto 0);
          din  : in  std_logic_vector(31 downto 0);
          dout : out std_logic_vector(31 downto 0));
  end component;
  
  component my_pulse_generator
    port (
      refclk : in  std_logic;
      q      : out std_logic_vector(31 downto 0); -- to logic
      din    : in  std_logic_vector(31 downto 0);
      dout   : out std_logic_vector(31 downto 0));
  end component;
  
  component spy_buffer_multilanes_d4096_multi_clock_domain
    generic (
      numberOfLanes : integer range 1 to spybuffer_lane_max := spybuffer_lane_max
      );
    port (
      Reset  : in  std_logic;
      Freeze : in  std_logic;
      Wen   : in  std_logic_vector(spybuffer_lane_max-1 downto 0);
      Clk   : in  std_logic_vector(spybuffer_lane_max-1 downto 0);
      Din   : in  spybuffer_array;
      Dout  : out std_logic_vector(spybuffer_data_width-1 downto 0);
      LaneSelector : in  std_logic_vector(spybuffer_ls_width-1 downto 0);
      ReadAddressBinary : in  std_logic_vector(spybuffer_addr_width_d4096-1 downto 0)
      );
  end component;
  
  component spy_buffer_multilanes_d1024_multi_clock_domain
    generic (
      numberOfLanes : integer range 1 to spybuffer_lane_max := spybuffer_lane_max
      );
    port (
      Reset  : in  std_logic;
      Freeze : in  std_logic;
      Wen   : in  std_logic_vector(spybuffer_lane_max-1 downto 0);
      Clk   : in  std_logic_vector(spybuffer_lane_max-1 downto 0);
      Din   : in  spybuffer_array;
      Dout  : out std_logic_vector(spybuffer_data_width-1 downto 0);
      LaneSelector : in  std_logic_vector(spybuffer_ls_width-1 downto 0);
      ReadAddressBinary : in  std_logic_vector(spybuffer_addr_width_d1024-1 downto 0)
      );
  end component;  
  
  component i2c_master
    generic(
      input_clk : INTEGER := 150e6); --input clock speed from user logic in Hz    
    port (
    clk       : IN     STD_LOGIC;                    --system clock
    reset     : IN     STD_LOGIC;                    --active low reset
    ena       : IN     STD_LOGIC;                    --latch in command
    addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
    rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
    data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
    busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
    data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
    ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
  end component;  

  type register_array is array (2**register_addr_width-1 downto 0) of std_logic_vector(31 downto 0);
  signal reg_from_master : register_array := (others=>(others=>'0'));
  signal reg_from_slave  : register_array := (others=>(others=>'0'));
  
  -----------------------------------
  -- Address definition --
  ----------------------------------- 
  constant addr_ipaddress : integer := CONV_INTEGER(x"00");
  constant addr_reset : integer := CONV_INTEGER(x"01");
  -- RESET [0]=sIDELAY RESET
  -- RESET [1]=FMC INTERFACE INPUT DISABLE (FIFO_RESET)
  -- RESET [2]=FMC PARITY CHECKER DISABLE (SYNC_RESET)
  -- RESET [3]=FMC FRAME STATE MACHINE RESET (FRAME_RESET)
  -- RESET [4]=EVERYTHING ELSE (input buffer / switch etc)
  -- RESET [5]=I2C state machine reset
  -- RESET [6]=RESET TO THE SWITCHING PARAMETERS
  -- RESET [7]=COUNTER RESET
  
  constant addr_fmc_fifo_error : integer := CONV_INTEGER(x"02");
  -- FIFO_ERROR[7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1
  
  constant addr_fmc_fifo_full : integer := CONV_INTEGER(x"03");
  -- FIFO_FULL[7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1
  
  constant addr_fmc_sync_done : integer := CONV_INTEGER(x"05");
  -- SYNC_DONE[7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1
  
  constant addr_fmc_sync_error : integer := CONV_INTEGER(x"06");
  -- SYNC_DONE[7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1
  
  -- SLINK CONTROLLER
  constant addr_gt_link_controller : integer := CONV_INTEGER(x"07");
  -- GT_LINK_CONTROLLER[0]=PLL_RESET (for all the lanes)
  -- GT_LINK_CONTROLLER[1]=TRANSCEIVER_RESET (for all the lanes)
  -- GT_LINK_CONTROLLER[2]=LINK_RESET 
  -- GT_LINK_CONTROLLER[3]=SLINK_URESET (for SLINK)
  -- GT_LINK_CONTROLLER[4]=SLINK_UTEST  (for SLINK)
  -- GT_LINK_CONTROLLER[5]=SLINK_PATGEN_ENABLE (for SLINK all lanes)
  -- GT_LINK_CONTROLLER[6]=SLINK_PATGEN_RESET (for SLINK all lanes)
  
  constant addr_gt_link_lrl_monitor : integer := CONV_INTEGER(x"04");
  
  constant addr_gt_link_monitor : integer := CONV_INTEGER(x"08");
  -- GT_LINK_MONITOR[0]=GT_RXBYTEISALIGNED
  -- GT_LINK_MONITOR[1]=GT_TX_RESET_DONE
  -- GT_LINK_MONITOR[2]=GT_RX_RESET_DONE
  -- GT_LINK_MONITORK_MONITOR[3]=GT_PLL_LOCK
  -- GT_LINK_MONITOR[4]=TESTLED_N (SLINK)  
  -- GT_LINK_MONITOR[5]=LDERRLED_N (SLINK)
  -- GT_LINK_MONITOR[6]=LUPLED_N (SLINK)
  -- GT_LINK_MONITOR[7]=FLOWCTLLED_N (SLINK)
  -- GT_LINK_MONITOR[8]=ACTIVITYLED_N (SLINK)
  -- GT_LINK_MONITOR[9]=INTERNALLINK_RX_BERT_COMPARISON_VALID (INTERNALLINK)

  constant addr_gt_link_monitor_configure_laneselector : integer := CONV_INTEGER(x"09");
  -- GT_LINK_SELECTOR
  
  constant addr_gt_link_configuration      : integer := CONV_INTEGER(x"0A");
  -- [0] GT_RXPOLARITY
  -- [1] GT_TXPOLARITY
  -- [2] FORCE_READY_MODE
  -- [3] TO ALTERA FPGA (valid only for 32bit mode)
  
  constant addr_gt_link_configuration_wen  : integer := CONV_INTEGER(x"0B");

  constant addr_gt_link_configuration_read : integer := CONV_INTEGER(x"0C");
  
  constant addr_fmc_user_signals : integer := CONV_INTEGER(x"0D");
  -- USER_SIGNALS[0]=Mezzanine Reset
  -- USER_SIGNALS[1]=Mezzanine Trigger (L1 Trigger)
  -- USER_SIGNALS[7:3]=RESERVED

  constant addr_input_buffer_full  : integer := CONV_INTEGER(x"0E");
  constant addr_input_buffer_xoff  : integer := CONV_INTEGER(x"0F");
  
  -- spy buffer related address :
  -- READOUT0[7:0] = DOUT[ 7: 0], READOUT1[7:0] = DOUT[15: 8],
  -- READOUT1[7:0] = DOUT[23:16], READOUT1[7:0] = DOUT[31:24]
  constant addr_spy_readout      : integer := CONV_INTEGER(x"10");
  constant addr_spy_readaddr     : integer := CONV_INTEGER(x"14");
  constant addr_spy_laneselector : integer := CONV_INTEGER(x"16"); 
  constant addr_spy_controller   : integer := CONV_INTEGER(x"17");
  -- CONTROLLER [0]=SPY RESET (=counter reset)
  -- CONTROLLER [1]=FREEZE
  -- CONTROLLER [7]=SWITCH FOR SPY BUFFER (just for debugging still reserved)
  
  constant addr_input_single_switch_this_board_mask_ido : integer := CONV_INTEGER(x"19");
  constant addr_input_single_switch_this_board_mask_ili : integer := CONV_INTEGER(x"1A");
  constant addr_internal_link_url : integer := CONV_INTEGER(x"1B");
  constant addr_enable_fmc_lanes_mask   : integer := CONV_INTEGER(x"1D");
  
  constant addr_fmc_patcheck        : integer := CONV_INTEGER(x"1E");
  constant addr_fmc_patcheck_persis : integer := CONV_INTEGER(x"1F");  
  
  constant addr_expected_num_of_module   : integer := CONV_INTEGER(x"20");
  constant addr_switching_configuration_lane_selector : integer := CONV_INTEGER(x"22");
  constant addr_internallink_destination_words : integer := CONV_INTEGER(x"24");
  constant addr_update_switching_configuration_enable    : integer := CONV_INTEGER(x"28");
  -- [0] INPUT SWITCH number of expected module
  -- [1] OUTPUT SWITCH number of expected module
  -- [2] CENTRAL SWITCH out / destination bit 
  
  constant addr_fb_i2c_addr : integer := CONV_INTEGER(x"30"); -- R/W
  -- [6:0] : 7bit address, [7] : R/W (R=1, W=0)
  constant addr_fb_i2c_data_from_master : integer := CONV_INTEGER(x"31"); -- R/W
  constant addr_fb_i2c_data_from_slave  : integer := CONV_INTEGER(x"32"); -- R
  
  constant addr_i2c_enable        : integer := CONV_INTEGER(x"3D"); -- R/W
  -- [0] : enable FMC1, [1] reserved,
  -- [2] : enable FMC2, [3] reserved,
  -- [7:4] reserved
  constant addr_i2c_status        : integer := CONV_INTEGER(x"3E"); -- R
  -- [0] : busy from FMC1, [1] ack_error from FMC1, 
  -- [2] : busy from FMC2, [3] ack_error from FMC2, 
  -- [7:4] : reserved
  
  constant addr_lut_configuration_selector : integer := CONV_INTEGER(X"40");
  -- 0 : Look Up Table #0 14-bit MOD -> Index
  -- 1 : Look Up Table #1 Index -> 14-bit MOD
  -- 2 : Look Up Table #2 Pixel Module Data -> 32-bit destination
  -- 3 : Look Up Table #3 SCT Module Data   -> 32-bit destination
  -- 4 : Look Up Table #4 Pixel Module FTK Plane
  -- 5 : Look Up Table #5 SCT Module Tower (top and/or bottom)
  -- 6 : Look Up Table #6 Pixel Module FTK Plane
  -- 7 : Look Up Table #7 SCT Module Tower (top and/or bottom)
  -- 6 : Look Up Table #8 Pixel Module AUX duplicatoin (default "11" for all modules)
  -- 7 : Look Up Table #9 SCT Module AUX duplication (default "11" for all modules)
  constant addr_lut_configuration_addr_confin   : integer := CONV_INTEGER(X"41");
  constant addr_lut_configuration_wen_confin    : integer := CONV_INTEGER(X"43");
  constant addr_lut_configuration_read_lane     : integer := CONV_INTEGER(X"47");
  constant addr_lut_configuration_data_confin   : integer := CONV_INTEGER(X"48");
  constant addr_lut_configuration_data_confout  : integer := CONV_INTEGER(X"4C");
  
  constant addr_fmc_config_clk_inv : integer := CONV_INTEGER(x"60");
  -- CLK_INV[0] for FMC0-FPGA0, CLK_INV[1] for FMC0-FPGA1
  -- CLK_INV[2] for FMC1-FPGA0, CLK_INV[3] for FMC1-FPGA1
  constant addr_fmc_config_clkdelay_ce  : integer := CONV_INTEGER(x"61");
  -- CLK_CE[0] for FMC0-FPGA0, CLK_CE[1] for FMC0-FPGA1
  -- CLK_CE[2] for FMC1-FPGA0, CLK_CE[3] for FMC1-FPGA1
  
  constant addr_internal_link_tx_enable : integer := CONV_INTEGER(x"75");
  constant addr_internal_link_rx_enable_bert : integer := CONV_INTEGER(x"76");
  constant addr_internal_link_tx_enable_bert : integer := CONV_INTEGER(x"77");    
  constant addr_internal_link_rx_enable : integer := CONV_INTEGER(x"78");

  constant addr_switch_selector_for_fifo_monitoring : integer := CONV_INTEGER(x"79");
  constant addr_switch_fifo_monitoring              : integer := CONV_INTEGER(x"7A");
  
  signal channeldelay_channel_selector_fpga_id : integer range 0 to 7; --(3bit)
  signal channeldelay_channel_selector_chan_id : integer range 0 to 31; --(5bit)
  constant addr_fmc_config_channeldelay_channel_selector : integer := CONV_INTEGER(x"62");
  -- [4:0] = channel number (from 0 to 17) @ maximum
  -- [7:5] = FPGA ID (from 0 to 7)
  constant addr_fmc_config_channeldelay_ce  : integer := CONV_INTEGER(x"63");
  
  -- debugging purpose (counter for received data)
  constant addr_32bit_counter : integer := CONV_INTEGER(x"70"); -- Counter[7:0]
  constant addr_32bit_counter_lane_selector : integer := CONV_INTEGER(x"74");  
    
  -------------------------------------------------------------------------------
  signal buf_reset                   : std_logic_vector(31 downto 0) := (others => '0');
  signal configurable_parameter_reset   : std_logic;
  signal counter_parameter_reset   : std_logic;
  -------------------------------------------------------------------------------
  signal buf_fmc_patcheck            : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_fmc_patcheck_persis     : std_logic_vector(31 downto 0) := (others => '0');  
  signal buf_fmc_fifo_full           : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_fmc_fifo_error          : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_fmc_sync_done           : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_fmc_sync_error          : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_input_buffer_full       : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_input_buffer_xoff       : std_logic_vector(31 downto 0) := (others => '0');  
  -------------------------------------------------------------------------------
  signal buf_enable_fmc_lanes_mask   : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_input_single_switch_this_board_mask_ido  : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_input_single_switch_this_board_mask_ili  : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_internal_link_url : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_internal_link_rx_enable : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_internal_link_tx_enable : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_internal_link_rx_enable_bert : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_internal_link_tx_enable_bert : std_logic_vector(31 downto 0) := (others => '0');
  -------------------------------------------------------------------------------
  signal buf_expected_num_of_module   : std_logic_vector(31 downto 0);
  signal buf_switching_configuration_lane_selector : std_logic_vector(31 downto 0) := (others => '0');
  -- 0-7 for input lanes  with buf_update_switching_configuration_enable(0)='1'
  -- for <INPUT_LUT_EXPECTED_NUM_OF_MODULE>
  -- 0-5 for output lanes with buf_update_switching_configuration_enable(1)='1'
  -- for <OUTPUT_EVENT_SORTER_NUMBER_OF_EXPECTED_MODULES>
  -- 0-7 for central swtich with buf_update_switching_configuration_enable(2)='1'
  -- for <DESTINATION_MASK_FOR_CENTRAL_SWITCH_OUT>
  
  signal buf_internallink_destination_words : std_logic_vector(31 downto 0) := (others => '0');
  -- First for "INPUT_LUT_EXPECTED_NUM_OF_MODULE" (!!)
  -- then for  "OUTPUT_EVENT_SORTER_NUMBER_OF_EXPECTED_MODULES" (!!)
  signal buf_update_switching_configuration_enable      : std_logic_vector(31 downto 0) := (others => '0');
  -------------------------------------------------------------------------------
  signal buf_spy_readout      : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_spy_readaddr     : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_spy_laneselector : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_spy_controller   : std_logic_vector(31 downto 0) := (others => '0');
  -------------------------------------------------------------------------------
  signal buf_gt_link_controller : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_gt_link_monitor    : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_gt_link_lrl_monitor    : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_gt_link_configuration  : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_gt_link_configuration_wen  : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_gt_link_configuration_read : std_logic_vector(31 downto 0) := (others => '0');  
  signal buf_gt_link_monitor_configure_laneselector : std_logic_vector(31 downto 0) := (others => '0');
  -------------------------------------------------------------------------------
  signal buf_fmc_user_signals : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_fmc_user_interface  : std_logic_vector(31 downto 0) := (others => '0');
  -------------------------------------------------------------------------------
  signal buf_fmc_config_clk_inv : std_logic_vector(31 downto 0):= (others => '0');
  signal buf_fmc_config_clkdelay_ce  : std_logic_vector(31 downto 0):= (others => '0');
  signal buf_fmc_config_channeldelay_channel_selector : std_logic_vector(31 downto 0);
  signal buf_fmc_config_channeldelay_ce  : std_logic_vector(31 downto 0):= (others => '0');
  -------------------------------------------------------------------------------
  signal buf_lut_configuration_selector      : std_logic_vector(31 downto 0):= (others => '0');
  signal buf_lut_configuration_addr_confin   : std_logic_vector(31 downto 0):= (others => '0');
  signal buf_lut_configuration_wen_confin    : std_logic_vector(31 downto 0):= (others => '0');
  signal buf_lut_configuration_read_lane     : std_logic_vector(31 downto 0):= (others => '0');
  signal buf_lut_configuration_data_confin   : std_logic_vector(31 downto 0):= (others => '0');
  signal buf_lut_configuration_data_confout  : std_logic_vector(31 downto 0):= (others => '0');
  -------------------------------------------------------------------------------
  signal buf_switch_selector_for_fifo_monitoring : std_logic_vector(31 downto 0):= (others => '0');
  signal buf_switch_fifo_monitoring              : std_logic_vector(31 downto 0):= (others => '0');
  signal switch_selector_for_fifo_monitoring_column : integer range 0 to 4  := 0;
  signal switch_selector_for_fifo_monitoring_row    : integer range 0 to 15 := 0;
  -------------------------------------------------------------------------------
  signal lut_lane_to_be_read : integer range 0 to 63 := 0;
  
  signal lut_configuration_addr_confin  : std_logic_vector(15 downto 0):= (others => '0');
  signal lut_configuration_wen_confin   : std_logic_vector(31 downto 0):= (others => '0');
  signal lut_configuration_data_confin  : std_logic_vector(31 downto 0):= (others => '0');
  signal lut_configuration_data_confout : std_logic_vector(31 downto 0):= (others => '0');

  signal tmpr1_lut_configuration_addr_confin  : std_logic_vector(15 downto 0):= (others => '0');
  signal tmpr1_lut_configuration_wen_confin   : std_logic_vector(31 downto 0):= (others => '0');
  signal tmpr1_lut_configuration_data_confin  : std_logic_vector(31 downto 0):= (others => '0');
  signal tmpr1_lut_configuration_data_confout : std_logic_vector(31 downto 0):= (others => '0');                    

  signal tmpr2_lut_configuration_addr_confin  : std_logic_vector(15 downto 0):= (others => '0');
  signal tmpr2_lut_configuration_wen_confin   : std_logic_vector(31 downto 0):= (others => '0');
  signal tmpr2_lut_configuration_data_confin  : std_logic_vector(31 downto 0):= (others => '0');
  signal tmpr2_lut_configuration_data_confout : std_logic_vector(31 downto 0):= (others => '0');
  
  -- (0) Look Up Table #0 14-bit MOD -> Index
  signal input_lut_mod2idx_addr_confin_i  : DF_INPUT_MOD2IDX_ADDR_ARRAY;
  signal input_lut_mod2idx_data_confin_i  : DF_INPUT_MOD2IDX_DATA_ARRAY;
  signal input_lut_mod2idx_wen_confin_i   : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_mod2idx_data_confout_i : DF_INPUT_MOD2IDX_DATA_ARRAY;
  -- (1) Look Up Table #1 Index -> 14-bit MOD
  signal input_lut_idx2mod_addr_confin_i   : DF_INPUT_IDX2MOD_ADDR_ARRAY;
  signal input_lut_idx2mod_data_confin_i   : DF_INPUT_IDX2MOD_DATA_ARRAY;
  signal input_lut_idx2mod_wen_confin_i    : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_idx2mod_data_confout_i  : DF_INPUT_IDX2MOD_DATA_ARRAY;
  -- (2) Look Up Table #2 Pixel Module Data -> 32-bit destination
  signal input_lut_pixmod2dst_addr_confin_i   : DF_INPUT_PIXMOD2DST_ADDR_ARRAY;
  signal input_lut_pixmod2dst_data_confin_i   : DF_INPUT_PIXMOD2DST_DATA_ARRAY;
  signal input_lut_pixmod2dst_wen_confin_i    : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_pixmod2dst_data_confout_i  : DF_INPUT_PIXMOD2DST_DATA_ARRAY;
  -- (3) Look Up Table #3 SCT Module Data   -> 32-bit destination
  signal input_lut_sctmod2dst_addr_confin_i   : DF_INPUT_SCTMOD2DST_ADDR_ARRAY;
  signal input_lut_sctmod2dst_data_confin_i   : DF_INPUT_SCTMOD2DST_DATA_ARRAY;
  signal input_lut_sctmod2dst_wen_confin_i    : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_sctmod2dst_data_confout_i  : DF_INPUT_SCTMOD2DST_DATA_ARRAY;      
  -- (4) Look Up Table #4 Pixel Module FTK Plane 
  signal odo_pixmod2ftkplane_addr_confin_i  : DF_PIXMOD2FTKPLANE_ADDR_ARRAY;
  signal odo_pixmod2ftkplane_data_confin_i  : DF_PIXMOD2FTKPLANE_DATA_ARRAY;
  signal odo_pixmod2ftkplane_wen_confin_i   : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_pixmod2ftkplane_data_confout_i : DF_PIXMOD2FTKPLANE_DATA_ARRAY;
  -- (5) Look Up Table #5 SCT Module Tower (top and/or bottom)
  signal odo_pixmod2tower_addr_confin_i     : DF_PIXMOD2TOWER_ADDR_ARRAY;
  signal odo_pixmod2tower_data_confin_i     : DF_PIXMOD2TOWER_DATA_ARRAY;
  signal odo_pixmod2tower_wen_confin_i      : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_pixmod2tower_data_confout_i    : DF_PIXMOD2TOWER_DATA_ARRAY;
  -- (6) Look Up Table #6 Pixel Module FTK Plane 
  signal odo_sctmod2ftkplane_addr_confin_i  : DF_SCTMOD2FTKPLANE_ADDR_ARRAY;
  signal odo_sctmod2ftkplane_data_confin_i  : DF_SCTMOD2FTKPLANE_DATA_ARRAY;
  signal odo_sctmod2ftkplane_wen_confin_i   : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_sctmod2ftkplane_data_confout_i : DF_SCTMOD2FTKPLANE_DATA_ARRAY;
  -- (7) Look Up Table #7 SCT Module Tower (top and/or bottom)
  signal odo_sctmod2tower_addr_confin_i     : DF_SCTMOD2TOWER_ADDR_ARRAY;
  signal odo_sctmod2tower_data_confin_i     : DF_SCTMOD2TOWER_DATA_ARRAY;
  signal odo_sctmod2tower_wen_confin_i      : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_sctmod2tower_data_confout_i    : DF_SCTMOD2TOWER_DATA_ARRAY;
  -- (8) Look Up Table #8 Pixel Module AUX duplication
  signal odo_pixmod2duplication_addr_confin_i   : DF_PIXMOD2DUPLICATION_ADDR_ARRAY;
  signal odo_pixmod2duplication_data_confin_i  : DF_PIXMOD2DUPLICATION_DATA_ARRAY;
  signal odo_pixmod2duplication_wen_confin_i   : std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
  signal odo_pixmod2duplication_data_confout_i : DF_PIXMOD2DUPLICATION_DATA_ARRAY;
  -- (9) Look Up Table #8 Pixel Module AUX duplication
  signal odo_sctmod2duplication_addr_confin_i   : DF_SCTMOD2DUPLICATION_ADDR_ARRAY;
  signal odo_sctmod2duplication_data_confin_i  : DF_SCTMOD2DUPLICATION_DATA_ARRAY;
  signal odo_sctmod2duplication_wen_confin_i   : std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
  signal odo_sctmod2duplication_data_confout_i : DF_SCTMOD2DUPLICATION_DATA_ARRAY;
  
  -- =====================================================================
  -- for DFF for timing requirement
  -- =====================================================================
  -- (0) Look Up Table #0 14-bit MOD -> Index
  signal input_lut_mod2idx_addr_confin_r1 : DF_INPUT_MOD2IDX_ADDR_ARRAY;
  signal input_lut_mod2idx_data_confin_r1 : DF_INPUT_MOD2IDX_DATA_ARRAY;
  signal input_lut_mod2idx_wen_confin_r1  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_mod2idx_data_confout_r1: DF_INPUT_MOD2IDX_DATA_ARRAY;
  -- (1) Look Up Table #1 Index -> 14-bit MOD
  signal input_lut_idx2mod_addr_confin_r1  : DF_INPUT_IDX2MOD_ADDR_ARRAY;
  signal input_lut_idx2mod_data_confin_r1  : DF_INPUT_IDX2MOD_DATA_ARRAY;
  signal input_lut_idx2mod_wen_confin_r1   : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_idx2mod_data_confout_r1 : DF_INPUT_IDX2MOD_DATA_ARRAY;
  -- (2) Look Up Table #2 Pixel Module Data -> 32-bit destination
  signal input_lut_pixmod2dst_addr_confin_r1  : DF_INPUT_PIXMOD2DST_ADDR_ARRAY;
  signal input_lut_pixmod2dst_data_confin_r1  : DF_INPUT_PIXMOD2DST_DATA_ARRAY;
  signal input_lut_pixmod2dst_wen_confin_r1   : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_pixmod2dst_data_confout_r1 : DF_INPUT_PIXMOD2DST_DATA_ARRAY;
  -- (3) Look Up Table #3 SCT Module Data   -> 32-bit destination
  signal input_lut_sctmod2dst_addr_confin_r1  : DF_INPUT_SCTMOD2DST_ADDR_ARRAY;
  signal input_lut_sctmod2dst_data_confin_r1  : DF_INPUT_SCTMOD2DST_DATA_ARRAY;
  signal input_lut_sctmod2dst_wen_confin_r1   : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal input_lut_sctmod2dst_data_confout_r1 : DF_INPUT_SCTMOD2DST_DATA_ARRAY;      
  -- (4) Look Up Table #4 Pixel Module FTK Plane 
  signal odo_pixmod2ftkplane_addr_confin_r1 : DF_PIXMOD2FTKPLANE_ADDR_ARRAY;
  signal odo_pixmod2ftkplane_data_confin_r1 : DF_PIXMOD2FTKPLANE_DATA_ARRAY;
  signal odo_pixmod2ftkplane_wen_confin_r1  : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_pixmod2ftkplane_data_confout_r1: DF_PIXMOD2FTKPLANE_DATA_ARRAY;
  -- (5) Look Up Table #5 SCT Module Tower (top and/or bottom)
  signal odo_pixmod2tower_addr_confin_r1    : DF_PIXMOD2TOWER_ADDR_ARRAY;
  signal odo_pixmod2tower_data_confin_r1    : DF_PIXMOD2TOWER_DATA_ARRAY;
  signal odo_pixmod2tower_wen_confin_r1     : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_pixmod2tower_data_confout_r1   : DF_PIXMOD2TOWER_DATA_ARRAY;
  -- (6) Look Up Table #6 Pixel Module FTK Plane 
  signal odo_sctmod2ftkplane_addr_confin_r1 : DF_SCTMOD2FTKPLANE_ADDR_ARRAY;
  signal odo_sctmod2ftkplane_data_confin_r1 : DF_SCTMOD2FTKPLANE_DATA_ARRAY;
  signal odo_sctmod2ftkplane_wen_confin_r1  : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_sctmod2ftkplane_data_confout_r1: DF_SCTMOD2FTKPLANE_DATA_ARRAY;
  -- (7) Look Up Table #7 SCT Module Tower (top and/or bottom)
  signal odo_sctmod2tower_addr_confin_r1    : DF_SCTMOD2TOWER_ADDR_ARRAY;
  signal odo_sctmod2tower_data_confin_r1    : DF_SCTMOD2TOWER_DATA_ARRAY;
  signal odo_sctmod2tower_wen_confin_r1     : std_logic_vector(NUMBER_OF_ODO_IN_LANES-1 downto 0);
  signal odo_sctmod2tower_data_confout_r1   : DF_SCTMOD2TOWER_DATA_ARRAY;  
  -- (8) Look Up Table #8 Pixel Module AUX duplication
  signal odo_pixmod2duplication_addr_confin_r1  : DF_PIXMOD2DUPLICATION_ADDR_ARRAY;
  signal odo_pixmod2duplication_data_confin_r1  : DF_PIXMOD2DUPLICATION_DATA_ARRAY;
  signal odo_pixmod2duplication_wen_confin_r1   : std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
  signal odo_pixmod2duplication_data_confout_r1 : DF_PIXMOD2DUPLICATION_DATA_ARRAY;
  -- (9) Look Up Table #8 Pixel Module AUX duplication
  signal odo_sctmod2duplication_addr_confin_r1  : DF_SCTMOD2DUPLICATION_ADDR_ARRAY;
  signal odo_sctmod2duplication_data_confin_r1  : DF_SCTMOD2DUPLICATION_DATA_ARRAY;
  signal odo_sctmod2duplication_wen_confin_r1   : std_logic_vector(NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1 downto 0);
  signal odo_sctmod2duplication_data_confout_r1 : DF_SCTMOD2DUPLICATION_DATA_ARRAY;
  
  -------------------------------------------------------------------------------
  constant spy_lane_size : integer := (NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   + -- raw-input-monitor
                                       4);
                                       --NUMBER_OF_GT_FOR_INTERNALLINK_LANES); --for_ilink_inputmonitor
  signal spy_din   : spybuffer_array := (others=>(others=>'0'));
  signal spy_wen   : std_logic_vector(spybuffer_lane_max-1 downto 0) := (others=>'0');
  signal spy_write_clock : std_logic_vector(spybuffer_lane_max-1 downto 0) := (others=>'0'); 
  signal spy_dout  : std_logic_vector(spybuffer_data_width-1 downto 0);
  signal spy_lane_selector : std_logic_vector(spybuffer_ls_width-1 downto 0);
  signal spy_read_address  : std_logic_vector(spybuffer_addr_width_d4096-1 downto 0);
  -------------------------------------------------------------------------------
  
  -------------------------------------------------------------------------------
  constant number_of_32bit_counter_lanes : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                                      num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                                      num_fpga_for_each_mainfpga   +
                                                      NUMBER_OF_ODO_IN_LANES +
                                                      NUMBER_OF_ILO_IN_LANES +
                                                      NROW_32X32_SWITCH_MATRIX + --output_switch_in
                                                      NROW_32X32_SWITCH_MATRIX + --output_switch_out
                                                      NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --event_soter_in
                                                      NROW_32X32_SWITCH_MATRIX + --central_switch_out
                                                      NROW_32X32_SWITCH_MATRIX + --il_outputport_switch_in
                                                      NROW_32X32_SWITCH_MATRIX + --il_outputport_switch_out
                                                      NUMBER_OF_GT_FOR_INTERNALLINK_LANES +
                                                      NUMBER_OF_FMC_INPUT_LANES +
                                                      NUMBER_OF_FMC_INPUT_LANES +
                                                      1 + -- Frame_path_monitoring_(IDO-SLINK_PACKER)
                                                      NUMBER_OF_GT_FOR_INTERNALLINK_LANES +
                                                      NUMBER_OF_GT_FOR_INTERNALLINK_LANES;
                                                      --for bert in internal link FW
  
  type   counter32_array is array(number_of_32bit_counter_lanes-1 downto 0)
    of std_logic_vector(31 downto 0);
  signal data_word_counters : counter32_array := (others=>(others=>'0'));
  signal ctrl_word_counters : counter32_array := (others=>(others=>'0'));
  signal buf_32bit_counter_lane_selector : std_logic_vector(31 downto 0) := (others => '0');
  -- [7 : 0] = lane selector [10 : 8] = type selector
  -------------------------------------------------------------------------------
  signal selected_32bit_counter   : std_logic_vector(31 downto 0);
  signal selected_32bit_counter_lane_id  : integer range 0 to number_of_32bit_counter_lanes-1 := 0;  
  -------------------------------------------------------------------------------
  constant number_of_xoff_counter_lanes : integer := number_of_32bit_counter_lanes;
  type  xoff_counter_array is array(number_of_xoff_counter_lanes-1 downto 0)
    of std_logic_vector(31 downto 0);
  signal xoff_counters : xoff_counter_array := (others=>(others=>'0'));
  signal xoff_monitors : xoff_counter_array := (others=>(others=>'0'));
  -------------------------------------------------------------------------------
  constant number_of_gt_channels : integer := NUM_GT_LANES_RTM + NUM_GT_LANES_FABRIC;
  type  gt_data_array_for_gt_channels is array(0 to number_of_gt_channels-1) of std_logic_vector(31 downto 0);
  signal gt_link_monitor_array : gt_data_array_for_gt_channels := (others => (others => '0'));
  signal gt_link_configuration_read : gt_data_array_for_gt_channels := (others => (others => '0'));
  signal selected_gt_link_lane_id : integer range 0 to number_of_gt_channels-1 := 0;  
  -------------------------------------------------------------------------------
  
  signal buf_i2c_enable : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_i2c_status : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_fb_i2c_addr : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_fb_i2c_data_from_master : std_logic_vector(31 downto 0) := (others => '0');
  signal buf_fb_i2c_data_from_slave  : std_logic_vector(31 downto 0) := (others => '0');
  
  type lrl_array_t is array (0 to number_of_gt_channels-1) of std_logic_vector(3 downto 0);
  signal lrl_array : lrl_array_t := (others => (others=> '0'));
  
begin
  
  clocks: entity work.clocks_7s_serdes
    port map(
      clki_fr => clk125_fr,
      clki_125 => clk125,
      clko_ipb => open,
      eth_locked => eth_locked,
      locked => open,
      nuke => sys_rst,
      rsto_125 => rst_125,
      rsto_ipb => rst_ipb,
      rsto_eth => rst_eth,
      onehz => onehz,
      clko_200 => open
      );
  
  eth: entity work.eth_7s_1000basex
    port map(
      gt_clkp => REFCLK_P,
      gt_clkn => REFCLK_N,
      gt_txp => GT_TXP,
      gt_txn => GT_TXN,
      gt_rxp => GT_RXP,
      gt_rxn => GT_RXN,
      clk125_out => clk125,
      clk31_25_out => ipb_clk,
      clk125_fr => clk125_fr,
      clk200 => CLK200,
      drpclk => CLK50,
      rsti => rst_eth,
      locked => eth_locked,
      tx_data => mac_tx_data,
      tx_valid => mac_tx_valid,
      tx_last => mac_tx_last,
      tx_error => mac_tx_error,
      tx_ready => mac_tx_ready,
      rx_data => mac_rx_data,
      rx_valid => mac_rx_valid,
      rx_last => mac_rx_last,
      rx_error => mac_rx_error,
      -- KH
      autoneg_status => open,
      autoneg_restart => '0',
      link_status => open,
      eth_mmcm_locked => open,
      eth_phy_done => open,
      
      gt_pll_lock => open,
      gt_tx_reset => open,
      gt_rx_reset => open,
      gt_tx_resetdone => open,
      gt_rx_resetdone => open,
      gt_tx_resetint => open,
      gt_rx_resetint => open,
      gt_rx_resetcounter => open,
      my_txp => open,
      my_txn => open,
      my_rxp => open,
      my_rxn => open,
      my_gmii_rxd => open,
      
      kh_encommaalign => open,
      kh_rxchariscomma => open,
      kh_rxcharisk => open,
      kh_rxclkcorcnt => open,
      kh_rxdata => open,
      kh_rxrundisp => open,
      kh_rxbuferr => open,
      kh_txbuferr => open
      );
  
  ipbus: entity work.ipbus_ctrl
    port map(
      mac_clk => clk125,
      rst_macclk => rst_125,
      ipb_clk => ipb_clk,
      rst_ipb => rst_ipb,
      mac_rx_data => mac_rx_data,
      mac_rx_valid => mac_rx_valid,
      mac_rx_last => mac_rx_last,
      mac_rx_error => mac_rx_error,
      mac_tx_data => mac_tx_data,
      mac_tx_valid => mac_tx_valid,
      mac_tx_last => mac_tx_last,
      mac_tx_error => mac_tx_error,
      mac_tx_ready => mac_tx_ready,
      ipb_out => ipb_master_out,
      ipb_in => ipb_master_in,
      mac_addr => mac_addr,
      ip_addr => ip_addr,
      pkt_rx => pkt_rx,
      pkt_tx => pkt_tx,
      pkt_rx_led => pkt_rx_led,
      pkt_tx_led => pkt_tx_led
      );
  
  --mac_addr <= X"000a3502b47c"; --APL-FTK-DF-01-FABRIC.CERN.CH
  --ip_addr  <= X"0a914d13"; -- 10.145.77.19 --APL-FTK-DF-01-FABRIC.CERN.CH

  --this is lab 4 ip address
  --mac_addr <= X"000a3502b47f"; --DF-TBED-FTK-04-FABRIC@CERN
  --ip_addr  <= X"0ac14016"; -- 10.193.64.22 --DF-TBED-FTK-04-FABRIC@CERN
  --ilink_spy_rx_monitoring <= 5; -- temporal solution for Jan test
  --ilink_spy_tx_monitoring <= 0; -- temporal solution for Jan test

  -- this is lab 4 ip address
  --mac_addr <= X"000a3502b47d"; --DF-TBED-FTK-01-FABRIC@CERN
  --ip_addr  <= X"0ac14014"; -- 10.193.64.20 --DF-TBED-FTK-01-FABRIC@CERN  
  --ilink_spy_rx_monitoring <= 0; -- temporal solution for Jan test
  --ilink_spy_tx_monitoring <= 5; -- temporal solution for Jan test
  
  -- This is point one IP address as of april
  mac_addr <= X"000a3502b47f";         --DF-TBED-FTK-04-FABRIC@CERN
  ip_addr  <= X"0a915f12";           -- 10.145.95.18, device name apl-ftk-df-01
  ilink_spy_rx_monitoring <= 0; -- temporal solution for Jan test
  ilink_spy_tx_monitoring <= 5; -- temporal solution for Jan test

  
  --ip_addr <= X"c0a80b85"; -- 192.168.11.133


  -- this is point one IP address for 1st new board
  --mac_addr <= X"000a3502b480";   --
  --ip_addr  <= X"0a915f1f";       -- 10.145.95.31, device name apl-ftk-df-01
  --ilink_spy_rx_monitoring <= 0; -- temporal solution for Jan test
  --ilink_spy_tx_monitoring <= 5; -- temporal solution for Jan test
  

  -- this is point one IP address for 1st new board
  --mac_addr <= X"000a3502b480";   --
  --ip_addr  <= X"0a915f1f";       -- 10.145.95.31, device name apl-ftk-df-01
  --ilink_spy_rx_monitoring <= 0; -- temporal solution for Jan test
  --ilink_spy_tx_monitoring <= 5; -- temporal solution for Jan test
  
  
  -- this is point one IP address for 2nd new board
  --mac_addr <= X"000a3502b481";   --
  --ip_addr  <= X"0a915f20";       -- 10.145.95.32, device name apl-ftk-df-01
  --ilink_spy_rx_monitoring <= 0; -- temporal solution for Jan test
  --ilink_spy_tx_monitoring <= 5; -- temporal solution for Jan test
  
  
  --fabric: entity work.ipbus_fabric
  --  generic map(NSLV => NSLV)
  --  port map(
  --    ipb_in => ipb_master_out,
  --    ipb_out => ipb_master_in,
  --    ipb_to_slaves => ipbw,
  --    ipb_from_slaves => ipbr
  --  );  
  
  slave : entity work.ipbus_register_interface
    generic map(
      ctrl_addr_width => register_addr_width,
      stat_addr_width => register_addr_width
      )
    port map(
      clk => ipb_clk,
      reset => rst_ipb,
      ipbus_in => ipb_master_out, --ipbw(0),
      ipbus_out => ipb_master_in, --ipbr(0),
      d => inj_stat,
      q => inj_ctrl
      );
  
  REG2IPBUS : for iReg in 0 to (2 ** register_addr_width - 1) generate
    constant start_bit : integer := iReg * 32;
    constant end_bit   : integer := start_bit + 31;
  begin
    inj_stat(end_bit downto start_bit) <= reg_from_slave(iReg);
    reg_from_master(iReg)              <= inj_ctrl(end_bit downto start_bit);
  end generate;
  
  -- ========================================================================
  INPUT_LANES : for iFpgaOnIM in 0 to num_fpga_for_each_mainfpga-1 generate
    constant ch0_lane   : integer := iFpgaOnIM*2;
    constant ch1_lane   : integer := iFpgaOnIM*2 + 1;
    constant front_lane : integer := iFpgaOnIM;
    
    constant spy_ch0_lane   : integer := ch0_lane + NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES;
    constant spy_ch1_lane   : integer := ch1_lane + NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES;
    constant spy_front_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                         num_fpga_for_each_mainfpga*2 +
                                         front_lane;
    
    signal xoff_ch0_lane_r1 : std_logic;
    signal xoff_ch1_lane_r1 : std_logic;
    signal xoff_ch0_lane_r2 : std_logic;
    signal xoff_ch1_lane_r2 : std_logic;

    -- to satisfy timing requirement
    signal spy_din_front_r1 : std_logic_vector(31 downto 0);
    signal spy_din_front_r2 : std_logic_vector(31 downto 0);
    signal spy_din_front_r3 : std_logic_vector(31 downto 0);
    
    signal spy_din_ch0_r1 : std_logic_vector(31 downto 0);
    signal spy_din_ch1_r1 : std_logic_vector(31 downto 0);
    signal spy_wen_ch0_r1 : std_logic;
    signal spy_wen_ch1_r1 : std_logic;
    
    signal spy_din_ch0_r2 : std_logic_vector(31 downto 0);
    signal spy_din_ch1_r2 : std_logic_vector(31 downto 0);
    signal spy_wen_ch0_r2 : std_logic;
    signal spy_wen_ch1_r2 : std_logic;

    signal spy_din_ch0_r3 : std_logic_vector(31 downto 0);
    signal spy_din_ch1_r3 : std_logic_vector(31 downto 0);
    signal spy_wen_ch0_r3 : std_logic;
    signal spy_wen_ch1_r3 : std_logic;        
  
  begin
    FMCIN_CONFIG_CHANNELDELAY_DIR(iFpgaOnIM) <= (others =>'1'); -- constant
    
    FMCIN_CONFIG_CLKDELAY_DIR(iFpgaOnIM) <= '1'; -- constant
    FMCIN_CONFIG_CLK_INV(iFpgaOnIM)     <= buf_fmc_config_clk_inv(iFpgaOnIM);
    FMCIN_CONFIG_CLKDELAY_CE(iFpgaOnIM) <= buf_fmc_config_clkdelay_ce(iFpgaOnIM);    

    buf_fmc_fifo_full(iFpgaOnIM)           <= FMCIN_CONFIG_FIFO_FULL(iFpgaOnIM);
    buf_fmc_fifo_error(iFpgaOnIM)          <= FMCIN_CONFIG_FIFO_ERROR(iFpgaOnIM);
    buf_fmc_sync_done(iFpgaOnIM)           <= FMCIN_CONFIG_SYNC_DONE(iFpgaOnIM);
    buf_fmc_sync_error(iFpgaOnIM)          <= FMCIN_CONFIG_SYNC_ERROR(iFpgaOnIM);

    buf_fmc_patcheck(ch0_lane)             <= FMCIN_CONFIG_PATCHECK(ch0_lane);
    buf_input_buffer_full(ch0_lane)        <= FMCIN_BUFFER_CONFIG_FULL(ch0_lane);
    buf_input_buffer_full(ch1_lane)        <= FMCIN_BUFFER_CONFIG_FULL(ch1_lane);
    
    buf_fmc_patcheck(ch1_lane)             <= FMCIN_CONFIG_PATCHECK(ch1_lane);
    buf_input_buffer_xoff(ch0_lane)        <= FMCIN_CONFIG_XOFF(ch0_lane);
    buf_input_buffer_xoff(ch1_lane)        <= FMCIN_CONFIG_XOFF(ch1_lane);
    
    CASE_SAMPLE_FMCIN_FRONT_DATA : if SAMPLE_FMCIN_FRONT_DATA = '1' generate
    begin
      spy_write_clock(spy_front_lane) <= FMC_COMMON_CLK;
    end generate;
    
    CASE_NO_SAMPLE_FMCIN_FRONT_DATA : if SAMPLE_FMCIN_FRONT_DATA = '0' generate
    begin
      spy_write_clock(spy_front_lane) <= '0';
    end generate;    
    
    CASE_SPYSAMPLING_WITH_FMC_CLOCK : if SAMPLE_SPYOUT_AT_FMCCOMMONCLK = '1' generate
    begin
      spy_write_clock(spy_ch0_lane) <= FMC_COMMON_CLK;
      spy_write_clock(spy_ch1_lane) <= FMC_COMMON_CLK;      
    end generate;

    CASE_SPYSAMPLING_WITH_MAIN_CLOCK : if SAMPLE_SPYOUT_AT_FMCCOMMONCLK = '0' generate
    begin
      spy_write_clock(spy_ch0_lane) <= MAIN_CLK;
      spy_write_clock(spy_ch1_lane) <= MAIN_CLK;
    end generate;    
    
    -- FOR SPYBUFFER FRONT
    -- dummy data (test for readout)
    data_word_counters(spy_front_lane) <= X"AAAA"&std_logic_vector(to_unsigned(spy_front_lane, 16));
    ctrl_word_counters(spy_front_lane) <= X"BBBB"&std_logic_vector(to_unsigned(spy_front_lane, 16));
    xoff_counters(spy_front_lane)      <= X"CCCC"&std_logic_vector(to_unsigned(spy_front_lane, 16));
    xoff_monitors(spy_front_lane)      <= (others => '0');
    FMCIN_FRONT_DATA_SPY_MONITOR : if SAMPLE_FMCIN_FRONT_DATA = '1' generate
    begin
      process (spy_write_clock(spy_front_lane), buf_spy_controller(0))
      begin
        if (buf_spy_controller(0)='1') then
          spy_din(spy_front_lane) <= (others => '0');
          spy_wen(spy_front_lane) <= '0';
          spy_din_front_r1 <= (others => '0');
          spy_din_front_r2 <= (others => '0');
          spy_din_front_r3 <= (others => '0');
        elsif (spy_write_clock(spy_front_lane)'event and spy_write_clock(spy_front_lane)='1') then
          spy_din_front_r1(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0) <= FMCIN_FRONT_DATA_SPYOUT(front_lane);
          spy_din_front_r1(31 downto 2*lvds_pairs_for_rx_in_each_fpga)  <= (others => '0');
          spy_din_front_r2 <= spy_din_front_r1;
          spy_din_front_r3 <= spy_din_front_r2;
          spy_din(spy_front_lane) <= spy_din_front_r3;
          spy_wen(spy_front_lane) <= '1';
        end if;
      end process;
    end generate;
    
    -- FOR SPYBUFFER CH0
    process (spy_write_clock(spy_ch0_lane), buf_spy_controller(0))
    begin
      if (buf_spy_controller(0)='1') then
        spy_din(spy_ch0_lane) <= (others => '0');
        spy_wen(spy_ch0_lane) <= '0';
        spy_din_ch0_r1 <= (others => '0');
        spy_wen_ch0_r1 <= '0';
        spy_din_ch0_r2 <= (others => '0');
        spy_wen_ch0_r2 <= '0';
        spy_din_ch0_r3 <= (others => '0');
        spy_wen_ch0_r3 <= '0';        
      elsif (spy_write_clock(spy_ch0_lane)'event and spy_write_clock(spy_ch0_lane)='1') then
        spy_din_ch0_r1 <= FMCIN_RX_DATA_SPYOUT(ch0_lane);
        spy_wen_ch0_r1 <= FMCIN_RX_DEN_SPYOUT(ch0_lane);
        spy_din_ch0_r2 <= spy_din_ch0_r1;
        spy_wen_ch0_r2 <= spy_wen_ch0_r1;
        spy_din_ch0_r3 <= spy_din_ch0_r2;
        spy_wen_ch0_r3 <= spy_wen_ch0_r2;
        spy_din(spy_ch0_lane) <= spy_din_ch0_r3;
        spy_wen(spy_ch0_lane) <= spy_wen_ch0_r3;
      end if;
    end process;

    -- FOR SPYBUFFER CH0 -- counter
    process (spy_write_clock(spy_ch0_lane), counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(spy_ch0_lane) <= (others=>'0');
        ctrl_word_counters(spy_ch0_lane) <= (others=>'0');
      elsif (spy_write_clock(spy_ch0_lane)'event and spy_write_clock(spy_ch0_lane)='1') then
        if FMCIN_RX_DEN_SPYOUT(ch0_lane)='1' then
          if FMCIN_RX_CTRL_SPYOUT(ch0_lane)='0' then
            data_word_counters(spy_ch0_lane)   <= data_word_counters(spy_ch0_lane)+1;
          else
            ctrl_word_counters(spy_ch0_lane)   <= ctrl_word_counters(spy_ch0_lane)+1;
          end if;
        end if;
      end if;
    end process;    
    
    -- FOR SPYBUFFER CH1
    process (spy_write_clock(spy_ch1_lane),  buf_spy_controller(0))
    begin
      if (buf_spy_controller(0)='1') then
        spy_din(spy_ch1_lane) <= (others => '0');
        spy_wen(spy_ch1_lane) <= '0';
        spy_din_ch1_r1 <= (others => '0');
        spy_wen_ch1_r1 <= '0';
        spy_din_ch1_r2 <= (others => '0');
        spy_wen_ch1_r2 <= '0';
        spy_din_ch1_r3 <= (others => '0');
        spy_wen_ch1_r3<= '0';
      elsif (spy_write_clock(spy_ch1_lane)'event and spy_write_clock(spy_ch1_lane)='1') then
        spy_din_ch1_r1 <= FMCIN_RX_DATA_SPYOUT(ch1_lane);
        spy_wen_ch1_r1 <= FMCIN_RX_DEN_SPYOUT(ch1_lane);
        spy_din_ch1_r2 <= spy_din_ch1_r1;
        spy_wen_ch1_r2 <= spy_wen_ch1_r1;
        spy_din_ch1_r3 <= spy_din_ch1_r2;
        spy_wen_ch1_r3 <= spy_wen_ch1_r2;
        spy_din(spy_ch1_lane) <= spy_din_ch1_r3;
        spy_wen(spy_ch1_lane) <= spy_wen_ch1_r3;
      end if;
    end process;
    
    -- FOR SPYBUFFER CH1 -- counter
    process (spy_write_clock(spy_ch1_lane), counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(spy_ch1_lane) <= (others=>'0');
        ctrl_word_counters(spy_ch1_lane) <= (others=>'0');
      elsif (spy_write_clock(spy_ch1_lane)'event and spy_write_clock(spy_ch1_lane)='1') then
        if FMCIN_RX_DEN_SPYOUT(ch1_lane)='1' then
          if FMCIN_RX_CTRL_SPYOUT(ch1_lane)='0' then
            data_word_counters(spy_ch1_lane)   <= data_word_counters(spy_ch1_lane)+1;
          else
            ctrl_word_counters(spy_ch1_lane)   <= ctrl_word_counters(spy_ch1_lane)+1;
          end if;
        end if;
      end if;
    end process;    
    
    -- =============================================================
    -- XOFF latch (detect rising edge of XOFF signal) ch0
    -- =============================================================
    process (spy_write_clock(spy_ch0_lane))
    begin
      if (spy_write_clock(spy_ch0_lane)'event and spy_write_clock(spy_ch0_lane)='1') then
        --xoff_ch0_lane_r1 <= FMCIN_CONFIG_XOFF(ch0_lane);
        xoff_ch0_lane_r1 <= not FMCIN_RX_RDY_SPYOUT(ch0_lane);
        xoff_ch0_lane_r2 <= xoff_ch0_lane_r1;
      end if;
    end process;
    
    -- =============================================================
    -- XOFF counter ch0
    -- =============================================================
    process (spy_write_clock(spy_ch0_lane), counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(spy_ch0_lane) <= (others => '0');
        xoff_monitors(spy_ch0_lane) <= (others => '0');
      elsif (spy_write_clock(spy_ch0_lane)'event and spy_write_clock(spy_ch0_lane)='1') then
        -- ch0 counter
        xoff_monitors(spy_ch0_lane)(0) <= xoff_ch0_lane_r2;
        if (xoff_ch0_lane_r1='1' and xoff_ch0_lane_r2='0') then
          if (and_reduce(xoff_counters(spy_ch0_lane))='0') then
            xoff_counters(spy_ch0_lane) <= xoff_counters(spy_ch0_lane) + 1;
          else NULL;
          end if;
        end if;        
      end if;
    end process;
    
    -- =============================================================
    -- XOFF latch (detect rising edge of XOFF signal) ch1
    -- =============================================================
    process (spy_write_clock(spy_ch1_lane))
    begin
      if (spy_write_clock(spy_ch1_lane)'event and spy_write_clock(spy_ch1_lane)='1') then
        --xoff_ch1_lane_r1 <= FMCIN_CONFIG_XOFF(ch1_lane);
        xoff_ch1_lane_r1 <= not FMCIN_RX_RDY_SPYOUT(ch1_lane);
        xoff_ch1_lane_r2 <= xoff_ch1_lane_r1;
      end if;
    end process;
    
    -- =============================================================
    -- XOFF counter ch1
    -- =============================================================
    process (spy_write_clock(spy_ch1_lane), counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(spy_ch1_lane) <= (others => '0');
        xoff_monitors(spy_ch1_lane) <= (others => '0');
      elsif (spy_write_clock(spy_ch1_lane)'event and spy_write_clock(spy_ch1_lane)='1') then
        -- ch1 counter
        xoff_monitors(spy_ch1_lane)(0) <= xoff_ch1_lane_r2;
        if (xoff_ch1_lane_r1='1' and xoff_ch1_lane_r2='0') then
          if (and_reduce(xoff_counters(spy_ch1_lane))='0') then
            xoff_counters(spy_ch1_lane) <= xoff_counters(spy_ch1_lane) + 1;
          else NULL;
          end if;
        end if;        
      end if;
    end process;        

    process (FMC_COMMON_CLK, buf_reset(2))
    begin
      if (buf_reset(2)='1') then
        buf_fmc_patcheck_persis(ch0_lane) <= '1';
        buf_fmc_patcheck_persis(ch1_lane) <= '1';
      elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
        if (buf_fmc_patcheck(ch0_lane)='0') then
          buf_fmc_patcheck_persis(ch0_lane) <= '0';
        end if;
        
        if (buf_fmc_patcheck(ch1_lane)='0') then
          buf_fmc_patcheck_persis(ch1_lane) <= '0';
        end if;        
      end if;
    end process;
    
  end generate;
  
  ------------------------------------------------------------------
  -- SPY BUFFER assignment for SLINK OUTPUT <LSC logic>
  ------------------------------------------------------------------
  SLINK_OUTPUT_LANES : for iSlink in 0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 generate
    constant spy_slink_lane  : integer := iSlink;
    signal xoff_slink_r1     : std_logic;
    signal xoff_slink_r2     : std_logic;
    constant gt_lanes : integer := iSlink;
    signal tmp_gt_link_configuration : std_logic_vector(31 downto 0) := (others => '0');
    
    signal spy_din_r1 : std_logic_vector(31 downto 0);
    signal spy_wen_r1 : std_logic;

    signal spy_din_r2 : std_logic_vector(31 downto 0);
    signal spy_wen_r2 : std_logic;
    
    signal spy_din_r3 : std_logic_vector(31 downto 0);
    signal spy_wen_r3 : std_logic;
    
  begin
    SLINK_LSC_URESET_N(iSlink) <= not buf_gt_link_controller(3);
    SLINK_LSC_UTEST_N(iSlink)  <= not buf_gt_link_controller(4);
    
    SLINK_LSC_GT_RXPOLARITY(iSlink) <= tmp_gt_link_configuration(0);
    SLINK_LSC_GT_TXPOLARITY(iSlink) <= tmp_gt_link_configuration(1);
    ODO_OUTPUT_FORCE_READY(iSlink) <= tmp_gt_link_configuration(2);        
    SLINK_LSC_TOSENDARREAV(iSlink) <= tmp_gt_link_configuration(3);
    SLINK_LSC_GT_TXPOSTCURSOR(iSlink) <= tmp_gt_link_configuration(8 downto 4);
    SLINK_LSC_GT_TXPRECURSOR(iSlink) <= tmp_gt_link_configuration(13 downto 9);
    
    process (CLK50, configurable_parameter_reset)
    begin
      if (configurable_parameter_reset='1') then
        tmp_gt_link_configuration <= (others => '0');
      elsif (CLK50'event and CLK50='1') then
        gt_link_configuration_read(gt_lanes) <= tmp_gt_link_configuration;
        if ((selected_gt_link_lane_id=gt_lanes) and
            (buf_gt_link_configuration_wen(0)='1')) then
          tmp_gt_link_configuration <= buf_gt_link_configuration;
        end if;
      end if;
    end process;

    spy_write_clock(spy_slink_lane) <= MAIN_CLK;
    process (spy_write_clock(spy_slink_lane), buf_spy_controller(0))
    begin
      if (buf_spy_controller(0)='1') then
        spy_din(spy_slink_lane) <= (others => '0');
        spy_wen(spy_slink_lane) <= '0';
        spy_din_r1 <= (others => '0');
        spy_wen_r1 <= '0';
        spy_din_r2 <= (others => '0');
        spy_wen_r2 <= '0';
        spy_din_r3 <= (others => '0');
        spy_wen_r3 <= '0';
      elsif (spy_write_clock(spy_slink_lane)'event and spy_write_clock(spy_slink_lane)='1') then
        spy_din_r1 <= SLINK_LSC_UD(iSlink);
        spy_wen_r1 <= (not SLINK_LSC_UWEN_N(iSlink));
        spy_din_r2 <= spy_din_r1;
        spy_wen_r2 <= spy_wen_r1;
        spy_din_r3 <= spy_din_r2;
        spy_wen_r3 <= spy_wen_r2;
        spy_din(spy_slink_lane) <= spy_din_r3;
        spy_wen(spy_slink_lane) <= spy_wen_r3;
      end if;
    end process;

    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(spy_slink_lane) <= (others=>'0');
        ctrl_word_counters(spy_slink_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if ((not SLINK_LSC_UWEN_N(iSlink))='1') then
          if SLINK_LSC_UCTRL_N(iSlink)='1' then
            data_word_counters(spy_slink_lane) <= data_word_counters(spy_slink_lane) + 1;
          else
            ctrl_word_counters(spy_slink_lane) <= ctrl_word_counters(spy_slink_lane) + 1;
          end if;
        end if;
      end if;
    end process;
    
    gt_link_monitor_array(gt_lanes)(0) <= SLINK_LSC_GT_RXBYTEISALIGNED(iSlink);
    gt_link_monitor_array(gt_lanes)(1) <= SLINK_LSC_GT_TX_RESET_DONE(iSlink);
    gt_link_monitor_array(gt_lanes)(2) <= SLINK_LSC_GT_RX_RESET_DONE(iSlink);
    gt_link_monitor_array(gt_lanes)(3) <= SLINK_LSC_GT_PLL_LOCK(iSlink);
    gt_link_monitor_array(gt_lanes)(4) <= SLINK_LSC_TESTLED_N(iSlink);
    gt_link_monitor_array(gt_lanes)(5) <= SLINK_LSC_LDERRLED_N(iSlink);
    gt_link_monitor_array(gt_lanes)(6) <= SLINK_LSC_LUPLED_N(iSlink);
    gt_link_monitor_array(gt_lanes)(7) <= SLINK_LSC_FLOWCTLLED_N(iSlink);
    gt_link_monitor_array(gt_lanes)(8) <= SLINK_LSC_ACTIVITYLED_N(iSlink);
    
    lrl_array(gt_lanes) <= SLINK_LSC_LRL(iSlink);

    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_slink_r1 <= not SLINK_LSC_LFF_N(iSlink);
        xoff_slink_r2 <= xoff_slink_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(spy_slink_lane) <= (others => '0');
        xoff_monitors(spy_slink_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(spy_slink_lane)(0) <= xoff_slink_r2;
        if (xoff_slink_r1='1' and xoff_slink_r2='0') then
          if (and_reduce(xoff_counters(spy_slink_lane))='0') then
            xoff_counters(spy_slink_lane) <= xoff_counters(spy_slink_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;  
  
  INTERNALLINK_LANES : for iLink in 0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 generate
    signal tmp_gt_link_configuration : std_logic_vector(31 downto 0) := (others => '0');
    constant gt_lanes : integer := iLink +
                                   NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES;
    constant counter_lane_id_for_bert : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                                   num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                                   num_fpga_for_each_mainfpga   +
                                                   NUMBER_OF_ODO_IN_LANES +
                                                   NUMBER_OF_ILO_IN_LANES +
                                                   NROW_32X32_SWITCH_MATRIX + --output_switch_in
                                                   NROW_32X32_SWITCH_MATRIX + --output_switch_out
                                                   NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --event_soter_in
                                                   NROW_32X32_SWITCH_MATRIX + --central_switch_out
                                                   NROW_32X32_SWITCH_MATRIX + --il_outputport_switch_in
                                                   NROW_32X32_SWITCH_MATRIX + --il_outputport_switch_out
                                                   NUMBER_OF_GT_FOR_INTERNALLINK_LANES +
                                                   NUMBER_OF_FMC_INPUT_LANES +
                                                   NUMBER_OF_FMC_INPUT_LANES +
                                                   1 + 
                                                   NUMBER_OF_GT_FOR_INTERNALLINK_LANES + 
                                                   iLink;
  begin
    INTERNALLINK_GT_RXPOLARITY(iLink) <= tmp_gt_link_configuration(0);
    INTERNALLINK_GT_TXPOLARITY(iLink) <= tmp_gt_link_configuration(1);
    INTERNALLINK_FORCE_READY(iLink)   <= tmp_gt_link_configuration(2);
    
    process (CLK50, configurable_parameter_reset)
    begin
      if (configurable_parameter_reset='1') then
        tmp_gt_link_configuration <= (others => '0');
      elsif (CLK50'event and CLK50='1') then
        gt_link_configuration_read(gt_lanes) <= tmp_gt_link_configuration;
        if ((selected_gt_link_lane_id=gt_lanes) and
            (buf_gt_link_configuration_wen(0)='1')) then
          tmp_gt_link_configuration <= buf_gt_link_configuration;
        end if;
      end if;
    end process;
    
    gt_link_monitor_array(gt_lanes)(0) <= INTERNALLINK_GT_RXBYTEISALIGNED(iLink);
    gt_link_monitor_array(gt_lanes)(1) <= INTERNALLINK_GT_TX_RESET_DONE(iLink);
    gt_link_monitor_array(gt_lanes)(2) <= INTERNALLINK_GT_RX_RESET_DONE(iLink);
    gt_link_monitor_array(gt_lanes)(3) <= INTERNALLINK_GT_PLL_LOCK(iLink);
    gt_link_monitor_array(gt_lanes)(4) <= '1';
    gt_link_monitor_array(gt_lanes)(5) <= '1';
    gt_link_monitor_array(gt_lanes)(6) <= '1';
    gt_link_monitor_array(gt_lanes)(7) <= '1';
    gt_link_monitor_array(gt_lanes)(8) <= '1';
    gt_link_monitor_array(gt_lanes)(9) <= INTERNALLINK_RX_BERT_COMPARISON_VALID(iLink);
    
    data_word_counters(counter_lane_id_for_bert) <= INTERNALLINK_RX_BERT_TOTAL_COUNT(iLink);
    ctrl_word_counters(counter_lane_id_for_bert) <= INTERNALLINK_RX_BERT_ERROR_COUNT(iLink);
    
    lrl_array(gt_lanes)(3 downto 0) <= INTERNALLINK_RX_LRL(iLink);
    
    INTERNALLINK_TX_URL(iLink)      <= buf_internal_link_url(3 downto 0);
    INTERNALLINK_RX_BERT_COUNTER_RESET(iLink) <= buf_reset(8);
    
    INTERNALLINK_RX_ENABLE(iLink)  <= buf_internal_link_rx_enable(iLink);
    INTERNALLINK_TX_ENABLE(iLink)  <= buf_internal_link_tx_enable(iLink);    
    INTERNALLINK_RX_ENABLE_BERT(iLink) <= buf_internal_link_rx_enable_bert(iLink);
    INTERNALLINK_TX_ENABLE_BERT(iLink) <= buf_internal_link_tx_enable_bert(iLink);    
    
  end generate;

  ODO_WORD_COUNTER : for iLane in 0 to NUMBER_OF_ODO_IN_LANES-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if ODOIN_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not ODOIN_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;
  
  ILO_WORD_COUNTER : for iLane in 0 to NUMBER_OF_ILO_IN_LANES-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if ILOIN_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not ILOIN_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;
  
  OUTPUT_SWITCH_IN_WORD_COUNTER : for iLane in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if OUTPUT_SWITCH_IN_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not OUTPUT_SWITCH_IN_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;

  OUTPUT_SWITCH_OUT_WORD_COUNTER : for iLane in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if OUTPUT_SWITCH_OUT_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not OUTPUT_SWITCH_OUT_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;
  
  EVENT_SORTER_IN_WORD_COUNTER : for iLane in 0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if EVENT_SORTER_IN_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not EVENT_SORTER_IN_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;  

  CENTRAL_SWITCH_OUT_WORD_COUNTER : for iLane in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if CENTRAL_SWITCH_OUT_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not CENTRAL_SWITCH_OUT_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;
  
  INTERNALLINK_OUTPUT_SWITCH_IN_WORD_COUNTER : for iLane in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if INTERNALLINK_OUTPUT_SWITCH_IN_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not INTERNALLINK_OUTPUT_SWITCH_IN_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;
  
  INTERNALLINK_OUTPUT_SWITCH_OUT_WORD_COUNTER : for iLane in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                       NROW_32X32_SWITCH_MATRIX +                                       
                                       NROW_32X32_SWITCH_MATRIX +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if INTERNALLINK_OUTPUT_SWITCH_OUT_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not INTERNALLINK_OUTPUT_SWITCH_OUT_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;  
  
  ILOOUT_WORD_COUNTER : for iLane in 0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                       NROW_32X32_SWITCH_MATRIX +                                       
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if ILOOUT_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not ILOOUT_RDY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;

  INPUT_SWITCH_WORD_COUNTER : for iLane in 0 to NUMBER_OF_FMC_INPUT_LANES-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                       NROW_32X32_SWITCH_MATRIX +                                       
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_INTERNALLINK_LANES + 
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if MODDATA_WEN_SWITCH_IN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= not MODDATA_RDY_SWITCH_IN_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;
  
  INPUT_EVENT_COUNTER_MONITOR : for iLane in 0 to NUMBER_OF_FMC_INPUT_LANES-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                       NROW_32X32_SWITCH_MATRIX +                                       
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_INTERNALLINK_LANES +
                                       NUMBER_OF_FMC_INPUT_LANES +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    -- FOR SPYBUFFER CH0 -- counter
    data_word_counters(counter_lane) <= IDO_INTERNAL_EVENT_COUNTER(iLane);
    ctrl_word_counters(counter_lane) <= (others=>'0');
    xoff_counters(counter_lane) <= (others => '0');
    xoff_monitors(counter_lane) <= (others => '0');
  end generate;  

  IDOOUT_FRAME_WORD_COUNTER : for iLane in 0 to 0 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                       NROW_32X32_SWITCH_MATRIX +                                       
                                       NROW_32X32_SWITCH_MATRIX +
                                       NROW_32X32_SWITCH_MATRIX +
                                       NUMBER_OF_GT_FOR_INTERNALLINK_LANES +
                                       NUMBER_OF_FMC_INPUT_LANES +
                                       NUMBER_OF_FMC_INPUT_LANES +
                                       iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;
  begin
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if (IDOOUT_FRAME_WEN_MONITOR='1') then
          if IDOOUT_FRAME_CTRL_MONITOR='0' then
            data_word_counters(counter_lane) <= data_word_counters(counter_lane) + 1;
          else
            ctrl_word_counters(counter_lane) <= ctrl_word_counters(counter_lane) + 1;
          end if;
        end if;
      end if;
    end process;
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= IDOOUT_FRAME_XOFF_MONITOR;
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;
  
  ILIOUT_WORD_COUNTER : for iLane in 0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 generate
    constant counter_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --LSC
                                       num_fpga_for_each_mainfpga*2 + -- encoded-fmcin-out
                                       num_fpga_for_each_mainfpga   +
                                       NUMBER_OF_ODO_IN_LANES +
                                       NUMBER_OF_ILO_IN_LANES +
                                       NROW_32X32_SWITCH_MATRIX + --output_switch_in
                                       NROW_32X32_SWITCH_MATRIX + --output_switch_out
                                       NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES + --event_soter_in
                                       NROW_32X32_SWITCH_MATRIX + --central_switch_out
                                       NROW_32X32_SWITCH_MATRIX + --il_outputport_switch_in
                                       NROW_32X32_SWITCH_MATRIX + --il_outputport_switch_out
                                       NUMBER_OF_GT_FOR_INTERNALLINK_LANES +
                                       NUMBER_OF_FMC_INPUT_LANES +
                                       NUMBER_OF_FMC_INPUT_LANES +
                                       1 + -- Frame_path_monitoring_(IDO-SLINK_PACKER)
                                       iLane;
    --constant spy_lane : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
    --                               num_fpga_for_each_mainfpga*2 +
    --                               num_fpga_for_each_mainfpga +
    --                               iLane;
    signal xoff_r1 : std_logic;
    signal xoff_r2 : std_logic;

    --signal spy_din_r1 : std_logic_vector(31 downto 0);
    --signal spy_wen_r1 : std_logic;

    --signal spy_din_r2 : std_logic_vector(31 downto 0);
    --signal spy_wen_r2 : std_logic;
    
    --signal spy_din_r3 : std_logic_vector(31 downto 0);
    --signal spy_wen_r3 : std_logic;    
  begin

    --SPY_CLOCK_ASSIGNMENT : if SAMPLE_INTERNALLINK_INPUT = '1' generate
    --begin
    --  spy_write_clock(spy_lane) <= MAIN_CLK;
    --end generate;

    --SPY_CLOCK_ASSIGNMENT_NOUSE : if SAMPLE_INTERNALLINK_INPUT = '0' generate
    --begin
    --  spy_write_clock(spy_lane) <= '0';
    --end generate;
    
    --process (spy_write_clock(spy_lane), buf_spy_controller(0))
    --begin
    --  if (buf_spy_controller(0)='1') then
    --    spy_din(spy_lane) <= (others => '0');
    --    spy_wen(spy_lane) <= '0';
    --    spy_din_r1 <= (others => '0');
    --    spy_wen_r1 <= '0';
    --    spy_din_r2 <= (others => '0');
    --    spy_wen_r2 <= '0';
    --    spy_din_r3 <= (others => '0');
    --    spy_wen_r3 <= '0';
    --  elsif (spy_write_clock(spy_lane)'event and spy_write_clock(spy_lane)='1') then
    --    spy_din_r1 <= ILIOUT_DATA_MONITOR(iLane);
    --    spy_wen_r1 <= ILIOUT_DEN_MONITOR(iLane);
    --    spy_din_r2 <= spy_din_r1;
    --    spy_wen_r2 <= spy_wen_r1;
    --    spy_din_r3 <= spy_din_r2;
    --    spy_wen_r3 <= spy_wen_r2;
    --    spy_din(spy_lane) <= spy_din_r3;
    --    spy_wen(spy_lane) <= spy_wen_r3;
    --  end if;
    --end process;    
    
    -- FOR SPYBUFFER CH0 -- counter
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        data_word_counters(counter_lane) <= (others=>'0');
        ctrl_word_counters(counter_lane) <= (others=>'0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        if ILIOUT_DEN_MONITOR(iLane)='1' then
          data_word_counters(counter_lane)   <= data_word_counters(counter_lane)+1;
        end if;
      end if;
    end process;    
    
    -----------------------------------
    -- DFF XOFF
    -----------------------------------
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_r1 <= ILIOUT_BUSY_MONITOR(iLane);
        xoff_r2 <= xoff_r1;
      end if;
    end process;
    
    -----------------------------------
    -- XOFF COUNTER
    -----------------------------------
    process (MAIN_CLK, counter_parameter_reset)
    begin
      if (counter_parameter_reset='1') then
        xoff_counters(counter_lane) <= (others => '0');
        xoff_monitors(counter_lane) <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        xoff_monitors(counter_lane)(0) <= xoff_r2;
        if (xoff_r1='1' and xoff_r2='0') then
          if (and_reduce(xoff_counters(counter_lane))='0') then
            xoff_counters(counter_lane) <= xoff_counters(counter_lane) + 1;
          else
            NULL;
          end if;
        end if;
      end if;
    end process;
  end generate;

  -------------------------------------------
  -- For debugging purpose (January 2015)
  -------------------------------------------
  INTERNAL_LINK_TEPORALLY_SPY : if SAMPLE_INTERNALLINK_INPUT = '1' generate
    constant spy_lane0 : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                    num_fpga_for_each_mainfpga*2 +
                                    num_fpga_for_each_mainfpga + 0;
    constant spy_lane1 : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                    num_fpga_for_each_mainfpga*2 +
                                    num_fpga_for_each_mainfpga + 1;
    constant spy_lane2 : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                    num_fpga_for_each_mainfpga*2 +
                                    num_fpga_for_each_mainfpga + 2;
    constant spy_lane3 : integer := NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES +
                                    num_fpga_for_each_mainfpga*2 +
                                    num_fpga_for_each_mainfpga + 3;    
    signal spy_din_r1_0 : std_logic_vector(31 downto 0);
    signal spy_wen_r1_0 : std_logic;
    
    signal spy_din_r2_0 : std_logic_vector(31 downto 0);
    signal spy_wen_r2_0 : std_logic;
    
    signal spy_din_r3_0 : std_logic_vector(31 downto 0);
    signal spy_wen_r3_0 : std_logic;        
    
    signal spy_din_r1_1 : std_logic_vector(31 downto 0);
    signal spy_wen_r1_1 : std_logic;
    
    signal spy_din_r2_1 : std_logic_vector(31 downto 0);
    signal spy_wen_r2_1 : std_logic;
    
    signal spy_din_r3_1 : std_logic_vector(31 downto 0);
    signal spy_wen_r3_1 : std_logic;
    
    signal spy_din_r1_2 : std_logic_vector(31 downto 0);
    signal spy_wen_r1_2 : std_logic;
    
    signal spy_din_r2_2 : std_logic_vector(31 downto 0);
    signal spy_wen_r2_2 : std_logic;
    
    signal spy_din_r3_2 : std_logic_vector(31 downto 0);
    signal spy_wen_r3_2 : std_logic;

    signal spy_din_r1_3 : std_logic_vector(31 downto 0);
    signal spy_wen_r1_3 : std_logic;
    
    signal spy_din_r2_3 : std_logic_vector(31 downto 0);
    signal spy_wen_r2_3 : std_logic;
    
    signal spy_din_r3_3 : std_logic_vector(31 downto 0);
    signal spy_wen_r3_3 : std_logic;        
  begin
    spy_write_clock(spy_lane0) <= MAIN_CLK;
    spy_write_clock(spy_lane1) <= MAIN_CLK;
    spy_write_clock(spy_lane2) <= MAIN_CLK;
    spy_write_clock(spy_lane3) <= MAIN_CLK;    
    
    process (spy_write_clock(spy_lane0), buf_spy_controller(0))
    begin
      if (buf_spy_controller(0)='1') then
        spy_din(spy_lane0) <= (others => '0');
        spy_wen(spy_lane0) <= '0';
        spy_din_r1_0 <= (others => '0');
        spy_wen_r1_0 <= '0';
        spy_din_r2_0 <= (others => '0');
        spy_wen_r2_0 <= '0';
        spy_din_r3_0 <= (others => '0');
        spy_wen_r3_0 <= '0';
      elsif (spy_write_clock(spy_lane0)'event and spy_write_clock(spy_lane0)='1') then
        spy_din_r1_0 <= ILIOUT_DATA_MONITOR(ilink_spy_rx_monitoring);
        spy_wen_r1_0 <= ILIOUT_DEN_MONITOR(ilink_spy_rx_monitoring);
        spy_din_r2_0 <= spy_din_r1_0;
        spy_wen_r2_0 <= spy_wen_r1_0;
        spy_din_r3_0 <= spy_din_r2_0;
        spy_wen_r3_0 <= spy_wen_r2_0;
        spy_din(spy_lane0) <= spy_din_r3_0;
        spy_wen(spy_lane0) <= spy_wen_r3_0;
      end if;
    end process;    
    
    process (spy_write_clock(spy_lane1), buf_spy_controller(0))
    begin
      if (buf_spy_controller(0)='1') then
        spy_din(spy_lane1) <= (others => '0');
        spy_wen(spy_lane1) <= '0';
        spy_din_r1_1 <= (others => '0');
        spy_wen_r1_1 <= '0';
        spy_din_r2_1 <= (others => '0');
        spy_wen_r2_1 <= '0';
        spy_din_r3_1 <= (others => '0');
        spy_wen_r3_1 <= '0';
      elsif (spy_write_clock(spy_lane1)'event and spy_write_clock(spy_lane1)='1') then
        spy_din_r1_1 <= ILIOUT_DATA_MONITOR(ilink_spy_rx_monitoring+12);
        spy_wen_r1_1 <= ILIOUT_DEN_MONITOR(ilink_spy_rx_monitoring+12);
        spy_din_r2_1 <= spy_din_r1_1;
        spy_wen_r2_1 <= spy_wen_r1_1;
        spy_din_r3_1 <= spy_din_r2_1;
        spy_wen_r3_1 <= spy_wen_r2_1;
        spy_din(spy_lane1) <= spy_din_r3_1;
        spy_wen(spy_lane1) <= spy_wen_r3_1;
      end if;
    end process;

    process (spy_write_clock(spy_lane2), buf_spy_controller(0))
    begin
      if (buf_spy_controller(0)='1') then
        spy_din(spy_lane2) <= (others => '0');
        spy_wen(spy_lane2) <= '0';
        spy_din_r1_2 <= (others => '0');
        spy_wen_r1_2 <= '0';
        spy_din_r2_2 <= (others => '0');
        spy_wen_r2_2 <= '0';
        spy_din_r3_2 <= (others => '0');
        spy_wen_r3_2 <= '0';
      elsif (spy_write_clock(spy_lane2)'event and spy_write_clock(spy_lane2)='1') then
        spy_din_r1_2 <= ILOOUT_DATA_MONITOR(ilink_spy_tx_monitoring);
        spy_wen_r1_2 <= ILOOUT_DEN_MONITOR(ilink_spy_tx_monitoring);
        spy_din_r2_2 <= spy_din_r1_2;
        spy_wen_r2_2 <= spy_wen_r1_2;
        spy_din_r3_2 <= spy_din_r2_2;
        spy_wen_r3_2 <= spy_wen_r2_2;
        spy_din(spy_lane2) <= spy_din_r3_2;
        spy_wen(spy_lane2) <= spy_wen_r3_2;
      end if;
    end process;

    process (spy_write_clock(spy_lane3), buf_spy_controller(0))
    begin
      if (buf_spy_controller(0)='1') then
        spy_din(spy_lane3) <= (others => '0');
        spy_wen(spy_lane3) <= '0';
        spy_din_r1_3 <= (others => '0');
        spy_wen_r1_3 <= '0';
        spy_din_r2_3 <= (others => '0');
        spy_wen_r2_3 <= '0';
        spy_din_r3_3 <= (others => '0');
        spy_wen_r3_3 <= '0';
      elsif (spy_write_clock(spy_lane3)'event and spy_write_clock(spy_lane3)='1') then
        spy_din_r1_3 <= ILOOUT_DATA_MONITOR(ilink_spy_tx_monitoring+12);
        spy_wen_r1_3 <= ILOOUT_DEN_MONITOR(ilink_spy_tx_monitoring+12);
        spy_din_r2_3 <= spy_din_r1_3;
        spy_wen_r2_3 <= spy_wen_r1_3;
        spy_din_r3_3 <= spy_din_r2_3;
        spy_wen_r3_3 <= spy_wen_r2_3;
        spy_din(spy_lane3) <= spy_din_r3_3;
        spy_wen(spy_lane3) <= spy_wen_r3_3;
      end if;
    end process;    
  end generate;
    




  
    
  ----------------------------------------------
  FMCIN_CONFIG_DELAY_RESET       <=buf_reset(0); -- delay reset
  FMCIN_CONFIG_FIFO_RESET        <=buf_reset(1); -- disable input
  FMCIN_CONFIG_CLOCK_SYNC_RESET  <=buf_reset(2); -- parity check reset
  FMCIN_CONFIG_FRAME_RESET       <=buf_reset(3);
  ----------------------------------------------
  INTERNALLINK_INPUT_BUFFER_RESET<=buf_reset(4);
  FMCIN_BUFFER_CONFIG_RESET      <=buf_reset(4);
  INPUT_LUT_RESET                <=buf_reset(4);
  INPUT_SINGLE_SWITCH_RESET      <=buf_reset(4);
  ODO_FTKPLANE_WORD_ADDER_RESET  <=buf_reset(4);
  ODO_OUTPUT_SWITCH_MERGER_RESET <=buf_reset(4);
  ODO_OUTPUT_SWITCH_RESET        <=buf_reset(4);
  ODO_DUPLICATOR_RESET           <=buf_reset(4);
  ODO_SLINK_PACKER_RESET         <=buf_reset(4);
  CENTRAL_SWITCH_RESET           <=buf_reset(4);
  INTERNALLINK_BUFFER_CLR        <=buf_reset(4); -- for clock domain crossing buffer
  INTERNALLINK_DESTINATION_WORD_ADDER_RESET   <=buf_reset(4);
  INTERNALLINK_DESTINATION_WORD_REMOVER_RESET <=buf_reset(4);
  ----------------------------------------------
  
  configurable_parameter_reset <= buf_reset(6);
  counter_parameter_reset      <= buf_reset(7);
  -- buf_reset(8) is used for internal link bert counter reset
  
  --
  register_ipaddress : my_readonly_register port map
    (d=>ip_addr, dout=>reg_from_slave(addr_ipaddress));
  
  --
  register_reset : my_writable_register port map
    (q=>buf_reset, din=>reg_from_master(addr_reset),
     dout=>reg_from_slave(addr_reset));

  --
  register_fmc_fifo_full : my_readonly_register port map
    (d=>buf_fmc_fifo_full, dout=>reg_from_slave(addr_fmc_fifo_full));

  --
  register_fmc_patcheck : my_readonly_register port map
    (d=>buf_fmc_patcheck, dout=>reg_from_slave(addr_fmc_patcheck));
 
  --
  register_fmc_patcheck_persis : my_readonly_register port map
    (d=>buf_fmc_patcheck_persis, dout=>reg_from_slave(addr_fmc_patcheck_persis)); 
  
  --
  register_fmc_fifo_error : my_readonly_register port map
    (d=>buf_fmc_fifo_error, dout=>reg_from_slave(addr_fmc_fifo_error));
  
  --
  register_fmc_sync_done : my_readonly_register port map
    (d=>buf_fmc_sync_done, dout=>reg_from_slave(addr_fmc_sync_done));
  
  --
  register_fmc_sync_error : my_readonly_register port map
    (d=>buf_fmc_sync_error, dout=>reg_from_slave(addr_fmc_sync_error));
  
  --
  register_input_buffer_full : my_readonly_register port map
    (d=>buf_input_buffer_full, dout=>reg_from_slave(addr_input_buffer_full));

  --
  register_input_buffer_xoff : my_readonly_register port map
    (d=>buf_input_buffer_xoff, dout=>reg_from_slave(addr_input_buffer_xoff));
  
  
  -- FMC DELAY
  register_fmc_config_clk_inv: my_writable_register port map
    (q=>buf_fmc_config_clk_inv, din=>reg_from_master(addr_fmc_config_clk_inv),
     dout=>reg_from_slave(addr_fmc_config_clk_inv));
  
  register_fmc_config_clkdelay_ce: my_pulse_generator
    port map (
      refclk=>DELAY_REFCLK, q=>buf_fmc_config_clkdelay_ce, 
      din=>reg_from_master(addr_fmc_config_clkdelay_ce),
      dout=>reg_from_slave(addr_fmc_config_clkdelay_ce));
  
  channeldelay_channel_selector_fpga_id <= CONV_INTEGER(buf_fmc_config_channeldelay_channel_selector(7 downto 5));
  channeldelay_channel_selector_chan_id <= CONV_INTEGER(buf_fmc_config_channeldelay_channel_selector(4 downto 0));
  register_fmc_config_channeldelay_channel_selector: my_writable_register port map
    (q=>buf_fmc_config_channeldelay_channel_selector, din=>reg_from_master(addr_fmc_config_channeldelay_channel_selector),
     dout=>reg_from_slave(addr_fmc_config_channeldelay_channel_selector));
  
  register_fmc_config_channeldelay_ce: my_pulse_generator
    port map (
      refclk=>DELAY_REFCLK, q=>buf_fmc_config_channeldelay_ce, 
      din=>reg_from_master(addr_fmc_config_channeldelay_ce),
      dout=>reg_from_slave(addr_fmc_config_channeldelay_ce));
  
  CHANNELDELAY_OUTPUT_FPGAS : for iFpgaOnIM in 0 to num_fpga_for_each_mainfpga-1 generate
  begin
    CHANNELDELAY_OUTPUT_CHANS : for iChan in lvds_pairs_for_rx_in_each_fpga-1 downto 0 generate
      process (DELAY_REFCLK)
      begin
        if (DELAY_REFCLK'event and DELAY_REFCLK='1') then
          if (iChan=channeldelay_channel_selector_chan_id and iFpgaOnIM=channeldelay_channel_selector_fpga_id) then
            FMCIN_CONFIG_CHANNELDELAY_CE(iFpgaOnIM)(iChan) <= buf_fmc_config_channeldelay_ce(0);
          else
            FMCIN_CONFIG_CHANNELDELAY_CE(iFpgaOnIM)(iChan) <= '0';
          end if;
        end if;
      end process;
    end generate;
  end generate;
  
  ENABLE_FMC_LANES_MASK <= buf_enable_fmc_lanes_mask(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);  
  register_enable_fmc_lanes_mask: my_writable_register port map
    (q=>buf_enable_fmc_lanes_mask, din=>reg_from_master(addr_enable_fmc_lanes_mask),
     dout=>reg_from_slave(addr_enable_fmc_lanes_mask));
  
  INPUT_LUT_FRAME_DOUT_LANEID <=  0  when (buf_enable_fmc_lanes_mask(0)='1') else
                                  1  when (buf_enable_fmc_lanes_mask(1)='1') else
                                  2  when (buf_enable_fmc_lanes_mask(2)='1') else
                                  3  when (buf_enable_fmc_lanes_mask(3)='1') else
                                  4  when (buf_enable_fmc_lanes_mask(4)='1') else
                                  5  when (buf_enable_fmc_lanes_mask(5)='1') else
                                  6  when (buf_enable_fmc_lanes_mask(6)='1') else
                                  7  when (buf_enable_fmc_lanes_mask(7)='1') else
                                  8  when (buf_enable_fmc_lanes_mask(8)='1') else
                                  9  when (buf_enable_fmc_lanes_mask(9)='1') else
                                  10 when (buf_enable_fmc_lanes_mask(10)='1') else
                                  11 when (buf_enable_fmc_lanes_mask(11)='1') else
                                  12 when (buf_enable_fmc_lanes_mask(12)='1') else
                                  13 when (buf_enable_fmc_lanes_mask(13)='1') else
                                  14 when (buf_enable_fmc_lanes_mask(14)='1') else
                                  15 when (buf_enable_fmc_lanes_mask(15)='1') else
                                  0;
  
  INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_IDO <= buf_input_single_switch_this_board_mask_ido;
  register_input_single_switch_this_board_mask_ido: my_writable_register port map
    (q=>buf_input_single_switch_this_board_mask_ido,
     din=>reg_from_master(addr_input_single_switch_this_board_mask_ido),
     dout=>reg_from_slave(addr_input_single_switch_this_board_mask_ido));
  
  INPUT_SINGLE_SWITCH_THIS_BOARD_MASK_ILI <= buf_input_single_switch_this_board_mask_ili;
  register_input_single_switch_this_board_mask_ili: my_writable_register port map
    (q=>buf_input_single_switch_this_board_mask_ili,
     din=>reg_from_master(addr_input_single_switch_this_board_mask_ili),
     dout=>reg_from_slave(addr_input_single_switch_this_board_mask_ili));  
  
  register_internal_link_url: my_writable_register port map
    (q=>buf_internal_link_url,
     din=>reg_from_master(addr_internal_link_url),
     dout=>reg_from_slave(addr_internal_link_url));
  
  register_internal_link_rx_enable: my_writable_register port map
    (q=>buf_internal_link_rx_enable,
     din=>reg_from_master(addr_internal_link_rx_enable),
     dout=>reg_from_slave(addr_internal_link_rx_enable));
  
  register_internal_link_tx_enable: my_writable_register port map
    (q=>buf_internal_link_tx_enable,
     din=>reg_from_master(addr_internal_link_tx_enable),
     dout=>reg_from_slave(addr_internal_link_tx_enable));

  register_internal_link_rx_enable_bert: my_writable_register port map
    (q=>buf_internal_link_rx_enable_bert,
     din=>reg_from_master(addr_internal_link_rx_enable_bert),
     dout=>reg_from_slave(addr_internal_link_rx_enable_bert));

  register_internal_link_tx_enable_bert: my_writable_register port map
    (q=>buf_internal_link_tx_enable_bert,
     din=>reg_from_master(addr_internal_link_tx_enable_bert),
     dout=>reg_from_slave(addr_internal_link_tx_enable_bert));    
  
  --
  INPUT_LANE_EXPECTED_NUM_MODULE : for iLane in DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY'range generate
    signal buf_expected_num_of_module_integer : integer := 8;
    constant ThisLaneId : integer := iLane;
  begin
    INPUT_LUT_EXPECTED_NUM_OF_MODULE(iLane) <= buf_expected_num_of_module_integer;
    process (CLK50, configurable_parameter_reset)
    begin
      if (configurable_parameter_reset='1') then
        buf_expected_num_of_module_integer <= 8; -- tmp
      elsif (CLK50'event and CLK50='1') then
        if ((CONV_INTEGER(buf_switching_configuration_lane_selector)=ThisLaneId) and (buf_update_switching_configuration_enable(0)='1')) then
          buf_expected_num_of_module_integer <= CONV_INTEGER(buf_expected_num_of_module);
        else
          NULL;
        end if;
      end if;
    end process;
  end generate;
  
  OUTPUT_EXPECTED_MODULES : for iLane in ODO_SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES'range generate
    signal buf_expected_num_of_module_integer : integer := 8;
    constant ThisLaneId : integer := iLane;
  begin
    ODO_SLINK_PACKER_NUMBER_OF_EXPECTED_MODULES(iLane) <= buf_expected_num_of_module_integer;
    process (CLK50, configurable_parameter_reset)
    begin
      if (configurable_parameter_reset='1') then
        buf_expected_num_of_module_integer <= 16; -- tmp
      elsif (CLK50'event and CLK50='1') then
        if ((CONV_INTEGER(buf_switching_configuration_lane_selector)=ThisLaneId) and (buf_update_switching_configuration_enable(1)='1')) then
          buf_expected_num_of_module_integer <= CONV_INTEGER(buf_expected_num_of_module);
        else
          NULL;
        end if;        
      end if;
    end process;
  end generate;
  
  register_internallink_destination_words: my_writable_register port map
    (q=>buf_internallink_destination_words,
     din=>reg_from_master(addr_internallink_destination_words),
     dout=>reg_from_slave(addr_internallink_destination_words));
  
  CENTRAL_SWITCH_OUTPUT_LANES : for iLane in 0 to NUMBER_OF_CENTRALSWITCH_OUTPUT_LANES-1 generate
    signal tmp_buffer : std_logic_vector(31 downto 0) := (others => '0');
    constant ThisLaneId : integer := iLane;    
  begin
    INTERNALLINK_DESTINATION_WORDS(iLane) <= tmp_buffer;
    process (CLK50, configurable_parameter_reset)
    begin
      if (configurable_parameter_reset='1') then
        tmp_buffer <= (others => '0');
      elsif (CLK50'event and CLK50='1') then
        if ((CONV_INTEGER(buf_switching_configuration_lane_selector)=ThisLaneId) and
            (buf_update_switching_configuration_enable(2)='1')) then
          tmp_buffer <= buf_internallink_destination_words;
        else
          NULL;
        end if;
      end if;
    end process;
  end generate;
  
  register_expected_num_of_module: my_writable_register port map
    (q=>buf_expected_num_of_module, din=>reg_from_master(addr_expected_num_of_module),
     dout=>reg_from_slave(addr_expected_num_of_module));
  
  register_switching_configuration_lane_selector: my_writable_register port map
    (q=>buf_switching_configuration_lane_selector, din=>reg_from_master(addr_switching_configuration_lane_selector),
     dout=>reg_from_slave(addr_switching_configuration_lane_selector));
  
  register_addr_update_switching_configuration_enable: my_writable_register port map
    (q=>buf_update_switching_configuration_enable, din=>reg_from_master(addr_update_switching_configuration_enable),
     dout=>reg_from_slave(addr_update_switching_configuration_enable));
  
  --
  PLL_RESET           <= buf_gt_link_controller(0);
  TRANSCEIVER_RESET   <= buf_gt_link_controller(1);
  LINK_RESET          <= buf_gt_link_controller(2);
  SLINK_PATGEN_ENABLE <= buf_gt_link_controller(5);
  SLINK_PATGEN_RESET  <= buf_gt_link_controller(6);
  
  register_gt_link_controller : my_writable_register port map
    (q=>buf_gt_link_controller, din=>reg_from_master(addr_gt_link_controller),
     dout=>reg_from_slave(addr_gt_link_controller));
  
  -- =======================
  buf_spy_readout<=spy_dout(31 downto  0);
  
  spy_read_address <=buf_spy_readaddr(11 downto 0);
  spy_lane_selector<=buf_spy_laneselector(7 downto 0);
  
  register_spy_readout : my_readonly_register port map
    (d=>buf_spy_readout, dout=>reg_from_slave(addr_spy_readout));
  
  -- =======================
  register_spy_readaddr : my_writable_register port map
    (q=>buf_spy_readaddr, din=>reg_from_master(addr_spy_readaddr),
     dout=>reg_from_slave(addr_spy_readaddr));
  
  --
  register_spy_laneselector : my_writable_register port map
    (q=>buf_spy_laneselector, din=>reg_from_master(addr_spy_laneselector),
     dout=>reg_from_slave(addr_spy_laneselector));
  
  -- =======================
  register_spy_controller : my_writable_register port map
    (q=>buf_spy_controller, din=>reg_from_master(addr_spy_controller),
     dout=>reg_from_slave(addr_spy_controller));
  FMCOUT_CONFIG_SPY_FREEZE_TO_IM <= buf_spy_controller(1);
  
  --
  FMCOUT_CONFIG_MEZZANINE_RESET<=buf_fmc_user_signals(0);
  FMCOUT_CONFIG_USER_TRIGGER   <=buf_fmc_user_signals(1);
  register_fmc_user_signals : my_writable_register port map
    (q=>buf_fmc_user_signals, din=>reg_from_master(addr_fmc_user_signals),
     dout=>reg_from_slave(addr_fmc_user_signals));
  
  --
  INST_4K_SPY_BUFFER : if USE_4K_SPY_BUFFER = '1' generate
  begin
    spy_buffer : spy_buffer_multilanes_d4096_multi_clock_domain
      generic map ( numberOfLanes => spy_lane_size)
      port map (
        Reset  => buf_spy_controller(0),
        Freeze => buf_spy_controller(1),
        Wen  => spy_wen,
        Clk  => spy_write_clock,
        Din  => spy_din,
        Dout => spy_dout,
        LaneSelector => spy_lane_selector,
        ReadAddressBinary => spy_read_address
        );
  end generate;
  
  --
  INST_1K_SPY_BUFFER : if USE_4K_SPY_BUFFER = '0' generate
  begin
    spy_buffer : spy_buffer_multilanes_d1024_multi_clock_domain
      generic map ( numberOfLanes => spy_lane_size)
      port map (
        Reset  => buf_spy_controller(0),
        Freeze => buf_spy_controller(1),
        Wen  => spy_wen,
        Clk  => spy_write_clock,
        Din  => spy_din,
        Dout => spy_dout,
        LaneSelector => spy_lane_selector,
        ReadAddressBinary => spy_read_address(spybuffer_addr_width_d1024-1 downto 0)
        );
  end generate;
  
  -- =======================
  register_32bit_counter_lane_selector : my_writable_register port map
    (q=>buf_32bit_counter_lane_selector, din=>reg_from_master(addr_32bit_counter_lane_selector),
     dout=>reg_from_slave(addr_32bit_counter_lane_selector));
  
  register_32bit_counter : my_readonly_register port map
    (d=>selected_32bit_counter, dout=>reg_from_slave(addr_32bit_counter));
  
  -- MONITORING DFF
  process (CLK50, buf_spy_controller(0))
  begin
    if buf_spy_controller(0)='1' then
      selected_32bit_counter_lane_id <= 0;
    elsif (CLK50'event and CLK50='1') then
      selected_32bit_counter_lane_id <= CONV_INTEGER(buf_32bit_counter_lane_selector(15 downto 0));
      
      if (buf_32bit_counter_lane_selector(18 downto 16)="000") then -- data
        selected_32bit_counter <= ctrl_word_counters(selected_32bit_counter_lane_id);
      elsif (buf_32bit_counter_lane_selector(18 downto 16)="001") then -- ctrl        
        selected_32bit_counter <= data_word_counters(selected_32bit_counter_lane_id);
      elsif (buf_32bit_counter_lane_selector(18 downto 16)="010") then -- XOFF
        selected_32bit_counter <= xoff_counters(selected_32bit_counter_lane_id);
      elsif (buf_32bit_counter_lane_selector(18 downto 16)="011") then -- XOFF
        selected_32bit_counter <= xoff_monitors(selected_32bit_counter_lane_id);        
      end if;
    end if;
  end process;
  
  -- =======================
  register_gt_link_monitor_configure_laneselector : my_writable_register port map
    (q=>buf_gt_link_monitor_configure_laneselector, din=>reg_from_master(addr_gt_link_monitor_configure_laneselector),
     dout=>reg_from_slave(addr_gt_link_monitor_configure_laneselector));
  
  register_gt_link_monitor : my_readonly_register port map
    (d=>buf_gt_link_monitor, dout=>reg_from_slave(addr_gt_link_monitor));
  
  register_gt_link_lrl_monitor : my_readonly_register port map
    (d=>buf_gt_link_lrl_monitor, dout=>reg_from_slave(addr_gt_link_lrl_monitor));  
  
  register_gt_link_configuration: my_writable_register port map
    (q=>buf_gt_link_configuration, din=>reg_from_master(addr_gt_link_configuration),
     dout=>reg_from_slave(addr_gt_link_configuration));
  
  register_gt_link_configuration_wen: my_writable_register port map
    (q=>buf_gt_link_configuration_wen, din=>reg_from_master(addr_gt_link_configuration_wen),
     dout=>reg_from_slave(addr_gt_link_configuration_wen));  
  
  register_gt_link_configuration_read : my_readonly_register port map
    (d=>buf_gt_link_configuration_read, dout=>reg_from_slave(addr_gt_link_configuration_read));
  
  process (CLK50)
  begin
    if (CLK50'event and CLK50='1') then
      buf_gt_link_configuration_read <= gt_link_configuration_read(selected_gt_link_lane_id);
    end if;
  end process;  
  
  -- MONITORING DFF
  process (CLK50, configurable_parameter_reset)
  begin
    if configurable_parameter_reset='1' then
      selected_gt_link_lane_id <= 0;
    elsif (CLK50'event and CLK50='1') then
      selected_gt_link_lane_id <= CONV_INTEGER(buf_gt_link_monitor_configure_laneselector(7 downto 0));
    end if;
  end process;
  
  process (CLK50)
  begin
    if (CLK50'event and CLK50='1') then
      buf_gt_link_monitor <= gt_link_monitor_array(selected_gt_link_lane_id);
      buf_gt_link_lrl_monitor(3 downto 0) <= lrl_array(selected_gt_link_lane_id);
    end if;
  end process;
  
  --=====================================================
  register_i2c_enable: my_writable_register port map
    (q=>buf_i2c_enable, din=>reg_from_master(addr_i2c_enable),
     dout=>reg_from_slave(addr_i2c_enable));
  
  register_i2c_status : my_readonly_register port map
    (d=>buf_i2c_status, dout=>reg_from_slave(addr_i2c_status));  
  
  --=====================================================
  register_fb_i2c_addr: my_writable_register port map
    (q=>buf_fb_i2c_addr, din=>reg_from_master(addr_fb_i2c_addr),
     dout=>reg_from_slave(addr_fb_i2c_addr));
  
  register_fb_i2c_data_from_master: my_writable_register port map
    (q=>buf_fb_i2c_data_from_master, din=>reg_from_master(addr_fb_i2c_data_from_master),
     dout=>reg_from_slave(addr_fb_i2c_data_from_master));  
  
  register_fb_i2c_data_from_slave : my_readonly_register port map
    (d=>buf_fb_i2c_data_from_slave, dout=>reg_from_slave(addr_fb_i2c_data_from_slave));
  
  i2c_master_fb : i2c_master
    port map (
      clk => MAIN_CLK, -- 150 MHz
      reset => buf_reset(5),
      ena => buf_i2c_enable(0), 
      addr => buf_fb_i2c_addr(6 downto 0),
      rw => buf_fb_i2c_addr(7),
      data_wr => buf_fb_i2c_data_from_master(7 downto 0),
      busy => buf_i2c_status(0),
      data_rd => buf_fb_i2c_data_from_slave(7 downto 0),
      ack_error => buf_i2c_status(1),
      sda => FB_SDA,
      scl => FB_SCL); -- 400 kHz
  
  --=====================================================
  register_lut_configuration_selector : my_writable_register port map
    (q=>buf_lut_configuration_selector, din=>reg_from_master(addr_lut_configuration_selector),
     dout=>reg_from_slave(addr_lut_configuration_selector));
  
  register_lut_configuration_addr_confin : my_writable_register port map
    (q=>buf_lut_configuration_addr_confin, din=>reg_from_master(addr_lut_configuration_addr_confin),
     dout=>reg_from_slave(addr_lut_configuration_addr_confin));
  
  register_lut_configuration_wen_confin : my_writable_register port map
    (q=>buf_lut_configuration_wen_confin, din=>reg_from_master(addr_lut_configuration_wen_confin),
     dout=>reg_from_slave(addr_lut_configuration_wen_confin));
  
  register_lut_configuration_read_lane : my_writable_register port map
    (q=>buf_lut_configuration_read_lane, din=>reg_from_master(addr_lut_configuration_read_lane),
     dout=>reg_from_slave(addr_lut_configuration_read_lane));

  register_lut_configuration_data_confin : my_writable_register port map
    (q=>buf_lut_configuration_data_confin, din=>reg_from_master(addr_lut_configuration_data_confin),
     dout=>reg_from_slave(addr_lut_configuration_data_confin));
  
  register_lut_configuration_data_confout : my_readonly_register port map
    (d=>buf_lut_configuration_data_confout, dout=>reg_from_slave(addr_lut_configuration_data_confout));
  
  process (MAIN_CLK, configurable_parameter_reset)
  begin
    if (configurable_parameter_reset='1') then
      -- (0) Look Up Table #0 14-bit MOD -> Index
      input_lut_mod2idx_addr_confin_i <= (others => (others => '0'));
      input_lut_mod2idx_data_confin_i <= (others => (others => '0'));
      input_lut_mod2idx_wen_confin_i  <= (others => '0');
      -- (1) Look Up Table #1 Index -> 14-bit MOD
      input_lut_idx2mod_addr_confin_i <= (others => (others => '0'));
      input_lut_idx2mod_data_confin_i <= (others => (others => '0'));
      input_lut_idx2mod_wen_confin_i  <= (others => '0');
      -- (2) Look Up Table #2 Pixel Module Data -> 32-bit destination
      input_lut_pixmod2dst_addr_confin_i <= (others => (others => '0'));
      input_lut_pixmod2dst_data_confin_i <= (others => (others => '0'));
      input_lut_pixmod2dst_wen_confin_i  <= (others => '0');
      -- (3) Look Up Table #3 SCT Module Data   -> 32-bit destination
      input_lut_sctmod2dst_addr_confin_i <= (others => (others => '0'));
      input_lut_sctmod2dst_data_confin_i   <= (others => (others => '0'));
      input_lut_sctmod2dst_wen_confin_i    <= (others => '0');
      -- (4) Look Up Table #4 Pixel Module FTK Plane 
      odo_pixmod2ftkplane_addr_confin_i  <= (others => (others => '0'));
      odo_pixmod2ftkplane_data_confin_i  <= (others => (others => '0'));
      odo_pixmod2ftkplane_wen_confin_i   <= (others => '0');
      -- (5) Look Up Table #5 SCT Module Tower (top and/or bottom)
      odo_pixmod2tower_addr_confin_i <= (others => (others => '0'));
      odo_pixmod2tower_data_confin_i <= (others => (others => '0'));
      odo_pixmod2tower_wen_confin_i  <= (others => '0');
      -- (6) Look Up Table #6 Pixel Module FTK Plane 
      odo_sctmod2ftkplane_addr_confin_i <= (others => (others => '0'));
      odo_sctmod2ftkplane_data_confin_i <= (others => (others => '0'));
      odo_sctmod2ftkplane_wen_confin_i  <= (others => '0');
      -- (7) Look Up Table #7 SCT Module Tower (top and/or bottom)
      odo_sctmod2tower_addr_confin_i <= (others => (others => '0'));
      odo_sctmod2tower_data_confin_i <= (others => (others => '0'));
      odo_sctmod2tower_wen_confin_i  <= (others => '0');
      -- (8) Look Up Table #5 SCT Module Duplication (top and/or bottom)
      odo_pixmod2duplication_addr_confin_i <= (others => (others => '0'));
      odo_pixmod2duplication_data_confin_i <= (others => (others => '0'));
      odo_pixmod2duplication_wen_confin_i  <= (others => '0');
      -- (9) Look Up Table #7 SCT Module Duplication (top and/or bottom)
      odo_sctmod2duplication_addr_confin_i <= (others => (others => '0'));
      odo_sctmod2duplication_data_confin_i <= (others => (others => '0'));
      odo_sctmod2duplication_wen_confin_i  <= (others => '0');
      
      
      lut_lane_to_be_read <= 0;

      INPUT_LUT_MOD2IDX_ADDR_CONFIN    <= (others => (others => '0'));
      INPUT_LUT_MOD2IDX_DATA_CONFIN    <= (others => (others => '0'));
      INPUT_LUT_MOD2IDX_WEN_CONFIN     <= (others => '0');
      
      INPUT_LUT_IDX2MOD_ADDR_CONFIN    <= (others => (others => '0'));
      INPUT_LUT_IDX2MOD_DATA_CONFIN    <= (others => (others => '0'));
      INPUT_LUT_IDX2MOD_WEN_CONFIN     <= (others => '0');
      
      INPUT_LUT_PIXMOD2DST_ADDR_CONFIN    <= (others => (others => '0'));
      INPUT_LUT_PIXMOD2DST_DATA_CONFIN    <= (others => (others => '0'));
      INPUT_LUT_PIXMOD2DST_WEN_CONFIN     <= (others => '0');
      
      INPUT_LUT_SCTMOD2DST_ADDR_CONFIN    <= (others => (others => '0'));
      INPUT_LUT_SCTMOD2DST_DATA_CONFIN    <= (others => (others => '0'));
      INPUT_LUT_SCTMOD2DST_WEN_CONFIN     <= (others => '0');
      
      ODO_PIXMOD2FTKPLANE_ADDR_CONFIN    <= (others => (others => '0'));
      ODO_PIXMOD2FTKPLANE_DATA_CONFIN    <= (others => (others => '0'));
      ODO_PIXMOD2FTKPLANE_WEN_CONFIN     <= (others => '0');
      
      ODO_PIXMOD2TOWER_ADDR_CONFIN    <= (others => (others => '0'));
      ODO_PIXMOD2TOWER_DATA_CONFIN    <= (others => (others => '0'));
      ODO_PIXMOD2TOWER_WEN_CONFIN     <= (others => '0');
      
      ODO_SCTMOD2FTKPLANE_ADDR_CONFIN    <= (others => (others => '0'));
      ODO_SCTMOD2FTKPLANE_DATA_CONFIN    <= (others => (others => '0'));
      ODO_SCTMOD2FTKPLANE_WEN_CONFIN     <= (others => '0');
      
      ODO_SCTMOD2TOWER_ADDR_CONFIN    <= (others => (others => '0'));
      ODO_SCTMOD2TOWER_DATA_CONFIN    <= (others => (others => '0'));
      ODO_SCTMOD2TOWER_WEN_CONFIN     <= (others => '0');
      
      ODO_PIXMOD2DUPLICATION_ADDR_CONFIN    <= (others => (others => '0'));
      ODO_PIXMOD2DUPLICATION_DATA_CONFIN    <= (others => (others => '0'));
      ODO_PIXMOD2DUPLICATION_WEN_CONFIN     <= (others => '0');
      
      ODO_SCTMOD2DUPLICATION_ADDR_CONFIN    <= (others => (others => '0'));
      ODO_SCTMOD2DUPLICATION_DATA_CONFIN    <= (others => (others => '0'));
      ODO_SCTMOD2DUPLICATION_WEN_CONFIN     <= (others => '0');
      
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      tmpr1_lut_configuration_addr_confin <= buf_lut_configuration_addr_confin(15 downto  0);
      tmpr1_lut_configuration_wen_confin  <= buf_lut_configuration_wen_confin;
      tmpr1_lut_configuration_data_confin <= buf_lut_configuration_data_confin;

      tmpr2_lut_configuration_addr_confin <= tmpr1_lut_configuration_addr_confin;
      tmpr2_lut_configuration_wen_confin  <= tmpr1_lut_configuration_wen_confin;
      tmpr2_lut_configuration_data_confin <= tmpr1_lut_configuration_data_confin;
                                            
      lut_configuration_addr_confin       <= tmpr2_lut_configuration_addr_confin;
      lut_configuration_wen_confin        <= tmpr2_lut_configuration_wen_confin;
      lut_configuration_data_confin       <= tmpr2_lut_configuration_data_confin;

      buf_lut_configuration_data_confout <= lut_configuration_data_confout;
      lut_lane_to_be_read <= CONV_INTEGER(buf_lut_configuration_read_lane);


      --=================================================================
      -- output to LUT
      --=================================================================
      INPUT_LUT_MOD2IDX_ADDR_CONFIN    <= input_lut_mod2idx_addr_confin_r1;
      INPUT_LUT_MOD2IDX_DATA_CONFIN    <= input_lut_mod2idx_data_confin_r1;
      INPUT_LUT_MOD2IDX_WEN_CONFIN     <= input_lut_mod2idx_wen_confin_r1;
      input_lut_mod2idx_data_confout_r1 <= INPUT_LUT_MOD2IDX_DATA_CONFOUT;
      
      INPUT_LUT_IDX2MOD_ADDR_CONFIN    <= input_lut_idx2mod_addr_confin_r1;
      INPUT_LUT_IDX2MOD_DATA_CONFIN    <= input_lut_idx2mod_data_confin_r1;
      INPUT_LUT_IDX2MOD_WEN_CONFIN     <= input_lut_idx2mod_wen_confin_r1;
      input_lut_idx2mod_data_confout_r1 <= INPUT_LUT_IDX2MOD_DATA_CONFOUT;
      
      INPUT_LUT_PIXMOD2DST_ADDR_CONFIN    <= input_lut_pixmod2dst_addr_confin_r1;
      INPUT_LUT_PIXMOD2DST_DATA_CONFIN    <= input_lut_pixmod2dst_data_confin_r1;
      INPUT_LUT_PIXMOD2DST_WEN_CONFIN     <= input_lut_pixmod2dst_wen_confin_r1;
      input_lut_pixmod2dst_data_confout_r1 <= INPUT_LUT_PIXMOD2DST_DATA_CONFOUT;
      
      INPUT_LUT_SCTMOD2DST_ADDR_CONFIN    <= input_lut_sctmod2dst_addr_confin_r1;
      INPUT_LUT_SCTMOD2DST_DATA_CONFIN    <= input_lut_sctmod2dst_data_confin_r1;
      INPUT_LUT_SCTMOD2DST_WEN_CONFIN     <= input_lut_sctmod2dst_wen_confin_r1;
      input_lut_sctmod2dst_data_confout_r1 <= INPUT_LUT_SCTMOD2DST_DATA_CONFOUT;
      
      ODO_PIXMOD2FTKPLANE_ADDR_CONFIN    <= odo_pixmod2ftkplane_addr_confin_r1;
      ODO_PIXMOD2FTKPLANE_DATA_CONFIN    <= odo_pixmod2ftkplane_data_confin_r1;
      ODO_PIXMOD2FTKPLANE_WEN_CONFIN     <= odo_pixmod2ftkplane_wen_confin_r1;
      odo_pixmod2ftkplane_data_confout_r1 <= ODO_PIXMOD2FTKPLANE_DATA_CONFOUT;
      
      ODO_PIXMOD2TOWER_ADDR_CONFIN    <= odo_pixmod2tower_addr_confin_r1;
      ODO_PIXMOD2TOWER_DATA_CONFIN    <= odo_pixmod2tower_data_confin_r1;
      ODO_PIXMOD2TOWER_WEN_CONFIN     <= odo_pixmod2tower_wen_confin_r1;
      odo_pixmod2tower_data_confout_r1 <= ODO_PIXMOD2TOWER_DATA_CONFOUT;
      
      ODO_SCTMOD2FTKPLANE_ADDR_CONFIN    <= odo_sctmod2ftkplane_addr_confin_r1;
      ODO_SCTMOD2FTKPLANE_DATA_CONFIN    <= odo_sctmod2ftkplane_data_confin_r1;
      ODO_SCTMOD2FTKPLANE_WEN_CONFIN     <= odo_sctmod2ftkplane_wen_confin_r1;
      odo_sctmod2ftkplane_data_confout_r1 <= ODO_SCTMOD2FTKPLANE_DATA_CONFOUT;
      
      ODO_SCTMOD2TOWER_ADDR_CONFIN    <= odo_sctmod2tower_addr_confin_r1;
      ODO_SCTMOD2TOWER_DATA_CONFIN    <= odo_sctmod2tower_data_confin_r1;
      ODO_SCTMOD2TOWER_WEN_CONFIN     <= odo_sctmod2tower_wen_confin_r1;
      odo_sctmod2tower_data_confout_r1 <= ODO_SCTMOD2TOWER_DATA_CONFOUT;    
      
      ODO_PIXMOD2DUPLICATION_ADDR_CONFIN    <= odo_pixmod2duplication_addr_confin_r1;
      ODO_PIXMOD2DUPLICATION_DATA_CONFIN    <= odo_pixmod2duplication_data_confin_r1;
      ODO_PIXMOD2DUPLICATION_WEN_CONFIN     <= odo_pixmod2duplication_wen_confin_r1;
      odo_pixmod2duplication_data_confout_r1 <= ODO_PIXMOD2DUPLICATION_DATA_CONFOUT;
      
      ODO_SCTMOD2DUPLICATION_ADDR_CONFIN    <= odo_sctmod2duplication_addr_confin_r1;
      ODO_SCTMOD2DUPLICATION_DATA_CONFIN    <= odo_sctmod2duplication_data_confin_r1;
      ODO_SCTMOD2DUPLICATION_WEN_CONFIN     <= odo_sctmod2duplication_wen_confin_r1;
      odo_sctmod2duplication_data_confout_r1 <= ODO_SCTMOD2DUPLICATION_DATA_CONFOUT; 
      
      --=================================================================
      -- buffer for timing requirement
      --=================================================================      
      input_lut_mod2idx_addr_confin_r1    <= input_lut_mod2idx_addr_confin_i;
      input_lut_mod2idx_data_confin_r1    <= input_lut_mod2idx_data_confin_i;
      input_lut_mod2idx_wen_confin_r1     <= input_lut_mod2idx_wen_confin_i;
      input_lut_mod2idx_data_confout_i    <= input_lut_mod2idx_data_confout_r1;
      
      input_lut_idx2mod_addr_confin_r1    <= input_lut_idx2mod_addr_confin_i;
      input_lut_idx2mod_data_confin_r1    <= input_lut_idx2mod_data_confin_i;
      input_lut_idx2mod_wen_confin_r1     <= input_lut_idx2mod_wen_confin_i;
      input_lut_idx2mod_data_confout_i    <= input_lut_idx2mod_data_confout_r1;
      
      input_lut_pixmod2dst_addr_confin_r1    <= input_lut_pixmod2dst_addr_confin_i;
      input_lut_pixmod2dst_data_confin_r1    <= input_lut_pixmod2dst_data_confin_i;
      input_lut_pixmod2dst_wen_confin_r1     <= input_lut_pixmod2dst_wen_confin_i;
      input_lut_pixmod2dst_data_confout_i    <= input_lut_pixmod2dst_data_confout_r1;
      
      input_lut_sctmod2dst_addr_confin_r1    <= input_lut_sctmod2dst_addr_confin_i;
      input_lut_sctmod2dst_data_confin_r1    <= input_lut_sctmod2dst_data_confin_i;
      input_lut_sctmod2dst_wen_confin_r1     <= input_lut_sctmod2dst_wen_confin_i;
      input_lut_sctmod2dst_data_confout_i    <= input_lut_sctmod2dst_data_confout_r1;
      
      odo_pixmod2ftkplane_addr_confin_r1    <= odo_pixmod2ftkplane_addr_confin_i;
      odo_pixmod2ftkplane_data_confin_r1    <= odo_pixmod2ftkplane_data_confin_i;
      odo_pixmod2ftkplane_wen_confin_r1     <= odo_pixmod2ftkplane_wen_confin_i;
      odo_pixmod2ftkplane_data_confout_i    <= odo_pixmod2ftkplane_data_confout_r1;
      
      odo_pixmod2tower_addr_confin_r1    <= odo_pixmod2tower_addr_confin_i;
      odo_pixmod2tower_data_confin_r1    <= odo_pixmod2tower_data_confin_i;
      odo_pixmod2tower_wen_confin_r1     <= odo_pixmod2tower_wen_confin_i;
      odo_pixmod2tower_data_confout_i    <= odo_pixmod2tower_data_confout_r1;
      
      odo_sctmod2ftkplane_addr_confin_r1    <= odo_sctmod2ftkplane_addr_confin_i;
      odo_sctmod2ftkplane_data_confin_r1    <= odo_sctmod2ftkplane_data_confin_i;
      odo_sctmod2ftkplane_wen_confin_r1     <= odo_sctmod2ftkplane_wen_confin_i;
      odo_sctmod2ftkplane_data_confout_i    <= odo_sctmod2ftkplane_data_confout_r1;
      
      odo_sctmod2tower_addr_confin_r1    <= odo_sctmod2tower_addr_confin_i;
      odo_sctmod2tower_data_confin_r1    <= odo_sctmod2tower_data_confin_i;
      odo_sctmod2tower_wen_confin_r1     <= odo_sctmod2tower_wen_confin_i;
      odo_sctmod2tower_data_confout_i    <= odo_sctmod2tower_data_confout_r1;
      
      odo_pixmod2duplication_addr_confin_r1    <= odo_pixmod2duplication_addr_confin_i;
      odo_pixmod2duplication_data_confin_r1    <= odo_pixmod2duplication_data_confin_i;
      odo_pixmod2duplication_wen_confin_r1     <= odo_pixmod2duplication_wen_confin_i;
      odo_pixmod2duplication_data_confout_i    <= odo_pixmod2duplication_data_confout_r1;

      odo_sctmod2duplication_addr_confin_r1    <= odo_sctmod2duplication_addr_confin_i;
      odo_sctmod2duplication_data_confin_r1    <= odo_sctmod2duplication_data_confin_i;
      odo_sctmod2duplication_wen_confin_r1     <= odo_sctmod2duplication_wen_confin_i;
      odo_sctmod2duplication_data_confout_i    <= odo_sctmod2duplication_data_confout_r1;
      
      case buf_lut_configuration_selector is
        when X"00" =>
          input_lut_mod2idx_addr_confin_i <= (others => lut_configuration_addr_confin(input_lut_mod2idx_addr_confin_i(0)'range) );
          input_lut_mod2idx_data_confin_i <= (others => lut_configuration_data_confin(input_lut_mod2idx_data_confin_i(0)'range) );
          input_lut_mod2idx_wen_confin_i  <= lut_configuration_wen_confin(input_lut_mod2idx_wen_confin_i'range);        
          lut_configuration_data_confout(8 downto 0) <= input_lut_mod2idx_data_confout_i(lut_lane_to_be_read);
          lut_configuration_data_confout(31 downto 9) <= (others => '0');
        when X"01" =>
          input_lut_idx2mod_addr_confin_i <= (others => lut_configuration_addr_confin(input_lut_idx2mod_addr_confin_i(0)'range) );
          input_lut_idx2mod_data_confin_i <= (others => lut_configuration_data_confin(input_lut_idx2mod_data_confin_i(0)'range) );
          input_lut_idx2mod_wen_confin_i  <= lut_configuration_wen_confin(input_lut_idx2mod_wen_confin_i'range);
          lut_configuration_data_confout(13 downto 0) <= input_lut_idx2mod_data_confout_i(lut_lane_to_be_read);
          lut_configuration_data_confout(31 downto 14) <= (others => '0');
        when X"02" =>
          -- <note> the destination bit is defined with 36-bit-width in the core level but
          -- 32-bit-width is enough, then here explicitly 32-bit length are shown
          input_lut_pixmod2dst_addr_confin_i <= (others => lut_configuration_addr_confin(input_lut_pixmod2dst_addr_confin_i(0)'range) );
          input_lut_pixmod2dst_data_confin_i <= (others => ("0000"&lut_configuration_data_confin(31 downto 0)) );
          input_lut_pixmod2dst_wen_confin_i  <= lut_configuration_wen_confin(input_lut_pixmod2dst_wen_confin_i'range);
          lut_configuration_data_confout(31 downto 0) <= input_lut_pixmod2dst_data_confout_i(lut_lane_to_be_read)(31 downto 0);
        when X"03" =>
          -- <note> the destination bit is defined with 36-bit-width in the core level but
          -- 32-bit-width is enough, then here explicitly 32-bit length are shown
          input_lut_sctmod2dst_addr_confin_i <= (others => lut_configuration_addr_confin(input_lut_sctmod2dst_addr_confin_i(0)'range) );
          input_lut_sctmod2dst_data_confin_i <= (others => ("0000"&lut_configuration_data_confin(31 downto 0) ) );
          input_lut_sctmod2dst_wen_confin_i  <= lut_configuration_wen_confin(input_lut_sctmod2dst_wen_confin_i'range);
          lut_configuration_data_confout(31 downto 0) <= input_lut_sctmod2dst_data_confout_i(lut_lane_to_be_read)(31 downto 0);
        when X"04" =>
          odo_pixmod2ftkplane_addr_confin_i <= (others => lut_configuration_addr_confin(odo_pixmod2ftkplane_addr_confin_i(0)'range) );
          odo_pixmod2ftkplane_data_confin_i <= (others => lut_configuration_data_confin(odo_pixmod2ftkplane_data_confin_i(0)'range) );
          odo_pixmod2ftkplane_wen_confin_i  <= lut_configuration_wen_confin(odo_pixmod2ftkplane_wen_confin_i'range);
          lut_configuration_data_confout(11 downto 0) <= odo_pixmod2ftkplane_data_confout_i(lut_lane_to_be_read);
          lut_configuration_data_confout(31 downto 12) <= (others => '0');
        when X"05" =>
          odo_pixmod2tower_addr_confin_i <= (others => lut_configuration_addr_confin(odo_pixmod2tower_addr_confin_i(0)'range) );
          odo_pixmod2tower_data_confin_i <= (others => lut_configuration_data_confin(odo_pixmod2tower_data_confin_i(0)'range) );
          odo_pixmod2tower_wen_confin_i  <= lut_configuration_wen_confin(odo_pixmod2tower_wen_confin_i'range);
          lut_configuration_data_confout(1 downto 0) <= odo_pixmod2tower_data_confout_i(lut_lane_to_be_read);
          lut_configuration_data_confout(31 downto 2) <= (others => '0');
        when X"06" =>
          odo_sctmod2ftkplane_addr_confin_i <= (others => lut_configuration_addr_confin(odo_sctmod2ftkplane_addr_confin_i(0)'range) );
          odo_sctmod2ftkplane_data_confin_i <= (others => lut_configuration_data_confin(odo_sctmod2ftkplane_data_confin_i(0)'range) );
          odo_sctmod2ftkplane_wen_confin_i  <= lut_configuration_wen_confin(odo_sctmod2ftkplane_wen_confin_i'range);
          lut_configuration_data_confout(11 downto 0) <= odo_sctmod2ftkplane_data_confout_i(lut_lane_to_be_read);
          lut_configuration_data_confout(31 downto 12) <= (others => '0');          
        when X"07" =>
          odo_sctmod2tower_addr_confin_i <= (others => lut_configuration_addr_confin(odo_sctmod2tower_addr_confin_i(0)'range) );
          odo_sctmod2tower_data_confin_i <= (others => lut_configuration_data_confin(odo_sctmod2tower_data_confin_i(0)'range) );
          odo_sctmod2tower_wen_confin_i  <= lut_configuration_wen_confin(odo_sctmod2tower_wen_confin_i'range);
          lut_configuration_data_confout(1 downto 0) <= odo_sctmod2tower_data_confout_i(lut_lane_to_be_read);
          lut_configuration_data_confout(31 downto 2) <= (others => '0');
        when X"08" =>
          odo_pixmod2duplication_addr_confin_i <= (others => lut_configuration_addr_confin(odo_pixmod2duplication_addr_confin_i(0)'range) );
          odo_pixmod2duplication_data_confin_i <= (others => lut_configuration_data_confin(odo_pixmod2duplication_data_confin_i(0)'range) );
          odo_pixmod2duplication_wen_confin_i  <= lut_configuration_wen_confin(odo_pixmod2duplication_wen_confin_i'range);
          lut_configuration_data_confout(1 downto 0) <= odo_pixmod2duplication_data_confout_i(lut_lane_to_be_read);
          lut_configuration_data_confout(31 downto 2) <= (others => '0');
        when X"09" =>
          odo_sctmod2duplication_addr_confin_i <= (others => lut_configuration_addr_confin(odo_sctmod2duplication_addr_confin_i(0)'range) );
          odo_sctmod2duplication_data_confin_i <= (others => lut_configuration_data_confin(odo_sctmod2duplication_data_confin_i(0)'range) );
          odo_sctmod2duplication_wen_confin_i  <= lut_configuration_wen_confin(odo_sctmod2duplication_wen_confin_i'range);
          lut_configuration_data_confout(1 downto 0) <= odo_sctmod2duplication_data_confout_i(lut_lane_to_be_read);
          lut_configuration_data_confout(31 downto 2) <= (others => '0');          
        when others => 
          NULL;
      end case;
    end if;
  end process;


  -- =======================
  register_switch_selector_for_fifo_monitoring : my_writable_register port map
    (q=>buf_switch_selector_for_fifo_monitoring, din=>reg_from_master(addr_switch_selector_for_fifo_monitoring),
     dout=>reg_from_slave(addr_switch_selector_for_fifo_monitoring));
  
  register_switch_fifo_monitoring : my_readonly_register port map
    (d=>buf_switch_fifo_monitoring, dout=>reg_from_slave(addr_switch_fifo_monitoring));
  
  process (CLK50)
  begin
    if (CLK50'event and CLK50='1') then
      switch_selector_for_fifo_monitoring_row <=
        CONV_INTEGER(buf_switch_selector_for_fifo_monitoring(3 downto 0));
      switch_selector_for_fifo_monitoring_column <=
        CONV_INTEGER(buf_switch_selector_for_fifo_monitoring(7 downto 4));
      
      if buf_switch_selector_for_fifo_monitoring(11 downto 8) = "0000" then
        buf_switch_fifo_monitoring <= OUTPUT_SWITCH_FIFO_MONITORING(switch_selector_for_fifo_monitoring_column)(switch_selector_for_fifo_monitoring_row);
      elsif buf_switch_selector_for_fifo_monitoring(11 downto 8) = "0001" then
        buf_switch_fifo_monitoring <= INTERNALLINK_CENTRAL_SWITCH_FIFO_MONITORING(switch_selector_for_fifo_monitoring_column)(switch_selector_for_fifo_monitoring_row);
      elsif buf_switch_selector_for_fifo_monitoring(11 downto 8) = "0010" then
        buf_switch_fifo_monitoring <= INTERNALLINK_OUTPUT_SWITCH_FIFO_MONITORING(switch_selector_for_fifo_monitoring_column)(switch_selector_for_fifo_monitoring_row);
      end if;
    end if;
  end process;
    
end logic;
