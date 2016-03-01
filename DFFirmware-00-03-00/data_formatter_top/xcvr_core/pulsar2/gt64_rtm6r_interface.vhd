------------------------------------------------------------------------------
-- modification
-- (0) modify the name from gt64_rtm6r_exdes -> gt_rtm6r_interface
-- (1)  remove signals in "----------------------- Frame check/gen Module Signals --------------------"
--      until track_data_out_ila_i
-- (2)  remove modules in "------------------------------ Frame Generators ---------------------------"
-- (3)  remove modules in "---------------------------------- Frame Checkers -------------------------"
--      until             "----------------------------- Debug Signals assignment -----------------------"
-- (4)  remove component vio_0 / component ila_0 / component ila_1 / component
-- (5)  remove signals _vio_ 
-- (6)  remove signals _lia
-- (7)  remove soft_reset_i instead add "TRANSCEIVER_RESET : in std_logic;"
--      and connect to soft_reset_in port
-- (9)  modify
--    DRP_CLK_IN_P / DRP_CLK_IN_N into DRP_CLK_IN
--    gt64_rtm6r/gt64_rtm6r_example/gt64_rtm6r_example.srcs/sources_1/imports/example_design/support/gt64_rtm6r_support.vhd SYSCLK_IN_P / SYSCLK_IN_N into DRP_CLK_I
--    gt64_rtm6r/gt64_rtm6r_example/gt64_rtm6r_example.srcs/sources_1/imports/example_design/support/gt64_rtm6r_gt_usrclk_source.vhd DRPCLK_IN_P / DRPCLK_IN_P into DRPCLK_IN
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
-- (18) add user clock out <NOTE ASSIGN > 
-- GT_TXUSERCLK_OUT(0) <= gt0_txusrclk2_i;
-- GT_RXUSERCLK_OUT(0) <= gt0_rxusrclk2_i;
-- GT_TXUSERCLK_OUT(1) <= gt1_txusrclk2_i;
-- GT_RXUSERCLK_OUT(1) <= gt1_rxusrclk2_i;
-- (19) remove
--      gt0_rxpolarity_i                             <= tied_to_ground_i;
--      gt0_txpolarity_i                             <= tied_to_ground_i;
-- (20) connect PLL_RESET to CPLL or QPLL reset <cpllreset>
-- e.g. cpllreset_in                =>      tied_to_ground_i, -> cpllreset_in  =>  PLL_RESET
-- (21) signal gt_qpll_lock_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0) := (others => '0');
--      gt_qpll_lock_i(0) <= gt0_qplllock_i;
--      gt_qpll_lock_i(1) <= gt0_qplllock_i;
--      gt_qpll_lock_i(2) <= gt0_qplllock_i;
--      gt_qpll_lock_i(3) <= gt0_qplllock_i;
--      gt_qpll_lock_i(4) <= gt1_qplllock_i;
--      gt_qpll_lock_i(5) <= gt1_qplllock_i;
-- (22) gt64_rtm6r/gt64_rtm6r_gt.vhd modify the transceiver parameters
--      RX_CM_TRIM                              =>     ("1101"),--RX_CM_TRIM=950mVR
--      TXDIFFCTRL                      =>      "0011", --V_PPD=0.407
-- (23) Reference Clock
--      Q0_CLK0_GTREFCLK_PAD_N_IN => GTREFCLK0_N_IN,
--      Q0_CLK0_GTREFCLK_PAD_P_IN => GTREFCLK0_P_IN,

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

use work.data_formatter_constants.all;

--***********************************Entity Declaration************************

entity gt_rtm6r_interface is
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

      PLL_RESET         : in std_logic := '0';
      TRANSCEIVER_RESET : in std_logic;
      DRP_CLK_IN        : in std_logic;
      POWER_ON_RESET_REQ_LINK : out std_logic;
      
      GT_TXUSERCLK_OUT    : out std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      GT_RXUSERCLK_OUT    : out std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      GT_TX_DATA_IN     : in  DF_GTDATA_LANES_RTM_R_ARRAY;
      GT_TX_CHARISK_IN  : in  DF_GTCHARISK_LANES_RTM_R_ARRAY;
      GT_RX_DATA_OUT    : out DF_GTDATA_LANES_RTM_R_ARRAY;
      GT_RX_CHARISK_OUT : out DF_GTCHARISK_LANES_RTM_R_ARRAY;      
      GT_RXBYTEISALIGNED_OUT : out std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      GT_RXENCOMMAALIGN_IN  : in  std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      GT_RXPOLARITY_IN      : in  std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      GT_TXPOLARITY_IN      : in  std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      GT_TX_RESET_DONE_OUT   : out std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      GT_RX_RESET_DONE_OUT   : out std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      GT_PLL_LOCK_OUT        : out std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);     
      
      RXN_IN  : in   std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      RXP_IN  : in   std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      TXN_OUT : out  std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
      TXP_OUT : out  std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0)    
      );

end gt_rtm6r_interface;
    
