--
library ieee;
use     ieee.std_Logic_1164.all;
use work.TlkGtxInterfaceDeclarations.All;

library work;

entity holaldc_gtx is
  generic (
      ALTERA_XILINX    : integer :=    1; -- 1=Altera 0=Xilinx
      SIMULATION       : integer :=    0; -- simulation mode
      ACTIVITY_LENGTH  : integer :=   15; -- ACTLED duration
      FIFODEPTH        : integer :=  512; -- only powers of 2 (USE 512!!)
      LOG2DEPTH        : integer :=    9; -- 2log of depth (USE 9!!)
      FULLMARGIN       : integer :=  256  -- words left when
                                          -- LFF_N ste
    );
  port (
    RESET_N          : in std_logic;
    -- SWITCH the IDLE words
    TOSENDARREAV     : in  std_logic := '0';
    
    LD               : out  std_logic_vector(31 downto 0);
    UXOFF_N          : in   std_logic;
    URESET_N         : in   std_logic;
    UTDO_N           : in   std_logic;
--   UDW              : in   std_logic_vector( 1 downto 0); -- not used
    LCTRL_N          : out  std_logic;
    LWEN_N           : out  std_logic;
    LCLK             : out  std_logic;
    LDERR_N          : out  std_logic;
    URL              : in   std_logic_vector( 3 downto 0);
    LDOWN_N          : out  std_logic;
    -----------------------------------------------------------------------------
    -- S-LINK LEDs                                                          ( 5)
    -----------------------------------------------------------------------------
    -- Vcc and Gnd with R
    TESTLED_N        : out  std_logic;                     -- Red
    LDERRLED_N       : out  std_logic;                     -- Red
    LUPLED_N         : out  std_logic;                     -- Green
    FLOWCTLLED_N     : out  std_logic;                     -- Red
    ACTIVITYLED_N    : out  std_logic;                     -- Green
    -----------------------------------------------------------------------------
    -- Special signals                                                      ( 1)
    -----------------------------------------------------------------------------
    XCLK             : in   std_logic;                     -- 100 MHz clock
    
    -----------------------------------------------------------------------------
    -- Serializer/Deserializer (TLK-2501) general terminals                 ( 1)
    -----------------------------------------------------------------------------
    ENABLE           : out std_logic;
    
    -----------------------------------------------------------------------------
    -- GTX related IO Ports
    -----------------------------------------------------------------------------
    -- GTX receive ports
    GTX_RXUSRCLK2      : in  std_logic;
    GTX_RXDATA         : in  std_logic_vector(31 downto 0);
    GTX_RXCHARISK      : in  std_logic_vector(3 downto 0);
    GTX_RXENCOMMAALIGN : out std_logic;
    -- GTX transmit ports
    GTX_TXUSRCLK2      : in  std_logic;
    GTX_TXCHARISK      : out std_logic_vector(3 downto 0);
    GTX_TXDATA         : out std_logic_vector(31 downto 0);
    
    -----------------------------------------------------------------------------
    -- Other                                                                ( 1)
    -----------------------------------------------------------------------------
    LCLK_IN          : in   std_logic;                      -- this is the clock
    -- at which the data is read out of the link. if the option of having an
    -- LCLK generator within the desing, is used, then the output 'LCLK' signal
    -- must be sent back in through this input.
    DLL_RESET        : in std_logic        -- only affects Xilinx implementations
                                           -- and should always be low except if
                                           -- complete system is reset.
                                           -- for Altera map to GND

    );
  
end holaldc_gtx;

