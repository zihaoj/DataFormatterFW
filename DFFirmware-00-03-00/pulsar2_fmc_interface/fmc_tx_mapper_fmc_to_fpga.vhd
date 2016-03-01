------------------------------------------------------------------------------
-- PulsarIIb
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.FmcConstants.all;

entity fmc_tx_mapper_fmc_to_fpga is
  port (
    dout      : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    din_fpga0 : in  std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0);
    din_fpga1 : in  std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0)
    );
end fmc_tx_mapper_fmc_to_fpga;

architecture logic of fmc_tx_mapper_fmc_to_fpga is

begin
  
  pins_fpga0 : for ipin in 0 to lvds_pairs_for_tx_in_each_fpga-1 generate
  begin
    dout(tx_fmc_to_fpga0_bit_mapping(ipin)) <= din_fpga0(ipin);
  end generate;

  pins_fpga1 : for ipin in 0 to lvds_pairs_for_tx_in_each_fpga-1 generate
  begin
    dout(tx_fmc_to_fpga1_bit_mapping(ipin)) <= din_fpga1(ipin);
  end generate;  
  
end logic;