architecture RTL of gt_rtm6r_interface is
    attribute DowngradeIPIdentifiedWarnings: string;
    attribute DowngradeIPIdentifiedWarnings of RTL : architecture is "yes";

    attribute CORE_GENERATION_INFO : string;
    attribute CORE_GENERATION_INFO of RTL : architecture is "gt64_rtm6r,gtwizard_v3_3,{protocol_file=Start_from_scratch}";

--**************************Component Declarations*****************************

    
component gt64_rtm6r_support
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
    Q0_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
    Q0_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;

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
    --_________________________________________________________________________
    --_________________________________________________________________________
    --GT0  (X1Y0)
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
    --GT1  (X1Y1)
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
    --GT2  (X1Y2)
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
    --GT3  (X1Y3)
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
    --GT4  (X1Y4)
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
    --GT5  (X1Y5)
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


    --____________________________COMMON PORTS________________________________
     GT0_QPLLOUTCLK_OUT  : out std_logic;
     GT0_QPLLOUTREFCLK_OUT : out std_logic;
    --____________________________COMMON PORTS________________________________
     GT1_QPLLOUTCLK_OUT  : out std_logic;
     GT1_QPLLOUTREFCLK_OUT : out std_logic;

     DRP_CLK_O : out std_logic;
     DRP_CLK_I : in  std_logic

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



--**************************** Wire Declarations ******************************
    -------------------------- GT Wrapper Wires ------------------------------
    --________________________________________________________________________
    --________________________________________________________________________
    --GT0  (X1Y0)

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
    --GT1  (X1Y1)

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
    --GT2  (X1Y2)

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
    --GT3  (X1Y3)

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
    --GT4  (X1Y4)

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
    --GT5  (X1Y5)

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



    ------------------------------- Global Signals -----------------------------
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

    ----------------------------- Reference Clocks ----------------------------
    signal    q0_clk0_refclk_i                : std_logic;


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
  
  
  GT_TXUSERCLK_OUT(0) <= gt0_txusrclk2_i;
  GT_RXUSERCLK_OUT(0) <= gt0_rxusrclk2_i;
  GT_TXUSERCLK_OUT(1) <= gt1_txusrclk2_i;
  GT_RXUSERCLK_OUT(1) <= gt1_rxusrclk2_i;
  GT_TXUSERCLK_OUT(2) <= gt2_txusrclk2_i;
  GT_RXUSERCLK_OUT(2) <= gt2_rxusrclk2_i;
  GT_TXUSERCLK_OUT(3) <= gt3_txusrclk2_i;
  GT_RXUSERCLK_OUT(3) <= gt3_rxusrclk2_i;
  GT_TXUSERCLK_OUT(4) <= gt4_txusrclk2_i;
  GT_RXUSERCLK_OUT(4) <= gt4_rxusrclk2_i;
  GT_TXUSERCLK_OUT(5) <= gt5_txusrclk2_i;
  GT_RXUSERCLK_OUT(5) <= gt5_rxusrclk2_i;

      gt_qpll_lock_i(0) <= gt0_qplllock_i;
      gt_qpll_lock_i(1) <= gt0_qplllock_i;
      gt_qpll_lock_i(2) <= gt0_qplllock_i;
      gt_qpll_lock_i(3) <= gt0_qplllock_i;
      gt_qpll_lock_i(4) <= gt1_qplllock_i;
      gt_qpll_lock_i(5) <= gt1_qplllock_i;
  
    --  Static signal Assigments
    tied_to_ground_i                             <= '0';
    tied_to_ground_vec_i                         <= x"0000000000000000";
    tied_to_vcc_i                                <= '1';
    tied_to_vcc_vec_i                            <= "11111111";

    
q0_clk0_refclk_i                             <= '0';
    ----------------------------- The GT Wrapper -----------------------------
    
    -- Use the instantiation template in the example directory to add the GT wrapper to your design.
    -- In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    -- checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is 
    -- enabled, bonding should occur after alignment.

    
    gt64_rtm6r_support_i : gt64_rtm6r_support
    generic map
    (
        EXAMPLE_SIM_GTRESET_SPEEDUP     =>      EXAMPLE_SIM_GTRESET_SPEEDUP,
        STABLE_CLOCK_PERIOD             =>      STABLE_CLOCK_PERIOD
    )
    port map
    (
        SOFT_RESET_IN                   =>      transceiver_reset_i,
        DONT_RESET_ON_DATA_ERROR_IN     =>      tied_to_ground_i,
        Q0_CLK0_GTREFCLK_PAD_N_IN => GTREFCLK0_N_IN,
        Q0_CLK0_GTREFCLK_PAD_P_IN => GTREFCLK0_P_IN,        
        
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


        --_____________________________________________________________________
        --_____________________________________________________________________
        --GT0  (X1Y0)

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
        --GT1  (X1Y1)

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
        --GT2  (X1Y2)

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
        --GT3  (X1Y3)

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
        --GT4  (X1Y4)

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
        --GT5  (X1Y5)

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



    --____________________________COMMON PORTS________________________________
     GT0_QPLLOUTCLK_OUT  => open,
     GT0_QPLLOUTREFCLK_OUT => open,
    --____________________________COMMON PORTS________________________________
     GT1_QPLLOUTCLK_OUT  => open,
     GT1_QPLLOUTREFCLK_OUT => open,

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

end RTL;


