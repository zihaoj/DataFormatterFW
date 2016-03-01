------------------------------------------------------------------------------
-- PulsarIIb
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.FmcConstants.all;

entity fmc_rx_mapper_fmc_to_fpga is
  port (
    din        : in  std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    dout_fpga0 : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
    dout_fpga1 : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0)
    );
end fmc_rx_mapper_fmc_to_fpga;

architecture logic of fmc_rx_mapper_fmc_to_fpga is

begin
  
  pins_fpga0 : for ipin in 0 to lvds_pairs_for_rx_in_each_fpga-1 generate
  begin
    dout_fpga0(ipin) <= din(rx_fmc_to_fpga0_bit_mapping(ipin));    
  end generate;
  
  pins_fpga1 : for ipin in 0 to lvds_pairs_for_rx_in_each_fpga-1 generate
  begin
    dout_fpga1(ipin) <= din(rx_fmc_to_fpga1_bit_mapping(ipin));
  end generate;
  
end logic;

