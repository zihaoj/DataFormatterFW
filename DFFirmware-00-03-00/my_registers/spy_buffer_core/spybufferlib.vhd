-----

library ieee;
use ieee.std_logic_1164.all;

package SpybufferConstants is
  constant spybuffer_ls_width         : integer := 8;  -- lane selector
  constant spybuffer_addr_width_d4096 : integer := 12; -- 4096 depth version
  constant spybuffer_addr_width_d1024 : integer := 10; -- 1024 depth version
  constant spybuffer_data_width : integer := 32;
  
  constant spybuffer_lane_max : integer := 2**spybuffer_ls_width;
  type spybuffer_array is array(0 to spybuffer_lane_max-1) of std_logic_vector(31 downto 0);
  
  component spy_buffer_core_d4096
    port (
      Reset : in  std_logic;
      Wen   : in  std_logic;
      Clk   : in  std_logic;
      Din   : in  std_logic_vector(spybuffer_data_width-1 downto 0);
      Dout  : out std_logic_vector(spybuffer_data_width-1 downto 0);
      ReadAddressBinary : in  std_logic_vector(spybuffer_addr_width_d4096-1 downto 0)
      );
  end component;

  component spy_buffer_core_d1024
    port (
      Reset : in  std_logic;
      Wen   : in  std_logic;
      Clk   : in  std_logic;
      Din   : in  std_logic_vector(spybuffer_data_width-1 downto 0);
      Dout  : out std_logic_vector(spybuffer_data_width-1 downto 0);
      ReadAddressBinary : in  std_logic_vector(spybuffer_addr_width_d1024-1 downto 0)
      );
  end component;  
  
end SpybufferConstants;

