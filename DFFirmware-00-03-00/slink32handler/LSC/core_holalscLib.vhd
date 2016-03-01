--
library ieee;
use ieee.std_logic_1164.all;

package LscModDeclarations is

  component holalsc_gtx
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
    
  end component;


  component holalsc_core
    generic(
      SIMULATION       : integer :=    0;                   -- simulation mode
      ALTERA_XILINX    : integer :=    0;                   -- 1=Altera 0=Xilinx
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
  
end LscModDeclarations;
