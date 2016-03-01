--
library ieee;
use     ieee.std_Logic_1164.all;

library work;
use work.TlkGtxInterfaceDeclarations.All;

entity holalsc_gtx is
  generic(
    SIMULATION       : integer :=    0; -- simulation mode
    ALTERA_XILINX    : integer :=    0; -- 1=Altera 0=Xilinx
    ACTIVITY_LENGTH  : integer :=   15; -- ACTLED duration
    FIFODEPTH        : integer :=  512; -- only powers of 2 (USE 512 !!)
    LOG2DEPTH        : integer :=    9; -- 2log of depth (USE 9 !!)
    FULLMARGIN       : integer :=   16  -- words left when LFF_N
    );                                       
  port (
    RESET_N       : in  std_logic;      -- Power-up reset input
    -- SWITCH the IDLE words
    TOSENDARREAV  : in  std_logic := '0';
    
    -----------------------------------------------------------------------------
    -- S-LINK signals                                                       (46)
    -----------------------------------------------------------------------------
    UD            : in  std_logic_vector(31 downto 0);
    URESET_N      : in  std_logic;
    UTEST_N       : in  std_logic;
    UCTRL_N       : in  std_logic;
    UWEN_N        : in  std_logic;
    UCLK          : in  std_logic;
    LFF_N         : out std_logic;
    LRL           : out std_logic_vector( 3 downto 0);
    LDOWN_N       : out std_logic;
    -----------------------------------------------------------------------------
    -- S-LINK LEDs                                                          ( 5)
    -----------------------------------------------------------------------------
    -- POWERLED_N : direct                -- Green LED between Vcc and Gnd with R
    TESTLED_N     : out std_logic;        -- Red
    LDERRLED_N    : out std_logic;        -- Red. Set to ground in LSC.
    LUPLED_N      : out std_logic;        -- Green
    FLOWCTLLED_N  : out std_logic;        -- Red
    ACTIVITYLED_N : out std_logic;        -- Green. Activity LED.Data being sent
    
    -----------------------------------------------------------------------------
    -- Serializer/Deserializer (TLK-2501) -- general terminals              ( 1)
    -----------------------------------------------------------------------------
    ENABLE        : out std_logic;
    
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
    -- Other pins                                                             (0)
    -----------------------------------------------------------------------------
    DLL_RESET     : in std_logic := '0'    -- only affects Xilinx implementations
                                           -- and should always be low except if
                                           -- complete system is reset.
                                           -- for Altera map to GND
    );  
  
end holalsc_gtx;

