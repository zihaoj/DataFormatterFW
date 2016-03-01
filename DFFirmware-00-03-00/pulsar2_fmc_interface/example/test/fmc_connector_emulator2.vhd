------------------------------------------------------------------------------
-- PulsarIIb
-- fmc_connector_emulator2 emulates the P/N swap on the FMC connector
-- fmc_connector_emulator   : emulate connector and output is separated for FPGA0/FPGA1
-- fmc_connector_emulator2  : emulate connector and output is merged for FPGA0/FPGA1
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.FmcConstants.all;

entity fmc_connector_emulator2 is
  generic (
    FMC_ID : integer -- 1/2/3/4
    );
  port (
    fpga0_p_din  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
    fpga0_n_din  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
    fpga1_p_din  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
    fpga1_n_din  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
    p_dout    : out std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
    n_dout    : out std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
    clk0_p_in : in  std_logic;
    clk0_n_in : in  std_logic;
    clk0_p_out: out std_logic;
    clk0_n_out: out std_logic;
    clk1_p_in : in  std_logic;
    clk1_n_in : in  std_logic;
    clk1_p_out: out std_logic;
    clk1_n_out: out std_logic);
end fmc_connector_emulator2;

architecture logic of fmc_connector_emulator2 is
  constant FPGA0_ID : integer := (FMC_ID-1)*2 + 0;
  constant FPGA1_ID : integer := (FMC_ID-1)*2 + 1;
  constant rx_swap_mask_channel_in_the_fpga0 : std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0) := rx_swap_mask_channel_in_fpga(FPGA0_ID);
  constant rx_swap_mask_channel_in_the_fpga1 : std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0) := rx_swap_mask_channel_in_fpga(FPGA1_ID);
begin
  -- FB1
  clk0_p_out <= clk0_p_in xor swap_mask_clk(FPGA0_ID);
  clk0_n_out <= clk0_n_in xor swap_mask_clk(FPGA0_ID);
  clk1_p_out <= clk1_p_in xor swap_mask_clk(FPGA1_ID);
  clk1_n_out <= clk1_n_in xor swap_mask_clk(FPGA1_ID);
  
  FPGA0_pins : for iChan in 0 to lvds_pairs_for_rx_in_each_fpga-1 generate
    constant bis_pos_in_fmc : integer := rx_fmc_to_fpga0_bit_mapping(iChan);
  begin
    p_dout(bis_pos_in_fmc) <= fpga0_p_din(iChan) xor rx_swap_mask_channel_in_the_fpga0(iChan);
    n_dout(bis_pos_in_fmc) <= fpga0_n_din(iChan) xor rx_swap_mask_channel_in_the_fpga0(iChan);
  end generate;
  
  FPGA1_pins : for iChan in 0 to lvds_pairs_for_rx_in_each_fpga-1 generate
    constant bis_pos_in_fmc : integer := rx_fmc_to_fpga1_bit_mapping(iChan);
  begin
    p_dout(bis_pos_in_fmc) <= fpga1_p_din(iChan) xor rx_swap_mask_channel_in_the_fpga1(iChan);
    n_dout(bis_pos_in_fmc) <= fpga1_n_din(iChan) xor rx_swap_mask_channel_in_the_fpga1(iChan);
  end generate;  
  
end logic;
