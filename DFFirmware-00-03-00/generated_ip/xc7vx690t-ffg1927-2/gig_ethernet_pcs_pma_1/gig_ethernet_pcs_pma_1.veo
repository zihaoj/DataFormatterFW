// (c) Copyright 1995-2015 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: xilinx.com:ip:gig_ethernet_pcs_pma:15.1
// IP Revision: 0

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
gig_ethernet_pcs_pma_1 your_instance_name (
  .gtrefclk_bufg(gtrefclk_bufg),                        // input wire gtrefclk_bufg
  .gtrefclk(gtrefclk),                                  // input wire gtrefclk
  .txn(txn),                                            // output wire txn
  .txp(txp),                                            // output wire txp
  .rxn(rxn),                                            // input wire rxn
  .rxp(rxp),                                            // input wire rxp
  .independent_clock_bufg(independent_clock_bufg),      // input wire independent_clock_bufg
  .txoutclk(txoutclk),                                  // output wire txoutclk
  .rxoutclk(rxoutclk),                                  // output wire rxoutclk
  .resetdone(resetdone),                                // output wire resetdone
  .cplllock(cplllock),                                  // output wire cplllock
  .mmcm_reset(mmcm_reset),                              // output wire mmcm_reset
  .userclk(userclk),                                    // input wire userclk
  .userclk2(userclk2),                                  // input wire userclk2
  .pma_reset(pma_reset),                                // input wire pma_reset
  .mmcm_locked(mmcm_locked),                            // input wire mmcm_locked
  .rxuserclk(rxuserclk),                                // input wire rxuserclk
  .rxuserclk2(rxuserclk2),                              // input wire rxuserclk2
  .gmii_txd(gmii_txd),                                  // input wire [7 : 0] gmii_txd
  .gmii_tx_en(gmii_tx_en),                              // input wire gmii_tx_en
  .gmii_tx_er(gmii_tx_er),                              // input wire gmii_tx_er
  .gmii_rxd(gmii_rxd),                                  // output wire [7 : 0] gmii_rxd
  .gmii_rx_dv(gmii_rx_dv),                              // output wire gmii_rx_dv
  .gmii_rx_er(gmii_rx_er),                              // output wire gmii_rx_er
  .gmii_isolate(gmii_isolate),                          // output wire gmii_isolate
  .configuration_vector(configuration_vector),          // input wire [4 : 0] configuration_vector
  .an_interrupt(an_interrupt),                          // output wire an_interrupt
  .an_adv_config_vector(an_adv_config_vector),          // input wire [15 : 0] an_adv_config_vector
  .an_restart_config(an_restart_config),                // input wire an_restart_config
  .status_vector(status_vector),                        // output wire [15 : 0] status_vector
  .reset(reset),                                        // input wire reset
  .signal_detect(signal_detect),                        // input wire signal_detect
  .gt0_qplloutclk_in(gt0_qplloutclk_in),                // input wire gt0_qplloutclk_in
  .gt0_qplloutrefclk_in(gt0_qplloutrefclk_in),          // input wire gt0_qplloutrefclk_in
  .gt0_rxchariscomma_out(gt0_rxchariscomma_out),        // output wire [1 : 0] gt0_rxchariscomma_out
  .gt0_rxcharisk_out(gt0_rxcharisk_out),                // output wire [1 : 0] gt0_rxcharisk_out
  .gt0_rxbyteisaligned_out(gt0_rxbyteisaligned_out),    // output wire gt0_rxbyteisaligned_out
  .gt0_rxbyterealign_out(gt0_rxbyterealign_out),        // output wire gt0_rxbyterealign_out
  .gt0_rxcommadet_out(gt0_rxcommadet_out),              // output wire gt0_rxcommadet_out
  .gt0_txpolarity_in(gt0_txpolarity_in),                // input wire gt0_txpolarity_in
  .gt0_txdiffctrl_in(gt0_txdiffctrl_in),                // input wire [3 : 0] gt0_txdiffctrl_in
  .gt0_txpostcursor_in(gt0_txpostcursor_in),            // input wire [4 : 0] gt0_txpostcursor_in
  .gt0_txprecursor_in(gt0_txprecursor_in),              // input wire [4 : 0] gt0_txprecursor_in
  .gt0_rxpolarity_in(gt0_rxpolarity_in),                // input wire gt0_rxpolarity_in
  .gt0_txinhibit_in(gt0_txinhibit_in),                  // input wire gt0_txinhibit_in
  .gt0_txprbssel_in(gt0_txprbssel_in),                  // input wire [2 : 0] gt0_txprbssel_in
  .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),        // input wire gt0_txprbsforceerr_in
  .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),        // input wire gt0_rxprbscntreset_in
  .gt0_rxprbserr_out(gt0_rxprbserr_out),                // output wire gt0_rxprbserr_out
  .gt0_rxprbssel_in(gt0_rxprbssel_in),                  // input wire [2 : 0] gt0_rxprbssel_in
  .gt0_loopback_in(gt0_loopback_in),                    // input wire [2 : 0] gt0_loopback_in
  .gt0_txresetdone_out(gt0_txresetdone_out),            // output wire gt0_txresetdone_out
  .gt0_rxresetdone_out(gt0_rxresetdone_out),            // output wire gt0_rxresetdone_out
  .gt0_rxpmaresetdone_out(gt0_rxpmaresetdone_out),      // output wire gt0_rxpmaresetdone_out
  .gt0_rxdisperr_out(gt0_rxdisperr_out),                // output wire [1 : 0] gt0_rxdisperr_out
  .gt0_txbufstatus_out(gt0_txbufstatus_out),            // output wire [1 : 0] gt0_txbufstatus_out
  .gt0_rxnotintable_out(gt0_rxnotintable_out),          // output wire [1 : 0] gt0_rxnotintable_out
  .gt0_eyescanreset_in(gt0_eyescanreset_in),            // input wire gt0_eyescanreset_in
  .gt0_eyescandataerror_out(gt0_eyescandataerror_out),  // output wire gt0_eyescandataerror_out
  .gt0_eyescantrigger_in(gt0_eyescantrigger_in),        // input wire gt0_eyescantrigger_in
  .gt0_rxcdrhold_in(gt0_rxcdrhold_in),                  // input wire gt0_rxcdrhold_in
  .gt0_rxpmareset_in(gt0_rxpmareset_in),                // input wire gt0_rxpmareset_in
  .gt0_txpmareset_in(gt0_txpmareset_in),                // input wire gt0_txpmareset_in
  .gt0_rxpcsreset_in(gt0_rxpcsreset_in),                // input wire gt0_rxpcsreset_in
  .gt0_txpcsreset_in(gt0_txpcsreset_in),                // input wire gt0_txpcsreset_in
  .gt0_rxbufreset_in(gt0_rxbufreset_in),                // input wire gt0_rxbufreset_in
  .gt0_rxbufstatus_out(gt0_rxbufstatus_out),            // output wire [2 : 0] gt0_rxbufstatus_out
  .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),          // input wire gt0_rxdfelpmreset_in
  .gt0_rxdfeagcovrden_in(gt0_rxdfeagcovrden_in),        // input wire gt0_rxdfeagcovrden_in
  .gt0_rxlpmen_in(gt0_rxlpmen_in),                      // input wire gt0_rxlpmen_in
  .gt0_rxmonitorout_out(gt0_rxmonitorout_out),          // output wire [6 : 0] gt0_rxmonitorout_out
  .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),            // input wire [1 : 0] gt0_rxmonitorsel_in
  .gt0_drpaddr_in(gt0_drpaddr_in),                      // input wire [8 : 0] gt0_drpaddr_in
  .gt0_drpclk_in(gt0_drpclk_in),                        // input wire gt0_drpclk_in
  .gt0_drpdi_in(gt0_drpdi_in),                          // input wire [15 : 0] gt0_drpdi_in
  .gt0_drpdo_out(gt0_drpdo_out),                        // output wire [15 : 0] gt0_drpdo_out
  .gt0_drpen_in(gt0_drpen_in),                          // input wire gt0_drpen_in
  .gt0_drprdy_out(gt0_drprdy_out),                      // output wire gt0_drprdy_out
  .gt0_drpwe_in(gt0_drpwe_in),                          // input wire gt0_drpwe_in
  .gt0_dmonitorout_out(gt0_dmonitorout_out)            // output wire [14 : 0] gt0_dmonitorout_out
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file gig_ethernet_pcs_pma_1.v when simulating
// the core, gig_ethernet_pcs_pma_1. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

