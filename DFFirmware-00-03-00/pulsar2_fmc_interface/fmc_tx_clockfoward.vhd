------------------------------------------------------------------------------
-- PulsarII
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.FmcConstants.all;

entity fmc_tx_clockforward is
  generic
    ( FMC_ID  : integer);  
  port
    (
      -- READOUT CLOCK
      FMC_COMMON_CLK : in std_logic;
      --
      FMCOUT_LVDS_CLOCKFORWARD_OUT_P : out std_logic;
      FMCOUT_LVDS_CLOCKFORWARD_OUT_N : out std_logic);
end fmc_tx_clockforward;

architecture logic of fmc_tx_clockforward is
  constant iFMC : integer := FMC_ID-1;
  signal clk_ddr_out : std_logic;
  signal clk_in_buf  : std_logic;
  constant ddr_clk_pos : std_logic := not swap_mask_tx_clk_forward(iFMC);
  constant ddr_clk_neg : std_logic := swap_mask_tx_clk_forward(iFMC);
  
begin
  
  ODDR_inst : ODDR
    generic map(
      DDR_CLK_EDGE => "OPPOSITE_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
      INIT => '0', -- Initial value for Q port ('1' or '0')
      SRTYPE => "SYNC") -- Reset Type ("ASYNC" or "SYNC")
    port map (
      Q => clk_ddr_out, -- 1-bit DDR output
      C =>  FMC_COMMON_CLK, -- 1-bit clock input
      CE => '1',
      D1 => ddr_clk_pos,
      D2 => ddr_clk_neg,
      R => '0',
      S => '0'
      );
  
  clk_fwd : OBUFDS
    generic map
    (IOSTANDARD => FMC_BANK_IOSTANDARD)
    port map
    ( I  => clk_ddr_out,
      O  => FMCOUT_LVDS_CLOCKFORWARD_OUT_P,
      OB => FMCOUT_LVDS_CLOCKFORWARD_OUT_N
      );
  
end logic;
