--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

entity ilink_patgen is
  port ( CLK        : in  std_logic;
         TX_DATA    : out std_logic_vector(31 downto 0);
         TX_DVALID  : out std_logic;
         TX_RDY     : in  std_logic;
         ENABLE     : in  std_logic
         );
end ilink_patgen;

architecture logic of ilink_patgen is
  signal patgen_data_i    : std_logic_vector(31 downto 0);
  signal patgen_en_i      : std_logic;
  
begin
  
  -------------------------------------
  -- set to the transceiver input
  -------------------------------------
  --process (CLK)
  --begin
  --  if (CLK'event and CLK='1') then
  --    TX_DVALID  <= patgen_en_i;
  --    if    (patgen_en_i='0') then
  --      TX_DATA <= (others => '0'); -- dummy data
  --    else
  --      TX_DATA <= patgen_data_i;
  --    end if;
  --  end if;
  --end process;
  TX_DATA    <= (others => '0') when (patgen_en_i='0') else patgen_data_i;
  TX_DVALID  <= patgen_en_i;
  
  -------------------------------------
  -- pattern generator
  -------------------------------------
  process (CLK, ENABLE)
  begin
    if    (ENABLE='0') then
      patgen_data_i <= X"CAFECAFE";
      patgen_en_i   <= '0';
    elsif (CLK'event and CLK='1') then
      if    (TX_RDY='0') then
        patgen_data_i <= patgen_data_i;
        patgen_en_i   <= '0';
      else 
        patgen_data_i <= patgen_data_i(0) & (not patgen_data_i(31 downto 1));
        patgen_en_i   <= '1';
      end if;
    end if;
  end process;  
end logic;
