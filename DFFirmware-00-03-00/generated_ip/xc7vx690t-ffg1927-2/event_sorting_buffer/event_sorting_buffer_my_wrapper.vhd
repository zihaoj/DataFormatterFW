-- wrapper
-- to have one cycle buffering
-- to maintain enough setup time (maybe is not needed)

library ieee;
use ieee.std_logic_1164.all;
use work.data_formatter_constants.all;

entity event_sorting_buffer_my_wrapper is
  port (
    clk : in std_logic;
    rst : in std_logic;
    din : in std_logic_vector ( 35 downto 0 );
    wr_en : in std_logic;
    rd_en : in std_logic;
    dout : out std_logic_vector ( 35 downto 0 );
    empty : out std_logic;
    data_count : out STD_LOGIC_VECTOR ( 13 downto 0 );
    prog_full : out std_logic
    );
end event_sorting_buffer_my_wrapper;

architecture logic of event_sorting_buffer_my_wrapper is
  
  component event_sorting_buffer
    port (
      clk : in std_logic;
      rst : in std_logic;
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      full : out std_logic;
      empty : out std_logic;
      data_count : out STD_LOGIC_VECTOR ( 13 downto 0 );
      prog_full : out std_logic
      );
  end component;
  
  signal din_sync   : std_logic_vector ( 35 downto 0 );
  signal wr_en_sync : std_logic;
  
begin
  
  FALLING_EDGE_MODE : if (not VIVADO_2014_2_OR_LATER) generate
  begin
    process (clk)
    begin
      if (clk'event and clk='0') then -- falling edge on purpose
        wr_en_sync <= wr_en;
        din_sync <= din;
      end if;
    end process;
    
    fifo_core : event_sorting_buffer
      port map (
        clk => clk,
        rst => rst,
        din => din_sync,
        wr_en => wr_en_sync,
        rd_en => rd_en,
        dout => dout,
        full => open,
        empty => empty,
        data_count => data_count,
        prog_full => prog_full
        );
  end generate;
  
  RISING_EDGE_MODE : if (VIVADO_2014_2_OR_LATER) generate
  begin
    fifo_core : event_sorting_buffer
      port map (
        clk => clk,
        rst => rst,
        din => din,
        wr_en => wr_en,
        rd_en => rd_en,
        dout => dout,
        full => open,
        empty => empty,
        data_count => data_count,
        prog_full => prog_full
        );    
  end generate;
  
end logic;

