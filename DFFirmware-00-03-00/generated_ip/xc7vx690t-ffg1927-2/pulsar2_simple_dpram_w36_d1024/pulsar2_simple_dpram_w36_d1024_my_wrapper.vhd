--
library ieee;
use ieee.std_logic_1164.all;
use work.data_formatter_constants.all;

entity pulsar2_simple_dpram_w36_d1024_my_wrapper is
  port (
    clka : in std_logic;
    wea : in std_logic_vector ( 0 to 0 );
    addra : in std_logic_vector ( 9 downto 0 );
    dina : in std_logic_vector ( 35 downto 0 );
    clkb : in std_logic;
    addrb : in std_logic_vector ( 9 downto 0 );
    doutb : out std_logic_vector ( 35 downto 0 )
    );
end pulsar2_simple_dpram_w36_d1024_my_wrapper;

architecture logic of pulsar2_simple_dpram_w36_d1024_my_wrapper is
  
  component pulsar2_simple_dpram_w36_d1024
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 9 downto 0 );
      dina : in std_logic_vector ( 35 downto 0 );
      clkb : in std_logic;
      addrb : in std_logic_vector ( 9 downto 0 );
      doutb : out std_logic_vector ( 35 downto 0 )
      );
  end component;

  signal wea_sync   : std_logic_vector ( 0 to 0 );
  signal addra_sync : std_logic_vector ( 9 downto 0 );
  signal dina_sync  : std_logic_vector ( 35 downto 0 );
  signal addrb_sync : std_logic_vector ( 9 downto 0 );

  signal wea_i_1024 : std_logic_vector( 0 to 0) := (others => '0');
  signal addrb_i_1024 : std_logic_vector ( 11 downto 0 );
  signal doutb_i_1024 : std_logic_vector( 35 downto 0);
  
  attribute mark_debug : string;
  attribute mark_debug of doutb_i_1024   : signal is "true";
  attribute mark_debug of addrb_i_1024   : signal is "true";
  attribute mark_debug of wea_i_1024   : signal is "true";
  

begin
  doutb   <= doutb_i_1024;
  addrb_i_1024 <= addrb;
  wea_i_1024   <= wea;

  FALLING_EDGE_MODE : if (not VIVADO_2014_2_OR_LATER) generate
  begin  
    process (clka)
    begin
      if (clka'event and clka='0') then -- falling edge on purpose
        wea_sync   <= wea;
        addra_sync <= addra;
        dina_sync  <= dina;
      end if;
    end process;
    
    process (clkb)
    begin
      if (clkb'event and clkb='0') then -- falling edge on purpose
        addrb_sync <= addrb;
      end if;
    end process;  
    
    SPY : pulsar2_simple_dpram_w36_d1024
      port map (
        clka => clka,
        wea => wea_sync,
        addra => addra_sync,
        dina => dina_sync,
        clkb => clkb,
        addrb => addrb_sync,
        doutb => doutb
        );
  end generate;
  
  RISING_EDGE_MODE : if (VIVADO_2014_2_OR_LATER) generate
  begin
    SPY : pulsar2_simple_dpram_w36_d1024
      port map (
        clka => clka,
        wea => wea,
        addra => addra,
        dina => dina,
        clkb => clkb,
        addrb => addrb,
        doutb => doutb_i_1024
        );    
  end generate;  
  
end logic;