architecture logic of holalsc_gtx is
  
  
  component holalsc_core
    generic(
      SIMULATION       : integer :=    0;                   -- simulation mode
      ALTERA_XILINX    : integer :=    1;                   -- 1=Altera 0=Xilinx
      ACTIVITY_LENGTH  : integer :=   15;                   -- ACTLED duration
      FIFODEPTH        : integer :=   64;                   -- only powers of 2
      LOG2DEPTH        : integer :=    6;                   -- 2log of depth
      FULLMARGIN       : integer :=   16                    -- words left when LFF_N
      );                                                      -- set

    port (
      -----------------------------------------------------------------------------
      -- All signals of the ICs are shown in the port description.
      -- The order of signals is according to the specifications of the
      -- S-LINK and TLK2501.
      --
      -- Signals that should be driven directly on the board are shown as
      -- comment with the word 'direct'.
      -----------------------------------------------------------------------------
      --  Total I/O signals (including clock pins, excl. test port)           (90)
      
      POWER_UP_RST_N : in  std_logic;
      -----------------------------------------------------------------------------
      -- S-LINK signals                                                       (46)
      -----------------------------------------------------------------------------
      UD            : in  std_logic_vector(31 downto 0);
      URESET_N      : in  std_logic;
      UTEST_N       : in  std_logic;
      UCTRL_N       : in  std_logic;
      UWEN_N        : in  std_logic;
      UCLK          : in  std_logic;
      LFF_N         : out std_logic;
      LRL           : out std_logic_vector( 3 downto 0);
      LDOWN_N       : out std_logic;
--   LDERR_N       : in  std_logic;
--   UDW           : in  std_logic_vector( 1 downto 0);
      -----------------------------------------------------------------------------
      -- S-LINK LEDs                                                          ( 5)
      -----------------------------------------------------------------------------
      -- POWERLED_N : direct                -- Green LED between Vcc and Gnd with R
      TESTLED_N     : out std_logic;        -- Red
      LDERRLED_N    : out std_logic;        -- Red. Set to ground in LSC.
      LUPLED_N      : out std_logic;        -- Green
      FLOWCTLLED_N  : out std_logic;        -- Red
      ACTIVITYLED_N : out std_logic;        -- Green. Activity LED.Data being sent
      -----------------------------------------------------------------------------
      -- Special signals                                                      ( 1)
      -----------------------------------------------------------------------------
      XCLK          : in std_logic;         -- 100 MHz clock
      -----------------------------------------------------------------------------
      -- Serializer/Deserializer (TLK-2501) -- general terminals              ( 1)
      -----------------------------------------------------------------------------
      ENABLE        : out std_logic;

      -----------------------------------------------------------------------------
      -- Transmitter side of TLK-2501 -- used for data transmission           (18)
      -----------------------------------------------------------------------------
      TXD           : out std_logic_vector(31 downto 0);
      TX_CLK        : in std_logic;         -- Transmit clock

      -- Terminals to control the kind of data presented to the TLK-2501
      -- and their validity

      TX_EN         : out std_logic;
      TX_ER         : out std_logic;

      -----------------------------------------------------------------------------
      -- Receiver side of TLK-2501 -- return lines and flow control            (19)
      -----------------------------------------------------------------------------
      RXD           : in std_logic_vector(31 downto 0); -- Received parallel data
      RX_CLK        : in std_logic;         -- Recovered clock.

      -- Terminals to control the kind of data received from TLK-2501
      -- and their validity

      RX_ER         : in std_logic;
      RX_DV         : in std_logic;


      -----------------------------------------------------------------------------
      -- Other pins                                                             (0)
      -----------------------------------------------------------------------------
      DLL_RESET     : in std_logic           -- only affects Xilinx implementations
                                             -- and should always be low except if
                                             -- complete system is reset.
                                             -- for Altera map to GND
      );

  end component;

  -- TLK signal
  signal TLK_TXD           : std_logic_vector(31 downto 0);
  signal TLK_TX_CLK        : std_logic;
  signal TLK_TX_EN         : std_logic;
  signal TLK_TX_ER         : std_logic;
  signal TLK_RXD           : std_logic_vector(31 downto 0);
  signal TLK_RX_CLK        : std_logic;
  signal TLK_RX_ER         : std_logic;
  signal TLK_RX_DV         : std_logic;
  
  signal RESET : std_logic;
  signal LSC_XCLK : std_logic;

  signal rxdata_i : std_logic_vector(31 downto 0);
  signal ldown_i : std_logic;

  attribute mark_debug : string; 
  attribute mark_debug of rxdata_i  : signal is "true";
  attribute mark_debug of ldown_i  : signal is "true";

  --Keep hierarchy
  --attribute KEEP_HIERARCHY : string;
  --attribute KEEP_HIERARCHY of MyLSC : label is "true";
  --attribute KEEP_HIERARCHY of MyTlkGtxInterface : label is "true";
  
begin
  -- reset
  RESET <= not RESET_N;

  
  -- clock assignment
  TLK_RX_CLK <= GTX_RXUSRCLK2; -- generated on the FPGA
  TLK_TX_CLK <= GTX_TXUSRCLK2; -- generated on the FPGA
  LSC_XCLK   <= GTX_TXUSRCLK2; -- generated on the FPGA
                               -- (usually as long as TX CLK pll out
                               -- is used for rx user clock)

  LDOWN_N <= ldown_i;
  rxdata_i <= GTX_RXDATA;

  MyLSC : holalsc_core
    generic map(
      SIMULATION => SIMULATION,
      ALTERA_XILINX => ALTERA_XILINX,
      ACTIVITY_LENGTH => ACTIVITY_LENGTH,
      FIFODEPTH => FIFODEPTH,
      LOG2DEPTH => LOG2DEPTH,
      FULLMARGIN => FULLMARGIN
      )
    port map (
      POWER_UP_RST_N => RESET_N,
      UD             => UD, 
      URESET_N       => URESET_N,
      UTEST_N        => UTEST_N,
      UCTRL_N        => UCTRL_N,
      UWEN_N         => UWEN_N,
      UCLK           => UCLK,
      LFF_N          => LFF_N,
      LRL            => LRL,
      LDOWN_N        => ldown_i,
      
      TESTLED_N      => TESTLED_N,
      LDERRLED_N     => LDERRLED_N,
      LUPLED_N       => LUPLED_N,
      FLOWCTLLED_N   => FLOWCTLLED_N,
      ACTIVITYLED_N  => ACTIVITYLED_N,
      
      XCLK           => LSC_XCLK, -- GTX_TXUSRCLK2

      ENABLE         => ENABLE,
      
      TXD            => TLK_TXD,
      TX_CLK         => TLK_TX_CLK, -- GTX_TXUSRCLK2
      
      TX_EN          => TLK_TX_EN,
      TX_ER          => TLK_TX_ER,
      
      RXD            => TLK_RXD,
      RX_CLK         => TLK_RX_CLK, -- GTX_TXUSRCLK2
      
      RX_ER          => TLK_RX_ER,
      RX_DV          => TLK_RX_DV,
      
      DLL_RESET      => DLL_RESET
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
