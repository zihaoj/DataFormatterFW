------------------------------------------------------------------------------
-- modification
-- (0)  modify the name from exdes -> interface
--      gt64_rtm34l_interface => gt_rtm34l_interface
-- (1)  remove signals in "----------------------- Frame check/gen Module Signals --------------------"
--      until track_data_out_ila_i
-- (2)  remove modules in "------------------------------ Frame Generators ---------------------------"
-- (3)  remove modules in "---------------------------------- Frame Checkers -------------------------"
--      until             "----------------------------- Debug Signals assignment -----------------------"
-- (4)  remove component vio_0 / component ila_0 / component ila_1 / component
--      xcvr_32b_2gbps_2014sum_GT_FRAME_GEN / cvr_32b_2gbps_2014sum_GT_FRAME_CHECK 
-- (5)  remove signals _vio_ 
-- (6)  remove signals _lia
-- (7)  remove soft_reset_i instead add "TRANSCEIVER_RESET : in std_logic;"
--      and connect to soft_reset_in port
-- (9)  modify
--    DRP_CLK_IN_P / DRP_CLK_IN_N into DRP_CLK_IN
--    gt64_rtm34l/gt64_rtm34l_example/gt64_rtm34l_example.srcs/sources_1/imports/example_design/support/gt64_rtm34l_support.vhd SYSCLK_IN_P / SYSCLK_IN_N into DRP_CLK_I
--    gt64_rtm34l/gt64_rtm34l_example/gt64_rtm34l_example.srcs/sources_1/imports/example_design/support/gt64_rtm34l_gt_usrclk_source.vhd DRPCLK_IN_P / DRPCLK_IN_P into DRPCLK_IN
--                                    remove IBUFDS / BUFG and directly connect
-- (10) remove TRACK_DATA_OUT : out 
-- (11) modify IO name
--    ORIGINALLY :
--      RXN_IN                                  : in   std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      RXP_IN                                  : in   std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      TXN_OUT                                 : out  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      TXP_OUT                                 : out  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0)
--    AFTER MODIFICATION :
--      RXN_IN  : in   std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      RXP_IN  : in   std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      TXN_OUT : out  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      TXP_OUT : out  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0)
-- (12) add parallel I/O bus
--      GT_TXUSERCLK_OUT     : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      GT_RXUSERCLK_OUT     : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      GT_TX_DATA_IN     : in  DF_GTDATA_GT_LANES_RTM_L_ARRAY;
--      GT_TX_CHARISK_IN  : in  DF_GTCHARISK_GT_LANES_RTM_L_ARRAY;
--      GT_RX_DATA_OUT    : out DF_GTDATA_GT_LANES_RTM_L_ARRAY;
--      GT_RX_CHARISK_OUT : out DF_GTCHARISK_GT_LANES_RTM_L_ARRAY;
--      GT_RXBYTEISALIGNED_OUT : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      GT_RXENCOMMAALIGN_IN  : in  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      GT_RXPOLARITY_IN      : in  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      GT_TXPOLARITY_IN      : in  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      GT_TX_RESET_DONE_OUT   : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
--      GT_RX_RESET_DONE_OUT   : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
-- (13) add connection part
--  -- gt0
--  gt0_txdata_i          <= GT_TX_DATA_IN(0);
--  gt0_txcharisk_i       <= GT_TX_CHARISK_IN(0);
--  GT_RX_DATA_OUT(0)         <= gt0_rxdata_i;
--  GT_RX_CHARISK_OUT(0)      <= gt0_rxcharisk_i;
--  GT_TX_RESET_DONE_OUT(0)   <= gt0_txfsmresetdone_r2;
--  GT_RX_RESET_DONE_OUT(0)   <= gt0_rxresetdone_r3;
--  GT_RXBYTEISALIGNED_OUT(0) <= gt0_rxbyteisaligned_i;
--  gt0_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(0) or (not gt0_rxresetdone_r3);
--  gt0_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(0) or (not gt0_rxresetdone_r3);
--  gt0_rxpolarity_i <= GT_RXPOLARITY_IN(0);
--  gt0_txpolarity_i <= GT_TXPOLARITY_IN(0);
--  GT_PLL_LOCK_OUT(0) <= gt0_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(0);
--
--  --
-- (14) remove gtX_tx_system_reset_c / gtX_rx_system_reset_c
-- (15) constant gtX_track_data_i : std_logic := '1';
-- (16) delete       EXAMPLE_WORDS_IN_BRAM                   : integer   := 512;
--                   EXAMPLE_CONFIG_INDEPENDENT_LANES        : integer   := 1;
--                   EXAMPLE_LANE_WITH_START_CHAR            : integer   := 0;    -- specifies lane with unique start frame ch
--                   STABLE_CLOCK_PERIOD                     : integer   := 6;
--                   EXAMPLE_SIM_GTRESET_SPEEDUP             : string    := "TRUE";    -- simulation setting for GT SecureIP model
--                   EXAMPLE_USE_CHIPSCOPE                   : integer   := 0           -- Set to 1 to use Chipscope to drive resets
-- (17) use work.data_formatter_constants.all;
-- (18) add user clock out <THIS IS MORE INTUITIVE IN 2014.2 version> 
-- GT_TXUSERCLK_OUT(0) <= gt0_txusrclk2_i;
-- GT_RXUSERCLK_OUT(0) <= gt1_rxusrclk2_i;
-- (19) remove
--      gt0_rxpolarity_i                             <= tied_to_ground_i;
--      gt0_txpolarity_i                             <= tied_to_ground_i;
-- (20) connect PLL_RESET to CPLL or QPLL reset (e.g. gt0_cpllreset_in)
-- (21) signal gt_qpll_lock_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0) := (others => '0');
--      gt_qpll_lock_i(0) <= gt0_qplllock_i;
--      gt_qpll_lock_i(1) <= gt0_qplllock_i;
--      gt_qpll_lock_i(2) <= gt1_qplllock_i;
--      gt_qpll_lock_i(3) <= gt1_qplllock_i;
--      gt_qpll_lock_i(4) <= gt1_qplllock_i;
--      gt_qpll_lock_i(5) <= gt1_qplllock_i;
--      gt_qpll_lock_i(6) <= gt2_qplllock_i;
--      gt_qpll_lock_i(7) <= gt2_qplllock_i;
--      gt_qpll_lock_i(8) <= gt2_qplllock_i;
--      gt_qpll_lock_i(9) <= gt2_qplllock_i;
--      gt_qpll_lock_i(10) <= gt3_qplllock_i;
--      gt_qpll_lock_i(11) <= gt3_qplllock_i;
--      gt_qpll_lock_i(12) <= gt3_qplllock_i;
--      gt_qpll_lock_i(13) <= gt3_qplllock_i;
--      gt_qpll_lock_i(14) <= gt4_qplllock_i;
--      gt_qpll_lock_i(15) <= gt4_qplllock_i;
-- (22) gt64_rtm34l/gt64_rtm34l_gt.vhd modify the transceiver parameters
--      RX_CM_TRIM                              =>     ("1101"),--RX_CM_TRIM=950mVR
--      TXDIFFCTRL                      =>      "0011", --V_PPD=0.407
-- (23) Reference clock
--Q1_CLK0_GTREFCLK_PAD_N_IN => GTREFCLK0_N_IN,
--Q1_CLK0_GTREFCLK_PAD_P_IN => GTREFCLK0_P_IN,
--Q4_CLK0_GTREFCLK_PAD_N_IN => GTREFCLK1_N_IN,
--Q4_CLK0_GTREFCLK_PAD_P_IN => GTREFCLK1_P_IN,
--Q7_CLK0_GTREFCLK_PAD_N_IN => GTREFCLK2_N_IN,
--Q7_CLK0_GTREFCLK_PAD_P_IN => GTREFCLK2_P_IN,


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

use work.data_formatter_constants.all;

--***********************************Entity Declaration************************

entity gt_rtm34l_interface is
  generic
    (
      -- Simulation attributes
      CPLL_USED : std_logic := '1';
      EXAMPLE_SIM_GTRESET_SPEEDUP    : string    := "FALSE";
      STABLE_CLOCK_PERIOD            : integer   := 20   
      );
  port
    (
      GTREFCLK0_N_IN : in   std_logic; -- should connect to Q1_CLK0
      GTREFCLK0_P_IN : in   std_logic; -- should conncet to Q1_CLK0
      GTREFCLK1_N_IN : in   std_logic; -- should connect to Q4_CLK0
      GTREFCLK1_P_IN : in   std_logic; -- should connect to Q4_CLK0
      GTREFCLK2_N_IN : in   std_logic; -- should connect to Q7_CLK0
      GTREFCLK2_P_IN : in   std_logic; -- should connect to Q7_CLK0      
      
      PLL_RESET         : in std_logic := '0';
      TRANSCEIVER_RESET : in std_logic;
      DRP_CLK_IN        : in std_logic;
      POWER_ON_RESET_REQ_LINK : out std_logic;
      
      GT_TXUSERCLK_OUT    : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      GT_RXUSERCLK_OUT    : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      GT_TX_DATA_IN     : in  DF_GTDATA_LANES_RTM_L_ARRAY;
      GT_TX_CHARISK_IN  : in  DF_GTCHARISK_LANES_RTM_L_ARRAY;
      GT_RX_DATA_OUT    : out DF_GTDATA_LANES_RTM_L_ARRAY;
      GT_RX_CHARISK_OUT : out DF_GTCHARISK_LANES_RTM_L_ARRAY;      
      GT_RXBYTEISALIGNED_OUT : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      GT_RXENCOMMAALIGN_IN  : in  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      GT_RXPOLARITY_IN      : in  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      GT_TXPOLARITY_IN      : in  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      GT_TX_RESET_DONE_OUT   : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      GT_RX_RESET_DONE_OUT   : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      GT_PLL_LOCK_OUT        : out std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);     
      
      RXN_IN  : in   std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      RXP_IN  : in   std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      TXN_OUT : out  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
      TXP_OUT : out  std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0)    
      );  
end gt_rtm34l_interface;
    
architecture RTL of gt_rtm34l_interface is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

    attribute CORE_GENERATION_INFO : string;
    attribute CORE_GENERATION_INFO of RTL : architecture is "gt64_rtm34l,gtwizard_v3_3,{protocol_file=Start_from_scratch}";

--**************************Component Declarations*****************************

    
component gt64_rtm34l_support
generic
(
    -- Simulation attributes
    EXAMPLE_SIM_GTRESET_SPEEDUP    : string    := "FALSE";    -- Set to TRUE to speed up sim reset
    STABLE_CLOCK_PERIOD            : integer   := 20 
);
port
(
    SOFT_RESET_IN                           : in   std_logic;
    DONT_RESET_ON_DATA_ERROR_IN             : in   std_logic;
    Q1_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
    Q1_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;
    Q4_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
    Q4_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;
    Q7_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
    Q7_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;

    GT0_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT0_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT0_DATA_VALID_IN                       : in   std_logic;
    GT1_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT1_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT1_DATA_VALID_IN                       : in   std_logic;
    GT2_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT2_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT2_DATA_VALID_IN                       : in   std_logic;
    GT3_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT3_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT3_DATA_VALID_IN                       : in   std_logic;
    GT4_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT4_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT4_DATA_VALID_IN                       : in   std_logic;
    GT5_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT5_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT5_DATA_VALID_IN                       : in   std_logic;
    GT6_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT6_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT6_DATA_VALID_IN                       : in   std_logic;
    GT7_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT7_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT7_DATA_VALID_IN                       : in   std_logic;
    GT8_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT8_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT8_DATA_VALID_IN                       : in   std_logic;
    GT9_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT9_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT9_DATA_VALID_IN                       : in   std_logic;
    GT10_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT10_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT10_DATA_VALID_IN                      : in   std_logic;
    GT11_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT11_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT11_DATA_VALID_IN                      : in   std_logic;
    GT12_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT12_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT12_DATA_VALID_IN                      : in   std_logic;
    GT13_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT13_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT13_DATA_VALID_IN                      : in   std_logic;
    GT14_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT14_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT14_DATA_VALID_IN                      : in   std_logic;
    GT15_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT15_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT15_DATA_VALID_IN                      : in   std_logic;
    GT16_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT16_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT16_DATA_VALID_IN                      : in   std_logic;
    GT17_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT17_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT17_DATA_VALID_IN                      : in   std_logic;
    GT18_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT18_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT18_DATA_VALID_IN                      : in   std_logic;
    GT19_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT19_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT19_DATA_VALID_IN                      : in   std_logic;
    GT20_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT20_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT20_DATA_VALID_IN                      : in   std_logic;
    GT21_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT21_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT21_DATA_VALID_IN                      : in   std_logic;
    GT22_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT22_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT22_DATA_VALID_IN                      : in   std_logic;
    GT23_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT23_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT23_DATA_VALID_IN                      : in   std_logic;
    GT24_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT24_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT24_DATA_VALID_IN                      : in   std_logic;
    GT25_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT25_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT25_DATA_VALID_IN                      : in   std_logic;
    GT26_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT26_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT26_DATA_VALID_IN                      : in   std_logic;
    GT27_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT27_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT27_DATA_VALID_IN                      : in   std_logic;
    GT28_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT28_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT28_DATA_VALID_IN                      : in   std_logic;
    GT29_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT29_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT29_DATA_VALID_IN                      : in   std_logic;
    GT30_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT30_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT30_DATA_VALID_IN                      : in   std_logic;
    GT31_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT31_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT31_DATA_VALID_IN                      : in   std_logic;
    GT32_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT32_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT32_DATA_VALID_IN                      : in   std_logic;
    GT33_TX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT33_RX_FSM_RESET_DONE_OUT              : out  std_logic;
    GT33_DATA_VALID_IN                      : in   std_logic;
 
    GT0_TXUSRCLK_OUT                        : out  std_logic;
    GT0_TXUSRCLK2_OUT                       : out  std_logic;
    GT0_RXUSRCLK_OUT                        : out  std_logic;
    GT0_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT1_TXUSRCLK_OUT                        : out  std_logic;
    GT1_TXUSRCLK2_OUT                       : out  std_logic;
    GT1_RXUSRCLK_OUT                        : out  std_logic;
    GT1_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT2_TXUSRCLK_OUT                        : out  std_logic;
    GT2_TXUSRCLK2_OUT                       : out  std_logic;
    GT2_RXUSRCLK_OUT                        : out  std_logic;
    GT2_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT3_TXUSRCLK_OUT                        : out  std_logic;
    GT3_TXUSRCLK2_OUT                       : out  std_logic;
    GT3_RXUSRCLK_OUT                        : out  std_logic;
    GT3_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT4_TXUSRCLK_OUT                        : out  std_logic;
    GT4_TXUSRCLK2_OUT                       : out  std_logic;
    GT4_RXUSRCLK_OUT                        : out  std_logic;
    GT4_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT5_TXUSRCLK_OUT                        : out  std_logic;
    GT5_TXUSRCLK2_OUT                       : out  std_logic;
    GT5_RXUSRCLK_OUT                        : out  std_logic;
    GT5_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT6_TXUSRCLK_OUT                        : out  std_logic;
    GT6_TXUSRCLK2_OUT                       : out  std_logic;
    GT6_RXUSRCLK_OUT                        : out  std_logic;
    GT6_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT7_TXUSRCLK_OUT                        : out  std_logic;
    GT7_TXUSRCLK2_OUT                       : out  std_logic;
    GT7_RXUSRCLK_OUT                        : out  std_logic;
    GT7_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT8_TXUSRCLK_OUT                        : out  std_logic;
    GT8_TXUSRCLK2_OUT                       : out  std_logic;
    GT8_RXUSRCLK_OUT                        : out  std_logic;
    GT8_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT9_TXUSRCLK_OUT                        : out  std_logic;
    GT9_TXUSRCLK2_OUT                       : out  std_logic;
    GT9_RXUSRCLK_OUT                        : out  std_logic;
    GT9_RXUSRCLK2_OUT                       : out  std_logic;
 
    GT10_TXUSRCLK_OUT                       : out  std_logic;
    GT10_TXUSRCLK2_OUT                      : out  std_logic;
    GT10_RXUSRCLK_OUT                       : out  std_logic;
    GT10_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT11_TXUSRCLK_OUT                       : out  std_logic;
    GT11_TXUSRCLK2_OUT                      : out  std_logic;
    GT11_RXUSRCLK_OUT                       : out  std_logic;
    GT11_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT12_TXUSRCLK_OUT                       : out  std_logic;
    GT12_TXUSRCLK2_OUT                      : out  std_logic;
    GT12_RXUSRCLK_OUT                       : out  std_logic;
    GT12_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT13_TXUSRCLK_OUT                       : out  std_logic;
    GT13_TXUSRCLK2_OUT                      : out  std_logic;
    GT13_RXUSRCLK_OUT                       : out  std_logic;
    GT13_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT14_TXUSRCLK_OUT                       : out  std_logic;
    GT14_TXUSRCLK2_OUT                      : out  std_logic;
    GT14_RXUSRCLK_OUT                       : out  std_logic;
    GT14_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT15_TXUSRCLK_OUT                       : out  std_logic;
    GT15_TXUSRCLK2_OUT                      : out  std_logic;
    GT15_RXUSRCLK_OUT                       : out  std_logic;
    GT15_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT16_TXUSRCLK_OUT                       : out  std_logic;
    GT16_TXUSRCLK2_OUT                      : out  std_logic;
    GT16_RXUSRCLK_OUT                       : out  std_logic;
    GT16_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT17_TXUSRCLK_OUT                       : out  std_logic;
    GT17_TXUSRCLK2_OUT                      : out  std_logic;
    GT17_RXUSRCLK_OUT                       : out  std_logic;
    GT17_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT18_TXUSRCLK_OUT                       : out  std_logic;
    GT18_TXUSRCLK2_OUT                      : out  std_logic;
    GT18_RXUSRCLK_OUT                       : out  std_logic;
    GT18_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT19_TXUSRCLK_OUT                       : out  std_logic;
    GT19_TXUSRCLK2_OUT                      : out  std_logic;
    GT19_RXUSRCLK_OUT                       : out  std_logic;
    GT19_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT20_TXUSRCLK_OUT                       : out  std_logic;
    GT20_TXUSRCLK2_OUT                      : out  std_logic;
    GT20_RXUSRCLK_OUT                       : out  std_logic;
    GT20_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT21_TXUSRCLK_OUT                       : out  std_logic;
    GT21_TXUSRCLK2_OUT                      : out  std_logic;
    GT21_RXUSRCLK_OUT                       : out  std_logic;
    GT21_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT22_TXUSRCLK_OUT                       : out  std_logic;
    GT22_TXUSRCLK2_OUT                      : out  std_logic;
    GT22_RXUSRCLK_OUT                       : out  std_logic;
    GT22_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT23_TXUSRCLK_OUT                       : out  std_logic;
    GT23_TXUSRCLK2_OUT                      : out  std_logic;
    GT23_RXUSRCLK_OUT                       : out  std_logic;
    GT23_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT24_TXUSRCLK_OUT                       : out  std_logic;
    GT24_TXUSRCLK2_OUT                      : out  std_logic;
    GT24_RXUSRCLK_OUT                       : out  std_logic;
    GT24_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT25_TXUSRCLK_OUT                       : out  std_logic;
    GT25_TXUSRCLK2_OUT                      : out  std_logic;
    GT25_RXUSRCLK_OUT                       : out  std_logic;
    GT25_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT26_TXUSRCLK_OUT                       : out  std_logic;
    GT26_TXUSRCLK2_OUT                      : out  std_logic;
    GT26_RXUSRCLK_OUT                       : out  std_logic;
    GT26_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT27_TXUSRCLK_OUT                       : out  std_logic;
    GT27_TXUSRCLK2_OUT                      : out  std_logic;
    GT27_RXUSRCLK_OUT                       : out  std_logic;
    GT27_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT28_TXUSRCLK_OUT                       : out  std_logic;
    GT28_TXUSRCLK2_OUT                      : out  std_logic;
    GT28_RXUSRCLK_OUT                       : out  std_logic;
    GT28_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT29_TXUSRCLK_OUT                       : out  std_logic;
    GT29_TXUSRCLK2_OUT                      : out  std_logic;
    GT29_RXUSRCLK_OUT                       : out  std_logic;
    GT29_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT30_TXUSRCLK_OUT                       : out  std_logic;
    GT30_TXUSRCLK2_OUT                      : out  std_logic;
    GT30_RXUSRCLK_OUT                       : out  std_logic;
    GT30_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT31_TXUSRCLK_OUT                       : out  std_logic;
    GT31_TXUSRCLK2_OUT                      : out  std_logic;
    GT31_RXUSRCLK_OUT                       : out  std_logic;
    GT31_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT32_TXUSRCLK_OUT                       : out  std_logic;
    GT32_TXUSRCLK2_OUT                      : out  std_logic;
    GT32_RXUSRCLK_OUT                       : out  std_logic;
    GT32_RXUSRCLK2_OUT                      : out  std_logic;
 
    GT33_TXUSRCLK_OUT                       : out  std_logic;
    GT33_TXUSRCLK2_OUT                      : out  std_logic;
    GT33_RXUSRCLK_OUT                       : out  std_logic;
    GT33_RXUSRCLK2_OUT                      : out  std_logic;
    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT0  (X0Y0)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt0_cpllfbclklost_out                   : out  std_logic;
    gt0_cplllock_out                        : out  std_logic;
    gt0_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt0_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt0_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt0_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt0_drpen_in                            : in   std_logic;
    gt0_drprdy_out                          : out  std_logic;
    gt0_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt0_eyescanreset_in                     : in   std_logic;
    gt0_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt0_eyescandataerror_out                : out  std_logic;
    gt0_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt0_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt0_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt0_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt0_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt0_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt0_rxbyteisaligned_out                 : out  std_logic;
    gt0_rxmcommaalignen_in                  : in   std_logic;
    gt0_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt0_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt0_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt0_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt0_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt0_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt0_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt0_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt0_gttxreset_in                        : in   std_logic;
    gt0_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt0_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt0_gthtxn_out                          : out  std_logic;
    gt0_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt0_txoutclkfabric_out                  : out  std_logic;
    gt0_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt0_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt0_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt0_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT1  (X0Y1)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt1_cpllfbclklost_out                   : out  std_logic;
    gt1_cplllock_out                        : out  std_logic;
    gt1_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt1_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt1_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt1_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt1_drpen_in                            : in   std_logic;
    gt1_drprdy_out                          : out  std_logic;
    gt1_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt1_eyescanreset_in                     : in   std_logic;
    gt1_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt1_eyescandataerror_out                : out  std_logic;
    gt1_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt1_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt1_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt1_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt1_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt1_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt1_rxbyteisaligned_out                 : out  std_logic;
    gt1_rxmcommaalignen_in                  : in   std_logic;
    gt1_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt1_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt1_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt1_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt1_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt1_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt1_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt1_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt1_gttxreset_in                        : in   std_logic;
    gt1_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt1_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt1_gthtxn_out                          : out  std_logic;
    gt1_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt1_txoutclkfabric_out                  : out  std_logic;
    gt1_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt1_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt1_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt1_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT2  (X0Y2)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt2_cpllfbclklost_out                   : out  std_logic;
    gt2_cplllock_out                        : out  std_logic;
    gt2_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt2_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt2_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt2_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt2_drpen_in                            : in   std_logic;
    gt2_drprdy_out                          : out  std_logic;
    gt2_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt2_eyescanreset_in                     : in   std_logic;
    gt2_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt2_eyescandataerror_out                : out  std_logic;
    gt2_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt2_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt2_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt2_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt2_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt2_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt2_rxbyteisaligned_out                 : out  std_logic;
    gt2_rxmcommaalignen_in                  : in   std_logic;
    gt2_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt2_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt2_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt2_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt2_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt2_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt2_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt2_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt2_gttxreset_in                        : in   std_logic;
    gt2_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt2_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt2_gthtxn_out                          : out  std_logic;
    gt2_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt2_txoutclkfabric_out                  : out  std_logic;
    gt2_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt2_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt2_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt2_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT3  (X0Y3)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt3_cpllfbclklost_out                   : out  std_logic;
    gt3_cplllock_out                        : out  std_logic;
    gt3_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt3_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt3_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt3_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt3_drpen_in                            : in   std_logic;
    gt3_drprdy_out                          : out  std_logic;
    gt3_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt3_eyescanreset_in                     : in   std_logic;
    gt3_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt3_eyescandataerror_out                : out  std_logic;
    gt3_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt3_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt3_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt3_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt3_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt3_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt3_rxbyteisaligned_out                 : out  std_logic;
    gt3_rxmcommaalignen_in                  : in   std_logic;
    gt3_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt3_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt3_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt3_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt3_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt3_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt3_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt3_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt3_gttxreset_in                        : in   std_logic;
    gt3_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt3_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt3_gthtxn_out                          : out  std_logic;
    gt3_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt3_txoutclkfabric_out                  : out  std_logic;
    gt3_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt3_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt3_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt3_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT4  (X0Y4)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt4_cpllfbclklost_out                   : out  std_logic;
    gt4_cplllock_out                        : out  std_logic;
    gt4_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt4_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt4_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt4_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt4_drpen_in                            : in   std_logic;
    gt4_drprdy_out                          : out  std_logic;
    gt4_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt4_eyescanreset_in                     : in   std_logic;
    gt4_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt4_eyescandataerror_out                : out  std_logic;
    gt4_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt4_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt4_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt4_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt4_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt4_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt4_rxbyteisaligned_out                 : out  std_logic;
    gt4_rxmcommaalignen_in                  : in   std_logic;
    gt4_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt4_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt4_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt4_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt4_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt4_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt4_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt4_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt4_gttxreset_in                        : in   std_logic;
    gt4_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt4_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt4_gthtxn_out                          : out  std_logic;
    gt4_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt4_txoutclkfabric_out                  : out  std_logic;
    gt4_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt4_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt4_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt4_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT5  (X0Y5)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt5_cpllfbclklost_out                   : out  std_logic;
    gt5_cplllock_out                        : out  std_logic;
    gt5_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt5_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt5_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt5_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt5_drpen_in                            : in   std_logic;
    gt5_drprdy_out                          : out  std_logic;
    gt5_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt5_eyescanreset_in                     : in   std_logic;
    gt5_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt5_eyescandataerror_out                : out  std_logic;
    gt5_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt5_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt5_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt5_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt5_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt5_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt5_rxbyteisaligned_out                 : out  std_logic;
    gt5_rxmcommaalignen_in                  : in   std_logic;
    gt5_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt5_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt5_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt5_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt5_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt5_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt5_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt5_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt5_gttxreset_in                        : in   std_logic;
    gt5_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt5_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt5_gthtxn_out                          : out  std_logic;
    gt5_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt5_txoutclkfabric_out                  : out  std_logic;
    gt5_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt5_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt5_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt5_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT6  (X0Y6)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt6_cpllfbclklost_out                   : out  std_logic;
    gt6_cplllock_out                        : out  std_logic;
    gt6_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt6_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt6_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt6_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt6_drpen_in                            : in   std_logic;
    gt6_drprdy_out                          : out  std_logic;
    gt6_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt6_eyescanreset_in                     : in   std_logic;
    gt6_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt6_eyescandataerror_out                : out  std_logic;
    gt6_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt6_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt6_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt6_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt6_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt6_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt6_rxbyteisaligned_out                 : out  std_logic;
    gt6_rxmcommaalignen_in                  : in   std_logic;
    gt6_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt6_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt6_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt6_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt6_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt6_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt6_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt6_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt6_gttxreset_in                        : in   std_logic;
    gt6_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt6_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt6_gthtxn_out                          : out  std_logic;
    gt6_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt6_txoutclkfabric_out                  : out  std_logic;
    gt6_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt6_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt6_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt6_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT7  (X0Y7)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt7_cpllfbclklost_out                   : out  std_logic;
    gt7_cplllock_out                        : out  std_logic;
    gt7_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt7_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt7_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt7_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt7_drpen_in                            : in   std_logic;
    gt7_drprdy_out                          : out  std_logic;
    gt7_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt7_eyescanreset_in                     : in   std_logic;
    gt7_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt7_eyescandataerror_out                : out  std_logic;
    gt7_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt7_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt7_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt7_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt7_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt7_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt7_rxbyteisaligned_out                 : out  std_logic;
    gt7_rxmcommaalignen_in                  : in   std_logic;
    gt7_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt7_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt7_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt7_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt7_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt7_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt7_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt7_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt7_gttxreset_in                        : in   std_logic;
    gt7_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt7_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt7_gthtxn_out                          : out  std_logic;
    gt7_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt7_txoutclkfabric_out                  : out  std_logic;
    gt7_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt7_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt7_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt7_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT8  (X0Y8)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt8_cpllfbclklost_out                   : out  std_logic;
    gt8_cplllock_out                        : out  std_logic;
    gt8_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt8_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt8_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt8_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt8_drpen_in                            : in   std_logic;
    gt8_drprdy_out                          : out  std_logic;
    gt8_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt8_eyescanreset_in                     : in   std_logic;
    gt8_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt8_eyescandataerror_out                : out  std_logic;
    gt8_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt8_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt8_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt8_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt8_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt8_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt8_rxbyteisaligned_out                 : out  std_logic;
    gt8_rxmcommaalignen_in                  : in   std_logic;
    gt8_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt8_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt8_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt8_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt8_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt8_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt8_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt8_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt8_gttxreset_in                        : in   std_logic;
    gt8_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt8_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt8_gthtxn_out                          : out  std_logic;
    gt8_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt8_txoutclkfabric_out                  : out  std_logic;
    gt8_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt8_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt8_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt8_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT9  (X0Y9)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt9_cpllfbclklost_out                   : out  std_logic;
    gt9_cplllock_out                        : out  std_logic;
    gt9_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt9_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt9_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt9_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt9_drpen_in                            : in   std_logic;
    gt9_drprdy_out                          : out  std_logic;
    gt9_drpwe_in                            : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt9_eyescanreset_in                     : in   std_logic;
    gt9_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt9_eyescandataerror_out                : out  std_logic;
    gt9_eyescantrigger_in                   : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt9_dmonitorout_out                     : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt9_rxdata_out                          : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt9_rxdisperr_out                       : out  std_logic_vector(3 downto 0);
    gt9_rxnotintable_out                    : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt9_gthrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt9_rxbyteisaligned_out                 : out  std_logic;
    gt9_rxmcommaalignen_in                  : in   std_logic;
    gt9_rxpcommaalignen_in                  : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt9_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt9_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt9_gtrxreset_in                        : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt9_rxpolarity_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt9_rxcharisk_out                       : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt9_gthrxp_in                           : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt9_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt9_gttxreset_in                        : in   std_logic;
    gt9_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt9_txdata_in                           : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt9_gthtxn_out                          : out  std_logic;
    gt9_gthtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt9_txoutclkfabric_out                  : out  std_logic;
    gt9_txoutclkpcs_out                     : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt9_txresetdone_out                     : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt9_txpolarity_in                       : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt9_txcharisk_in                        : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT10  (X0Y10)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt10_cpllfbclklost_out                  : out  std_logic;
    gt10_cplllock_out                       : out  std_logic;
    gt10_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt10_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt10_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt10_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt10_drpen_in                           : in   std_logic;
    gt10_drprdy_out                         : out  std_logic;
    gt10_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt10_eyescanreset_in                    : in   std_logic;
    gt10_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt10_eyescandataerror_out               : out  std_logic;
    gt10_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt10_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt10_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt10_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt10_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt10_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt10_rxbyteisaligned_out                : out  std_logic;
    gt10_rxmcommaalignen_in                 : in   std_logic;
    gt10_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt10_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt10_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt10_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt10_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt10_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt10_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt10_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt10_gttxreset_in                       : in   std_logic;
    gt10_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt10_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt10_gthtxn_out                         : out  std_logic;
    gt10_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt10_txoutclkfabric_out                 : out  std_logic;
    gt10_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt10_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt10_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt10_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT11  (X0Y11)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt11_cpllfbclklost_out                  : out  std_logic;
    gt11_cplllock_out                       : out  std_logic;
    gt11_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt11_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt11_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt11_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt11_drpen_in                           : in   std_logic;
    gt11_drprdy_out                         : out  std_logic;
    gt11_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt11_eyescanreset_in                    : in   std_logic;
    gt11_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt11_eyescandataerror_out               : out  std_logic;
    gt11_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt11_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt11_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt11_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt11_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt11_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt11_rxbyteisaligned_out                : out  std_logic;
    gt11_rxmcommaalignen_in                 : in   std_logic;
    gt11_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt11_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt11_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt11_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt11_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt11_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt11_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt11_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt11_gttxreset_in                       : in   std_logic;
    gt11_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt11_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt11_gthtxn_out                         : out  std_logic;
    gt11_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt11_txoutclkfabric_out                 : out  std_logic;
    gt11_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt11_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt11_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt11_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT12  (X0Y12)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt12_cpllfbclklost_out                  : out  std_logic;
    gt12_cplllock_out                       : out  std_logic;
    gt12_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt12_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt12_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt12_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt12_drpen_in                           : in   std_logic;
    gt12_drprdy_out                         : out  std_logic;
    gt12_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt12_eyescanreset_in                    : in   std_logic;
    gt12_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt12_eyescandataerror_out               : out  std_logic;
    gt12_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt12_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt12_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt12_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt12_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt12_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt12_rxbyteisaligned_out                : out  std_logic;
    gt12_rxmcommaalignen_in                 : in   std_logic;
    gt12_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt12_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt12_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt12_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt12_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt12_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt12_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt12_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt12_gttxreset_in                       : in   std_logic;
    gt12_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt12_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt12_gthtxn_out                         : out  std_logic;
    gt12_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt12_txoutclkfabric_out                 : out  std_logic;
    gt12_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt12_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt12_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt12_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT13  (X0Y13)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt13_cpllfbclklost_out                  : out  std_logic;
    gt13_cplllock_out                       : out  std_logic;
    gt13_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt13_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt13_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt13_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt13_drpen_in                           : in   std_logic;
    gt13_drprdy_out                         : out  std_logic;
    gt13_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt13_eyescanreset_in                    : in   std_logic;
    gt13_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt13_eyescandataerror_out               : out  std_logic;
    gt13_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt13_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt13_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt13_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt13_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt13_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt13_rxbyteisaligned_out                : out  std_logic;
    gt13_rxmcommaalignen_in                 : in   std_logic;
    gt13_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt13_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt13_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt13_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt13_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt13_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt13_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt13_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt13_gttxreset_in                       : in   std_logic;
    gt13_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt13_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt13_gthtxn_out                         : out  std_logic;
    gt13_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt13_txoutclkfabric_out                 : out  std_logic;
    gt13_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt13_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt13_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt13_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT14  (X0Y14)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt14_cpllfbclklost_out                  : out  std_logic;
    gt14_cplllock_out                       : out  std_logic;
    gt14_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt14_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt14_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt14_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt14_drpen_in                           : in   std_logic;
    gt14_drprdy_out                         : out  std_logic;
    gt14_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt14_eyescanreset_in                    : in   std_logic;
    gt14_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt14_eyescandataerror_out               : out  std_logic;
    gt14_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt14_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt14_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt14_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt14_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt14_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt14_rxbyteisaligned_out                : out  std_logic;
    gt14_rxmcommaalignen_in                 : in   std_logic;
    gt14_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt14_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt14_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt14_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt14_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt14_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt14_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt14_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt14_gttxreset_in                       : in   std_logic;
    gt14_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt14_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt14_gthtxn_out                         : out  std_logic;
    gt14_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt14_txoutclkfabric_out                 : out  std_logic;
    gt14_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt14_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt14_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt14_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT15  (X0Y15)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt15_cpllfbclklost_out                  : out  std_logic;
    gt15_cplllock_out                       : out  std_logic;
    gt15_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt15_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt15_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt15_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt15_drpen_in                           : in   std_logic;
    gt15_drprdy_out                         : out  std_logic;
    gt15_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt15_eyescanreset_in                    : in   std_logic;
    gt15_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt15_eyescandataerror_out               : out  std_logic;
    gt15_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt15_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt15_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt15_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt15_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt15_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt15_rxbyteisaligned_out                : out  std_logic;
    gt15_rxmcommaalignen_in                 : in   std_logic;
    gt15_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt15_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt15_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt15_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt15_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt15_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt15_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt15_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt15_gttxreset_in                       : in   std_logic;
    gt15_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt15_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt15_gthtxn_out                         : out  std_logic;
    gt15_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt15_txoutclkfabric_out                 : out  std_logic;
    gt15_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt15_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt15_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt15_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT16  (X0Y16)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt16_cpllfbclklost_out                  : out  std_logic;
    gt16_cplllock_out                       : out  std_logic;
    gt16_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt16_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt16_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt16_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt16_drpen_in                           : in   std_logic;
    gt16_drprdy_out                         : out  std_logic;
    gt16_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt16_eyescanreset_in                    : in   std_logic;
    gt16_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt16_eyescandataerror_out               : out  std_logic;
    gt16_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt16_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt16_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt16_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt16_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt16_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt16_rxbyteisaligned_out                : out  std_logic;
    gt16_rxmcommaalignen_in                 : in   std_logic;
    gt16_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt16_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt16_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt16_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt16_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt16_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt16_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt16_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt16_gttxreset_in                       : in   std_logic;
    gt16_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt16_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt16_gthtxn_out                         : out  std_logic;
    gt16_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt16_txoutclkfabric_out                 : out  std_logic;
    gt16_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt16_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt16_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt16_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT17  (X0Y17)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt17_cpllfbclklost_out                  : out  std_logic;
    gt17_cplllock_out                       : out  std_logic;
    gt17_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt17_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt17_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt17_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt17_drpen_in                           : in   std_logic;
    gt17_drprdy_out                         : out  std_logic;
    gt17_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt17_eyescanreset_in                    : in   std_logic;
    gt17_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt17_eyescandataerror_out               : out  std_logic;
    gt17_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt17_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt17_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt17_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt17_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt17_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt17_rxbyteisaligned_out                : out  std_logic;
    gt17_rxmcommaalignen_in                 : in   std_logic;
    gt17_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt17_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt17_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt17_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt17_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt17_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt17_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt17_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt17_gttxreset_in                       : in   std_logic;
    gt17_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt17_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt17_gthtxn_out                         : out  std_logic;
    gt17_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt17_txoutclkfabric_out                 : out  std_logic;
    gt17_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt17_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt17_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt17_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT18  (X0Y18)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt18_cpllfbclklost_out                  : out  std_logic;
    gt18_cplllock_out                       : out  std_logic;
    gt18_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt18_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt18_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt18_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt18_drpen_in                           : in   std_logic;
    gt18_drprdy_out                         : out  std_logic;
    gt18_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt18_eyescanreset_in                    : in   std_logic;
    gt18_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt18_eyescandataerror_out               : out  std_logic;
    gt18_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt18_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt18_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt18_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt18_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt18_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt18_rxbyteisaligned_out                : out  std_logic;
    gt18_rxmcommaalignen_in                 : in   std_logic;
    gt18_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt18_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt18_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt18_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt18_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt18_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt18_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt18_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt18_gttxreset_in                       : in   std_logic;
    gt18_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt18_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt18_gthtxn_out                         : out  std_logic;
    gt18_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt18_txoutclkfabric_out                 : out  std_logic;
    gt18_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt18_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt18_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt18_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT19  (X0Y19)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt19_cpllfbclklost_out                  : out  std_logic;
    gt19_cplllock_out                       : out  std_logic;
    gt19_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt19_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt19_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt19_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt19_drpen_in                           : in   std_logic;
    gt19_drprdy_out                         : out  std_logic;
    gt19_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt19_eyescanreset_in                    : in   std_logic;
    gt19_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt19_eyescandataerror_out               : out  std_logic;
    gt19_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt19_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt19_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt19_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt19_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt19_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt19_rxbyteisaligned_out                : out  std_logic;
    gt19_rxmcommaalignen_in                 : in   std_logic;
    gt19_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt19_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt19_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt19_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt19_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt19_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt19_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt19_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt19_gttxreset_in                       : in   std_logic;
    gt19_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt19_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt19_gthtxn_out                         : out  std_logic;
    gt19_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt19_txoutclkfabric_out                 : out  std_logic;
    gt19_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt19_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt19_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt19_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT20  (X0Y20)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt20_cpllfbclklost_out                  : out  std_logic;
    gt20_cplllock_out                       : out  std_logic;
    gt20_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt20_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt20_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt20_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt20_drpen_in                           : in   std_logic;
    gt20_drprdy_out                         : out  std_logic;
    gt20_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt20_eyescanreset_in                    : in   std_logic;
    gt20_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt20_eyescandataerror_out               : out  std_logic;
    gt20_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt20_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt20_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt20_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt20_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt20_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt20_rxbyteisaligned_out                : out  std_logic;
    gt20_rxmcommaalignen_in                 : in   std_logic;
    gt20_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt20_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt20_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt20_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt20_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt20_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt20_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt20_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt20_gttxreset_in                       : in   std_logic;
    gt20_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt20_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt20_gthtxn_out                         : out  std_logic;
    gt20_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt20_txoutclkfabric_out                 : out  std_logic;
    gt20_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt20_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt20_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt20_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT21  (X0Y21)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt21_cpllfbclklost_out                  : out  std_logic;
    gt21_cplllock_out                       : out  std_logic;
    gt21_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt21_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt21_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt21_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt21_drpen_in                           : in   std_logic;
    gt21_drprdy_out                         : out  std_logic;
    gt21_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt21_eyescanreset_in                    : in   std_logic;
    gt21_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt21_eyescandataerror_out               : out  std_logic;
    gt21_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt21_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt21_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt21_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt21_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt21_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt21_rxbyteisaligned_out                : out  std_logic;
    gt21_rxmcommaalignen_in                 : in   std_logic;
    gt21_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt21_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt21_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt21_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt21_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt21_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt21_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt21_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt21_gttxreset_in                       : in   std_logic;
    gt21_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt21_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt21_gthtxn_out                         : out  std_logic;
    gt21_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt21_txoutclkfabric_out                 : out  std_logic;
    gt21_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt21_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt21_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt21_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT22  (X0Y22)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt22_cpllfbclklost_out                  : out  std_logic;
    gt22_cplllock_out                       : out  std_logic;
    gt22_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt22_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt22_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt22_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt22_drpen_in                           : in   std_logic;
    gt22_drprdy_out                         : out  std_logic;
    gt22_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt22_eyescanreset_in                    : in   std_logic;
    gt22_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt22_eyescandataerror_out               : out  std_logic;
    gt22_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt22_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt22_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt22_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt22_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt22_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt22_rxbyteisaligned_out                : out  std_logic;
    gt22_rxmcommaalignen_in                 : in   std_logic;
    gt22_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt22_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt22_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt22_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt22_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt22_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt22_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt22_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt22_gttxreset_in                       : in   std_logic;
    gt22_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt22_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt22_gthtxn_out                         : out  std_logic;
    gt22_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt22_txoutclkfabric_out                 : out  std_logic;
    gt22_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt22_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt22_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt22_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT23  (X0Y23)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt23_cpllfbclklost_out                  : out  std_logic;
    gt23_cplllock_out                       : out  std_logic;
    gt23_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt23_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt23_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt23_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt23_drpen_in                           : in   std_logic;
    gt23_drprdy_out                         : out  std_logic;
    gt23_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt23_eyescanreset_in                    : in   std_logic;
    gt23_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt23_eyescandataerror_out               : out  std_logic;
    gt23_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt23_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt23_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt23_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt23_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt23_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt23_rxbyteisaligned_out                : out  std_logic;
    gt23_rxmcommaalignen_in                 : in   std_logic;
    gt23_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt23_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt23_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt23_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt23_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt23_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt23_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt23_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt23_gttxreset_in                       : in   std_logic;
    gt23_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt23_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt23_gthtxn_out                         : out  std_logic;
    gt23_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt23_txoutclkfabric_out                 : out  std_logic;
    gt23_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt23_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt23_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt23_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT24  (X0Y24)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt24_cpllfbclklost_out                  : out  std_logic;
    gt24_cplllock_out                       : out  std_logic;
    gt24_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt24_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt24_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt24_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt24_drpen_in                           : in   std_logic;
    gt24_drprdy_out                         : out  std_logic;
    gt24_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt24_eyescanreset_in                    : in   std_logic;
    gt24_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt24_eyescandataerror_out               : out  std_logic;
    gt24_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt24_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt24_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt24_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt24_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt24_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt24_rxbyteisaligned_out                : out  std_logic;
    gt24_rxmcommaalignen_in                 : in   std_logic;
    gt24_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt24_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt24_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt24_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt24_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt24_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt24_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt24_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt24_gttxreset_in                       : in   std_logic;
    gt24_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt24_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt24_gthtxn_out                         : out  std_logic;
    gt24_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt24_txoutclkfabric_out                 : out  std_logic;
    gt24_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt24_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt24_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt24_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT25  (X0Y25)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt25_cpllfbclklost_out                  : out  std_logic;
    gt25_cplllock_out                       : out  std_logic;
    gt25_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt25_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt25_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt25_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt25_drpen_in                           : in   std_logic;
    gt25_drprdy_out                         : out  std_logic;
    gt25_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt25_eyescanreset_in                    : in   std_logic;
    gt25_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt25_eyescandataerror_out               : out  std_logic;
    gt25_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt25_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt25_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt25_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt25_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt25_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt25_rxbyteisaligned_out                : out  std_logic;
    gt25_rxmcommaalignen_in                 : in   std_logic;
    gt25_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt25_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt25_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt25_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt25_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt25_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt25_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt25_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt25_gttxreset_in                       : in   std_logic;
    gt25_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt25_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt25_gthtxn_out                         : out  std_logic;
    gt25_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt25_txoutclkfabric_out                 : out  std_logic;
    gt25_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt25_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt25_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt25_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT26  (X0Y26)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt26_cpllfbclklost_out                  : out  std_logic;
    gt26_cplllock_out                       : out  std_logic;
    gt26_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt26_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt26_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt26_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt26_drpen_in                           : in   std_logic;
    gt26_drprdy_out                         : out  std_logic;
    gt26_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt26_eyescanreset_in                    : in   std_logic;
    gt26_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt26_eyescandataerror_out               : out  std_logic;
    gt26_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt26_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt26_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt26_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt26_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt26_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt26_rxbyteisaligned_out                : out  std_logic;
    gt26_rxmcommaalignen_in                 : in   std_logic;
    gt26_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt26_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt26_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt26_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt26_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt26_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt26_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt26_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt26_gttxreset_in                       : in   std_logic;
    gt26_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt26_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt26_gthtxn_out                         : out  std_logic;
    gt26_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt26_txoutclkfabric_out                 : out  std_logic;
    gt26_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt26_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt26_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt26_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT27  (X0Y27)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt27_cpllfbclklost_out                  : out  std_logic;
    gt27_cplllock_out                       : out  std_logic;
    gt27_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt27_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt27_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt27_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt27_drpen_in                           : in   std_logic;
    gt27_drprdy_out                         : out  std_logic;
    gt27_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt27_eyescanreset_in                    : in   std_logic;
    gt27_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt27_eyescandataerror_out               : out  std_logic;
    gt27_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt27_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt27_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt27_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt27_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt27_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt27_rxbyteisaligned_out                : out  std_logic;
    gt27_rxmcommaalignen_in                 : in   std_logic;
    gt27_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt27_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt27_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt27_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt27_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt27_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt27_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt27_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt27_gttxreset_in                       : in   std_logic;
    gt27_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt27_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt27_gthtxn_out                         : out  std_logic;
    gt27_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt27_txoutclkfabric_out                 : out  std_logic;
    gt27_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt27_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt27_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt27_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT28  (X0Y28)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt28_cpllfbclklost_out                  : out  std_logic;
    gt28_cplllock_out                       : out  std_logic;
    gt28_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt28_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt28_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt28_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt28_drpen_in                           : in   std_logic;
    gt28_drprdy_out                         : out  std_logic;
    gt28_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt28_eyescanreset_in                    : in   std_logic;
    gt28_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt28_eyescandataerror_out               : out  std_logic;
    gt28_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt28_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt28_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt28_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt28_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt28_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt28_rxbyteisaligned_out                : out  std_logic;
    gt28_rxmcommaalignen_in                 : in   std_logic;
    gt28_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt28_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt28_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt28_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt28_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt28_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt28_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt28_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt28_gttxreset_in                       : in   std_logic;
    gt28_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt28_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt28_gthtxn_out                         : out  std_logic;
    gt28_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt28_txoutclkfabric_out                 : out  std_logic;
    gt28_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt28_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt28_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt28_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT29  (X0Y29)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt29_cpllfbclklost_out                  : out  std_logic;
    gt29_cplllock_out                       : out  std_logic;
    gt29_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt29_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt29_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt29_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt29_drpen_in                           : in   std_logic;
    gt29_drprdy_out                         : out  std_logic;
    gt29_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt29_eyescanreset_in                    : in   std_logic;
    gt29_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt29_eyescandataerror_out               : out  std_logic;
    gt29_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt29_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt29_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt29_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt29_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt29_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt29_rxbyteisaligned_out                : out  std_logic;
    gt29_rxmcommaalignen_in                 : in   std_logic;
    gt29_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt29_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt29_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt29_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt29_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt29_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt29_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt29_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt29_gttxreset_in                       : in   std_logic;
    gt29_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt29_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt29_gthtxn_out                         : out  std_logic;
    gt29_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt29_txoutclkfabric_out                 : out  std_logic;
    gt29_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt29_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt29_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt29_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT30  (X0Y30)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt30_cpllfbclklost_out                  : out  std_logic;
    gt30_cplllock_out                       : out  std_logic;
    gt30_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt30_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt30_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt30_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt30_drpen_in                           : in   std_logic;
    gt30_drprdy_out                         : out  std_logic;
    gt30_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt30_eyescanreset_in                    : in   std_logic;
    gt30_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt30_eyescandataerror_out               : out  std_logic;
    gt30_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt30_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt30_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt30_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt30_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt30_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt30_rxbyteisaligned_out                : out  std_logic;
    gt30_rxmcommaalignen_in                 : in   std_logic;
    gt30_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt30_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt30_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt30_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt30_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt30_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt30_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt30_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt30_gttxreset_in                       : in   std_logic;
    gt30_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt30_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt30_gthtxn_out                         : out  std_logic;
    gt30_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt30_txoutclkfabric_out                 : out  std_logic;
    gt30_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt30_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt30_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt30_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT31  (X0Y31)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt31_cpllfbclklost_out                  : out  std_logic;
    gt31_cplllock_out                       : out  std_logic;
    gt31_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt31_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt31_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt31_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt31_drpen_in                           : in   std_logic;
    gt31_drprdy_out                         : out  std_logic;
    gt31_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt31_eyescanreset_in                    : in   std_logic;
    gt31_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt31_eyescandataerror_out               : out  std_logic;
    gt31_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt31_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt31_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt31_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt31_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt31_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt31_rxbyteisaligned_out                : out  std_logic;
    gt31_rxmcommaalignen_in                 : in   std_logic;
    gt31_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt31_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt31_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt31_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt31_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt31_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt31_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt31_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt31_gttxreset_in                       : in   std_logic;
    gt31_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt31_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt31_gthtxn_out                         : out  std_logic;
    gt31_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt31_txoutclkfabric_out                 : out  std_logic;
    gt31_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt31_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt31_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt31_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT32  (X0Y32)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt32_cpllfbclklost_out                  : out  std_logic;
    gt32_cplllock_out                       : out  std_logic;
    gt32_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt32_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt32_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt32_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt32_drpen_in                           : in   std_logic;
    gt32_drprdy_out                         : out  std_logic;
    gt32_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt32_eyescanreset_in                    : in   std_logic;
    gt32_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt32_eyescandataerror_out               : out  std_logic;
    gt32_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt32_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt32_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt32_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt32_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt32_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt32_rxbyteisaligned_out                : out  std_logic;
    gt32_rxmcommaalignen_in                 : in   std_logic;
    gt32_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt32_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt32_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt32_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt32_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt32_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt32_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt32_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt32_gttxreset_in                       : in   std_logic;
    gt32_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt32_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt32_gthtxn_out                         : out  std_logic;
    gt32_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt32_txoutclkfabric_out                 : out  std_logic;
    gt32_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt32_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt32_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt32_txcharisk_in                       : in   std_logic_vector(3 downto 0);

    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT33  (X0Y33)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt33_cpllfbclklost_out                  : out  std_logic;
    gt33_cplllock_out                       : out  std_logic;
    gt33_cpllreset_in                       : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt33_drpaddr_in                         : in   std_logic_vector(8 downto 0);
    gt33_drpdi_in                           : in   std_logic_vector(15 downto 0);
    gt33_drpdo_out                          : out  std_logic_vector(15 downto 0);
    gt33_drpen_in                           : in   std_logic;
    gt33_drprdy_out                         : out  std_logic;
    gt33_drpwe_in                           : in   std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    gt33_eyescanreset_in                    : in   std_logic;
    gt33_rxuserrdy_in                       : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt33_eyescandataerror_out               : out  std_logic;
    gt33_eyescantrigger_in                  : in   std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    gt33_dmonitorout_out                    : out  std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt33_rxdata_out                         : out  std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt33_rxdisperr_out                      : out  std_logic_vector(3 downto 0);
    gt33_rxnotintable_out                   : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt33_gthrxn_in                          : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt33_rxbyteisaligned_out                : out  std_logic;
    gt33_rxmcommaalignen_in                 : in   std_logic;
    gt33_rxpcommaalignen_in                 : in   std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt33_rxmonitorout_out                   : out  std_logic_vector(6 downto 0);
    gt33_rxmonitorsel_in                    : in   std_logic_vector(1 downto 0);
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt33_gtrxreset_in                       : in   std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    gt33_rxpolarity_in                      : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt33_rxcharisk_out                      : out  std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    gt33_gthrxp_in                          : in   std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt33_rxresetdone_out                    : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt33_gttxreset_in                       : in   std_logic;
    gt33_txuserrdy_in                       : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt33_txdata_in                          : in   std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt33_gthtxn_out                         : out  std_logic;
    gt33_gthtxp_out                         : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt33_txoutclkfabric_out                 : out  std_logic;
    gt33_txoutclkpcs_out                    : out  std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt33_txresetdone_out                    : out  std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    gt33_txpolarity_in                      : in   std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    gt33_txcharisk_in                       : in   std_logic_vector(3 downto 0);


    --____________________________COMMON PORTS________________________________
     GT0_QPLLOUTCLK_OUT  : out std_logic;
     GT0_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT1_QPLLOUTCLK_OUT  : out std_logic;
     GT1_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT2_QPLLOUTCLK_OUT  : out std_logic;
     GT2_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT3_QPLLOUTCLK_OUT  : out std_logic;
     GT3_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT4_QPLLOUTCLK_OUT  : out std_logic;
     GT4_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT5_QPLLOUTCLK_OUT  : out std_logic;
     GT5_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT6_QPLLOUTCLK_OUT  : out std_logic;
     GT6_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT7_QPLLOUTCLK_OUT  : out std_logic;
     GT7_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT8_QPLLOUTCLK_OUT  : out std_logic;
     GT8_QPLLOUTREFCLK_OUT : out std_logic;

     DRP_CLK_O : out std_logic;
     DRP_CLK_I : in  std_logic
);
end component;



