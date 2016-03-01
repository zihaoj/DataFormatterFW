// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.1 (win64) Build 881834 Fri Apr  4 14:15:54 MDT 2014
// Date        : Sat May 17 18:46:35 2014
// Host        : PC-UC-FTK-FW running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               c:/cygwin64/home/okumura/firmware_vivado/ipcore/xc7vx690t-ffg1927-2/gig_ethernet_pcs_pma_1_0/gig_ethernet_pcs_pma_1_stub.v
// Design      : gig_ethernet_pcs_pma_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "gig_ethernet_pcs_pma_v14_2,Vivado 2014.1" *)
module gig_ethernet_pcs_pma_1(gtrefclk, txp, txn, rxp, rxn, resetdone, cplllock, txoutclk, rxoutclk, userclk, userclk2, rxuserclk, rxuserclk2, pma_reset, mmcm_locked, independent_clock_bufg, gmii_txd, gmii_tx_en, gmii_tx_er, gmii_rxd, gmii_rx_dv, gmii_rx_er, gmii_isolate, configuration_vector, an_interrupt, an_adv_config_vector, an_restart_config, status_vector, reset, gt0_txpmareset_in, gt0_txpcsreset_in, gt0_rxpmareset_in, gt0_rxpcsreset_in, gt0_rxbufreset_in, gt0_rxpmaresetdone_out, gt0_rxbufstatus_out, gt0_txbufstatus_out, gt0_dmonitorout_out, gt0_drpaddr_in, gt0_drpclk_in, gt0_drpdi_in, gt0_drpdo_out, gt0_drpen_in, gt0_drprdy_out, gt0_drpwe_in, gt0_rxchariscomma_out, gt0_rxcharisk_out, gt0_rxbyteisaligned_out, gt0_rxbyterealign_out, gt0_rxcommadet_out, gt0_txpolarity_in, gt0_txdiffctrl_in, gt0_txpostcursor_in, gt0_txprecursor_in, gt0_rxpolarity_in, gt0_rxdfelpmreset_in, gt0_rxdfeagcovrden_in, gt0_rxlpmen_in, gt0_txprbssel_in, gt0_txprbsforceerr_in, gt0_rxprbscntreset_in, gt0_rxprbserr_out, gt0_rxprbssel_in, gt0_loopback_in, gt0_txresetdone_out, gt0_rxresetdone_out, gt0_rxdisperr_out, gt0_rxnotintable_out, gt0_eyescanreset_in, gt0_eyescandataerror_out, gt0_eyescantrigger_in, gt0_rxcdrhold_in, gt0_rxmonitorout_out, gt0_rxmonitorsel_in, signal_detect, gt0_qplloutclk_in, gt0_qplloutrefclk_in)
/* synthesis syn_black_box black_box_pad_pin="gtrefclk,txp,txn,rxp,rxn,resetdone,cplllock,txoutclk,rxoutclk,userclk,userclk2,rxuserclk,rxuserclk2,pma_reset,mmcm_locked,independent_clock_bufg,gmii_txd[7:0],gmii_tx_en,gmii_tx_er,gmii_rxd[7:0],gmii_rx_dv,gmii_rx_er,gmii_isolate,configuration_vector[4:0],an_interrupt,an_adv_config_vector[15:0],an_restart_config,status_vector[15:0],reset,gt0_txpmareset_in,gt0_txpcsreset_in,gt0_rxpmareset_in,gt0_rxpcsreset_in,gt0_rxbufreset_in,gt0_rxpmaresetdone_out,gt0_rxbufstatus_out[2:0],gt0_txbufstatus_out[1:0],gt0_dmonitorout_out[16:0],gt0_drpaddr_in[8:0],gt0_drpclk_in,gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_rxchariscomma_out[1:0],gt0_rxcharisk_out[1:0],gt0_rxbyteisaligned_out,gt0_rxbyterealign_out,gt0_rxcommadet_out,gt0_txpolarity_in,gt0_txdiffctrl_in[3:0],gt0_txpostcursor_in[4:0],gt0_txprecursor_in[4:0],gt0_rxpolarity_in,gt0_rxdfelpmreset_in,gt0_rxdfeagcovrden_in,gt0_rxlpmen_in,gt0_txprbssel_in[2:0],gt0_txprbsforceerr_in,gt0_rxprbscntreset_in,gt0_rxprbserr_out,gt0_rxprbssel_in[2:0],gt0_loopback_in[2:0],gt0_txresetdone_out,gt0_rxresetdone_out,gt0_rxdisperr_out[1:0],gt0_rxnotintable_out[1:0],gt0_eyescanreset_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_rxcdrhold_in,gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],signal_detect,gt0_qplloutclk_in,gt0_qplloutrefclk_in" */;
  input gtrefclk;
  output txp;
  output txn;
  input rxp;
  input rxn;
  output resetdone;
  output cplllock;
  output txoutclk;
  output rxoutclk;
  input userclk;
  input userclk2;
  input rxuserclk;
  input rxuserclk2;
  input pma_reset;
  input mmcm_locked;
  input independent_clock_bufg;
  input [7:0]gmii_txd;
  input gmii_tx_en;
  input gmii_tx_er;
  output [7:0]gmii_rxd;
  output gmii_rx_dv;
  output gmii_rx_er;
  output gmii_isolate;
  input [4:0]configuration_vector;
  output an_interrupt;
  input [15:0]an_adv_config_vector;
  input an_restart_config;
  output [15:0]status_vector;
  input reset;
  input gt0_txpmareset_in;
  input gt0_txpcsreset_in;
  input gt0_rxpmareset_in;
  input gt0_rxpcsreset_in;
  input gt0_rxbufreset_in;
  output gt0_rxpmaresetdone_out;
  output [2:0]gt0_rxbufstatus_out;
  output [1:0]gt0_txbufstatus_out;
  output [16:0]gt0_dmonitorout_out;
  input [8:0]gt0_drpaddr_in;
  input gt0_drpclk_in;
  input [15:0]gt0_drpdi_in;
  output [15:0]gt0_drpdo_out;
  input gt0_drpen_in;
  output gt0_drprdy_out;
  input gt0_drpwe_in;
  output [1:0]gt0_rxchariscomma_out;
  output [1:0]gt0_rxcharisk_out;
  output gt0_rxbyteisaligned_out;
  output gt0_rxbyterealign_out;
  output gt0_rxcommadet_out;
  input gt0_txpolarity_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input gt0_rxpolarity_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxdfeagcovrden_in;
  input gt0_rxlpmen_in;
  input [2:0]gt0_txprbssel_in;
  input gt0_txprbsforceerr_in;
  input gt0_rxprbscntreset_in;
  output gt0_rxprbserr_out;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_loopback_in;
  output gt0_txresetdone_out;
  output gt0_rxresetdone_out;
  output [1:0]gt0_rxdisperr_out;
  output [1:0]gt0_rxnotintable_out;
  input gt0_eyescanreset_in;
  output gt0_eyescandataerror_out;
  input gt0_eyescantrigger_in;
  input gt0_rxcdrhold_in;
  output [6:0]gt0_rxmonitorout_out;
  input [1:0]gt0_rxmonitorsel_in;
  input signal_detect;
  input gt0_qplloutclk_in;
  input gt0_qplloutrefclk_in;
endmodule
