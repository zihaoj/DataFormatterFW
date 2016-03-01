library ieee;
use ieee.std_logic_1164.all;
use work.data_formatter_constants.all;

entity pulsar2_simple_dpram_w36_d4096_my_wrapper is
  port (
    clka : in std_logic;
    wea : in std_logic_vector ( 0 to 0 );
    addra : in std_logic_vector ( 11 downto 0 );
    dina : in std_logic_vector ( 35 downto 0 );
    clkb : in std_logic;
    enb : in std_logic;
    addrb : in std_logic_vector ( 11 downto 0 );
    doutb : out std_logic_vector ( 35 downto 0 )
    );
end pulsar2_simple_dpram_w36_d4096_my_wrapper;

architecture logic of pulsar2_simple_dpram_w36_d4096_my_wrapper is
  
  component pulsar2_simple_dpram_w36_d4096_v3
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 11 downto 0 );
      dina : in std_logic_vector ( 35 downto 0 );
      clkb : in std_logic;
      enb : in std_logic;
      addrb : in std_logic_vector ( 11 downto 0 );
      doutb : out std_logic_vector ( 35 downto 0 );
      sbiterr : OUT STD_LOGIC;
      dbiterr : OUT STD_LOGIC;
      rdaddrecc : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
      );
  end component;

  signal wea_sync   : std_logic_vector ( 0 to 0 ) ;
  signal addra_sync : std_logic_vector ( 11 downto 0 );
  signal dina_sync  : std_logic_vector ( 35 downto 0 );
  signal addrb_sync : std_logic_vector ( 11 downto 0 );

  signal wea_i_4096 : std_logic_vector( 0 to 0) := (others => '0');
  signal addrb_i_4096 : std_logic_vector ( 11 downto 0 );
  signal doutb_i_4096 : std_logic_vector( 35 downto 0);
  signal enb_i : std_logic;
  signal sbiterr_i : std_logic;
  signal dbiterr_i : std_logic;
  signal rdaddrecc_i : std_logic_vector(11 downto 0);

  
  attribute mark_debug : string;
  attribute mark_debug of doutb_i_4096   : signal is "true";
  attribute mark_debug of addrb_i_4096   : signal is "true";
  attribute mark_debug of sbiterr_i   : signal is "true";
  attribute mark_debug of dbiterr_i   : signal is "true";
  attribute mark_debug of wea_i_4096   : signal is "true";
  attribute mark_debug of rdaddrecc_i  : signal is "true";
  attribute mark_debug of enb_i   : signal is "true";

Begin
  doutb   <= doutb_i_4096;
  addrb_i_4096 <= addrb;
  wea_i_4096   <= wea;
  enb_i <= enb;
  
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
    
    SPY : pulsar2_simple_dpram_w36_d4096_v3
      port map (
        clka => clka,
        wea => wea_sync,
        addra => addra_sync,
        dina => dina_sync,
        clkb => clkb,
        addrb => addrb_sync,
        doutb => doutb,
        sbiterr => sbiterr_i,
        dbiterr => dbiterr_i,
        rdaddrecc => rdaddrecc_i,
        enb => enb
        );
  end generate;
  
  RISING_EDGE_MODE : if (VIVADO_2014_2_OR_LATER) generate
  begin
    SPY : pulsar2_simple_dpram_w36_d4096_v3
      port map (
        clka => clka,
        wea => wea,
        addra => addra,
        dina => dina,
        clkb => clkb,
        addrb => addrb,
        doutb => doutb_i_4096,
        sbiterr => sbiterr_i,
        dbiterr => dbiterr_i,
        rdaddrecc => rdaddrecc_i,
        enb => enb
        );    
  end generate;  
  
end logic;

