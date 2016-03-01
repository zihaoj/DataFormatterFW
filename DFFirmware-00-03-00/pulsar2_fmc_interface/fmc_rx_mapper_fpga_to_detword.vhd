------------------------------------------------------------------------------
-- PulsarIIb
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.FmcConstants.all;

entity fmc_rx_mapper_fpga_to_detword is
  port (
    FRONT_TO_MAPPER_DIN      : in  std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
    MAPPER_TO_FRAME_SCT_DATA : out std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
    MAPPER_TO_FRAME_SCT_CTRL : out std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
    MAPPER_TO_FRAME_PIX_DATA : out std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
    MAPPER_TO_FRAME_PIX_CTRL : out std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0)
    );
end fmc_rx_mapper_fpga_to_detword;

architecture logic of fmc_rx_mapper_fpga_to_detword is

begin
  
  -- pix data
  FORM_PIX_DATA_FROM_FPGA : for iBit in 0 to data_width_in_each_clockcycle-1 generate
    constant bit_pos_in_word : integer := detword_to_data_bit_mapping(iBit);
    constant bit_pos_in_fpga : integer := fpga_to_pixword_bit_mapping(bit_pos_in_word);
  begin
    MAPPER_TO_FRAME_PIX_DATA(iBit) <= FRONT_TO_MAPPER_DIN(bit_pos_in_fpga);
  end generate;
  
  -- pix ctrl
  FORM_PIX_CTRL_FROM_FPGA : for iBit in 0 to ctrl_width_in_each_clockcycle-1 generate
    constant bit_pos_in_word : integer := detword_to_ctrl_bit_mapping(iBit);
    constant bit_pos_in_fpga : integer := fpga_to_pixword_bit_mapping(bit_pos_in_word);
  begin
    MAPPER_TO_FRAME_PIX_CTRL(iBit) <= FRONT_TO_MAPPER_DIN(bit_pos_in_fpga);
  end generate;
  
  -- sct data
  FORM_SCT_DATA_FROM_FPGA : for iBit in 0 to data_width_in_each_clockcycle-1 generate
    constant bit_pos_in_word : integer := detword_to_data_bit_mapping(iBit);
    constant bit_pos_in_fpga : integer := fpga_to_sctword_bit_mapping(bit_pos_in_word);
  begin
    MAPPER_TO_FRAME_SCT_DATA(iBit) <= FRONT_TO_MAPPER_DIN(bit_pos_in_fpga);
  end generate;
  
  -- sct ctrl
  FORM_SCT_CTRL_FROM_FPGA : for iBit in 0 to ctrl_width_in_each_clockcycle-1 generate
    constant bit_pos_in_word : integer := detword_to_ctrl_bit_mapping(iBit);
    constant bit_pos_in_fpga : integer := fpga_to_sctword_bit_mapping(bit_pos_in_word);
  begin
    MAPPER_TO_FRAME_SCT_CTRL(iBit) <= FRONT_TO_MAPPER_DIN(bit_pos_in_fpga);
  end generate;
  
end logic;

