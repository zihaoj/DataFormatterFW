--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity pattern_generator is
  generic (
    INPUT_ROM_FILE_NALE : string  := "test.dat";
    DATA_WIDTH        : positive := 32;
    RAM_ADDRESS_WIDTH : positive := 8
    );
  port (
    SYS_CLK : in  std_logic;    

    -- output request and data out
    RDREQ   : in  std_logic;
    Q       : out std_logic_vector(DATA_WIDTH-1 downto 0);
    DV      : out std_logic; -- data valid
    
    -- CLEAR signal
    ACLR    : in  std_logic
    );
end pattern_generator;


architecture logic of pattern_generator is

  type RomType is array(0 to (2**RAM_ADDRESS_WIDTH)-1) of std_logic_vector(DATA_WIDTH downto 0);
  
  impure function InitRomFromFile (RomFileName : in string) return RomType is
    
    FILE RomFile : text open read_mode is RomFileName;
    variable RomFileLine : line;
    variable ROM : RomType := (others => (others => '0'));
    variable tmpbuf : std_logic_vector(35 downto 0); -- 9 digit
  begin
    for i in RomType'range loop
      readline (RomFile, RomFileLine);
      hread (RomFileLine, tmpbuf);
      ROM(i) := tmpbuf(DATA_WIDTH downto 0); -- +1 to show the termination bit
    end loop;
    return ROM;
  end function;
  
  signal ROM : RomType := InitRomFromFile(INPUT_ROM_FILE_NALE);
  signal rom_read_address : std_logic_vector(RAM_ADDRESS_WIDTH-1 downto 0) := (others => '0');
  signal internal_stop : std_logic := '0';
  
begin
  
  process (SYS_CLK, ACLR)
  begin
    if (ACLR='1') then
      rom_read_address <= (others => '0');
      Q <= (others => '0');
      DV <= '0';
      
    elsif (SYS_CLK'event and SYS_CLK='1') then 
      if (RDREQ = '0' or internal_stop ='1')  then
        rom_read_address    <= rom_read_address;
        DV <= '0';
      elsif (ROM(conv_integer(rom_read_address))(DATA_WIDTH) = '1') then
        Q <= ROM(conv_integer(rom_read_address))(DATA_WIDTH-1 downto 0);
        rom_read_address <= (others => '1');
        internal_stop <= '1';
        DV <= '0';
      else
        Q <= ROM(conv_integer(rom_read_address))(DATA_WIDTH-1 downto 0);
        rom_read_address <= rom_read_address + 1;
        DV <= '1';
      end if;
    end if;
  end process;
  
end logic;
