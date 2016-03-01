--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

entity ilink_patchk is
  port (CLK        : in  std_logic;
        RX_DATA    : in  std_logic_vector(31 downto 0);
        RX_DVALID  : in  std_logic;
        COUNTER_RESET : in  std_logic;
        TOTAL_COUNTER : out std_logic_vector(31 downto 0);
        ERROR_COUNTER : out std_logic_vector(31 downto 0);
        COMPARISON_VALID : out std_logic
        );
end ilink_patchk;

architecture logic of ilink_patchk is
  signal rxdata_r              : std_logic_vector(31 downto 0) := (others => '0');
  signal ref_data_r            : std_logic_vector(31 downto 0) := (others => '0');
  signal rxdvalid_r            : std_logic;
  signal check_error_counter_i : std_logic_vector(31 downto 0) := (others => '0');
  signal check_total_counter_i : std_logic_vector(51 downto 0) := (others => '0');
  signal comparison_valid_i    : std_logic;
  
begin
  
  ERROR_COUNTER <= check_error_counter_i;
  TOTAL_COUNTER <= check_total_counter_i(51 downto 20);
  COMPARISON_VALID <= comparison_valid_i;
  
  -- LDC pattern cheker part
  -------------------------------------
  -- pattern prediction
  -------------------------------------
  process (CLK)
  begin
    if (CLK'event and CLK='1') then
      if (RX_DVALID='1') then
        rxdata_r <= RX_DATA;
      end if;
      ref_data_r <= rxdata_r(0) & (not rxdata_r(31 downto 1));
      rxdvalid_r  <= RX_DVALID;
    end if;
  end process;
  
  -------------------------------------
  -- pattern checker
  -------------------------------------
  process (CLK, COUNTER_RESET)
  begin
    if    (COUNTER_RESET='1') then
      check_error_counter_i <= (others => '0');
      check_total_counter_i <= (others => '0');
      comparison_valid_i    <= '0';
    elsif (CLK'event and CLK='1') then
      if (rxdvalid_r = '1') then
        comparison_valid_i <= '1';
        check_total_counter_i <= check_total_counter_i + 1;
        if ((ref_data_r /= rxdata_r) and (comparison_valid_i='1') and (check_error_counter_i(31)='0') ) then
          check_error_counter_i <= check_error_counter_i + 1;
        end if;
      end if;
    end if;
  end process;  
  
end logic;
