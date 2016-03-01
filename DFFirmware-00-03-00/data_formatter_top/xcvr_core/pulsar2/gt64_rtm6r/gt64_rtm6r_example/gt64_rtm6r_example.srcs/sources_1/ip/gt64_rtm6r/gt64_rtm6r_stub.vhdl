-- Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2014.2 (win64) Build 928826 Thu Jun  5 18:17:50 MDT 2014
-- Date        : Wed Aug 13 02:48:28 2014
-- Host        : PC-UC-FTK-FW running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/cygwin64/home/okumura/firmware_vivado/ipcore/xc7vx690t-ffg1927-2/gt64_rtm6r/gt64_rtm6r_stub.vhdl
-- Design      : gt64_rtm6r
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gt64_rtm6r is
  Port ( 
    SYSCLK_IN : in STD_LOGIC;
    SOFT_RESET_IN : in STD_LOGIC;
    DONT_RESET_ON_DATA_ERROR_IN : in STD_LOGIC;
    GT0_TX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT0_RX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT0_DATA_VALID_IN : in STD_LOGIC;
    GT1_TX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT1_RX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT1_DATA_VALID_IN : in STD_LOGIC;
    GT2_TX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT2_RX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT2_DATA_VALID_IN : in STD_LOGIC;
    GT3_TX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT3_RX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT3_DATA_VALID_IN : in STD_LOGIC;
    GT4_TX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT4_RX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT4_DATA_VALID_IN : in STD_LOGIC;
    GT5_TX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT5_RX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT5_DATA_VALID_IN : in STD_LOGIC;
    gt0_cpllfbclklost_out : out STD_LOGIC;
    gt0_cplllock_out : out STD_LOGIC;
    gt0_cplllockdetclk_in : in STD_LOGIC;
    gt0_cpllreset_in : in STD_LOGIC;
    gt0_gtrefclk0_in : in STD_LOGIC;
    gt0_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt0_drpclk_in : in STD_LOGIC;
    gt0_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpen_in : in STD_LOGIC;
    gt0_drprdy_out : out STD_LOGIC;
    gt0_drpwe_in : in STD_LOGIC;
    gt0_eyescanreset_in : in STD_LOGIC;
    gt0_rxuserrdy_in : in STD_LOGIC;
    gt0_eyescandataerror_out : out STD_LOGIC;
    gt0_eyescantrigger_in : in STD_LOGIC;
    gt0_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt0_rxusrclk_in : in STD_LOGIC;
    gt0_rxusrclk2_in : in STD_LOGIC;
    gt0_rxdata_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt0_rxdisperr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxnotintable_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_gthrxn_in : in STD_LOGIC;
    gt0_rxbyteisaligned_out : out STD_LOGIC;
    gt0_rxmcommaalignen_in : in STD_LOGIC;
    gt0_rxpcommaalignen_in : in STD_LOGIC;
    gt0_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt0_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_gtrxreset_in : in STD_LOGIC;
    gt0_rxpolarity_in : in STD_LOGIC;
    gt0_rxcharisk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_gthrxp_in : in STD_LOGIC;
    gt0_rxresetdone_out : out STD_LOGIC;
    gt0_gttxreset_in : in STD_LOGIC;
    gt0_txuserrdy_in : in STD_LOGIC;
    gt0_txusrclk_in : in STD_LOGIC;
    gt0_txusrclk2_in : in STD_LOGIC;
    gt0_txdata_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt0_gthtxn_out : out STD_LOGIC;
    gt0_gthtxp_out : out STD_LOGIC;
    gt0_txoutclk_out : out STD_LOGIC;
    gt0_txoutclkfabric_out : out STD_LOGIC;
    gt0_txoutclkpcs_out : out STD_LOGIC;
    gt0_txresetdone_out : out STD_LOGIC;
    gt0_txpolarity_in : in STD_LOGIC;
    gt0_txcharisk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_cpllfbclklost_out : out STD_LOGIC;
    gt1_cplllock_out : out STD_LOGIC;
    gt1_cplllockdetclk_in : in STD_LOGIC;
    gt1_cpllreset_in : in STD_LOGIC;
    gt1_gtrefclk0_in : in STD_LOGIC;
    gt1_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt1_drpclk_in : in STD_LOGIC;
    gt1_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt1_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt1_drpen_in : in STD_LOGIC;
    gt1_drprdy_out : out STD_LOGIC;
    gt1_drpwe_in : in STD_LOGIC;
    gt1_eyescanreset_in : in STD_LOGIC;
    gt1_rxuserrdy_in : in STD_LOGIC;
    gt1_eyescandataerror_out : out STD_LOGIC;
    gt1_eyescantrigger_in : in STD_LOGIC;
    gt1_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt1_rxusrclk_in : in STD_LOGIC;
    gt1_rxusrclk2_in : in STD_LOGIC;
    gt1_rxdata_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt1_rxdisperr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_rxnotintable_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_gthrxn_in : in STD_LOGIC;
    gt1_rxbyteisaligned_out : out STD_LOGIC;
    gt1_rxmcommaalignen_in : in STD_LOGIC;
    gt1_rxpcommaalignen_in : in STD_LOGIC;
    gt1_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt1_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt1_gtrxreset_in : in STD_LOGIC;
    gt1_rxpolarity_in : in STD_LOGIC;
    gt1_rxcharisk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_gthrxp_in : in STD_LOGIC;
    gt1_rxresetdone_out : out STD_LOGIC;
    gt1_gttxreset_in : in STD_LOGIC;
    gt1_txuserrdy_in : in STD_LOGIC;
    gt1_txusrclk_in : in STD_LOGIC;
    gt1_txusrclk2_in : in STD_LOGIC;
    gt1_txdata_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt1_gthtxn_out : out STD_LOGIC;
    gt1_gthtxp_out : out STD_LOGIC;
    gt1_txoutclk_out : out STD_LOGIC;
    gt1_txoutclkfabric_out : out STD_LOGIC;
    gt1_txoutclkpcs_out : out STD_LOGIC;
    gt1_txresetdone_out : out STD_LOGIC;
    gt1_txpolarity_in : in STD_LOGIC;
    gt1_txcharisk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_cpllfbclklost_out : out STD_LOGIC;
    gt2_cplllock_out : out STD_LOGIC;
    gt2_cplllockdetclk_in : in STD_LOGIC;
    gt2_cpllreset_in : in STD_LOGIC;
    gt2_gtrefclk0_in : in STD_LOGIC;
    gt2_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt2_drpclk_in : in STD_LOGIC;
    gt2_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt2_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt2_drpen_in : in STD_LOGIC;
    gt2_drprdy_out : out STD_LOGIC;
    gt2_drpwe_in : in STD_LOGIC;
    gt2_eyescanreset_in : in STD_LOGIC;
    gt2_rxuserrdy_in : in STD_LOGIC;
    gt2_eyescandataerror_out : out STD_LOGIC;
    gt2_eyescantrigger_in : in STD_LOGIC;
    gt2_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt2_rxusrclk_in : in STD_LOGIC;
    gt2_rxusrclk2_in : in STD_LOGIC;
    gt2_rxdata_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt2_rxdisperr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_rxnotintable_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_gthrxn_in : in STD_LOGIC;
    gt2_rxbyteisaligned_out : out STD_LOGIC;
    gt2_rxmcommaalignen_in : in STD_LOGIC;
    gt2_rxpcommaalignen_in : in STD_LOGIC;
    gt2_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt2_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt2_gtrxreset_in : in STD_LOGIC;
    gt2_rxpolarity_in : in STD_LOGIC;
    gt2_rxcharisk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_gthrxp_in : in STD_LOGIC;
    gt2_rxresetdone_out : out STD_LOGIC;
    gt2_gttxreset_in : in STD_LOGIC;
    gt2_txuserrdy_in : in STD_LOGIC;
    gt2_txusrclk_in : in STD_LOGIC;
    gt2_txusrclk2_in : in STD_LOGIC;
    gt2_txdata_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt2_gthtxn_out : out STD_LOGIC;
    gt2_gthtxp_out : out STD_LOGIC;
    gt2_txoutclk_out : out STD_LOGIC;
    gt2_txoutclkfabric_out : out STD_LOGIC;
    gt2_txoutclkpcs_out : out STD_LOGIC;
    gt2_txresetdone_out : out STD_LOGIC;
    gt2_txpolarity_in : in STD_LOGIC;
    gt2_txcharisk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_cpllfbclklost_out : out STD_LOGIC;
    gt3_cplllock_out : out STD_LOGIC;
    gt3_cplllockdetclk_in : in STD_LOGIC;
    gt3_cpllreset_in : in STD_LOGIC;
    gt3_gtrefclk0_in : in STD_LOGIC;
    gt3_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt3_drpclk_in : in STD_LOGIC;
    gt3_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt3_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt3_drpen_in : in STD_LOGIC;
    gt3_drprdy_out : out STD_LOGIC;
    gt3_drpwe_in : in STD_LOGIC;
    gt3_eyescanreset_in : in STD_LOGIC;
    gt3_rxuserrdy_in : in STD_LOGIC;
    gt3_eyescandataerror_out : out STD_LOGIC;
    gt3_eyescantrigger_in : in STD_LOGIC;
    gt3_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt3_rxusrclk_in : in STD_LOGIC;
    gt3_rxusrclk2_in : in STD_LOGIC;
    gt3_rxdata_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt3_rxdisperr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_rxnotintable_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_gthrxn_in : in STD_LOGIC;
    gt3_rxbyteisaligned_out : out STD_LOGIC;
    gt3_rxmcommaalignen_in : in STD_LOGIC;
    gt3_rxpcommaalignen_in : in STD_LOGIC;
    gt3_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt3_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt3_gtrxreset_in : in STD_LOGIC;
    gt3_rxpolarity_in : in STD_LOGIC;
    gt3_rxcharisk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_gthrxp_in : in STD_LOGIC;
    gt3_rxresetdone_out : out STD_LOGIC;
    gt3_gttxreset_in : in STD_LOGIC;
    gt3_txuserrdy_in : in STD_LOGIC;
    gt3_txusrclk_in : in STD_LOGIC;
    gt3_txusrclk2_in : in STD_LOGIC;
    gt3_txdata_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt3_gthtxn_out : out STD_LOGIC;
    gt3_gthtxp_out : out STD_LOGIC;
    gt3_txoutclk_out : out STD_LOGIC;
    gt3_txoutclkfabric_out : out STD_LOGIC;
    gt3_txoutclkpcs_out : out STD_LOGIC;
    gt3_txresetdone_out : out STD_LOGIC;
    gt3_txpolarity_in : in STD_LOGIC;
    gt3_txcharisk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt4_cpllfbclklost_out : out STD_LOGIC;
    gt4_cplllock_out : out STD_LOGIC;
    gt4_cplllockdetclk_in : in STD_LOGIC;
    gt4_cpllreset_in : in STD_LOGIC;
    gt4_gtrefclk0_in : in STD_LOGIC;
    gt4_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt4_drpclk_in : in STD_LOGIC;
    gt4_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt4_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt4_drpen_in : in STD_LOGIC;
    gt4_drprdy_out : out STD_LOGIC;
    gt4_drpwe_in : in STD_LOGIC;
    gt4_eyescanreset_in : in STD_LOGIC;
    gt4_rxuserrdy_in : in STD_LOGIC;
    gt4_eyescandataerror_out : out STD_LOGIC;
    gt4_eyescantrigger_in : in STD_LOGIC;
    gt4_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt4_rxusrclk_in : in STD_LOGIC;
    gt4_rxusrclk2_in : in STD_LOGIC;
    gt4_rxdata_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt4_rxdisperr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt4_rxnotintable_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt4_gthrxn_in : in STD_LOGIC;
    gt4_rxbyteisaligned_out : out STD_LOGIC;
    gt4_rxmcommaalignen_in : in STD_LOGIC;
    gt4_rxpcommaalignen_in : in STD_LOGIC;
    gt4_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt4_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt4_gtrxreset_in : in STD_LOGIC;
    gt4_rxpolarity_in : in STD_LOGIC;
    gt4_rxcharisk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt4_gthrxp_in : in STD_LOGIC;
    gt4_rxresetdone_out : out STD_LOGIC;
    gt4_gttxreset_in : in STD_LOGIC;
    gt4_txuserrdy_in : in STD_LOGIC;
    gt4_txusrclk_in : in STD_LOGIC;
    gt4_txusrclk2_in : in STD_LOGIC;
    gt4_txdata_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt4_gthtxn_out : out STD_LOGIC;
    gt4_gthtxp_out : out STD_LOGIC;
    gt4_txoutclk_out : out STD_LOGIC;
    gt4_txoutclkfabric_out : out STD_LOGIC;
    gt4_txoutclkpcs_out : out STD_LOGIC;
    gt4_txresetdone_out : out STD_LOGIC;
    gt4_txpolarity_in : in STD_LOGIC;
    gt4_txcharisk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt5_cpllfbclklost_out : out STD_LOGIC;
    gt5_cplllock_out : out STD_LOGIC;
    gt5_cplllockdetclk_in : in STD_LOGIC;
    gt5_cpllreset_in : in STD_LOGIC;
    gt5_gtrefclk0_in : in STD_LOGIC;
    gt5_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt5_drpclk_in : in STD_LOGIC;
    gt5_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt5_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt5_drpen_in : in STD_LOGIC;
    gt5_drprdy_out : out STD_LOGIC;
    gt5_drpwe_in : in STD_LOGIC;
    gt5_eyescanreset_in : in STD_LOGIC;
    gt5_rxuserrdy_in : in STD_LOGIC;
    gt5_eyescandataerror_out : out STD_LOGIC;
    gt5_eyescantrigger_in : in STD_LOGIC;
    gt5_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt5_rxusrclk_in : in STD_LOGIC;
    gt5_rxusrclk2_in : in STD_LOGIC;
    gt5_rxdata_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt5_rxdisperr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt5_rxnotintable_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt5_gthrxn_in : in STD_LOGIC;
    gt5_rxbyteisaligned_out : out STD_LOGIC;
    gt5_rxmcommaalignen_in : in STD_LOGIC;
    gt5_rxpcommaalignen_in : in STD_LOGIC;
    gt5_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt5_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt5_gtrxreset_in : in STD_LOGIC;
    gt5_rxpolarity_in : in STD_LOGIC;
    gt5_rxcharisk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt5_gthrxp_in : in STD_LOGIC;
    gt5_rxresetdone_out : out STD_LOGIC;
    gt5_gttxreset_in : in STD_LOGIC;
    gt5_txuserrdy_in : in STD_LOGIC;
    gt5_txusrclk_in : in STD_LOGIC;
    gt5_txusrclk2_in : in STD_LOGIC;
    gt5_txdata_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt5_gthtxn_out : out STD_LOGIC;
    gt5_gthtxp_out : out STD_LOGIC;
    gt5_txoutclk_out : out STD_LOGIC;
    gt5_txoutclkfabric_out : out STD_LOGIC;
    gt5_txoutclkpcs_out : out STD_LOGIC;
    gt5_txresetdone_out : out STD_LOGIC;
    gt5_txpolarity_in : in STD_LOGIC;
    gt5_txcharisk_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    GT0_QPLLOUTCLK_IN : in STD_LOGIC;
    GT0_QPLLOUTREFCLK_IN : in STD_LOGIC;
    GT1_QPLLOUTCLK_IN : in STD_LOGIC;
    GT1_QPLLOUTREFCLK_IN : in STD_LOGIC
  );

