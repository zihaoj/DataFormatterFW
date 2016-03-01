------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.SpiConstants.all;
use work.data_formatter_constants.all;

library unisim;
use unisim.vcomponents.all;  

entity testbench is
  generic ( clk_per_sysclk : time :=5 ns);
end testbench;

architecture logic of testbench is
  
  component top
    port (
      -- SYSCLK
      SYSCLK_P : in std_logic;
      SYSCLK_N : in std_logic;
      
      -- SPI
      SCLK    : in  std_logic;
      SPI_SEL : in  std_logic;
      MOSI    : in  std_logic;
      MISO    : out std_logic
      );
  end component;

  -- ========================================================
  -- master
  signal txdata  : std_logic_vector(bus_width-1 downto 0);
  signal rxdata  : std_logic_vector(bus_width-1 downto 0);  
  
  -- ##########################################  
  procedure spi_master(signal sclk    : out std_logic;
                       signal spi_sel : out std_logic;
                       signal mosi    : out std_logic;
                       signal miso    : in  std_logic;
                       signal txdata  : in  std_logic_vector(bus_width-1 downto 0);
                       signal rxdata  : out std_logic_vector(bus_width-1 downto 0)
                       ) is
  begin
    if cpha='1' then
      -- first select 
      spi_sel <= '0';
      wait for spi_clock_cycle;
      
      for iBit in 1 to bus_width loop
        if cpol='0' then sclk <= '1'; else sclk <= '0'; end if;
        mosi <= txdata(bus_width-iBit);
        wait for spi_clock_cycle;
        if cpol='0' then sclk <= '0'; else sclk <= '1'; end if;
        rxdata(bus_width-iBit) <= miso;
        wait for spi_clock_cycle;
      end loop;
      
      mosi    <= 'Z';
      spi_sel <= '1';
    end if;
    
    if cpha='0' then
      -- first select 
      spi_sel <= '0';
      
      for iBit in 1 to bus_width loop
        mosi <= txdata(bus_width-iBit);
        wait for spi_clock_cycle;
        if cpol='0' then sclk <= '1'; else sclk <= '0'; end if;
        rxdata(bus_width-iBit) <= miso;
        wait for spi_clock_cycle;
        if cpol='0' then sclk <= '0'; else sclk <= '1'; end if;
      end loop;
      
      wait for spi_clock_cycle;
      mosi    <= 'Z';
      spi_sel <= '1';      
    end if;
    
  end spi_master;
  
  signal SCLK : std_logic;
  signal SPI_SEL : std_logic;
  signal MOSI : std_logic;
  signal MISO : std_logic;

  signal SYSCLK_P : std_logic := '0';
  signal SYSCLK_N : std_logic := '1';
  
begin

  -----------------------------------------------------
  -- clock generator (200MHz)
  -----------------------------------------------------
  process
  begin
    wait for clk_per_sysclk/2;
    SYSCLK_P <= not SYSCLK_P;
  end process;
  SYSCLK_N <= not SYSCLK_P;
  
  my_top : top
    port map (
      -- SYSCLK
      SYSCLK_P => SYSCLK_P,
      SYSCLK_N => SYSCLK_N,
      
      -- SPI
      SCLK => SCLK,
      SPI_SEL => SPI_SEL,
      MOSI => MOSI,
      MISO => MISO
      );
  
  process
  begin
    wait for 3 us;
    -- ================================ RESET ENABLE ================================
    txdata<=X"8200";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL,
               mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"8101";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL,
               mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);    
    
    txdata<=X"8100";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL,
               mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);    
    
    --===================================================
    -- RESET SPYBUFFER (before starting data taking) & wait to finish the reset
    --===================================================
    txdata<=X"9701";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"9700";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    wait for 30 us; 
    
    -- ================================ Data Taking Start ================================
    txdata<=X"8201";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL,
               mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    --wait for 10 us;
    
    --txdata<=X"8200";
    --wait for waiting_time;
    --spi_master(sclk=>SCLK, spi_sel=>SPI_SEL,
    --           mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    --wait for 10 us;
    
    --txdata<=X"8201";
    --wait for waiting_time;
    --spi_master(sclk=>SCLK, spi_sel=>SPI_SEL,
    --           mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    wait for 10 us;
    
    --spy buffer readout
    txdata<=X"9702"; -- freeze
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);      
    txdata<=X"9601"; -- set lane
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    --===
    txdata<=X"9400"; -- set address [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"9500"; -- set address [11 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"1000"; -- read data [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1100"; -- read data [15 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1200"; -- read data [23 downto 16]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1300"; -- read data [31 downto 24]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    --===

    txdata<=X"9401"; -- set address [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"9500"; -- set address [11 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1000"; -- read data [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1100"; -- read data [15 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1200"; -- read data [23 downto 16]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1300"; -- read data [31 downto 24]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    --===
    
    txdata<=X"9402"; -- set address [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"9500"; -- set address [11 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1000"; -- read data [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1100"; -- read data [15 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1200"; -- read data [23 downto 16]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1300"; -- read data [31 downto 24]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    --===
    txdata<=X"9601"; -- set lane
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"9403"; -- set address [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"9500"; -- set address [11 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1000"; -- read data [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1100"; -- read data [15 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1200"; -- read data [23 downto 16]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1300"; -- read data [31 downto 24]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    --===
    
    txdata<=X"9404"; -- set address [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"9500"; -- set address [11 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1000"; -- read data [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1100"; -- read data [15 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1200"; -- read data [23 downto 16]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1300"; -- read data [31 downto 24]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    --===
    
    txdata<=X"9405"; -- set address [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"9500"; -- set address [11 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1000"; -- read data [7 downto 0]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1100"; -- read data [15 downto 8]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1200"; -- read data [23 downto 16]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

    txdata<=X"1300"; -- read data [31 downto 24]
    wait for waiting_time;  
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);    
    
    wait;
    
  end process;
  
end logic;
