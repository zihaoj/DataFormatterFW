library ieee;
use ieee.std_logic_1164.all;
use work.LscModDeclarations.all;
use work.data_formatter_constants.all;

entity df_transceiver is
  generic (
    EXAMPLE_SIM_GTRESET_SPEEDUP    : string    := "FALSE";    -- Set to TRUE to speed up sim reset    
    SIMULATION       : integer :=    1;
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
    INTERNALLINK_GT_RXBYTEISALIGNED_OUT : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_GT_PLL_LOCK_OUT        : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_GT_RXPOLARITY_IN : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_GT_TXPOLARITY_IN : in std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_RXN_IN  : in   std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_RXP_IN  : in   std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_TXN_OUT : out  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_TXP_OUT : out  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0)
    );
end df_transceiver;

architecture logic of df_transceiver is

  --component user_logic_prbs
  --  port (
  --    reset       : in  std_logic;            
  --    UCLK        : in  std_logic;
  --    LFF_N       : in  std_logic;
  --    UD          : out std_logic_vector(31 downto 0);
  --    UCTRL_N     : out std_logic;
  --    UWEN_N      : out std_logic;
  --    LDOWN_N     : in  std_logic
  --    );
  --end component;

  component ilink_interface 
    -- define frequency of idle and pad words
    generic (TX_WORD_COUNTER_LENGTH   : integer := 7);
    port (BUFFER_CLR  : in  std_logic;
          MAIN_CLK    : in  std_logic;
          RX_DATA     : out std_logic_vector(31 downto 0);
          RX_DVALID   : out std_logic;
          RX_BUSY     : in  std_logic;
          RX_ENABLE   : in  std_logic;
          
          TX_DATA       : in  std_logic_vector(31 downto 0);
          TX_DVALID     : in  std_logic;
          TX_RDY        : out std_logic;
          TX_ENABLE     : in  std_logic;
          
          -------------------------
          -- Bit Error Rate Test --
          -------------------------
          RX_ENABLE_BERT           : in  std_logic; -- stop data transfer to the main_logic
          TX_ENABLE_BERT           : in  std_logic; -- start sending pseudo-random-data
          RX_BERT_COUNTER_RESET    : in  std_logic; -- counter reset for BERT
          RX_BERT_TOTAL_COUNT      : out std_logic_vector(31 downto 0); --  total/1M
          RX_BERT_ERROR_COUNT      : out std_logic_vector(31 downto 0);
          RX_BERT_COMPARISON_VALID : out std_logic;
          
          --------------------
          -- Return Channel --
          --------------------
          URL         : in  std_logic_vector(3 downto 0);
          LRL         : out std_logic_vector(3 downto 0);        
          
          -------------------
          -- GT RX signals --
          -------------------
          GT_RX_SYNC     : in  std_logic;
          GT_RX_SYNC_MON : out std_logic;
          GT_RXUSERCLK   : in  std_logic;
          GT_RXDATA      : in  std_logic_vector(31 downto 0);
          GT_RXCHARISK   : in  std_logic_vector(3  downto 0);
          GT_RXRESETDONE : in  std_logic;
          
          -------------------
          -- GT TX signals --
          -------------------
          GT_TXUSERCLK   : in  std_logic;
          GT_TXDATA      : out std_logic_vector(31 downto 0);
          GT_TXCHARISK   : out std_logic_vector(3  downto 0);
          GT_TXRESETDONE : in  std_logic;
          
          -----------------
          -- FRAME CHECK --
          -----------------
          GT_RXENCOMMAALIGN        : out std_logic);
  end component;
  
  component gt_fab20_interface
    generic
      (
        -- Simulation attributes
        CPLL_USED : std_logic := '1';
        EXAMPLE_SIM_GTRESET_SPEEDUP    : string    := "FALSE";
        STABLE_CLOCK_PERIOD            : integer   := 20   
        );
    port
      (
        GTREFCLK0_N_IN : in   std_logic; -- should connect to Q2_CLK0
        GTREFCLK0_P_IN : in   std_logic; -- should conncet to Q2_CLK0
        GTREFCLK1_N_IN : in   std_logic; -- should connect to Q5_CLK0
        GTREFCLK1_P_IN : in   std_logic; -- should conncet to Q5_CLK0      
        
        PLL_RESET         : in std_logic := '0';
        TRANSCEIVER_RESET : in std_logic;
        DRP_CLK_IN        : in std_logic;
        POWER_ON_RESET_REQ_LINK : out std_logic;
        
        GT_TXUSERCLK_OUT    : out std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        GT_RXUSERCLK_OUT    : out std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        GT_TX_DATA_IN     : in  DF_GTDATA_LANES_FABRIC_ARRAY;
        GT_TX_CHARISK_IN  : in  DF_GTCHARISK_LANES_FABRIC_ARRAY;
        GT_RX_DATA_OUT    : out DF_GTDATA_LANES_FABRIC_ARRAY;
        GT_RX_CHARISK_OUT : out DF_GTCHARISK_LANES_FABRIC_ARRAY;      
        GT_RXBYTEISALIGNED_OUT : out std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        GT_RXENCOMMAALIGN_IN  : in  std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        GT_RXPOLARITY_IN      : in  std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        GT_TXPOLARITY_IN      : in  std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        GT_TX_RESET_DONE_OUT   : out std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        GT_RX_RESET_DONE_OUT   : out std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        GT_PLL_LOCK_OUT        : out std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);     
        
        RXN_IN  : in   std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        RXP_IN  : in   std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        TXN_OUT : out  std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
        TXP_OUT : out  std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0)
        );
    
  end component;
  
  component gt_rtm34l_interface
    generic
      (
        EXAMPLE_SIM_GTRESET_SPEEDUP             : string    := EXAMPLE_SIM_GTRESET_SPEEDUP;
        STABLE_CLOCK_PERIOD                     : integer   := 20
        );
    port
      (
        GTREFCLK0_N_IN : in   std_logic; -- should connect to Q1_CLK0
        GTREFCLK0_P_IN : in   std_logic; -- should conncet to Q1_CLK0
        GTREFCLK1_N_IN : in   std_logic; -- should connect to Q4_CLK0
        GTREFCLK1_P_IN : in   std_logic; -- should connect to Q4_CLK0
        GTREFCLK2_N_IN : in   std_logic; -- should connect to Q7_CLK0
        GTREFCLK2_P_IN : in   std_logic; -- should connect to Q7_CLK0        

        PLL_RESET         : in std_logic;
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
  end component;
  
  component gt_rtm6r_interface
    generic
      (
        EXAMPLE_SIM_GTRESET_SPEEDUP             : string    := EXAMPLE_SIM_GTRESET_SPEEDUP;
        STABLE_CLOCK_PERIOD                     : integer   := 20
        );
    port
      (
        GTREFCLK0_N_IN : in   std_logic; -- should connect to Q0_CLK0
        GTREFCLK0_P_IN : in   std_logic; -- should conncet to Q0_CLK0

        PLL_RESET         : in std_logic;
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
  end component;  
  
  
  signal slink_lsc_gt_txdata_i      : DF_GTDATA_FOR_SLINK_OUTPUT_ARRAY;
  signal slink_lsc_gt_txcharisk_i   : DF_GTCHARISK_FOR_SLINK_OUTPUT_ARRAY;
  signal slink_lsc_gt_rxdata_i      : DF_GTDATA_FOR_SLINK_OUTPUT_ARRAY;
  signal slink_lsc_gt_rxcharisk_i   : DF_GTCHARISK_FOR_SLINK_OUTPUT_ARRAY;
  signal slink_lsc_gt_txusrclk_i      : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal slink_lsc_gt_rxusrclk_i      : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  signal slink_lsc_gt_rxencommaalign_i : std_logic_vector(NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 downto 0);
  
  signal internallink_gt_txdata_i      : DF_GTDATA_FOR_INTERNALLINK_ARRAY;
  signal internallink_gt_txcharisk_i   : DF_GTCHARISK_FOR_INTERNALLINK_ARRAY;
  signal internallink_gt_rxdata_i      : DF_GTDATA_FOR_INTERNALLINK_ARRAY;
  signal internallink_gt_rxcharisk_i   : DF_GTCHARISK_FOR_INTERNALLINK_ARRAY;
  signal internallink_gt_txusrclk_i      : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_gt_rxusrclk_i      : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  signal internallink_gt_rxencommaalign_i : std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
  
  signal gt_rtm_l_txdata_i    : DF_GTDATA_LANES_RTM_L_ARRAY;
  signal gt_rtm_l_txcharisk_i : DF_GTCHARISK_LANES_RTM_L_ARRAY;
  signal gt_rtm_l_rxdata_i    : DF_GTDATA_LANES_RTM_L_ARRAY;
  signal gt_rtm_l_rxcharisk_i : DF_GTCHARISK_LANES_RTM_L_ARRAY;
  signal gt_rtm_l_txusrclk_i    : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_rxusrclk_i    : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_rxencommaalign_i  : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_rxbyteisaligned_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_rxpolarity_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_txpolarity_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_gt_rxreset_done_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_gt_txreset_done_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_gt_pll_lock_out_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_rxn_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_rxp_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_txn_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);
  signal gt_rtm_l_txp_i : std_logic_vector(NUM_GT_LANES_RTM_L-1 downto 0);

  signal gt_rtm_r_txdata_i    : DF_GTDATA_LANES_RTM_R_ARRAY;
  signal gt_rtm_r_txcharisk_i : DF_GTCHARISK_LANES_RTM_R_ARRAY;
  signal gt_rtm_r_rxdata_i    : DF_GTDATA_LANES_RTM_R_ARRAY;
  signal gt_rtm_r_rxcharisk_i : DF_GTCHARISK_LANES_RTM_R_ARRAY;
  signal gt_rtm_r_txusrclk_i  : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_rxusrclk_i  : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_rxencommaalign_i  : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_rxbyteisaligned_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_rxpolarity_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_txpolarity_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_gt_rxreset_done_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_gt_txreset_done_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_gt_pll_lock_out_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);  
  signal gt_rtm_r_rxn_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_rxp_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_txn_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);
  signal gt_rtm_r_txp_i : std_logic_vector(NUM_GT_LANES_RTM_R-1 downto 0);  
  
  signal gt_fabric_txdata_i    : DF_GTDATA_LANES_FABRIC_ARRAY;
  signal gt_fabric_txcharisk_i : DF_GTCHARISK_LANES_FABRIC_ARRAY;
  signal gt_fabric_rxdata_i    : DF_GTDATA_LANES_FABRIC_ARRAY;
  signal gt_fabric_rxcharisk_i : DF_GTCHARISK_LANES_FABRIC_ARRAY;
  signal gt_fabric_txusrclk_i  : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_rxusrclk_i  : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_rxencommaalign_i  : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_rxbyteisaligned_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_rxpolarity_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_txpolarity_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_gt_rxreset_done_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_gt_txreset_done_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_gt_pll_lock_out_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_rxn_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_rxp_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_txn_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  signal gt_fabric_txp_i : std_logic_vector(NUM_GT_LANES_FABRIC-1 downto 0);
  
  signal gt_rtm_l_power_on_reset_req_i : std_logic;
  signal gt_rtm_r_power_on_reset_req_i : std_logic;
  signal gt_fabric_power_on_reset_req_i : std_logic;
  
  --attribute mark_debug : string; 
  --attribute mark_debug of gt_rtm_r_rxdata_i  : signal is "true";
  --attribute mark_debug of gt_rtm_r_rxcharisk_i  : signal is "true";
  --attribute mark_debug of gt_rtm_r_gt_rxreset_done_i  : signal is "true";
  
