library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity user_logic_prbs is
  port (
    reset       : in  std_logic;            
    UCLK        : in  std_logic;
    LFF_N       : in  std_logic;
    UD          : out std_logic_vector(31 downto 0);
    UCTRL_N     : out std_logic;
    UWEN_N      : out std_logic;
    LDOWN_N     : in  std_logic
  );
end entity user_logic_prbs ;

architecture behavioral of user_logic_prbs  is
  -------------------
  -- Components    --
  -------------------
  component PRBS_ANY is
    generic (      
      CHK_MODE: boolean := false; 
      INV_PATTERN : boolean := false;
      POLY_LENGHT : natural range 2 to 63 := 31 ;
      POLY_TAP : natural range 1 to 62 := 28 ;
      NBITS : natural range 1 to 512 := 32
    );
    port (
      RST               : in  std_logic;                            -- sync reset active high
      CLK               : in  std_logic;                            -- system clock
      DATA_IN           : in  std_logic_vector(NBITS - 1 downto 0); -- inject error/data to be checked
      EN                : in  std_logic;                            -- enable/pause pattern generation
      DATA_OUT          : out std_logic_vector(NBITS - 1 downto 0):= (others => '0');  -- generated prbs pattern/errors found
      ERROR_COUNT       : out std_logic_vector(NBITS - 1 downto 0):= (others => '0');  -- sums errors
      EN_OUT	        : out std_logic
    );
  end component PRBS_ANY;

  -------------------
  -- Signal        --
  -------------------
  signal enable         : std_logic;
  signal reset_int      : std_logic;
  signal uwen           : std_logic;
begin
  prbs_inst : prbs_any
    generic map (
      inv_pattern       => false,
      poly_lenght       => 7,
      poly_tap          => 6
    )
    port map (
      rst       => reset_int,
      clk       => UCLK,
      data_in    => X"00000000",
      data_out  => UD,
      en        => enable,
      en_out    => uwen
    );

  reset_int <= not LDOWN_N or reset;
  enable <= LFF_N and LDOWN_N;
  UCTRL_N <= '1';
  UWEN_N <= not uwen;

end architecture behavioral;