end gt64_rtm6r;

architecture stub of gt64_rtm6r is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "SYSCLK_IN,SOFT_RESET_IN,DONT_RESET_ON_DATA_ERROR_IN,GT0_TX_FSM_RESET_DONE_OUT,GT0_RX_FSM_RESET_DONE_OUT,GT0_DATA_VALID_IN,GT1_TX_FSM_RESET_DONE_OUT,GT1_RX_FSM_RESET_DONE_OUT,GT1_DATA_VALID_IN,GT2_TX_FSM_RESET_DONE_OUT,GT2_RX_FSM_RESET_DONE_OUT,GT2_DATA_VALID_IN,GT3_TX_FSM_RESET_DONE_OUT,GT3_RX_FSM_RESET_DONE_OUT,GT3_DATA_VALID_IN,GT4_TX_FSM_RESET_DONE_OUT,GT4_RX_FSM_RESET_DONE_OUT,GT4_DATA_VALID_IN,GT5_TX_FSM_RESET_DONE_OUT,GT5_RX_FSM_RESET_DONE_OUT,GT5_DATA_VALID_IN,gt0_cpllfbclklost_out,gt0_cplllock_out,gt0_cplllockdetclk_in,gt0_cpllreset_in,gt0_gtrefclk0_in,gt0_drpaddr_in[8:0],gt0_drpclk_in,gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_eyescanreset_in,gt0_rxuserrdy_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_dmonitorout_out[14:0],gt0_rxusrclk_in,gt0_rxusrclk2_in,gt0_rxdata_out[31:0],gt0_rxdisperr_out[3:0],gt0_rxnotintable_out[3:0],gt0_gthrxn_in,gt0_rxbyteisaligned_out,gt0_rxmcommaalignen_in,gt0_rxpcommaalignen_in,gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],gt0_gtrxreset_in,gt0_rxpolarity_in,gt0_rxcharisk_out[3:0],gt0_gthrxp_in,gt0_rxresetdone_out,gt0_gttxreset_in,gt0_txuserrdy_in,gt0_txusrclk_in,gt0_txusrclk2_in,gt0_txdata_in[31:0],gt0_gthtxn_out,gt0_gthtxp_out,gt0_txoutclk_out,gt0_txoutclkfabric_out,gt0_txoutclkpcs_out,gt0_txresetdone_out,gt0_txpolarity_in,gt0_txcharisk_in[3:0],gt1_cpllfbclklost_out,gt1_cplllock_out,gt1_cplllockdetclk_in,gt1_cpllreset_in,gt1_gtrefclk0_in,gt1_drpaddr_in[8:0],gt1_drpclk_in,gt1_drpdi_in[15:0],gt1_drpdo_out[15:0],gt1_drpen_in,gt1_drprdy_out,gt1_drpwe_in,gt1_eyescanreset_in,gt1_rxuserrdy_in,gt1_eyescandataerror_out,gt1_eyescantrigger_in,gt1_dmonitorout_out[14:0],gt1_rxusrclk_in,gt1_rxusrclk2_in,gt1_rxdata_out[31:0],gt1_rxdisperr_out[3:0],gt1_rxnotintable_out[3:0],gt1_gthrxn_in,gt1_rxbyteisaligned_out,gt1_rxmcommaalignen_in,gt1_rxpcommaalignen_in,gt1_rxmonitorout_out[6:0],gt1_rxmonitorsel_in[1:0],gt1_gtrxreset_in,gt1_rxpolarity_in,gt1_rxcharisk_out[3:0],gt1_gthrxp_in,gt1_rxresetdone_out,gt1_gttxreset_in,gt1_txuserrdy_in,gt1_txusrclk_in,gt1_txusrclk2_in,gt1_txdata_in[31:0],gt1_gthtxn_out,gt1_gthtxp_out,gt1_txoutclk_out,gt1_txoutclkfabric_out,gt1_txoutclkpcs_out,gt1_txresetdone_out,gt1_txpolarity_in,gt1_txcharisk_in[3:0],gt2_cpllfbclklost_out,gt2_cplllock_out,gt2_cplllockdetclk_in,gt2_cpllreset_in,gt2_gtrefclk0_in,gt2_drpaddr_in[8:0],gt2_drpclk_in,gt2_drpdi_in[15:0],gt2_drpdo_out[15:0],gt2_drpen_in,gt2_drprdy_out,gt2_drpwe_in,gt2_eyescanreset_in,gt2_rxuserrdy_in,gt2_eyescandataerror_out,gt2_eyescantrigger_in,gt2_dmonitorout_out[14:0],gt2_rxusrclk_in,gt2_rxusrclk2_in,gt2_rxdata_out[31:0],gt2_rxdisperr_out[3:0],gt2_rxnotintable_out[3:0],gt2_gthrxn_in,gt2_rxbyteisaligned_out,gt2_rxmcommaalignen_in,gt2_rxpcommaalignen_in,gt2_rxmonitorout_out[6:0],gt2_rxmonitorsel_in[1:0],gt2_gtrxreset_in,gt2_rxpolarity_in,gt2_rxcharisk_out[3:0],gt2_gthrxp_in,gt2_rxresetdone_out,gt2_gttxreset_in,gt2_txuserrdy_in,gt2_txusrclk_in,gt2_txusrclk2_in,gt2_txdata_in[31:0],gt2_gthtxn_out,gt2_gthtxp_out,gt2_txoutclk_out,gt2_txoutclkfabric_out,gt2_txoutclkpcs_out,gt2_txresetdone_out,gt2_txpolarity_in,gt2_txcharisk_in[3:0],gt3_cpllfbclklost_out,gt3_cplllock_out,gt3_cplllockdetclk_in,gt3_cpllreset_in,gt3_gtrefclk0_in,gt3_drpaddr_in[8:0],gt3_drpclk_in,gt3_drpdi_in[15:0],gt3_drpdo_out[15:0],gt3_drpen_in,gt3_drprdy_out,gt3_drpwe_in,gt3_eyescanreset_in,gt3_rxuserrdy_in,gt3_eyescandataerror_out,gt3_eyescantrigger_in,gt3_dmonitorout_out[14:0],gt3_rxusrclk_in,gt3_rxusrclk2_in,gt3_rxdata_out[31:0],gt3_rxdisperr_out[3:0],gt3_rxnotintable_out[3:0],gt3_gthrxn_in,gt3_rxbyteisaligned_out,gt3_rxmcommaalignen_in,gt3_rxpcommaalignen_in,gt3_rxmonitorout_out[6:0],gt3_rxmonitorsel_in[1:0],gt3_gtrxreset_in,gt3_rxpolarity_in,gt3_rxcharisk_out[3:0],gt3_gthrxp_in,gt3_rxresetdone_out,gt3_gttxreset_in,gt3_txuserrdy_in,gt3_txusrclk_in,gt3_txusrclk2_in,gt3_txdata_in[31:0],gt3_gthtxn_out,gt3_gthtxp_out,gt3_txoutclk_out,gt3_txoutclkfabric_out,gt3_txoutclkpcs_out,gt3_txresetdone_out,gt3_txpolarity_in,gt3_txcharisk_in[3:0],gt4_cpllfbclklost_out,gt4_cplllock_out,gt4_cplllockdetclk_in,gt4_cpllreset_in,gt4_gtrefclk0_in,gt4_drpaddr_in[8:0],gt4_drpclk_in,gt4_drpdi_in[15:0],gt4_drpdo_out[15:0],gt4_drpen_in,gt4_drprdy_out,gt4_drpwe_in,gt4_eyescanreset_in,gt4_rxuserrdy_in,gt4_eyescandataerror_out,gt4_eyescantrigger_in,gt4_dmonitorout_out[14:0],gt4_rxusrclk_in,gt4_rxusrclk2_in,gt4_rxdata_out[31:0],gt4_rxdisperr_out[3:0],gt4_rxnotintable_out[3:0],gt4_gthrxn_in,gt4_rxbyteisaligned_out,gt4_rxmcommaalignen_in,gt4_rxpcommaalignen_in,gt4_rxmonitorout_out[6:0],gt4_rxmonitorsel_in[1:0],gt4_gtrxreset_in,gt4_rxpolarity_in,gt4_rxcharisk_out[3:0],gt4_gthrxp_in,gt4_rxresetdone_out,gt4_gttxreset_in,gt4_txuserrdy_in,gt4_txusrclk_in,gt4_txusrclk2_in,gt4_txdata_in[31:0],gt4_gthtxn_out,gt4_gthtxp_out,gt4_txoutclk_out,gt4_txoutclkfabric_out,gt4_txoutclkpcs_out,gt4_txresetdone_out,gt4_txpolarity_in,gt4_txcharisk_in[3:0],gt5_cpllfbclklost_out,gt5_cplllock_out,gt5_cplllockdetclk_in,gt5_cpllreset_in,gt5_gtrefclk0_in,gt5_drpaddr_in[8:0],gt5_drpclk_in,gt5_drpdi_in[15:0],gt5_drpdo_out[15:0],gt5_drpen_in,gt5_drprdy_out,gt5_drpwe_in,gt5_eyescanreset_in,gt5_rxuserrdy_in,gt5_eyescandataerror_out,gt5_eyescantrigger_in,gt5_dmonitorout_out[14:0],gt5_rxusrclk_in,gt5_rxusrclk2_in,gt5_rxdata_out[31:0],gt5_rxdisperr_out[3:0],gt5_rxnotintable_out[3:0],gt5_gthrxn_in,gt5_rxbyteisaligned_out,gt5_rxmcommaalignen_in,gt5_rxpcommaalignen_in,gt5_rxmonitorout_out[6:0],gt5_rxmonitorsel_in[1:0],gt5_gtrxreset_in,gt5_rxpolarity_in,gt5_rxcharisk_out[3:0],gt5_gthrxp_in,gt5_rxresetdone_out,gt5_gttxreset_in,gt5_txuserrdy_in,gt5_txusrclk_in,gt5_txusrclk2_in,gt5_txdata_in[31:0],gt5_gthtxn_out,gt5_gthtxp_out,gt5_txoutclk_out,gt5_txoutclkfabric_out,gt5_txoutclkpcs_out,gt5_txresetdone_out,gt5_txpolarity_in,gt5_txcharisk_in[3:0],GT0_QPLLOUTCLK_IN,GT0_QPLLOUTREFCLK_IN,GT1_QPLLOUTCLK_IN,GT1_QPLLOUTREFCLK_IN";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "gt64_rtm6r,gtwizard_v3_3,{protocol_file=Start_from_scratch}";
begin
end;
