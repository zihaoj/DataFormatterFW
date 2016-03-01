-----
-- spi spybuffer module
-- muti-clock domain version
-----

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.SpybufferConstants.all;

entity spy_buffer_multilanes_d4096_multi_clock_domain is
  generic (
    numberOfLanes : integer range 1 to spybuffer_lane_max := spybuffer_lane_max
    );
  port (
    Reset  : in  std_logic;
    Freeze : in  std_logic;
    Wen   : in  std_logic_vector(spybuffer_lane_max-1 downto 0);
    Ren    : in  std_logic;
    Clk   : in  std_logic_vector(spybuffer_lane_max-1 downto 0);
    Din   : in  spybuffer_array;
    Dout  : out std_logic_vector(spybuffer_data_width-1 downto 0);
    LaneSelector : in  std_logic_vector(spybuffer_ls_width-1 downto 0);
    ReadAddressBinary : in  std_logic_vector(spybuffer_addr_width_d4096-1 downto 0)
    );
end spy_buffer_multilanes_d4096_multi_clock_domain;

architecture logic of spy_buffer_multilanes_d4096_multi_clock_domain is
  component spy_buffer_core_d4096 is
   port (
    Reset : in  std_logic;
    Ren   : in  std_logic;
    Wen   : in  std_logic;
    Clk   : in  std_logic;    
    Din   : in  std_logic_vector(31 downto 0);
    Dout  : out std_logic_vector(31 downto 0);
    ReadAddressBinary : in  std_logic_vector(11 downto 0)
    );
  end component;
  
  signal dout_buf : spybuffer_array;
  signal lane_sel : integer range 0 to numberOfLanes-1 := 0;
begin
  
  lane_sel <= to_integer(unsigned(LaneSelector));
  Dout <= dout_buf(lane_sel);

  
  
  SpyBuffers : for ii in 0 to numberOfLanes-1 generate
    signal the_wen : std_logic := '0';
    signal the_ren : std_logic := '0';
    signal dout_i  : std_logic_vector(spybuffer_data_width-1 downto 0);
    signal din_i   : std_logic_vector(spybuffer_data_width-1 downto 0);
  begin
    process (Clk(ii))
    begin
      if (Clk(ii)'event and Clk(ii)='1') then
        the_wen      <= Wen(ii) and (not Freeze);
        din_i        <= Din(ii);
        dout_buf(ii) <= dout_i;
        the_ren      <= Ren;
      end if;
    end process;
    
    SpyBufferCore : spy_buffer_core_d4096
      port map(
        Reset => Reset,
        Ren => the_ren,
        Wen => the_wen,
        Clk => Clk(ii),
        Din => din_i,
        Dout => dout_i,
        ReadAddressBinary => ReadAddressBinary
        );
  end generate;

end logic;
