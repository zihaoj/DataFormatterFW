-----
library ieee;
use ieee.std_logic_1164.all;

library work;

entity my_readonly_register is
  port (
    d    : in  std_logic_vector(31 downto 0); -- from logic
    dout : out std_logic_vector(31 downto 0));
end my_readonly_register;

architecture logic of my_readonly_register is
begin
  dout <= d;
end logic;