component gt64_rtm34l_GT_FRAME_GEN 
generic
(
     WORDS_IN_BRAM    : integer := 512
);
port
(
    -- User Interface
    TX_DATA_OUT             : out   std_logic_vector(79 downto 0);
    TXCTRL_OUT              : out   std_logic_vector(7 downto 0); 
    -- System Interface
    USER_CLK                : in    std_logic;      
    SYSTEM_RESET            : in    std_logic
); 
end component;

component gt64_rtm34l_GT_FRAME_CHECK 
generic
(
    RX_DATA_WIDTH            : integer := 16;
    RXCTRL_WIDTH             : integer := 2; 
    WORDS_IN_BRAM            : integer := 256;
    CHANBOND_SEQ_LEN         : integer := 1;
    COMMA_DOUBLE             : std_logic_vector(15 downto 0) := x"f628";
    START_OF_PACKET_CHAR     : std_logic_vector(31 downto 0) := x"060504bc"
);
port
(
    -- User Interface
    RX_DATA_IN               : in  std_logic_vector((RX_DATA_WIDTH-1) downto 0);
    RXCTRL_IN                : in  std_logic_vector((RXCTRL_WIDTH-1) downto 0); 
    RXENMCOMMADET_OUT        : out std_logic;
    RXENPCOMMADET_OUT        : out std_logic;
    RX_ENCHAN_SYNC_OUT       : out std_logic;
    RX_CHANBOND_SEQ_IN       : in  std_logic;

    -- Control Interface
    INC_IN                   : in  std_logic; 
    INC_OUT                  : out std_logic; 
    PATTERN_MATCHB_OUT       : out std_logic;
    RESET_ON_ERROR_IN        : in  std_logic;


    -- Error Monitoring
    ERROR_COUNT_OUT          : out std_logic_vector(7 downto 0);

    -- Track Data
    TRACK_DATA_OUT           : out std_logic;

 

    -- System Interface
    USER_CLK                 : in std_logic;       
    SYSTEM_RESET             : in std_logic
);
end component;


--***********************************Parameter Declarations********************

    constant DLY : time := 1 ns;

--************************** Register Declarations ****************************
attribute ASYNC_REG                        : string;
    signal   gt0_txfsmresetdone_i            : std_logic;
signal   gt0_rxfsmresetdone_i            : std_logic;
    signal   gt0_txfsmresetdone_r            : std_logic;
    signal   gt0_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt0_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt0_txfsmresetdone_r2     : signal is "TRUE";
signal   gt0_rxresetdone_r               : std_logic;
signal   gt0_rxresetdone_r2              : std_logic;
signal   gt0_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt0_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt0_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt0_rxresetdone_r3     : signal is "TRUE";


    signal   gt1_txfsmresetdone_i            : std_logic;
signal   gt1_rxfsmresetdone_i            : std_logic;
    signal   gt1_txfsmresetdone_r            : std_logic;
    signal   gt1_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt1_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt1_txfsmresetdone_r2     : signal is "TRUE";
signal   gt1_rxresetdone_r               : std_logic;
signal   gt1_rxresetdone_r2              : std_logic;
signal   gt1_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt1_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt1_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt1_rxresetdone_r3     : signal is "TRUE";


    signal   gt2_txfsmresetdone_i            : std_logic;
signal   gt2_rxfsmresetdone_i            : std_logic;
    signal   gt2_txfsmresetdone_r            : std_logic;
    signal   gt2_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt2_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt2_txfsmresetdone_r2     : signal is "TRUE";
signal   gt2_rxresetdone_r               : std_logic;
signal   gt2_rxresetdone_r2              : std_logic;
signal   gt2_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt2_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt2_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt2_rxresetdone_r3     : signal is "TRUE";


    signal   gt3_txfsmresetdone_i            : std_logic;
signal   gt3_rxfsmresetdone_i            : std_logic;
    signal   gt3_txfsmresetdone_r            : std_logic;
    signal   gt3_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt3_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt3_txfsmresetdone_r2     : signal is "TRUE";
signal   gt3_rxresetdone_r               : std_logic;
signal   gt3_rxresetdone_r2              : std_logic;
signal   gt3_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt3_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt3_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt3_rxresetdone_r3     : signal is "TRUE";


    signal   gt4_txfsmresetdone_i            : std_logic;
signal   gt4_rxfsmresetdone_i            : std_logic;
    signal   gt4_txfsmresetdone_r            : std_logic;
    signal   gt4_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt4_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt4_txfsmresetdone_r2     : signal is "TRUE";
signal   gt4_rxresetdone_r               : std_logic;
signal   gt4_rxresetdone_r2              : std_logic;
signal   gt4_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt4_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt4_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt4_rxresetdone_r3     : signal is "TRUE";


    signal   gt5_txfsmresetdone_i            : std_logic;
signal   gt5_rxfsmresetdone_i            : std_logic;
    signal   gt5_txfsmresetdone_r            : std_logic;
    signal   gt5_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt5_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt5_txfsmresetdone_r2     : signal is "TRUE";
signal   gt5_rxresetdone_r               : std_logic;
signal   gt5_rxresetdone_r2              : std_logic;
signal   gt5_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt5_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt5_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt5_rxresetdone_r3     : signal is "TRUE";


    signal   gt6_txfsmresetdone_i            : std_logic;
signal   gt6_rxfsmresetdone_i            : std_logic;
    signal   gt6_txfsmresetdone_r            : std_logic;
    signal   gt6_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt6_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt6_txfsmresetdone_r2     : signal is "TRUE";
signal   gt6_rxresetdone_r               : std_logic;
signal   gt6_rxresetdone_r2              : std_logic;
signal   gt6_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt6_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt6_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt6_rxresetdone_r3     : signal is "TRUE";


    signal   gt7_txfsmresetdone_i            : std_logic;
signal   gt7_rxfsmresetdone_i            : std_logic;
    signal   gt7_txfsmresetdone_r            : std_logic;
    signal   gt7_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt7_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt7_txfsmresetdone_r2     : signal is "TRUE";
signal   gt7_rxresetdone_r               : std_logic;
signal   gt7_rxresetdone_r2              : std_logic;
signal   gt7_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt7_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt7_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt7_rxresetdone_r3     : signal is "TRUE";


    signal   gt8_txfsmresetdone_i            : std_logic;
signal   gt8_rxfsmresetdone_i            : std_logic;
    signal   gt8_txfsmresetdone_r            : std_logic;
    signal   gt8_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt8_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt8_txfsmresetdone_r2     : signal is "TRUE";
signal   gt8_rxresetdone_r               : std_logic;
signal   gt8_rxresetdone_r2              : std_logic;
signal   gt8_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt8_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt8_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt8_rxresetdone_r3     : signal is "TRUE";


    signal   gt9_txfsmresetdone_i            : std_logic;
signal   gt9_rxfsmresetdone_i            : std_logic;
    signal   gt9_txfsmresetdone_r            : std_logic;
    signal   gt9_txfsmresetdone_r2           : std_logic;
attribute ASYNC_REG of gt9_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt9_txfsmresetdone_r2     : signal is "TRUE";
signal   gt9_rxresetdone_r               : std_logic;
signal   gt9_rxresetdone_r2              : std_logic;
signal   gt9_rxresetdone_r3              : std_logic;
attribute ASYNC_REG of gt9_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt9_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt9_rxresetdone_r3     : signal is "TRUE";


    signal   gt10_txfsmresetdone_i           : std_logic;
signal   gt10_rxfsmresetdone_i           : std_logic;
    signal   gt10_txfsmresetdone_r           : std_logic;
    signal   gt10_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt10_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt10_txfsmresetdone_r2     : signal is "TRUE";
signal   gt10_rxresetdone_r              : std_logic;
signal   gt10_rxresetdone_r2             : std_logic;
signal   gt10_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt10_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt10_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt10_rxresetdone_r3     : signal is "TRUE";


    signal   gt11_txfsmresetdone_i           : std_logic;
signal   gt11_rxfsmresetdone_i           : std_logic;
    signal   gt11_txfsmresetdone_r           : std_logic;
    signal   gt11_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt11_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt11_txfsmresetdone_r2     : signal is "TRUE";
signal   gt11_rxresetdone_r              : std_logic;
signal   gt11_rxresetdone_r2             : std_logic;
signal   gt11_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt11_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt11_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt11_rxresetdone_r3     : signal is "TRUE";


    signal   gt12_txfsmresetdone_i           : std_logic;
signal   gt12_rxfsmresetdone_i           : std_logic;
    signal   gt12_txfsmresetdone_r           : std_logic;
    signal   gt12_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt12_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt12_txfsmresetdone_r2     : signal is "TRUE";
signal   gt12_rxresetdone_r              : std_logic;
signal   gt12_rxresetdone_r2             : std_logic;
signal   gt12_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt12_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt12_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt12_rxresetdone_r3     : signal is "TRUE";


    signal   gt13_txfsmresetdone_i           : std_logic;
signal   gt13_rxfsmresetdone_i           : std_logic;
    signal   gt13_txfsmresetdone_r           : std_logic;
    signal   gt13_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt13_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt13_txfsmresetdone_r2     : signal is "TRUE";
signal   gt13_rxresetdone_r              : std_logic;
signal   gt13_rxresetdone_r2             : std_logic;
signal   gt13_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt13_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt13_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt13_rxresetdone_r3     : signal is "TRUE";


    signal   gt14_txfsmresetdone_i           : std_logic;
signal   gt14_rxfsmresetdone_i           : std_logic;
    signal   gt14_txfsmresetdone_r           : std_logic;
    signal   gt14_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt14_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt14_txfsmresetdone_r2     : signal is "TRUE";
signal   gt14_rxresetdone_r              : std_logic;
signal   gt14_rxresetdone_r2             : std_logic;
signal   gt14_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt14_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt14_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt14_rxresetdone_r3     : signal is "TRUE";


    signal   gt15_txfsmresetdone_i           : std_logic;
signal   gt15_rxfsmresetdone_i           : std_logic;
    signal   gt15_txfsmresetdone_r           : std_logic;
    signal   gt15_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt15_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt15_txfsmresetdone_r2     : signal is "TRUE";
signal   gt15_rxresetdone_r              : std_logic;
signal   gt15_rxresetdone_r2             : std_logic;
signal   gt15_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt15_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt15_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt15_rxresetdone_r3     : signal is "TRUE";


    signal   gt16_txfsmresetdone_i           : std_logic;
signal   gt16_rxfsmresetdone_i           : std_logic;
    signal   gt16_txfsmresetdone_r           : std_logic;
    signal   gt16_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt16_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt16_txfsmresetdone_r2     : signal is "TRUE";
signal   gt16_rxresetdone_r              : std_logic;
signal   gt16_rxresetdone_r2             : std_logic;
signal   gt16_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt16_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt16_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt16_rxresetdone_r3     : signal is "TRUE";


    signal   gt17_txfsmresetdone_i           : std_logic;
signal   gt17_rxfsmresetdone_i           : std_logic;
    signal   gt17_txfsmresetdone_r           : std_logic;
    signal   gt17_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt17_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt17_txfsmresetdone_r2     : signal is "TRUE";
signal   gt17_rxresetdone_r              : std_logic;
signal   gt17_rxresetdone_r2             : std_logic;
signal   gt17_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt17_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt17_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt17_rxresetdone_r3     : signal is "TRUE";


    signal   gt18_txfsmresetdone_i           : std_logic;
signal   gt18_rxfsmresetdone_i           : std_logic;
    signal   gt18_txfsmresetdone_r           : std_logic;
    signal   gt18_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt18_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt18_txfsmresetdone_r2     : signal is "TRUE";
signal   gt18_rxresetdone_r              : std_logic;
signal   gt18_rxresetdone_r2             : std_logic;
signal   gt18_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt18_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt18_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt18_rxresetdone_r3     : signal is "TRUE";


    signal   gt19_txfsmresetdone_i           : std_logic;
signal   gt19_rxfsmresetdone_i           : std_logic;
    signal   gt19_txfsmresetdone_r           : std_logic;
    signal   gt19_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt19_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt19_txfsmresetdone_r2     : signal is "TRUE";
signal   gt19_rxresetdone_r              : std_logic;
signal   gt19_rxresetdone_r2             : std_logic;
signal   gt19_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt19_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt19_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt19_rxresetdone_r3     : signal is "TRUE";


    signal   gt20_txfsmresetdone_i           : std_logic;
signal   gt20_rxfsmresetdone_i           : std_logic;
    signal   gt20_txfsmresetdone_r           : std_logic;
    signal   gt20_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt20_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt20_txfsmresetdone_r2     : signal is "TRUE";
signal   gt20_rxresetdone_r              : std_logic;
signal   gt20_rxresetdone_r2             : std_logic;
signal   gt20_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt20_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt20_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt20_rxresetdone_r3     : signal is "TRUE";


    signal   gt21_txfsmresetdone_i           : std_logic;
signal   gt21_rxfsmresetdone_i           : std_logic;
    signal   gt21_txfsmresetdone_r           : std_logic;
    signal   gt21_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt21_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt21_txfsmresetdone_r2     : signal is "TRUE";
signal   gt21_rxresetdone_r              : std_logic;
signal   gt21_rxresetdone_r2             : std_logic;
signal   gt21_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt21_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt21_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt21_rxresetdone_r3     : signal is "TRUE";


    signal   gt22_txfsmresetdone_i           : std_logic;
signal   gt22_rxfsmresetdone_i           : std_logic;
    signal   gt22_txfsmresetdone_r           : std_logic;
    signal   gt22_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt22_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt22_txfsmresetdone_r2     : signal is "TRUE";
signal   gt22_rxresetdone_r              : std_logic;
signal   gt22_rxresetdone_r2             : std_logic;
signal   gt22_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt22_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt22_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt22_rxresetdone_r3     : signal is "TRUE";


    signal   gt23_txfsmresetdone_i           : std_logic;
signal   gt23_rxfsmresetdone_i           : std_logic;
    signal   gt23_txfsmresetdone_r           : std_logic;
    signal   gt23_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt23_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt23_txfsmresetdone_r2     : signal is "TRUE";
signal   gt23_rxresetdone_r              : std_logic;
signal   gt23_rxresetdone_r2             : std_logic;
signal   gt23_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt23_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt23_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt23_rxresetdone_r3     : signal is "TRUE";


    signal   gt24_txfsmresetdone_i           : std_logic;
signal   gt24_rxfsmresetdone_i           : std_logic;
    signal   gt24_txfsmresetdone_r           : std_logic;
    signal   gt24_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt24_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt24_txfsmresetdone_r2     : signal is "TRUE";
signal   gt24_rxresetdone_r              : std_logic;
signal   gt24_rxresetdone_r2             : std_logic;
signal   gt24_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt24_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt24_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt24_rxresetdone_r3     : signal is "TRUE";


    signal   gt25_txfsmresetdone_i           : std_logic;
signal   gt25_rxfsmresetdone_i           : std_logic;
    signal   gt25_txfsmresetdone_r           : std_logic;
    signal   gt25_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt25_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt25_txfsmresetdone_r2     : signal is "TRUE";
signal   gt25_rxresetdone_r              : std_logic;
signal   gt25_rxresetdone_r2             : std_logic;
signal   gt25_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt25_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt25_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt25_rxresetdone_r3     : signal is "TRUE";


    signal   gt26_txfsmresetdone_i           : std_logic;
signal   gt26_rxfsmresetdone_i           : std_logic;
    signal   gt26_txfsmresetdone_r           : std_logic;
    signal   gt26_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt26_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt26_txfsmresetdone_r2     : signal is "TRUE";
signal   gt26_rxresetdone_r              : std_logic;
signal   gt26_rxresetdone_r2             : std_logic;
signal   gt26_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt26_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt26_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt26_rxresetdone_r3     : signal is "TRUE";


    signal   gt27_txfsmresetdone_i           : std_logic;
signal   gt27_rxfsmresetdone_i           : std_logic;
    signal   gt27_txfsmresetdone_r           : std_logic;
    signal   gt27_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt27_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt27_txfsmresetdone_r2     : signal is "TRUE";
signal   gt27_rxresetdone_r              : std_logic;
signal   gt27_rxresetdone_r2             : std_logic;
signal   gt27_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt27_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt27_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt27_rxresetdone_r3     : signal is "TRUE";


    signal   gt28_txfsmresetdone_i           : std_logic;
signal   gt28_rxfsmresetdone_i           : std_logic;
    signal   gt28_txfsmresetdone_r           : std_logic;
    signal   gt28_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt28_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt28_txfsmresetdone_r2     : signal is "TRUE";
signal   gt28_rxresetdone_r              : std_logic;
signal   gt28_rxresetdone_r2             : std_logic;
signal   gt28_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt28_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt28_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt28_rxresetdone_r3     : signal is "TRUE";


    signal   gt29_txfsmresetdone_i           : std_logic;
signal   gt29_rxfsmresetdone_i           : std_logic;
    signal   gt29_txfsmresetdone_r           : std_logic;
    signal   gt29_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt29_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt29_txfsmresetdone_r2     : signal is "TRUE";
signal   gt29_rxresetdone_r              : std_logic;
signal   gt29_rxresetdone_r2             : std_logic;
signal   gt29_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt29_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt29_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt29_rxresetdone_r3     : signal is "TRUE";


    signal   gt30_txfsmresetdone_i           : std_logic;
signal   gt30_rxfsmresetdone_i           : std_logic;
    signal   gt30_txfsmresetdone_r           : std_logic;
    signal   gt30_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt30_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt30_txfsmresetdone_r2     : signal is "TRUE";
signal   gt30_rxresetdone_r              : std_logic;
signal   gt30_rxresetdone_r2             : std_logic;
signal   gt30_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt30_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt30_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt30_rxresetdone_r3     : signal is "TRUE";


    signal   gt31_txfsmresetdone_i           : std_logic;
signal   gt31_rxfsmresetdone_i           : std_logic;
    signal   gt31_txfsmresetdone_r           : std_logic;
    signal   gt31_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt31_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt31_txfsmresetdone_r2     : signal is "TRUE";
signal   gt31_rxresetdone_r              : std_logic;
signal   gt31_rxresetdone_r2             : std_logic;
signal   gt31_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt31_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt31_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt31_rxresetdone_r3     : signal is "TRUE";


    signal   gt32_txfsmresetdone_i           : std_logic;
signal   gt32_rxfsmresetdone_i           : std_logic;
    signal   gt32_txfsmresetdone_r           : std_logic;
    signal   gt32_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt32_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt32_txfsmresetdone_r2     : signal is "TRUE";
signal   gt32_rxresetdone_r              : std_logic;
signal   gt32_rxresetdone_r2             : std_logic;
signal   gt32_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt32_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt32_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt32_rxresetdone_r3     : signal is "TRUE";


    signal   gt33_txfsmresetdone_i           : std_logic;
signal   gt33_rxfsmresetdone_i           : std_logic;
    signal   gt33_txfsmresetdone_r           : std_logic;
    signal   gt33_txfsmresetdone_r2          : std_logic;
attribute ASYNC_REG of gt33_txfsmresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt33_txfsmresetdone_r2     : signal is "TRUE";
signal   gt33_rxresetdone_r              : std_logic;
signal   gt33_rxresetdone_r2             : std_logic;
signal   gt33_rxresetdone_r3             : std_logic;
attribute ASYNC_REG of gt33_rxresetdone_r     : signal is "TRUE";
attribute ASYNC_REG of gt33_rxresetdone_r2     : signal is "TRUE";
attribute ASYNC_REG of gt33_rxresetdone_r3     : signal is "TRUE";



