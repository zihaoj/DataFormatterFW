-----
-- spi read write register
-----

library ieee;
use ieee.std_logic_1164.all;

library work;

entity my_writable_register is
  port (
    q    : out std_logic_vector(31 downto 0); -- to logic
    din  : in  std_logic_vector(31 downto 0);
    dout : out std_logic_vector(31 downto 0));
end my_writable_register;

architecture logic of my_writable_register is
begin
  q    <= din;
  dout <= din;
end logic;
