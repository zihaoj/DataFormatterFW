--
library ieee;
use ieee.std_logic_1164.all;
use work.data_formatter_constants.all;

entity XFIFOLSC_my_wrapper is
  port (
    rst : in std_logic;
    wr_clk : in std_logic;
    rd_clk : in std_logic;
    din : in std_logic_vector ( 33 downto 0 );
    wr_en : in std_logic;
    rd_en : in std_logic;
    dout : out std_logic_vector ( 33 downto 0 );
    full : out std_logic;
    empty : out std_logic;
    wr_data_count : out std_logic_vector ( 8 downto 0 )
    );
end XFIFOLSC_my_wrapper;

architecture logic of XFIFOLSC_my_wrapper is

  component XFIFOLSC is
    port (
      rst : in std_logic;
      wr_clk : in std_logic;
      rd_clk : in std_logic;
      din : in std_logic_vector ( 33 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 33 downto 0 );
      full : out std_logic;
      empty : out std_logic;
      wr_data_count : out std_logic_vector ( 8 downto 0 )
      );
  end component;

  signal din_sync   : std_logic_vector ( 33 downto 0 );
  signal wr_en_sync : std_logic;

begin

  FALLING_EDGE_MODE : if (not VIVADO_2014_2_OR_LATER) generate
  begin  
    process (wr_clk)
    begin
      if (wr_clk'event and wr_clk='0') then -- falling edge on purpose
        wr_en_sync <= wr_en;
        din_sync <= din;
      end if;
    end process;
    
    fifo_core : XFIFOLSC
      port map (
        rst    => rst,
        wr_clk => wr_clk,
        rd_clk => rd_clk,
        din    => din_sync,
        wr_en  => wr_en_sync,
        rd_en  => rd_en,
        dout   => dout,
        full   => full,
        empty  => empty,
        wr_data_count => wr_data_count
        );
  end generate;
  
  RISING_EDGE_MODE : if (VIVADO_2014_2_OR_LATER) generate
  begin
    fifo_core : XFIFOLSC
      port map (
        rst    => rst,
        wr_clk => wr_clk,
        rd_clk => rd_clk,
        din    => din,
        wr_en  => wr_en,
        rd_en  => rd_en,
        dout   => dout,
        full   => full,
        empty  => empty,
        wr_data_count => wr_data_count
        );    
  end generate;  
  
end logic;