begin
    
  
  --SLINK_LANES : for iSlink in 3 to 5 generate
  SLINK_LANES : for iSlink in 0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1 generate
    constant gt_link_id : integer := MAPPING_CONF_SLINKOUT2GTCHANNEL(iSlink);
    signal   slink_lff_n_i          : std_logic;
    --signal   patgen_slink_ud_i      : std_logic_vector(31 downto 0);
    --signal   patgen_slink_uctrl_n_i : std_logic;
    --signal   patgen_slink_uwen_n_i  : std_logic;
    signal   slink_ud_i      : std_logic_vector(31 downto 0);
    signal   slink_uctrl_n_i : std_logic;
    signal   slink_uwen_n_i  : std_logic;    
    signal   slink_ldown_n_i : std_logic;
    signal   slink_reset_n_i : std_logic;
  begin

    -- get rid off the prbs test components 
    
    --PAT_GEN : user_logic_prbs
    --  port map (
    --    reset => SLINK_PATGEN_RESET,
    --    UCLK => MAIN_CLK,
    --   LFF_N => slink_lff_n_i,
    --    UD => patgen_slink_ud_i,
    --    UCTRL_N => patgen_slink_uctrl_n_i,
    --    UWEN_N => patgen_slink_uwen_n_i,
    --    LDOWN_N => slink_ldown_n_i
    --    );
    
    SLINK_LSC_LDOWN_N(iSlink) <= slink_ldown_n_i;
    SLINK_LSC_LFF_N(iSlink)   <= slink_lff_n_i;
    
    process (MAIN_CLK) is
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        --if (SLINK_PATGEN_ENABLE='0') then
        slink_ud_i      <= SLINK_LSC_UD(iSlink);
        slink_uwen_n_i  <= SLINK_LSC_UWEN_N(iSlink);
        slink_uctrl_n_i <= SLINK_LSC_UCTRL_N(iSlink);
        --else
        --  slink_ud_i      <= patgen_slink_ud_i;
        --  slink_uwen_n_i  <= patgen_slink_uwen_n_i;
        --  slink_uctrl_n_i <= patgen_slink_uctrl_n_i;
        --end if;
      end if;
    end process;
    
    LSC_LANE : holalsc_gtx
      generic map(
        SIMULATION=>SIMULATION,
        ALTERA_XILINX=>ALTERA_XILINX,
        ACTIVITY_LENGTH=>ACTIVITY_LENGTH,
        FIFODEPTH=>FIFODEPTH,
        LOG2DEPTH=>LOG2DEPTH,
        FULLMARGIN=>FULLMARGIN_LSC
         )
      port map(
        RESET_N=>slink_reset_n_i,
        
        TOSENDARREAV=>SLINK_LSC_TOSENDARREAV(iSlink),
        
        UD=>slink_ud_i,
        URESET_N=>SLINK_LSC_URESET_N(iSlink),
        UTEST_N=>SLINK_LSC_UTEST_N(iSlink),
        UCTRL_N=>slink_uctrl_n_i,
        UWEN_N=>slink_uwen_n_i,
        UCLK =>MAIN_CLK,
        LFF_N=>SLINK_LSC_LFF_N(iSlink),
        LRL=>SLINK_LSC_LRL(iSlink),
        LDOWN_N=>SLINK_LSC_LDOWN_N(iSlink),
        
        TESTLED_N=>SLINK_LSC_TESTLED_N(iSlink),
        LDERRLED_N=>SLINK_LSC_LDERRLED_N(iSlink),
        LUPLED_N=>SLINK_LSC_LUPLED_N(iSlink),
        FLOWCTLLED_N=>SLINK_LSC_FLOWCTLLED_N(iSlink),
        ACTIVITYLED_N=>SLINK_LSC_ACTIVITYLED_N(iSlink),
        
        ENABLE=>open,
        
        GTX_RXUSRCLK2=>slink_lsc_gt_rxusrclk_i(iSlink),
        GTX_RXDATA=>slink_lsc_gt_rxdata_i(iSlink),
        GTX_RXCHARISK=>slink_lsc_gt_rxcharisk_i(iSlink),
        GTX_RXENCOMMAALIGN=>slink_lsc_gt_rxencommaalign_i(iSlink),
        GTX_TXUSRCLK2=>slink_lsc_gt_txusrclk_i(iSlink),
        GTX_TXCHARISK=>slink_lsc_gt_txcharisk_i(iSlink),
        GTX_TXDATA=>slink_lsc_gt_txdata_i(iSlink),        
        
        DLL_RESET=>'0'                  -- NOT USED
        );    


    
    L_GTCHANNEL : if MAPPING_CONF_SLINKOUT2GTLOC(iSlink)=GTLOC_RTM_L generate
      slink_reset_n_i <= (not LINK_RESET) and (not gt_rtm_l_power_on_reset_req_i); 
      gt_rtm_l_txdata_i(gt_link_id)    <= slink_lsc_gt_txdata_i(iSlink);
      gt_rtm_l_txcharisk_i(gt_link_id) <= slink_lsc_gt_txcharisk_i(iSlink);
      slink_lsc_gt_rxdata_i(iSlink)     <= gt_rtm_l_rxdata_i(gt_link_id);
      slink_lsc_gt_rxcharisk_i(iSlink)  <= gt_rtm_l_rxcharisk_i(gt_link_id);
      slink_lsc_gt_txusrclk_i(iSlink)     <= gt_rtm_l_txusrclk_i(gt_link_id);
      slink_lsc_gt_rxusrclk_i(iSlink)     <= gt_rtm_l_rxusrclk_i(gt_link_id);
      gt_rtm_l_rxencommaalign_i(gt_link_id)   <= slink_lsc_gt_rxencommaalign_i(iSlink);
      SLINK_LSC_GT_RXBYTEISALIGNED_OUT(iSlink) <= gt_rtm_l_rxbyteisaligned_i(gt_link_id);
      gt_rtm_l_rxpolarity_i(gt_link_id) <= SLINK_LSC_GT_RXPOLARITY_IN(iSlink);
      gt_rtm_l_txpolarity_i(gt_link_id) <= SLINK_LSC_GT_TXPOLARITY_IN(iSlink);
      SLINK_LSC_GT_RX_RESET_DONE_OUT(iSlink) <= gt_rtm_l_gt_rxreset_done_i(gt_link_id);
      SLINK_LSC_GT_TX_RESET_DONE_OUT(iSlink) <= gt_rtm_l_gt_txreset_done_i(gt_link_id);
      gt_rtm_l_rxn_i(gt_link_id) <= SLINK_LSC_RXN_IN(iSlink);
      gt_rtm_l_rxp_i(gt_link_id) <= SLINK_LSC_RXP_IN(iSlink);
      SLINK_LSC_TXN_OUT(iSlink) <= gt_rtm_l_txn_i(gt_link_id);
      SLINK_LSC_TXP_OUT(iSlink) <= gt_rtm_l_txp_i(gt_link_id);
      SLINK_LSC_GT_PLL_LOCK_OUT(iSlink) <= gt_rtm_l_gt_pll_lock_out_i(gt_link_id);
    end generate;

    R_GTCHANNEL : if MAPPING_CONF_SLINKOUT2GTLOC(iSlink)=GTLOC_RTM_R generate
      slink_reset_n_i <= (not LINK_RESET) and (not gt_rtm_r_power_on_reset_req_i);
      gt_rtm_r_txdata_i(gt_link_id)    <= slink_lsc_gt_txdata_i(iSlink);
      gt_rtm_r_txcharisk_i(gt_link_id) <= slink_lsc_gt_txcharisk_i(iSlink);
      slink_lsc_gt_rxdata_i(iSlink)     <= gt_rtm_r_rxdata_i(gt_link_id);
      slink_lsc_gt_rxcharisk_i(iSlink)  <= gt_rtm_r_rxcharisk_i(gt_link_id);
      slink_lsc_gt_txusrclk_i(iSlink)     <= gt_rtm_r_txusrclk_i(gt_link_id);
      slink_lsc_gt_rxusrclk_i(iSlink)     <= gt_rtm_r_rxusrclk_i(gt_link_id);
      gt_rtm_r_rxencommaalign_i(gt_link_id)   <= slink_lsc_gt_rxencommaalign_i(iSlink);
      SLINK_LSC_GT_RXBYTEISALIGNED_OUT(iSlink) <= gt_rtm_r_rxbyteisaligned_i(gt_link_id);
      gt_rtm_r_rxpolarity_i(gt_link_id) <= SLINK_LSC_GT_RXPOLARITY_IN(iSlink);
      gt_rtm_r_txpolarity_i(gt_link_id) <= SLINK_LSC_GT_TXPOLARITY_IN(iSlink);
      SLINK_LSC_GT_RX_RESET_DONE_OUT(iSlink) <= gt_rtm_r_gt_rxreset_done_i(gt_link_id);
      SLINK_LSC_GT_TX_RESET_DONE_OUT(iSlink) <= gt_rtm_r_gt_txreset_done_i(gt_link_id);
      gt_rtm_r_rxn_i(gt_link_id) <= SLINK_LSC_RXN_IN(iSlink);
      gt_rtm_r_rxp_i(gt_link_id) <= SLINK_LSC_RXP_IN(iSlink);
      SLINK_LSC_TXN_OUT(iSlink) <= gt_rtm_r_txn_i(gt_link_id);
      SLINK_LSC_TXP_OUT(iSlink) <= gt_rtm_r_txp_i(gt_link_id);
      SLINK_LSC_GT_PLL_LOCK_OUT(iSlink) <= gt_rtm_r_gt_pll_lock_out_i(gt_link_id);
    end generate;    
  end generate;
  
  --SLINK_LANES : for iSlink in 3 to 5 generate
  INTERNALLINK_LANES : for iLink in 0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 generate
    constant gt_link_id : integer := MAPPING_CONF_INTERNALLINK2GTCHANNEL(iLink);
    signal   rx_resetdone_i : std_logic;
    signal   tx_resetdone_i : std_logic;
    signal   link_reset_req_i : std_logic;
  begin
    
    my_internallink_interface :  ilink_interface 
      port map (
        BUFFER_CLR  => INTERNALLINK_BUFFER_CLR,
        MAIN_CLK    => MAIN_CLK,
        RX_DATA     => INTERNALLINK_RX_DATA(iLink),
        RX_DVALID   => INTERNALLINK_RX_DVALID(iLink),
        RX_BUSY     => INTERNALLINK_RX_BUSY(iLink),
        RX_ENABLE   => INTERNALLINK_RX_ENABLE(iLink),
        
        TX_DATA     => INTERNALLINK_TX_DATA(iLink),   
        TX_DVALID   => INTERNALLINK_TX_DVALID(iLink),
        TX_RDY      => INTERNALLINK_TX_RDY(iLink),
        TX_ENABLE   => INTERNALLINK_TX_ENABLE(iLink),
        
        -------------------------
        -- Bit Error Rate Test --
        -------------------------
        RX_ENABLE_BERT           => INTERNALLINK_RX_ENABLE_BERT(iLink),
        TX_ENABLE_BERT           => INTERNALLINK_TX_ENABLE_BERT(iLink),
        RX_BERT_COUNTER_RESET    => INTERNALLINK_RX_BERT_COUNTER_RESET(iLink),
        RX_BERT_TOTAL_COUNT      => INTERNALLINK_RX_BERT_TOTAL_COUNT(iLink),
        RX_BERT_ERROR_COUNT      => INTERNALLINK_RX_BERT_ERROR_COUNT(iLink),
        RX_BERT_COMPARISON_VALID => INTERNALLINK_RX_BERT_COMPARISON_VALID(iLink),
        
        --------------------
        -- Return Channel --
        --------------------
        URL => INTERNALLINK_TX_URL(iLink),
        LRL => INTERNALLINK_RX_LRL(iLink),
        
        -------------------
        -- GT RX signals --
        -------------------
        GT_RX_SYNC     => link_reset_req_i,
        GT_RX_SYNC_MON => open,
        GT_RXUSERCLK   => internallink_gt_rxusrclk_i(iLink),
        GT_RXDATA      => internallink_gt_rxdata_i(iLink),
        GT_RXCHARISK   => internallink_gt_rxcharisk_i(iLink),
        GT_RXRESETDONE => rx_resetdone_i,
        
        -------------------
        -- GT TX signals --
        -------------------
        GT_TXUSERCLK   => internallink_gt_txusrclk_i(iLink),
        GT_TXDATA      => internallink_gt_txdata_i(iLink),
        GT_TXCHARISK   => internallink_gt_txcharisk_i(iLink),
        GT_TXRESETDONE => tx_resetdone_i,
        
        -----------------
        -- FRAME CHECK --
        -----------------
        GT_RXENCOMMAALIGN =>internallink_gt_rxencommaalign_i(iLink));
    
    L_GTCHANNEL : if MAPPING_CONF_INTERNALLINK2GTLOC(iLink)=GTLOC_RTM_L generate
      link_reset_req_i <= LINK_RESET or gt_rtm_l_power_on_reset_req_i;
      gt_rtm_l_txdata_i(gt_link_id)    <= internallink_gt_txdata_i(iLink);
      gt_rtm_l_txcharisk_i(gt_link_id) <= internallink_gt_txcharisk_i(iLink);
      internallink_gt_rxdata_i(iLink)     <= gt_rtm_l_rxdata_i(gt_link_id);
      internallink_gt_rxcharisk_i(iLink)  <= gt_rtm_l_rxcharisk_i(gt_link_id);
      internallink_gt_txusrclk_i(iLink)     <= gt_rtm_l_txusrclk_i(gt_link_id);
      internallink_gt_rxusrclk_i(iLink)     <= gt_rtm_l_rxusrclk_i(gt_link_id);
      gt_rtm_l_rxencommaalign_i(gt_link_id)   <= internallink_gt_rxencommaalign_i(iLink);
      INTERNALLINK_GT_RXBYTEISALIGNED_OUT(iLink) <= gt_rtm_l_rxbyteisaligned_i(gt_link_id);
      gt_rtm_l_rxpolarity_i(gt_link_id) <= INTERNALLINK_GT_RXPOLARITY_IN(iLink);
      gt_rtm_l_txpolarity_i(gt_link_id) <= INTERNALLINK_GT_TXPOLARITY_IN(iLink);
      INTERNALLINK_GT_RX_RESET_DONE_OUT(iLink) <= gt_rtm_l_gt_rxreset_done_i(gt_link_id);
      INTERNALLINK_GT_TX_RESET_DONE_OUT(iLink) <= gt_rtm_l_gt_txreset_done_i(gt_link_id);
      rx_resetdone_i <= gt_rtm_l_gt_rxreset_done_i(gt_link_id);
      tx_resetdone_i <= gt_rtm_l_gt_txreset_done_i(gt_link_id);
      gt_rtm_l_rxn_i(gt_link_id) <= INTERNALLINK_RXN_IN(iLink);
      gt_rtm_l_rxp_i(gt_link_id) <= INTERNALLINK_RXP_IN(iLink);
      INTERNALLINK_TXN_OUT(iLink) <= gt_rtm_l_txn_i(gt_link_id);
      INTERNALLINK_TXP_OUT(iLink) <= gt_rtm_l_txp_i(gt_link_id);
      INTERNALLINK_GT_PLL_LOCK_OUT(iLink) <= gt_rtm_l_gt_pll_lock_out_i(gt_link_id);
    end generate;
    
    R_GTCHANNEL : if MAPPING_CONF_INTERNALLINK2GTLOC(iLink)=GTLOC_RTM_R generate
      link_reset_req_i <= LINK_RESET or gt_rtm_r_power_on_reset_req_i;
      gt_rtm_r_txdata_i(gt_link_id)    <= internallink_gt_txdata_i(iLink);
      gt_rtm_r_txcharisk_i(gt_link_id) <= internallink_gt_txcharisk_i(iLink);
      internallink_gt_rxdata_i(iLink)     <= gt_rtm_r_rxdata_i(gt_link_id);
      internallink_gt_rxcharisk_i(iLink)  <= gt_rtm_r_rxcharisk_i(gt_link_id);
      internallink_gt_txusrclk_i(iLink)     <= gt_rtm_r_txusrclk_i(gt_link_id);
      internallink_gt_rxusrclk_i(iLink)     <= gt_rtm_r_rxusrclk_i(gt_link_id);
      gt_rtm_r_rxencommaalign_i(gt_link_id)   <= internallink_gt_rxencommaalign_i(iLink);
      INTERNALLINK_GT_RXBYTEISALIGNED_OUT(iLink) <= gt_rtm_r_rxbyteisaligned_i(gt_link_id);
      gt_rtm_r_rxpolarity_i(gt_link_id) <= INTERNALLINK_GT_RXPOLARITY_IN(iLink);
      gt_rtm_r_txpolarity_i(gt_link_id) <= INTERNALLINK_GT_TXPOLARITY_IN(iLink);
      INTERNALLINK_GT_RX_RESET_DONE_OUT(iLink) <= gt_rtm_r_gt_rxreset_done_i(gt_link_id);
      INTERNALLINK_GT_TX_RESET_DONE_OUT(iLink) <= gt_rtm_r_gt_txreset_done_i(gt_link_id);
      rx_resetdone_i <= gt_rtm_r_gt_rxreset_done_i(gt_link_id);
      tx_resetdone_i <= gt_rtm_r_gt_txreset_done_i(gt_link_id);
      gt_rtm_r_rxn_i(gt_link_id) <= INTERNALLINK_RXN_IN(iLink);
      gt_rtm_r_rxp_i(gt_link_id) <= INTERNALLINK_RXP_IN(iLink);
      INTERNALLINK_TXN_OUT(iLink) <= gt_rtm_r_txn_i(gt_link_id);
      INTERNALLINK_TXP_OUT(iLink) <= gt_rtm_r_txp_i(gt_link_id);
      INTERNALLINK_GT_PLL_LOCK_OUT(iLink) <= gt_rtm_r_gt_pll_lock_out_i(gt_link_id);
    end generate;
    
    FABRIC_GTCHANNEL : if MAPPING_CONF_INTERNALLINK2GTLOC(iLink)=GTLOC_FABRIC generate
      link_reset_req_i <= LINK_RESET or gt_fabric_power_on_reset_req_i;
      gt_fabric_txdata_i(gt_link_id)    <= internallink_gt_txdata_i(iLink);
      gt_fabric_txcharisk_i(gt_link_id) <= internallink_gt_txcharisk_i(iLink);
      internallink_gt_rxdata_i(iLink)     <= gt_fabric_rxdata_i(gt_link_id);
      internallink_gt_rxcharisk_i(iLink)  <= gt_fabric_rxcharisk_i(gt_link_id);
      internallink_gt_txusrclk_i(iLink)     <= gt_fabric_txusrclk_i(gt_link_id);
      internallink_gt_rxusrclk_i(iLink)     <= gt_fabric_rxusrclk_i(gt_link_id);
      gt_fabric_rxencommaalign_i(gt_link_id)   <= internallink_gt_rxencommaalign_i(iLink);
      INTERNALLINK_GT_RXBYTEISALIGNED_OUT(iLink) <= gt_fabric_rxbyteisaligned_i(gt_link_id);
      gt_fabric_rxpolarity_i(gt_link_id) <= INTERNALLINK_GT_RXPOLARITY_IN(iLink);
      gt_fabric_txpolarity_i(gt_link_id) <= INTERNALLINK_GT_TXPOLARITY_IN(iLink);
      INTERNALLINK_GT_RX_RESET_DONE_OUT(iLink) <= gt_fabric_gt_rxreset_done_i(gt_link_id);
      INTERNALLINK_GT_TX_RESET_DONE_OUT(iLink) <= gt_fabric_gt_txreset_done_i(gt_link_id);
      rx_resetdone_i <= gt_fabric_gt_rxreset_done_i(gt_link_id);
      tx_resetdone_i <= gt_fabric_gt_txreset_done_i(gt_link_id);
      gt_fabric_rxn_i(gt_link_id) <= INTERNALLINK_RXN_IN(iLink);
      gt_fabric_rxp_i(gt_link_id) <= INTERNALLINK_RXP_IN(iLink);
      INTERNALLINK_TXN_OUT(iLink) <= gt_fabric_txn_i(gt_link_id);
      INTERNALLINK_TXP_OUT(iLink) <= gt_fabric_txp_i(gt_link_id);
      INTERNALLINK_GT_PLL_LOCK_OUT(iLink) <= gt_fabric_gt_pll_lock_out_i(gt_link_id);
    end generate;
    
  end generate;
  
  my_gt_rtm34l_interface : gt_rtm34l_interface
    port map
    (
      GTREFCLK0_N_IN => GTREFCLK_N_IN(0),
      GTREFCLK0_P_IN => GTREFCLK_P_IN(0),
      GTREFCLK1_N_IN => GTREFCLK_N_IN(1),
      GTREFCLK1_P_IN => GTREFCLK_P_IN(1),
      GTREFCLK2_N_IN => GTREFCLK_N_IN(2),
      GTREFCLK2_P_IN => GTREFCLK_P_IN(2),      

      PLL_RESET         => PLL_RESET,
      TRANSCEIVER_RESET => TRANSCEIVER_RESET,
      DRP_CLK_IN        => DRP_CLK_IN,
      POWER_ON_RESET_REQ_LINK => gt_rtm_l_power_on_reset_req_i,
      
      GT_TXUSERCLK_OUT=>gt_rtm_l_txusrclk_i,
      GT_RXUSERCLK_OUT=>gt_rtm_l_rxusrclk_i,
      GT_TX_DATA_IN=>gt_rtm_l_txdata_i,
      GT_TX_CHARISK_IN=>gt_rtm_l_txcharisk_i,
      GT_RX_DATA_OUT=>gt_rtm_l_rxdata_i,
      GT_RX_CHARISK_OUT=>gt_rtm_l_rxcharisk_i,
      GT_RXBYTEISALIGNED_OUT=>gt_rtm_l_rxbyteisaligned_i,
      GT_RXENCOMMAALIGN_IN=>gt_rtm_l_rxencommaalign_i,
      GT_RXPOLARITY_IN=>gt_rtm_l_rxpolarity_i,
      GT_TXPOLARITY_IN=>gt_rtm_l_txpolarity_i,
      GT_TX_RESET_DONE_OUT=>gt_rtm_l_gt_txreset_done_i,
      GT_RX_RESET_DONE_OUT=>gt_rtm_l_gt_rxreset_done_i,
      GT_PLL_LOCK_OUT=>gt_rtm_l_gt_pll_lock_out_i,
      
      RXN_IN=>gt_rtm_l_rxn_i, RXP_IN=>gt_rtm_l_rxp_i,
      TXN_OUT=>gt_rtm_l_txn_i, TXP_OUT=>gt_rtm_l_txp_i
      );
    
  my_gt_rtm6r_interface : gt_rtm6r_interface
    port map
    (
      GTREFCLK0_N_IN => GTREFCLK_N_IN(3),
      GTREFCLK0_P_IN => GTREFCLK_P_IN(3),

      PLL_RESET         => PLL_RESET,
      TRANSCEIVER_RESET => TRANSCEIVER_RESET,
      DRP_CLK_IN        => DRP_CLK_IN,
      POWER_ON_RESET_REQ_LINK => gt_rtm_r_power_on_reset_req_i,
      
      GT_TXUSERCLK_OUT=>gt_rtm_r_txusrclk_i,
      GT_RXUSERCLK_OUT=>gt_rtm_r_rxusrclk_i,
      GT_TX_DATA_IN=>gt_rtm_r_txdata_i,
      GT_TX_CHARISK_IN=>gt_rtm_r_txcharisk_i,
      GT_RX_DATA_OUT=>gt_rtm_r_rxdata_i,
      GT_RX_CHARISK_OUT=>gt_rtm_r_rxcharisk_i,
      GT_RXBYTEISALIGNED_OUT=>gt_rtm_r_rxbyteisaligned_i,
      GT_RXENCOMMAALIGN_IN=>gt_rtm_r_rxencommaalign_i,
      GT_RXPOLARITY_IN=>gt_rtm_r_rxpolarity_i,
      GT_TXPOLARITY_IN=>gt_rtm_r_txpolarity_i,
      GT_TX_RESET_DONE_OUT=>gt_rtm_r_gt_txreset_done_i,
      GT_RX_RESET_DONE_OUT=>gt_rtm_r_gt_rxreset_done_i,
      GT_PLL_LOCK_OUT=>gt_rtm_r_gt_pll_lock_out_i,
      
      RXN_IN=>gt_rtm_r_rxn_i, RXP_IN=>gt_rtm_r_rxp_i,
      TXN_OUT=>gt_rtm_r_txn_i, TXP_OUT=>gt_rtm_r_txp_i
      );
  
  my_gt_fab20_interface : gt_fab20_interface
    port map
    (
      GTREFCLK0_N_IN => GTREFCLK_N_IN(4),
      GTREFCLK0_P_IN => GTREFCLK_P_IN(4),
      GTREFCLK1_N_IN => GTREFCLK_N_IN(5),
      GTREFCLK1_P_IN => GTREFCLK_P_IN(5),      

      PLL_RESET         => PLL_RESET,
      TRANSCEIVER_RESET => TRANSCEIVER_RESET,
      DRP_CLK_IN        => DRP_CLK_IN,
      POWER_ON_RESET_REQ_LINK => gt_fabric_power_on_reset_req_i,
      
      GT_TXUSERCLK_OUT=>gt_fabric_txusrclk_i,
      GT_RXUSERCLK_OUT=>gt_fabric_rxusrclk_i,
      GT_TX_DATA_IN=>gt_fabric_txdata_i,
      GT_TX_CHARISK_IN=>gt_fabric_txcharisk_i,
      GT_RX_DATA_OUT=>gt_fabric_rxdata_i,
      GT_RX_CHARISK_OUT=>gt_fabric_rxcharisk_i,
      GT_RXBYTEISALIGNED_OUT=>gt_fabric_rxbyteisaligned_i,
      GT_RXENCOMMAALIGN_IN=>gt_fabric_rxencommaalign_i,
      GT_RXPOLARITY_IN=>gt_fabric_rxpolarity_i,
      GT_TXPOLARITY_IN=>gt_fabric_txpolarity_i,
      GT_TX_RESET_DONE_OUT=>gt_fabric_gt_txreset_done_i,
      GT_RX_RESET_DONE_OUT=>gt_fabric_gt_rxreset_done_i,
      GT_PLL_LOCK_OUT=>gt_fabric_gt_pll_lock_out_i,
      
      RXN_IN=>gt_fabric_rxn_i, RXP_IN=>gt_fabric_rxp_i,
      TXN_OUT=>gt_fabric_txn_i, TXP_OUT=>gt_fabric_txp_i
      );    
  
end logic;