--**************************** Wire Declarations ******************************
    -------------------------- GT Wrapper Wires ------------------------------
    --________________________________________________________________________
    --________________________________________________________________________
    --GT0  (X0Y0)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt0_cpllfbclklost_i             : std_logic;
    signal  gt0_cplllock_i                  : std_logic;
    signal  gt0_cpllrefclklost_i            : std_logic;
    signal  gt0_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt0_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt0_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt0_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt0_drpen_i                     : std_logic;
    signal  gt0_drprdy_i                    : std_logic;
    signal  gt0_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt0_eyescanreset_i              : std_logic;
    signal  gt0_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt0_eyescandataerror_i          : std_logic;
    signal  gt0_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt0_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt0_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt0_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt0_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt0_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt0_rxbyteisaligned_i           : std_logic;
    signal  gt0_rxmcommaalignen_i           : std_logic;
    signal  gt0_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt0_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt0_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt0_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt0_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt0_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt0_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt0_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt0_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt0_gttxreset_i                 : std_logic;
    signal  gt0_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt0_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt0_gthtxn_i                    : std_logic;
    signal  gt0_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt0_txoutclk_i                  : std_logic;
    signal  gt0_txoutclkfabric_i            : std_logic;
    signal  gt0_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt0_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt0_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt0_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT1  (X0Y1)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt1_cpllfbclklost_i             : std_logic;
    signal  gt1_cplllock_i                  : std_logic;
    signal  gt1_cpllrefclklost_i            : std_logic;
    signal  gt1_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt1_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt1_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt1_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt1_drpen_i                     : std_logic;
    signal  gt1_drprdy_i                    : std_logic;
    signal  gt1_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt1_eyescanreset_i              : std_logic;
    signal  gt1_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt1_eyescandataerror_i          : std_logic;
    signal  gt1_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt1_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt1_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt1_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt1_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt1_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt1_rxbyteisaligned_i           : std_logic;
    signal  gt1_rxmcommaalignen_i           : std_logic;
    signal  gt1_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt1_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt1_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt1_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt1_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt1_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt1_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt1_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt1_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt1_gttxreset_i                 : std_logic;
    signal  gt1_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt1_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt1_gthtxn_i                    : std_logic;
    signal  gt1_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt1_txoutclk_i                  : std_logic;
    signal  gt1_txoutclkfabric_i            : std_logic;
    signal  gt1_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt1_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt1_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt1_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT2  (X0Y2)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt2_cpllfbclklost_i             : std_logic;
    signal  gt2_cplllock_i                  : std_logic;
    signal  gt2_cpllrefclklost_i            : std_logic;
    signal  gt2_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt2_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt2_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt2_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt2_drpen_i                     : std_logic;
    signal  gt2_drprdy_i                    : std_logic;
    signal  gt2_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt2_eyescanreset_i              : std_logic;
    signal  gt2_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt2_eyescandataerror_i          : std_logic;
    signal  gt2_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt2_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt2_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt2_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt2_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt2_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt2_rxbyteisaligned_i           : std_logic;
    signal  gt2_rxmcommaalignen_i           : std_logic;
    signal  gt2_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt2_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt2_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt2_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt2_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt2_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt2_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt2_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt2_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt2_gttxreset_i                 : std_logic;
    signal  gt2_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt2_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt2_gthtxn_i                    : std_logic;
    signal  gt2_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt2_txoutclk_i                  : std_logic;
    signal  gt2_txoutclkfabric_i            : std_logic;
    signal  gt2_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt2_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt2_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt2_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT3  (X0Y3)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt3_cpllfbclklost_i             : std_logic;
    signal  gt3_cplllock_i                  : std_logic;
    signal  gt3_cpllrefclklost_i            : std_logic;
    signal  gt3_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt3_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt3_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt3_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt3_drpen_i                     : std_logic;
    signal  gt3_drprdy_i                    : std_logic;
    signal  gt3_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt3_eyescanreset_i              : std_logic;
    signal  gt3_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt3_eyescandataerror_i          : std_logic;
    signal  gt3_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt3_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt3_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt3_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt3_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt3_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt3_rxbyteisaligned_i           : std_logic;
    signal  gt3_rxmcommaalignen_i           : std_logic;
    signal  gt3_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt3_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt3_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt3_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt3_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt3_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt3_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt3_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt3_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt3_gttxreset_i                 : std_logic;
    signal  gt3_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt3_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt3_gthtxn_i                    : std_logic;
    signal  gt3_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt3_txoutclk_i                  : std_logic;
    signal  gt3_txoutclkfabric_i            : std_logic;
    signal  gt3_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt3_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt3_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt3_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT4  (X0Y4)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt4_cpllfbclklost_i             : std_logic;
    signal  gt4_cplllock_i                  : std_logic;
    signal  gt4_cpllrefclklost_i            : std_logic;
    signal  gt4_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt4_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt4_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt4_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt4_drpen_i                     : std_logic;
    signal  gt4_drprdy_i                    : std_logic;
    signal  gt4_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt4_eyescanreset_i              : std_logic;
    signal  gt4_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt4_eyescandataerror_i          : std_logic;
    signal  gt4_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt4_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt4_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt4_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt4_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt4_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt4_rxbyteisaligned_i           : std_logic;
    signal  gt4_rxmcommaalignen_i           : std_logic;
    signal  gt4_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt4_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt4_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt4_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt4_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt4_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt4_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt4_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt4_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt4_gttxreset_i                 : std_logic;
    signal  gt4_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt4_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt4_gthtxn_i                    : std_logic;
    signal  gt4_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt4_txoutclk_i                  : std_logic;
    signal  gt4_txoutclkfabric_i            : std_logic;
    signal  gt4_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt4_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt4_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt4_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT5  (X0Y5)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt5_cpllfbclklost_i             : std_logic;
    signal  gt5_cplllock_i                  : std_logic;
    signal  gt5_cpllrefclklost_i            : std_logic;
    signal  gt5_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt5_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt5_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt5_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt5_drpen_i                     : std_logic;
    signal  gt5_drprdy_i                    : std_logic;
    signal  gt5_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt5_eyescanreset_i              : std_logic;
    signal  gt5_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt5_eyescandataerror_i          : std_logic;
    signal  gt5_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt5_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt5_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt5_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt5_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt5_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt5_rxbyteisaligned_i           : std_logic;
    signal  gt5_rxmcommaalignen_i           : std_logic;
    signal  gt5_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt5_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt5_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt5_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt5_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt5_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt5_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt5_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt5_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt5_gttxreset_i                 : std_logic;
    signal  gt5_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt5_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt5_gthtxn_i                    : std_logic;
    signal  gt5_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt5_txoutclk_i                  : std_logic;
    signal  gt5_txoutclkfabric_i            : std_logic;
    signal  gt5_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt5_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt5_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt5_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT6  (X0Y6)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt6_cpllfbclklost_i             : std_logic;
    signal  gt6_cplllock_i                  : std_logic;
    signal  gt6_cpllrefclklost_i            : std_logic;
    signal  gt6_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt6_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt6_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt6_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt6_drpen_i                     : std_logic;
    signal  gt6_drprdy_i                    : std_logic;
    signal  gt6_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt6_eyescanreset_i              : std_logic;
    signal  gt6_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt6_eyescandataerror_i          : std_logic;
    signal  gt6_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt6_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt6_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt6_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt6_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt6_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt6_rxbyteisaligned_i           : std_logic;
    signal  gt6_rxmcommaalignen_i           : std_logic;
    signal  gt6_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt6_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt6_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt6_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt6_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt6_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt6_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt6_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt6_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt6_gttxreset_i                 : std_logic;
    signal  gt6_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt6_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt6_gthtxn_i                    : std_logic;
    signal  gt6_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt6_txoutclk_i                  : std_logic;
    signal  gt6_txoutclkfabric_i            : std_logic;
    signal  gt6_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt6_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt6_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt6_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT7  (X0Y7)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt7_cpllfbclklost_i             : std_logic;
    signal  gt7_cplllock_i                  : std_logic;
    signal  gt7_cpllrefclklost_i            : std_logic;
    signal  gt7_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt7_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt7_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt7_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt7_drpen_i                     : std_logic;
    signal  gt7_drprdy_i                    : std_logic;
    signal  gt7_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt7_eyescanreset_i              : std_logic;
    signal  gt7_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt7_eyescandataerror_i          : std_logic;
    signal  gt7_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt7_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt7_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt7_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt7_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt7_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt7_rxbyteisaligned_i           : std_logic;
    signal  gt7_rxmcommaalignen_i           : std_logic;
    signal  gt7_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt7_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt7_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt7_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt7_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt7_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt7_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt7_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt7_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt7_gttxreset_i                 : std_logic;
    signal  gt7_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt7_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt7_gthtxn_i                    : std_logic;
    signal  gt7_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt7_txoutclk_i                  : std_logic;
    signal  gt7_txoutclkfabric_i            : std_logic;
    signal  gt7_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt7_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt7_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt7_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT8  (X0Y8)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt8_cpllfbclklost_i             : std_logic;
    signal  gt8_cplllock_i                  : std_logic;
    signal  gt8_cpllrefclklost_i            : std_logic;
    signal  gt8_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt8_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt8_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt8_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt8_drpen_i                     : std_logic;
    signal  gt8_drprdy_i                    : std_logic;
    signal  gt8_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt8_eyescanreset_i              : std_logic;
    signal  gt8_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt8_eyescandataerror_i          : std_logic;
    signal  gt8_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt8_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt8_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt8_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt8_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt8_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt8_rxbyteisaligned_i           : std_logic;
    signal  gt8_rxmcommaalignen_i           : std_logic;
    signal  gt8_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt8_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt8_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt8_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt8_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt8_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt8_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt8_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt8_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt8_gttxreset_i                 : std_logic;
    signal  gt8_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt8_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt8_gthtxn_i                    : std_logic;
    signal  gt8_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt8_txoutclk_i                  : std_logic;
    signal  gt8_txoutclkfabric_i            : std_logic;
    signal  gt8_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt8_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt8_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt8_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT9  (X0Y9)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt9_cpllfbclklost_i             : std_logic;
    signal  gt9_cplllock_i                  : std_logic;
    signal  gt9_cpllrefclklost_i            : std_logic;
    signal  gt9_cpllreset_i                 : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt9_drpaddr_i                   : std_logic_vector(8 downto 0);
    signal  gt9_drpdi_i                     : std_logic_vector(15 downto 0);
    signal  gt9_drpdo_i                     : std_logic_vector(15 downto 0);
    signal  gt9_drpen_i                     : std_logic;
    signal  gt9_drprdy_i                    : std_logic;
    signal  gt9_drpwe_i                     : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt9_eyescanreset_i              : std_logic;
    signal  gt9_rxuserrdy_i                 : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt9_eyescandataerror_i          : std_logic;
    signal  gt9_eyescantrigger_i            : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt9_dmonitorout_i               : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt9_rxdata_i                    : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt9_rxdisperr_i                 : std_logic_vector(3 downto 0);
    signal  gt9_rxnotintable_i              : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt9_gthrxn_i                    : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt9_rxbyteisaligned_i           : std_logic;
    signal  gt9_rxmcommaalignen_i           : std_logic;
    signal  gt9_rxpcommaalignen_i           : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt9_rxmonitorout_i              : std_logic_vector(6 downto 0);
    signal  gt9_rxmonitorsel_i              : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt9_rxoutclk_i                  : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt9_gtrxreset_i                 : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt9_rxpolarity_i                : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt9_rxcharisk_i                 : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt9_gthrxp_i                    : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt9_rxresetdone_i               : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt9_gttxreset_i                 : std_logic;
    signal  gt9_txuserrdy_i                 : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt9_txdata_i                    : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt9_gthtxn_i                    : std_logic;
    signal  gt9_gthtxp_i                    : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt9_txoutclk_i                  : std_logic;
    signal  gt9_txoutclkfabric_i            : std_logic;
    signal  gt9_txoutclkpcs_i               : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt9_txresetdone_i               : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt9_txpolarity_i                : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt9_txcharisk_i                 : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT10  (X0Y10)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt10_cpllfbclklost_i            : std_logic;
    signal  gt10_cplllock_i                 : std_logic;
    signal  gt10_cpllrefclklost_i           : std_logic;
    signal  gt10_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt10_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt10_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt10_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt10_drpen_i                    : std_logic;
    signal  gt10_drprdy_i                   : std_logic;
    signal  gt10_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt10_eyescanreset_i             : std_logic;
    signal  gt10_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt10_eyescandataerror_i         : std_logic;
    signal  gt10_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt10_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt10_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt10_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt10_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt10_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt10_rxbyteisaligned_i          : std_logic;
    signal  gt10_rxmcommaalignen_i          : std_logic;
    signal  gt10_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt10_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt10_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt10_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt10_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt10_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt10_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt10_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt10_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt10_gttxreset_i                : std_logic;
    signal  gt10_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt10_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt10_gthtxn_i                   : std_logic;
    signal  gt10_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt10_txoutclk_i                 : std_logic;
    signal  gt10_txoutclkfabric_i           : std_logic;
    signal  gt10_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt10_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt10_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt10_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT11  (X0Y11)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt11_cpllfbclklost_i            : std_logic;
    signal  gt11_cplllock_i                 : std_logic;
    signal  gt11_cpllrefclklost_i           : std_logic;
    signal  gt11_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt11_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt11_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt11_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt11_drpen_i                    : std_logic;
    signal  gt11_drprdy_i                   : std_logic;
    signal  gt11_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt11_eyescanreset_i             : std_logic;
    signal  gt11_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt11_eyescandataerror_i         : std_logic;
    signal  gt11_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt11_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt11_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt11_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt11_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt11_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt11_rxbyteisaligned_i          : std_logic;
    signal  gt11_rxmcommaalignen_i          : std_logic;
    signal  gt11_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt11_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt11_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt11_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt11_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt11_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt11_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt11_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt11_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt11_gttxreset_i                : std_logic;
    signal  gt11_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt11_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt11_gthtxn_i                   : std_logic;
    signal  gt11_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt11_txoutclk_i                 : std_logic;
    signal  gt11_txoutclkfabric_i           : std_logic;
    signal  gt11_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt11_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt11_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt11_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT12  (X0Y12)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt12_cpllfbclklost_i            : std_logic;
    signal  gt12_cplllock_i                 : std_logic;
    signal  gt12_cpllrefclklost_i           : std_logic;
    signal  gt12_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt12_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt12_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt12_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt12_drpen_i                    : std_logic;
    signal  gt12_drprdy_i                   : std_logic;
    signal  gt12_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt12_eyescanreset_i             : std_logic;
    signal  gt12_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt12_eyescandataerror_i         : std_logic;
    signal  gt12_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt12_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt12_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt12_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt12_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt12_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt12_rxbyteisaligned_i          : std_logic;
    signal  gt12_rxmcommaalignen_i          : std_logic;
    signal  gt12_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt12_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt12_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt12_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt12_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt12_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt12_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt12_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt12_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt12_gttxreset_i                : std_logic;
    signal  gt12_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt12_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt12_gthtxn_i                   : std_logic;
    signal  gt12_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt12_txoutclk_i                 : std_logic;
    signal  gt12_txoutclkfabric_i           : std_logic;
    signal  gt12_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt12_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt12_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt12_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT13  (X0Y13)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt13_cpllfbclklost_i            : std_logic;
    signal  gt13_cplllock_i                 : std_logic;
    signal  gt13_cpllrefclklost_i           : std_logic;
    signal  gt13_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt13_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt13_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt13_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt13_drpen_i                    : std_logic;
    signal  gt13_drprdy_i                   : std_logic;
    signal  gt13_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt13_eyescanreset_i             : std_logic;
    signal  gt13_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt13_eyescandataerror_i         : std_logic;
    signal  gt13_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt13_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt13_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt13_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt13_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt13_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt13_rxbyteisaligned_i          : std_logic;
    signal  gt13_rxmcommaalignen_i          : std_logic;
    signal  gt13_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt13_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt13_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt13_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt13_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt13_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt13_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt13_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt13_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt13_gttxreset_i                : std_logic;
    signal  gt13_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt13_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt13_gthtxn_i                   : std_logic;
    signal  gt13_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt13_txoutclk_i                 : std_logic;
    signal  gt13_txoutclkfabric_i           : std_logic;
    signal  gt13_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt13_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt13_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt13_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT14  (X0Y14)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt14_cpllfbclklost_i            : std_logic;
    signal  gt14_cplllock_i                 : std_logic;
    signal  gt14_cpllrefclklost_i           : std_logic;
    signal  gt14_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt14_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt14_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt14_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt14_drpen_i                    : std_logic;
    signal  gt14_drprdy_i                   : std_logic;
    signal  gt14_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt14_eyescanreset_i             : std_logic;
    signal  gt14_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt14_eyescandataerror_i         : std_logic;
    signal  gt14_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt14_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt14_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt14_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt14_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt14_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt14_rxbyteisaligned_i          : std_logic;
    signal  gt14_rxmcommaalignen_i          : std_logic;
    signal  gt14_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt14_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt14_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt14_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt14_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt14_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt14_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt14_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt14_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt14_gttxreset_i                : std_logic;
    signal  gt14_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt14_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt14_gthtxn_i                   : std_logic;
    signal  gt14_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt14_txoutclk_i                 : std_logic;
    signal  gt14_txoutclkfabric_i           : std_logic;
    signal  gt14_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt14_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt14_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt14_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT15  (X0Y15)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt15_cpllfbclklost_i            : std_logic;
    signal  gt15_cplllock_i                 : std_logic;
    signal  gt15_cpllrefclklost_i           : std_logic;
    signal  gt15_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt15_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt15_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt15_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt15_drpen_i                    : std_logic;
    signal  gt15_drprdy_i                   : std_logic;
    signal  gt15_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt15_eyescanreset_i             : std_logic;
    signal  gt15_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt15_eyescandataerror_i         : std_logic;
    signal  gt15_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt15_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt15_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt15_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt15_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt15_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt15_rxbyteisaligned_i          : std_logic;
    signal  gt15_rxmcommaalignen_i          : std_logic;
    signal  gt15_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt15_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt15_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt15_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt15_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt15_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt15_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt15_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt15_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt15_gttxreset_i                : std_logic;
    signal  gt15_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt15_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt15_gthtxn_i                   : std_logic;
    signal  gt15_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt15_txoutclk_i                 : std_logic;
    signal  gt15_txoutclkfabric_i           : std_logic;
    signal  gt15_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt15_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt15_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt15_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT16  (X0Y16)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt16_cpllfbclklost_i            : std_logic;
    signal  gt16_cplllock_i                 : std_logic;
    signal  gt16_cpllrefclklost_i           : std_logic;
    signal  gt16_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt16_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt16_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt16_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt16_drpen_i                    : std_logic;
    signal  gt16_drprdy_i                   : std_logic;
    signal  gt16_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt16_eyescanreset_i             : std_logic;
    signal  gt16_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt16_eyescandataerror_i         : std_logic;
    signal  gt16_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt16_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt16_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt16_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt16_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt16_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt16_rxbyteisaligned_i          : std_logic;
    signal  gt16_rxmcommaalignen_i          : std_logic;
    signal  gt16_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt16_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt16_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt16_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt16_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt16_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt16_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt16_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt16_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt16_gttxreset_i                : std_logic;
    signal  gt16_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt16_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt16_gthtxn_i                   : std_logic;
    signal  gt16_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt16_txoutclk_i                 : std_logic;
    signal  gt16_txoutclkfabric_i           : std_logic;
    signal  gt16_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt16_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt16_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt16_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT17  (X0Y17)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt17_cpllfbclklost_i            : std_logic;
    signal  gt17_cplllock_i                 : std_logic;
    signal  gt17_cpllrefclklost_i           : std_logic;
    signal  gt17_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt17_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt17_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt17_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt17_drpen_i                    : std_logic;
    signal  gt17_drprdy_i                   : std_logic;
    signal  gt17_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt17_eyescanreset_i             : std_logic;
    signal  gt17_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt17_eyescandataerror_i         : std_logic;
    signal  gt17_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt17_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt17_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt17_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt17_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt17_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt17_rxbyteisaligned_i          : std_logic;
    signal  gt17_rxmcommaalignen_i          : std_logic;
    signal  gt17_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt17_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt17_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt17_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt17_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt17_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt17_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt17_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt17_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt17_gttxreset_i                : std_logic;
    signal  gt17_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt17_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt17_gthtxn_i                   : std_logic;
    signal  gt17_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt17_txoutclk_i                 : std_logic;
    signal  gt17_txoutclkfabric_i           : std_logic;
    signal  gt17_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt17_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt17_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt17_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT18  (X0Y18)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt18_cpllfbclklost_i            : std_logic;
    signal  gt18_cplllock_i                 : std_logic;
    signal  gt18_cpllrefclklost_i           : std_logic;
    signal  gt18_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt18_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt18_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt18_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt18_drpen_i                    : std_logic;
    signal  gt18_drprdy_i                   : std_logic;
    signal  gt18_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt18_eyescanreset_i             : std_logic;
    signal  gt18_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt18_eyescandataerror_i         : std_logic;
    signal  gt18_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt18_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt18_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt18_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt18_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt18_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt18_rxbyteisaligned_i          : std_logic;
    signal  gt18_rxmcommaalignen_i          : std_logic;
    signal  gt18_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt18_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt18_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt18_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt18_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt18_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt18_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt18_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt18_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt18_gttxreset_i                : std_logic;
    signal  gt18_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt18_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt18_gthtxn_i                   : std_logic;
    signal  gt18_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt18_txoutclk_i                 : std_logic;
    signal  gt18_txoutclkfabric_i           : std_logic;
    signal  gt18_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt18_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt18_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt18_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT19  (X0Y19)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt19_cpllfbclklost_i            : std_logic;
    signal  gt19_cplllock_i                 : std_logic;
    signal  gt19_cpllrefclklost_i           : std_logic;
    signal  gt19_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt19_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt19_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt19_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt19_drpen_i                    : std_logic;
    signal  gt19_drprdy_i                   : std_logic;
    signal  gt19_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt19_eyescanreset_i             : std_logic;
    signal  gt19_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt19_eyescandataerror_i         : std_logic;
    signal  gt19_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt19_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt19_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt19_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt19_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt19_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt19_rxbyteisaligned_i          : std_logic;
    signal  gt19_rxmcommaalignen_i          : std_logic;
    signal  gt19_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt19_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt19_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt19_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt19_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt19_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt19_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt19_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt19_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt19_gttxreset_i                : std_logic;
    signal  gt19_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt19_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt19_gthtxn_i                   : std_logic;
    signal  gt19_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt19_txoutclk_i                 : std_logic;
    signal  gt19_txoutclkfabric_i           : std_logic;
    signal  gt19_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt19_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt19_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt19_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT20  (X0Y20)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt20_cpllfbclklost_i            : std_logic;
    signal  gt20_cplllock_i                 : std_logic;
    signal  gt20_cpllrefclklost_i           : std_logic;
    signal  gt20_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt20_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt20_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt20_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt20_drpen_i                    : std_logic;
    signal  gt20_drprdy_i                   : std_logic;
    signal  gt20_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt20_eyescanreset_i             : std_logic;
    signal  gt20_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt20_eyescandataerror_i         : std_logic;
    signal  gt20_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt20_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt20_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt20_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt20_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt20_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt20_rxbyteisaligned_i          : std_logic;
    signal  gt20_rxmcommaalignen_i          : std_logic;
    signal  gt20_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt20_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt20_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt20_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt20_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt20_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt20_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt20_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt20_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt20_gttxreset_i                : std_logic;
    signal  gt20_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt20_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt20_gthtxn_i                   : std_logic;
    signal  gt20_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt20_txoutclk_i                 : std_logic;
    signal  gt20_txoutclkfabric_i           : std_logic;
    signal  gt20_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt20_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt20_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt20_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT21  (X0Y21)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt21_cpllfbclklost_i            : std_logic;
    signal  gt21_cplllock_i                 : std_logic;
    signal  gt21_cpllrefclklost_i           : std_logic;
    signal  gt21_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt21_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt21_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt21_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt21_drpen_i                    : std_logic;
    signal  gt21_drprdy_i                   : std_logic;
    signal  gt21_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt21_eyescanreset_i             : std_logic;
    signal  gt21_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt21_eyescandataerror_i         : std_logic;
    signal  gt21_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt21_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt21_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt21_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt21_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt21_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt21_rxbyteisaligned_i          : std_logic;
    signal  gt21_rxmcommaalignen_i          : std_logic;
    signal  gt21_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt21_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt21_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt21_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt21_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt21_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt21_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt21_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt21_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt21_gttxreset_i                : std_logic;
    signal  gt21_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt21_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt21_gthtxn_i                   : std_logic;
    signal  gt21_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt21_txoutclk_i                 : std_logic;
    signal  gt21_txoutclkfabric_i           : std_logic;
    signal  gt21_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt21_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt21_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt21_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT22  (X0Y22)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt22_cpllfbclklost_i            : std_logic;
    signal  gt22_cplllock_i                 : std_logic;
    signal  gt22_cpllrefclklost_i           : std_logic;
    signal  gt22_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt22_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt22_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt22_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt22_drpen_i                    : std_logic;
    signal  gt22_drprdy_i                   : std_logic;
    signal  gt22_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt22_eyescanreset_i             : std_logic;
    signal  gt22_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt22_eyescandataerror_i         : std_logic;
    signal  gt22_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt22_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt22_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt22_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt22_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt22_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt22_rxbyteisaligned_i          : std_logic;
    signal  gt22_rxmcommaalignen_i          : std_logic;
    signal  gt22_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt22_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt22_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt22_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt22_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt22_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt22_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt22_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt22_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt22_gttxreset_i                : std_logic;
    signal  gt22_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt22_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt22_gthtxn_i                   : std_logic;
    signal  gt22_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt22_txoutclk_i                 : std_logic;
    signal  gt22_txoutclkfabric_i           : std_logic;
    signal  gt22_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt22_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt22_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt22_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT23  (X0Y23)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt23_cpllfbclklost_i            : std_logic;
    signal  gt23_cplllock_i                 : std_logic;
    signal  gt23_cpllrefclklost_i           : std_logic;
    signal  gt23_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt23_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt23_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt23_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt23_drpen_i                    : std_logic;
    signal  gt23_drprdy_i                   : std_logic;
    signal  gt23_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt23_eyescanreset_i             : std_logic;
    signal  gt23_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt23_eyescandataerror_i         : std_logic;
    signal  gt23_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt23_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt23_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt23_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt23_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt23_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt23_rxbyteisaligned_i          : std_logic;
    signal  gt23_rxmcommaalignen_i          : std_logic;
    signal  gt23_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt23_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt23_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt23_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt23_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt23_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt23_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt23_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt23_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt23_gttxreset_i                : std_logic;
    signal  gt23_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt23_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt23_gthtxn_i                   : std_logic;
    signal  gt23_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt23_txoutclk_i                 : std_logic;
    signal  gt23_txoutclkfabric_i           : std_logic;
    signal  gt23_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt23_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt23_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt23_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT24  (X0Y24)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt24_cpllfbclklost_i            : std_logic;
    signal  gt24_cplllock_i                 : std_logic;
    signal  gt24_cpllrefclklost_i           : std_logic;
    signal  gt24_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt24_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt24_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt24_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt24_drpen_i                    : std_logic;
    signal  gt24_drprdy_i                   : std_logic;
    signal  gt24_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt24_eyescanreset_i             : std_logic;
    signal  gt24_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt24_eyescandataerror_i         : std_logic;
    signal  gt24_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt24_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt24_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt24_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt24_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt24_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt24_rxbyteisaligned_i          : std_logic;
    signal  gt24_rxmcommaalignen_i          : std_logic;
    signal  gt24_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt24_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt24_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt24_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt24_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt24_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt24_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt24_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt24_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt24_gttxreset_i                : std_logic;
    signal  gt24_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt24_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt24_gthtxn_i                   : std_logic;
    signal  gt24_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt24_txoutclk_i                 : std_logic;
    signal  gt24_txoutclkfabric_i           : std_logic;
    signal  gt24_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt24_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt24_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt24_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT25  (X0Y25)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt25_cpllfbclklost_i            : std_logic;
    signal  gt25_cplllock_i                 : std_logic;
    signal  gt25_cpllrefclklost_i           : std_logic;
    signal  gt25_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt25_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt25_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt25_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt25_drpen_i                    : std_logic;
    signal  gt25_drprdy_i                   : std_logic;
    signal  gt25_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt25_eyescanreset_i             : std_logic;
    signal  gt25_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt25_eyescandataerror_i         : std_logic;
    signal  gt25_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt25_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt25_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt25_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt25_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt25_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt25_rxbyteisaligned_i          : std_logic;
    signal  gt25_rxmcommaalignen_i          : std_logic;
    signal  gt25_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt25_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt25_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt25_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt25_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt25_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt25_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt25_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt25_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt25_gttxreset_i                : std_logic;
    signal  gt25_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt25_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt25_gthtxn_i                   : std_logic;
    signal  gt25_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt25_txoutclk_i                 : std_logic;
    signal  gt25_txoutclkfabric_i           : std_logic;
    signal  gt25_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt25_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt25_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt25_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT26  (X0Y26)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt26_cpllfbclklost_i            : std_logic;
    signal  gt26_cplllock_i                 : std_logic;
    signal  gt26_cpllrefclklost_i           : std_logic;
    signal  gt26_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt26_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt26_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt26_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt26_drpen_i                    : std_logic;
    signal  gt26_drprdy_i                   : std_logic;
    signal  gt26_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt26_eyescanreset_i             : std_logic;
    signal  gt26_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt26_eyescandataerror_i         : std_logic;
    signal  gt26_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt26_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt26_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt26_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt26_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt26_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt26_rxbyteisaligned_i          : std_logic;
    signal  gt26_rxmcommaalignen_i          : std_logic;
    signal  gt26_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt26_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt26_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt26_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt26_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt26_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt26_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt26_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt26_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt26_gttxreset_i                : std_logic;
    signal  gt26_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt26_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt26_gthtxn_i                   : std_logic;
    signal  gt26_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt26_txoutclk_i                 : std_logic;
    signal  gt26_txoutclkfabric_i           : std_logic;
    signal  gt26_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt26_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt26_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt26_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT27  (X0Y27)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt27_cpllfbclklost_i            : std_logic;
    signal  gt27_cplllock_i                 : std_logic;
    signal  gt27_cpllrefclklost_i           : std_logic;
    signal  gt27_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt27_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt27_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt27_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt27_drpen_i                    : std_logic;
    signal  gt27_drprdy_i                   : std_logic;
    signal  gt27_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt27_eyescanreset_i             : std_logic;
    signal  gt27_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt27_eyescandataerror_i         : std_logic;
    signal  gt27_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt27_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt27_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt27_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt27_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt27_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt27_rxbyteisaligned_i          : std_logic;
    signal  gt27_rxmcommaalignen_i          : std_logic;
    signal  gt27_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt27_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt27_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt27_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt27_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt27_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt27_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt27_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt27_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt27_gttxreset_i                : std_logic;
    signal  gt27_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt27_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt27_gthtxn_i                   : std_logic;
    signal  gt27_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt27_txoutclk_i                 : std_logic;
    signal  gt27_txoutclkfabric_i           : std_logic;
    signal  gt27_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt27_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt27_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt27_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT28  (X0Y28)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt28_cpllfbclklost_i            : std_logic;
    signal  gt28_cplllock_i                 : std_logic;
    signal  gt28_cpllrefclklost_i           : std_logic;
    signal  gt28_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt28_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt28_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt28_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt28_drpen_i                    : std_logic;
    signal  gt28_drprdy_i                   : std_logic;
    signal  gt28_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt28_eyescanreset_i             : std_logic;
    signal  gt28_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt28_eyescandataerror_i         : std_logic;
    signal  gt28_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt28_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt28_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt28_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt28_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt28_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt28_rxbyteisaligned_i          : std_logic;
    signal  gt28_rxmcommaalignen_i          : std_logic;
    signal  gt28_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt28_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt28_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt28_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt28_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt28_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt28_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt28_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt28_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt28_gttxreset_i                : std_logic;
    signal  gt28_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt28_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt28_gthtxn_i                   : std_logic;
    signal  gt28_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt28_txoutclk_i                 : std_logic;
    signal  gt28_txoutclkfabric_i           : std_logic;
    signal  gt28_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt28_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt28_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt28_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT29  (X0Y29)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt29_cpllfbclklost_i            : std_logic;
    signal  gt29_cplllock_i                 : std_logic;
    signal  gt29_cpllrefclklost_i           : std_logic;
    signal  gt29_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt29_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt29_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt29_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt29_drpen_i                    : std_logic;
    signal  gt29_drprdy_i                   : std_logic;
    signal  gt29_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt29_eyescanreset_i             : std_logic;
    signal  gt29_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt29_eyescandataerror_i         : std_logic;
    signal  gt29_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt29_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt29_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt29_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt29_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt29_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt29_rxbyteisaligned_i          : std_logic;
    signal  gt29_rxmcommaalignen_i          : std_logic;
    signal  gt29_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt29_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt29_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt29_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt29_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt29_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt29_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt29_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt29_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt29_gttxreset_i                : std_logic;
    signal  gt29_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt29_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt29_gthtxn_i                   : std_logic;
    signal  gt29_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt29_txoutclk_i                 : std_logic;
    signal  gt29_txoutclkfabric_i           : std_logic;
    signal  gt29_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt29_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt29_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt29_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT30  (X0Y30)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt30_cpllfbclklost_i            : std_logic;
    signal  gt30_cplllock_i                 : std_logic;
    signal  gt30_cpllrefclklost_i           : std_logic;
    signal  gt30_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt30_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt30_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt30_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt30_drpen_i                    : std_logic;
    signal  gt30_drprdy_i                   : std_logic;
    signal  gt30_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt30_eyescanreset_i             : std_logic;
    signal  gt30_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt30_eyescandataerror_i         : std_logic;
    signal  gt30_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt30_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt30_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt30_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt30_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt30_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt30_rxbyteisaligned_i          : std_logic;
    signal  gt30_rxmcommaalignen_i          : std_logic;
    signal  gt30_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt30_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt30_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt30_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt30_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt30_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt30_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt30_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt30_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt30_gttxreset_i                : std_logic;
    signal  gt30_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt30_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt30_gthtxn_i                   : std_logic;
    signal  gt30_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt30_txoutclk_i                 : std_logic;
    signal  gt30_txoutclkfabric_i           : std_logic;
    signal  gt30_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt30_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt30_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt30_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT31  (X0Y31)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt31_cpllfbclklost_i            : std_logic;
    signal  gt31_cplllock_i                 : std_logic;
    signal  gt31_cpllrefclklost_i           : std_logic;
    signal  gt31_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt31_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt31_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt31_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt31_drpen_i                    : std_logic;
    signal  gt31_drprdy_i                   : std_logic;
    signal  gt31_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt31_eyescanreset_i             : std_logic;
    signal  gt31_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt31_eyescandataerror_i         : std_logic;
    signal  gt31_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt31_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt31_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt31_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt31_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt31_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt31_rxbyteisaligned_i          : std_logic;
    signal  gt31_rxmcommaalignen_i          : std_logic;
    signal  gt31_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt31_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt31_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt31_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt31_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt31_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt31_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt31_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt31_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt31_gttxreset_i                : std_logic;
    signal  gt31_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt31_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt31_gthtxn_i                   : std_logic;
    signal  gt31_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt31_txoutclk_i                 : std_logic;
    signal  gt31_txoutclkfabric_i           : std_logic;
    signal  gt31_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt31_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt31_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt31_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT32  (X0Y32)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt32_cpllfbclklost_i            : std_logic;
    signal  gt32_cplllock_i                 : std_logic;
    signal  gt32_cpllrefclklost_i           : std_logic;
    signal  gt32_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt32_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt32_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt32_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt32_drpen_i                    : std_logic;
    signal  gt32_drprdy_i                   : std_logic;
    signal  gt32_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt32_eyescanreset_i             : std_logic;
    signal  gt32_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt32_eyescandataerror_i         : std_logic;
    signal  gt32_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt32_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt32_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt32_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt32_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt32_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt32_rxbyteisaligned_i          : std_logic;
    signal  gt32_rxmcommaalignen_i          : std_logic;
    signal  gt32_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt32_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt32_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt32_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt32_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt32_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt32_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt32_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt32_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt32_gttxreset_i                : std_logic;
    signal  gt32_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt32_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt32_gthtxn_i                   : std_logic;
    signal  gt32_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt32_txoutclk_i                 : std_logic;
    signal  gt32_txoutclkfabric_i           : std_logic;
    signal  gt32_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt32_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt32_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt32_txcharisk_i                : std_logic_vector(3 downto 0);


    --________________________________________________________________________
    --________________________________________________________________________
    --GT33  (X0Y33)

    --------------------------------- CPLL Ports -------------------------------
    signal  gt33_cpllfbclklost_i            : std_logic;
    signal  gt33_cplllock_i                 : std_logic;
    signal  gt33_cpllrefclklost_i           : std_logic;
    signal  gt33_cpllreset_i                : std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    signal  gt33_drpaddr_i                  : std_logic_vector(8 downto 0);
    signal  gt33_drpdi_i                    : std_logic_vector(15 downto 0);
    signal  gt33_drpdo_i                    : std_logic_vector(15 downto 0);
    signal  gt33_drpen_i                    : std_logic;
    signal  gt33_drprdy_i                   : std_logic;
    signal  gt33_drpwe_i                    : std_logic;
    --------------------- RX Initialization and Reset Ports --------------------
    signal  gt33_eyescanreset_i             : std_logic;
    signal  gt33_rxuserrdy_i                : std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    signal  gt33_eyescandataerror_i         : std_logic;
    signal  gt33_eyescantrigger_i           : std_logic;
    ------------------- Receive Ports - Digital Monitor Ports ------------------
    signal  gt33_dmonitorout_i              : std_logic_vector(14 downto 0);
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    signal  gt33_rxdata_i                   : std_logic_vector(31 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    signal  gt33_rxdisperr_i                : std_logic_vector(3 downto 0);
    signal  gt33_rxnotintable_i             : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    signal  gt33_gthrxn_i                   : std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    signal  gt33_rxbyteisaligned_i          : std_logic;
    signal  gt33_rxmcommaalignen_i          : std_logic;
    signal  gt33_rxpcommaalignen_i          : std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    signal  gt33_rxmonitorout_i             : std_logic_vector(6 downto 0);
    signal  gt33_rxmonitorsel_i             : std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    signal  gt33_rxoutclk_i                 : std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    signal  gt33_gtrxreset_i                : std_logic;
    ----------------- Receive Ports - RX Polarity Control Ports ----------------
    signal  gt33_rxpolarity_i               : std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    signal  gt33_rxcharisk_i                : std_logic_vector(3 downto 0);
    ------------------------ Receive Ports -RX AFE Ports -----------------------
    signal  gt33_gthrxp_i                   : std_logic;
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    signal  gt33_rxresetdone_i              : std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    signal  gt33_gttxreset_i                : std_logic;
    signal  gt33_txuserrdy_i                : std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    signal  gt33_txdata_i                   : std_logic_vector(31 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    signal  gt33_gthtxn_i                   : std_logic;
    signal  gt33_gthtxp_i                   : std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    signal  gt33_txoutclk_i                 : std_logic;
    signal  gt33_txoutclkfabric_i           : std_logic;
    signal  gt33_txoutclkpcs_i              : std_logic;
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    signal  gt33_txresetdone_i              : std_logic;
    ----------------- Transmit Ports - TX Polarity Control Ports ---------------
    signal  gt33_txpolarity_i               : std_logic;
    ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
    signal  gt33_txcharisk_i                : std_logic_vector(3 downto 0);



    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt0_qplllock_i                  : std_logic;
    signal  gt0_qpllrefclklost_i            : std_logic;
    signal  gt0_qpllreset_i                 : std_logic;

    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt1_qplllock_i                  : std_logic;
    signal  gt1_qpllrefclklost_i            : std_logic;
    signal  gt1_qpllreset_i                 : std_logic;

    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt2_qplllock_i                  : std_logic;
    signal  gt2_qpllrefclklost_i            : std_logic;
    signal  gt2_qpllreset_i                 : std_logic;

    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt3_qplllock_i                  : std_logic;
    signal  gt3_qpllrefclklost_i            : std_logic;
    signal  gt3_qpllreset_i                 : std_logic;

    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt4_qplllock_i                  : std_logic;
    signal  gt4_qpllrefclklost_i            : std_logic;
    signal  gt4_qpllreset_i                 : std_logic;

    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt5_qplllock_i                  : std_logic;
    signal  gt5_qpllrefclklost_i            : std_logic;
    signal  gt5_qpllreset_i                 : std_logic;

    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt6_qplllock_i                  : std_logic;
    signal  gt6_qpllrefclklost_i            : std_logic;
    signal  gt6_qpllreset_i                 : std_logic;

    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt7_qplllock_i                  : std_logic;
    signal  gt7_qpllrefclklost_i            : std_logic;
    signal  gt7_qpllreset_i                 : std_logic;

    --____________________________COMMON PORTS________________________________
    ------------------------- Common Block - QPLL Ports ------------------------
    signal  gt8_qplllock_i                  : std_logic;
    signal  gt8_qpllrefclklost_i            : std_logic;
    signal  gt8_qpllreset_i                 : std_logic;



    signal  tied_to_ground_i                : std_logic;
    signal  tied_to_ground_vec_i            : std_logic_vector(63 downto 0);
    signal  tied_to_vcc_i                   : std_logic;
    signal  tied_to_vcc_vec_i               : std_logic_vector(7 downto 0);
    signal  drpclk_in_i                     : std_logic;
    signal  GTTXRESET_IN                    : std_logic;
    signal  GTRXRESET_IN                    : std_logic;
    signal  CPLLRESET_IN                    : std_logic;
    signal  QPLLRESET_IN                    : std_logic;

    attribute keep: string;
   ------------------------------- User Clocks ---------------------------------
    signal    gt0_txusrclk_i                  : std_logic; 
    signal    gt0_txusrclk2_i                 : std_logic; 
    signal    gt0_rxusrclk_i                  : std_logic; 
    signal    gt0_rxusrclk2_i                 : std_logic; 
    attribute keep of gt0_txusrclk_i : signal is "true";
    attribute keep of gt0_txusrclk2_i : signal is "true";
    attribute keep of gt0_rxusrclk_i : signal is "true";
    attribute keep of gt0_rxusrclk2_i : signal is "true";

    signal    gt1_txusrclk_i                  : std_logic; 
    signal    gt1_txusrclk2_i                 : std_logic; 
    signal    gt1_rxusrclk_i                  : std_logic; 
    signal    gt1_rxusrclk2_i                 : std_logic; 
    attribute keep of gt1_txusrclk_i : signal is "true";
    attribute keep of gt1_txusrclk2_i : signal is "true";
    attribute keep of gt1_rxusrclk_i : signal is "true";
    attribute keep of gt1_rxusrclk2_i : signal is "true";

    signal    gt2_txusrclk_i                  : std_logic; 
    signal    gt2_txusrclk2_i                 : std_logic; 
    signal    gt2_rxusrclk_i                  : std_logic; 
    signal    gt2_rxusrclk2_i                 : std_logic; 
    attribute keep of gt2_txusrclk_i : signal is "true";
    attribute keep of gt2_txusrclk2_i : signal is "true";
    attribute keep of gt2_rxusrclk_i : signal is "true";
    attribute keep of gt2_rxusrclk2_i : signal is "true";

    signal    gt3_txusrclk_i                  : std_logic; 
    signal    gt3_txusrclk2_i                 : std_logic; 
    signal    gt3_rxusrclk_i                  : std_logic; 
    signal    gt3_rxusrclk2_i                 : std_logic; 
    attribute keep of gt3_txusrclk_i : signal is "true";
    attribute keep of gt3_txusrclk2_i : signal is "true";
    attribute keep of gt3_rxusrclk_i : signal is "true";
    attribute keep of gt3_rxusrclk2_i : signal is "true";

    signal    gt4_txusrclk_i                  : std_logic; 
    signal    gt4_txusrclk2_i                 : std_logic; 
    signal    gt4_rxusrclk_i                  : std_logic; 
    signal    gt4_rxusrclk2_i                 : std_logic; 
    attribute keep of gt4_txusrclk_i : signal is "true";
    attribute keep of gt4_txusrclk2_i : signal is "true";
    attribute keep of gt4_rxusrclk_i : signal is "true";
    attribute keep of gt4_rxusrclk2_i : signal is "true";

    signal    gt5_txusrclk_i                  : std_logic; 
    signal    gt5_txusrclk2_i                 : std_logic; 
    signal    gt5_rxusrclk_i                  : std_logic; 
    signal    gt5_rxusrclk2_i                 : std_logic; 
    attribute keep of gt5_txusrclk_i : signal is "true";
    attribute keep of gt5_txusrclk2_i : signal is "true";
    attribute keep of gt5_rxusrclk_i : signal is "true";
    attribute keep of gt5_rxusrclk2_i : signal is "true";

    signal    gt6_txusrclk_i                  : std_logic; 
    signal    gt6_txusrclk2_i                 : std_logic; 
    signal    gt6_rxusrclk_i                  : std_logic; 
    signal    gt6_rxusrclk2_i                 : std_logic; 
    attribute keep of gt6_txusrclk_i : signal is "true";
    attribute keep of gt6_txusrclk2_i : signal is "true";
    attribute keep of gt6_rxusrclk_i : signal is "true";
    attribute keep of gt6_rxusrclk2_i : signal is "true";

    signal    gt7_txusrclk_i                  : std_logic; 
    signal    gt7_txusrclk2_i                 : std_logic; 
    signal    gt7_rxusrclk_i                  : std_logic; 
    signal    gt7_rxusrclk2_i                 : std_logic; 
    attribute keep of gt7_txusrclk_i : signal is "true";
    attribute keep of gt7_txusrclk2_i : signal is "true";
    attribute keep of gt7_rxusrclk_i : signal is "true";
    attribute keep of gt7_rxusrclk2_i : signal is "true";

    signal    gt8_txusrclk_i                  : std_logic; 
    signal    gt8_txusrclk2_i                 : std_logic; 
    signal    gt8_rxusrclk_i                  : std_logic; 
    signal    gt8_rxusrclk2_i                 : std_logic; 
    attribute keep of gt8_txusrclk_i : signal is "true";
    attribute keep of gt8_txusrclk2_i : signal is "true";
    attribute keep of gt8_rxusrclk_i : signal is "true";
    attribute keep of gt8_rxusrclk2_i : signal is "true";

    signal    gt9_txusrclk_i                  : std_logic; 
    signal    gt9_txusrclk2_i                 : std_logic; 
    signal    gt9_rxusrclk_i                  : std_logic; 
    signal    gt9_rxusrclk2_i                 : std_logic; 
    attribute keep of gt9_txusrclk_i : signal is "true";
    attribute keep of gt9_txusrclk2_i : signal is "true";
    attribute keep of gt9_rxusrclk_i : signal is "true";
    attribute keep of gt9_rxusrclk2_i : signal is "true";

    signal    gt10_txusrclk_i                 : std_logic; 
    signal    gt10_txusrclk2_i                : std_logic; 
    signal    gt10_rxusrclk_i                 : std_logic; 
    signal    gt10_rxusrclk2_i                : std_logic; 
    attribute keep of gt10_txusrclk_i : signal is "true";
    attribute keep of gt10_txusrclk2_i : signal is "true";
    attribute keep of gt10_rxusrclk_i : signal is "true";
    attribute keep of gt10_rxusrclk2_i : signal is "true";

    signal    gt11_txusrclk_i                 : std_logic; 
    signal    gt11_txusrclk2_i                : std_logic; 
    signal    gt11_rxusrclk_i                 : std_logic; 
    signal    gt11_rxusrclk2_i                : std_logic; 
    attribute keep of gt11_txusrclk_i : signal is "true";
    attribute keep of gt11_txusrclk2_i : signal is "true";
    attribute keep of gt11_rxusrclk_i : signal is "true";
    attribute keep of gt11_rxusrclk2_i : signal is "true";

    signal    gt12_txusrclk_i                 : std_logic; 
    signal    gt12_txusrclk2_i                : std_logic; 
    signal    gt12_rxusrclk_i                 : std_logic; 
    signal    gt12_rxusrclk2_i                : std_logic; 
    attribute keep of gt12_txusrclk_i : signal is "true";
    attribute keep of gt12_txusrclk2_i : signal is "true";
    attribute keep of gt12_rxusrclk_i : signal is "true";
    attribute keep of gt12_rxusrclk2_i : signal is "true";

    signal    gt13_txusrclk_i                 : std_logic; 
    signal    gt13_txusrclk2_i                : std_logic; 
    signal    gt13_rxusrclk_i                 : std_logic; 
    signal    gt13_rxusrclk2_i                : std_logic; 
    attribute keep of gt13_txusrclk_i : signal is "true";
    attribute keep of gt13_txusrclk2_i : signal is "true";
    attribute keep of gt13_rxusrclk_i : signal is "true";
    attribute keep of gt13_rxusrclk2_i : signal is "true";

    signal    gt14_txusrclk_i                 : std_logic; 
    signal    gt14_txusrclk2_i                : std_logic; 
    signal    gt14_rxusrclk_i                 : std_logic; 
    signal    gt14_rxusrclk2_i                : std_logic; 
    attribute keep of gt14_txusrclk_i : signal is "true";
    attribute keep of gt14_txusrclk2_i : signal is "true";
    attribute keep of gt14_rxusrclk_i : signal is "true";
    attribute keep of gt14_rxusrclk2_i : signal is "true";

    signal    gt15_txusrclk_i                 : std_logic; 
    signal    gt15_txusrclk2_i                : std_logic; 
    signal    gt15_rxusrclk_i                 : std_logic; 
    signal    gt15_rxusrclk2_i                : std_logic; 
    attribute keep of gt15_txusrclk_i : signal is "true";
    attribute keep of gt15_txusrclk2_i : signal is "true";
    attribute keep of gt15_rxusrclk_i : signal is "true";
    attribute keep of gt15_rxusrclk2_i : signal is "true";

    signal    gt16_txusrclk_i                 : std_logic; 
    signal    gt16_txusrclk2_i                : std_logic; 
    signal    gt16_rxusrclk_i                 : std_logic; 
    signal    gt16_rxusrclk2_i                : std_logic; 
    attribute keep of gt16_txusrclk_i : signal is "true";
    attribute keep of gt16_txusrclk2_i : signal is "true";
    attribute keep of gt16_rxusrclk_i : signal is "true";
    attribute keep of gt16_rxusrclk2_i : signal is "true";

    signal    gt17_txusrclk_i                 : std_logic; 
    signal    gt17_txusrclk2_i                : std_logic; 
    signal    gt17_rxusrclk_i                 : std_logic; 
    signal    gt17_rxusrclk2_i                : std_logic; 
    attribute keep of gt17_txusrclk_i : signal is "true";
    attribute keep of gt17_txusrclk2_i : signal is "true";
    attribute keep of gt17_rxusrclk_i : signal is "true";
    attribute keep of gt17_rxusrclk2_i : signal is "true";

    signal    gt18_txusrclk_i                 : std_logic; 
    signal    gt18_txusrclk2_i                : std_logic; 
    signal    gt18_rxusrclk_i                 : std_logic; 
    signal    gt18_rxusrclk2_i                : std_logic; 
    attribute keep of gt18_txusrclk_i : signal is "true";
    attribute keep of gt18_txusrclk2_i : signal is "true";
    attribute keep of gt18_rxusrclk_i : signal is "true";
    attribute keep of gt18_rxusrclk2_i : signal is "true";

    signal    gt19_txusrclk_i                 : std_logic; 
    signal    gt19_txusrclk2_i                : std_logic; 
    signal    gt19_rxusrclk_i                 : std_logic; 
    signal    gt19_rxusrclk2_i                : std_logic; 
    attribute keep of gt19_txusrclk_i : signal is "true";
    attribute keep of gt19_txusrclk2_i : signal is "true";
    attribute keep of gt19_rxusrclk_i : signal is "true";
    attribute keep of gt19_rxusrclk2_i : signal is "true";

    signal    gt20_txusrclk_i                 : std_logic; 
    signal    gt20_txusrclk2_i                : std_logic; 
    signal    gt20_rxusrclk_i                 : std_logic; 
    signal    gt20_rxusrclk2_i                : std_logic; 
    attribute keep of gt20_txusrclk_i : signal is "true";
    attribute keep of gt20_txusrclk2_i : signal is "true";
    attribute keep of gt20_rxusrclk_i : signal is "true";
    attribute keep of gt20_rxusrclk2_i : signal is "true";

    signal    gt21_txusrclk_i                 : std_logic; 
    signal    gt21_txusrclk2_i                : std_logic; 
    signal    gt21_rxusrclk_i                 : std_logic; 
    signal    gt21_rxusrclk2_i                : std_logic; 
    attribute keep of gt21_txusrclk_i : signal is "true";
    attribute keep of gt21_txusrclk2_i : signal is "true";
    attribute keep of gt21_rxusrclk_i : signal is "true";
    attribute keep of gt21_rxusrclk2_i : signal is "true";

    signal    gt22_txusrclk_i                 : std_logic; 
    signal    gt22_txusrclk2_i                : std_logic; 
    signal    gt22_rxusrclk_i                 : std_logic; 
    signal    gt22_rxusrclk2_i                : std_logic; 
    attribute keep of gt22_txusrclk_i : signal is "true";
    attribute keep of gt22_txusrclk2_i : signal is "true";
    attribute keep of gt22_rxusrclk_i : signal is "true";
    attribute keep of gt22_rxusrclk2_i : signal is "true";

    signal    gt23_txusrclk_i                 : std_logic; 
    signal    gt23_txusrclk2_i                : std_logic; 
    signal    gt23_rxusrclk_i                 : std_logic; 
    signal    gt23_rxusrclk2_i                : std_logic; 
    attribute keep of gt23_txusrclk_i : signal is "true";
    attribute keep of gt23_txusrclk2_i : signal is "true";
    attribute keep of gt23_rxusrclk_i : signal is "true";
    attribute keep of gt23_rxusrclk2_i : signal is "true";

    signal    gt24_txusrclk_i                 : std_logic; 
    signal    gt24_txusrclk2_i                : std_logic; 
    signal    gt24_rxusrclk_i                 : std_logic; 
    signal    gt24_rxusrclk2_i                : std_logic; 
    attribute keep of gt24_txusrclk_i : signal is "true";
    attribute keep of gt24_txusrclk2_i : signal is "true";
    attribute keep of gt24_rxusrclk_i : signal is "true";
    attribute keep of gt24_rxusrclk2_i : signal is "true";

    signal    gt25_txusrclk_i                 : std_logic; 
    signal    gt25_txusrclk2_i                : std_logic; 
    signal    gt25_rxusrclk_i                 : std_logic; 
    signal    gt25_rxusrclk2_i                : std_logic; 
    attribute keep of gt25_txusrclk_i : signal is "true";
    attribute keep of gt25_txusrclk2_i : signal is "true";
    attribute keep of gt25_rxusrclk_i : signal is "true";
    attribute keep of gt25_rxusrclk2_i : signal is "true";

    signal    gt26_txusrclk_i                 : std_logic; 
    signal    gt26_txusrclk2_i                : std_logic; 
    signal    gt26_rxusrclk_i                 : std_logic; 
    signal    gt26_rxusrclk2_i                : std_logic; 
    attribute keep of gt26_txusrclk_i : signal is "true";
    attribute keep of gt26_txusrclk2_i : signal is "true";
    attribute keep of gt26_rxusrclk_i : signal is "true";
    attribute keep of gt26_rxusrclk2_i : signal is "true";

    signal    gt27_txusrclk_i                 : std_logic; 
    signal    gt27_txusrclk2_i                : std_logic; 
    signal    gt27_rxusrclk_i                 : std_logic; 
    signal    gt27_rxusrclk2_i                : std_logic; 
    attribute keep of gt27_txusrclk_i : signal is "true";
    attribute keep of gt27_txusrclk2_i : signal is "true";
    attribute keep of gt27_rxusrclk_i : signal is "true";
    attribute keep of gt27_rxusrclk2_i : signal is "true";

    signal    gt28_txusrclk_i                 : std_logic; 
    signal    gt28_txusrclk2_i                : std_logic; 
    signal    gt28_rxusrclk_i                 : std_logic; 
    signal    gt28_rxusrclk2_i                : std_logic; 
    attribute keep of gt28_txusrclk_i : signal is "true";
    attribute keep of gt28_txusrclk2_i : signal is "true";
    attribute keep of gt28_rxusrclk_i : signal is "true";
    attribute keep of gt28_rxusrclk2_i : signal is "true";

    signal    gt29_txusrclk_i                 : std_logic; 
    signal    gt29_txusrclk2_i                : std_logic; 
    signal    gt29_rxusrclk_i                 : std_logic; 
    signal    gt29_rxusrclk2_i                : std_logic; 
    attribute keep of gt29_txusrclk_i : signal is "true";
    attribute keep of gt29_txusrclk2_i : signal is "true";
    attribute keep of gt29_rxusrclk_i : signal is "true";
    attribute keep of gt29_rxusrclk2_i : signal is "true";

    signal    gt30_txusrclk_i                 : std_logic; 
    signal    gt30_txusrclk2_i                : std_logic; 
    signal    gt30_rxusrclk_i                 : std_logic; 
    signal    gt30_rxusrclk2_i                : std_logic; 
    attribute keep of gt30_txusrclk_i : signal is "true";
    attribute keep of gt30_txusrclk2_i : signal is "true";
    attribute keep of gt30_rxusrclk_i : signal is "true";
    attribute keep of gt30_rxusrclk2_i : signal is "true";

    signal    gt31_txusrclk_i                 : std_logic; 
    signal    gt31_txusrclk2_i                : std_logic; 
    signal    gt31_rxusrclk_i                 : std_logic; 
    signal    gt31_rxusrclk2_i                : std_logic; 
    attribute keep of gt31_txusrclk_i : signal is "true";
    attribute keep of gt31_txusrclk2_i : signal is "true";
    attribute keep of gt31_rxusrclk_i : signal is "true";
    attribute keep of gt31_rxusrclk2_i : signal is "true";

    signal    gt32_txusrclk_i                 : std_logic; 
    signal    gt32_txusrclk2_i                : std_logic; 
    signal    gt32_rxusrclk_i                 : std_logic; 
    signal    gt32_rxusrclk2_i                : std_logic; 
    attribute keep of gt32_txusrclk_i : signal is "true";
    attribute keep of gt32_txusrclk2_i : signal is "true";
    attribute keep of gt32_rxusrclk_i : signal is "true";
    attribute keep of gt32_rxusrclk2_i : signal is "true";

    signal    gt33_txusrclk_i                 : std_logic; 
    signal    gt33_txusrclk2_i                : std_logic; 
    signal    gt33_rxusrclk_i                 : std_logic; 
    signal    gt33_rxusrclk2_i                : std_logic; 
    attribute keep of gt33_txusrclk_i : signal is "true";
    attribute keep of gt33_txusrclk2_i : signal is "true";
    attribute keep of gt33_rxusrclk_i : signal is "true";
    attribute keep of gt33_rxusrclk2_i : signal is "true";

    ----------------------------- Reference Clocks ----------------------------
    signal    q1_clk0_refclk_i                : std_logic;
    signal    q4_clk0_refclk_i                : std_logic;
    signal    q7_clk0_refclk_i                : std_logic;


   function and_reduce(arg: std_logic_vector) return std_logic is
   variable result: std_logic;
    begin
   result := '1';
   for i in arg'range loop
       result := result and arg(i);
   end loop;
        return result;
    end;

    constant gt0_track_data_i : std_logic := '1';
    constant gt1_track_data_i : std_logic := '1';
    constant gt2_track_data_i : std_logic := '1';
    constant gt3_track_data_i : std_logic := '1';
    constant gt4_track_data_i : std_logic := '1';
    constant gt5_track_data_i : std_logic := '1';
    constant gt6_track_data_i : std_logic := '1';
    constant gt7_track_data_i : std_logic := '1';
    constant gt8_track_data_i : std_logic := '1';
    constant gt9_track_data_i : std_logic := '1';
    constant gt10_track_data_i : std_logic := '1';
    constant gt11_track_data_i : std_logic := '1';
    constant gt12_track_data_i : std_logic := '1';
    constant gt13_track_data_i : std_logic := '1';
    constant gt14_track_data_i : std_logic := '1';
    constant gt15_track_data_i : std_logic := '1';
    constant gt16_track_data_i : std_logic := '1';
    constant gt17_track_data_i : std_logic := '1';
    constant gt18_track_data_i : std_logic := '1';
    constant gt19_track_data_i : std_logic := '1';
    constant gt20_track_data_i : std_logic := '1';
    constant gt21_track_data_i : std_logic := '1';
    constant gt22_track_data_i : std_logic := '1';
    constant gt23_track_data_i : std_logic := '1';
    constant gt24_track_data_i : std_logic := '1';
    constant gt25_track_data_i : std_logic := '1';
    constant gt26_track_data_i : std_logic := '1';
    constant gt27_track_data_i : std_logic := '1';
    constant gt28_track_data_i : std_logic := '1';
    constant gt29_track_data_i : std_logic := '1';
    constant gt30_track_data_i : std_logic := '1';
    constant gt31_track_data_i : std_logic := '1';
    constant gt32_track_data_i : std_logic := '1';
    constant gt33_track_data_i : std_logic := '1';

    signal gt_qpll_lock_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0) := (others => '0');

    signal power_on_reset_counter : std_logic_vector(27 downto 0) := (others => '0');
    signal power_on_reset_transceiver_i : std_logic;
    signal power_on_reset_link_i : std_logic;
    signal transceiver_reset_i   : std_logic;
    
--**************************** Main Body of Code *******************************
begin

  -- for transceiver power on reset
  process (drpclk_in_i) is
  begin
    if (drpclk_in_i'event and drpclk_in_i='1') then
      if (power_on_reset_counter(27)='0') then
        power_on_reset_counter <= power_on_reset_counter + 1;
        power_on_reset_transceiver_i <= not power_on_reset_counter(26);
      else
        NULL;
      end if;
    end if;
  end process;      
  power_on_reset_link_i <= (not power_on_reset_counter(27));
  transceiver_reset_i   <= power_on_reset_transceiver_i or TRANSCEIVER_RESET;
  POWER_ON_RESET_REQ_LINK <= power_on_reset_link_i;
  
  -- gt0
  gt0_txdata_i          <= GT_TX_DATA_IN(0);
  gt0_txcharisk_i       <= GT_TX_CHARISK_IN(0);
  GT_RX_DATA_OUT(0)         <= gt0_rxdata_i;
  GT_RX_CHARISK_OUT(0)      <= gt0_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(0)   <= gt0_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(0)   <= gt0_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(0) <= gt0_rxbyteisaligned_i;
  gt0_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(0) or (not gt0_rxresetdone_r3);
  gt0_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(0) or (not gt0_rxresetdone_r3);
  gt0_rxpolarity_i <= GT_RXPOLARITY_IN(0);
  gt0_txpolarity_i <= GT_TXPOLARITY_IN(0);
  GT_PLL_LOCK_OUT(0) <= gt0_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(0);
  
  -- gt1
  gt1_txdata_i          <= GT_TX_DATA_IN(1);
  gt1_txcharisk_i       <= GT_TX_CHARISK_IN(1);
  GT_RX_DATA_OUT(1)         <= gt1_rxdata_i;
  GT_RX_CHARISK_OUT(1)      <= gt1_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(1)   <= gt1_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(1)   <= gt1_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(1) <= gt1_rxbyteisaligned_i;
  gt1_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(1) or (not gt1_rxresetdone_r3);
  gt1_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(1) or (not gt1_rxresetdone_r3);
  gt1_rxpolarity_i <= GT_RXPOLARITY_IN(1);
  gt1_txpolarity_i <= GT_TXPOLARITY_IN(1);
  GT_PLL_LOCK_OUT(1) <= gt1_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(1);

  -- gt2
  gt2_txdata_i          <= GT_TX_DATA_IN(2);
  gt2_txcharisk_i       <= GT_TX_CHARISK_IN(2);
  GT_RX_DATA_OUT(2)         <= gt2_rxdata_i;
  GT_RX_CHARISK_OUT(2)      <= gt2_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(2)   <= gt2_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(2)   <= gt2_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(2) <= gt2_rxbyteisaligned_i;
  gt2_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(2) or (not gt2_rxresetdone_r3);
  gt2_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(2) or (not gt2_rxresetdone_r3);
  gt2_rxpolarity_i <= GT_RXPOLARITY_IN(2);
  gt2_txpolarity_i <= GT_TXPOLARITY_IN(2);
  GT_PLL_LOCK_OUT(2) <= gt2_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(2);

  -- gt3
  gt3_txdata_i          <= GT_TX_DATA_IN(3);
  gt3_txcharisk_i       <= GT_TX_CHARISK_IN(3);
  GT_RX_DATA_OUT(3)         <= gt3_rxdata_i;
  GT_RX_CHARISK_OUT(3)      <= gt3_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(3)   <= gt3_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(3)   <= gt3_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(3) <= gt3_rxbyteisaligned_i;
  gt3_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(3) or (not gt3_rxresetdone_r3);
  gt3_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(3) or (not gt3_rxresetdone_r3);
  gt3_rxpolarity_i <= GT_RXPOLARITY_IN(3);
  gt3_txpolarity_i <= GT_TXPOLARITY_IN(3);
  GT_PLL_LOCK_OUT(3) <= gt3_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(3);

  -- gt4
  gt4_txdata_i          <= GT_TX_DATA_IN(4);
  gt4_txcharisk_i       <= GT_TX_CHARISK_IN(4);
  GT_RX_DATA_OUT(4)         <= gt4_rxdata_i;
  GT_RX_CHARISK_OUT(4)      <= gt4_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(4)   <= gt4_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(4)   <= gt4_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(4) <= gt4_rxbyteisaligned_i;
  gt4_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(4) or (not gt4_rxresetdone_r3);
  gt4_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(4) or (not gt4_rxresetdone_r3);
  gt4_rxpolarity_i <= GT_RXPOLARITY_IN(4);
  gt4_txpolarity_i <= GT_TXPOLARITY_IN(4);
  GT_PLL_LOCK_OUT(4) <= gt4_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(4);

  -- gt5
  gt5_txdata_i          <= GT_TX_DATA_IN(5);
  gt5_txcharisk_i       <= GT_TX_CHARISK_IN(5);
  GT_RX_DATA_OUT(5)         <= gt5_rxdata_i;
  GT_RX_CHARISK_OUT(5)      <= gt5_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(5)   <= gt5_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(5)   <= gt5_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(5) <= gt5_rxbyteisaligned_i;
  gt5_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(5) or (not gt5_rxresetdone_r3);
  gt5_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(5) or (not gt5_rxresetdone_r3);
  gt5_rxpolarity_i <= GT_RXPOLARITY_IN(5);
  gt5_txpolarity_i <= GT_TXPOLARITY_IN(5);
  GT_PLL_LOCK_OUT(5) <= gt5_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(5);

  -- gt6
  gt6_txdata_i          <= GT_TX_DATA_IN(6);
  gt6_txcharisk_i       <= GT_TX_CHARISK_IN(6);
  GT_RX_DATA_OUT(6)         <= gt6_rxdata_i;
  GT_RX_CHARISK_OUT(6)      <= gt6_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(6)   <= gt6_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(6)   <= gt6_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(6) <= gt6_rxbyteisaligned_i;
  gt6_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(6) or (not gt6_rxresetdone_r3);
  gt6_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(6) or (not gt6_rxresetdone_r3);
  gt6_rxpolarity_i <= GT_RXPOLARITY_IN(6);
  gt6_txpolarity_i <= GT_TXPOLARITY_IN(6);
  GT_PLL_LOCK_OUT(6) <= gt6_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(7);

  -- gt7
  gt7_txdata_i          <= GT_TX_DATA_IN(7);
  gt7_txcharisk_i       <= GT_TX_CHARISK_IN(7);
  GT_RX_DATA_OUT(7)         <= gt7_rxdata_i;
  GT_RX_CHARISK_OUT(7)      <= gt7_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(7)   <= gt7_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(7)   <= gt7_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(7) <= gt7_rxbyteisaligned_i;
  gt7_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(7) or (not gt7_rxresetdone_r3);
  gt7_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(7) or (not gt7_rxresetdone_r3);
  gt7_rxpolarity_i <= GT_RXPOLARITY_IN(7);
  gt7_txpolarity_i <= GT_TXPOLARITY_IN(7);
  GT_PLL_LOCK_OUT(7) <= gt7_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(0);

  -- gt8
  gt8_txdata_i          <= GT_TX_DATA_IN(8);
  gt8_txcharisk_i       <= GT_TX_CHARISK_IN(8);
  GT_RX_DATA_OUT(8)         <= gt8_rxdata_i;
  GT_RX_CHARISK_OUT(8)      <= gt8_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(8)   <= gt8_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(8)   <= gt8_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(8) <= gt8_rxbyteisaligned_i;
  gt8_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(8) or (not gt8_rxresetdone_r3);
  gt8_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(8) or (not gt8_rxresetdone_r3);
  gt8_rxpolarity_i <= GT_RXPOLARITY_IN(8);
  gt8_txpolarity_i <= GT_TXPOLARITY_IN(8);
  GT_PLL_LOCK_OUT(8) <= gt8_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(8);

  -- gt9
  gt9_txdata_i          <= GT_TX_DATA_IN(9);
  gt9_txcharisk_i       <= GT_TX_CHARISK_IN(9);
  GT_RX_DATA_OUT(9)         <= gt9_rxdata_i;
  GT_RX_CHARISK_OUT(9)      <= gt9_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(9)   <= gt9_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(9)   <= gt9_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(9) <= gt9_rxbyteisaligned_i;
  gt9_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(9) or (not gt9_rxresetdone_r3);
  gt9_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(9) or (not gt9_rxresetdone_r3);
  gt9_rxpolarity_i <= GT_RXPOLARITY_IN(9);
  gt9_txpolarity_i <= GT_TXPOLARITY_IN(9);
  GT_PLL_LOCK_OUT(9) <= gt9_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(9);

  -- gt10
  gt10_txdata_i          <= GT_TX_DATA_IN(10);
  gt10_txcharisk_i       <= GT_TX_CHARISK_IN(10);
  GT_RX_DATA_OUT(10)         <= gt10_rxdata_i;
  GT_RX_CHARISK_OUT(10)      <= gt10_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(10)   <= gt10_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(10)   <= gt10_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(10) <= gt10_rxbyteisaligned_i;
  gt10_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(10) or (not gt10_rxresetdone_r3);
  gt10_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(10) or (not gt10_rxresetdone_r3);
  gt10_rxpolarity_i <= GT_RXPOLARITY_IN(10);
  gt10_txpolarity_i <= GT_TXPOLARITY_IN(10);
  GT_PLL_LOCK_OUT(10) <= gt10_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(10);

  -- gt11
  gt11_txdata_i          <= GT_TX_DATA_IN(11);
  gt11_txcharisk_i       <= GT_TX_CHARISK_IN(11);
  GT_RX_DATA_OUT(11)         <= gt11_rxdata_i;
  GT_RX_CHARISK_OUT(11)      <= gt11_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(11)   <= gt11_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(11)   <= gt11_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(11) <= gt11_rxbyteisaligned_i;
  gt11_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(11) or (not gt11_rxresetdone_r3);
  gt11_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(11) or (not gt11_rxresetdone_r3);
  gt11_rxpolarity_i <= GT_RXPOLARITY_IN(11);
  gt11_txpolarity_i <= GT_TXPOLARITY_IN(11);
  GT_PLL_LOCK_OUT(11) <= gt11_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(11);

  -- gt12
  gt12_txdata_i          <= GT_TX_DATA_IN(12);
  gt12_txcharisk_i       <= GT_TX_CHARISK_IN(12);
  GT_RX_DATA_OUT(12)         <= gt12_rxdata_i;
  GT_RX_CHARISK_OUT(12)      <= gt12_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(12)   <= gt12_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(12)   <= gt12_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(12) <= gt12_rxbyteisaligned_i;
  gt12_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(12) or (not gt12_rxresetdone_r3);
  gt12_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(12) or (not gt12_rxresetdone_r3);
  gt12_rxpolarity_i <= GT_RXPOLARITY_IN(12);
  gt12_txpolarity_i <= GT_TXPOLARITY_IN(12);
  GT_PLL_LOCK_OUT(12) <= gt12_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(12);

  -- gt13
  gt13_txdata_i          <= GT_TX_DATA_IN(13);
  gt13_txcharisk_i       <= GT_TX_CHARISK_IN(13);
  GT_RX_DATA_OUT(13)         <= gt13_rxdata_i;
  GT_RX_CHARISK_OUT(13)      <= gt13_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(13)   <= gt13_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(13)   <= gt13_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(13) <= gt13_rxbyteisaligned_i;
  gt13_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(13) or (not gt13_rxresetdone_r3);
  gt13_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(13) or (not gt13_rxresetdone_r3);
  gt13_rxpolarity_i <= GT_RXPOLARITY_IN(13);
  gt13_txpolarity_i <= GT_TXPOLARITY_IN(13);
  GT_PLL_LOCK_OUT(13) <= gt13_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(13);

  -- gt14
  gt14_txdata_i          <= GT_TX_DATA_IN(14);
  gt14_txcharisk_i       <= GT_TX_CHARISK_IN(14);
  GT_RX_DATA_OUT(14)         <= gt14_rxdata_i;
  GT_RX_CHARISK_OUT(14)      <= gt14_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(14)   <= gt14_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(14)   <= gt14_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(14) <= gt14_rxbyteisaligned_i;
  gt14_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(14) or (not gt14_rxresetdone_r3);
  gt14_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(14) or (not gt14_rxresetdone_r3);
  gt14_rxpolarity_i <= GT_RXPOLARITY_IN(14);
  gt14_txpolarity_i <= GT_TXPOLARITY_IN(14);
  GT_PLL_LOCK_OUT(14) <= gt14_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(14);

  -- gt15
  gt15_txdata_i          <= GT_TX_DATA_IN(15);
  gt15_txcharisk_i       <= GT_TX_CHARISK_IN(15);
  GT_RX_DATA_OUT(15)         <= gt15_rxdata_i;
  GT_RX_CHARISK_OUT(15)      <= gt15_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(15)   <= gt15_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(15)   <= gt15_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(15) <= gt15_rxbyteisaligned_i;
  gt15_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(15) or (not gt15_rxresetdone_r3);
  gt15_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(15) or (not gt15_rxresetdone_r3);
  gt15_rxpolarity_i <= GT_RXPOLARITY_IN(15);
  gt15_txpolarity_i <= GT_TXPOLARITY_IN(15);
  GT_PLL_LOCK_OUT(15) <= gt15_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(15);

  -- gt16
  gt16_txdata_i          <= GT_TX_DATA_IN(16);
  gt16_txcharisk_i       <= GT_TX_CHARISK_IN(16);
  GT_RX_DATA_OUT(16)         <= gt16_rxdata_i;
  GT_RX_CHARISK_OUT(16)      <= gt16_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(16)   <= gt16_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(16)   <= gt16_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(16) <= gt16_rxbyteisaligned_i;
  gt16_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(16) or (not gt16_rxresetdone_r3);
  gt16_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(16) or (not gt16_rxresetdone_r3);
  gt16_rxpolarity_i <= GT_RXPOLARITY_IN(16);
  gt16_txpolarity_i <= GT_TXPOLARITY_IN(16);
  GT_PLL_LOCK_OUT(16) <= gt16_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(16);

  -- gt17
  gt17_txdata_i          <= GT_TX_DATA_IN(17);
  gt17_txcharisk_i       <= GT_TX_CHARISK_IN(17);
  GT_RX_DATA_OUT(17)         <= gt17_rxdata_i;
  GT_RX_CHARISK_OUT(17)      <= gt17_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(17)   <= gt17_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(17)   <= gt17_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(17) <= gt17_rxbyteisaligned_i;
  gt17_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(17) or (not gt17_rxresetdone_r3);
  gt17_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(17) or (not gt17_rxresetdone_r3);
  gt17_rxpolarity_i <= GT_RXPOLARITY_IN(17);
  gt17_txpolarity_i <= GT_TXPOLARITY_IN(17);
  GT_PLL_LOCK_OUT(17) <= gt17_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(17);

  -- gt18
  gt18_txdata_i          <= GT_TX_DATA_IN(18);
  gt18_txcharisk_i       <= GT_TX_CHARISK_IN(18);
  GT_RX_DATA_OUT(18)         <= gt18_rxdata_i;
  GT_RX_CHARISK_OUT(18)      <= gt18_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(18)   <= gt18_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(18)   <= gt18_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(18) <= gt18_rxbyteisaligned_i;
  gt18_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(18) or (not gt18_rxresetdone_r3);
  gt18_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(18) or (not gt18_rxresetdone_r3);
  gt18_rxpolarity_i <= GT_RXPOLARITY_IN(18);
  gt18_txpolarity_i <= GT_TXPOLARITY_IN(18);
  GT_PLL_LOCK_OUT(18) <= gt18_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(18);

  -- gt19
  gt19_txdata_i          <= GT_TX_DATA_IN(19);
  gt19_txcharisk_i       <= GT_TX_CHARISK_IN(19);
  GT_RX_DATA_OUT(19)         <= gt19_rxdata_i;
  GT_RX_CHARISK_OUT(19)      <= gt19_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(19)   <= gt19_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(19)   <= gt19_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(19) <= gt19_rxbyteisaligned_i;
  gt19_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(19) or (not gt19_rxresetdone_r3);
  gt19_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(19) or (not gt19_rxresetdone_r3);
  gt19_rxpolarity_i <= GT_RXPOLARITY_IN(19);
  gt19_txpolarity_i <= GT_TXPOLARITY_IN(19);
  GT_PLL_LOCK_OUT(19) <= gt19_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(19);

  -- gt20
  gt20_txdata_i          <= GT_TX_DATA_IN(20);
  gt20_txcharisk_i       <= GT_TX_CHARISK_IN(20);
  GT_RX_DATA_OUT(20)         <= gt20_rxdata_i;
  GT_RX_CHARISK_OUT(20)      <= gt20_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(20)   <= gt20_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(20)   <= gt20_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(20) <= gt20_rxbyteisaligned_i;
  gt20_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(20) or (not gt20_rxresetdone_r3);
  gt20_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(20) or (not gt20_rxresetdone_r3);
  gt20_rxpolarity_i <= GT_RXPOLARITY_IN(20);
  gt20_txpolarity_i <= GT_TXPOLARITY_IN(20);
  GT_PLL_LOCK_OUT(20) <= gt20_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(20);

  -- gt21
  gt21_txdata_i          <= GT_TX_DATA_IN(21);
  gt21_txcharisk_i       <= GT_TX_CHARISK_IN(21);
  GT_RX_DATA_OUT(21)         <= gt21_rxdata_i;
  GT_RX_CHARISK_OUT(21)      <= gt21_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(21)   <= gt21_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(21)   <= gt21_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(21) <= gt21_rxbyteisaligned_i;
  gt21_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(21) or (not gt21_rxresetdone_r3);
  gt21_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(21) or (not gt21_rxresetdone_r3);
  gt21_rxpolarity_i <= GT_RXPOLARITY_IN(21);
  gt21_txpolarity_i <= GT_TXPOLARITY_IN(21);
  GT_PLL_LOCK_OUT(21) <= gt21_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(21);

  -- gt22
  gt22_txdata_i          <= GT_TX_DATA_IN(22);
  gt22_txcharisk_i       <= GT_TX_CHARISK_IN(22);
  GT_RX_DATA_OUT(22)         <= gt22_rxdata_i;
  GT_RX_CHARISK_OUT(22)      <= gt22_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(22)   <= gt22_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(22)   <= gt22_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(22) <= gt22_rxbyteisaligned_i;
  gt22_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(22) or (not gt22_rxresetdone_r3);
  gt22_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(22) or (not gt22_rxresetdone_r3);
  gt22_rxpolarity_i <= GT_RXPOLARITY_IN(22);
  gt22_txpolarity_i <= GT_TXPOLARITY_IN(22);
  GT_PLL_LOCK_OUT(22) <= gt22_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(22);

  -- gt23
  gt23_txdata_i          <= GT_TX_DATA_IN(23);
  gt23_txcharisk_i       <= GT_TX_CHARISK_IN(23);
  GT_RX_DATA_OUT(23)         <= gt23_rxdata_i;
  GT_RX_CHARISK_OUT(23)      <= gt23_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(23)   <= gt23_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(23)   <= gt23_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(23) <= gt23_rxbyteisaligned_i;
  gt23_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(23) or (not gt23_rxresetdone_r3);
  gt23_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(23) or (not gt23_rxresetdone_r3);
  gt23_rxpolarity_i <= GT_RXPOLARITY_IN(23);
  gt23_txpolarity_i <= GT_TXPOLARITY_IN(23);
  GT_PLL_LOCK_OUT(23) <= gt23_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(23);

  -- gt24
  gt24_txdata_i          <= GT_TX_DATA_IN(24);
  gt24_txcharisk_i       <= GT_TX_CHARISK_IN(24);
  GT_RX_DATA_OUT(24)         <= gt24_rxdata_i;
  GT_RX_CHARISK_OUT(24)      <= gt24_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(24)   <= gt24_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(24)   <= gt24_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(24) <= gt24_rxbyteisaligned_i;
  gt24_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(24) or (not gt24_rxresetdone_r3);
  gt24_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(24) or (not gt24_rxresetdone_r3);
  gt24_rxpolarity_i <= GT_RXPOLARITY_IN(24);
  gt24_txpolarity_i <= GT_TXPOLARITY_IN(24);
  GT_PLL_LOCK_OUT(24) <= gt24_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(24);

  -- gt25
  gt25_txdata_i          <= GT_TX_DATA_IN(25);
  gt25_txcharisk_i       <= GT_TX_CHARISK_IN(25);
  GT_RX_DATA_OUT(25)         <= gt25_rxdata_i;
  GT_RX_CHARISK_OUT(25)      <= gt25_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(25)   <= gt25_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(25)   <= gt25_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(25) <= gt25_rxbyteisaligned_i;
  gt25_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(25) or (not gt25_rxresetdone_r3);
  gt25_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(25) or (not gt25_rxresetdone_r3);
  gt25_rxpolarity_i <= GT_RXPOLARITY_IN(25);
  gt25_txpolarity_i <= GT_TXPOLARITY_IN(25);
  GT_PLL_LOCK_OUT(25) <= gt25_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(25);

  -- gt26
  gt26_txdata_i          <= GT_TX_DATA_IN(26);
  gt26_txcharisk_i       <= GT_TX_CHARISK_IN(26);
  GT_RX_DATA_OUT(26)         <= gt26_rxdata_i;
  GT_RX_CHARISK_OUT(26)      <= gt26_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(26)   <= gt26_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(26)   <= gt26_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(26) <= gt26_rxbyteisaligned_i;
  gt26_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(26) or (not gt26_rxresetdone_r3);
  gt26_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(26) or (not gt26_rxresetdone_r3);
  gt26_rxpolarity_i <= GT_RXPOLARITY_IN(26);
  gt26_txpolarity_i <= GT_TXPOLARITY_IN(26);
  GT_PLL_LOCK_OUT(26) <= gt26_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(26);

  -- gt27
  gt27_txdata_i          <= GT_TX_DATA_IN(27);
  gt27_txcharisk_i       <= GT_TX_CHARISK_IN(27);
  GT_RX_DATA_OUT(27)         <= gt27_rxdata_i;
  GT_RX_CHARISK_OUT(27)      <= gt27_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(27)   <= gt27_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(27)   <= gt27_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(27) <= gt27_rxbyteisaligned_i;
  gt27_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(27) or (not gt27_rxresetdone_r3);
  gt27_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(27) or (not gt27_rxresetdone_r3);
  gt27_rxpolarity_i <= GT_RXPOLARITY_IN(27);
  gt27_txpolarity_i <= GT_TXPOLARITY_IN(27);
  GT_PLL_LOCK_OUT(27) <= gt27_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(27);

  -- gt28
  gt28_txdata_i          <= GT_TX_DATA_IN(28);
  gt28_txcharisk_i       <= GT_TX_CHARISK_IN(28);
  GT_RX_DATA_OUT(28)         <= gt28_rxdata_i;
  GT_RX_CHARISK_OUT(28)      <= gt28_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(28)   <= gt28_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(28)   <= gt28_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(28) <= gt28_rxbyteisaligned_i;
  gt28_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(28) or (not gt28_rxresetdone_r3);
  gt28_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(28) or (not gt28_rxresetdone_r3);
  gt28_rxpolarity_i <= GT_RXPOLARITY_IN(28);
  gt28_txpolarity_i <= GT_TXPOLARITY_IN(28);
  GT_PLL_LOCK_OUT(28) <= gt28_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(28);

  -- gt29
  gt29_txdata_i          <= GT_TX_DATA_IN(29);
  gt29_txcharisk_i       <= GT_TX_CHARISK_IN(29);
  GT_RX_DATA_OUT(29)         <= gt29_rxdata_i;
  GT_RX_CHARISK_OUT(29)      <= gt29_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(29)   <= gt29_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(29)   <= gt29_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(29) <= gt29_rxbyteisaligned_i;
  gt29_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(29) or (not gt29_rxresetdone_r3);
  gt29_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(29) or (not gt29_rxresetdone_r3);
  gt29_rxpolarity_i <= GT_RXPOLARITY_IN(29);
  gt29_txpolarity_i <= GT_TXPOLARITY_IN(29);
  GT_PLL_LOCK_OUT(29) <= gt29_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(29);

  -- gt30
  gt30_txdata_i          <= GT_TX_DATA_IN(30);
  gt30_txcharisk_i       <= GT_TX_CHARISK_IN(30);
  GT_RX_DATA_OUT(30)         <= gt30_rxdata_i;
  GT_RX_CHARISK_OUT(30)      <= gt30_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(30)   <= gt30_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(30)   <= gt30_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(30) <= gt30_rxbyteisaligned_i;
  gt30_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(30) or (not gt30_rxresetdone_r3);
  gt30_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(30) or (not gt30_rxresetdone_r3);
  gt30_rxpolarity_i <= GT_RXPOLARITY_IN(30);
  gt30_txpolarity_i <= GT_TXPOLARITY_IN(30);
  GT_PLL_LOCK_OUT(30) <= gt30_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(30);

  -- gt31
  gt31_txdata_i          <= GT_TX_DATA_IN(31);
  gt31_txcharisk_i       <= GT_TX_CHARISK_IN(31);
  GT_RX_DATA_OUT(31)         <= gt31_rxdata_i;
  GT_RX_CHARISK_OUT(31)      <= gt31_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(31)   <= gt31_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(31)   <= gt31_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(31) <= gt31_rxbyteisaligned_i;
  gt31_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(31) or (not gt31_rxresetdone_r3);
  gt31_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(31) or (not gt31_rxresetdone_r3);
  gt31_rxpolarity_i <= GT_RXPOLARITY_IN(31);
  gt31_txpolarity_i <= GT_TXPOLARITY_IN(31);
  GT_PLL_LOCK_OUT(31) <= gt31_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(31);

  -- gt32
  gt32_txdata_i          <= GT_TX_DATA_IN(32);
  gt32_txcharisk_i       <= GT_TX_CHARISK_IN(32);
  GT_RX_DATA_OUT(32)         <= gt32_rxdata_i;
  GT_RX_CHARISK_OUT(32)      <= gt32_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(32)   <= gt32_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(32)   <= gt32_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(32) <= gt32_rxbyteisaligned_i;
  gt32_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(32) or (not gt32_rxresetdone_r3);
  gt32_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(32) or (not gt32_rxresetdone_r3);
  gt32_rxpolarity_i <= GT_RXPOLARITY_IN(32);
  gt32_txpolarity_i <= GT_TXPOLARITY_IN(32);
  GT_PLL_LOCK_OUT(32) <= gt32_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(32);

  -- gt33
  gt33_txdata_i          <= GT_TX_DATA_IN(33);
  gt33_txcharisk_i       <= GT_TX_CHARISK_IN(33);
  GT_RX_DATA_OUT(33)         <= gt33_rxdata_i;
  GT_RX_CHARISK_OUT(33)      <= gt33_rxcharisk_i;
  GT_TX_RESET_DONE_OUT(33)   <= gt33_txfsmresetdone_r2;
  GT_RX_RESET_DONE_OUT(33)   <= gt33_rxresetdone_r3;
  GT_RXBYTEISALIGNED_OUT(33) <= gt33_rxbyteisaligned_i;
  gt33_rxmcommaalignen_i <= GT_RXENCOMMAALIGN_IN(33) or (not gt33_rxresetdone_r3);
  gt33_rxpcommaalignen_i <= GT_RXENCOMMAALIGN_IN(33) or (not gt33_rxresetdone_r3);
  gt33_rxpolarity_i <= GT_RXPOLARITY_IN(33);
  gt33_txpolarity_i <= GT_TXPOLARITY_IN(33);
  GT_PLL_LOCK_OUT(33) <= gt33_cplllock_i when CPLL_USED='1' else gt_qpll_lock_i(33);
  
  -- USER CLOCK
  GT_TXUSERCLK_OUT(0) <= gt0_txusrclk2_i;
  GT_TXUSERCLK_OUT(1) <= gt1_txusrclk2_i;
  GT_TXUSERCLK_OUT(2) <= gt2_txusrclk2_i;
  GT_TXUSERCLK_OUT(3) <= gt3_txusrclk2_i;
  GT_TXUSERCLK_OUT(4) <= gt4_txusrclk2_i;
  GT_TXUSERCLK_OUT(5) <= gt5_txusrclk2_i;
  GT_TXUSERCLK_OUT(6) <= gt6_txusrclk2_i;
  GT_TXUSERCLK_OUT(7) <= gt7_txusrclk2_i;
  GT_TXUSERCLK_OUT(8) <= gt8_txusrclk2_i;
  GT_TXUSERCLK_OUT(9) <= gt9_txusrclk2_i;
  GT_TXUSERCLK_OUT(10) <= gt10_txusrclk2_i;
  GT_TXUSERCLK_OUT(11) <= gt11_txusrclk2_i;
  GT_TXUSERCLK_OUT(12) <= gt12_txusrclk2_i;
  GT_TXUSERCLK_OUT(13) <= gt13_txusrclk2_i;
  GT_TXUSERCLK_OUT(14) <= gt14_txusrclk2_i;
  GT_TXUSERCLK_OUT(15) <= gt15_txusrclk2_i;
  GT_TXUSERCLK_OUT(16) <= gt16_txusrclk2_i;
  GT_TXUSERCLK_OUT(17) <= gt17_txusrclk2_i;
  GT_TXUSERCLK_OUT(18) <= gt18_txusrclk2_i;
  GT_TXUSERCLK_OUT(19) <= gt19_txusrclk2_i;
  GT_TXUSERCLK_OUT(20) <= gt20_txusrclk2_i;
  GT_TXUSERCLK_OUT(21) <= gt21_txusrclk2_i;
  GT_TXUSERCLK_OUT(22) <= gt22_txusrclk2_i;
  GT_TXUSERCLK_OUT(23) <= gt23_txusrclk2_i;
  GT_TXUSERCLK_OUT(24) <= gt24_txusrclk2_i;
  GT_TXUSERCLK_OUT(25) <= gt25_txusrclk2_i;
  GT_TXUSERCLK_OUT(26) <= gt26_txusrclk2_i;
  GT_TXUSERCLK_OUT(27) <= gt27_txusrclk2_i;
  GT_TXUSERCLK_OUT(28) <= gt28_txusrclk2_i;
  GT_TXUSERCLK_OUT(29) <= gt29_txusrclk2_i;  
  GT_TXUSERCLK_OUT(30) <= gt30_txusrclk2_i;
  GT_TXUSERCLK_OUT(31) <= gt31_txusrclk2_i;
  GT_TXUSERCLK_OUT(32) <= gt32_txusrclk2_i;
  GT_TXUSERCLK_OUT(33) <= gt33_txusrclk2_i;

  GT_RXUSERCLK_OUT(0) <= gt0_rxusrclk2_i;
  GT_RXUSERCLK_OUT(1) <= gt1_rxusrclk2_i;
  GT_RXUSERCLK_OUT(2) <= gt2_rxusrclk2_i;
  GT_RXUSERCLK_OUT(3) <= gt3_rxusrclk2_i;
  GT_RXUSERCLK_OUT(4) <= gt4_rxusrclk2_i;
  GT_RXUSERCLK_OUT(5) <= gt5_rxusrclk2_i;
  GT_RXUSERCLK_OUT(6) <= gt6_rxusrclk2_i;
  GT_RXUSERCLK_OUT(7) <= gt7_rxusrclk2_i;
  GT_RXUSERCLK_OUT(8) <= gt8_rxusrclk2_i;
  GT_RXUSERCLK_OUT(9) <= gt9_rxusrclk2_i;
  GT_RXUSERCLK_OUT(10) <= gt10_rxusrclk2_i;
  GT_RXUSERCLK_OUT(11) <= gt11_rxusrclk2_i;
  GT_RXUSERCLK_OUT(12) <= gt12_rxusrclk2_i;
  GT_RXUSERCLK_OUT(13) <= gt13_rxusrclk2_i;
  GT_RXUSERCLK_OUT(14) <= gt14_rxusrclk2_i;
  GT_RXUSERCLK_OUT(15) <= gt15_rxusrclk2_i;
  GT_RXUSERCLK_OUT(16) <= gt16_rxusrclk2_i;
  GT_RXUSERCLK_OUT(17) <= gt17_rxusrclk2_i;
  GT_RXUSERCLK_OUT(18) <= gt18_rxusrclk2_i;
  GT_RXUSERCLK_OUT(19) <= gt19_rxusrclk2_i;
  GT_RXUSERCLK_OUT(20) <= gt20_rxusrclk2_i;
  GT_RXUSERCLK_OUT(21) <= gt21_rxusrclk2_i;
  GT_RXUSERCLK_OUT(22) <= gt22_rxusrclk2_i;
  GT_RXUSERCLK_OUT(23) <= gt23_rxusrclk2_i;
  GT_RXUSERCLK_OUT(24) <= gt24_rxusrclk2_i;
  GT_RXUSERCLK_OUT(25) <= gt25_rxusrclk2_i;
  GT_RXUSERCLK_OUT(26) <= gt26_rxusrclk2_i;
  GT_RXUSERCLK_OUT(27) <= gt27_rxusrclk2_i;
  GT_RXUSERCLK_OUT(28) <= gt28_rxusrclk2_i;
  GT_RXUSERCLK_OUT(29) <= gt29_rxusrclk2_i;  
  GT_RXUSERCLK_OUT(30) <= gt30_rxusrclk2_i;
  GT_RXUSERCLK_OUT(31) <= gt31_rxusrclk2_i;
  GT_RXUSERCLK_OUT(32) <= gt32_rxusrclk2_i;
  GT_RXUSERCLK_OUT(33) <= gt33_rxusrclk2_i;    
  
  -- QPLL
  gt_qpll_lock_i(0) <= gt0_qplllock_i;
  gt_qpll_lock_i(1) <= gt0_qplllock_i;
  gt_qpll_lock_i(2) <= gt0_qplllock_i;
  gt_qpll_lock_i(3) <= gt0_qplllock_i;
  gt_qpll_lock_i(4) <= gt1_qplllock_i;
  gt_qpll_lock_i(5) <= gt1_qplllock_i;
  gt_qpll_lock_i(6) <= gt1_qplllock_i;
  gt_qpll_lock_i(7) <= gt1_qplllock_i;
  gt_qpll_lock_i(8) <= gt2_qplllock_i;
  gt_qpll_lock_i(9) <= gt2_qplllock_i;
  gt_qpll_lock_i(10) <= gt2_qplllock_i;
  gt_qpll_lock_i(11) <= gt2_qplllock_i;
  gt_qpll_lock_i(12) <= gt3_qplllock_i;
  gt_qpll_lock_i(13) <= gt3_qplllock_i;
  gt_qpll_lock_i(14) <= gt3_qplllock_i;
  gt_qpll_lock_i(15) <= gt3_qplllock_i;
  gt_qpll_lock_i(16) <= gt4_qplllock_i;
  gt_qpll_lock_i(17) <= gt4_qplllock_i;
  gt_qpll_lock_i(18) <= gt4_qplllock_i;
  gt_qpll_lock_i(19) <= gt4_qplllock_i;
  gt_qpll_lock_i(20) <= gt5_qplllock_i;
  gt_qpll_lock_i(21) <= gt5_qplllock_i;
  gt_qpll_lock_i(22) <= gt5_qplllock_i;
  gt_qpll_lock_i(23) <= gt5_qplllock_i;
  gt_qpll_lock_i(24) <= gt6_qplllock_i;
  gt_qpll_lock_i(25) <= gt6_qplllock_i;
  gt_qpll_lock_i(26) <= gt6_qplllock_i;
  gt_qpll_lock_i(27) <= gt6_qplllock_i;
  gt_qpll_lock_i(28) <= gt7_qplllock_i;
  gt_qpll_lock_i(29) <= gt7_qplllock_i;
  gt_qpll_lock_i(30) <= gt7_qplllock_i;
  gt_qpll_lock_i(31) <= gt7_qplllock_i;
  gt_qpll_lock_i(32) <= gt8_qplllock_i;
  gt_qpll_lock_i(33) <= gt8_qplllock_i;
  
  
    --  Static signal Assigments
    tied_to_ground_i                             <= '0';
    tied_to_ground_vec_i                         <= x"0000000000000000";
    tied_to_vcc_i                                <= '1';
    tied_to_vcc_vec_i                            <= "11111111";

    
q1_clk0_refclk_i                             <= '0';
    
q4_clk0_refclk_i                             <= '0';
    
q7_clk0_refclk_i                             <= '0';
    ----------------------------- The GT Wrapper -----------------------------
    
    -- Use the instantiation template in the example directory to add the GT wrapper to your design.
    -- In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    -- checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is 
    -- enabled, bonding should occur after alignment.

    
    gt64_rtm34l_support_i : gt64_rtm34l_support
    generic map
    (
        EXAMPLE_SIM_GTRESET_SPEEDUP     =>      EXAMPLE_SIM_GTRESET_SPEEDUP,
        STABLE_CLOCK_PERIOD             =>      STABLE_CLOCK_PERIOD
    )
    port map
    (
        SOFT_RESET_IN                   =>      transceiver_reset_i,
        DONT_RESET_ON_DATA_ERROR_IN     =>      tied_to_ground_i,
    Q1_CLK0_GTREFCLK_PAD_N_IN => GTREFCLK0_N_IN,
    Q1_CLK0_GTREFCLK_PAD_P_IN => GTREFCLK0_P_IN,
    Q4_CLK0_GTREFCLK_PAD_N_IN => GTREFCLK1_N_IN,
    Q4_CLK0_GTREFCLK_PAD_P_IN => GTREFCLK1_P_IN,
    Q7_CLK0_GTREFCLK_PAD_N_IN => GTREFCLK2_N_IN,
    Q7_CLK0_GTREFCLK_PAD_P_IN => GTREFCLK2_P_IN,

        GT0_TX_FSM_RESET_DONE_OUT       =>      gt0_txfsmresetdone_i,
        GT0_RX_FSM_RESET_DONE_OUT       =>      gt0_rxfsmresetdone_i,
        GT0_DATA_VALID_IN               =>      gt0_track_data_i,
        GT1_TX_FSM_RESET_DONE_OUT       =>      gt1_txfsmresetdone_i,
        GT1_RX_FSM_RESET_DONE_OUT       =>      gt1_rxfsmresetdone_i,
        GT1_DATA_VALID_IN               =>      gt1_track_data_i,
        GT2_TX_FSM_RESET_DONE_OUT       =>      gt2_txfsmresetdone_i,
        GT2_RX_FSM_RESET_DONE_OUT       =>      gt2_rxfsmresetdone_i,
        GT2_DATA_VALID_IN               =>      gt2_track_data_i,
        GT3_TX_FSM_RESET_DONE_OUT       =>      gt3_txfsmresetdone_i,
        GT3_RX_FSM_RESET_DONE_OUT       =>      gt3_rxfsmresetdone_i,
        GT3_DATA_VALID_IN               =>      gt3_track_data_i,
        GT4_TX_FSM_RESET_DONE_OUT       =>      gt4_txfsmresetdone_i,
        GT4_RX_FSM_RESET_DONE_OUT       =>      gt4_rxfsmresetdone_i,
        GT4_DATA_VALID_IN               =>      gt4_track_data_i,
        GT5_TX_FSM_RESET_DONE_OUT       =>      gt5_txfsmresetdone_i,
        GT5_RX_FSM_RESET_DONE_OUT       =>      gt5_rxfsmresetdone_i,
        GT5_DATA_VALID_IN               =>      gt5_track_data_i,
        GT6_TX_FSM_RESET_DONE_OUT       =>      gt6_txfsmresetdone_i,
        GT6_RX_FSM_RESET_DONE_OUT       =>      gt6_rxfsmresetdone_i,
        GT6_DATA_VALID_IN               =>      gt6_track_data_i,
        GT7_TX_FSM_RESET_DONE_OUT       =>      gt7_txfsmresetdone_i,
        GT7_RX_FSM_RESET_DONE_OUT       =>      gt7_rxfsmresetdone_i,
        GT7_DATA_VALID_IN               =>      gt7_track_data_i,
        GT8_TX_FSM_RESET_DONE_OUT       =>      gt8_txfsmresetdone_i,
        GT8_RX_FSM_RESET_DONE_OUT       =>      gt8_rxfsmresetdone_i,
        GT8_DATA_VALID_IN               =>      gt8_track_data_i,
        GT9_TX_FSM_RESET_DONE_OUT       =>      gt9_txfsmresetdone_i,
        GT9_RX_FSM_RESET_DONE_OUT       =>      gt9_rxfsmresetdone_i,
        GT9_DATA_VALID_IN               =>      gt9_track_data_i,
        GT10_TX_FSM_RESET_DONE_OUT      =>      gt10_txfsmresetdone_i,
        GT10_RX_FSM_RESET_DONE_OUT      =>      gt10_rxfsmresetdone_i,
        GT10_DATA_VALID_IN              =>      gt10_track_data_i,
        GT11_TX_FSM_RESET_DONE_OUT      =>      gt11_txfsmresetdone_i,
        GT11_RX_FSM_RESET_DONE_OUT      =>      gt11_rxfsmresetdone_i,
        GT11_DATA_VALID_IN              =>      gt11_track_data_i,
        GT12_TX_FSM_RESET_DONE_OUT      =>      gt12_txfsmresetdone_i,
        GT12_RX_FSM_RESET_DONE_OUT      =>      gt12_rxfsmresetdone_i,
        GT12_DATA_VALID_IN              =>      gt12_track_data_i,
        GT13_TX_FSM_RESET_DONE_OUT      =>      gt13_txfsmresetdone_i,
        GT13_RX_FSM_RESET_DONE_OUT      =>      gt13_rxfsmresetdone_i,
        GT13_DATA_VALID_IN              =>      gt13_track_data_i,
        GT14_TX_FSM_RESET_DONE_OUT      =>      gt14_txfsmresetdone_i,
        GT14_RX_FSM_RESET_DONE_OUT      =>      gt14_rxfsmresetdone_i,
        GT14_DATA_VALID_IN              =>      gt14_track_data_i,
        GT15_TX_FSM_RESET_DONE_OUT      =>      gt15_txfsmresetdone_i,
        GT15_RX_FSM_RESET_DONE_OUT      =>      gt15_rxfsmresetdone_i,
        GT15_DATA_VALID_IN              =>      gt15_track_data_i,
        GT16_TX_FSM_RESET_DONE_OUT      =>      gt16_txfsmresetdone_i,
        GT16_RX_FSM_RESET_DONE_OUT      =>      gt16_rxfsmresetdone_i,
        GT16_DATA_VALID_IN              =>      gt16_track_data_i,
        GT17_TX_FSM_RESET_DONE_OUT      =>      gt17_txfsmresetdone_i,
        GT17_RX_FSM_RESET_DONE_OUT      =>      gt17_rxfsmresetdone_i,
        GT17_DATA_VALID_IN              =>      gt17_track_data_i,
        GT18_TX_FSM_RESET_DONE_OUT      =>      gt18_txfsmresetdone_i,
        GT18_RX_FSM_RESET_DONE_OUT      =>      gt18_rxfsmresetdone_i,
        GT18_DATA_VALID_IN              =>      gt18_track_data_i,
        GT19_TX_FSM_RESET_DONE_OUT      =>      gt19_txfsmresetdone_i,
        GT19_RX_FSM_RESET_DONE_OUT      =>      gt19_rxfsmresetdone_i,
        GT19_DATA_VALID_IN              =>      gt19_track_data_i,
        GT20_TX_FSM_RESET_DONE_OUT      =>      gt20_txfsmresetdone_i,
        GT20_RX_FSM_RESET_DONE_OUT      =>      gt20_rxfsmresetdone_i,
        GT20_DATA_VALID_IN              =>      gt20_track_data_i,
        GT21_TX_FSM_RESET_DONE_OUT      =>      gt21_txfsmresetdone_i,
        GT21_RX_FSM_RESET_DONE_OUT      =>      gt21_rxfsmresetdone_i,
        GT21_DATA_VALID_IN              =>      gt21_track_data_i,
        GT22_TX_FSM_RESET_DONE_OUT      =>      gt22_txfsmresetdone_i,
        GT22_RX_FSM_RESET_DONE_OUT      =>      gt22_rxfsmresetdone_i,
        GT22_DATA_VALID_IN              =>      gt22_track_data_i,
        GT23_TX_FSM_RESET_DONE_OUT      =>      gt23_txfsmresetdone_i,
        GT23_RX_FSM_RESET_DONE_OUT      =>      gt23_rxfsmresetdone_i,
        GT23_DATA_VALID_IN              =>      gt23_track_data_i,
        GT24_TX_FSM_RESET_DONE_OUT      =>      gt24_txfsmresetdone_i,
        GT24_RX_FSM_RESET_DONE_OUT      =>      gt24_rxfsmresetdone_i,
        GT24_DATA_VALID_IN              =>      gt24_track_data_i,
        GT25_TX_FSM_RESET_DONE_OUT      =>      gt25_txfsmresetdone_i,
        GT25_RX_FSM_RESET_DONE_OUT      =>      gt25_rxfsmresetdone_i,
        GT25_DATA_VALID_IN              =>      gt25_track_data_i,
        GT26_TX_FSM_RESET_DONE_OUT      =>      gt26_txfsmresetdone_i,
        GT26_RX_FSM_RESET_DONE_OUT      =>      gt26_rxfsmresetdone_i,
        GT26_DATA_VALID_IN              =>      gt26_track_data_i,
        GT27_TX_FSM_RESET_DONE_OUT      =>      gt27_txfsmresetdone_i,
        GT27_RX_FSM_RESET_DONE_OUT      =>      gt27_rxfsmresetdone_i,
        GT27_DATA_VALID_IN              =>      gt27_track_data_i,
        GT28_TX_FSM_RESET_DONE_OUT      =>      gt28_txfsmresetdone_i,
        GT28_RX_FSM_RESET_DONE_OUT      =>      gt28_rxfsmresetdone_i,
        GT28_DATA_VALID_IN              =>      gt28_track_data_i,
        GT29_TX_FSM_RESET_DONE_OUT      =>      gt29_txfsmresetdone_i,
        GT29_RX_FSM_RESET_DONE_OUT      =>      gt29_rxfsmresetdone_i,
        GT29_DATA_VALID_IN              =>      gt29_track_data_i,
        GT30_TX_FSM_RESET_DONE_OUT      =>      gt30_txfsmresetdone_i,
        GT30_RX_FSM_RESET_DONE_OUT      =>      gt30_rxfsmresetdone_i,
        GT30_DATA_VALID_IN              =>      gt30_track_data_i,
        GT31_TX_FSM_RESET_DONE_OUT      =>      gt31_txfsmresetdone_i,
        GT31_RX_FSM_RESET_DONE_OUT      =>      gt31_rxfsmresetdone_i,
        GT31_DATA_VALID_IN              =>      gt31_track_data_i,
        GT32_TX_FSM_RESET_DONE_OUT      =>      gt32_txfsmresetdone_i,
        GT32_RX_FSM_RESET_DONE_OUT      =>      gt32_rxfsmresetdone_i,
        GT32_DATA_VALID_IN              =>      gt32_track_data_i,
        GT33_TX_FSM_RESET_DONE_OUT      =>      gt33_txfsmresetdone_i,
        GT33_RX_FSM_RESET_DONE_OUT      =>      gt33_rxfsmresetdone_i,
        GT33_DATA_VALID_IN              =>      gt33_track_data_i,
 
    GT0_TXUSRCLK_OUT => gt0_txusrclk_i,
    GT0_TXUSRCLK2_OUT => gt0_txusrclk2_i,
    GT0_RXUSRCLK_OUT => gt0_rxusrclk_i,
    GT0_RXUSRCLK2_OUT => gt0_rxusrclk2_i,
 
    GT1_TXUSRCLK_OUT => gt1_txusrclk_i,
    GT1_TXUSRCLK2_OUT => gt1_txusrclk2_i,
    GT1_RXUSRCLK_OUT => gt1_rxusrclk_i,
    GT1_RXUSRCLK2_OUT => gt1_rxusrclk2_i,
 
    GT2_TXUSRCLK_OUT => gt2_txusrclk_i,
    GT2_TXUSRCLK2_OUT => gt2_txusrclk2_i,
    GT2_RXUSRCLK_OUT => gt2_rxusrclk_i,
    GT2_RXUSRCLK2_OUT => gt2_rxusrclk2_i,
 
    GT3_TXUSRCLK_OUT => gt3_txusrclk_i,
    GT3_TXUSRCLK2_OUT => gt3_txusrclk2_i,
    GT3_RXUSRCLK_OUT => gt3_rxusrclk_i,
    GT3_RXUSRCLK2_OUT => gt3_rxusrclk2_i,
 
    GT4_TXUSRCLK_OUT => gt4_txusrclk_i,
    GT4_TXUSRCLK2_OUT => gt4_txusrclk2_i,
    GT4_RXUSRCLK_OUT => gt4_rxusrclk_i,
    GT4_RXUSRCLK2_OUT => gt4_rxusrclk2_i,
 
    GT5_TXUSRCLK_OUT => gt5_txusrclk_i,
    GT5_TXUSRCLK2_OUT => gt5_txusrclk2_i,
    GT5_RXUSRCLK_OUT => gt5_rxusrclk_i,
    GT5_RXUSRCLK2_OUT => gt5_rxusrclk2_i,
 
    GT6_TXUSRCLK_OUT => gt6_txusrclk_i,
    GT6_TXUSRCLK2_OUT => gt6_txusrclk2_i,
    GT6_RXUSRCLK_OUT => gt6_rxusrclk_i,
    GT6_RXUSRCLK2_OUT => gt6_rxusrclk2_i,
 
    GT7_TXUSRCLK_OUT => gt7_txusrclk_i,
    GT7_TXUSRCLK2_OUT => gt7_txusrclk2_i,
    GT7_RXUSRCLK_OUT => gt7_rxusrclk_i,
    GT7_RXUSRCLK2_OUT => gt7_rxusrclk2_i,
 
    GT8_TXUSRCLK_OUT => gt8_txusrclk_i,
    GT8_TXUSRCLK2_OUT => gt8_txusrclk2_i,
    GT8_RXUSRCLK_OUT => gt8_rxusrclk_i,
    GT8_RXUSRCLK2_OUT => gt8_rxusrclk2_i,
 
    GT9_TXUSRCLK_OUT => gt9_txusrclk_i,
    GT9_TXUSRCLK2_OUT => gt9_txusrclk2_i,
    GT9_RXUSRCLK_OUT => gt9_rxusrclk_i,
    GT9_RXUSRCLK2_OUT => gt9_rxusrclk2_i,
 
    GT10_TXUSRCLK_OUT => gt10_txusrclk_i,
    GT10_TXUSRCLK2_OUT => gt10_txusrclk2_i,
    GT10_RXUSRCLK_OUT => gt10_rxusrclk_i,
    GT10_RXUSRCLK2_OUT => gt10_rxusrclk2_i,
 
    GT11_TXUSRCLK_OUT => gt11_txusrclk_i,
    GT11_TXUSRCLK2_OUT => gt11_txusrclk2_i,
    GT11_RXUSRCLK_OUT => gt11_rxusrclk_i,
    GT11_RXUSRCLK2_OUT => gt11_rxusrclk2_i,
 
    GT12_TXUSRCLK_OUT => gt12_txusrclk_i,
    GT12_TXUSRCLK2_OUT => gt12_txusrclk2_i,
    GT12_RXUSRCLK_OUT => gt12_rxusrclk_i,
    GT12_RXUSRCLK2_OUT => gt12_rxusrclk2_i,
 
    GT13_TXUSRCLK_OUT => gt13_txusrclk_i,
    GT13_TXUSRCLK2_OUT => gt13_txusrclk2_i,
    GT13_RXUSRCLK_OUT => gt13_rxusrclk_i,
    GT13_RXUSRCLK2_OUT => gt13_rxusrclk2_i,
 
    GT14_TXUSRCLK_OUT => gt14_txusrclk_i,
    GT14_TXUSRCLK2_OUT => gt14_txusrclk2_i,
    GT14_RXUSRCLK_OUT => gt14_rxusrclk_i,
    GT14_RXUSRCLK2_OUT => gt14_rxusrclk2_i,
 
    GT15_TXUSRCLK_OUT => gt15_txusrclk_i,
    GT15_TXUSRCLK2_OUT => gt15_txusrclk2_i,
    GT15_RXUSRCLK_OUT => gt15_rxusrclk_i,
    GT15_RXUSRCLK2_OUT => gt15_rxusrclk2_i,
 
    GT16_TXUSRCLK_OUT => gt16_txusrclk_i,
    GT16_TXUSRCLK2_OUT => gt16_txusrclk2_i,
    GT16_RXUSRCLK_OUT => gt16_rxusrclk_i,
    GT16_RXUSRCLK2_OUT => gt16_rxusrclk2_i,
 
    GT17_TXUSRCLK_OUT => gt17_txusrclk_i,
    GT17_TXUSRCLK2_OUT => gt17_txusrclk2_i,
    GT17_RXUSRCLK_OUT => gt17_rxusrclk_i,
    GT17_RXUSRCLK2_OUT => gt17_rxusrclk2_i,
 
    GT18_TXUSRCLK_OUT => gt18_txusrclk_i,
    GT18_TXUSRCLK2_OUT => gt18_txusrclk2_i,
    GT18_RXUSRCLK_OUT => gt18_rxusrclk_i,
    GT18_RXUSRCLK2_OUT => gt18_rxusrclk2_i,
 
    GT19_TXUSRCLK_OUT => gt19_txusrclk_i,
    GT19_TXUSRCLK2_OUT => gt19_txusrclk2_i,
    GT19_RXUSRCLK_OUT => gt19_rxusrclk_i,
    GT19_RXUSRCLK2_OUT => gt19_rxusrclk2_i,
 
    GT20_TXUSRCLK_OUT => gt20_txusrclk_i,
    GT20_TXUSRCLK2_OUT => gt20_txusrclk2_i,
    GT20_RXUSRCLK_OUT => gt20_rxusrclk_i,
    GT20_RXUSRCLK2_OUT => gt20_rxusrclk2_i,
 
    GT21_TXUSRCLK_OUT => gt21_txusrclk_i,
    GT21_TXUSRCLK2_OUT => gt21_txusrclk2_i,
    GT21_RXUSRCLK_OUT => gt21_rxusrclk_i,
    GT21_RXUSRCLK2_OUT => gt21_rxusrclk2_i,
 
    GT22_TXUSRCLK_OUT => gt22_txusrclk_i,
    GT22_TXUSRCLK2_OUT => gt22_txusrclk2_i,
    GT22_RXUSRCLK_OUT => gt22_rxusrclk_i,
    GT22_RXUSRCLK2_OUT => gt22_rxusrclk2_i,
 
    GT23_TXUSRCLK_OUT => gt23_txusrclk_i,
    GT23_TXUSRCLK2_OUT => gt23_txusrclk2_i,
    GT23_RXUSRCLK_OUT => gt23_rxusrclk_i,
    GT23_RXUSRCLK2_OUT => gt23_rxusrclk2_i,
 
    GT24_TXUSRCLK_OUT => gt24_txusrclk_i,
    GT24_TXUSRCLK2_OUT => gt24_txusrclk2_i,
    GT24_RXUSRCLK_OUT => gt24_rxusrclk_i,
    GT24_RXUSRCLK2_OUT => gt24_rxusrclk2_i,
 
    GT25_TXUSRCLK_OUT => gt25_txusrclk_i,
    GT25_TXUSRCLK2_OUT => gt25_txusrclk2_i,
    GT25_RXUSRCLK_OUT => gt25_rxusrclk_i,
    GT25_RXUSRCLK2_OUT => gt25_rxusrclk2_i,
 
    GT26_TXUSRCLK_OUT => gt26_txusrclk_i,
    GT26_TXUSRCLK2_OUT => gt26_txusrclk2_i,
    GT26_RXUSRCLK_OUT => gt26_rxusrclk_i,
    GT26_RXUSRCLK2_OUT => gt26_rxusrclk2_i,
 
    GT27_TXUSRCLK_OUT => gt27_txusrclk_i,
    GT27_TXUSRCLK2_OUT => gt27_txusrclk2_i,
    GT27_RXUSRCLK_OUT => gt27_rxusrclk_i,
    GT27_RXUSRCLK2_OUT => gt27_rxusrclk2_i,
 
    GT28_TXUSRCLK_OUT => gt28_txusrclk_i,
    GT28_TXUSRCLK2_OUT => gt28_txusrclk2_i,
    GT28_RXUSRCLK_OUT => gt28_rxusrclk_i,
    GT28_RXUSRCLK2_OUT => gt28_rxusrclk2_i,
 
    GT29_TXUSRCLK_OUT => gt29_txusrclk_i,
    GT29_TXUSRCLK2_OUT => gt29_txusrclk2_i,
    GT29_RXUSRCLK_OUT => gt29_rxusrclk_i,
    GT29_RXUSRCLK2_OUT => gt29_rxusrclk2_i,
 
    GT30_TXUSRCLK_OUT => gt30_txusrclk_i,
    GT30_TXUSRCLK2_OUT => gt30_txusrclk2_i,
    GT30_RXUSRCLK_OUT => gt30_rxusrclk_i,
    GT30_RXUSRCLK2_OUT => gt30_rxusrclk2_i,
 
    GT31_TXUSRCLK_OUT => gt31_txusrclk_i,
    GT31_TXUSRCLK2_OUT => gt31_txusrclk2_i,
    GT31_RXUSRCLK_OUT => gt31_rxusrclk_i,
    GT31_RXUSRCLK2_OUT => gt31_rxusrclk2_i,
 
    GT32_TXUSRCLK_OUT => gt32_txusrclk_i,
    GT32_TXUSRCLK2_OUT => gt32_txusrclk2_i,
    GT32_RXUSRCLK_OUT => gt32_rxusrclk_i,
    GT32_RXUSRCLK2_OUT => gt32_rxusrclk2_i,
 
    GT33_TXUSRCLK_OUT => gt33_txusrclk_i,
    GT33_TXUSRCLK2_OUT => gt33_txusrclk2_i,
    GT33_RXUSRCLK_OUT => gt33_rxusrclk_i,
    GT33_RXUSRCLK2_OUT => gt33_rxusrclk2_i,


        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT0  (X0Y0)

        --------------------------------- CPLL Ports -------------------------------
        gt0_cpllfbclklost_out           =>      gt0_cpllfbclklost_i,
        gt0_cplllock_out                =>      gt0_cplllock_i,
        gt0_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt0_drpaddr_in                  =>      gt0_drpaddr_i,
        gt0_drpdi_in                    =>      gt0_drpdi_i,
        gt0_drpdo_out                   =>      gt0_drpdo_i,
        gt0_drpen_in                    =>      gt0_drpen_i,
        gt0_drprdy_out                  =>      gt0_drprdy_i,
        gt0_drpwe_in                    =>      gt0_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt0_eyescanreset_in             =>      tied_to_ground_i,
        gt0_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt0_eyescandataerror_out        =>      gt0_eyescandataerror_i,
        gt0_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt0_dmonitorout_out             =>      gt0_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt0_rxdata_out                  =>      gt0_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt0_rxdisperr_out               =>      gt0_rxdisperr_i,
        gt0_rxnotintable_out            =>      gt0_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt0_gthrxn_in                   =>      RXN_IN(0),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt0_rxbyteisaligned_out         =>      gt0_rxbyteisaligned_i,
        gt0_rxmcommaalignen_in          =>      gt0_rxmcommaalignen_i,
        gt0_rxpcommaalignen_in          =>      gt0_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt0_rxmonitorout_out            =>      gt0_rxmonitorout_i,
        gt0_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt0_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt0_rxpolarity_in               =>      gt0_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt0_rxcharisk_out               =>      gt0_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt0_gthrxp_in                   =>      RXP_IN(0),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt0_rxresetdone_out             =>      gt0_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt0_gttxreset_in                =>      tied_to_ground_i,
        gt0_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt0_txdata_in                   =>      gt0_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt0_gthtxn_out                  =>      TXN_OUT(0),
        gt0_gthtxp_out                  =>      TXP_OUT(0),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt0_txoutclkfabric_out          =>      gt0_txoutclkfabric_i,
        gt0_txoutclkpcs_out             =>      gt0_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt0_txresetdone_out             =>      gt0_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt0_txpolarity_in               =>      gt0_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt0_txcharisk_in                =>      gt0_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT1  (X0Y1)

        --------------------------------- CPLL Ports -------------------------------
        gt1_cpllfbclklost_out           =>      gt1_cpllfbclklost_i,
        gt1_cplllock_out                =>      gt1_cplllock_i,
        gt1_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt1_drpaddr_in                  =>      gt1_drpaddr_i,
        gt1_drpdi_in                    =>      gt1_drpdi_i,
        gt1_drpdo_out                   =>      gt1_drpdo_i,
        gt1_drpen_in                    =>      gt1_drpen_i,
        gt1_drprdy_out                  =>      gt1_drprdy_i,
        gt1_drpwe_in                    =>      gt1_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt1_eyescanreset_in             =>      tied_to_ground_i,
        gt1_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt1_eyescandataerror_out        =>      gt1_eyescandataerror_i,
        gt1_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt1_dmonitorout_out             =>      gt1_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt1_rxdata_out                  =>      gt1_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt1_rxdisperr_out               =>      gt1_rxdisperr_i,
        gt1_rxnotintable_out            =>      gt1_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt1_gthrxn_in                   =>      RXN_IN(1),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt1_rxbyteisaligned_out         =>      gt1_rxbyteisaligned_i,
        gt1_rxmcommaalignen_in          =>      gt1_rxmcommaalignen_i,
        gt1_rxpcommaalignen_in          =>      gt1_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt1_rxmonitorout_out            =>      gt1_rxmonitorout_i,
        gt1_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt1_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt1_rxpolarity_in               =>      gt1_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt1_rxcharisk_out               =>      gt1_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt1_gthrxp_in                   =>      RXP_IN(1),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt1_rxresetdone_out             =>      gt1_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt1_gttxreset_in                =>      tied_to_ground_i,
        gt1_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt1_txdata_in                   =>      gt1_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt1_gthtxn_out                  =>      TXN_OUT(1),
        gt1_gthtxp_out                  =>      TXP_OUT(1),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt1_txoutclkfabric_out          =>      gt1_txoutclkfabric_i,
        gt1_txoutclkpcs_out             =>      gt1_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt1_txresetdone_out             =>      gt1_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt1_txpolarity_in               =>      gt1_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt1_txcharisk_in                =>      gt1_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT2  (X0Y2)

        --------------------------------- CPLL Ports -------------------------------
        gt2_cpllfbclklost_out           =>      gt2_cpllfbclklost_i,
        gt2_cplllock_out                =>      gt2_cplllock_i,
        gt2_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt2_drpaddr_in                  =>      gt2_drpaddr_i,
        gt2_drpdi_in                    =>      gt2_drpdi_i,
        gt2_drpdo_out                   =>      gt2_drpdo_i,
        gt2_drpen_in                    =>      gt2_drpen_i,
        gt2_drprdy_out                  =>      gt2_drprdy_i,
        gt2_drpwe_in                    =>      gt2_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt2_eyescanreset_in             =>      tied_to_ground_i,
        gt2_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt2_eyescandataerror_out        =>      gt2_eyescandataerror_i,
        gt2_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt2_dmonitorout_out             =>      gt2_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt2_rxdata_out                  =>      gt2_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt2_rxdisperr_out               =>      gt2_rxdisperr_i,
        gt2_rxnotintable_out            =>      gt2_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt2_gthrxn_in                   =>      RXN_IN(2),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt2_rxbyteisaligned_out         =>      gt2_rxbyteisaligned_i,
        gt2_rxmcommaalignen_in          =>      gt2_rxmcommaalignen_i,
        gt2_rxpcommaalignen_in          =>      gt2_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt2_rxmonitorout_out            =>      gt2_rxmonitorout_i,
        gt2_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt2_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt2_rxpolarity_in               =>      gt2_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt2_rxcharisk_out               =>      gt2_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt2_gthrxp_in                   =>      RXP_IN(2),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt2_rxresetdone_out             =>      gt2_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt2_gttxreset_in                =>      tied_to_ground_i,
        gt2_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt2_txdata_in                   =>      gt2_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt2_gthtxn_out                  =>      TXN_OUT(2),
        gt2_gthtxp_out                  =>      TXP_OUT(2),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt2_txoutclkfabric_out          =>      gt2_txoutclkfabric_i,
        gt2_txoutclkpcs_out             =>      gt2_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt2_txresetdone_out             =>      gt2_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt2_txpolarity_in               =>      gt2_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt2_txcharisk_in                =>      gt2_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT3  (X0Y3)

        --------------------------------- CPLL Ports -------------------------------
        gt3_cpllfbclklost_out           =>      gt3_cpllfbclklost_i,
        gt3_cplllock_out                =>      gt3_cplllock_i,
        gt3_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt3_drpaddr_in                  =>      gt3_drpaddr_i,
        gt3_drpdi_in                    =>      gt3_drpdi_i,
        gt3_drpdo_out                   =>      gt3_drpdo_i,
        gt3_drpen_in                    =>      gt3_drpen_i,
        gt3_drprdy_out                  =>      gt3_drprdy_i,
        gt3_drpwe_in                    =>      gt3_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt3_eyescanreset_in             =>      tied_to_ground_i,
        gt3_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt3_eyescandataerror_out        =>      gt3_eyescandataerror_i,
        gt3_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt3_dmonitorout_out             =>      gt3_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt3_rxdata_out                  =>      gt3_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt3_rxdisperr_out               =>      gt3_rxdisperr_i,
        gt3_rxnotintable_out            =>      gt3_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt3_gthrxn_in                   =>      RXN_IN(3),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt3_rxbyteisaligned_out         =>      gt3_rxbyteisaligned_i,
        gt3_rxmcommaalignen_in          =>      gt3_rxmcommaalignen_i,
        gt3_rxpcommaalignen_in          =>      gt3_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt3_rxmonitorout_out            =>      gt3_rxmonitorout_i,
        gt3_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt3_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt3_rxpolarity_in               =>      gt3_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt3_rxcharisk_out               =>      gt3_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt3_gthrxp_in                   =>      RXP_IN(3),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt3_rxresetdone_out             =>      gt3_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt3_gttxreset_in                =>      tied_to_ground_i,
        gt3_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt3_txdata_in                   =>      gt3_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt3_gthtxn_out                  =>      TXN_OUT(3),
        gt3_gthtxp_out                  =>      TXP_OUT(3),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt3_txoutclkfabric_out          =>      gt3_txoutclkfabric_i,
        gt3_txoutclkpcs_out             =>      gt3_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt3_txresetdone_out             =>      gt3_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt3_txpolarity_in               =>      gt3_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt3_txcharisk_in                =>      gt3_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT4  (X0Y4)

        --------------------------------- CPLL Ports -------------------------------
        gt4_cpllfbclklost_out           =>      gt4_cpllfbclklost_i,
        gt4_cplllock_out                =>      gt4_cplllock_i,
        gt4_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt4_drpaddr_in                  =>      gt4_drpaddr_i,
        gt4_drpdi_in                    =>      gt4_drpdi_i,
        gt4_drpdo_out                   =>      gt4_drpdo_i,
        gt4_drpen_in                    =>      gt4_drpen_i,
        gt4_drprdy_out                  =>      gt4_drprdy_i,
        gt4_drpwe_in                    =>      gt4_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt4_eyescanreset_in             =>      tied_to_ground_i,
        gt4_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt4_eyescandataerror_out        =>      gt4_eyescandataerror_i,
        gt4_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt4_dmonitorout_out             =>      gt4_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt4_rxdata_out                  =>      gt4_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt4_rxdisperr_out               =>      gt4_rxdisperr_i,
        gt4_rxnotintable_out            =>      gt4_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt4_gthrxn_in                   =>      RXN_IN(4),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt4_rxbyteisaligned_out         =>      gt4_rxbyteisaligned_i,
        gt4_rxmcommaalignen_in          =>      gt4_rxmcommaalignen_i,
        gt4_rxpcommaalignen_in          =>      gt4_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt4_rxmonitorout_out            =>      gt4_rxmonitorout_i,
        gt4_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt4_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt4_rxpolarity_in               =>      gt4_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt4_rxcharisk_out               =>      gt4_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt4_gthrxp_in                   =>      RXP_IN(4),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt4_rxresetdone_out             =>      gt4_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt4_gttxreset_in                =>      tied_to_ground_i,
        gt4_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt4_txdata_in                   =>      gt4_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt4_gthtxn_out                  =>      TXN_OUT(4),
        gt4_gthtxp_out                  =>      TXP_OUT(4),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt4_txoutclkfabric_out          =>      gt4_txoutclkfabric_i,
        gt4_txoutclkpcs_out             =>      gt4_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt4_txresetdone_out             =>      gt4_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt4_txpolarity_in               =>      gt4_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt4_txcharisk_in                =>      gt4_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT5  (X0Y5)

        --------------------------------- CPLL Ports -------------------------------
        gt5_cpllfbclklost_out           =>      gt5_cpllfbclklost_i,
        gt5_cplllock_out                =>      gt5_cplllock_i,
        gt5_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt5_drpaddr_in                  =>      gt5_drpaddr_i,
        gt5_drpdi_in                    =>      gt5_drpdi_i,
        gt5_drpdo_out                   =>      gt5_drpdo_i,
        gt5_drpen_in                    =>      gt5_drpen_i,
        gt5_drprdy_out                  =>      gt5_drprdy_i,
        gt5_drpwe_in                    =>      gt5_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt5_eyescanreset_in             =>      tied_to_ground_i,
        gt5_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt5_eyescandataerror_out        =>      gt5_eyescandataerror_i,
        gt5_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt5_dmonitorout_out             =>      gt5_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt5_rxdata_out                  =>      gt5_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt5_rxdisperr_out               =>      gt5_rxdisperr_i,
        gt5_rxnotintable_out            =>      gt5_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt5_gthrxn_in                   =>      RXN_IN(5),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt5_rxbyteisaligned_out         =>      gt5_rxbyteisaligned_i,
        gt5_rxmcommaalignen_in          =>      gt5_rxmcommaalignen_i,
        gt5_rxpcommaalignen_in          =>      gt5_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt5_rxmonitorout_out            =>      gt5_rxmonitorout_i,
        gt5_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt5_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt5_rxpolarity_in               =>      gt5_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt5_rxcharisk_out               =>      gt5_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt5_gthrxp_in                   =>      RXP_IN(5),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt5_rxresetdone_out             =>      gt5_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt5_gttxreset_in                =>      tied_to_ground_i,
        gt5_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt5_txdata_in                   =>      gt5_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt5_gthtxn_out                  =>      TXN_OUT(5),
        gt5_gthtxp_out                  =>      TXP_OUT(5),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt5_txoutclkfabric_out          =>      gt5_txoutclkfabric_i,
        gt5_txoutclkpcs_out             =>      gt5_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt5_txresetdone_out             =>      gt5_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt5_txpolarity_in               =>      gt5_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt5_txcharisk_in                =>      gt5_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT6  (X0Y6)

        --------------------------------- CPLL Ports -------------------------------
        gt6_cpllfbclklost_out           =>      gt6_cpllfbclklost_i,
        gt6_cplllock_out                =>      gt6_cplllock_i,
        gt6_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt6_drpaddr_in                  =>      gt6_drpaddr_i,
        gt6_drpdi_in                    =>      gt6_drpdi_i,
        gt6_drpdo_out                   =>      gt6_drpdo_i,
        gt6_drpen_in                    =>      gt6_drpen_i,
        gt6_drprdy_out                  =>      gt6_drprdy_i,
        gt6_drpwe_in                    =>      gt6_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt6_eyescanreset_in             =>      tied_to_ground_i,
        gt6_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt6_eyescandataerror_out        =>      gt6_eyescandataerror_i,
        gt6_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt6_dmonitorout_out             =>      gt6_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt6_rxdata_out                  =>      gt6_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt6_rxdisperr_out               =>      gt6_rxdisperr_i,
        gt6_rxnotintable_out            =>      gt6_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt6_gthrxn_in                   =>      RXN_IN(6),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt6_rxbyteisaligned_out         =>      gt6_rxbyteisaligned_i,
        gt6_rxmcommaalignen_in          =>      gt6_rxmcommaalignen_i,
        gt6_rxpcommaalignen_in          =>      gt6_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt6_rxmonitorout_out            =>      gt6_rxmonitorout_i,
        gt6_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt6_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt6_rxpolarity_in               =>      gt6_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt6_rxcharisk_out               =>      gt6_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt6_gthrxp_in                   =>      RXP_IN(6),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt6_rxresetdone_out             =>      gt6_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt6_gttxreset_in                =>      tied_to_ground_i,
        gt6_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt6_txdata_in                   =>      gt6_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt6_gthtxn_out                  =>      TXN_OUT(6),
        gt6_gthtxp_out                  =>      TXP_OUT(6),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt6_txoutclkfabric_out          =>      gt6_txoutclkfabric_i,
        gt6_txoutclkpcs_out             =>      gt6_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt6_txresetdone_out             =>      gt6_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt6_txpolarity_in               =>      gt6_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt6_txcharisk_in                =>      gt6_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT7  (X0Y7)

        --------------------------------- CPLL Ports -------------------------------
        gt7_cpllfbclklost_out           =>      gt7_cpllfbclklost_i,
        gt7_cplllock_out                =>      gt7_cplllock_i,
        gt7_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt7_drpaddr_in                  =>      gt7_drpaddr_i,
        gt7_drpdi_in                    =>      gt7_drpdi_i,
        gt7_drpdo_out                   =>      gt7_drpdo_i,
        gt7_drpen_in                    =>      gt7_drpen_i,
        gt7_drprdy_out                  =>      gt7_drprdy_i,
        gt7_drpwe_in                    =>      gt7_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt7_eyescanreset_in             =>      tied_to_ground_i,
        gt7_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt7_eyescandataerror_out        =>      gt7_eyescandataerror_i,
        gt7_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt7_dmonitorout_out             =>      gt7_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt7_rxdata_out                  =>      gt7_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt7_rxdisperr_out               =>      gt7_rxdisperr_i,
        gt7_rxnotintable_out            =>      gt7_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt7_gthrxn_in                   =>      RXN_IN(7),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt7_rxbyteisaligned_out         =>      gt7_rxbyteisaligned_i,
        gt7_rxmcommaalignen_in          =>      gt7_rxmcommaalignen_i,
        gt7_rxpcommaalignen_in          =>      gt7_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt7_rxmonitorout_out            =>      gt7_rxmonitorout_i,
        gt7_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt7_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt7_rxpolarity_in               =>      gt7_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt7_rxcharisk_out               =>      gt7_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt7_gthrxp_in                   =>      RXP_IN(7),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt7_rxresetdone_out             =>      gt7_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt7_gttxreset_in                =>      tied_to_ground_i,
        gt7_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt7_txdata_in                   =>      gt7_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt7_gthtxn_out                  =>      TXN_OUT(7),
        gt7_gthtxp_out                  =>      TXP_OUT(7),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt7_txoutclkfabric_out          =>      gt7_txoutclkfabric_i,
        gt7_txoutclkpcs_out             =>      gt7_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt7_txresetdone_out             =>      gt7_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt7_txpolarity_in               =>      gt7_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt7_txcharisk_in                =>      gt7_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT8  (X0Y8)

        --------------------------------- CPLL Ports -------------------------------
        gt8_cpllfbclklost_out           =>      gt8_cpllfbclklost_i,
        gt8_cplllock_out                =>      gt8_cplllock_i,
        gt8_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt8_drpaddr_in                  =>      gt8_drpaddr_i,
        gt8_drpdi_in                    =>      gt8_drpdi_i,
        gt8_drpdo_out                   =>      gt8_drpdo_i,
        gt8_drpen_in                    =>      gt8_drpen_i,
        gt8_drprdy_out                  =>      gt8_drprdy_i,
        gt8_drpwe_in                    =>      gt8_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt8_eyescanreset_in             =>      tied_to_ground_i,
        gt8_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt8_eyescandataerror_out        =>      gt8_eyescandataerror_i,
        gt8_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt8_dmonitorout_out             =>      gt8_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt8_rxdata_out                  =>      gt8_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt8_rxdisperr_out               =>      gt8_rxdisperr_i,
        gt8_rxnotintable_out            =>      gt8_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt8_gthrxn_in                   =>      RXN_IN(8),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt8_rxbyteisaligned_out         =>      gt8_rxbyteisaligned_i,
        gt8_rxmcommaalignen_in          =>      gt8_rxmcommaalignen_i,
        gt8_rxpcommaalignen_in          =>      gt8_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt8_rxmonitorout_out            =>      gt8_rxmonitorout_i,
        gt8_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt8_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt8_rxpolarity_in               =>      gt8_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt8_rxcharisk_out               =>      gt8_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt8_gthrxp_in                   =>      RXP_IN(8),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt8_rxresetdone_out             =>      gt8_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt8_gttxreset_in                =>      tied_to_ground_i,
        gt8_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt8_txdata_in                   =>      gt8_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt8_gthtxn_out                  =>      TXN_OUT(8),
        gt8_gthtxp_out                  =>      TXP_OUT(8),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt8_txoutclkfabric_out          =>      gt8_txoutclkfabric_i,
        gt8_txoutclkpcs_out             =>      gt8_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt8_txresetdone_out             =>      gt8_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt8_txpolarity_in               =>      gt8_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt8_txcharisk_in                =>      gt8_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT9  (X0Y9)

        --------------------------------- CPLL Ports -------------------------------
        gt9_cpllfbclklost_out           =>      gt9_cpllfbclklost_i,
        gt9_cplllock_out                =>      gt9_cplllock_i,
        gt9_cpllreset_in                =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt9_drpaddr_in                  =>      gt9_drpaddr_i,
        gt9_drpdi_in                    =>      gt9_drpdi_i,
        gt9_drpdo_out                   =>      gt9_drpdo_i,
        gt9_drpen_in                    =>      gt9_drpen_i,
        gt9_drprdy_out                  =>      gt9_drprdy_i,
        gt9_drpwe_in                    =>      gt9_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt9_eyescanreset_in             =>      tied_to_ground_i,
        gt9_rxuserrdy_in                =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt9_eyescandataerror_out        =>      gt9_eyescandataerror_i,
        gt9_eyescantrigger_in           =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt9_dmonitorout_out             =>      gt9_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt9_rxdata_out                  =>      gt9_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt9_rxdisperr_out               =>      gt9_rxdisperr_i,
        gt9_rxnotintable_out            =>      gt9_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt9_gthrxn_in                   =>      RXN_IN(9),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt9_rxbyteisaligned_out         =>      gt9_rxbyteisaligned_i,
        gt9_rxmcommaalignen_in          =>      gt9_rxmcommaalignen_i,
        gt9_rxpcommaalignen_in          =>      gt9_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt9_rxmonitorout_out            =>      gt9_rxmonitorout_i,
        gt9_rxmonitorsel_in             =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt9_gtrxreset_in                =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt9_rxpolarity_in               =>      gt9_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt9_rxcharisk_out               =>      gt9_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt9_gthrxp_in                   =>      RXP_IN(9),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt9_rxresetdone_out             =>      gt9_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt9_gttxreset_in                =>      tied_to_ground_i,
        gt9_txuserrdy_in                =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt9_txdata_in                   =>      gt9_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt9_gthtxn_out                  =>      TXN_OUT(9),
        gt9_gthtxp_out                  =>      TXP_OUT(9),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt9_txoutclkfabric_out          =>      gt9_txoutclkfabric_i,
        gt9_txoutclkpcs_out             =>      gt9_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt9_txresetdone_out             =>      gt9_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt9_txpolarity_in               =>      gt9_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt9_txcharisk_in                =>      gt9_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT10  (X0Y10)

        --------------------------------- CPLL Ports -------------------------------
        gt10_cpllfbclklost_out          =>      gt10_cpllfbclklost_i,
        gt10_cplllock_out               =>      gt10_cplllock_i,
        gt10_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt10_drpaddr_in                 =>      gt10_drpaddr_i,
        gt10_drpdi_in                   =>      gt10_drpdi_i,
        gt10_drpdo_out                  =>      gt10_drpdo_i,
        gt10_drpen_in                   =>      gt10_drpen_i,
        gt10_drprdy_out                 =>      gt10_drprdy_i,
        gt10_drpwe_in                   =>      gt10_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt10_eyescanreset_in            =>      tied_to_ground_i,
        gt10_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt10_eyescandataerror_out       =>      gt10_eyescandataerror_i,
        gt10_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt10_dmonitorout_out            =>      gt10_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt10_rxdata_out                 =>      gt10_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt10_rxdisperr_out              =>      gt10_rxdisperr_i,
        gt10_rxnotintable_out           =>      gt10_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt10_gthrxn_in                  =>      RXN_IN(10),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt10_rxbyteisaligned_out        =>      gt10_rxbyteisaligned_i,
        gt10_rxmcommaalignen_in         =>      gt10_rxmcommaalignen_i,
        gt10_rxpcommaalignen_in         =>      gt10_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt10_rxmonitorout_out           =>      gt10_rxmonitorout_i,
        gt10_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt10_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt10_rxpolarity_in              =>      gt10_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt10_rxcharisk_out              =>      gt10_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt10_gthrxp_in                  =>      RXP_IN(10),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt10_rxresetdone_out            =>      gt10_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt10_gttxreset_in               =>      tied_to_ground_i,
        gt10_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt10_txdata_in                  =>      gt10_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt10_gthtxn_out                 =>      TXN_OUT(10),
        gt10_gthtxp_out                 =>      TXP_OUT(10),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt10_txoutclkfabric_out         =>      gt10_txoutclkfabric_i,
        gt10_txoutclkpcs_out            =>      gt10_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt10_txresetdone_out            =>      gt10_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt10_txpolarity_in              =>      gt10_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt10_txcharisk_in               =>      gt10_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT11  (X0Y11)

        --------------------------------- CPLL Ports -------------------------------
        gt11_cpllfbclklost_out          =>      gt11_cpllfbclklost_i,
        gt11_cplllock_out               =>      gt11_cplllock_i,
        gt11_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt11_drpaddr_in                 =>      gt11_drpaddr_i,
        gt11_drpdi_in                   =>      gt11_drpdi_i,
        gt11_drpdo_out                  =>      gt11_drpdo_i,
        gt11_drpen_in                   =>      gt11_drpen_i,
        gt11_drprdy_out                 =>      gt11_drprdy_i,
        gt11_drpwe_in                   =>      gt11_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt11_eyescanreset_in            =>      tied_to_ground_i,
        gt11_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt11_eyescandataerror_out       =>      gt11_eyescandataerror_i,
        gt11_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt11_dmonitorout_out            =>      gt11_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt11_rxdata_out                 =>      gt11_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt11_rxdisperr_out              =>      gt11_rxdisperr_i,
        gt11_rxnotintable_out           =>      gt11_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt11_gthrxn_in                  =>      RXN_IN(11),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt11_rxbyteisaligned_out        =>      gt11_rxbyteisaligned_i,
        gt11_rxmcommaalignen_in         =>      gt11_rxmcommaalignen_i,
        gt11_rxpcommaalignen_in         =>      gt11_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt11_rxmonitorout_out           =>      gt11_rxmonitorout_i,
        gt11_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt11_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt11_rxpolarity_in              =>      gt11_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt11_rxcharisk_out              =>      gt11_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt11_gthrxp_in                  =>      RXP_IN(11),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt11_rxresetdone_out            =>      gt11_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt11_gttxreset_in               =>      tied_to_ground_i,
        gt11_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt11_txdata_in                  =>      gt11_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt11_gthtxn_out                 =>      TXN_OUT(11),
        gt11_gthtxp_out                 =>      TXP_OUT(11),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt11_txoutclkfabric_out         =>      gt11_txoutclkfabric_i,
        gt11_txoutclkpcs_out            =>      gt11_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt11_txresetdone_out            =>      gt11_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt11_txpolarity_in              =>      gt11_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt11_txcharisk_in               =>      gt11_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT12  (X0Y12)

        --------------------------------- CPLL Ports -------------------------------
        gt12_cpllfbclklost_out          =>      gt12_cpllfbclklost_i,
        gt12_cplllock_out               =>      gt12_cplllock_i,
        gt12_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt12_drpaddr_in                 =>      gt12_drpaddr_i,
        gt12_drpdi_in                   =>      gt12_drpdi_i,
        gt12_drpdo_out                  =>      gt12_drpdo_i,
        gt12_drpen_in                   =>      gt12_drpen_i,
        gt12_drprdy_out                 =>      gt12_drprdy_i,
        gt12_drpwe_in                   =>      gt12_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt12_eyescanreset_in            =>      tied_to_ground_i,
        gt12_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt12_eyescandataerror_out       =>      gt12_eyescandataerror_i,
        gt12_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt12_dmonitorout_out            =>      gt12_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt12_rxdata_out                 =>      gt12_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt12_rxdisperr_out              =>      gt12_rxdisperr_i,
        gt12_rxnotintable_out           =>      gt12_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt12_gthrxn_in                  =>      RXN_IN(12),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt12_rxbyteisaligned_out        =>      gt12_rxbyteisaligned_i,
        gt12_rxmcommaalignen_in         =>      gt12_rxmcommaalignen_i,
        gt12_rxpcommaalignen_in         =>      gt12_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt12_rxmonitorout_out           =>      gt12_rxmonitorout_i,
        gt12_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt12_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt12_rxpolarity_in              =>      gt12_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt12_rxcharisk_out              =>      gt12_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt12_gthrxp_in                  =>      RXP_IN(12),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt12_rxresetdone_out            =>      gt12_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt12_gttxreset_in               =>      tied_to_ground_i,
        gt12_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt12_txdata_in                  =>      gt12_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt12_gthtxn_out                 =>      TXN_OUT(12),
        gt12_gthtxp_out                 =>      TXP_OUT(12),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt12_txoutclkfabric_out         =>      gt12_txoutclkfabric_i,
        gt12_txoutclkpcs_out            =>      gt12_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt12_txresetdone_out            =>      gt12_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt12_txpolarity_in              =>      gt12_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt12_txcharisk_in               =>      gt12_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT13  (X0Y13)

        --------------------------------- CPLL Ports -------------------------------
        gt13_cpllfbclklost_out          =>      gt13_cpllfbclklost_i,
        gt13_cplllock_out               =>      gt13_cplllock_i,
        gt13_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt13_drpaddr_in                 =>      gt13_drpaddr_i,
        gt13_drpdi_in                   =>      gt13_drpdi_i,
        gt13_drpdo_out                  =>      gt13_drpdo_i,
        gt13_drpen_in                   =>      gt13_drpen_i,
        gt13_drprdy_out                 =>      gt13_drprdy_i,
        gt13_drpwe_in                   =>      gt13_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt13_eyescanreset_in            =>      tied_to_ground_i,
        gt13_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt13_eyescandataerror_out       =>      gt13_eyescandataerror_i,
        gt13_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt13_dmonitorout_out            =>      gt13_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt13_rxdata_out                 =>      gt13_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt13_rxdisperr_out              =>      gt13_rxdisperr_i,
        gt13_rxnotintable_out           =>      gt13_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt13_gthrxn_in                  =>      RXN_IN(13),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt13_rxbyteisaligned_out        =>      gt13_rxbyteisaligned_i,
        gt13_rxmcommaalignen_in         =>      gt13_rxmcommaalignen_i,
        gt13_rxpcommaalignen_in         =>      gt13_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt13_rxmonitorout_out           =>      gt13_rxmonitorout_i,
        gt13_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt13_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt13_rxpolarity_in              =>      gt13_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt13_rxcharisk_out              =>      gt13_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt13_gthrxp_in                  =>      RXP_IN(13),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt13_rxresetdone_out            =>      gt13_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt13_gttxreset_in               =>      tied_to_ground_i,
        gt13_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt13_txdata_in                  =>      gt13_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt13_gthtxn_out                 =>      TXN_OUT(13),
        gt13_gthtxp_out                 =>      TXP_OUT(13),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt13_txoutclkfabric_out         =>      gt13_txoutclkfabric_i,
        gt13_txoutclkpcs_out            =>      gt13_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt13_txresetdone_out            =>      gt13_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt13_txpolarity_in              =>      gt13_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt13_txcharisk_in               =>      gt13_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT14  (X0Y14)

        --------------------------------- CPLL Ports -------------------------------
        gt14_cpllfbclklost_out          =>      gt14_cpllfbclklost_i,
        gt14_cplllock_out               =>      gt14_cplllock_i,
        gt14_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt14_drpaddr_in                 =>      gt14_drpaddr_i,
        gt14_drpdi_in                   =>      gt14_drpdi_i,
        gt14_drpdo_out                  =>      gt14_drpdo_i,
        gt14_drpen_in                   =>      gt14_drpen_i,
        gt14_drprdy_out                 =>      gt14_drprdy_i,
        gt14_drpwe_in                   =>      gt14_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt14_eyescanreset_in            =>      tied_to_ground_i,
        gt14_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt14_eyescandataerror_out       =>      gt14_eyescandataerror_i,
        gt14_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt14_dmonitorout_out            =>      gt14_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt14_rxdata_out                 =>      gt14_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt14_rxdisperr_out              =>      gt14_rxdisperr_i,
        gt14_rxnotintable_out           =>      gt14_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt14_gthrxn_in                  =>      RXN_IN(14),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt14_rxbyteisaligned_out        =>      gt14_rxbyteisaligned_i,
        gt14_rxmcommaalignen_in         =>      gt14_rxmcommaalignen_i,
        gt14_rxpcommaalignen_in         =>      gt14_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt14_rxmonitorout_out           =>      gt14_rxmonitorout_i,
        gt14_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt14_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt14_rxpolarity_in              =>      gt14_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt14_rxcharisk_out              =>      gt14_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt14_gthrxp_in                  =>      RXP_IN(14),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt14_rxresetdone_out            =>      gt14_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt14_gttxreset_in               =>      tied_to_ground_i,
        gt14_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt14_txdata_in                  =>      gt14_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt14_gthtxn_out                 =>      TXN_OUT(14),
        gt14_gthtxp_out                 =>      TXP_OUT(14),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt14_txoutclkfabric_out         =>      gt14_txoutclkfabric_i,
        gt14_txoutclkpcs_out            =>      gt14_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt14_txresetdone_out            =>      gt14_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt14_txpolarity_in              =>      gt14_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt14_txcharisk_in               =>      gt14_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT15  (X0Y15)

        --------------------------------- CPLL Ports -------------------------------
        gt15_cpllfbclklost_out          =>      gt15_cpllfbclklost_i,
        gt15_cplllock_out               =>      gt15_cplllock_i,
        gt15_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt15_drpaddr_in                 =>      gt15_drpaddr_i,
        gt15_drpdi_in                   =>      gt15_drpdi_i,
        gt15_drpdo_out                  =>      gt15_drpdo_i,
        gt15_drpen_in                   =>      gt15_drpen_i,
        gt15_drprdy_out                 =>      gt15_drprdy_i,
        gt15_drpwe_in                   =>      gt15_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt15_eyescanreset_in            =>      tied_to_ground_i,
        gt15_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt15_eyescandataerror_out       =>      gt15_eyescandataerror_i,
        gt15_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt15_dmonitorout_out            =>      gt15_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt15_rxdata_out                 =>      gt15_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt15_rxdisperr_out              =>      gt15_rxdisperr_i,
        gt15_rxnotintable_out           =>      gt15_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt15_gthrxn_in                  =>      RXN_IN(15),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt15_rxbyteisaligned_out        =>      gt15_rxbyteisaligned_i,
        gt15_rxmcommaalignen_in         =>      gt15_rxmcommaalignen_i,
        gt15_rxpcommaalignen_in         =>      gt15_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt15_rxmonitorout_out           =>      gt15_rxmonitorout_i,
        gt15_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt15_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt15_rxpolarity_in              =>      gt15_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt15_rxcharisk_out              =>      gt15_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt15_gthrxp_in                  =>      RXP_IN(15),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt15_rxresetdone_out            =>      gt15_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt15_gttxreset_in               =>      tied_to_ground_i,
        gt15_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt15_txdata_in                  =>      gt15_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt15_gthtxn_out                 =>      TXN_OUT(15),
        gt15_gthtxp_out                 =>      TXP_OUT(15),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt15_txoutclkfabric_out         =>      gt15_txoutclkfabric_i,
        gt15_txoutclkpcs_out            =>      gt15_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt15_txresetdone_out            =>      gt15_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt15_txpolarity_in              =>      gt15_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt15_txcharisk_in               =>      gt15_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT16  (X0Y16)

        --------------------------------- CPLL Ports -------------------------------
        gt16_cpllfbclklost_out          =>      gt16_cpllfbclklost_i,
        gt16_cplllock_out               =>      gt16_cplllock_i,
        gt16_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt16_drpaddr_in                 =>      gt16_drpaddr_i,
        gt16_drpdi_in                   =>      gt16_drpdi_i,
        gt16_drpdo_out                  =>      gt16_drpdo_i,
        gt16_drpen_in                   =>      gt16_drpen_i,
        gt16_drprdy_out                 =>      gt16_drprdy_i,
        gt16_drpwe_in                   =>      gt16_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt16_eyescanreset_in            =>      tied_to_ground_i,
        gt16_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt16_eyescandataerror_out       =>      gt16_eyescandataerror_i,
        gt16_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt16_dmonitorout_out            =>      gt16_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt16_rxdata_out                 =>      gt16_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt16_rxdisperr_out              =>      gt16_rxdisperr_i,
        gt16_rxnotintable_out           =>      gt16_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt16_gthrxn_in                  =>      RXN_IN(16),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt16_rxbyteisaligned_out        =>      gt16_rxbyteisaligned_i,
        gt16_rxmcommaalignen_in         =>      gt16_rxmcommaalignen_i,
        gt16_rxpcommaalignen_in         =>      gt16_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt16_rxmonitorout_out           =>      gt16_rxmonitorout_i,
        gt16_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt16_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt16_rxpolarity_in              =>      gt16_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt16_rxcharisk_out              =>      gt16_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt16_gthrxp_in                  =>      RXP_IN(16),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt16_rxresetdone_out            =>      gt16_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt16_gttxreset_in               =>      tied_to_ground_i,
        gt16_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt16_txdata_in                  =>      gt16_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt16_gthtxn_out                 =>      TXN_OUT(16),
        gt16_gthtxp_out                 =>      TXP_OUT(16),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt16_txoutclkfabric_out         =>      gt16_txoutclkfabric_i,
        gt16_txoutclkpcs_out            =>      gt16_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt16_txresetdone_out            =>      gt16_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt16_txpolarity_in              =>      gt16_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt16_txcharisk_in               =>      gt16_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT17  (X0Y17)

        --------------------------------- CPLL Ports -------------------------------
        gt17_cpllfbclklost_out          =>      gt17_cpllfbclklost_i,
        gt17_cplllock_out               =>      gt17_cplllock_i,
        gt17_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt17_drpaddr_in                 =>      gt17_drpaddr_i,
        gt17_drpdi_in                   =>      gt17_drpdi_i,
        gt17_drpdo_out                  =>      gt17_drpdo_i,
        gt17_drpen_in                   =>      gt17_drpen_i,
        gt17_drprdy_out                 =>      gt17_drprdy_i,
        gt17_drpwe_in                   =>      gt17_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt17_eyescanreset_in            =>      tied_to_ground_i,
        gt17_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt17_eyescandataerror_out       =>      gt17_eyescandataerror_i,
        gt17_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt17_dmonitorout_out            =>      gt17_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt17_rxdata_out                 =>      gt17_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt17_rxdisperr_out              =>      gt17_rxdisperr_i,
        gt17_rxnotintable_out           =>      gt17_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt17_gthrxn_in                  =>      RXN_IN(17),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt17_rxbyteisaligned_out        =>      gt17_rxbyteisaligned_i,
        gt17_rxmcommaalignen_in         =>      gt17_rxmcommaalignen_i,
        gt17_rxpcommaalignen_in         =>      gt17_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt17_rxmonitorout_out           =>      gt17_rxmonitorout_i,
        gt17_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt17_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt17_rxpolarity_in              =>      gt17_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt17_rxcharisk_out              =>      gt17_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt17_gthrxp_in                  =>      RXP_IN(17),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt17_rxresetdone_out            =>      gt17_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt17_gttxreset_in               =>      tied_to_ground_i,
        gt17_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt17_txdata_in                  =>      gt17_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt17_gthtxn_out                 =>      TXN_OUT(17),
        gt17_gthtxp_out                 =>      TXP_OUT(17),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt17_txoutclkfabric_out         =>      gt17_txoutclkfabric_i,
        gt17_txoutclkpcs_out            =>      gt17_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt17_txresetdone_out            =>      gt17_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt17_txpolarity_in              =>      gt17_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt17_txcharisk_in               =>      gt17_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT18  (X0Y18)

        --------------------------------- CPLL Ports -------------------------------
        gt18_cpllfbclklost_out          =>      gt18_cpllfbclklost_i,
        gt18_cplllock_out               =>      gt18_cplllock_i,
        gt18_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt18_drpaddr_in                 =>      gt18_drpaddr_i,
        gt18_drpdi_in                   =>      gt18_drpdi_i,
        gt18_drpdo_out                  =>      gt18_drpdo_i,
        gt18_drpen_in                   =>      gt18_drpen_i,
        gt18_drprdy_out                 =>      gt18_drprdy_i,
        gt18_drpwe_in                   =>      gt18_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt18_eyescanreset_in            =>      tied_to_ground_i,
        gt18_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt18_eyescandataerror_out       =>      gt18_eyescandataerror_i,
        gt18_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt18_dmonitorout_out            =>      gt18_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt18_rxdata_out                 =>      gt18_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt18_rxdisperr_out              =>      gt18_rxdisperr_i,
        gt18_rxnotintable_out           =>      gt18_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt18_gthrxn_in                  =>      RXN_IN(18),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt18_rxbyteisaligned_out        =>      gt18_rxbyteisaligned_i,
        gt18_rxmcommaalignen_in         =>      gt18_rxmcommaalignen_i,
        gt18_rxpcommaalignen_in         =>      gt18_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt18_rxmonitorout_out           =>      gt18_rxmonitorout_i,
        gt18_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt18_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt18_rxpolarity_in              =>      gt18_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt18_rxcharisk_out              =>      gt18_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt18_gthrxp_in                  =>      RXP_IN(18),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt18_rxresetdone_out            =>      gt18_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt18_gttxreset_in               =>      tied_to_ground_i,
        gt18_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt18_txdata_in                  =>      gt18_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt18_gthtxn_out                 =>      TXN_OUT(18),
        gt18_gthtxp_out                 =>      TXP_OUT(18),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt18_txoutclkfabric_out         =>      gt18_txoutclkfabric_i,
        gt18_txoutclkpcs_out            =>      gt18_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt18_txresetdone_out            =>      gt18_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt18_txpolarity_in              =>      gt18_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt18_txcharisk_in               =>      gt18_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT19  (X0Y19)

        --------------------------------- CPLL Ports -------------------------------
        gt19_cpllfbclklost_out          =>      gt19_cpllfbclklost_i,
        gt19_cplllock_out               =>      gt19_cplllock_i,
        gt19_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt19_drpaddr_in                 =>      gt19_drpaddr_i,
        gt19_drpdi_in                   =>      gt19_drpdi_i,
        gt19_drpdo_out                  =>      gt19_drpdo_i,
        gt19_drpen_in                   =>      gt19_drpen_i,
        gt19_drprdy_out                 =>      gt19_drprdy_i,
        gt19_drpwe_in                   =>      gt19_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt19_eyescanreset_in            =>      tied_to_ground_i,
        gt19_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt19_eyescandataerror_out       =>      gt19_eyescandataerror_i,
        gt19_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt19_dmonitorout_out            =>      gt19_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt19_rxdata_out                 =>      gt19_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt19_rxdisperr_out              =>      gt19_rxdisperr_i,
        gt19_rxnotintable_out           =>      gt19_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt19_gthrxn_in                  =>      RXN_IN(19),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt19_rxbyteisaligned_out        =>      gt19_rxbyteisaligned_i,
        gt19_rxmcommaalignen_in         =>      gt19_rxmcommaalignen_i,
        gt19_rxpcommaalignen_in         =>      gt19_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt19_rxmonitorout_out           =>      gt19_rxmonitorout_i,
        gt19_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt19_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt19_rxpolarity_in              =>      gt19_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt19_rxcharisk_out              =>      gt19_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt19_gthrxp_in                  =>      RXP_IN(19),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt19_rxresetdone_out            =>      gt19_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt19_gttxreset_in               =>      tied_to_ground_i,
        gt19_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt19_txdata_in                  =>      gt19_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt19_gthtxn_out                 =>      TXN_OUT(19),
        gt19_gthtxp_out                 =>      TXP_OUT(19),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt19_txoutclkfabric_out         =>      gt19_txoutclkfabric_i,
        gt19_txoutclkpcs_out            =>      gt19_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt19_txresetdone_out            =>      gt19_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt19_txpolarity_in              =>      gt19_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt19_txcharisk_in               =>      gt19_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT20  (X0Y20)

        --------------------------------- CPLL Ports -------------------------------
        gt20_cpllfbclklost_out          =>      gt20_cpllfbclklost_i,
        gt20_cplllock_out               =>      gt20_cplllock_i,
        gt20_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt20_drpaddr_in                 =>      gt20_drpaddr_i,
        gt20_drpdi_in                   =>      gt20_drpdi_i,
        gt20_drpdo_out                  =>      gt20_drpdo_i,
        gt20_drpen_in                   =>      gt20_drpen_i,
        gt20_drprdy_out                 =>      gt20_drprdy_i,
        gt20_drpwe_in                   =>      gt20_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt20_eyescanreset_in            =>      tied_to_ground_i,
        gt20_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt20_eyescandataerror_out       =>      gt20_eyescandataerror_i,
        gt20_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt20_dmonitorout_out            =>      gt20_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt20_rxdata_out                 =>      gt20_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt20_rxdisperr_out              =>      gt20_rxdisperr_i,
        gt20_rxnotintable_out           =>      gt20_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt20_gthrxn_in                  =>      RXN_IN(20),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt20_rxbyteisaligned_out        =>      gt20_rxbyteisaligned_i,
        gt20_rxmcommaalignen_in         =>      gt20_rxmcommaalignen_i,
        gt20_rxpcommaalignen_in         =>      gt20_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt20_rxmonitorout_out           =>      gt20_rxmonitorout_i,
        gt20_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt20_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt20_rxpolarity_in              =>      gt20_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt20_rxcharisk_out              =>      gt20_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt20_gthrxp_in                  =>      RXP_IN(20),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt20_rxresetdone_out            =>      gt20_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt20_gttxreset_in               =>      tied_to_ground_i,
        gt20_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt20_txdata_in                  =>      gt20_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt20_gthtxn_out                 =>      TXN_OUT(20),
        gt20_gthtxp_out                 =>      TXP_OUT(20),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt20_txoutclkfabric_out         =>      gt20_txoutclkfabric_i,
        gt20_txoutclkpcs_out            =>      gt20_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt20_txresetdone_out            =>      gt20_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt20_txpolarity_in              =>      gt20_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt20_txcharisk_in               =>      gt20_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT21  (X0Y21)

        --------------------------------- CPLL Ports -------------------------------
        gt21_cpllfbclklost_out          =>      gt21_cpllfbclklost_i,
        gt21_cplllock_out               =>      gt21_cplllock_i,
        gt21_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt21_drpaddr_in                 =>      gt21_drpaddr_i,
        gt21_drpdi_in                   =>      gt21_drpdi_i,
        gt21_drpdo_out                  =>      gt21_drpdo_i,
        gt21_drpen_in                   =>      gt21_drpen_i,
        gt21_drprdy_out                 =>      gt21_drprdy_i,
        gt21_drpwe_in                   =>      gt21_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt21_eyescanreset_in            =>      tied_to_ground_i,
        gt21_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt21_eyescandataerror_out       =>      gt21_eyescandataerror_i,
        gt21_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt21_dmonitorout_out            =>      gt21_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt21_rxdata_out                 =>      gt21_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt21_rxdisperr_out              =>      gt21_rxdisperr_i,
        gt21_rxnotintable_out           =>      gt21_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt21_gthrxn_in                  =>      RXN_IN(21),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt21_rxbyteisaligned_out        =>      gt21_rxbyteisaligned_i,
        gt21_rxmcommaalignen_in         =>      gt21_rxmcommaalignen_i,
        gt21_rxpcommaalignen_in         =>      gt21_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt21_rxmonitorout_out           =>      gt21_rxmonitorout_i,
        gt21_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt21_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt21_rxpolarity_in              =>      gt21_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt21_rxcharisk_out              =>      gt21_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt21_gthrxp_in                  =>      RXP_IN(21),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt21_rxresetdone_out            =>      gt21_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt21_gttxreset_in               =>      tied_to_ground_i,
        gt21_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt21_txdata_in                  =>      gt21_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt21_gthtxn_out                 =>      TXN_OUT(21),
        gt21_gthtxp_out                 =>      TXP_OUT(21),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt21_txoutclkfabric_out         =>      gt21_txoutclkfabric_i,
        gt21_txoutclkpcs_out            =>      gt21_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt21_txresetdone_out            =>      gt21_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt21_txpolarity_in              =>      gt21_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt21_txcharisk_in               =>      gt21_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT22  (X0Y22)

        --------------------------------- CPLL Ports -------------------------------
        gt22_cpllfbclklost_out          =>      gt22_cpllfbclklost_i,
        gt22_cplllock_out               =>      gt22_cplllock_i,
        gt22_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt22_drpaddr_in                 =>      gt22_drpaddr_i,
        gt22_drpdi_in                   =>      gt22_drpdi_i,
        gt22_drpdo_out                  =>      gt22_drpdo_i,
        gt22_drpen_in                   =>      gt22_drpen_i,
        gt22_drprdy_out                 =>      gt22_drprdy_i,
        gt22_drpwe_in                   =>      gt22_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt22_eyescanreset_in            =>      tied_to_ground_i,
        gt22_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt22_eyescandataerror_out       =>      gt22_eyescandataerror_i,
        gt22_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt22_dmonitorout_out            =>      gt22_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt22_rxdata_out                 =>      gt22_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt22_rxdisperr_out              =>      gt22_rxdisperr_i,
        gt22_rxnotintable_out           =>      gt22_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt22_gthrxn_in                  =>      RXN_IN(22),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt22_rxbyteisaligned_out        =>      gt22_rxbyteisaligned_i,
        gt22_rxmcommaalignen_in         =>      gt22_rxmcommaalignen_i,
        gt22_rxpcommaalignen_in         =>      gt22_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt22_rxmonitorout_out           =>      gt22_rxmonitorout_i,
        gt22_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt22_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt22_rxpolarity_in              =>      gt22_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt22_rxcharisk_out              =>      gt22_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt22_gthrxp_in                  =>      RXP_IN(22),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt22_rxresetdone_out            =>      gt22_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt22_gttxreset_in               =>      tied_to_ground_i,
        gt22_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt22_txdata_in                  =>      gt22_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt22_gthtxn_out                 =>      TXN_OUT(22),
        gt22_gthtxp_out                 =>      TXP_OUT(22),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt22_txoutclkfabric_out         =>      gt22_txoutclkfabric_i,
        gt22_txoutclkpcs_out            =>      gt22_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt22_txresetdone_out            =>      gt22_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt22_txpolarity_in              =>      gt22_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt22_txcharisk_in               =>      gt22_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT23  (X0Y23)

        --------------------------------- CPLL Ports -------------------------------
        gt23_cpllfbclklost_out          =>      gt23_cpllfbclklost_i,
        gt23_cplllock_out               =>      gt23_cplllock_i,
        gt23_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt23_drpaddr_in                 =>      gt23_drpaddr_i,
        gt23_drpdi_in                   =>      gt23_drpdi_i,
        gt23_drpdo_out                  =>      gt23_drpdo_i,
        gt23_drpen_in                   =>      gt23_drpen_i,
        gt23_drprdy_out                 =>      gt23_drprdy_i,
        gt23_drpwe_in                   =>      gt23_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt23_eyescanreset_in            =>      tied_to_ground_i,
        gt23_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt23_eyescandataerror_out       =>      gt23_eyescandataerror_i,
        gt23_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt23_dmonitorout_out            =>      gt23_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt23_rxdata_out                 =>      gt23_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt23_rxdisperr_out              =>      gt23_rxdisperr_i,
        gt23_rxnotintable_out           =>      gt23_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt23_gthrxn_in                  =>      RXN_IN(23),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt23_rxbyteisaligned_out        =>      gt23_rxbyteisaligned_i,
        gt23_rxmcommaalignen_in         =>      gt23_rxmcommaalignen_i,
        gt23_rxpcommaalignen_in         =>      gt23_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt23_rxmonitorout_out           =>      gt23_rxmonitorout_i,
        gt23_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt23_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt23_rxpolarity_in              =>      gt23_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt23_rxcharisk_out              =>      gt23_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt23_gthrxp_in                  =>      RXP_IN(23),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt23_rxresetdone_out            =>      gt23_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt23_gttxreset_in               =>      tied_to_ground_i,
        gt23_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt23_txdata_in                  =>      gt23_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt23_gthtxn_out                 =>      TXN_OUT(23),
        gt23_gthtxp_out                 =>      TXP_OUT(23),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt23_txoutclkfabric_out         =>      gt23_txoutclkfabric_i,
        gt23_txoutclkpcs_out            =>      gt23_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt23_txresetdone_out            =>      gt23_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt23_txpolarity_in              =>      gt23_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt23_txcharisk_in               =>      gt23_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT24  (X0Y24)

        --------------------------------- CPLL Ports -------------------------------
        gt24_cpllfbclklost_out          =>      gt24_cpllfbclklost_i,
        gt24_cplllock_out               =>      gt24_cplllock_i,
        gt24_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt24_drpaddr_in                 =>      gt24_drpaddr_i,
        gt24_drpdi_in                   =>      gt24_drpdi_i,
        gt24_drpdo_out                  =>      gt24_drpdo_i,
        gt24_drpen_in                   =>      gt24_drpen_i,
        gt24_drprdy_out                 =>      gt24_drprdy_i,
        gt24_drpwe_in                   =>      gt24_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt24_eyescanreset_in            =>      tied_to_ground_i,
        gt24_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt24_eyescandataerror_out       =>      gt24_eyescandataerror_i,
        gt24_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt24_dmonitorout_out            =>      gt24_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt24_rxdata_out                 =>      gt24_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt24_rxdisperr_out              =>      gt24_rxdisperr_i,
        gt24_rxnotintable_out           =>      gt24_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt24_gthrxn_in                  =>      RXN_IN(24),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt24_rxbyteisaligned_out        =>      gt24_rxbyteisaligned_i,
        gt24_rxmcommaalignen_in         =>      gt24_rxmcommaalignen_i,
        gt24_rxpcommaalignen_in         =>      gt24_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt24_rxmonitorout_out           =>      gt24_rxmonitorout_i,
        gt24_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt24_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt24_rxpolarity_in              =>      gt24_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt24_rxcharisk_out              =>      gt24_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt24_gthrxp_in                  =>      RXP_IN(24),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt24_rxresetdone_out            =>      gt24_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt24_gttxreset_in               =>      tied_to_ground_i,
        gt24_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt24_txdata_in                  =>      gt24_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt24_gthtxn_out                 =>      TXN_OUT(24),
        gt24_gthtxp_out                 =>      TXP_OUT(24),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt24_txoutclkfabric_out         =>      gt24_txoutclkfabric_i,
        gt24_txoutclkpcs_out            =>      gt24_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt24_txresetdone_out            =>      gt24_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt24_txpolarity_in              =>      gt24_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt24_txcharisk_in               =>      gt24_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT25  (X0Y25)

        --------------------------------- CPLL Ports -------------------------------
        gt25_cpllfbclklost_out          =>      gt25_cpllfbclklost_i,
        gt25_cplllock_out               =>      gt25_cplllock_i,
        gt25_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt25_drpaddr_in                 =>      gt25_drpaddr_i,
        gt25_drpdi_in                   =>      gt25_drpdi_i,
        gt25_drpdo_out                  =>      gt25_drpdo_i,
        gt25_drpen_in                   =>      gt25_drpen_i,
        gt25_drprdy_out                 =>      gt25_drprdy_i,
        gt25_drpwe_in                   =>      gt25_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt25_eyescanreset_in            =>      tied_to_ground_i,
        gt25_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt25_eyescandataerror_out       =>      gt25_eyescandataerror_i,
        gt25_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt25_dmonitorout_out            =>      gt25_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt25_rxdata_out                 =>      gt25_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt25_rxdisperr_out              =>      gt25_rxdisperr_i,
        gt25_rxnotintable_out           =>      gt25_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt25_gthrxn_in                  =>      RXN_IN(25),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt25_rxbyteisaligned_out        =>      gt25_rxbyteisaligned_i,
        gt25_rxmcommaalignen_in         =>      gt25_rxmcommaalignen_i,
        gt25_rxpcommaalignen_in         =>      gt25_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt25_rxmonitorout_out           =>      gt25_rxmonitorout_i,
        gt25_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt25_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt25_rxpolarity_in              =>      gt25_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt25_rxcharisk_out              =>      gt25_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt25_gthrxp_in                  =>      RXP_IN(25),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt25_rxresetdone_out            =>      gt25_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt25_gttxreset_in               =>      tied_to_ground_i,
        gt25_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt25_txdata_in                  =>      gt25_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt25_gthtxn_out                 =>      TXN_OUT(25),
        gt25_gthtxp_out                 =>      TXP_OUT(25),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt25_txoutclkfabric_out         =>      gt25_txoutclkfabric_i,
        gt25_txoutclkpcs_out            =>      gt25_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt25_txresetdone_out            =>      gt25_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt25_txpolarity_in              =>      gt25_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt25_txcharisk_in               =>      gt25_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT26  (X0Y26)

        --------------------------------- CPLL Ports -------------------------------
        gt26_cpllfbclklost_out          =>      gt26_cpllfbclklost_i,
        gt26_cplllock_out               =>      gt26_cplllock_i,
        gt26_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt26_drpaddr_in                 =>      gt26_drpaddr_i,
        gt26_drpdi_in                   =>      gt26_drpdi_i,
        gt26_drpdo_out                  =>      gt26_drpdo_i,
        gt26_drpen_in                   =>      gt26_drpen_i,
        gt26_drprdy_out                 =>      gt26_drprdy_i,
        gt26_drpwe_in                   =>      gt26_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt26_eyescanreset_in            =>      tied_to_ground_i,
        gt26_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt26_eyescandataerror_out       =>      gt26_eyescandataerror_i,
        gt26_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt26_dmonitorout_out            =>      gt26_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt26_rxdata_out                 =>      gt26_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt26_rxdisperr_out              =>      gt26_rxdisperr_i,
        gt26_rxnotintable_out           =>      gt26_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt26_gthrxn_in                  =>      RXN_IN(26),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt26_rxbyteisaligned_out        =>      gt26_rxbyteisaligned_i,
        gt26_rxmcommaalignen_in         =>      gt26_rxmcommaalignen_i,
        gt26_rxpcommaalignen_in         =>      gt26_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt26_rxmonitorout_out           =>      gt26_rxmonitorout_i,
        gt26_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt26_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt26_rxpolarity_in              =>      gt26_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt26_rxcharisk_out              =>      gt26_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt26_gthrxp_in                  =>      RXP_IN(26),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt26_rxresetdone_out            =>      gt26_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt26_gttxreset_in               =>      tied_to_ground_i,
        gt26_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt26_txdata_in                  =>      gt26_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt26_gthtxn_out                 =>      TXN_OUT(26),
        gt26_gthtxp_out                 =>      TXP_OUT(26),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt26_txoutclkfabric_out         =>      gt26_txoutclkfabric_i,
        gt26_txoutclkpcs_out            =>      gt26_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt26_txresetdone_out            =>      gt26_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt26_txpolarity_in              =>      gt26_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt26_txcharisk_in               =>      gt26_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT27  (X0Y27)

        --------------------------------- CPLL Ports -------------------------------
        gt27_cpllfbclklost_out          =>      gt27_cpllfbclklost_i,
        gt27_cplllock_out               =>      gt27_cplllock_i,
        gt27_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt27_drpaddr_in                 =>      gt27_drpaddr_i,
        gt27_drpdi_in                   =>      gt27_drpdi_i,
        gt27_drpdo_out                  =>      gt27_drpdo_i,
        gt27_drpen_in                   =>      gt27_drpen_i,
        gt27_drprdy_out                 =>      gt27_drprdy_i,
        gt27_drpwe_in                   =>      gt27_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt27_eyescanreset_in            =>      tied_to_ground_i,
        gt27_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt27_eyescandataerror_out       =>      gt27_eyescandataerror_i,
        gt27_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt27_dmonitorout_out            =>      gt27_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt27_rxdata_out                 =>      gt27_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt27_rxdisperr_out              =>      gt27_rxdisperr_i,
        gt27_rxnotintable_out           =>      gt27_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt27_gthrxn_in                  =>      RXN_IN(27),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt27_rxbyteisaligned_out        =>      gt27_rxbyteisaligned_i,
        gt27_rxmcommaalignen_in         =>      gt27_rxmcommaalignen_i,
        gt27_rxpcommaalignen_in         =>      gt27_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt27_rxmonitorout_out           =>      gt27_rxmonitorout_i,
        gt27_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt27_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt27_rxpolarity_in              =>      gt27_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt27_rxcharisk_out              =>      gt27_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt27_gthrxp_in                  =>      RXP_IN(27),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt27_rxresetdone_out            =>      gt27_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt27_gttxreset_in               =>      tied_to_ground_i,
        gt27_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt27_txdata_in                  =>      gt27_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt27_gthtxn_out                 =>      TXN_OUT(27),
        gt27_gthtxp_out                 =>      TXP_OUT(27),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt27_txoutclkfabric_out         =>      gt27_txoutclkfabric_i,
        gt27_txoutclkpcs_out            =>      gt27_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt27_txresetdone_out            =>      gt27_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt27_txpolarity_in              =>      gt27_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt27_txcharisk_in               =>      gt27_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT28  (X0Y28)

        --------------------------------- CPLL Ports -------------------------------
        gt28_cpllfbclklost_out          =>      gt28_cpllfbclklost_i,
        gt28_cplllock_out               =>      gt28_cplllock_i,
        gt28_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt28_drpaddr_in                 =>      gt28_drpaddr_i,
        gt28_drpdi_in                   =>      gt28_drpdi_i,
        gt28_drpdo_out                  =>      gt28_drpdo_i,
        gt28_drpen_in                   =>      gt28_drpen_i,
        gt28_drprdy_out                 =>      gt28_drprdy_i,
        gt28_drpwe_in                   =>      gt28_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt28_eyescanreset_in            =>      tied_to_ground_i,
        gt28_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt28_eyescandataerror_out       =>      gt28_eyescandataerror_i,
        gt28_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt28_dmonitorout_out            =>      gt28_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt28_rxdata_out                 =>      gt28_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt28_rxdisperr_out              =>      gt28_rxdisperr_i,
        gt28_rxnotintable_out           =>      gt28_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt28_gthrxn_in                  =>      RXN_IN(28),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt28_rxbyteisaligned_out        =>      gt28_rxbyteisaligned_i,
        gt28_rxmcommaalignen_in         =>      gt28_rxmcommaalignen_i,
        gt28_rxpcommaalignen_in         =>      gt28_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt28_rxmonitorout_out           =>      gt28_rxmonitorout_i,
        gt28_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt28_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt28_rxpolarity_in              =>      gt28_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt28_rxcharisk_out              =>      gt28_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt28_gthrxp_in                  =>      RXP_IN(28),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt28_rxresetdone_out            =>      gt28_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt28_gttxreset_in               =>      tied_to_ground_i,
        gt28_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt28_txdata_in                  =>      gt28_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt28_gthtxn_out                 =>      TXN_OUT(28),
        gt28_gthtxp_out                 =>      TXP_OUT(28),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt28_txoutclkfabric_out         =>      gt28_txoutclkfabric_i,
        gt28_txoutclkpcs_out            =>      gt28_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt28_txresetdone_out            =>      gt28_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt28_txpolarity_in              =>      gt28_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt28_txcharisk_in               =>      gt28_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT29  (X0Y29)

        --------------------------------- CPLL Ports -------------------------------
        gt29_cpllfbclklost_out          =>      gt29_cpllfbclklost_i,
        gt29_cplllock_out               =>      gt29_cplllock_i,
        gt29_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt29_drpaddr_in                 =>      gt29_drpaddr_i,
        gt29_drpdi_in                   =>      gt29_drpdi_i,
        gt29_drpdo_out                  =>      gt29_drpdo_i,
        gt29_drpen_in                   =>      gt29_drpen_i,
        gt29_drprdy_out                 =>      gt29_drprdy_i,
        gt29_drpwe_in                   =>      gt29_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt29_eyescanreset_in            =>      tied_to_ground_i,
        gt29_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt29_eyescandataerror_out       =>      gt29_eyescandataerror_i,
        gt29_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt29_dmonitorout_out            =>      gt29_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt29_rxdata_out                 =>      gt29_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt29_rxdisperr_out              =>      gt29_rxdisperr_i,
        gt29_rxnotintable_out           =>      gt29_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt29_gthrxn_in                  =>      RXN_IN(29),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt29_rxbyteisaligned_out        =>      gt29_rxbyteisaligned_i,
        gt29_rxmcommaalignen_in         =>      gt29_rxmcommaalignen_i,
        gt29_rxpcommaalignen_in         =>      gt29_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt29_rxmonitorout_out           =>      gt29_rxmonitorout_i,
        gt29_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt29_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt29_rxpolarity_in              =>      gt29_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt29_rxcharisk_out              =>      gt29_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt29_gthrxp_in                  =>      RXP_IN(29),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt29_rxresetdone_out            =>      gt29_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt29_gttxreset_in               =>      tied_to_ground_i,
        gt29_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt29_txdata_in                  =>      gt29_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt29_gthtxn_out                 =>      TXN_OUT(29),
        gt29_gthtxp_out                 =>      TXP_OUT(29),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt29_txoutclkfabric_out         =>      gt29_txoutclkfabric_i,
        gt29_txoutclkpcs_out            =>      gt29_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt29_txresetdone_out            =>      gt29_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt29_txpolarity_in              =>      gt29_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt29_txcharisk_in               =>      gt29_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT30  (X0Y30)

        --------------------------------- CPLL Ports -------------------------------
        gt30_cpllfbclklost_out          =>      gt30_cpllfbclklost_i,
        gt30_cplllock_out               =>      gt30_cplllock_i,
        gt30_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt30_drpaddr_in                 =>      gt30_drpaddr_i,
        gt30_drpdi_in                   =>      gt30_drpdi_i,
        gt30_drpdo_out                  =>      gt30_drpdo_i,
        gt30_drpen_in                   =>      gt30_drpen_i,
        gt30_drprdy_out                 =>      gt30_drprdy_i,
        gt30_drpwe_in                   =>      gt30_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt30_eyescanreset_in            =>      tied_to_ground_i,
        gt30_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt30_eyescandataerror_out       =>      gt30_eyescandataerror_i,
        gt30_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt30_dmonitorout_out            =>      gt30_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt30_rxdata_out                 =>      gt30_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt30_rxdisperr_out              =>      gt30_rxdisperr_i,
        gt30_rxnotintable_out           =>      gt30_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt30_gthrxn_in                  =>      RXN_IN(30),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt30_rxbyteisaligned_out        =>      gt30_rxbyteisaligned_i,
        gt30_rxmcommaalignen_in         =>      gt30_rxmcommaalignen_i,
        gt30_rxpcommaalignen_in         =>      gt30_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt30_rxmonitorout_out           =>      gt30_rxmonitorout_i,
        gt30_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt30_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt30_rxpolarity_in              =>      gt30_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt30_rxcharisk_out              =>      gt30_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt30_gthrxp_in                  =>      RXP_IN(30),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt30_rxresetdone_out            =>      gt30_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt30_gttxreset_in               =>      tied_to_ground_i,
        gt30_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt30_txdata_in                  =>      gt30_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt30_gthtxn_out                 =>      TXN_OUT(30),
        gt30_gthtxp_out                 =>      TXP_OUT(30),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt30_txoutclkfabric_out         =>      gt30_txoutclkfabric_i,
        gt30_txoutclkpcs_out            =>      gt30_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt30_txresetdone_out            =>      gt30_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt30_txpolarity_in              =>      gt30_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt30_txcharisk_in               =>      gt30_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT31  (X0Y31)

        --------------------------------- CPLL Ports -------------------------------
        gt31_cpllfbclklost_out          =>      gt31_cpllfbclklost_i,
        gt31_cplllock_out               =>      gt31_cplllock_i,
        gt31_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt31_drpaddr_in                 =>      gt31_drpaddr_i,
        gt31_drpdi_in                   =>      gt31_drpdi_i,
        gt31_drpdo_out                  =>      gt31_drpdo_i,
        gt31_drpen_in                   =>      gt31_drpen_i,
        gt31_drprdy_out                 =>      gt31_drprdy_i,
        gt31_drpwe_in                   =>      gt31_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt31_eyescanreset_in            =>      tied_to_ground_i,
        gt31_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt31_eyescandataerror_out       =>      gt31_eyescandataerror_i,
        gt31_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt31_dmonitorout_out            =>      gt31_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt31_rxdata_out                 =>      gt31_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt31_rxdisperr_out              =>      gt31_rxdisperr_i,
        gt31_rxnotintable_out           =>      gt31_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt31_gthrxn_in                  =>      RXN_IN(31),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt31_rxbyteisaligned_out        =>      gt31_rxbyteisaligned_i,
        gt31_rxmcommaalignen_in         =>      gt31_rxmcommaalignen_i,
        gt31_rxpcommaalignen_in         =>      gt31_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt31_rxmonitorout_out           =>      gt31_rxmonitorout_i,
        gt31_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt31_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt31_rxpolarity_in              =>      gt31_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt31_rxcharisk_out              =>      gt31_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt31_gthrxp_in                  =>      RXP_IN(31),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt31_rxresetdone_out            =>      gt31_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt31_gttxreset_in               =>      tied_to_ground_i,
        gt31_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt31_txdata_in                  =>      gt31_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt31_gthtxn_out                 =>      TXN_OUT(31),
        gt31_gthtxp_out                 =>      TXP_OUT(31),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt31_txoutclkfabric_out         =>      gt31_txoutclkfabric_i,
        gt31_txoutclkpcs_out            =>      gt31_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt31_txresetdone_out            =>      gt31_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt31_txpolarity_in              =>      gt31_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt31_txcharisk_in               =>      gt31_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT32  (X0Y32)

        --------------------------------- CPLL Ports -------------------------------
        gt32_cpllfbclklost_out          =>      gt32_cpllfbclklost_i,
        gt32_cplllock_out               =>      gt32_cplllock_i,
        gt32_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt32_drpaddr_in                 =>      gt32_drpaddr_i,
        gt32_drpdi_in                   =>      gt32_drpdi_i,
        gt32_drpdo_out                  =>      gt32_drpdo_i,
        gt32_drpen_in                   =>      gt32_drpen_i,
        gt32_drprdy_out                 =>      gt32_drprdy_i,
        gt32_drpwe_in                   =>      gt32_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt32_eyescanreset_in            =>      tied_to_ground_i,
        gt32_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt32_eyescandataerror_out       =>      gt32_eyescandataerror_i,
        gt32_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt32_dmonitorout_out            =>      gt32_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt32_rxdata_out                 =>      gt32_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt32_rxdisperr_out              =>      gt32_rxdisperr_i,
        gt32_rxnotintable_out           =>      gt32_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt32_gthrxn_in                  =>      RXN_IN(32),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt32_rxbyteisaligned_out        =>      gt32_rxbyteisaligned_i,
        gt32_rxmcommaalignen_in         =>      gt32_rxmcommaalignen_i,
        gt32_rxpcommaalignen_in         =>      gt32_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt32_rxmonitorout_out           =>      gt32_rxmonitorout_i,
        gt32_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt32_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt32_rxpolarity_in              =>      gt32_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt32_rxcharisk_out              =>      gt32_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt32_gthrxp_in                  =>      RXP_IN(32),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt32_rxresetdone_out            =>      gt32_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt32_gttxreset_in               =>      tied_to_ground_i,
        gt32_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt32_txdata_in                  =>      gt32_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt32_gthtxn_out                 =>      TXN_OUT(32),
        gt32_gthtxp_out                 =>      TXP_OUT(32),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt32_txoutclkfabric_out         =>      gt32_txoutclkfabric_i,
        gt32_txoutclkpcs_out            =>      gt32_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt32_txresetdone_out            =>      gt32_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt32_txpolarity_in              =>      gt32_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt32_txcharisk_in               =>      gt32_txcharisk_i,



        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT33  (X0Y33)

        --------------------------------- CPLL Ports -------------------------------
        gt33_cpllfbclklost_out          =>      gt33_cpllfbclklost_i,
        gt33_cplllock_out               =>      gt33_cplllock_i,
        gt33_cpllreset_in               =>      PLL_RESET,
        ---------------------------- Channel - DRP Ports  --------------------------
        gt33_drpaddr_in                 =>      gt33_drpaddr_i,
        gt33_drpdi_in                   =>      gt33_drpdi_i,
        gt33_drpdo_out                  =>      gt33_drpdo_i,
        gt33_drpen_in                   =>      gt33_drpen_i,
        gt33_drprdy_out                 =>      gt33_drprdy_i,
        gt33_drpwe_in                   =>      gt33_drpwe_i,
        --------------------- RX Initialization and Reset Ports --------------------
        gt33_eyescanreset_in            =>      tied_to_ground_i,
        gt33_rxuserrdy_in               =>      tied_to_ground_i,
        -------------------------- RX Margin Analysis Ports ------------------------
        gt33_eyescandataerror_out       =>      gt33_eyescandataerror_i,
        gt33_eyescantrigger_in          =>      tied_to_ground_i,
        ------------------- Receive Ports - Digital Monitor Ports ------------------
        gt33_dmonitorout_out            =>      gt33_dmonitorout_i,
        ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt33_rxdata_out                 =>      gt33_rxdata_i,
        ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt33_rxdisperr_out              =>      gt33_rxdisperr_i,
        gt33_rxnotintable_out           =>      gt33_rxnotintable_i,
        ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt33_gthrxn_in                  =>      RXN_IN(33),
        -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt33_rxbyteisaligned_out        =>      gt33_rxbyteisaligned_i,
        gt33_rxmcommaalignen_in         =>      gt33_rxmcommaalignen_i,
        gt33_rxpcommaalignen_in         =>      gt33_rxpcommaalignen_i,
        --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt33_rxmonitorout_out           =>      gt33_rxmonitorout_i,
        gt33_rxmonitorsel_in            =>      "00",
        ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt33_gtrxreset_in               =>      tied_to_ground_i,
        ----------------- Receive Ports - RX Polarity Control Ports ----------------
        gt33_rxpolarity_in              =>      gt33_rxpolarity_i,
        ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt33_rxcharisk_out              =>      gt33_rxcharisk_i,
        ------------------------ Receive Ports -RX AFE Ports -----------------------
        gt33_gthrxp_in                  =>      RXP_IN(33),
        -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt33_rxresetdone_out            =>      gt33_rxresetdone_i,
        --------------------- TX Initialization and Reset Ports --------------------
        gt33_gttxreset_in               =>      tied_to_ground_i,
        gt33_txuserrdy_in               =>      tied_to_ground_i,
        ------------------ Transmit Ports - TX Data Path interface -----------------
        gt33_txdata_in                  =>      gt33_txdata_i,
        ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt33_gthtxn_out                 =>      TXN_OUT(33),
        gt33_gthtxp_out                 =>      TXP_OUT(33),
        ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt33_txoutclkfabric_out         =>      gt33_txoutclkfabric_i,
        gt33_txoutclkpcs_out            =>      gt33_txoutclkpcs_i,
        ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt33_txresetdone_out            =>      gt33_txresetdone_i,
        ----------------- Transmit Ports - TX Polarity Control Ports ---------------
        gt33_txpolarity_in              =>      gt33_txpolarity_i,
        ----------- Transmit Transmit Ports - 8b10b Encoder Control Ports ----------
        gt33_txcharisk_in               =>      gt33_txcharisk_i,



    --____________________________COMMON PORTS________________________________
     GT0_QPLLOUTCLK_OUT  => open,
     GT0_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT1_QPLLOUTCLK_OUT  => open,
     GT1_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT2_QPLLOUTCLK_OUT  => open,
     GT2_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT3_QPLLOUTCLK_OUT  => open,
     GT3_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT4_QPLLOUTCLK_OUT  => open,
     GT4_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT5_QPLLOUTCLK_OUT  => open,
     GT5_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT6_QPLLOUTCLK_OUT  => open,
     GT6_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT7_QPLLOUTCLK_OUT  => open,
     GT7_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT8_QPLLOUTCLK_OUT  => open,
     GT8_QPLLOUTREFCLK_OUT => open,

        DRP_CLK_O => drpclk_in_i,
        DRP_CLK_I => DRP_CLK_IN
    );


    -------------------------- User Module Resets -----------------------------
    -- All the User Modules i.e. FRAME_GEN, FRAME_CHECK and the sync modules
    -- are held in reset till the RESETDONE goes high. 
    -- The RESETDONE is registered a couple of times on USRCLK2 and connected 
    -- to the reset of the modules
    
process(gt0_rxusrclk2_i,gt0_rxresetdone_i)
    begin
        if(gt0_rxresetdone_i = '0') then
            gt0_rxresetdone_r  <= '0'   after DLY;
            gt0_rxresetdone_r2 <= '0'   after DLY;
            gt0_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt0_rxusrclk2_i'event and gt0_rxusrclk2_i = '1') then
            gt0_rxresetdone_r  <= gt0_rxresetdone_i   after DLY;
            gt0_rxresetdone_r2 <= gt0_rxresetdone_r   after DLY;
            gt0_rxresetdone_r3  <= gt0_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt0_txusrclk2_i,gt0_txfsmresetdone_i)
    begin
        if(gt0_txfsmresetdone_i = '0') then
            gt0_txfsmresetdone_r  <= '0'   after DLY;
            gt0_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt0_txusrclk2_i'event and gt0_txusrclk2_i = '1') then
            gt0_txfsmresetdone_r  <= gt0_txfsmresetdone_i   after DLY;
            gt0_txfsmresetdone_r2 <= gt0_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt1_rxusrclk2_i,gt1_rxresetdone_i)
    begin
        if(gt1_rxresetdone_i = '0') then
            gt1_rxresetdone_r  <= '0'   after DLY;
            gt1_rxresetdone_r2 <= '0'   after DLY;
            gt1_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt1_rxusrclk2_i'event and gt1_rxusrclk2_i = '1') then
            gt1_rxresetdone_r  <= gt1_rxresetdone_i   after DLY;
            gt1_rxresetdone_r2 <= gt1_rxresetdone_r   after DLY;
            gt1_rxresetdone_r3  <= gt1_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt1_txusrclk2_i,gt1_txfsmresetdone_i)
    begin
        if(gt1_txfsmresetdone_i = '0') then
            gt1_txfsmresetdone_r  <= '0'   after DLY;
            gt1_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt1_txusrclk2_i'event and gt1_txusrclk2_i = '1') then
            gt1_txfsmresetdone_r  <= gt1_txfsmresetdone_i   after DLY;
            gt1_txfsmresetdone_r2 <= gt1_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt2_rxusrclk2_i,gt2_rxresetdone_i)
    begin
        if(gt2_rxresetdone_i = '0') then
            gt2_rxresetdone_r  <= '0'   after DLY;
            gt2_rxresetdone_r2 <= '0'   after DLY;
            gt2_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt2_rxusrclk2_i'event and gt2_rxusrclk2_i = '1') then
            gt2_rxresetdone_r  <= gt2_rxresetdone_i   after DLY;
            gt2_rxresetdone_r2 <= gt2_rxresetdone_r   after DLY;
            gt2_rxresetdone_r3  <= gt2_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt2_txusrclk2_i,gt2_txfsmresetdone_i)
    begin
        if(gt2_txfsmresetdone_i = '0') then
            gt2_txfsmresetdone_r  <= '0'   after DLY;
            gt2_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt2_txusrclk2_i'event and gt2_txusrclk2_i = '1') then
            gt2_txfsmresetdone_r  <= gt2_txfsmresetdone_i   after DLY;
            gt2_txfsmresetdone_r2 <= gt2_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt3_rxusrclk2_i,gt3_rxresetdone_i)
    begin
        if(gt3_rxresetdone_i = '0') then
            gt3_rxresetdone_r  <= '0'   after DLY;
            gt3_rxresetdone_r2 <= '0'   after DLY;
            gt3_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt3_rxusrclk2_i'event and gt3_rxusrclk2_i = '1') then
            gt3_rxresetdone_r  <= gt3_rxresetdone_i   after DLY;
            gt3_rxresetdone_r2 <= gt3_rxresetdone_r   after DLY;
            gt3_rxresetdone_r3  <= gt3_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt3_txusrclk2_i,gt3_txfsmresetdone_i)
    begin
        if(gt3_txfsmresetdone_i = '0') then
            gt3_txfsmresetdone_r  <= '0'   after DLY;
            gt3_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt3_txusrclk2_i'event and gt3_txusrclk2_i = '1') then
            gt3_txfsmresetdone_r  <= gt3_txfsmresetdone_i   after DLY;
            gt3_txfsmresetdone_r2 <= gt3_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt4_rxusrclk2_i,gt4_rxresetdone_i)
    begin
        if(gt4_rxresetdone_i = '0') then
            gt4_rxresetdone_r  <= '0'   after DLY;
            gt4_rxresetdone_r2 <= '0'   after DLY;
            gt4_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt4_rxusrclk2_i'event and gt4_rxusrclk2_i = '1') then
            gt4_rxresetdone_r  <= gt4_rxresetdone_i   after DLY;
            gt4_rxresetdone_r2 <= gt4_rxresetdone_r   after DLY;
            gt4_rxresetdone_r3  <= gt4_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt4_txusrclk2_i,gt4_txfsmresetdone_i)
    begin
        if(gt4_txfsmresetdone_i = '0') then
            gt4_txfsmresetdone_r  <= '0'   after DLY;
            gt4_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt4_txusrclk2_i'event and gt4_txusrclk2_i = '1') then
            gt4_txfsmresetdone_r  <= gt4_txfsmresetdone_i   after DLY;
            gt4_txfsmresetdone_r2 <= gt4_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt5_rxusrclk2_i,gt5_rxresetdone_i)
    begin
        if(gt5_rxresetdone_i = '0') then
            gt5_rxresetdone_r  <= '0'   after DLY;
            gt5_rxresetdone_r2 <= '0'   after DLY;
            gt5_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt5_rxusrclk2_i'event and gt5_rxusrclk2_i = '1') then
            gt5_rxresetdone_r  <= gt5_rxresetdone_i   after DLY;
            gt5_rxresetdone_r2 <= gt5_rxresetdone_r   after DLY;
            gt5_rxresetdone_r3  <= gt5_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt5_txusrclk2_i,gt5_txfsmresetdone_i)
    begin
        if(gt5_txfsmresetdone_i = '0') then
            gt5_txfsmresetdone_r  <= '0'   after DLY;
            gt5_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt5_txusrclk2_i'event and gt5_txusrclk2_i = '1') then
            gt5_txfsmresetdone_r  <= gt5_txfsmresetdone_i   after DLY;
            gt5_txfsmresetdone_r2 <= gt5_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt6_rxusrclk2_i,gt6_rxresetdone_i)
    begin
        if(gt6_rxresetdone_i = '0') then
            gt6_rxresetdone_r  <= '0'   after DLY;
            gt6_rxresetdone_r2 <= '0'   after DLY;
            gt6_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt6_rxusrclk2_i'event and gt6_rxusrclk2_i = '1') then
            gt6_rxresetdone_r  <= gt6_rxresetdone_i   after DLY;
            gt6_rxresetdone_r2 <= gt6_rxresetdone_r   after DLY;
            gt6_rxresetdone_r3  <= gt6_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt6_txusrclk2_i,gt6_txfsmresetdone_i)
    begin
        if(gt6_txfsmresetdone_i = '0') then
            gt6_txfsmresetdone_r  <= '0'   after DLY;
            gt6_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt6_txusrclk2_i'event and gt6_txusrclk2_i = '1') then
            gt6_txfsmresetdone_r  <= gt6_txfsmresetdone_i   after DLY;
            gt6_txfsmresetdone_r2 <= gt6_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt7_rxusrclk2_i,gt7_rxresetdone_i)
    begin
        if(gt7_rxresetdone_i = '0') then
            gt7_rxresetdone_r  <= '0'   after DLY;
            gt7_rxresetdone_r2 <= '0'   after DLY;
            gt7_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt7_rxusrclk2_i'event and gt7_rxusrclk2_i = '1') then
            gt7_rxresetdone_r  <= gt7_rxresetdone_i   after DLY;
            gt7_rxresetdone_r2 <= gt7_rxresetdone_r   after DLY;
            gt7_rxresetdone_r3  <= gt7_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt7_txusrclk2_i,gt7_txfsmresetdone_i)
    begin
        if(gt7_txfsmresetdone_i = '0') then
            gt7_txfsmresetdone_r  <= '0'   after DLY;
            gt7_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt7_txusrclk2_i'event and gt7_txusrclk2_i = '1') then
            gt7_txfsmresetdone_r  <= gt7_txfsmresetdone_i   after DLY;
            gt7_txfsmresetdone_r2 <= gt7_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt8_rxusrclk2_i,gt8_rxresetdone_i)
    begin
        if(gt8_rxresetdone_i = '0') then
            gt8_rxresetdone_r  <= '0'   after DLY;
            gt8_rxresetdone_r2 <= '0'   after DLY;
            gt8_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt8_rxusrclk2_i'event and gt8_rxusrclk2_i = '1') then
            gt8_rxresetdone_r  <= gt8_rxresetdone_i   after DLY;
            gt8_rxresetdone_r2 <= gt8_rxresetdone_r   after DLY;
            gt8_rxresetdone_r3  <= gt8_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt8_txusrclk2_i,gt8_txfsmresetdone_i)
    begin
        if(gt8_txfsmresetdone_i = '0') then
            gt8_txfsmresetdone_r  <= '0'   after DLY;
            gt8_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt8_txusrclk2_i'event and gt8_txusrclk2_i = '1') then
            gt8_txfsmresetdone_r  <= gt8_txfsmresetdone_i   after DLY;
            gt8_txfsmresetdone_r2 <= gt8_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt9_rxusrclk2_i,gt9_rxresetdone_i)
    begin
        if(gt9_rxresetdone_i = '0') then
            gt9_rxresetdone_r  <= '0'   after DLY;
            gt9_rxresetdone_r2 <= '0'   after DLY;
            gt9_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt9_rxusrclk2_i'event and gt9_rxusrclk2_i = '1') then
            gt9_rxresetdone_r  <= gt9_rxresetdone_i   after DLY;
            gt9_rxresetdone_r2 <= gt9_rxresetdone_r   after DLY;
            gt9_rxresetdone_r3  <= gt9_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt9_txusrclk2_i,gt9_txfsmresetdone_i)
    begin
        if(gt9_txfsmresetdone_i = '0') then
            gt9_txfsmresetdone_r  <= '0'   after DLY;
            gt9_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt9_txusrclk2_i'event and gt9_txusrclk2_i = '1') then
            gt9_txfsmresetdone_r  <= gt9_txfsmresetdone_i   after DLY;
            gt9_txfsmresetdone_r2 <= gt9_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt10_rxusrclk2_i,gt10_rxresetdone_i)
    begin
        if(gt10_rxresetdone_i = '0') then
            gt10_rxresetdone_r  <= '0'   after DLY;
            gt10_rxresetdone_r2 <= '0'   after DLY;
            gt10_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt10_rxusrclk2_i'event and gt10_rxusrclk2_i = '1') then
            gt10_rxresetdone_r  <= gt10_rxresetdone_i   after DLY;
            gt10_rxresetdone_r2 <= gt10_rxresetdone_r   after DLY;
            gt10_rxresetdone_r3  <= gt10_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt10_txusrclk2_i,gt10_txfsmresetdone_i)
    begin
        if(gt10_txfsmresetdone_i = '0') then
            gt10_txfsmresetdone_r  <= '0'   after DLY;
            gt10_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt10_txusrclk2_i'event and gt10_txusrclk2_i = '1') then
            gt10_txfsmresetdone_r  <= gt10_txfsmresetdone_i   after DLY;
            gt10_txfsmresetdone_r2 <= gt10_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt11_rxusrclk2_i,gt11_rxresetdone_i)
    begin
        if(gt11_rxresetdone_i = '0') then
            gt11_rxresetdone_r  <= '0'   after DLY;
            gt11_rxresetdone_r2 <= '0'   after DLY;
            gt11_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt11_rxusrclk2_i'event and gt11_rxusrclk2_i = '1') then
            gt11_rxresetdone_r  <= gt11_rxresetdone_i   after DLY;
            gt11_rxresetdone_r2 <= gt11_rxresetdone_r   after DLY;
            gt11_rxresetdone_r3  <= gt11_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt11_txusrclk2_i,gt11_txfsmresetdone_i)
    begin
        if(gt11_txfsmresetdone_i = '0') then
            gt11_txfsmresetdone_r  <= '0'   after DLY;
            gt11_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt11_txusrclk2_i'event and gt11_txusrclk2_i = '1') then
            gt11_txfsmresetdone_r  <= gt11_txfsmresetdone_i   after DLY;
            gt11_txfsmresetdone_r2 <= gt11_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt12_rxusrclk2_i,gt12_rxresetdone_i)
    begin
        if(gt12_rxresetdone_i = '0') then
            gt12_rxresetdone_r  <= '0'   after DLY;
            gt12_rxresetdone_r2 <= '0'   after DLY;
            gt12_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt12_rxusrclk2_i'event and gt12_rxusrclk2_i = '1') then
            gt12_rxresetdone_r  <= gt12_rxresetdone_i   after DLY;
            gt12_rxresetdone_r2 <= gt12_rxresetdone_r   after DLY;
            gt12_rxresetdone_r3  <= gt12_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt12_txusrclk2_i,gt12_txfsmresetdone_i)
    begin
        if(gt12_txfsmresetdone_i = '0') then
            gt12_txfsmresetdone_r  <= '0'   after DLY;
            gt12_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt12_txusrclk2_i'event and gt12_txusrclk2_i = '1') then
            gt12_txfsmresetdone_r  <= gt12_txfsmresetdone_i   after DLY;
            gt12_txfsmresetdone_r2 <= gt12_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt13_rxusrclk2_i,gt13_rxresetdone_i)
    begin
        if(gt13_rxresetdone_i = '0') then
            gt13_rxresetdone_r  <= '0'   after DLY;
            gt13_rxresetdone_r2 <= '0'   after DLY;
            gt13_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt13_rxusrclk2_i'event and gt13_rxusrclk2_i = '1') then
            gt13_rxresetdone_r  <= gt13_rxresetdone_i   after DLY;
            gt13_rxresetdone_r2 <= gt13_rxresetdone_r   after DLY;
            gt13_rxresetdone_r3  <= gt13_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt13_txusrclk2_i,gt13_txfsmresetdone_i)
    begin
        if(gt13_txfsmresetdone_i = '0') then
            gt13_txfsmresetdone_r  <= '0'   after DLY;
            gt13_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt13_txusrclk2_i'event and gt13_txusrclk2_i = '1') then
            gt13_txfsmresetdone_r  <= gt13_txfsmresetdone_i   after DLY;
            gt13_txfsmresetdone_r2 <= gt13_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt14_rxusrclk2_i,gt14_rxresetdone_i)
    begin
        if(gt14_rxresetdone_i = '0') then
            gt14_rxresetdone_r  <= '0'   after DLY;
            gt14_rxresetdone_r2 <= '0'   after DLY;
            gt14_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt14_rxusrclk2_i'event and gt14_rxusrclk2_i = '1') then
            gt14_rxresetdone_r  <= gt14_rxresetdone_i   after DLY;
            gt14_rxresetdone_r2 <= gt14_rxresetdone_r   after DLY;
            gt14_rxresetdone_r3  <= gt14_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt14_txusrclk2_i,gt14_txfsmresetdone_i)
    begin
        if(gt14_txfsmresetdone_i = '0') then
            gt14_txfsmresetdone_r  <= '0'   after DLY;
            gt14_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt14_txusrclk2_i'event and gt14_txusrclk2_i = '1') then
            gt14_txfsmresetdone_r  <= gt14_txfsmresetdone_i   after DLY;
            gt14_txfsmresetdone_r2 <= gt14_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt15_rxusrclk2_i,gt15_rxresetdone_i)
    begin
        if(gt15_rxresetdone_i = '0') then
            gt15_rxresetdone_r  <= '0'   after DLY;
            gt15_rxresetdone_r2 <= '0'   after DLY;
            gt15_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt15_rxusrclk2_i'event and gt15_rxusrclk2_i = '1') then
            gt15_rxresetdone_r  <= gt15_rxresetdone_i   after DLY;
            gt15_rxresetdone_r2 <= gt15_rxresetdone_r   after DLY;
            gt15_rxresetdone_r3  <= gt15_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt15_txusrclk2_i,gt15_txfsmresetdone_i)
    begin
        if(gt15_txfsmresetdone_i = '0') then
            gt15_txfsmresetdone_r  <= '0'   after DLY;
            gt15_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt15_txusrclk2_i'event and gt15_txusrclk2_i = '1') then
            gt15_txfsmresetdone_r  <= gt15_txfsmresetdone_i   after DLY;
            gt15_txfsmresetdone_r2 <= gt15_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt16_rxusrclk2_i,gt16_rxresetdone_i)
    begin
        if(gt16_rxresetdone_i = '0') then
            gt16_rxresetdone_r  <= '0'   after DLY;
            gt16_rxresetdone_r2 <= '0'   after DLY;
            gt16_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt16_rxusrclk2_i'event and gt16_rxusrclk2_i = '1') then
            gt16_rxresetdone_r  <= gt16_rxresetdone_i   after DLY;
            gt16_rxresetdone_r2 <= gt16_rxresetdone_r   after DLY;
            gt16_rxresetdone_r3  <= gt16_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt16_txusrclk2_i,gt16_txfsmresetdone_i)
    begin
        if(gt16_txfsmresetdone_i = '0') then
            gt16_txfsmresetdone_r  <= '0'   after DLY;
            gt16_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt16_txusrclk2_i'event and gt16_txusrclk2_i = '1') then
            gt16_txfsmresetdone_r  <= gt16_txfsmresetdone_i   after DLY;
            gt16_txfsmresetdone_r2 <= gt16_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt17_rxusrclk2_i,gt17_rxresetdone_i)
    begin
        if(gt17_rxresetdone_i = '0') then
            gt17_rxresetdone_r  <= '0'   after DLY;
            gt17_rxresetdone_r2 <= '0'   after DLY;
            gt17_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt17_rxusrclk2_i'event and gt17_rxusrclk2_i = '1') then
            gt17_rxresetdone_r  <= gt17_rxresetdone_i   after DLY;
            gt17_rxresetdone_r2 <= gt17_rxresetdone_r   after DLY;
            gt17_rxresetdone_r3  <= gt17_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt17_txusrclk2_i,gt17_txfsmresetdone_i)
    begin
        if(gt17_txfsmresetdone_i = '0') then
            gt17_txfsmresetdone_r  <= '0'   after DLY;
            gt17_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt17_txusrclk2_i'event and gt17_txusrclk2_i = '1') then
            gt17_txfsmresetdone_r  <= gt17_txfsmresetdone_i   after DLY;
            gt17_txfsmresetdone_r2 <= gt17_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt18_rxusrclk2_i,gt18_rxresetdone_i)
    begin
        if(gt18_rxresetdone_i = '0') then
            gt18_rxresetdone_r  <= '0'   after DLY;
            gt18_rxresetdone_r2 <= '0'   after DLY;
            gt18_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt18_rxusrclk2_i'event and gt18_rxusrclk2_i = '1') then
            gt18_rxresetdone_r  <= gt18_rxresetdone_i   after DLY;
            gt18_rxresetdone_r2 <= gt18_rxresetdone_r   after DLY;
            gt18_rxresetdone_r3  <= gt18_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt18_txusrclk2_i,gt18_txfsmresetdone_i)
    begin
        if(gt18_txfsmresetdone_i = '0') then
            gt18_txfsmresetdone_r  <= '0'   after DLY;
            gt18_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt18_txusrclk2_i'event and gt18_txusrclk2_i = '1') then
            gt18_txfsmresetdone_r  <= gt18_txfsmresetdone_i   after DLY;
            gt18_txfsmresetdone_r2 <= gt18_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt19_rxusrclk2_i,gt19_rxresetdone_i)
    begin
        if(gt19_rxresetdone_i = '0') then
            gt19_rxresetdone_r  <= '0'   after DLY;
            gt19_rxresetdone_r2 <= '0'   after DLY;
            gt19_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt19_rxusrclk2_i'event and gt19_rxusrclk2_i = '1') then
            gt19_rxresetdone_r  <= gt19_rxresetdone_i   after DLY;
            gt19_rxresetdone_r2 <= gt19_rxresetdone_r   after DLY;
            gt19_rxresetdone_r3  <= gt19_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt19_txusrclk2_i,gt19_txfsmresetdone_i)
    begin
        if(gt19_txfsmresetdone_i = '0') then
            gt19_txfsmresetdone_r  <= '0'   after DLY;
            gt19_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt19_txusrclk2_i'event and gt19_txusrclk2_i = '1') then
            gt19_txfsmresetdone_r  <= gt19_txfsmresetdone_i   after DLY;
            gt19_txfsmresetdone_r2 <= gt19_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt20_rxusrclk2_i,gt20_rxresetdone_i)
    begin
        if(gt20_rxresetdone_i = '0') then
            gt20_rxresetdone_r  <= '0'   after DLY;
            gt20_rxresetdone_r2 <= '0'   after DLY;
            gt20_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt20_rxusrclk2_i'event and gt20_rxusrclk2_i = '1') then
            gt20_rxresetdone_r  <= gt20_rxresetdone_i   after DLY;
            gt20_rxresetdone_r2 <= gt20_rxresetdone_r   after DLY;
            gt20_rxresetdone_r3  <= gt20_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt20_txusrclk2_i,gt20_txfsmresetdone_i)
    begin
        if(gt20_txfsmresetdone_i = '0') then
            gt20_txfsmresetdone_r  <= '0'   after DLY;
            gt20_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt20_txusrclk2_i'event and gt20_txusrclk2_i = '1') then
            gt20_txfsmresetdone_r  <= gt20_txfsmresetdone_i   after DLY;
            gt20_txfsmresetdone_r2 <= gt20_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt21_rxusrclk2_i,gt21_rxresetdone_i)
    begin
        if(gt21_rxresetdone_i = '0') then
            gt21_rxresetdone_r  <= '0'   after DLY;
            gt21_rxresetdone_r2 <= '0'   after DLY;
            gt21_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt21_rxusrclk2_i'event and gt21_rxusrclk2_i = '1') then
            gt21_rxresetdone_r  <= gt21_rxresetdone_i   after DLY;
            gt21_rxresetdone_r2 <= gt21_rxresetdone_r   after DLY;
            gt21_rxresetdone_r3  <= gt21_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt21_txusrclk2_i,gt21_txfsmresetdone_i)
    begin
        if(gt21_txfsmresetdone_i = '0') then
            gt21_txfsmresetdone_r  <= '0'   after DLY;
            gt21_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt21_txusrclk2_i'event and gt21_txusrclk2_i = '1') then
            gt21_txfsmresetdone_r  <= gt21_txfsmresetdone_i   after DLY;
            gt21_txfsmresetdone_r2 <= gt21_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt22_rxusrclk2_i,gt22_rxresetdone_i)
    begin
        if(gt22_rxresetdone_i = '0') then
            gt22_rxresetdone_r  <= '0'   after DLY;
            gt22_rxresetdone_r2 <= '0'   after DLY;
            gt22_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt22_rxusrclk2_i'event and gt22_rxusrclk2_i = '1') then
            gt22_rxresetdone_r  <= gt22_rxresetdone_i   after DLY;
            gt22_rxresetdone_r2 <= gt22_rxresetdone_r   after DLY;
            gt22_rxresetdone_r3  <= gt22_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt22_txusrclk2_i,gt22_txfsmresetdone_i)
    begin
        if(gt22_txfsmresetdone_i = '0') then
            gt22_txfsmresetdone_r  <= '0'   after DLY;
            gt22_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt22_txusrclk2_i'event and gt22_txusrclk2_i = '1') then
            gt22_txfsmresetdone_r  <= gt22_txfsmresetdone_i   after DLY;
            gt22_txfsmresetdone_r2 <= gt22_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt23_rxusrclk2_i,gt23_rxresetdone_i)
    begin
        if(gt23_rxresetdone_i = '0') then
            gt23_rxresetdone_r  <= '0'   after DLY;
            gt23_rxresetdone_r2 <= '0'   after DLY;
            gt23_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt23_rxusrclk2_i'event and gt23_rxusrclk2_i = '1') then
            gt23_rxresetdone_r  <= gt23_rxresetdone_i   after DLY;
            gt23_rxresetdone_r2 <= gt23_rxresetdone_r   after DLY;
            gt23_rxresetdone_r3  <= gt23_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt23_txusrclk2_i,gt23_txfsmresetdone_i)
    begin
        if(gt23_txfsmresetdone_i = '0') then
            gt23_txfsmresetdone_r  <= '0'   after DLY;
            gt23_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt23_txusrclk2_i'event and gt23_txusrclk2_i = '1') then
            gt23_txfsmresetdone_r  <= gt23_txfsmresetdone_i   after DLY;
            gt23_txfsmresetdone_r2 <= gt23_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt24_rxusrclk2_i,gt24_rxresetdone_i)
    begin
        if(gt24_rxresetdone_i = '0') then
            gt24_rxresetdone_r  <= '0'   after DLY;
            gt24_rxresetdone_r2 <= '0'   after DLY;
            gt24_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt24_rxusrclk2_i'event and gt24_rxusrclk2_i = '1') then
            gt24_rxresetdone_r  <= gt24_rxresetdone_i   after DLY;
            gt24_rxresetdone_r2 <= gt24_rxresetdone_r   after DLY;
            gt24_rxresetdone_r3  <= gt24_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt24_txusrclk2_i,gt24_txfsmresetdone_i)
    begin
        if(gt24_txfsmresetdone_i = '0') then
            gt24_txfsmresetdone_r  <= '0'   after DLY;
            gt24_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt24_txusrclk2_i'event and gt24_txusrclk2_i = '1') then
            gt24_txfsmresetdone_r  <= gt24_txfsmresetdone_i   after DLY;
            gt24_txfsmresetdone_r2 <= gt24_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt25_rxusrclk2_i,gt25_rxresetdone_i)
    begin
        if(gt25_rxresetdone_i = '0') then
            gt25_rxresetdone_r  <= '0'   after DLY;
            gt25_rxresetdone_r2 <= '0'   after DLY;
            gt25_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt25_rxusrclk2_i'event and gt25_rxusrclk2_i = '1') then
            gt25_rxresetdone_r  <= gt25_rxresetdone_i   after DLY;
            gt25_rxresetdone_r2 <= gt25_rxresetdone_r   after DLY;
            gt25_rxresetdone_r3  <= gt25_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt25_txusrclk2_i,gt25_txfsmresetdone_i)
    begin
        if(gt25_txfsmresetdone_i = '0') then
            gt25_txfsmresetdone_r  <= '0'   after DLY;
            gt25_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt25_txusrclk2_i'event and gt25_txusrclk2_i = '1') then
            gt25_txfsmresetdone_r  <= gt25_txfsmresetdone_i   after DLY;
            gt25_txfsmresetdone_r2 <= gt25_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt26_rxusrclk2_i,gt26_rxresetdone_i)
    begin
        if(gt26_rxresetdone_i = '0') then
            gt26_rxresetdone_r  <= '0'   after DLY;
            gt26_rxresetdone_r2 <= '0'   after DLY;
            gt26_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt26_rxusrclk2_i'event and gt26_rxusrclk2_i = '1') then
            gt26_rxresetdone_r  <= gt26_rxresetdone_i   after DLY;
            gt26_rxresetdone_r2 <= gt26_rxresetdone_r   after DLY;
            gt26_rxresetdone_r3  <= gt26_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt26_txusrclk2_i,gt26_txfsmresetdone_i)
    begin
        if(gt26_txfsmresetdone_i = '0') then
            gt26_txfsmresetdone_r  <= '0'   after DLY;
            gt26_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt26_txusrclk2_i'event and gt26_txusrclk2_i = '1') then
            gt26_txfsmresetdone_r  <= gt26_txfsmresetdone_i   after DLY;
            gt26_txfsmresetdone_r2 <= gt26_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt27_rxusrclk2_i,gt27_rxresetdone_i)
    begin
        if(gt27_rxresetdone_i = '0') then
            gt27_rxresetdone_r  <= '0'   after DLY;
            gt27_rxresetdone_r2 <= '0'   after DLY;
            gt27_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt27_rxusrclk2_i'event and gt27_rxusrclk2_i = '1') then
            gt27_rxresetdone_r  <= gt27_rxresetdone_i   after DLY;
            gt27_rxresetdone_r2 <= gt27_rxresetdone_r   after DLY;
            gt27_rxresetdone_r3  <= gt27_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt27_txusrclk2_i,gt27_txfsmresetdone_i)
    begin
        if(gt27_txfsmresetdone_i = '0') then
            gt27_txfsmresetdone_r  <= '0'   after DLY;
            gt27_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt27_txusrclk2_i'event and gt27_txusrclk2_i = '1') then
            gt27_txfsmresetdone_r  <= gt27_txfsmresetdone_i   after DLY;
            gt27_txfsmresetdone_r2 <= gt27_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt28_rxusrclk2_i,gt28_rxresetdone_i)
    begin
        if(gt28_rxresetdone_i = '0') then
            gt28_rxresetdone_r  <= '0'   after DLY;
            gt28_rxresetdone_r2 <= '0'   after DLY;
            gt28_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt28_rxusrclk2_i'event and gt28_rxusrclk2_i = '1') then
            gt28_rxresetdone_r  <= gt28_rxresetdone_i   after DLY;
            gt28_rxresetdone_r2 <= gt28_rxresetdone_r   after DLY;
            gt28_rxresetdone_r3  <= gt28_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt28_txusrclk2_i,gt28_txfsmresetdone_i)
    begin
        if(gt28_txfsmresetdone_i = '0') then
            gt28_txfsmresetdone_r  <= '0'   after DLY;
            gt28_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt28_txusrclk2_i'event and gt28_txusrclk2_i = '1') then
            gt28_txfsmresetdone_r  <= gt28_txfsmresetdone_i   after DLY;
            gt28_txfsmresetdone_r2 <= gt28_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt29_rxusrclk2_i,gt29_rxresetdone_i)
    begin
        if(gt29_rxresetdone_i = '0') then
            gt29_rxresetdone_r  <= '0'   after DLY;
            gt29_rxresetdone_r2 <= '0'   after DLY;
            gt29_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt29_rxusrclk2_i'event and gt29_rxusrclk2_i = '1') then
            gt29_rxresetdone_r  <= gt29_rxresetdone_i   after DLY;
            gt29_rxresetdone_r2 <= gt29_rxresetdone_r   after DLY;
            gt29_rxresetdone_r3  <= gt29_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt29_txusrclk2_i,gt29_txfsmresetdone_i)
    begin
        if(gt29_txfsmresetdone_i = '0') then
            gt29_txfsmresetdone_r  <= '0'   after DLY;
            gt29_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt29_txusrclk2_i'event and gt29_txusrclk2_i = '1') then
            gt29_txfsmresetdone_r  <= gt29_txfsmresetdone_i   after DLY;
            gt29_txfsmresetdone_r2 <= gt29_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt30_rxusrclk2_i,gt30_rxresetdone_i)
    begin
        if(gt30_rxresetdone_i = '0') then
            gt30_rxresetdone_r  <= '0'   after DLY;
            gt30_rxresetdone_r2 <= '0'   after DLY;
            gt30_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt30_rxusrclk2_i'event and gt30_rxusrclk2_i = '1') then
            gt30_rxresetdone_r  <= gt30_rxresetdone_i   after DLY;
            gt30_rxresetdone_r2 <= gt30_rxresetdone_r   after DLY;
            gt30_rxresetdone_r3  <= gt30_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt30_txusrclk2_i,gt30_txfsmresetdone_i)
    begin
        if(gt30_txfsmresetdone_i = '0') then
            gt30_txfsmresetdone_r  <= '0'   after DLY;
            gt30_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt30_txusrclk2_i'event and gt30_txusrclk2_i = '1') then
            gt30_txfsmresetdone_r  <= gt30_txfsmresetdone_i   after DLY;
            gt30_txfsmresetdone_r2 <= gt30_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt31_rxusrclk2_i,gt31_rxresetdone_i)
    begin
        if(gt31_rxresetdone_i = '0') then
            gt31_rxresetdone_r  <= '0'   after DLY;
            gt31_rxresetdone_r2 <= '0'   after DLY;
            gt31_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt31_rxusrclk2_i'event and gt31_rxusrclk2_i = '1') then
            gt31_rxresetdone_r  <= gt31_rxresetdone_i   after DLY;
            gt31_rxresetdone_r2 <= gt31_rxresetdone_r   after DLY;
            gt31_rxresetdone_r3  <= gt31_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt31_txusrclk2_i,gt31_txfsmresetdone_i)
    begin
        if(gt31_txfsmresetdone_i = '0') then
            gt31_txfsmresetdone_r  <= '0'   after DLY;
            gt31_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt31_txusrclk2_i'event and gt31_txusrclk2_i = '1') then
            gt31_txfsmresetdone_r  <= gt31_txfsmresetdone_i   after DLY;
            gt31_txfsmresetdone_r2 <= gt31_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt32_rxusrclk2_i,gt32_rxresetdone_i)
    begin
        if(gt32_rxresetdone_i = '0') then
            gt32_rxresetdone_r  <= '0'   after DLY;
            gt32_rxresetdone_r2 <= '0'   after DLY;
            gt32_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt32_rxusrclk2_i'event and gt32_rxusrclk2_i = '1') then
            gt32_rxresetdone_r  <= gt32_rxresetdone_i   after DLY;
            gt32_rxresetdone_r2 <= gt32_rxresetdone_r   after DLY;
            gt32_rxresetdone_r3  <= gt32_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt32_txusrclk2_i,gt32_txfsmresetdone_i)
    begin
        if(gt32_txfsmresetdone_i = '0') then
            gt32_txfsmresetdone_r  <= '0'   after DLY;
            gt32_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt32_txusrclk2_i'event and gt32_txusrclk2_i = '1') then
            gt32_txfsmresetdone_r  <= gt32_txfsmresetdone_i   after DLY;
            gt32_txfsmresetdone_r2 <= gt32_txfsmresetdone_r   after DLY;
        end if;
    end process;
