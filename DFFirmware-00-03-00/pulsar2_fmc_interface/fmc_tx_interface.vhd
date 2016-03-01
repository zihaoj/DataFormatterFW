------------------------------------------------------------------------------
-- PulsarII
-- NO DDR decoding version
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.FmcConstants.all;

entity fmc_tx_interface is
  generic
    ( FMC_ID  : integer;
      FPGA_ID : integer);
  port
    (
      -- READOUT CLOCK
      FMC_COMMON_CLK : in std_logic;
      
      -- USER Interface
      FMC_SPY_BUFFER_FREEZE_IN : in std_logic := '0';
      FMC_SCT_BUSY_IN          : in std_logic := '0';
      FMC_PIX_BUSY_IN          : in std_logic := '0';
      --
      FMCOUT_LVDS_DATA_OUT_P : out std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0);
      FMCOUT_LVDS_DATA_OUT_N : out std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1  downto 0)
      );
end fmc_tx_interface;

architecture logic of fmc_tx_interface is
  constant npins_for_tx : integer := lvds_pairs_for_tx_in_each_fpga;
  -- r1/r2 to satisfy the timine requirement -- Nina added r3 to satisfy timing
  signal data_bus_r3 : std_logic_vector(npins_for_tx-1 downto 0);  -- Nina added
  signal data_bus_r2 : std_logic_vector(npins_for_tx-1 downto 0);
  signal data_bus_r1 : std_logic_vector(npins_for_tx-1 downto 0);
  signal output_buf_i       : std_logic_vector(npins_for_tx-1 downto 0);
  constant iFPGA : integer := (FMC_ID-1)*2+FPGA_ID;
  constant swap_mask_of_this_fpga : std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0)
    := tx_swap_mask_channel_in_fpga(iFPGA);
  
begin

  process (FMC_COMMON_CLK)
  begin
    if (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      data_bus_r3 <= data_bus_r2; -- Nina added for buffering purpose
      data_bus_r2 <= data_bus_r1;
      
      data_bus_r1(bitpos_in_txline_spy_freeze) <= FMC_SPY_BUFFER_FREEZE_IN;
      data_bus_r1(bitpos_in_txline_sct_hold) <= FMC_SCT_BUSY_IN;
      data_bus_r1(bitpos_in_txline_pix_hold) <= FMC_PIX_BUSY_IN;
    end if;
  end process;
  
  OUT_PINS: for iPins in 0 to npins_for_tx-1 generate
    signal   data_bit : std_logic;
  begin
    
    data_bit <= data_bus_r3(iPins) xor swap_mask_of_this_fpga(iPins); -- Nina
                                                                      -- changed
                                                                      -- data_bus_r2
                                                                      -- to data_bus_r3
    
    pinout : OBUFDS
      generic map
      (IOSTANDARD => FMC_BANK_IOSTANDARD)
      port map
      ( I  => data_bit,
        O  => FMCOUT_LVDS_DATA_OUT_P(iPins),
        OB => FMCOUT_LVDS_DATA_OUT_N(iPins));    
  end generate;
  
end logic;
