--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

use work.data_formatter_constants.all;

entity patgen is
  generic (longer_period : std_logic := '0';
           const_pattern : std_logic_vector(7 downto 0) := (others => '0'));
  port ( CLK        : in  std_logic;
         TX_DATA    : out std_logic_vector(31 downto 0);
         TX_DVALID  : out std_logic;
         TX_RDY     : in  std_logic;
         ENABLE     : in  std_logic
         );
end patgen;

architecture logic of patgen is
  signal control_counter_i    : std_logic_vector(27 downto 0);
  signal test_pattern_i       : std_logic_vector(7 downto 0) := (others => '0');
  signal patgen_en_i      : std_logic;
  
  type desination_bit_pattern_t is array(3 downto 0) of std_logic_vector(31 downto 0);
  constant DESTINATION_BIT_PATTERN_1 : desination_bit_pattern_t :=
    ( "0000"&"0000"& "0000"&"1000"& "1000"&"0000"& "0000"&"0001",
      "0000"&"0000"& "0000"&"0100"& "0100"&"0000"& "0000"&"0010",
      "0000"&"0000"& "0000"&"0001"& "0001"&"0000"& "0000"&"0100",
      "0000"&"0000"& "0000"&"0010"& "0010"&"0000"& "0000"&"1000"
      );
  
begin
  
  -------------------------------------
  -- set to the transceiver input
  -------------------------------------
  process (CLK)
  begin
    if (CLK'event and CLK='1') then
      TX_DVALID  <= patgen_en_i;
      if    (patgen_en_i='0') then
        TX_DATA(31 downto 28) <= "0000";
        TX_DATA <= (others => '0'); -- dummy data
      else
        if (longer_period = '0') then
          if    (control_counter_i(3 downto 0)="0001") then
            TX_DATA(15 downto  0) <= control_counter_i(23 downto  8); -- pseudo event id
            TX_DATA(23 downto 16) <= const_pattern;
            TX_DATA(27 downto 24) <= (others => '0');
            TX_DATA(31 downto 28) <= DFIF_FRAGMENTID_HEADER;
            test_pattern_i        <= (others => '0');
          elsif (control_counter_i(3 downto 0)="0010") then
            TX_DATA <= DESTINATION_BIT_PATTERN_1(CONV_INTEGER(control_counter_i(5 downto 4)));
          elsif (control_counter_i(3 downto 0)="0000") then
            TX_DATA(27 downto  0) <= (others => '0');
            TX_DATA(31 downto 28) <= DFIF_FRAGMENTID_TRAILER;
          else
            test_pattern_i <= test_pattern_i+1;
            TX_DATA(23 downto  0) <= test_pattern_i&test_pattern_i&test_pattern_i;
            TX_DATA(27 downto 24) <= "0000"; 
            TX_DATA(31 downto 28) <= "0000"; -- FRAGMENT ID for DATA
          end if;
        else
          if    (control_counter_i(5 downto 0)="000001") then
            TX_DATA(15 downto  0) <= control_counter_i(24 downto  9); -- pseudo event id
            TX_DATA(23 downto 16) <= const_pattern;
            TX_DATA(27 downto 24) <= (others => '0');            
            TX_DATA(31 downto 28) <= DFIF_FRAGMENTID_HEADER;
          elsif (control_counter_i(5 downto 0)="000010") then
            TX_DATA <= DESTINATION_BIT_PATTERN_1(CONV_INTEGER(control_counter_i(7 downto 6)));
          elsif (control_counter_i(5 downto 0)="000000") then
            TX_DATA(27 downto  0) <= (others => '0');
            TX_DATA(31 downto 28) <= DFIF_FRAGMENTID_TRAILER;
          else
            test_pattern_i <= test_pattern_i+1;
            TX_DATA(23 downto  0) <= test_pattern_i&test_pattern_i&test_pattern_i;
            TX_DATA(27 downto 24) <= "0000";
            TX_DATA(31 downto 28) <= "0000";
          end if;          
        end if;
      end if;
    end if;
  end process;
  
  -------------------------------------
  -- pattern generator
  -------------------------------------
  process (CLK, ENABLE)
  begin
    if    (ENABLE='0') then
      control_counter_i <= (others => '0');
      patgen_en_i   <= '0';
    elsif (CLK'event and CLK='1') then
      if    (TX_RDY='0') then
        control_counter_i <= control_counter_i;
        patgen_en_i   <= '0';
      else 
        control_counter_i <= control_counter_i + 1;
        patgen_en_i   <= '1';
      end if;
    end if;
  end process;  
end logic;