architecture logic of holaldc_gtx is

  component holaldc_core
    generic (
      ALTERA_XILINX    : integer :=    1;                   -- 1=Altera 0=Xilinx
      SIMULATION       : integer :=    0;                   -- simulation mode
      ACTIVITY_LENGTH  : integer :=   15;                   -- ACTLED duration
      FIFODEPTH        : integer :=  512;                   -- only powers of 2
      LOG2DEPTH        : integer :=    9;                   -- 2log of depth
      FULLMARGIN       : integer :=  256                    -- words left when
                                                            -- LFF_N set
      );
    port (
      POWER_UP_RST_N : in std_logic;
      -----------------------------------------------------------------------------
      -- All signals of the ICs are shown in the port description.               --
      -- The order of signals is according to the specifications of the          --
      -- S-LINK and TLK2501.                                                     --
      --                                                                         --
      -- Signals that should be driven directly on the board are shown as        --
      -- comment with the word 'direct'.                                         --
      --                                                                         --
      -----------------------------------------------------------------------------
      -- Total I/O signals(including clock pins, excl. test port)          (91)  --
      -----------------------------------------------------------------------------
      -- S-LINK signals                                                       (47)
      -----------------------------------------------------------------------------
      LD               : out  std_logic_vector(31 downto 0);
      UXOFF_N          : in   std_logic;
      URESET_N         : in   std_logic;
      UTDO_N           : in   std_logic;
      LCTRL_N          : out  std_logic;
      LWEN_N           : out  std_logic;
      LCLK             : out  std_logic;
      LDERR_N          : out  std_logic;
      URL              : in   std_logic_vector( 3 downto 0);
      LDOWN_N          : out  std_logic;
      -----------------------------------------------------------------------------
      -- S-LINK LEDs                                                          ( 5)
      -----------------------------------------------------------------------------
            -- Vcc and Gnd with R
      TESTLED_N        : out  std_logic;                     -- Red
      LDERRLED_N       : out  std_logic;                     -- Red
      LUPLED_N         : out  std_logic;                     -- Green
      FLOWCTLLED_N     : out  std_logic;                     -- Red
      ACTIVITYLED_N    : out  std_logic;                     -- Green
      -----------------------------------------------------------------------------
      -- Special signals                                                      ( 1)
      -----------------------------------------------------------------------------
      XCLK             : in   std_logic;                     -- 100 MHz clock

      -----------------------------------------------------------------------------
      -- Serializer/Deserializer (TLK-2501) general terminals                 ( 1)
      -----------------------------------------------------------------------------
      ENABLE           : out std_logic;
      -----------------------------------------------------------------------------
      -- Transmitter side of TLK-2501 -- return lines and flow control        (18)
      -----------------------------------------------------------------------------

      TXD              : out std_logic_vector(31 downto 0);
      TX_CLK           : in  std_logic;                     -- Recovered clock.   

      -- Terminals to control the kind of data presented to the TLK-2501,
      -- and their validity

      TX_EN            : out  std_logic;
      TX_ER            : out  std_logic;
      -----------------------------------------------------------------------------
      -- Receiver side of TLK-2501 -- used for data reception                 (19)
      -----------------------------------------------------------------------------
      RXD              : in   std_logic_vector(31 downto 0); -- Received parallel
                                                             -- data
      RX_CLK           : in   std_logic;                     -- Recovered clock.

      -- Terminals to control the kind of data received from TLK-2501,
      -- and their validity
      RX_ER            : in   std_logic;
      RX_DV            : in   std_logic;
      -----------------------------------------------------------------------------
      -- Other                                                                ( 1)
      -----------------------------------------------------------------------------
      LCLK_IN          : in   std_logic;     -- this is the clock at which the data
    	                                     -- is read out of the link.
      DLL_RESET        : in std_logic        -- only affects Xilinx implementations
                                             -- and should always be low except if
                                             -- complete system is reset.
                                             -- for Altera map to GND

      );
    
  end component;

  
  -- TLK signal
  signal TLK_TXD           : std_logic_vector(31 downto 0);
  signal TLK_TX_EN         : std_logic;
  signal TLK_TX_ER         : std_logic;
  signal TLK_RXD           : std_logic_vector(31 downto 0);
  signal TLK_RX_CLK        : std_logic;
  signal TLK_RX_ER         : std_logic;
  signal TLK_RX_DV         : std_logic;  
  
  signal RESET : std_logic;
  signal TLK_TX_CLK : std_logic;
  
begin
  -- reset signal
  RESET <= not RESET_N;

  -- clock assignment
  TLK_TX_CLK <= GTX_TXUSRCLK2;
  TLK_RX_CLK <= GTX_RXUSRCLK2;

  MyLDC : holaldc_core
    generic map (
      ALTERA_XILINX => ALTERA_XILINX,
      SIMULATION => SIMULATION,
      ACTIVITY_LENGTH => ACTIVITY_LENGTH,
      FIFODEPTH => FIFODEPTH,
      LOG2DEPTH => LOG2DEPTH,
      FULLMARGIN => FULLMARGIN
      )
    port map (
      POWER_UP_RST_N => RESET_N,
      LD =>  LD,
      UXOFF_N => UXOFF_N,
      URESET_N => URESET_N,
      UTDO_N => UTDO_N,
      LCTRL_N => LCTRL_N,
      LWEN_N => LWEN_N,
      LCLK => LCLK,
      LDERR_N => LDERR_N,
      URL => URL,
      LDOWN_N => LDOWN_N,
      
      TESTLED_N => TESTLED_N,
      LDERRLED_N => LDERRLED_N,
      LUPLED_N => LUPLED_N,
      FLOWCTLLED_N => FLOWCTLLED_N,
      ACTIVITYLED_N => ACTIVITYLED_N,
      
      XCLK => XCLK,
      
      ENABLE => ENABLE,
      
      TXD => TLK_TXD,
      TX_CLK => TLK_TX_CLK,
      TX_EN => TLK_TX_EN,
      TX_ER => TLK_TX_ER,

      RXD => TLK_RXD, 
      RX_CLK => TLK_RX_CLK,
      RX_ER => TLK_RX_ER,
      RX_DV => TLK_RX_DV,
      
      LCLK_IN => LCLK_IN,
      DLL_RESET => DLL_RESET
      );
  
  MyTlkGtxInterface : tlk_gtx_interface
    port map (
      SYS_RST            => RESET,
      -- SWITCH the IDLE words
      TOSENDARREAV       => TOSENDARREAV,
      -- GTX receive ports
      GTX_RXUSRCLK2      => GTX_RXUSRCLK2,
      GTX_RXDATA         => GTX_RXDATA,
      GTX_RXCHARISK      => GTX_RXCHARISK,
      GTX_RXENCOMMAALIGN => GTX_RXENCOMMAALIGN,
      -- GTX transmit ports
      GTX_TXUSRCLK2      => GTX_TXUSRCLK2,
      GTX_TXCHARISK      => GTX_TXCHARISK,
      GTX_TXDATA         => GTX_TXDATA,
      -- TLK2501 ports
      TLK_TXD            => TLK_TXD,
      TLK_TXEN           => TLK_TX_EN,
      TLK_TXER           => TLK_TX_ER,
      TLK_RXD            => TLK_RXD,
      TLK_RXDV           => TLK_RX_DV,
      TLK_RXER           => TLK_RX_ER);
  
end logic;