process(gt33_rxusrclk2_i,gt33_rxresetdone_i)
    begin
        if(gt33_rxresetdone_i = '0') then
            gt33_rxresetdone_r  <= '0'   after DLY;
            gt33_rxresetdone_r2 <= '0'   after DLY;
            gt33_rxresetdone_r3 <= '0'   after DLY;
        elsif(gt33_rxusrclk2_i'event and gt33_rxusrclk2_i = '1') then
            gt33_rxresetdone_r  <= gt33_rxresetdone_i   after DLY;
            gt33_rxresetdone_r2 <= gt33_rxresetdone_r   after DLY;
            gt33_rxresetdone_r3  <= gt33_rxresetdone_r2   after DLY;
        end if;
    end process;


    process(gt33_txusrclk2_i,gt33_txfsmresetdone_i)
    begin
        if(gt33_txfsmresetdone_i = '0') then
            gt33_txfsmresetdone_r  <= '0'   after DLY;
            gt33_txfsmresetdone_r2 <= '0'   after DLY;
        elsif(gt33_txusrclk2_i'event and gt33_txusrclk2_i = '1') then
            gt33_txfsmresetdone_r  <= gt33_txfsmresetdone_i   after DLY;
            gt33_txfsmresetdone_r2 <= gt33_txfsmresetdone_r   after DLY;
        end if;
    end process;
-------------------------------------------------------------------------------
----------------------------- Debug Signals assignment -----------------------

------------------------------------------------------ 


gt0_drpaddr_i <= (others => '0');
gt0_drpdi_i <= (others => '0');
gt0_drpen_i <= '0';
gt0_drpwe_i <= '0';
gt1_drpaddr_i <= (others => '0');
gt1_drpdi_i <= (others => '0');
gt1_drpen_i <= '0';
gt1_drpwe_i <= '0';
gt2_drpaddr_i <= (others => '0');
gt2_drpdi_i <= (others => '0');
gt2_drpen_i <= '0';
gt2_drpwe_i <= '0';
gt3_drpaddr_i <= (others => '0');
gt3_drpdi_i <= (others => '0');
gt3_drpen_i <= '0';
gt3_drpwe_i <= '0';
gt4_drpaddr_i <= (others => '0');
gt4_drpdi_i <= (others => '0');
gt4_drpen_i <= '0';
gt4_drpwe_i <= '0';
gt5_drpaddr_i <= (others => '0');
gt5_drpdi_i <= (others => '0');
gt5_drpen_i <= '0';
gt5_drpwe_i <= '0';
gt6_drpaddr_i <= (others => '0');
gt6_drpdi_i <= (others => '0');
gt6_drpen_i <= '0';
gt6_drpwe_i <= '0';
gt7_drpaddr_i <= (others => '0');
gt7_drpdi_i <= (others => '0');
gt7_drpen_i <= '0';
gt7_drpwe_i <= '0';
gt8_drpaddr_i <= (others => '0');
gt8_drpdi_i <= (others => '0');
gt8_drpen_i <= '0';
gt8_drpwe_i <= '0';
gt9_drpaddr_i <= (others => '0');
gt9_drpdi_i <= (others => '0');
gt9_drpen_i <= '0';
gt9_drpwe_i <= '0';
gt10_drpaddr_i <= (others => '0');
gt10_drpdi_i <= (others => '0');
gt10_drpen_i <= '0';
gt10_drpwe_i <= '0';
gt11_drpaddr_i <= (others => '0');
gt11_drpdi_i <= (others => '0');
gt11_drpen_i <= '0';
gt11_drpwe_i <= '0';
gt12_drpaddr_i <= (others => '0');
gt12_drpdi_i <= (others => '0');
gt12_drpen_i <= '0';
gt12_drpwe_i <= '0';
gt13_drpaddr_i <= (others => '0');
gt13_drpdi_i <= (others => '0');
gt13_drpen_i <= '0';
gt13_drpwe_i <= '0';
gt14_drpaddr_i <= (others => '0');
gt14_drpdi_i <= (others => '0');
gt14_drpen_i <= '0';
gt14_drpwe_i <= '0';
gt15_drpaddr_i <= (others => '0');
gt15_drpdi_i <= (others => '0');
gt15_drpen_i <= '0';
gt15_drpwe_i <= '0';
gt16_drpaddr_i <= (others => '0');
gt16_drpdi_i <= (others => '0');
gt16_drpen_i <= '0';
gt16_drpwe_i <= '0';
gt17_drpaddr_i <= (others => '0');
gt17_drpdi_i <= (others => '0');
gt17_drpen_i <= '0';
gt17_drpwe_i <= '0';
gt18_drpaddr_i <= (others => '0');
gt18_drpdi_i <= (others => '0');
gt18_drpen_i <= '0';
gt18_drpwe_i <= '0';
gt19_drpaddr_i <= (others => '0');
gt19_drpdi_i <= (others => '0');
gt19_drpen_i <= '0';
gt19_drpwe_i <= '0';
gt20_drpaddr_i <= (others => '0');
gt20_drpdi_i <= (others => '0');
gt20_drpen_i <= '0';
gt20_drpwe_i <= '0';
gt21_drpaddr_i <= (others => '0');
gt21_drpdi_i <= (others => '0');
gt21_drpen_i <= '0';
gt21_drpwe_i <= '0';
gt22_drpaddr_i <= (others => '0');
gt22_drpdi_i <= (others => '0');
gt22_drpen_i <= '0';
gt22_drpwe_i <= '0';
gt23_drpaddr_i <= (others => '0');
gt23_drpdi_i <= (others => '0');
gt23_drpen_i <= '0';
gt23_drpwe_i <= '0';
gt24_drpaddr_i <= (others => '0');
gt24_drpdi_i <= (others => '0');
gt24_drpen_i <= '0';
gt24_drpwe_i <= '0';
gt25_drpaddr_i <= (others => '0');
gt25_drpdi_i <= (others => '0');
gt25_drpen_i <= '0';
gt25_drpwe_i <= '0';
gt26_drpaddr_i <= (others => '0');
gt26_drpdi_i <= (others => '0');
gt26_drpen_i <= '0';
gt26_drpwe_i <= '0';
gt27_drpaddr_i <= (others => '0');
gt27_drpdi_i <= (others => '0');
gt27_drpen_i <= '0';
gt27_drpwe_i <= '0';
gt28_drpaddr_i <= (others => '0');
gt28_drpdi_i <= (others => '0');
gt28_drpen_i <= '0';
gt28_drpwe_i <= '0';
gt29_drpaddr_i <= (others => '0');
gt29_drpdi_i <= (others => '0');
gt29_drpen_i <= '0';
gt29_drpwe_i <= '0';
gt30_drpaddr_i <= (others => '0');
gt30_drpdi_i <= (others => '0');
gt30_drpen_i <= '0';
gt30_drpwe_i <= '0';
gt31_drpaddr_i <= (others => '0');
gt31_drpdi_i <= (others => '0');
gt31_drpen_i <= '0';
gt31_drpwe_i <= '0';
gt32_drpaddr_i <= (others => '0');
gt32_drpdi_i <= (others => '0');
gt32_drpen_i <= '0';
gt32_drpwe_i <= '0';
gt33_drpaddr_i <= (others => '0');
gt33_drpdi_i <= (others => '0');
gt33_drpen_i <= '0';
gt33_drpwe_i <= '0';


end RTL;


