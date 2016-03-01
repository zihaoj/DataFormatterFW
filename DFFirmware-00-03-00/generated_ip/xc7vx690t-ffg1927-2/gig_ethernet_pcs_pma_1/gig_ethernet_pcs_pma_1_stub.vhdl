-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
-- Date        : Tue Feb 23 09:44:13 2016
-- Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
-- Command     : write_vhdl -force -mode synth_stub
--               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/gig_ethernet_pcs_pma_1/gig_ethernet_pcs_pma_1_stub.vhdl
-- Design      : gig_ethernet_pcs_pma_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gig_ethernet_pcs_pma_1 is
  Port ( 
    gtrefclk : in STD_LOGIC;
    gtrefclk_bufg : in STD_LOGIC;
    txp : out STD_LOGIC;
    txn : out STD_LOGIC;
    rxp : in STD_LOGIC;
    rxn : in STD_LOGIC;
    resetdone : out STD_LOGIC;
    cplllock : out STD_LOGIC;
    mmcm_reset : out STD_LOGIC;
    txoutclk : out STD_LOGIC;
    rxoutclk : out STD_LOGIC;
    userclk : in STD_LOGIC;
    userclk2 : in STD_LOGIC;
    rxuserclk : in STD_LOGIC;
    rxuserclk2 : in STD_LOGIC;
    pma_reset : in STD_LOGIC;
    mmcm_locked : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    gmii_txd : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en : in STD_LOGIC;
    gmii_tx_er : in STD_LOGIC;
    gmii_rxd : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv : out STD_LOGIC;
    gmii_rx_er : out STD_LOGIC;
    gmii_isolate : out STD_LOGIC;
    configuration_vector : in STD_LOGIC_VECTOR ( 4 downto 0 );
    an_interrupt : out STD_LOGIC;
    an_adv_config_vector : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_restart_config : in STD_LOGIC;
    status_vector : out STD_LOGIC_VECTOR ( 15 downto 0 );
    reset : in STD_LOGIC;
    gt0_txpmareset_in : in STD_LOGIC;
    gt0_txpcsreset_in : in STD_LOGIC;
    gt0_rxpmareset_in : in STD_LOGIC;
    gt0_rxpcsreset_in : in STD_LOGIC;
    gt0_rxbufreset_in : in STD_LOGIC;
    gt0_rxpmaresetdone_out : out STD_LOGIC;
    gt0_rxbufstatus_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_txbufstatus_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_dmonitorout_out : out STD_LOGIC_VECTOR ( 14 downto 0 );
    gt0_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt0_drpclk_in : in STD_LOGIC;
    gt0_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpen_in : in STD_LOGIC;
    gt0_drprdy_out : out STD_LOGIC;
    gt0_drpwe_in : in STD_LOGIC;
    gt0_rxchariscomma_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_rxcharisk_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_rxbyteisaligned_out : out STD_LOGIC;
    gt0_rxbyterealign_out : out STD_LOGIC;
    gt0_rxcommadet_out : out STD_LOGIC;
    gt0_txpolarity_in : in STD_LOGIC;
    gt0_txdiffctrl_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_txinhibit_in : in STD_LOGIC;
    gt0_txpostcursor_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    gt0_txprecursor_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    gt0_rxpolarity_in : in STD_LOGIC;
    gt0_rxdfelpmreset_in : in STD_LOGIC;
    gt0_rxdfeagcovrden_in : in STD_LOGIC;
    gt0_rxlpmen_in : in STD_LOGIC;
    gt0_txprbssel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_txprbsforceerr_in : in STD_LOGIC;
    gt0_rxprbscntreset_in : in STD_LOGIC;
    gt0_rxprbserr_out : out STD_LOGIC;
    gt0_rxprbssel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_loopback_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_txresetdone_out : out STD_LOGIC;
    gt0_rxresetdone_out : out STD_LOGIC;
    gt0_rxdisperr_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_rxnotintable_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_eyescanreset_in : in STD_LOGIC;
    gt0_eyescandataerror_out : out STD_LOGIC;
    gt0_eyescantrigger_in : in STD_LOGIC;
    gt0_rxcdrhold_in : in STD_LOGIC;
    gt0_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt0_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    signal_detect : in STD_LOGIC;
    gt0_qplloutclk_in : in STD_LOGIC;
    gt0_qplloutrefclk_in : in STD_LOGIC
  );

end gig_ethernet_pcs_pma_1;

architecture stub of gig_ethernet_pcs_pma_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "gtrefclk,gtrefclk_bufg,txp,txn,rxp,rxn,resetdone,cplllock,mmcm_reset,txoutclk,rxoutclk,userclk,userclk2,rxuserclk,rxuserclk2,pma_reset,mmcm_locked,independent_clock_bufg,gmii_txd[7:0],gmii_tx_en,gmii_tx_er,gmii_rxd[7:0],gmii_rx_dv,gmii_rx_er,gmii_isolate,configuration_vector[4:0],an_interrupt,an_adv_config_vector[15:0],an_restart_config,status_vector[15:0],reset,gt0_txpmareset_in,gt0_txpcsreset_in,gt0_rxpmareset_in,gt0_rxpcsreset_in,gt0_rxbufreset_in,gt0_rxpmaresetdone_out,gt0_rxbufstatus_out[2:0],gt0_txbufstatus_out[1:0],gt0_dmonitorout_out[14:0],gt0_drpaddr_in[8:0],gt0_drpclk_in,gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_rxchariscomma_out[1:0],gt0_rxcharisk_out[1:0],gt0_rxbyteisaligned_out,gt0_rxbyterealign_out,gt0_rxcommadet_out,gt0_txpolarity_in,gt0_txdiffctrl_in[3:0],gt0_txinhibit_in,gt0_txpostcursor_in[4:0],gt0_txprecursor_in[4:0],gt0_rxpolarity_in,gt0_rxdfelpmreset_in,gt0_rxdfeagcovrden_in,gt0_rxlpmen_in,gt0_txprbssel_in[2:0],gt0_txprbsforceerr_in,gt0_rxprbscntreset_in,gt0_rxprbserr_out,gt0_rxprbssel_in[2:0],gt0_loopback_in[2:0],gt0_txresetdone_out,gt0_rxresetdone_out,gt0_rxdisperr_out[1:0],gt0_rxnotintable_out[1:0],gt0_eyescanreset_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_rxcdrhold_in,gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],signal_detect,gt0_qplloutclk_in,gt0_qplloutrefclk_in";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "gig_ethernet_pcs_pma_v15_1_0,Vivado 2015.3";
begin
end;
