-----
-- spy buffer core
-----

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
    
entity spy_buffer_core_d1024 is
  port (
    Reset : in  std_logic;
    Wen   : in  std_logic;
    Clk   : in  std_logic;    
    Din   : in  std_logic_vector(31 downto 0);
    Dout  : out std_logic_vector(31 downto 0);
    ReadAddressBinary : in  std_logic_vector(9 downto 0)
    );
end spy_buffer_core_d1024;

architecture logic of spy_buffer_core_d1024 is
  
  signal   din_buf_32_r1   : std_logic_vector(31 downto  0);
  signal   din_buf_32_r2   : std_logic_vector(31 downto  0);
  constant din_buf_4    : std_logic_vector(35 downto 32) := (others => '0');
  signal   dout_float_4 : std_logic_vector(35 downto 32);
  signal   WriteAddress_Gray : std_logic_vector(9 downto 0);
  signal   ReadAddress_Gray : std_logic_vector(9 downto 0);
  
  component pulsar2_simple_dpram_w36_d1024_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector(0 downto 0);
      addra : in std_logic_vector(9 downto 0);
      dina : in std_logic_vector(35 downto 0);
      clkb : in std_logic;
      addrb : in std_logic_vector(9 downto 0);
      doutb : out std_logic_vector(35 downto 0)
      );
  end component;
  
  component GrayCounter
    generic (
      COUNTER_WIDTH :integer := 10
      );
    port (                                  --'Gray' code count output.
        GrayCount_out   :out std_logic_vector (COUNTER_WIDTH-1 downto 0);  
        BinaryCount_out :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
        Enable_in       :in  std_logic;       -- Count enable.
        Clear_in        :in  std_logic;       -- Count reset.
        clk             :in  std_logic        -- Input clock
    );  
  end component;
  
  signal wen_r1 : std_logic;
  signal wen_r2 : std_logic;
  signal writeAddress_Gray_r2   : std_logic_vector(9 downto 0);
  signal writeAddress_for_reset : std_logic_vector(9 downto 0);
  signal during_reset : std_logic := '0';
  
begin

  -- latch and selector
  process (Clk)
  begin
    if (Clk'event and Clk='1') then
      -- delay 1
      din_buf_32_r1 <= Din;
      wen_r1        <= Wen;
      if (during_reset='0') then
        -- delay 2
        din_buf_32_r2 <= din_buf_32_r1;
        wen_r2        <= wen_r1;
        writeAddress_Gray_r2 <= WriteAddress_Gray;
      else
        -- delay 2
        din_buf_32_r2 <= (others => '0');
        wen_r2        <= '1';
        writeAddress_Gray_r2 <= writeAddress_for_reset;
      end if;
    end if;
  end process;
  
  -- "during reset" bit handler
  process (Clk)
  begin
    if (Clk'event and Clk='1') then
      if (Reset='1') then
        during_reset <= '1';
      elsif (and_reduce(writeAddress_for_reset)='1') then
        during_reset <= '0';
      end if;
    end if;
  end process;

  -- reset address counter
  process (Clk)
  begin
    if (Clk'event and Clk='1') then
      if (during_reset='1') then
        writeAddress_for_reset <= writeAddress_for_reset + 1;
      else
        writeAddress_for_reset <= (others => '0');
      end if;
    end if;
  end process;  
  
  DPRAM : pulsar2_simple_dpram_w36_d1024_my_wrapper
    port map (
      clka  => Clk,
      wea(0)=> wen_r2,
      addra => WriteAddress_Gray_r2,
      dina(31 downto  0) => din_buf_32_r2,
      dina(35 downto 32) => din_buf_4,
      clkb  => Clk,
      addrb => ReadAddress_Gray,
      doutb(31 downto  0) => Dout,
      doutb(35 downto 32) => dout_float_4
      );
  
  GrayCounter_Wr : GrayCounter
    port map (
      GrayCount_out   => WriteAddress_Gray,
      BinaryCount_out => open,
      Enable_in       => wen_r1,
      Clear_in        => Reset,
      clk             => Clk
      );
  
  ReadAddress_Gray <= (ReadAddressBinary(9) & (ReadAddressBinary(8 downto 0) xor
                                               ReadAddressBinary(9 downto 1)) );  
  
end logic;
