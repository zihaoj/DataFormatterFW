--
library ieee;
use ieee.std_logic_1164.all;

package TlkGtxInterfaceDeclarations is
  
  component tlk_gtx_interface 
    port (SYS_RST            : in  std_logic;
          -- SWITCH the IDLE words
          TOSENDARREAV       : in  std_logic := '0';          
          -- GTX receive ports
          GTX_RXUSRCLK2      : in  std_logic;
          GTX_RXDATA         : in  std_logic_vector(31 downto 0);
          GTX_RXCHARISK      : in  std_logic_vector(3 downto 0);
          GTX_RXENCOMMAALIGN : out std_logic;
          -- GTX transmit ports
          GTX_TXUSRCLK2      : in  std_logic;
          GTX_TXCHARISK      : out std_logic_vector(3 downto 0);
          GTX_TXDATA         : out std_logic_vector(31 downto 0);
          -- TLK2501 ports
          TLK_TXD            : in  std_logic_vector(31 downto 0);
          TLK_TXEN           : in  std_logic;
          TLK_TXER           : in  std_logic;
          TLK_RXD            : out std_logic_vector(31 downto 0);
          TLK_RXDV           : out std_logic;
          TLK_RXER           : out std_logic);
  end component;
  
end TlkGtxInterfaceDeclarations;
