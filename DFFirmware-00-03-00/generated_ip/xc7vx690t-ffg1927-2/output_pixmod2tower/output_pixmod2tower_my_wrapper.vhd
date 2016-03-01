--
library ieee;
use ieee.std_logic_1164.all;
use work.data_formatter_constants.all;

entity output_pixmod2tower_my_wrapper is
  port (
    clka : in std_logic;
    wea : in std_logic_vector ( 0 to 0 );
    addra : in std_logic_vector ( 10 downto 0 );
    dina : in std_logic_vector ( 1 downto 0 );
    douta : out std_logic_vector ( 1 downto 0 );
    clkb : in std_logic;
    web : in std_logic_vector ( 0 to 0 );
    addrb : in std_logic_vector ( 10 downto 0 );
    dinb : in std_logic_vector ( 1 downto 0 );
    doutb : out std_logic_vector ( 1 downto 0 ) );
end output_pixmod2tower_my_wrapper;

architecture logic of output_pixmod2tower_my_wrapper is
  
  component output_pixmod2tower
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 10 downto 0 );
      dina : in std_logic_vector ( 1 downto 0 );
      douta : out std_logic_vector ( 1 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 10 downto 0 );
      dinb : in std_logic_vector ( 1 downto 0 );
      doutb : out std_logic_vector ( 1 downto 0 ) );
  end component;
  
  signal wea_sync   : std_logic_vector ( 0 to 0 );
  signal addra_sync : std_logic_vector ( 10 downto 0 );
  signal dina_sync  : std_logic_vector ( 1 downto 0 );
  
  signal web_sync   : std_logic_vector ( 0 to 0 );
  signal addrb_sync : std_logic_vector ( 10 downto 0 );
  signal dinb_sync  : std_logic_vector ( 1 downto 0 );  
  
begin

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
        web_sync   <= web;
        addrb_sync <= addrb;
        dinb_sync  <= dinb;
      end if;
    end process;  
    
    LUT : output_pixmod2tower
      port map (
        clka  => clka,
        wea   => wea_sync,
        addra => addra_sync,
        dina  => dina_sync,
        douta => douta,
        clkb  => clkb,
        web   => web_sync,
        addrb => addrb_sync,
        dinb  => dinb_sync,
        doutb => doutb);
  end generate;
  
  RISING_EDGE_MODE : if (VIVADO_2014_2_OR_LATER) generate
  begin
    LUT : output_pixmod2tower
      port map (
        clka  => clka,
        wea   => wea,
        addra => addra,
        dina  => dina,
        douta => douta,
        clkb  => clkb,
        web   => web,
        addrb => addrb,
        dinb  => dinb,
        doutb => doutb);    
  end generate;  
  
end logic;

