// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.1 (win64) Build 881834 Fri Apr  4 14:15:54 MDT 2014
// Date        : Sat May 17 18:46:35 2014
// Host        : PC-UC-FTK-FW running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               c:/cygwin64/home/okumura/firmware_vivado/ipcore/xc7vx690t-ffg1927-2/gig_ethernet_pcs_pma_1_0/gig_ethernet_pcs_pma_1_funcsim.v
// Design      : gig_ethernet_pcs_pma_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* core_generation_info = "gig_ethernet_pcs_pma_1,gig_ethernet_pcs_pma_v14_2,{x_ipProduct=Vivado 2014.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=gig_ethernet_pcs_pma,x_ipVersion=14.2,x_ipCoreRevision=0,x_ipLanguage=VHDL,c_elaboration_transient_dir=.,c_component_name=gig_ethernet_pcs_pma_1,c_family=virtex7,c_is_sgmii=false,c_use_transceiver=true,c_use_tbi=false,c_use_lvds=false,c_has_an=true,c_has_mdio=false,c_has_ext_mdio=false,c_sgmii_phy_mode=false,c_dynamic_switching=false,c_transceiver_mode=A,c_sgmii_fabric_buffer=true,c_1588=0,gt_rx_byte_width=1,C_EMAC_IF_TEMAC=true,C_PHYADDR=1,EXAMPLE_SIMULATION=0,c_support_level=false,c_sub_core_name=gig_ethernet_pcs_pma_1_gt,c_transceivercontrol=true}" *) (* x_core_info = "gig_ethernet_pcs_pma_v14_2,Vivado 2014.1" *) 
(* NotValidForBitStream *)
module gig_ethernet_pcs_pma_1
   (gtrefclk,
    txp,
    txn,
    rxp,
    rxn,
    resetdone,
    cplllock,
    txoutclk,
    rxoutclk,
    userclk,
    userclk2,
    rxuserclk,
    rxuserclk2,
    pma_reset,
    mmcm_locked,
    independent_clock_bufg,
    gmii_txd,
    gmii_tx_en,
    gmii_tx_er,
    gmii_rxd,
    gmii_rx_dv,
    gmii_rx_er,
    gmii_isolate,
    configuration_vector,
    an_interrupt,
    an_adv_config_vector,
    an_restart_config,
    status_vector,
    reset,
    gt0_txpmareset_in,
    gt0_txpcsreset_in,
    gt0_rxpmareset_in,
    gt0_rxpcsreset_in,
    gt0_rxbufreset_in,
    gt0_rxpmaresetdone_out,
    gt0_rxbufstatus_out,
    gt0_txbufstatus_out,
    gt0_dmonitorout_out,
    gt0_drpaddr_in,
    gt0_drpclk_in,
    gt0_drpdi_in,
    gt0_drpdo_out,
    gt0_drpen_in,
    gt0_drprdy_out,
    gt0_drpwe_in,
    gt0_rxchariscomma_out,
    gt0_rxcharisk_out,
    gt0_rxbyteisaligned_out,
    gt0_rxbyterealign_out,
    gt0_rxcommadet_out,
    gt0_txpolarity_in,
    gt0_txdiffctrl_in,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    gt0_rxpolarity_in,
    gt0_rxdfelpmreset_in,
    gt0_rxdfeagcovrden_in,
    gt0_rxlpmen_in,
    gt0_txprbssel_in,
    gt0_txprbsforceerr_in,
    gt0_rxprbscntreset_in,
    gt0_rxprbserr_out,
    gt0_rxprbssel_in,
    gt0_loopback_in,
    gt0_txresetdone_out,
    gt0_rxresetdone_out,
    gt0_rxdisperr_out,
    gt0_rxnotintable_out,
    gt0_eyescanreset_in,
    gt0_eyescandataerror_out,
    gt0_eyescantrigger_in,
    gt0_rxcdrhold_in,
    gt0_rxmonitorout_out,
    gt0_rxmonitorsel_in,
    signal_detect,
    gt0_qplloutclk_in,
    gt0_qplloutrefclk_in);
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

  wire \<const0> ;
  wire \<const1> ;
  wire [15:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire cplllock;
  wire gmii_isolate;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire [14:0]\^gt0_dmonitorout_out ;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drprdy_out;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire [2:0]gt0_loopback_in;
  wire gt0_qplloutclk_in;
  wire gt0_qplloutrefclk_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire gt0_rxbyteisaligned_out;
  wire gt0_rxbyterealign_out;
  wire gt0_rxcdrhold_in;
  wire [0:0]\^gt0_rxchariscomma_out ;
  wire [0:0]\^gt0_rxcharisk_out ;
  wire gt0_rxcommadet_out;
  wire gt0_rxdfeagcovrden_in;
  wire gt0_rxdfelpmreset_in;
  wire [0:0]\^gt0_rxdisperr_out ;
  wire gt0_rxlpmen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire [0:0]\^gt0_rxnotintable_out ;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpmaresetdone_out;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire gt0_rxresetdone_out;
  wire [1:0]gt0_txbufstatus_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txpcsreset_in;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gt0_txresetdone_out;
  wire gtrefclk;
  wire independent_clock_bufg;
  wire mmcm_locked;
  wire pma_reset;
  wire reset;
  wire resetdone;
  wire rxn;
  wire rxoutclk;
  wire rxp;
  wire rxuserclk;
  wire signal_detect;
  wire [15:0]\^status_vector ;
  wire txn;
  wire txoutclk;
  wire txp;
  wire userclk;
  wire userclk2;

  assign gt0_dmonitorout_out[16] = \<const0> ;
  assign gt0_dmonitorout_out[15] = \<const0> ;
  assign gt0_dmonitorout_out[14:0] = \^gt0_dmonitorout_out [14:0];
  assign gt0_rxchariscomma_out[1] = \<const0> ;
  assign gt0_rxchariscomma_out[0] = \^gt0_rxchariscomma_out [0];
  assign gt0_rxcharisk_out[1] = \<const0> ;
  assign gt0_rxcharisk_out[0] = \^gt0_rxcharisk_out [0];
  assign gt0_rxdisperr_out[1] = \<const0> ;
  assign gt0_rxdisperr_out[0] = \^gt0_rxdisperr_out [0];
  assign gt0_rxnotintable_out[1] = \<const0> ;
  assign gt0_rxnotintable_out[0] = \^gt0_rxnotintable_out [0];
  assign status_vector[15:12] = \^status_vector [15:12];
  assign status_vector[11] = \<const1> ;
  assign status_vector[10] = \<const0> ;
  assign status_vector[9:8] = \^status_vector [9:8];
  assign status_vector[7] = \<const0> ;
  assign status_vector[6:0] = \^status_vector [6:0];
GND GND
       (.G(\<const0> ));
gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_block U0
       (.O1(gt0_txresetdone_out),
        .O2(gt0_rxresetdone_out),
        .an_adv_config_vector({an_adv_config_vector[15],an_adv_config_vector[13:11],an_adv_config_vector[8:7],an_adv_config_vector[5]}),
        .an_interrupt(an_interrupt),
        .an_restart_config(an_restart_config),
        .configuration_vector(configuration_vector),
        .cplllock(cplllock),
        .gmii_isolate(gmii_isolate),
        .gmii_rx_dv(gmii_rx_dv),
        .gmii_rx_er(gmii_rx_er),
        .gmii_rxd(gmii_rxd),
        .gmii_tx_en(gmii_tx_en),
        .gmii_tx_er(gmii_tx_er),
        .gmii_txd(gmii_txd),
        .gt0_dmonitorout_out(\^gt0_dmonitorout_out ),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drprdy_out(gt0_drprdy_out),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_qplloutclk_in(gt0_qplloutclk_in),
        .gt0_qplloutrefclk_in(gt0_qplloutrefclk_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxbyteisaligned_out(gt0_rxbyteisaligned_out),
        .gt0_rxbyterealign_out(gt0_rxbyterealign_out),
        .gt0_rxcdrhold_in(gt0_rxcdrhold_in),
        .gt0_rxchariscomma_out(\^gt0_rxchariscomma_out ),
        .gt0_rxcharisk_out(\^gt0_rxcharisk_out ),
        .gt0_rxcommadet_out(gt0_rxcommadet_out),
        .gt0_rxdfeagcovrden_in(gt0_rxdfeagcovrden_in),
        .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),
        .gt0_rxdisperr_out(\^gt0_rxdisperr_out ),
        .gt0_rxlpmen_in(gt0_rxlpmen_in),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxnotintable_out(\^gt0_rxnotintable_out ),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxpmareset_in(gt0_rxpmareset_in),
        .gt0_rxpmaresetdone_out(gt0_rxpmaresetdone_out),
        .gt0_rxpolarity_in(gt0_rxpolarity_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdiffctrl_in(gt0_txdiffctrl_in),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpmareset_in(gt0_txpmareset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txpostcursor_in(gt0_txpostcursor_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txprecursor_in(gt0_txprecursor_in),
        .gtrefclk(gtrefclk),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked(mmcm_locked),
        .pma_reset(pma_reset),
        .reset(reset),
        .resetdone(resetdone),
        .rxn(rxn),
        .rxoutclk(rxoutclk),
        .rxp(rxp),
        .rxuserclk(rxuserclk),
        .signal_detect(signal_detect),
        .status_vector({\^status_vector [15:12],\^status_vector [9:8],\^status_vector [6:0]}),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp),
        .userclk(userclk),
        .userclk2(userclk2));
VCC VCC
       (.P(\<const1> ));
endmodule

(* ORIG_REF_NAME = "AUTO_NEG" *) 
module gig_ethernet_pcs_pma_1AUTO_NEG__parameterized0
   (status_vector,
    O1,
    O2,
    an_interrupt,
    STAT_VEC_DUPLEX_MODE_RSLVD_reg,
    O3,
    RX_RUDI_INVALID,
    STATUS_VECTOR_0_PRE0,
    XMIT_DATA,
    XMIT_CONFIG,
    D,
    O4,
    O5,
    O6,
    I1,
    userclk2,
    RESTART_AN_SET,
    Q,
    RX_IDLE,
    I2,
    I3,
    I4,
    RX_CONFIG_VALID,
    RXSYNC_STATUS,
    data_out,
    p_0_in,
    MASK_RUDI_BUFERR_TIMER0,
    I5,
    S,
    I6,
    I7,
    I8,
    SOP_REG3,
    an_adv_config_vector,
    I9,
    I10,
    EOP_REG1,
    I11,
    gmii_rx_dv,
    SYNC_STATUS_HELD,
    SR);
  output [5:0]status_vector;
  output O1;
  output O2;
  output an_interrupt;
  output STAT_VEC_DUPLEX_MODE_RSLVD_reg;
  output O3;
  output RX_RUDI_INVALID;
  output STATUS_VECTOR_0_PRE0;
  output XMIT_DATA;
  output XMIT_CONFIG;
  output [7:0]D;
  output O4;
  output [5:0]O5;
  output [5:0]O6;
  input I1;
  input userclk2;
  input RESTART_AN_SET;
  input [3:0]Q;
  input RX_IDLE;
  input I2;
  input I3;
  input I4;
  input RX_CONFIG_VALID;
  input RXSYNC_STATUS;
  input data_out;
  input p_0_in;
  input MASK_RUDI_BUFERR_TIMER0;
  input [15:0]I5;
  input [1:0]S;
  input [1:0]I6;
  input I7;
  input I8;
  input SOP_REG3;
  input [6:0]an_adv_config_vector;
  input [1:0]I9;
  input I10;
  input EOP_REG1;
  input I11;
  input gmii_rx_dv;
  input SYNC_STATUS_HELD;
  input [0:0]SR;

  wire ABILITY_MATCH;
  wire ABILITY_MATCH_2;
  wire ABILITY_MATCH_22;
  wire ACKNOWLEDGE_MATCH_2;
  wire ACKNOWLEDGE_MATCH_3;
  wire AN_SYNC_STATUS;
  wire CONSISTENCY_MATCH;
  wire CONSISTENCY_MATCH1;
  wire CONSISTENCY_MATCH_COMB;
  wire [7:0]D;
  wire EOP_REG1;
  wire GENERATE_REMOTE_FAULT;
  wire I1;
  wire I10;
  wire I11;
  wire I2;
  wire I3;
  wire I4;
  wire [15:0]I5;
  wire [1:0]I6;
  wire I7;
  wire I8;
  wire [1:0]I9;
  wire IDLE_MATCH;
  wire IDLE_MATCH_2;
  wire IDLE_REMOVED;
  wire IDLE_REMOVED0;
  wire IDLE_REMOVED_REG1;
  wire IDLE_REMOVED_REG2;
  wire LINK_TIMER_DONE;
  wire LINK_TIMER_SATURATED;
  wire LINK_TIMER_SATURATED_COMB;
  wire [8:0]LINK_TIMER_reg__0;
  wire [8:0]MASK_RUDI_BUFERR_TIMER;
  wire MASK_RUDI_BUFERR_TIMER0;
  wire MR_AN_ENABLE_CHANGE;
  wire MR_AN_ENABLE_CHANGE0;
  wire MR_AN_ENABLE_REG1;
  wire MR_AN_ENABLE_REG2;
  wire MR_RESTART_AN_SET_REG1;
  wire MR_RESTART_AN_SET_REG2;
  wire [3:3]NEXT_STATE;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [5:0]O5;
  wire [5:0]O6;
  wire PREVIOUS_STATE;
  wire PULSE4096;
  wire PULSE40960;
  wire [3:0]Q;
  wire RESTART_AN_SET;
  wire RXSYNC_STATUS;
  wire RX_CONFIG_SNAPSHOT;
  wire RX_CONFIG_VALID;
  wire RX_IDLE;
  wire RX_IDLE_REG1;
  wire RX_IDLE_REG2;
  wire RX_RUDI_INVALID;
  wire [1:0]RX_RUDI_INVALID_DELAY;
  wire RX_RUDI_INVALID_DELAY0;
  wire RX_RUDI_INVALID_REG;
  wire [1:0]S;
  wire SOP_REG3;
  wire [0:0]SR;
  wire START_LINK_TIMER;
  wire START_LINK_TIMER114_out;
  wire START_LINK_TIMER_REG;
  wire START_LINK_TIMER_REG2;
  wire STATE1;
  wire STATUS_VECTOR_0_PRE0;
  wire STAT_VEC_DUPLEX_MODE_RSLVD_reg;
  wire SYNC_STATUS_HELD;
  wire SYNC_STATUS_HELD__0;
  wire TIMER4096_MSB_REG;
  wire TOGGLE_RX;
  wire TOGGLE_TX;
  wire XMIT_CONFIG;
  wire XMIT_CONFIG_INT;
  wire XMIT_DATA;
  wire XMIT_DATA_INT;
  wire XMIT_DATA_INT0;
  wire [6:0]an_adv_config_vector;
  wire an_interrupt;
  wire data_out;
  wire gmii_rx_dv;
  wire n_0_ABILITY_MATCH_2_i_1;
  wire n_0_ABILITY_MATCH_2_i_2;
  wire n_0_ABILITY_MATCH_i_1;
  wire n_0_ACKNOWLEDGE_MATCH_2_i_1;
  wire n_0_ACKNOWLEDGE_MATCH_3_i_1;
  wire n_0_ACKNOWLEDGE_MATCH_3_reg;
  wire n_0_AN_SYNC_STATUS_i_1;
  wire \n_0_BASEX_REMOTE_FAULT[0]_i_1 ;
  wire \n_0_BASEX_REMOTE_FAULT[1]_i_1 ;
  wire n_0_CONSISTENCY_MATCH_i_4;
  wire n_0_CONSISTENCY_MATCH_i_5;
  wire n_0_CONSISTENCY_MATCH_i_8;
  wire n_0_CONSISTENCY_MATCH_reg_i_3;
  wire n_0_IDLE_MATCH_2_i_1;
  wire n_0_IDLE_MATCH_i_1;
  wire \n_0_LINK_TIMER[7]_i_2 ;
  wire \n_0_LINK_TIMER[8]_i_1 ;
  wire \n_0_LINK_TIMER[8]_i_3 ;
  wire n_0_LINK_TIMER_DONE_i_1;
  wire n_0_LINK_TIMER_SATURATED_i_2;
  wire n_0_LINK_TIMER_SATURATED_i_3;
  wire n_0_LINK_TIMER_SATURATED_i_4;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2 ;
  wire \n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ;
  wire n_0_MASK_RUDI_BUFERR_i_1;
  wire n_0_MASK_RUDI_BUFERR_i_2;
  wire n_0_MASK_RUDI_BUFERR_reg;
  wire n_0_MASK_RUDI_CLKCOR_i_1;
  wire n_0_MASK_RUDI_CLKCOR_reg;
  wire n_0_MR_AN_COMPLETE_i_1;
  wire \n_0_MR_LP_ADV_ABILITY_INT[9]_i_1 ;
  wire \n_0_MR_LP_ADV_ABILITY_INT_reg[13] ;
  wire \n_0_MR_LP_ADV_ABILITY_INT_reg[14] ;
  wire \n_0_MR_LP_ADV_ABILITY_INT_reg[16] ;
  wire n_0_MR_REMOTE_FAULT_i_1;
  wire n_0_MR_RESTART_AN_INT_i_1;
  wire n_0_MR_RESTART_AN_INT_reg;
  wire \n_0_PREVIOUS_STATE_reg[0] ;
  wire \n_0_PREVIOUS_STATE_reg[1] ;
  wire \n_0_PREVIOUS_STATE_reg[2] ;
  wire \n_0_PREVIOUS_STATE_reg[3] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[0] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[10] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[11] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[12] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[13] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[1] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[2] ;
  wire \n_0_RX_CONFIG_REG_REG_reg[9] ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_10 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_2 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_3 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_6 ;
  wire \n_0_RX_CONFIG_SNAPSHOT[15]_i_7 ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[0] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[10] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[11] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[12] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[13] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[15] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[1] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[2] ;
  wire \n_0_RX_CONFIG_SNAPSHOT_reg[9] ;
  wire n_0_RX_DV_i_2;
  wire n_0_START_LINK_TIMER_REG_i_2;
  wire n_0_START_LINK_TIMER_REG_i_3;
  wire n_0_START_LINK_TIMER_REG_i_4;
  wire \n_0_STATE[0]_i_1 ;
  wire \n_0_STATE[0]_i_2 ;
  wire \n_0_STATE[0]_i_3 ;
  wire \n_0_STATE[0]_i_4 ;
  wire \n_0_STATE[0]_i_5 ;
  wire \n_0_STATE[0]_i_6 ;
  wire \n_0_STATE[0]_i_7 ;
  wire \n_0_STATE[1]_i_1 ;
  wire \n_0_STATE[1]_i_2 ;
  wire \n_0_STATE[1]_i_3 ;
  wire \n_0_STATE[1]_i_4 ;
  wire \n_0_STATE[2]_i_1 ;
  wire \n_0_STATE[2]_i_2 ;
  wire \n_0_STATE[2]_i_3 ;
  wire \n_0_STATE[2]_i_4 ;
  wire \n_0_STATE[2]_i_5 ;
  wire \n_0_STATE[2]_i_6 ;
  wire \n_0_STATE[3]_i_1 ;
  wire \n_0_STATE[3]_i_4 ;
  wire \n_0_STATE[3]_i_5 ;
  wire \n_0_STATE_reg[0] ;
  wire \n_0_STATE_reg[1] ;
  wire \n_0_STATE_reg[2] ;
  wire \n_0_STATE_reg[3] ;
  wire n_0_SYNC_STATUS_HELD_i_1;
  wire \n_0_TIMER4096[0]_i_2 ;
  wire \n_0_TIMER4096[0]_i_3 ;
  wire \n_0_TIMER4096[0]_i_4 ;
  wire \n_0_TIMER4096[0]_i_5 ;
  wire \n_0_TIMER4096[4]_i_2 ;
  wire \n_0_TIMER4096[4]_i_3 ;
  wire \n_0_TIMER4096[4]_i_4 ;
  wire \n_0_TIMER4096[4]_i_5 ;
  wire \n_0_TIMER4096[8]_i_2 ;
  wire \n_0_TIMER4096[8]_i_3 ;
  wire \n_0_TIMER4096[8]_i_4 ;
  wire \n_0_TIMER4096[8]_i_5 ;
  wire \n_0_TIMER4096_reg[0] ;
  wire \n_0_TIMER4096_reg[0]_i_1 ;
  wire \n_0_TIMER4096_reg[10] ;
  wire \n_0_TIMER4096_reg[11] ;
  wire \n_0_TIMER4096_reg[1] ;
  wire \n_0_TIMER4096_reg[2] ;
  wire \n_0_TIMER4096_reg[3] ;
  wire \n_0_TIMER4096_reg[4] ;
  wire \n_0_TIMER4096_reg[4]_i_1 ;
  wire \n_0_TIMER4096_reg[5] ;
  wire \n_0_TIMER4096_reg[6] ;
  wire \n_0_TIMER4096_reg[7] ;
  wire \n_0_TIMER4096_reg[8] ;
  wire \n_0_TIMER4096_reg[9] ;
  wire n_0_TOGGLE_RX_i_1;
  wire n_0_TOGGLE_TX_i_1;
  wire \n_0_TX_CONFIG_REG_INT[11]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[12]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[13]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[14]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[15]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[15]_i_2 ;
  wire \n_0_TX_CONFIG_REG_INT[5]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[7]_i_1 ;
  wire \n_0_TX_CONFIG_REG_INT[8]_i_1 ;
  wire n_0_XMIT_CONFIG_INT_i_1__0;
  wire n_0_XMIT_CONFIG_INT_i_2__0;
  wire n_0_XMIT_CONFIG_INT_i_3;
  wire n_1_CONSISTENCY_MATCH_reg_i_3;
  wire \n_1_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ;
  wire \n_1_TIMER4096_reg[0]_i_1 ;
  wire \n_1_TIMER4096_reg[4]_i_1 ;
  wire \n_1_TIMER4096_reg[8]_i_1 ;
  wire n_2_CONSISTENCY_MATCH_reg_i_3;
  wire n_2_LINK_TIMER_SATURATED_reg_i_1;
  wire \n_2_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ;
  wire \n_2_TIMER4096_reg[0]_i_1 ;
  wire \n_2_TIMER4096_reg[4]_i_1 ;
  wire \n_2_TIMER4096_reg[8]_i_1 ;
  wire n_3_CONSISTENCY_MATCH_reg_i_3;
  wire n_3_LINK_TIMER_SATURATED_reg_i_1;
  wire \n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ;
  wire \n_3_TIMER4096_reg[0]_i_1 ;
  wire \n_3_TIMER4096_reg[4]_i_1 ;
  wire \n_3_TIMER4096_reg[8]_i_1 ;
  wire \n_4_TIMER4096_reg[0]_i_1 ;
  wire \n_4_TIMER4096_reg[4]_i_1 ;
  wire \n_4_TIMER4096_reg[8]_i_1 ;
  wire \n_5_TIMER4096_reg[0]_i_1 ;
  wire \n_5_TIMER4096_reg[4]_i_1 ;
  wire \n_5_TIMER4096_reg[8]_i_1 ;
  wire \n_6_TIMER4096_reg[0]_i_1 ;
  wire \n_6_TIMER4096_reg[4]_i_1 ;
  wire \n_6_TIMER4096_reg[8]_i_1 ;
  wire \n_7_TIMER4096_reg[0]_i_1 ;
  wire \n_7_TIMER4096_reg[4]_i_1 ;
  wire \n_7_TIMER4096_reg[8]_i_1 ;
  wire p_0_in;
  wire p_0_in0_in;
  wire p_0_in38_in;
  wire [8:0]plusOp;
  wire [5:0]status_vector;
  wire userclk2;
  wire [3:1]NLW_CONSISTENCY_MATCH_reg_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_CONSISTENCY_MATCH_reg_i_2_O_UNCONNECTED;
  wire [3:0]NLW_CONSISTENCY_MATCH_reg_i_3_O_UNCONNECTED;
  wire [3:3]NLW_LINK_TIMER_SATURATED_reg_i_1_CO_UNCONNECTED;
  wire [3:0]NLW_LINK_TIMER_SATURATED_reg_i_1_O_UNCONNECTED;
  wire [3:1]\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_4_CO_UNCONNECTED ;
  wire [3:0]\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_4_O_UNCONNECTED ;
  wire [3:0]\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_5_O_UNCONNECTED ;
  wire [3:3]\NLW_TIMER4096_reg[8]_i_1_CO_UNCONNECTED ;

LUT5 #(
    .INIT(32'h00002E22)) 
     ABILITY_MATCH_2_i_1
       (.I0(ABILITY_MATCH_2),
        .I1(RX_CONFIG_VALID),
        .I2(n_0_ABILITY_MATCH_2_i_2),
        .I3(ABILITY_MATCH_22),
        .I4(ACKNOWLEDGE_MATCH_3),
        .O(n_0_ABILITY_MATCH_2_i_1));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT3 #(
    .INIT(8'hF6)) 
     ABILITY_MATCH_2_i_2
       (.I0(p_0_in0_in),
        .I1(I5[15]),
        .I2(O2),
        .O(n_0_ABILITY_MATCH_2_i_2));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     ABILITY_MATCH_2_i_3
       (.I0(I1),
        .I1(n_0_MASK_RUDI_BUFERR_reg),
        .I2(RX_IDLE),
        .O(ACKNOWLEDGE_MATCH_3));
FDRE ABILITY_MATCH_2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_ABILITY_MATCH_2_i_1),
        .Q(ABILITY_MATCH_2),
        .R(1'b0));
LUT6 #(
    .INIT(64'h0000000020FF2000)) 
     ABILITY_MATCH_i_1
       (.I0(ABILITY_MATCH_22),
        .I1(n_0_ABILITY_MATCH_2_i_2),
        .I2(ABILITY_MATCH_2),
        .I3(RX_CONFIG_VALID),
        .I4(ABILITY_MATCH),
        .I5(ACKNOWLEDGE_MATCH_3),
        .O(n_0_ABILITY_MATCH_i_1));
FDRE ABILITY_MATCH_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_ABILITY_MATCH_i_1),
        .Q(ABILITY_MATCH),
        .R(1'b0));
LUT5 #(
    .INIT(32'h0000E222)) 
     ACKNOWLEDGE_MATCH_2_i_1
       (.I0(ACKNOWLEDGE_MATCH_2),
        .I1(RX_CONFIG_VALID),
        .I2(p_0_in38_in),
        .I3(I5[14]),
        .I4(ACKNOWLEDGE_MATCH_3),
        .O(n_0_ACKNOWLEDGE_MATCH_2_i_1));
FDRE ACKNOWLEDGE_MATCH_2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_ACKNOWLEDGE_MATCH_2_i_1),
        .Q(ACKNOWLEDGE_MATCH_2),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000E2222222)) 
     ACKNOWLEDGE_MATCH_3_i_1
       (.I0(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .I1(RX_CONFIG_VALID),
        .I2(I5[14]),
        .I3(p_0_in38_in),
        .I4(ACKNOWLEDGE_MATCH_2),
        .I5(ACKNOWLEDGE_MATCH_3),
        .O(n_0_ACKNOWLEDGE_MATCH_3_i_1));
FDRE ACKNOWLEDGE_MATCH_3_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_ACKNOWLEDGE_MATCH_3_i_1),
        .Q(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .R(1'b0));
LUT5 #(
    .INIT(32'hFFBFFF80)) 
     AN_SYNC_STATUS_i_1
       (.I0(SYNC_STATUS_HELD__0),
        .I1(PULSE4096),
        .I2(LINK_TIMER_SATURATED),
        .I3(RXSYNC_STATUS),
        .I4(AN_SYNC_STATUS),
        .O(n_0_AN_SYNC_STATUS_i_1));
FDRE AN_SYNC_STATUS_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_AN_SYNC_STATUS_i_1),
        .Q(AN_SYNC_STATUS),
        .R(I1));
LUT3 #(
    .INIT(8'hB8)) 
     \BASEX_REMOTE_FAULT[0]_i_1 
       (.I0(I5[12]),
        .I1(PREVIOUS_STATE),
        .I2(status_vector[1]),
        .O(\n_0_BASEX_REMOTE_FAULT[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \BASEX_REMOTE_FAULT[1]_i_1 
       (.I0(I5[13]),
        .I1(PREVIOUS_STATE),
        .I2(status_vector[2]),
        .O(\n_0_BASEX_REMOTE_FAULT[1]_i_1 ));
FDRE \BASEX_REMOTE_FAULT_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_BASEX_REMOTE_FAULT[0]_i_1 ),
        .Q(status_vector[1]),
        .R(I1));
FDRE \BASEX_REMOTE_FAULT_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_BASEX_REMOTE_FAULT[1]_i_1 ),
        .Q(status_vector[2]),
        .R(I1));
LUT3 #(
    .INIT(8'h82)) 
     CONSISTENCY_MATCH_i_1
       (.I0(CONSISTENCY_MATCH1),
        .I1(\n_0_RX_CONFIG_SNAPSHOT_reg[15] ),
        .I2(I5[15]),
        .O(CONSISTENCY_MATCH_COMB));
LUT4 #(
    .INIT(16'h9009)) 
     CONSISTENCY_MATCH_i_4
       (.I0(\n_0_RX_CONFIG_SNAPSHOT_reg[13] ),
        .I1(I5[13]),
        .I2(\n_0_RX_CONFIG_SNAPSHOT_reg[12] ),
        .I3(I5[12]),
        .O(n_0_CONSISTENCY_MATCH_i_4));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     CONSISTENCY_MATCH_i_5
       (.I0(\n_0_RX_CONFIG_SNAPSHOT_reg[9] ),
        .I1(I5[9]),
        .I2(I5[10]),
        .I3(\n_0_RX_CONFIG_SNAPSHOT_reg[10] ),
        .I4(I5[11]),
        .I5(\n_0_RX_CONFIG_SNAPSHOT_reg[11] ),
        .O(n_0_CONSISTENCY_MATCH_i_5));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     CONSISTENCY_MATCH_i_8
       (.I0(\n_0_RX_CONFIG_SNAPSHOT_reg[2] ),
        .I1(I5[2]),
        .I2(I5[0]),
        .I3(\n_0_RX_CONFIG_SNAPSHOT_reg[0] ),
        .I4(I5[1]),
        .I5(\n_0_RX_CONFIG_SNAPSHOT_reg[1] ),
        .O(n_0_CONSISTENCY_MATCH_i_8));
FDRE CONSISTENCY_MATCH_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(CONSISTENCY_MATCH_COMB),
        .Q(CONSISTENCY_MATCH),
        .R(I1));
CARRY4 CONSISTENCY_MATCH_reg_i_2
       (.CI(n_0_CONSISTENCY_MATCH_reg_i_3),
        .CO({NLW_CONSISTENCY_MATCH_reg_i_2_CO_UNCONNECTED[3:1],CONSISTENCY_MATCH1}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_CONSISTENCY_MATCH_reg_i_2_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,1'b0,n_0_CONSISTENCY_MATCH_i_4}));
CARRY4 CONSISTENCY_MATCH_reg_i_3
       (.CI(1'b0),
        .CO({n_0_CONSISTENCY_MATCH_reg_i_3,n_1_CONSISTENCY_MATCH_reg_i_3,n_2_CONSISTENCY_MATCH_reg_i_3,n_3_CONSISTENCY_MATCH_reg_i_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_CONSISTENCY_MATCH_reg_i_3_O_UNCONNECTED[3:0]),
        .S({n_0_CONSISTENCY_MATCH_i_5,I6,n_0_CONSISTENCY_MATCH_i_8}));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT5 #(
    .INIT(32'h8F8A0000)) 
     FROM_IDLE_D_i_2
       (.I0(XMIT_DATA_INT),
        .I1(STAT_VEC_DUPLEX_MODE_RSLVD_reg),
        .I2(Q[3]),
        .I3(Q[0]),
        .I4(RXSYNC_STATUS),
        .O(O3));
LUT5 #(
    .INIT(32'h02000000)) 
     GENERATE_REMOTE_FAULT_i_1
       (.I0(n_0_START_LINK_TIMER_REG_i_4),
        .I1(\n_0_PREVIOUS_STATE_reg[3] ),
        .I2(\n_0_PREVIOUS_STATE_reg[2] ),
        .I3(\n_0_PREVIOUS_STATE_reg[0] ),
        .I4(\n_0_PREVIOUS_STATE_reg[1] ),
        .O(PREVIOUS_STATE));
FDRE GENERATE_REMOTE_FAULT_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(PREVIOUS_STATE),
        .Q(GENERATE_REMOTE_FAULT),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     IDLE_MATCH_2_i_1
       (.I0(RX_IDLE),
        .I1(RX_IDLE_REG2),
        .I2(IDLE_MATCH_2),
        .O(n_0_IDLE_MATCH_2_i_1));
FDRE IDLE_MATCH_2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_IDLE_MATCH_2_i_1),
        .Q(IDLE_MATCH_2),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair8" *) 
   LUT5 #(
    .INIT(32'hA8FFA800)) 
     IDLE_MATCH_i_1
       (.I0(RX_IDLE),
        .I1(IDLE_REMOVED_REG2),
        .I2(IDLE_MATCH_2),
        .I3(RX_IDLE_REG2),
        .I4(IDLE_MATCH),
        .O(n_0_IDLE_MATCH_i_1));
FDRE IDLE_MATCH_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_IDLE_MATCH_i_1),
        .Q(IDLE_MATCH),
        .R(I1));
FDRE IDLE_REMOVED_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(IDLE_REMOVED),
        .Q(IDLE_REMOVED_REG1),
        .R(I1));
FDRE IDLE_REMOVED_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(IDLE_REMOVED_REG1),
        .Q(IDLE_REMOVED_REG2),
        .R(I1));
LUT3 #(
    .INIT(8'h04)) 
     IDLE_REMOVED_i_1
       (.I0(XMIT_CONFIG_INT),
        .I1(I9[0]),
        .I2(I9[1]),
        .O(IDLE_REMOVED0));
FDRE IDLE_REMOVED_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(IDLE_REMOVED0),
        .Q(IDLE_REMOVED),
        .R(I1));
(* RETAIN_INVERTER *) 
   (* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \LINK_TIMER[0]_i_1 
       (.I0(LINK_TIMER_reg__0[0]),
        .O(plusOp[0]));
(* SOFT_HLUTNM = "soft_lutpair21" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \LINK_TIMER[1]_i_1 
       (.I0(LINK_TIMER_reg__0[0]),
        .I1(LINK_TIMER_reg__0[1]),
        .O(plusOp[1]));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT3 #(
    .INIT(8'h6A)) 
     \LINK_TIMER[2]_i_1 
       (.I0(LINK_TIMER_reg__0[2]),
        .I1(LINK_TIMER_reg__0[0]),
        .I2(LINK_TIMER_reg__0[1]),
        .O(plusOp[2]));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \LINK_TIMER[3]_i_1 
       (.I0(LINK_TIMER_reg__0[1]),
        .I1(LINK_TIMER_reg__0[0]),
        .I2(LINK_TIMER_reg__0[2]),
        .I3(LINK_TIMER_reg__0[3]),
        .O(plusOp[3]));
(* SOFT_HLUTNM = "soft_lutpair10" *) 
   LUT5 #(
    .INIT(32'h6AAAAAAA)) 
     \LINK_TIMER[4]_i_1 
       (.I0(LINK_TIMER_reg__0[4]),
        .I1(LINK_TIMER_reg__0[1]),
        .I2(LINK_TIMER_reg__0[0]),
        .I3(LINK_TIMER_reg__0[2]),
        .I4(LINK_TIMER_reg__0[3]),
        .O(plusOp[4]));
LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
     \LINK_TIMER[5]_i_1 
       (.I0(LINK_TIMER_reg__0[5]),
        .I1(LINK_TIMER_reg__0[3]),
        .I2(LINK_TIMER_reg__0[2]),
        .I3(LINK_TIMER_reg__0[0]),
        .I4(LINK_TIMER_reg__0[1]),
        .I5(LINK_TIMER_reg__0[4]),
        .O(plusOp[5]));
LUT5 #(
    .INIT(32'h9AAAAAAA)) 
     \LINK_TIMER[6]_i_1 
       (.I0(LINK_TIMER_reg__0[6]),
        .I1(\n_0_LINK_TIMER[7]_i_2 ),
        .I2(LINK_TIMER_reg__0[4]),
        .I3(LINK_TIMER_reg__0[5]),
        .I4(LINK_TIMER_reg__0[3]),
        .O(plusOp[6]));
LUT6 #(
    .INIT(64'hAAAA6AAAAAAAAAAA)) 
     \LINK_TIMER[7]_i_1 
       (.I0(LINK_TIMER_reg__0[7]),
        .I1(LINK_TIMER_reg__0[3]),
        .I2(LINK_TIMER_reg__0[5]),
        .I3(LINK_TIMER_reg__0[4]),
        .I4(\n_0_LINK_TIMER[7]_i_2 ),
        .I5(LINK_TIMER_reg__0[6]),
        .O(plusOp[7]));
(* SOFT_HLUTNM = "soft_lutpair17" *) 
   LUT3 #(
    .INIT(8'h7F)) 
     \LINK_TIMER[7]_i_2 
       (.I0(LINK_TIMER_reg__0[1]),
        .I1(LINK_TIMER_reg__0[0]),
        .I2(LINK_TIMER_reg__0[2]),
        .O(\n_0_LINK_TIMER[7]_i_2 ));
LUT4 #(
    .INIT(16'hFFEA)) 
     \LINK_TIMER[8]_i_1 
       (.I0(START_LINK_TIMER_REG),
        .I1(LINK_TIMER_SATURATED),
        .I2(PULSE4096),
        .I3(I1),
        .O(\n_0_LINK_TIMER[8]_i_1 ));
LUT4 #(
    .INIT(16'h6AAA)) 
     \LINK_TIMER[8]_i_2 
       (.I0(LINK_TIMER_reg__0[8]),
        .I1(LINK_TIMER_reg__0[6]),
        .I2(\n_0_LINK_TIMER[8]_i_3 ),
        .I3(LINK_TIMER_reg__0[7]),
        .O(plusOp[8]));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     \LINK_TIMER[8]_i_3 
       (.I0(LINK_TIMER_reg__0[3]),
        .I1(LINK_TIMER_reg__0[5]),
        .I2(LINK_TIMER_reg__0[4]),
        .I3(LINK_TIMER_reg__0[2]),
        .I4(LINK_TIMER_reg__0[0]),
        .I5(LINK_TIMER_reg__0[1]),
        .O(\n_0_LINK_TIMER[8]_i_3 ));
LUT6 #(
    .INIT(64'h000000000000000E)) 
     LINK_TIMER_DONE_i_1
       (.I0(LINK_TIMER_DONE),
        .I1(LINK_TIMER_SATURATED),
        .I2(START_LINK_TIMER_REG),
        .I3(START_LINK_TIMER_REG2),
        .I4(I1),
        .I5(START_LINK_TIMER),
        .O(n_0_LINK_TIMER_DONE_i_1));
FDRE LINK_TIMER_DONE_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_LINK_TIMER_DONE_i_1),
        .Q(LINK_TIMER_DONE),
        .R(1'b0));
LUT3 #(
    .INIT(8'h02)) 
     LINK_TIMER_SATURATED_i_2
       (.I0(LINK_TIMER_reg__0[8]),
        .I1(LINK_TIMER_reg__0[7]),
        .I2(LINK_TIMER_reg__0[6]),
        .O(n_0_LINK_TIMER_SATURATED_i_2));
LUT3 #(
    .INIT(8'h80)) 
     LINK_TIMER_SATURATED_i_3
       (.I0(LINK_TIMER_reg__0[4]),
        .I1(LINK_TIMER_reg__0[5]),
        .I2(LINK_TIMER_reg__0[3]),
        .O(n_0_LINK_TIMER_SATURATED_i_3));
LUT3 #(
    .INIT(8'h08)) 
     LINK_TIMER_SATURATED_i_4
       (.I0(LINK_TIMER_reg__0[2]),
        .I1(LINK_TIMER_reg__0[0]),
        .I2(LINK_TIMER_reg__0[1]),
        .O(n_0_LINK_TIMER_SATURATED_i_4));
FDRE LINK_TIMER_SATURATED_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(LINK_TIMER_SATURATED_COMB),
        .Q(LINK_TIMER_SATURATED),
        .R(I1));
CARRY4 LINK_TIMER_SATURATED_reg_i_1
       (.CI(1'b0),
        .CO({NLW_LINK_TIMER_SATURATED_reg_i_1_CO_UNCONNECTED[3],LINK_TIMER_SATURATED_COMB,n_2_LINK_TIMER_SATURATED_reg_i_1,n_3_LINK_TIMER_SATURATED_reg_i_1}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_LINK_TIMER_SATURATED_reg_i_1_O_UNCONNECTED[3:0]),
        .S({1'b0,n_0_LINK_TIMER_SATURATED_i_2,n_0_LINK_TIMER_SATURATED_i_3,n_0_LINK_TIMER_SATURATED_i_4}));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[0] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[0]),
        .Q(LINK_TIMER_reg__0[0]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[1] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[1]),
        .Q(LINK_TIMER_reg__0[1]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[2] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[2]),
        .Q(LINK_TIMER_reg__0[2]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[3] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[3]),
        .Q(LINK_TIMER_reg__0[3]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[4] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[4]),
        .Q(LINK_TIMER_reg__0[4]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[5] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[5]),
        .Q(LINK_TIMER_reg__0[5]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[6] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[6]),
        .Q(LINK_TIMER_reg__0[6]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[7] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[7]),
        .Q(LINK_TIMER_reg__0[7]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* counter = "14" *) 
   FDRE \LINK_TIMER_reg[8] 
       (.C(userclk2),
        .CE(PULSE4096),
        .D(plusOp[8]),
        .Q(LINK_TIMER_reg__0[8]),
        .R(\n_0_LINK_TIMER[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT4 #(
    .INIT(16'h5155)) 
     \MASK_RUDI_BUFERR_TIMER[0]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[0]),
        .I1(data_out),
        .I2(Q[1]),
        .I3(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair3" *) 
   LUT5 #(
    .INIT(32'h66066666)) 
     \MASK_RUDI_BUFERR_TIMER[1]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[1]),
        .I1(MASK_RUDI_BUFERR_TIMER[0]),
        .I2(data_out),
        .I3(Q[1]),
        .I4(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1 ));
LUT6 #(
    .INIT(64'h7878007878787878)) 
     \MASK_RUDI_BUFERR_TIMER[2]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[1]),
        .I1(MASK_RUDI_BUFERR_TIMER[0]),
        .I2(MASK_RUDI_BUFERR_TIMER[2]),
        .I3(data_out),
        .I4(Q[1]),
        .I5(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT5 #(
    .INIT(32'h00007F80)) 
     \MASK_RUDI_BUFERR_TIMER[3]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[2]),
        .I1(MASK_RUDI_BUFERR_TIMER[0]),
        .I2(MASK_RUDI_BUFERR_TIMER[1]),
        .I3(MASK_RUDI_BUFERR_TIMER[3]),
        .I4(MASK_RUDI_BUFERR_TIMER0),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1 ));
LUT6 #(
    .INIT(64'h000000007FFF8000)) 
     \MASK_RUDI_BUFERR_TIMER[4]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[3]),
        .I1(MASK_RUDI_BUFERR_TIMER[2]),
        .I2(MASK_RUDI_BUFERR_TIMER[0]),
        .I3(MASK_RUDI_BUFERR_TIMER[1]),
        .I4(MASK_RUDI_BUFERR_TIMER[4]),
        .I5(MASK_RUDI_BUFERR_TIMER0),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1 ));
LUT6 #(
    .INIT(64'hD2D200D2D2D2D2D2)) 
     \MASK_RUDI_BUFERR_TIMER[5]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[4]),
        .I1(\n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2 ),
        .I2(MASK_RUDI_BUFERR_TIMER[5]),
        .I3(data_out),
        .I4(Q[1]),
        .I5(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair6" *) 
   LUT4 #(
    .INIT(16'h7FFF)) 
     \MASK_RUDI_BUFERR_TIMER[5]_i_2 
       (.I0(MASK_RUDI_BUFERR_TIMER[3]),
        .I1(MASK_RUDI_BUFERR_TIMER[2]),
        .I2(MASK_RUDI_BUFERR_TIMER[0]),
        .I3(MASK_RUDI_BUFERR_TIMER[1]),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[5]_i_2 ));
LUT5 #(
    .INIT(32'h99099999)) 
     \MASK_RUDI_BUFERR_TIMER[6]_i_1 
       (.I0(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I1(MASK_RUDI_BUFERR_TIMER[6]),
        .I2(data_out),
        .I3(Q[1]),
        .I4(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1 ));
LUT6 #(
    .INIT(64'hA6A600A6A6A6A6A6)) 
     \MASK_RUDI_BUFERR_TIMER[7]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[7]),
        .I1(MASK_RUDI_BUFERR_TIMER[6]),
        .I2(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I3(data_out),
        .I4(Q[1]),
        .I5(p_0_in),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1 ));
LUT5 #(
    .INIT(32'hFFFFF7FF)) 
     \MASK_RUDI_BUFERR_TIMER[8]_i_1 
       (.I0(MASK_RUDI_BUFERR_TIMER[7]),
        .I1(MASK_RUDI_BUFERR_TIMER[6]),
        .I2(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I3(MASK_RUDI_BUFERR_TIMER[8]),
        .I4(MASK_RUDI_BUFERR_TIMER0),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT5 #(
    .INIT(32'h0000F708)) 
     \MASK_RUDI_BUFERR_TIMER[8]_i_2 
       (.I0(MASK_RUDI_BUFERR_TIMER[7]),
        .I1(MASK_RUDI_BUFERR_TIMER[6]),
        .I2(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .I3(MASK_RUDI_BUFERR_TIMER[8]),
        .I4(MASK_RUDI_BUFERR_TIMER0),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2 ));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \MASK_RUDI_BUFERR_TIMER[8]_i_3 
       (.I0(MASK_RUDI_BUFERR_TIMER[4]),
        .I1(MASK_RUDI_BUFERR_TIMER[3]),
        .I2(MASK_RUDI_BUFERR_TIMER[2]),
        .I3(MASK_RUDI_BUFERR_TIMER[0]),
        .I4(MASK_RUDI_BUFERR_TIMER[1]),
        .I5(MASK_RUDI_BUFERR_TIMER[5]),
        .O(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[0] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[0]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[0]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[1] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[1]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[1]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[2] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[2]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[2]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[3] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[3]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[3]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[4] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[4]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[4]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[5] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[5]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[5]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[6] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[6]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[6]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[7] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[7]_i_1 ),
        .Q(MASK_RUDI_BUFERR_TIMER[7]),
        .S(I1));
FDSE \MASK_RUDI_BUFERR_TIMER_reg[8] 
       (.C(userclk2),
        .CE(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_1 ),
        .D(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_2 ),
        .Q(MASK_RUDI_BUFERR_TIMER[8]),
        .S(I1));
LUT5 #(
    .INIT(32'h00F700F0)) 
     MASK_RUDI_BUFERR_i_1
       (.I0(n_0_MASK_RUDI_BUFERR_i_2),
        .I1(MASK_RUDI_BUFERR_TIMER[8]),
        .I2(MASK_RUDI_BUFERR_TIMER0),
        .I3(I1),
        .I4(n_0_MASK_RUDI_BUFERR_reg),
        .O(n_0_MASK_RUDI_BUFERR_i_1));
(* SOFT_HLUTNM = "soft_lutpair2" *) 
   LUT3 #(
    .INIT(8'h08)) 
     MASK_RUDI_BUFERR_i_2
       (.I0(MASK_RUDI_BUFERR_TIMER[7]),
        .I1(MASK_RUDI_BUFERR_TIMER[6]),
        .I2(\n_0_MASK_RUDI_BUFERR_TIMER[8]_i_3 ),
        .O(n_0_MASK_RUDI_BUFERR_i_2));
FDRE MASK_RUDI_BUFERR_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_MASK_RUDI_BUFERR_i_1),
        .Q(n_0_MASK_RUDI_BUFERR_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFFFB0000FFF00000)) 
     MASK_RUDI_CLKCOR_i_1
       (.I0(RX_RUDI_INVALID),
        .I1(RX_RUDI_INVALID_REG),
        .I2(I9[0]),
        .I3(I9[1]),
        .I4(SYNC_STATUS_HELD),
        .I5(n_0_MASK_RUDI_CLKCOR_reg),
        .O(n_0_MASK_RUDI_CLKCOR_i_1));
FDRE MASK_RUDI_CLKCOR_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_MASK_RUDI_CLKCOR_i_1),
        .Q(n_0_MASK_RUDI_CLKCOR_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h2322222222222200)) 
     MR_AN_COMPLETE_i_1
       (.I0(an_interrupt),
        .I1(I1),
        .I2(\n_0_STATE_reg[3] ),
        .I3(\n_0_STATE_reg[0] ),
        .I4(\n_0_STATE_reg[1] ),
        .I5(\n_0_STATE_reg[2] ),
        .O(n_0_MR_AN_COMPLETE_i_1));
FDRE MR_AN_COMPLETE_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_MR_AN_COMPLETE_i_1),
        .Q(an_interrupt),
        .R(1'b0));
LUT2 #(
    .INIT(4'h6)) 
     MR_AN_ENABLE_CHANGE_i_1
       (.I0(MR_AN_ENABLE_REG1),
        .I1(MR_AN_ENABLE_REG2),
        .O(MR_AN_ENABLE_CHANGE0));
FDRE MR_AN_ENABLE_CHANGE_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(MR_AN_ENABLE_CHANGE0),
        .Q(MR_AN_ENABLE_CHANGE),
        .R(I1));
FDRE MR_AN_ENABLE_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(Q[3]),
        .Q(MR_AN_ENABLE_REG1),
        .R(I1));
FDRE MR_AN_ENABLE_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(MR_AN_ENABLE_REG1),
        .Q(MR_AN_ENABLE_REG2),
        .R(I1));
LUT2 #(
    .INIT(4'hE)) 
     \MR_LP_ADV_ABILITY_INT[9]_i_1 
       (.I0(I1),
        .I1(PREVIOUS_STATE),
        .O(\n_0_MR_LP_ADV_ABILITY_INT[9]_i_1 ));
FDRE \MR_LP_ADV_ABILITY_INT_reg[13] 
       (.C(userclk2),
        .CE(\n_0_MR_LP_ADV_ABILITY_INT[9]_i_1 ),
        .D(I5[12]),
        .Q(\n_0_MR_LP_ADV_ABILITY_INT_reg[13] ),
        .R(I1));
FDRE \MR_LP_ADV_ABILITY_INT_reg[14] 
       (.C(userclk2),
        .CE(\n_0_MR_LP_ADV_ABILITY_INT[9]_i_1 ),
        .D(I5[13]),
        .Q(\n_0_MR_LP_ADV_ABILITY_INT_reg[14] ),
        .R(I1));
FDRE \MR_LP_ADV_ABILITY_INT_reg[16] 
       (.C(userclk2),
        .CE(\n_0_MR_LP_ADV_ABILITY_INT[9]_i_1 ),
        .D(I5[15]),
        .Q(\n_0_MR_LP_ADV_ABILITY_INT_reg[16] ),
        .R(I1));
FDRE \MR_LP_ADV_ABILITY_INT_reg[6] 
       (.C(userclk2),
        .CE(\n_0_MR_LP_ADV_ABILITY_INT[9]_i_1 ),
        .D(I5[5]),
        .Q(STAT_VEC_DUPLEX_MODE_RSLVD_reg),
        .R(I1));
FDRE \MR_LP_ADV_ABILITY_INT_reg[8] 
       (.C(userclk2),
        .CE(\n_0_MR_LP_ADV_ABILITY_INT[9]_i_1 ),
        .D(I5[7]),
        .Q(status_vector[4]),
        .R(I1));
FDRE \MR_LP_ADV_ABILITY_INT_reg[9] 
       (.C(userclk2),
        .CE(\n_0_MR_LP_ADV_ABILITY_INT[9]_i_1 ),
        .D(I5[8]),
        .Q(status_vector[5]),
        .R(I1));
LUT5 #(
    .INIT(32'h55555400)) 
     MR_REMOTE_FAULT_i_1
       (.I0(I1),
        .I1(\n_0_MR_LP_ADV_ABILITY_INT_reg[13] ),
        .I2(\n_0_MR_LP_ADV_ABILITY_INT_reg[14] ),
        .I3(GENERATE_REMOTE_FAULT),
        .I4(status_vector[3]),
        .O(n_0_MR_REMOTE_FAULT_i_1));
FDRE MR_REMOTE_FAULT_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_MR_REMOTE_FAULT_i_1),
        .Q(status_vector[3]),
        .R(1'b0));
LUT6 #(
    .INIT(64'h1010331000003300)) 
     MR_RESTART_AN_INT_i_1
       (.I0(n_0_START_LINK_TIMER_REG_i_2),
        .I1(I1),
        .I2(Q[3]),
        .I3(MR_RESTART_AN_SET_REG1),
        .I4(MR_RESTART_AN_SET_REG2),
        .I5(n_0_MR_RESTART_AN_INT_reg),
        .O(n_0_MR_RESTART_AN_INT_i_1));
FDRE MR_RESTART_AN_INT_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_MR_RESTART_AN_INT_i_1),
        .Q(n_0_MR_RESTART_AN_INT_reg),
        .R(1'b0));
FDRE MR_RESTART_AN_SET_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RESTART_AN_SET),
        .Q(MR_RESTART_AN_SET_REG1),
        .R(I1));
FDRE MR_RESTART_AN_SET_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(MR_RESTART_AN_SET_REG1),
        .Q(MR_RESTART_AN_SET_REG2),
        .R(I1));
LUT2 #(
    .INIT(4'hB)) 
     \PREVIOUS_STATE[3]_i_1 
       (.I0(I1),
        .I1(I7),
        .O(STATE1));
FDRE \PREVIOUS_STATE_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_STATE_reg[0] ),
        .Q(\n_0_PREVIOUS_STATE_reg[0] ),
        .R(STATE1));
FDRE \PREVIOUS_STATE_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_STATE_reg[1] ),
        .Q(\n_0_PREVIOUS_STATE_reg[1] ),
        .R(STATE1));
FDRE \PREVIOUS_STATE_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_STATE_reg[2] ),
        .Q(\n_0_PREVIOUS_STATE_reg[2] ),
        .R(STATE1));
FDRE \PREVIOUS_STATE_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_STATE_reg[3] ),
        .Q(\n_0_PREVIOUS_STATE_reg[3] ),
        .R(STATE1));
LUT2 #(
    .INIT(4'h2)) 
     PULSE4096_i_1
       (.I0(TIMER4096_MSB_REG),
        .I1(\n_0_TIMER4096_reg[11] ),
        .O(PULSE40960));
FDRE PULSE4096_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(PULSE40960),
        .Q(PULSE4096),
        .R(I1));
FDRE RECEIVED_IDLE_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(I4),
        .Q(O2),
        .R(1'b0));
FDRE RUDI_INVALID_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_RUDI_INVALID_DELAY[1]),
        .Q(status_vector[0]),
        .R(I1));
FDRE RX_CONFIG_REG_NULL_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(I3),
        .Q(O1),
        .R(1'b0));
FDRE \RX_CONFIG_REG_REG_reg[0] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[0]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[0] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[10] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[10]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[10] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[11] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[11]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[11] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[12] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[12]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[12] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[13] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[13]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[13] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[14] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[14]),
        .Q(p_0_in38_in),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[15] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[15]),
        .Q(p_0_in0_in),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[1] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[1]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[1] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[2] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[2]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[2] ),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[3] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[3]),
        .Q(O5[0]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[4] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[4]),
        .Q(O5[1]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[5] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[5]),
        .Q(O5[2]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[6] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[6]),
        .Q(O5[3]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[7] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[7]),
        .Q(O5[4]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[8] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[8]),
        .Q(O5[5]),
        .R(SR));
FDRE \RX_CONFIG_REG_REG_reg[9] 
       (.C(userclk2),
        .CE(RX_CONFIG_VALID),
        .D(I5[9]),
        .Q(\n_0_RX_CONFIG_REG_REG_reg[9] ),
        .R(SR));
LUT6 #(
    .INIT(64'h0200000000000000)) 
     \RX_CONFIG_SNAPSHOT[15]_i_1 
       (.I0(\n_0_RX_CONFIG_SNAPSHOT[15]_i_2 ),
        .I1(ABILITY_MATCH),
        .I2(\n_0_RX_CONFIG_SNAPSHOT[15]_i_3 ),
        .I3(RX_CONFIG_VALID),
        .I4(ABILITY_MATCH_2),
        .I5(ABILITY_MATCH_22),
        .O(RX_CONFIG_SNAPSHOT));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_10 
       (.I0(\n_0_RX_CONFIG_REG_REG_reg[2] ),
        .I1(I5[2]),
        .I2(I5[0]),
        .I3(\n_0_RX_CONFIG_REG_REG_reg[0] ),
        .I4(I5[1]),
        .I5(\n_0_RX_CONFIG_REG_REG_reg[1] ),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_10 ));
(* SOFT_HLUTNM = "soft_lutpair5" *) 
   LUT5 #(
    .INIT(32'h00000041)) 
     \RX_CONFIG_SNAPSHOT[15]_i_2 
       (.I0(O2),
        .I1(I5[15]),
        .I2(p_0_in0_in),
        .I3(n_0_MASK_RUDI_BUFERR_reg),
        .I4(RX_IDLE),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT4 #(
    .INIT(16'h1000)) 
     \RX_CONFIG_SNAPSHOT[15]_i_3 
       (.I0(\n_0_STATE_reg[2] ),
        .I1(\n_0_STATE_reg[3] ),
        .I2(\n_0_STATE_reg[0] ),
        .I3(\n_0_STATE_reg[1] ),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_3 ));
LUT4 #(
    .INIT(16'h9009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_6 
       (.I0(\n_0_RX_CONFIG_REG_REG_reg[13] ),
        .I1(I5[13]),
        .I2(\n_0_RX_CONFIG_REG_REG_reg[12] ),
        .I3(I5[12]),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_6 ));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_7 
       (.I0(\n_0_RX_CONFIG_REG_REG_reg[9] ),
        .I1(I5[9]),
        .I2(I5[10]),
        .I3(\n_0_RX_CONFIG_REG_REG_reg[10] ),
        .I4(I5[11]),
        .I5(\n_0_RX_CONFIG_REG_REG_reg[11] ),
        .O(\n_0_RX_CONFIG_SNAPSHOT[15]_i_7 ));
FDRE \RX_CONFIG_SNAPSHOT_reg[0] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[0]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[0] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[10] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[10]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[10] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[11] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[11]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[11] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[12] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[12]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[12] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[13] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[13]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[13] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[15] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[15]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[15] ),
        .R(I1));
CARRY4 \RX_CONFIG_SNAPSHOT_reg[15]_i_4 
       (.CI(\n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ),
        .CO({\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_4_CO_UNCONNECTED [3:1],ABILITY_MATCH_22}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_4_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,\n_0_RX_CONFIG_SNAPSHOT[15]_i_6 }));
CARRY4 \RX_CONFIG_SNAPSHOT_reg[15]_i_5 
       (.CI(1'b0),
        .CO({\n_0_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ,\n_1_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ,\n_2_RX_CONFIG_SNAPSHOT_reg[15]_i_5 ,\n_3_RX_CONFIG_SNAPSHOT_reg[15]_i_5 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_RX_CONFIG_SNAPSHOT_reg[15]_i_5_O_UNCONNECTED [3:0]),
        .S({\n_0_RX_CONFIG_SNAPSHOT[15]_i_7 ,S,\n_0_RX_CONFIG_SNAPSHOT[15]_i_10 }));
FDRE \RX_CONFIG_SNAPSHOT_reg[1] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[1]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[1] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[2] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[2]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[2] ),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[3] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[3]),
        .Q(O6[0]),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[4] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[4]),
        .Q(O6[1]),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[5] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[5]),
        .Q(O6[2]),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[6] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[6]),
        .Q(O6[3]),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[7] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[7]),
        .Q(O6[4]),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[8] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[8]),
        .Q(O6[5]),
        .R(I1));
FDRE \RX_CONFIG_SNAPSHOT_reg[9] 
       (.C(userclk2),
        .CE(RX_CONFIG_SNAPSHOT),
        .D(I5[9]),
        .Q(\n_0_RX_CONFIG_SNAPSHOT_reg[9] ),
        .R(I1));
LUT6 #(
    .INIT(64'h00AB00AA00AA00AA)) 
     RX_DV_i_1
       (.I0(n_0_RX_DV_i_2),
        .I1(I10),
        .I2(EOP_REG1),
        .I3(I11),
        .I4(XMIT_DATA),
        .I5(gmii_rx_dv),
        .O(O4));
LUT4 #(
    .INIT(16'h0008)) 
     RX_DV_i_2
       (.I0(O3),
        .I1(SOP_REG3),
        .I2(Q[2]),
        .I3(Q[1]),
        .O(n_0_RX_DV_i_2));
FDRE RX_IDLE_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_IDLE),
        .Q(RX_IDLE_REG1),
        .R(I1));
FDRE RX_IDLE_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_IDLE_REG1),
        .Q(RX_IDLE_REG2),
        .R(I1));
LUT3 #(
    .INIT(8'h02)) 
     \RX_RUDI_INVALID_DELAY[0]_i_1 
       (.I0(RX_RUDI_INVALID),
        .I1(n_0_MASK_RUDI_BUFERR_reg),
        .I2(n_0_MASK_RUDI_CLKCOR_reg),
        .O(RX_RUDI_INVALID_DELAY0));
LUT6 #(
    .INIT(64'hAAAAAAEEAAEFAAEF)) 
     \RX_RUDI_INVALID_DELAY[0]_i_2 
       (.I0(I8),
        .I1(Q[3]),
        .I2(Q[0]),
        .I3(RXSYNC_STATUS),
        .I4(STAT_VEC_DUPLEX_MODE_RSLVD_reg),
        .I5(XMIT_DATA_INT),
        .O(RX_RUDI_INVALID));
FDRE \RX_RUDI_INVALID_DELAY_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_RUDI_INVALID_DELAY0),
        .Q(RX_RUDI_INVALID_DELAY[0]),
        .R(I1));
FDRE \RX_RUDI_INVALID_DELAY_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_RUDI_INVALID_DELAY[0]),
        .Q(RX_RUDI_INVALID_DELAY[1]),
        .R(I1));
FDRE RX_RUDI_INVALID_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(I2),
        .Q(RX_RUDI_INVALID_REG),
        .R(1'b0));
FDRE START_LINK_TIMER_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(START_LINK_TIMER_REG),
        .Q(START_LINK_TIMER_REG2),
        .R(I1));
LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
     START_LINK_TIMER_REG_i_1
       (.I0(START_LINK_TIMER114_out),
        .I1(Q[3]),
        .I2(n_0_START_LINK_TIMER_REG_i_2),
        .I3(\n_0_STATE[2]_i_2 ),
        .I4(n_0_START_LINK_TIMER_REG_i_3),
        .I5(n_0_START_LINK_TIMER_REG_i_4),
        .O(START_LINK_TIMER));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT4 #(
    .INIT(16'h0001)) 
     START_LINK_TIMER_REG_i_2
       (.I0(\n_0_STATE_reg[2] ),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[0] ),
        .I3(\n_0_STATE_reg[3] ),
        .O(n_0_START_LINK_TIMER_REG_i_2));
LUT6 #(
    .INIT(64'h00007F007F007F00)) 
     START_LINK_TIMER_REG_i_3
       (.I0(an_adv_config_vector[6]),
        .I1(D[7]),
        .I2(\n_0_MR_LP_ADV_ABILITY_INT_reg[16] ),
        .I3(LINK_TIMER_DONE),
        .I4(O1),
        .I5(ABILITY_MATCH),
        .O(n_0_START_LINK_TIMER_REG_i_3));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT4 #(
    .INIT(16'h0010)) 
     START_LINK_TIMER_REG_i_4
       (.I0(\n_0_STATE_reg[0] ),
        .I1(\n_0_STATE_reg[3] ),
        .I2(\n_0_STATE_reg[2] ),
        .I3(\n_0_STATE_reg[1] ),
        .O(n_0_START_LINK_TIMER_REG_i_4));
FDRE START_LINK_TIMER_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(START_LINK_TIMER),
        .Q(START_LINK_TIMER_REG),
        .R(I1));
LUT6 #(
    .INIT(64'h00000000FFFFFF04)) 
     \STATE[0]_i_1 
       (.I0(\n_0_STATE[0]_i_2 ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE_reg[3] ),
        .I3(\n_0_STATE[0]_i_3 ),
        .I4(\n_0_STATE[0]_i_4 ),
        .I5(\n_0_STATE[2]_i_5 ),
        .O(\n_0_STATE[0]_i_1 ));
LUT6 #(
    .INIT(64'hF3F3F3F3FFBFBFFF)) 
     \STATE[0]_i_2 
       (.I0(O1),
        .I1(\n_0_STATE_reg[1] ),
        .I2(ABILITY_MATCH),
        .I3(TOGGLE_RX),
        .I4(\n_0_RX_CONFIG_REG_REG_reg[11] ),
        .I5(\n_0_STATE_reg[0] ),
        .O(\n_0_STATE[0]_i_2 ));
LUT6 #(
    .INIT(64'h550030005500FC00)) 
     \STATE[0]_i_3 
       (.I0(\n_0_STATE[0]_i_5 ),
        .I1(\n_0_STATE_reg[0] ),
        .I2(Q[3]),
        .I3(\n_0_STATE[0]_i_6 ),
        .I4(\n_0_STATE_reg[1] ),
        .I5(LINK_TIMER_DONE),
        .O(\n_0_STATE[0]_i_3 ));
LUT6 #(
    .INIT(64'h0404040400000400)) 
     \STATE[0]_i_4 
       (.I0(\n_0_STATE_reg[1] ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE_reg[3] ),
        .I3(\n_0_STATE_reg[0] ),
        .I4(\n_0_STATE[0]_i_7 ),
        .I5(n_0_START_LINK_TIMER_REG_i_3),
        .O(\n_0_STATE[0]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT4 #(
    .INIT(16'hF833)) 
     \STATE[0]_i_5 
       (.I0(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .I1(\n_0_STATE_reg[0] ),
        .I2(O1),
        .I3(ABILITY_MATCH),
        .O(\n_0_STATE[0]_i_5 ));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT2 #(
    .INIT(4'h1)) 
     \STATE[0]_i_6 
       (.I0(\n_0_STATE_reg[3] ),
        .I1(\n_0_STATE_reg[2] ),
        .O(\n_0_STATE[0]_i_6 ));
LUT2 #(
    .INIT(4'h8)) 
     \STATE[0]_i_7 
       (.I0(O1),
        .I1(ABILITY_MATCH),
        .O(\n_0_STATE[0]_i_7 ));
(* SOFT_HLUTNM = "soft_lutpair7" *) 
   LUT5 #(
    .INIT(32'h0000AABA)) 
     \STATE[1]_i_1 
       (.I0(\n_0_STATE[1]_i_2 ),
        .I1(\n_0_STATE_reg[3] ),
        .I2(\n_0_STATE_reg[2] ),
        .I3(\n_0_STATE[1]_i_3 ),
        .I4(\n_0_STATE[2]_i_5 ),
        .O(\n_0_STATE[1]_i_1 ));
LUT6 #(
    .INIT(64'h0103030001000300)) 
     \STATE[1]_i_2 
       (.I0(\n_0_STATE[1]_i_4 ),
        .I1(\n_0_STATE_reg[3] ),
        .I2(\n_0_STATE_reg[2] ),
        .I3(\n_0_STATE_reg[1] ),
        .I4(\n_0_STATE_reg[0] ),
        .I5(LINK_TIMER_DONE),
        .O(\n_0_STATE[1]_i_2 ));
LUT6 #(
    .INIT(64'hFFFF1555BF551555)) 
     \STATE[1]_i_3 
       (.I0(\n_0_STATE_reg[1] ),
        .I1(IDLE_MATCH),
        .I2(LINK_TIMER_DONE),
        .I3(\n_0_STATE_reg[0] ),
        .I4(ABILITY_MATCH),
        .I5(O1),
        .O(\n_0_STATE[1]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT3 #(
    .INIT(8'hE0)) 
     \STATE[1]_i_4 
       (.I0(O1),
        .I1(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .I2(ABILITY_MATCH),
        .O(\n_0_STATE[1]_i_4 ));
LUT6 #(
    .INIT(64'h00000000FFFFBFAA)) 
     \STATE[2]_i_1 
       (.I0(\n_0_STATE[2]_i_2 ),
        .I1(O1),
        .I2(ABILITY_MATCH),
        .I3(\n_0_STATE[2]_i_3 ),
        .I4(\n_0_STATE[2]_i_4 ),
        .I5(\n_0_STATE[2]_i_5 ),
        .O(\n_0_STATE[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair1" *) 
   LUT5 #(
    .INIT(32'h00800000)) 
     \STATE[2]_i_2 
       (.I0(\n_0_RX_CONFIG_SNAPSHOT[15]_i_3 ),
        .I1(n_0_ACKNOWLEDGE_MATCH_3_reg),
        .I2(CONSISTENCY_MATCH),
        .I3(O1),
        .I4(ABILITY_MATCH),
        .O(\n_0_STATE[2]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT3 #(
    .INIT(8'h04)) 
     \STATE[2]_i_3 
       (.I0(\n_0_STATE_reg[3] ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE_reg[1] ),
        .O(\n_0_STATE[2]_i_3 ));
LUT6 #(
    .INIT(64'h0404000400040404)) 
     \STATE[2]_i_4 
       (.I0(\n_0_STATE_reg[3] ),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE[2]_i_6 ),
        .I3(ABILITY_MATCH),
        .I4(TOGGLE_RX),
        .I5(\n_0_RX_CONFIG_REG_REG_reg[11] ),
        .O(\n_0_STATE[2]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair19" *) 
   LUT3 #(
    .INIT(8'hFB)) 
     \STATE[2]_i_5 
       (.I0(START_LINK_TIMER114_out),
        .I1(I7),
        .I2(I1),
        .O(\n_0_STATE[2]_i_5 ));
(* SOFT_HLUTNM = "soft_lutpair11" *) 
   LUT4 #(
    .INIT(16'hFB33)) 
     \STATE[2]_i_6 
       (.I0(\n_0_STATE_reg[0] ),
        .I1(\n_0_STATE_reg[1] ),
        .I2(O1),
        .I3(ABILITY_MATCH),
        .O(\n_0_STATE[2]_i_6 ));
LUT6 #(
    .INIT(64'h00002E2200000000)) 
     \STATE[3]_i_1 
       (.I0(NEXT_STATE),
        .I1(START_LINK_TIMER114_out),
        .I2(Q[3]),
        .I3(AN_SYNC_STATUS),
        .I4(I1),
        .I5(I7),
        .O(\n_0_STATE[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair4" *) 
   LUT5 #(
    .INIT(32'h00030001)) 
     \STATE[3]_i_2 
       (.I0(Q[3]),
        .I1(\n_0_STATE_reg[2] ),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[0] ),
        .I4(\n_0_STATE_reg[3] ),
        .O(NEXT_STATE));
LUT6 #(
    .INIT(64'hFFFFFFFF10101000)) 
     \STATE[3]_i_3 
       (.I0(n_0_MASK_RUDI_CLKCOR_reg),
        .I1(n_0_MASK_RUDI_BUFERR_reg),
        .I2(XMIT_CONFIG_INT),
        .I3(\n_0_STATE[3]_i_4 ),
        .I4(I8),
        .I5(\n_0_STATE[3]_i_5 ),
        .O(START_LINK_TIMER114_out));
(* SOFT_HLUTNM = "soft_lutpair0" *) 
   LUT5 #(
    .INIT(32'h07070005)) 
     \STATE[3]_i_4 
       (.I0(XMIT_DATA_INT),
        .I1(STAT_VEC_DUPLEX_MODE_RSLVD_reg),
        .I2(RXSYNC_STATUS),
        .I3(Q[0]),
        .I4(Q[3]),
        .O(\n_0_STATE[3]_i_4 ));
LUT3 #(
    .INIT(8'hFB)) 
     \STATE[3]_i_5 
       (.I0(MR_AN_ENABLE_CHANGE),
        .I1(AN_SYNC_STATUS),
        .I2(n_0_MR_RESTART_AN_INT_reg),
        .O(\n_0_STATE[3]_i_5 ));
FDRE \STATE_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_STATE[0]_i_1 ),
        .Q(\n_0_STATE_reg[0] ),
        .R(1'b0));
FDRE \STATE_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_STATE[1]_i_1 ),
        .Q(\n_0_STATE_reg[1] ),
        .R(1'b0));
FDRE \STATE_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_STATE[2]_i_1 ),
        .Q(\n_0_STATE_reg[2] ),
        .R(1'b0));
FDRE \STATE_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_STATE[3]_i_1 ),
        .Q(\n_0_STATE_reg[3] ),
        .R(1'b0));
LUT6 #(
    .INIT(64'h8888008800800080)) 
     STATUS_VECTOR_0_PRE_i_1
       (.I0(I7),
        .I1(RXSYNC_STATUS),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(STAT_VEC_DUPLEX_MODE_RSLVD_reg),
        .I5(XMIT_DATA_INT),
        .O(STATUS_VECTOR_0_PRE0));
LUT5 #(
    .INIT(32'h00BF00AA)) 
     SYNC_STATUS_HELD_i_1
       (.I0(RXSYNC_STATUS),
        .I1(LINK_TIMER_SATURATED),
        .I2(PULSE4096),
        .I3(I1),
        .I4(SYNC_STATUS_HELD__0),
        .O(n_0_SYNC_STATUS_HELD_i_1));
FDRE SYNC_STATUS_HELD_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_SYNC_STATUS_HELD_i_1),
        .Q(SYNC_STATUS_HELD__0),
        .R(1'b0));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[0]_i_2 
       (.I0(\n_0_TIMER4096_reg[3] ),
        .O(\n_0_TIMER4096[0]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[0]_i_3 
       (.I0(\n_0_TIMER4096_reg[2] ),
        .O(\n_0_TIMER4096[0]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[0]_i_4 
       (.I0(\n_0_TIMER4096_reg[1] ),
        .O(\n_0_TIMER4096[0]_i_4 ));
LUT1 #(
    .INIT(2'h1)) 
     \TIMER4096[0]_i_5 
       (.I0(\n_0_TIMER4096_reg[0] ),
        .O(\n_0_TIMER4096[0]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[4]_i_2 
       (.I0(\n_0_TIMER4096_reg[7] ),
        .O(\n_0_TIMER4096[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[4]_i_3 
       (.I0(\n_0_TIMER4096_reg[6] ),
        .O(\n_0_TIMER4096[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[4]_i_4 
       (.I0(\n_0_TIMER4096_reg[5] ),
        .O(\n_0_TIMER4096[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[4]_i_5 
       (.I0(\n_0_TIMER4096_reg[4] ),
        .O(\n_0_TIMER4096[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[8]_i_2 
       (.I0(\n_0_TIMER4096_reg[11] ),
        .O(\n_0_TIMER4096[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[8]_i_3 
       (.I0(\n_0_TIMER4096_reg[10] ),
        .O(\n_0_TIMER4096[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[8]_i_4 
       (.I0(\n_0_TIMER4096_reg[9] ),
        .O(\n_0_TIMER4096[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \TIMER4096[8]_i_5 
       (.I0(\n_0_TIMER4096_reg[8] ),
        .O(\n_0_TIMER4096[8]_i_5 ));
FDRE TIMER4096_MSB_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_TIMER4096_reg[11] ),
        .Q(TIMER4096_MSB_REG),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_7_TIMER4096_reg[0]_i_1 ),
        .Q(\n_0_TIMER4096_reg[0] ),
        .R(I1));
CARRY4 \TIMER4096_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\n_0_TIMER4096_reg[0]_i_1 ,\n_1_TIMER4096_reg[0]_i_1 ,\n_2_TIMER4096_reg[0]_i_1 ,\n_3_TIMER4096_reg[0]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_TIMER4096_reg[0]_i_1 ,\n_5_TIMER4096_reg[0]_i_1 ,\n_6_TIMER4096_reg[0]_i_1 ,\n_7_TIMER4096_reg[0]_i_1 }),
        .S({\n_0_TIMER4096[0]_i_2 ,\n_0_TIMER4096[0]_i_3 ,\n_0_TIMER4096[0]_i_4 ,\n_0_TIMER4096[0]_i_5 }));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[10] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_5_TIMER4096_reg[8]_i_1 ),
        .Q(\n_0_TIMER4096_reg[10] ),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[11] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_4_TIMER4096_reg[8]_i_1 ),
        .Q(\n_0_TIMER4096_reg[11] ),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_6_TIMER4096_reg[0]_i_1 ),
        .Q(\n_0_TIMER4096_reg[1] ),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_5_TIMER4096_reg[0]_i_1 ),
        .Q(\n_0_TIMER4096_reg[2] ),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_4_TIMER4096_reg[0]_i_1 ),
        .Q(\n_0_TIMER4096_reg[3] ),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_7_TIMER4096_reg[4]_i_1 ),
        .Q(\n_0_TIMER4096_reg[4] ),
        .R(I1));
CARRY4 \TIMER4096_reg[4]_i_1 
       (.CI(\n_0_TIMER4096_reg[0]_i_1 ),
        .CO({\n_0_TIMER4096_reg[4]_i_1 ,\n_1_TIMER4096_reg[4]_i_1 ,\n_2_TIMER4096_reg[4]_i_1 ,\n_3_TIMER4096_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_TIMER4096_reg[4]_i_1 ,\n_5_TIMER4096_reg[4]_i_1 ,\n_6_TIMER4096_reg[4]_i_1 ,\n_7_TIMER4096_reg[4]_i_1 }),
        .S({\n_0_TIMER4096[4]_i_2 ,\n_0_TIMER4096[4]_i_3 ,\n_0_TIMER4096[4]_i_4 ,\n_0_TIMER4096[4]_i_5 }));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_6_TIMER4096_reg[4]_i_1 ),
        .Q(\n_0_TIMER4096_reg[5] ),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_5_TIMER4096_reg[4]_i_1 ),
        .Q(\n_0_TIMER4096_reg[6] ),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_4_TIMER4096_reg[4]_i_1 ),
        .Q(\n_0_TIMER4096_reg[7] ),
        .R(I1));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[8] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_7_TIMER4096_reg[8]_i_1 ),
        .Q(\n_0_TIMER4096_reg[8] ),
        .R(I1));
CARRY4 \TIMER4096_reg[8]_i_1 
       (.CI(\n_0_TIMER4096_reg[4]_i_1 ),
        .CO({\NLW_TIMER4096_reg[8]_i_1_CO_UNCONNECTED [3],\n_1_TIMER4096_reg[8]_i_1 ,\n_2_TIMER4096_reg[8]_i_1 ,\n_3_TIMER4096_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_TIMER4096_reg[8]_i_1 ,\n_5_TIMER4096_reg[8]_i_1 ,\n_6_TIMER4096_reg[8]_i_1 ,\n_7_TIMER4096_reg[8]_i_1 }),
        .S({\n_0_TIMER4096[8]_i_2 ,\n_0_TIMER4096[8]_i_3 ,\n_0_TIMER4096[8]_i_4 ,\n_0_TIMER4096[8]_i_5 }));
(* counter = "13" *) 
   FDRE \TIMER4096_reg[9] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_6_TIMER4096_reg[8]_i_1 ),
        .Q(\n_0_TIMER4096_reg[9] ),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair20" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     TOGGLE_RX_i_1
       (.I0(I5[11]),
        .I1(PREVIOUS_STATE),
        .I2(TOGGLE_RX),
        .O(n_0_TOGGLE_RX_i_1));
FDRE TOGGLE_RX_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_TOGGLE_RX_i_1),
        .Q(TOGGLE_RX),
        .R(I1));
LUT6 #(
    .INIT(64'hBA33BB338ACC88CC)) 
     TOGGLE_TX_i_1
       (.I0(an_adv_config_vector[3]),
        .I1(PREVIOUS_STATE),
        .I2(\n_0_STATE_reg[2] ),
        .I3(\n_0_STATE_reg[1] ),
        .I4(n_0_XMIT_CONFIG_INT_i_3),
        .I5(TOGGLE_TX),
        .O(n_0_TOGGLE_TX_i_1));
FDRE TOGGLE_TX_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_TOGGLE_TX_i_1),
        .Q(TOGGLE_TX),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT2 #(
    .INIT(4'h8)) 
     \TX_CONFIG_REG_INT[11]_i_1 
       (.I0(\n_0_STATE_reg[2] ),
        .I1(TOGGLE_TX),
        .O(\n_0_TX_CONFIG_REG_INT[11]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT3 #(
    .INIT(8'h08)) 
     \TX_CONFIG_REG_INT[12]_i_1 
       (.I0(an_adv_config_vector[4]),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[2] ),
        .O(\n_0_TX_CONFIG_REG_INT[12]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair16" *) 
   LUT3 #(
    .INIT(8'h08)) 
     \TX_CONFIG_REG_INT[13]_i_1 
       (.I0(an_adv_config_vector[5]),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[2] ),
        .O(\n_0_TX_CONFIG_REG_INT[13]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair9" *) 
   LUT5 #(
    .INIT(32'hEFEE0040)) 
     \TX_CONFIG_REG_INT[14]_i_1 
       (.I0(\n_0_STATE_reg[3] ),
        .I1(\n_0_STATE_reg[0] ),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[2] ),
        .I4(D[6]),
        .O(\n_0_TX_CONFIG_REG_INT[14]_i_1 ));
LUT4 #(
    .INIT(16'h000D)) 
     \TX_CONFIG_REG_INT[15]_i_1 
       (.I0(\n_0_STATE_reg[2] ),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[0] ),
        .I3(\n_0_STATE_reg[3] ),
        .O(\n_0_TX_CONFIG_REG_INT[15]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair18" *) 
   LUT3 #(
    .INIT(8'h08)) 
     \TX_CONFIG_REG_INT[15]_i_2 
       (.I0(an_adv_config_vector[6]),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[2] ),
        .O(\n_0_TX_CONFIG_REG_INT[15]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT3 #(
    .INIT(8'h08)) 
     \TX_CONFIG_REG_INT[5]_i_1 
       (.I0(an_adv_config_vector[0]),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[2] ),
        .O(\n_0_TX_CONFIG_REG_INT[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair14" *) 
   LUT3 #(
    .INIT(8'h08)) 
     \TX_CONFIG_REG_INT[7]_i_1 
       (.I0(an_adv_config_vector[1]),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[2] ),
        .O(\n_0_TX_CONFIG_REG_INT[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair15" *) 
   LUT3 #(
    .INIT(8'h08)) 
     \TX_CONFIG_REG_INT[8]_i_1 
       (.I0(an_adv_config_vector[2]),
        .I1(\n_0_STATE_reg[1] ),
        .I2(\n_0_STATE_reg[2] ),
        .O(\n_0_TX_CONFIG_REG_INT[8]_i_1 ));
FDRE \TX_CONFIG_REG_INT_reg[11] 
       (.C(userclk2),
        .CE(\n_0_TX_CONFIG_REG_INT[15]_i_1 ),
        .D(\n_0_TX_CONFIG_REG_INT[11]_i_1 ),
        .Q(D[3]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[12] 
       (.C(userclk2),
        .CE(\n_0_TX_CONFIG_REG_INT[15]_i_1 ),
        .D(\n_0_TX_CONFIG_REG_INT[12]_i_1 ),
        .Q(D[4]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[13] 
       (.C(userclk2),
        .CE(\n_0_TX_CONFIG_REG_INT[15]_i_1 ),
        .D(\n_0_TX_CONFIG_REG_INT[13]_i_1 ),
        .Q(D[5]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[14] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_TX_CONFIG_REG_INT[14]_i_1 ),
        .Q(D[6]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[15] 
       (.C(userclk2),
        .CE(\n_0_TX_CONFIG_REG_INT[15]_i_1 ),
        .D(\n_0_TX_CONFIG_REG_INT[15]_i_2 ),
        .Q(D[7]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[5] 
       (.C(userclk2),
        .CE(\n_0_TX_CONFIG_REG_INT[15]_i_1 ),
        .D(\n_0_TX_CONFIG_REG_INT[5]_i_1 ),
        .Q(D[0]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[7] 
       (.C(userclk2),
        .CE(\n_0_TX_CONFIG_REG_INT[15]_i_1 ),
        .D(\n_0_TX_CONFIG_REG_INT[7]_i_1 ),
        .Q(D[1]),
        .R(I1));
FDRE \TX_CONFIG_REG_INT_reg[8] 
       (.C(userclk2),
        .CE(\n_0_TX_CONFIG_REG_INT[15]_i_1 ),
        .D(\n_0_TX_CONFIG_REG_INT[8]_i_1 ),
        .Q(D[2]),
        .R(I1));
LUT6 #(
    .INIT(64'hFFFFFFFFAAAEAAAA)) 
     XMIT_CONFIG_INT_i_1__0
       (.I0(n_0_XMIT_CONFIG_INT_i_2__0),
        .I1(n_0_XMIT_CONFIG_INT_i_3),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[2] ),
        .I4(Q[3]),
        .I5(I1),
        .O(n_0_XMIT_CONFIG_INT_i_1__0));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT3 #(
    .INIT(8'h8A)) 
     XMIT_CONFIG_INT_i_2
       (.I0(XMIT_CONFIG_INT),
        .I1(Q[3]),
        .I2(Q[0]),
        .O(XMIT_CONFIG));
LUT6 #(
    .INIT(64'hAAAAAAA0AA0AAAA8)) 
     XMIT_CONFIG_INT_i_2__0
       (.I0(XMIT_CONFIG_INT),
        .I1(Q[3]),
        .I2(\n_0_STATE_reg[2] ),
        .I3(\n_0_STATE_reg[1] ),
        .I4(\n_0_STATE_reg[0] ),
        .I5(\n_0_STATE_reg[3] ),
        .O(n_0_XMIT_CONFIG_INT_i_2__0));
LUT2 #(
    .INIT(4'h1)) 
     XMIT_CONFIG_INT_i_3
       (.I0(\n_0_STATE_reg[3] ),
        .I1(\n_0_STATE_reg[0] ),
        .O(n_0_XMIT_CONFIG_INT_i_3));
FDRE XMIT_CONFIG_INT_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_XMIT_CONFIG_INT_i_1__0),
        .Q(XMIT_CONFIG_INT),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair13" *) 
   LUT4 #(
    .INIT(16'hF322)) 
     XMIT_DATA_INT_i_1
       (.I0(Q[0]),
        .I1(Q[3]),
        .I2(STAT_VEC_DUPLEX_MODE_RSLVD_reg),
        .I3(XMIT_DATA_INT),
        .O(XMIT_DATA));
(* SOFT_HLUTNM = "soft_lutpair12" *) 
   LUT4 #(
    .INIT(16'h2004)) 
     XMIT_DATA_INT_i_1__0
       (.I0(\n_0_STATE_reg[2] ),
        .I1(\n_0_STATE_reg[3] ),
        .I2(\n_0_STATE_reg[1] ),
        .I3(\n_0_STATE_reg[0] ),
        .O(XMIT_DATA_INT0));
FDRE XMIT_DATA_INT_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(XMIT_DATA_INT0),
        .Q(XMIT_DATA_INT),
        .R(I1));
endmodule

(* ORIG_REF_NAME = "GPCS_PMA_GEN" *) 
module gig_ethernet_pcs_pma_1GPCS_PMA_GEN
   (SR,
    O1,
    gmii_rx_er,
    status_vector,
    txchardispmode,
    txcharisk,
    encommaalign,
    gmii_rx_dv,
    an_interrupt,
    txchardispval,
    Q,
    O2,
    gmii_rxd,
    D,
    userclk2,
    gmii_tx_en,
    gmii_tx_er,
    gt0_rxnotintable_out,
    rxbuferr,
    txbuferr,
    gt0_rxdisperr_out,
    an_restart_config,
    reset,
    mmcm_locked,
    gmii_txd,
    data_out,
    an_adv_config_vector,
    gt0_rxcharisk_out,
    gt0_rxchariscomma_out,
    toggle,
    I1,
    signal_detect,
    configuration_vector,
    I2);
  output [0:0]SR;
  output [0:0]O1;
  output gmii_rx_er;
  output [12:0]status_vector;
  output txchardispmode;
  output txcharisk;
  output encommaalign;
  output gmii_rx_dv;
  output an_interrupt;
  output txchardispval;
  output [1:0]Q;
  output O2;
  output [7:0]gmii_rxd;
  output [7:0]D;
  input userclk2;
  input gmii_tx_en;
  input gmii_tx_er;
  input [0:0]gt0_rxnotintable_out;
  input rxbuferr;
  input txbuferr;
  input [0:0]gt0_rxdisperr_out;
  input an_restart_config;
  input reset;
  input mmcm_locked;
  input [7:0]gmii_txd;
  input data_out;
  input [6:0]an_adv_config_vector;
  input [0:0]gt0_rxcharisk_out;
  input [0:0]gt0_rxchariscomma_out;
  input toggle;
  input [7:0]I1;
  input signal_detect;
  input [4:0]configuration_vector;
  input [1:0]I2;

  wire AN_ENABLE_INT;
  wire [7:0]D;
  wire DUPLEX_MODE_RSLVD_REG;
  wire D_1;
  wire EOP_REG1;
  wire [7:0]I1;
  wire [1:0]I2;
  wire K28p5_REG1;
  wire LOOPBACK_INT;
  wire MASK_RUDI_BUFERR_TIMER0;
  wire MGT_RX_RESET_INT;
  wire MGT_TX_RESET_INT;
  wire [0:0]O1;
  wire O2;
  wire [1:0]Q;
  wire Q_0;
  wire RESET_INT;
  wire RESET_INT_PIPE;
  wire RESTART_AN_EN;
  wire RESTART_AN_EN_REG;
  wire RESTART_AN_SET;
  wire RXEVEN;
  wire RXNOTINTABLE_INT;
  wire RXNOTINTABLE_SRL;
  wire RXSYNC_STATUS;
  wire [15:0]RX_CONFIG_REG;
  wire RX_CONFIG_REG_REG0;
  wire RX_CONFIG_VALID;
  wire RX_IDLE;
  wire RX_RUDI_INVALID;
  wire SIGNAL_DETECT_MOD;
  wire SOP_REG3;
  wire [0:0]SR;
  wire SRESET_PIPE;
  wire STATUS_VECTOR_0_PRE;
  wire STATUS_VECTOR_0_PRE0;
  wire STAT_VEC_DUPLEX_MODE_RSLVD_reg;
  wire SYNC_STATUS_HELD;
  wire SYNC_STATUS_REG;
  wire SYNC_STATUS_REG0;
  wire TXBUFERR_INT;
  wire [15:15]TX_CONFIG_REG;
  wire XMIT_CONFIG;
  wire XMIT_DATA;
  wire [6:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire data_out;
  wire data_out_2;
  wire encommaalign;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire [0:0]gt0_rxchariscomma_out;
  wire [0:0]gt0_rxcharisk_out;
  wire [0:0]gt0_rxdisperr_out;
  wire [0:0]gt0_rxnotintable_out;
  wire mmcm_locked;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[10]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[11]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[12]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[14]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_5 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_3 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_4 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_5 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_6 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_7 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_8 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_9 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[3]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[4]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[6]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[7]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[8]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_3 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[15] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[1] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[10]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[11]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[12]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[14]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_5 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_3 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_4 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_5 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_6 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_7 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_8 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_9 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[3]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[4]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[6]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[7]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[8]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_1 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_2 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_3 ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[15] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[1] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ;
  wire \n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ;
  wire \n_0_MGT_RESET.RESET_INT_i_1 ;
  wire \n_0_MGT_RESET.SRESET_reg ;
  wire \n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] ;
  wire \n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1 ;
  wire n_0_TRANSMITTER;
  wire \n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_2 ;
  wire \n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_3 ;
  wire \n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_4 ;
  wire \n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_5 ;
  wire \n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_6 ;
  wire \n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_7 ;
  wire \n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_8 ;
  wire \n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_2 ;
  wire \n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_3 ;
  wire \n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_4 ;
  wire \n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_5 ;
  wire \n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_6 ;
  wire \n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_7 ;
  wire \n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_8 ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7] ;
  wire \n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 ;
  wire \n_10_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_10_RECEIVER;
  wire n_10_TRANSMITTER;
  wire n_11_TRANSMITTER;
  wire n_12_TRANSMITTER;
  wire n_13_TRANSMITTER;
  wire n_14_TRANSMITTER;
  wire n_15_TRANSMITTER;
  wire \n_16_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_16_TRANSMITTER;
  wire \n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_17_TRANSMITTER;
  wire \n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_18_TRANSMITTER;
  wire \n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_19_TRANSMITTER;
  wire n_1_TRANSMITTER;
  wire \n_20_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_20_TRANSMITTER;
  wire \n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_21_TRANSMITTER;
  wire \n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire \n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire \n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire \n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire \n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire \n_27_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire \n_28_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_28_RECEIVER;
  wire \n_29_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_29_RECEIVER;
  wire n_2_TRANSMITTER;
  wire \n_30_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_30_RECEIVER;
  wire \n_31_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_31_RECEIVER;
  wire \n_32_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_32_RECEIVER;
  wire \n_33_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_33_RECEIVER;
  wire \n_34_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire \n_35_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_3_SYNCHRONISATION;
  wire n_3_TRANSMITTER;
  wire n_4_TRANSMITTER;
  wire n_5_SYNCHRONISATION;
  wire n_5_TRANSMITTER;
  wire \n_6_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_6_TRANSMITTER;
  wire \n_7_HAS_AUTO_NEG.AUTO_NEGOTIATION ;
  wire n_7_SYNCHRONISATION;
  wire n_7_TRANSMITTER;
  wire n_8_RECEIVER;
  wire n_8_SYNCHRONISATION;
  wire n_8_TRANSMITTER;
  wire n_9_TRANSMITTER;
  wire p_0_in;
  wire p_0_out;
  wire p_1_out;
  wire reset;
  wire rxbuferr;
  wire signal_detect;
  wire [12:0]status_vector;
  wire toggle;
  wire txbuferr;
  wire txchardispmode;
  wire txchardispval;
  wire txcharisk;
  wire userclk2;

(* XILINX_LEGACY_PRIM = "SRL16" *) 
   (* box_type = "PRIMITIVE" *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/DELAY_RXDISPERR " *) 
   SRL16E #(
    .INIT(16'h0000)) 
     DELAY_RXDISPERR
       (.A0(1'b0),
        .A1(1'b0),
        .A2(1'b1),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(D_1),
        .Q(Q_0));
(* XILINX_LEGACY_PRIM = "SRL16" *) 
   (* box_type = "PRIMITIVE" *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/DELAY_RXNOTINTABLE " *) 
   SRL16E #(
    .INIT(16'h0000)) 
     DELAY_RXNOTINTABLE
       (.A0(1'b0),
        .A1(1'b0),
        .A2(1'b1),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(RXNOTINTABLE_INT),
        .Q(RXNOTINTABLE_SRL));
FDRE #(
    .INIT(1'b0)) 
     DUPLEX_MODE_RSLVD_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(STAT_VEC_DUPLEX_MODE_RSLVD_reg),
        .Q(DUPLEX_MODE_RSLVD_REG),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[10]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair70" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[11]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[11]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[12]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[12]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair73" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_2 ));
LUT6 #(
    .INIT(64'h0000000000040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[14]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_5 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[14]_i_1 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_1 
       (.I0(p_0_in),
        .I1(RESET_INT),
        .O(p_0_out));
LUT6 #(
    .INIT(64'h0000000000040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_5 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[15] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[1] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_5 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_5 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFE9)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_2 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_3 ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_4 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_5 ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_6 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_3 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFFFEFEFEFEFE)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_4 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_7 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[1] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[15] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFEEE0EEE0EEE0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_5 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_5 ));
LUT6 #(
    .INIT(64'hFFFFFFF8FFF8F8F8)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_6 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_8 ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_9 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_6 ));
LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_7 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_7 ));
(* SOFT_HLUTNM = "soft_lutpair75" *) 
   LUT5 #(
    .INIT(32'hFEFEFE00)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_8 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_8 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_9 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_9 ));
LUT6 #(
    .INIT(64'h0000001000000000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[3]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[3]_i_1 ));
LUT6 #(
    .INIT(64'h0000000400000000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[4]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[4]_i_1 ));
LUT6 #(
    .INIT(64'h0000000400000000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair71" *) 
   LUT5 #(
    .INIT(32'h00000002)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[6]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair78" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[7]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair77" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[8]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[15] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[1] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_3 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_3 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_3 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[10]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[11]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[12]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[14]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[15] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_2 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[15] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[1]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[1] ),
        .R(p_0_out));
FDSE #(
    .INIT(1'b1)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(1'b0),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .S(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[3]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[4]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[5]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[6]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[7]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[8]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .R(p_0_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .R(p_0_out));
(* SOFT_HLUTNM = "soft_lutpair81" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[10]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair81" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[11]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[11]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair82" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[12]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[12]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair82" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_2 ));
LUT6 #(
    .INIT(64'h0000000000040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[14]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_5 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[14]_i_1 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_1 
       (.I0(RESET_INT),
        .I1(TXBUFERR_INT),
        .O(p_1_out));
LUT6 #(
    .INIT(64'h0000000000040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_5 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair85" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[15] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[1] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_5 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_5 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFE9)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_2 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_3 ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_4 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_5 ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_6 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair83" *) 
   LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair80" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_3 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFFFEFEFEFEFE)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_4 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_7 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[1] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[15] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFEEE0EEE0EEE0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_5 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_5 ));
LUT6 #(
    .INIT(64'hFFFFFFF8FFF8F8F8)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_6 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_8 ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_9 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_6 ));
LUT6 #(
    .INIT(64'hFFFFF888F888F888)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_7 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_7 ));
(* SOFT_HLUTNM = "soft_lutpair83" *) 
   LUT5 #(
    .INIT(32'hFEFEFE00)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_8 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_8 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_9 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_9 ));
LUT6 #(
    .INIT(64'h0000001000000000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[3]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[3]_i_1 ));
LUT6 #(
    .INIT(64'h0000000400000000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[4]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[4]_i_1 ));
LUT6 #(
    .INIT(64'h0000000400000000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair85" *) 
   LUT5 #(
    .INIT(32'h00000002)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair80" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[6]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair79" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[7]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair79" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[8]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[8]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_1 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_2 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_2 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[15] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[1] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_3 ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair84" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_3 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .O(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_3 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[10]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[11]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[12]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[14]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[15] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_2 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[15] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[1]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[1] ),
        .R(p_1_out));
FDSE #(
    .INIT(1'b1)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(1'b0),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .S(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[3]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[4]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[5]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[6]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[7]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[8]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .R(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_1 ),
        .Q(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .R(p_1_out));
gig_ethernet_pcs_pma_1AUTO_NEG__parameterized0 \HAS_AUTO_NEG.AUTO_NEGOTIATION 
       (.D({TX_CONFIG_REG,\n_16_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_20_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .EOP_REG1(EOP_REG1),
        .I1(\n_0_MGT_RESET.SRESET_reg ),
        .I10(n_8_SYNCHRONISATION),
        .I11(O1),
        .I2(n_3_SYNCHRONISATION),
        .I3(n_32_RECEIVER),
        .I4(n_33_RECEIVER),
        .I5(RX_CONFIG_REG),
        .I6({n_30_RECEIVER,n_31_RECEIVER}),
        .I7(data_out),
        .I8(n_10_RECEIVER),
        .I9({\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1] ,\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] }),
        .MASK_RUDI_BUFERR_TIMER0(MASK_RUDI_BUFERR_TIMER0),
        .O1(\n_6_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O2(\n_7_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O3(\n_10_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O4(\n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .O5({\n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_27_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_28_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_29_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .O6({\n_30_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_31_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_32_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_33_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_34_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_35_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .Q({AN_ENABLE_INT,Q,\n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] }),
        .RESTART_AN_SET(RESTART_AN_SET),
        .RXSYNC_STATUS(RXSYNC_STATUS),
        .RX_CONFIG_VALID(RX_CONFIG_VALID),
        .RX_IDLE(RX_IDLE),
        .RX_RUDI_INVALID(RX_RUDI_INVALID),
        .S({n_28_RECEIVER,n_29_RECEIVER}),
        .SOP_REG3(SOP_REG3),
        .SR(RX_CONFIG_REG_REG0),
        .STATUS_VECTOR_0_PRE0(STATUS_VECTOR_0_PRE0),
        .STAT_VEC_DUPLEX_MODE_RSLVD_reg(STAT_VEC_DUPLEX_MODE_RSLVD_reg),
        .SYNC_STATUS_HELD(SYNC_STATUS_HELD),
        .XMIT_CONFIG(XMIT_CONFIG),
        .XMIT_DATA(XMIT_DATA),
        .an_adv_config_vector(an_adv_config_vector),
        .an_interrupt(an_interrupt),
        .data_out(data_out_2),
        .gmii_rx_dv(gmii_rx_dv),
        .p_0_in(p_0_in),
        .status_vector({status_vector[12:10],status_vector[8:7],status_vector[4]}),
        .userclk2(userclk2));
(* ASYNC_REG *) 
   FDPE #(
    .INIT(1'b0)) 
     \MGT_RESET.RESET_INT_PIPE_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(1'b0),
        .PRE(\n_0_MGT_RESET.RESET_INT_i_1 ),
        .Q(RESET_INT_PIPE));
LUT2 #(
    .INIT(4'hB)) 
     \MGT_RESET.RESET_INT_i_1 
       (.I0(reset),
        .I1(mmcm_locked),
        .O(\n_0_MGT_RESET.RESET_INT_i_1 ));
(* ASYNC_REG *) 
   FDPE #(
    .INIT(1'b0)) 
     \MGT_RESET.RESET_INT_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(RESET_INT_PIPE),
        .PRE(\n_0_MGT_RESET.RESET_INT_i_1 ),
        .Q(RESET_INT));
(* ASYNC_REG *) 
   FDRE #(
    .INIT(1'b0)) 
     \MGT_RESET.SRESET_PIPE_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(RESET_INT),
        .Q(SRESET_PIPE),
        .R(1'b0));
(* ASYNC_REG *) 
   FDSE #(
    .INIT(1'b0)) 
     \MGT_RESET.SRESET_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(SRESET_PIPE),
        .Q(\n_0_MGT_RESET.SRESET_reg ),
        .S(RESET_INT));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(configuration_vector[0]),
        .Q(\n_0_NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[0] ),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(configuration_vector[1]),
        .Q(LOOPBACK_INT),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(configuration_vector[2]),
        .Q(Q[0]),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(configuration_vector[3]),
        .Q(Q[1]),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.CONFIGURATION_VECTOR_REG_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(configuration_vector[4]),
        .Q(AN_ENABLE_INT),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_REG_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(an_restart_config),
        .Q(RESTART_AN_EN_REG),
        .R(\n_0_MGT_RESET.SRESET_reg ));
LUT2 #(
    .INIT(4'h2)) 
     \NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1 
       (.I0(an_restart_config),
        .I1(RESTART_AN_EN_REG),
        .O(\n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_EN_i_1 ),
        .Q(RESTART_AN_EN),
        .R(\n_0_MGT_RESET.SRESET_reg ));
FDRE #(
    .INIT(1'b0)) 
     \NO_MANAGEMENT.NO_MDIO_HAS_AN.RESTART_AN_SET_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(RESTART_AN_EN),
        .Q(RESTART_AN_SET),
        .R(\n_0_MGT_RESET.SRESET_reg ));
gig_ethernet_pcs_pma_1RX__parameterized0 RECEIVER
       (.D_1(D_1),
        .EOP_REG1(EOP_REG1),
        .I1(O1),
        .I10(\n_6_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .I11(\n_7_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .I2(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg ),
        .I3(\n_23_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .I4({\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1] ,\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] }),
        .I5(\n_10_HAS_AUTO_NEG.AUTO_NEGOTIATION ),
        .I6({n_30_RECEIVER,n_31_RECEIVER}),
        .I7(n_7_SYNCHRONISATION),
        .I8(Q),
        .I9(n_5_SYNCHRONISATION),
        .K28p5_REG1(K28p5_REG1),
        .O1(n_8_RECEIVER),
        .O2(n_10_RECEIVER),
        .O3(RX_CONFIG_REG),
        .O4(RX_CONFIG_REG_REG0),
        .O5({\n_24_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_25_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_26_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_27_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_28_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_29_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .O6({\n_30_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_31_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_32_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_33_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_34_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_35_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .O7(n_32_RECEIVER),
        .O8(n_33_RECEIVER),
        .Q({\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1] ,\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0] }),
        .RXEVEN(RXEVEN),
        .RXNOTINTABLE_INT(RXNOTINTABLE_INT),
        .RXSYNC_STATUS(RXSYNC_STATUS),
        .RX_CONFIG_VALID(RX_CONFIG_VALID),
        .RX_IDLE(RX_IDLE),
        .S({n_28_RECEIVER,n_29_RECEIVER}),
        .SOP_REG3(SOP_REG3),
        .SR(\n_0_MGT_RESET.SRESET_reg ),
        .SYNC_STATUS_REG0(SYNC_STATUS_REG0),
        .XMIT_DATA(XMIT_DATA),
        .gmii_rx_dv(gmii_rx_dv),
        .gmii_rx_er(gmii_rx_er),
        .gmii_rxd(gmii_rxd),
        .p_0_in(p_0_in),
        .status_vector(status_vector[3:2]),
        .userclk2(userclk2));
FDRE #(
    .INIT(1'b0)) 
     RXDISPERR_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(Q_0),
        .Q(status_vector[5]),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     RXNOTINTABLE_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RXNOTINTABLE_SRL),
        .Q(status_vector[6]),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     STATUS_VECTOR_0_PRE_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(STATUS_VECTOR_0_PRE0),
        .Q(STATUS_VECTOR_0_PRE),
        .R(1'b0));
FDRE \STATUS_VECTOR_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(STATUS_VECTOR_0_PRE),
        .Q(status_vector[0]),
        .R(1'b0));
FDRE \STATUS_VECTOR_reg[12] 
       (.C(userclk2),
        .CE(1'b1),
        .D(DUPLEX_MODE_RSLVD_REG),
        .Q(status_vector[9]),
        .R(1'b0));
FDRE \STATUS_VECTOR_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(SYNC_STATUS_REG),
        .Q(status_vector[1]),
        .R(1'b0));
gig_ethernet_pcs_pma_1SYNCHRONISE SYNCHRONISATION
       (.D_1(D_1),
        .I1(O1),
        .I2(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg ),
        .I3(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg ),
        .I4(n_8_RECEIVER),
        .K28p5_REG1(K28p5_REG1),
        .O1(n_3_SYNCHRONISATION),
        .O2(n_5_SYNCHRONISATION),
        .O3(n_7_SYNCHRONISATION),
        .O4(n_8_SYNCHRONISATION),
        .Q(LOOPBACK_INT),
        .RXEVEN(RXEVEN),
        .RXNOTINTABLE_INT(RXNOTINTABLE_INT),
        .RXSYNC_STATUS(RXSYNC_STATUS),
        .RX_RUDI_INVALID(RX_RUDI_INVALID),
        .SIGNAL_DETECT_MOD(SIGNAL_DETECT_MOD),
        .SR(\n_0_MGT_RESET.SRESET_reg ),
        .SYNC_STATUS_HELD(SYNC_STATUS_HELD),
        .SYNC_STATUS_REG0(SYNC_STATUS_REG0),
        .encommaalign(encommaalign),
        .p_0_in(p_0_in),
        .userclk2(userclk2));
gig_ethernet_pcs_pma_1sync_block__parameterized0 SYNC_SIGNAL_DETECT
       (.MASK_RUDI_BUFERR_TIMER0(MASK_RUDI_BUFERR_TIMER0),
        .Q(Q[0]),
        .SIGNAL_DETECT_MOD(SIGNAL_DETECT_MOD),
        .data_out(data_out_2),
        .p_0_in(p_0_in),
        .signal_detect(signal_detect),
        .userclk2(userclk2));
FDRE #(
    .INIT(1'b0)) 
     SYNC_STATUS_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RXSYNC_STATUS),
        .Q(SYNC_STATUS_REG),
        .R(1'b0));
gig_ethernet_pcs_pma_1TX__parameterized0 TRANSMITTER
       (.D({n_0_TRANSMITTER,n_1_TRANSMITTER,n_2_TRANSMITTER,n_3_TRANSMITTER}),
        .I1(SR),
        .I2(I1),
        .I3({TX_CONFIG_REG,\n_16_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_17_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_18_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_19_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_20_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_21_HAS_AUTO_NEG.AUTO_NEGOTIATION ,\n_22_HAS_AUTO_NEG.AUTO_NEGOTIATION }),
        .O1(n_4_TRANSMITTER),
        .O10(n_20_TRANSMITTER),
        .O11(n_21_TRANSMITTER),
        .O2(n_5_TRANSMITTER),
        .O3(n_6_TRANSMITTER),
        .O4(n_7_TRANSMITTER),
        .O5(n_8_TRANSMITTER),
        .O6(n_9_TRANSMITTER),
        .O7(n_10_TRANSMITTER),
        .O8(n_11_TRANSMITTER),
        .O9({n_12_TRANSMITTER,n_13_TRANSMITTER,n_14_TRANSMITTER,n_15_TRANSMITTER,n_16_TRANSMITTER,n_17_TRANSMITTER,n_18_TRANSMITTER,n_19_TRANSMITTER}),
        .Q({Q[1],LOOPBACK_INT}),
        .XMIT_CONFIG(XMIT_CONFIG),
        .XMIT_DATA(XMIT_DATA),
        .gmii_tx_en(gmii_tx_en),
        .gmii_tx_er(gmii_tx_er),
        .gmii_txd(gmii_txd),
        .gt0_rxchariscomma_out(gt0_rxchariscomma_out),
        .gt0_rxcharisk_out(gt0_rxcharisk_out),
        .userclk2(userclk2));
LUT6 #(
    .INIT(64'hFFFFFFFFEFFEEEEE)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_1 
       (.I0(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_2 ),
        .I1(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_3 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[3] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[4] ),
        .I4(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_4 ),
        .I5(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_5 ),
        .O(MGT_RX_RESET_INT));
LUT6 #(
    .INIT(64'h0000000000300022)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_2 
       (.I0(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_6 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_5 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I5(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_7 ),
        .O(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_2 ));
LUT6 #(
    .INIT(64'hAAAAAAAEAAAEAEEA)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_3 
       (.I0(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_8 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[13]_i_2 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[10] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[9] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[12] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[11] ),
        .O(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair76" *) 
   LUT5 #(
    .INIT(32'h00000004)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_4 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .O(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair74" *) 
   LUT5 #(
    .INIT(32'h01160000)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_5 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[9]_i_2 ),
        .O(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_5 ));
LUT6 #(
    .INIT(64'h0000000000000004)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_6 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[1] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[15] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[7] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[8] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[5] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[6] ),
        .O(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_6 ));
LUT2 #(
    .INIT(4'hE)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_7 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .O(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_7 ));
LUT6 #(
    .INIT(64'h0000000400040000)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_i_8 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_5 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_4 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM[15]_i_3 ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[2] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[14] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.RX_RST_SM_reg[13] ),
        .O(\n_0_USE_ROCKET_IO.MGT_RX_RESET_INT_i_8 ));
FDSE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.MGT_RX_RESET_INT_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(MGT_RX_RESET_INT),
        .Q(O1),
        .S(p_0_out));
LUT6 #(
    .INIT(64'hFFFFFFFFEFFEEEEE)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_1 
       (.I0(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_2 ),
        .I1(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_3 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[3] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[4] ),
        .I4(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_4 ),
        .I5(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_5 ),
        .O(MGT_TX_RESET_INT));
LUT6 #(
    .INIT(64'h0000000000300022)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_2 
       (.I0(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_6 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_5 ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I5(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_7 ),
        .O(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_2 ));
LUT6 #(
    .INIT(64'hAAAAAAAEAAAEAEEA)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_3 
       (.I0(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_8 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[13]_i_2 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[10] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[9] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[12] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[11] ),
        .O(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair84" *) 
   LUT5 #(
    .INIT(32'h00000004)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_4 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .O(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair72" *) 
   LUT5 #(
    .INIT(32'h01160000)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_5 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[9]_i_2 ),
        .O(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_5 ));
LUT6 #(
    .INIT(64'h0000000000000004)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_6 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[1] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[15] ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[7] ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[8] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[5] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[6] ),
        .O(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_6 ));
LUT2 #(
    .INIT(4'hE)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_7 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .O(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_7 ));
LUT6 #(
    .INIT(64'h0000000400040000)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_i_8 
       (.I0(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_5 ),
        .I1(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_4 ),
        .I2(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM[15]_i_3 ),
        .I3(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[2] ),
        .I4(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[14] ),
        .I5(\n_0_FSM_onehot_USE_ROCKET_IO.TX_RST_SM_reg[13] ),
        .O(\n_0_USE_ROCKET_IO.MGT_TX_RESET_INT_i_8 ));
FDSE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.MGT_TX_RESET_INT_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(MGT_TX_RESET_INT),
        .Q(SR),
        .S(p_1_out));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXBUFSTATUS_INT_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(rxbuferr),
        .Q(p_0_in),
        .R(\n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_11_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_reg ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_10_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXCHARISK_INT_reg ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(I2[0]),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[0] ),
        .R(\n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(I2[1]),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXCLKCORCNT_INT_reg[1] ),
        .R(\n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_19_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[0] ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_18_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[1] ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_17_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[2] ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_16_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[3] ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_15_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[4] ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_14_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[5] ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_13_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[6] ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_12_TRANSMITTER),
        .Q(\n_0_USE_ROCKET_IO.NO_1588.RXDATA_INT_reg[7] ),
        .R(O1));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXDISPERR_INT_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(gt0_rxdisperr_out),
        .Q(D_1),
        .R(\n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 ));
LUT2 #(
    .INIT(4'hE)) 
     \USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 
       (.I0(LOOPBACK_INT),
        .I1(O1),
        .O(\n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(gt0_rxnotintable_out),
        .Q(RXNOTINTABLE_INT),
        .R(\n_0_USE_ROCKET_IO.NO_1588.RXNOTINTABLE_INT_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \USE_ROCKET_IO.TXBUFERR_INT_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(txbuferr),
        .Q(TXBUFERR_INT),
        .R(SR));
FDRE \USE_ROCKET_IO.TXCHARDISPMODE_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_4_TRANSMITTER),
        .Q(txchardispmode),
        .R(SR));
FDRE \USE_ROCKET_IO.TXCHARDISPVAL_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_21_TRANSMITTER),
        .Q(txchardispval),
        .R(1'b0));
FDRE \USE_ROCKET_IO.TXCHARISK_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_9_TRANSMITTER),
        .Q(txcharisk),
        .R(SR));
FDRE \USE_ROCKET_IO.TXDATA_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_3_TRANSMITTER),
        .Q(D[0]),
        .R(1'b0));
FDRE \USE_ROCKET_IO.TXDATA_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_2_TRANSMITTER),
        .Q(D[1]),
        .R(1'b0));
FDSE \USE_ROCKET_IO.TXDATA_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_8_TRANSMITTER),
        .Q(D[2]),
        .S(n_20_TRANSMITTER));
FDSE \USE_ROCKET_IO.TXDATA_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_7_TRANSMITTER),
        .Q(D[3]),
        .S(n_20_TRANSMITTER));
FDRE \USE_ROCKET_IO.TXDATA_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_1_TRANSMITTER),
        .Q(D[4]),
        .R(1'b0));
FDSE \USE_ROCKET_IO.TXDATA_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_6_TRANSMITTER),
        .Q(D[5]),
        .S(n_20_TRANSMITTER));
FDRE \USE_ROCKET_IO.TXDATA_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_TRANSMITTER),
        .Q(D[6]),
        .R(1'b0));
FDSE \USE_ROCKET_IO.TXDATA_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(n_5_TRANSMITTER),
        .Q(D[7]),
        .S(n_20_TRANSMITTER));
LUT2 #(
    .INIT(4'hB)) 
     \txchardispmode_double[1]_i_1 
       (.I0(SR),
        .I1(toggle),
        .O(O2));
endmodule

(* ORIG_REF_NAME = "RX" *) 
module gig_ethernet_pcs_pma_1RX__parameterized0
   (K28p5_REG1,
    RX_IDLE,
    SOP_REG3,
    EOP_REG1,
    gmii_rx_er,
    RX_CONFIG_VALID,
    status_vector,
    O1,
    gmii_rx_dv,
    O2,
    O3,
    O4,
    S,
    I6,
    O7,
    O8,
    gmii_rxd,
    Q,
    userclk2,
    I1,
    SYNC_STATUS_REG0,
    I2,
    I3,
    I4,
    SR,
    RXSYNC_STATUS,
    RXNOTINTABLE_INT,
    D_1,
    p_0_in,
    I5,
    XMIT_DATA,
    RXEVEN,
    O5,
    O6,
    I7,
    I8,
    I9,
    I10,
    I11);
  output K28p5_REG1;
  output RX_IDLE;
  output SOP_REG3;
  output EOP_REG1;
  output gmii_rx_er;
  output RX_CONFIG_VALID;
  output [1:0]status_vector;
  output O1;
  output gmii_rx_dv;
  output O2;
  output [15:0]O3;
  output [0:0]O4;
  output [1:0]S;
  output [1:0]I6;
  output O7;
  output O8;
  output [7:0]gmii_rxd;
  input [7:0]Q;
  input userclk2;
  input I1;
  input SYNC_STATUS_REG0;
  input I2;
  input I3;
  input [1:0]I4;
  input [0:0]SR;
  input RXSYNC_STATUS;
  input RXNOTINTABLE_INT;
  input D_1;
  input p_0_in;
  input I5;
  input XMIT_DATA;
  input RXEVEN;
  input [5:0]O5;
  input [5:0]O6;
  input I7;
  input [1:0]I8;
  input I9;
  input I10;
  input I11;

  wire C;
  wire C0;
  wire CGBAD;
  wire CGBAD_REG1;
  wire CGBAD_REG2;
  wire CGBAD_REG3;
  wire C_HDR_REMOVED;
  wire C_HDR_REMOVED_REG;
  wire C_REG1;
  wire C_REG2;
  wire C_REG3;
  wire D0p0;
  wire D0p0_REG;
  wire D_1;
  wire EOP;
  wire EOP0;
  wire EOP_REG1;
  wire EOP_REG10;
  wire EXTEND_ERR;
  wire EXTEND_ERR0;
  wire EXTEND_REG1;
  wire EXTEND_REG2;
  wire EXTEND_REG3;
  wire EXT_ILLEGAL_K;
  wire EXT_ILLEGAL_K0;
  wire EXT_ILLEGAL_K_REG1;
  wire EXT_ILLEGAL_K_REG2;
  wire FALSE_CARRIER;
  wire FALSE_CARRIER_REG1;
  wire FALSE_CARRIER_REG2;
  wire FALSE_CARRIER_REG3;
  wire FALSE_DATA;
  wire FALSE_DATA0;
  wire FALSE_K;
  wire FALSE_K0;
  wire FALSE_NIT;
  wire FALSE_NIT0;
  wire FROM_IDLE_D;
  wire FROM_IDLE_D0;
  wire FROM_RX_CX;
  wire FROM_RX_CX0;
  wire FROM_RX_K;
  wire FROM_RX_K0;
  wire I;
  wire I0;
  wire I1;
  wire I10;
  wire I11;
  wire I2;
  wire I3;
  wire [1:0]I4;
  wire I5;
  wire [1:0]I6;
  wire I7;
  wire [1:0]I8;
  wire I9;
  wire ILLEGAL_K;
  wire ILLEGAL_K0;
  wire ILLEGAL_K_REG1;
  wire ILLEGAL_K_REG2;
  wire K23p7;
  wire K28p5;
  wire K28p5_REG1;
  wire K28p5_REG2;
  wire K29p7;
  wire O1;
  wire O2;
  wire [15:0]O3;
  wire [0:0]O4;
  wire [5:0]O5;
  wire [5:0]O6;
  wire O7;
  wire O8;
  wire [7:0]Q;
  wire R;
  wire RUDI_C0;
  wire RUDI_I0;
  wire RXCHARISK_REG1;
  wire [7:0]RXDATA_REG5;
  wire RXEVEN;
  wire RXNOTINTABLE_INT;
  wire RXSYNC_STATUS;
  wire RX_CONFIG_VALID;
  wire RX_CONFIG_VALID_INT0;
  wire RX_DATA_ERROR;
  wire RX_DATA_ERROR0;
  wire RX_ER0;
  wire RX_IDLE;
  wire R_REG1;
  wire [1:0]S;
  wire S0;
  wire S2;
  wire SOP;
  wire SOP0;
  wire SOP_REG1;
  wire SOP_REG2;
  wire SOP_REG3;
  wire [0:0]SR;
  wire SYNC_STATUS_REG;
  wire SYNC_STATUS_REG0;
  wire S_0;
  wire T;
  wire T_REG1;
  wire T_REG2;
  wire WAIT_FOR_K;
  wire XMIT_DATA;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire n_0_C_i_2;
  wire n_0_C_i_3;
  wire n_0_C_i_4;
  wire n_0_D0p0_REG_i_2;
  wire n_0_EOP_i_2;
  wire n_0_EXTEND_i_1;
  wire n_0_EXTEND_i_3;
  wire n_0_EXTEND_reg;
  wire n_0_FALSE_CARRIER_i_1;
  wire n_0_FALSE_CARRIER_i_2;
  wire n_0_FALSE_CARRIER_i_3;
  wire n_0_FALSE_DATA_i_2;
  wire n_0_FALSE_DATA_i_3;
  wire n_0_FALSE_DATA_i_4;
  wire n_0_FALSE_DATA_i_5;
  wire n_0_FALSE_DATA_i_6;
  wire n_0_FALSE_K_i_2;
  wire n_0_FALSE_NIT_i_2;
  wire n_0_FALSE_NIT_i_3;
  wire n_0_FALSE_NIT_i_4;
  wire n_0_FALSE_NIT_i_5;
  wire n_0_FALSE_NIT_i_6;
  wire \n_0_IDLE_REG_reg[0] ;
  wire \n_0_IDLE_REG_reg[2] ;
  wire n_0_I_i_2;
  wire n_0_RECEIVE_i_1;
  wire \n_0_RXDATA_REG4_reg[0]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[1]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[2]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[3]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[4]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[5]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[6]_srl4 ;
  wire \n_0_RXDATA_REG4_reg[7]_srl4 ;
  wire \n_0_RXD[0]_i_1 ;
  wire \n_0_RXD[1]_i_1 ;
  wire \n_0_RXD[2]_i_1 ;
  wire \n_0_RXD[3]_i_1 ;
  wire \n_0_RXD[4]_i_1 ;
  wire \n_0_RXD[5]_i_1 ;
  wire \n_0_RXD[6]_i_1 ;
  wire \n_0_RXD[7]_i_1 ;
  wire \n_0_RX_CONFIG_REG[7]_i_1 ;
  wire n_0_RX_CONFIG_REG_NULL_i_2;
  wire n_0_RX_CONFIG_REG_NULL_i_3;
  wire n_0_RX_CONFIG_REG_NULL_i_4;
  wire n_0_RX_CONFIG_VALID_INT_i_2;
  wire \n_0_RX_CONFIG_VALID_REG_reg[0] ;
  wire \n_0_RX_CONFIG_VALID_REG_reg[3] ;
  wire n_0_RX_DATA_ERROR_i_2;
  wire n_0_RX_DATA_ERROR_i_4;
  wire n_0_RX_ER_i_2;
  wire n_0_RX_ER_i_3;
  wire n_0_RX_INVALID_i_1;
  wire n_0_RX_INVALID_i_2;
  wire n_0_R_i_2;
  wire n_0_S_i_2;
  wire n_0_WAIT_FOR_K_i_1;
  wire p_0_in;
  wire p_0_in1_in;
  wire p_0_in2_in;
  wire [8:8]p_0_out;
  wire p_1_in;
  wire [1:0]status_vector;
  wire userclk2;

FDRE CGBAD_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(CGBAD),
        .Q(CGBAD_REG1),
        .R(1'b0));
FDRE CGBAD_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(CGBAD_REG1),
        .Q(CGBAD_REG2),
        .R(1'b0));
FDRE CGBAD_REG3_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(CGBAD_REG2),
        .Q(CGBAD_REG3),
        .R(I1));
LUT3 #(
    .INIT(8'hFE)) 
     CGBAD_i_1
       (.I0(RXNOTINTABLE_INT),
        .I1(D_1),
        .I2(p_0_in),
        .O(S2));
FDRE CGBAD_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(S2),
        .Q(CGBAD),
        .R(I1));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     CONSISTENCY_MATCH_i_6
       (.I0(O3[8]),
        .I1(O6[5]),
        .I2(O3[6]),
        .I3(O6[3]),
        .I4(O6[4]),
        .I5(O3[7]),
        .O(I6[1]));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     CONSISTENCY_MATCH_i_7
       (.I0(O3[4]),
        .I1(O6[1]),
        .I2(O3[5]),
        .I3(O6[2]),
        .I4(O6[0]),
        .I5(O3[3]),
        .O(I6[0]));
LUT3 #(
    .INIT(8'h08)) 
     C_HDR_REMOVED_REG_i_1
       (.I0(C_REG2),
        .I1(I4[0]),
        .I2(I4[1]),
        .O(C_HDR_REMOVED));
FDRE C_HDR_REMOVED_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(C_HDR_REMOVED),
        .Q(C_HDR_REMOVED_REG),
        .R(1'b0));
FDRE C_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(C),
        .Q(C_REG1),
        .R(1'b0));
FDRE C_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(C_REG1),
        .Q(C_REG2),
        .R(1'b0));
FDRE C_REG3_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(C_REG2),
        .Q(C_REG3),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT2 #(
    .INIT(4'h2)) 
     C_i_1
       (.I0(K28p5_REG1),
        .I1(n_0_C_i_2),
        .O(C0));
LUT6 #(
    .INIT(64'hBABBBBBBBBBBBBBB)) 
     C_i_2
       (.I0(I2),
        .I1(n_0_C_i_3),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[2]),
        .I5(n_0_C_i_4),
        .O(n_0_C_i_2));
LUT6 #(
    .INIT(64'h0000010000000000)) 
     C_i_3
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(Q[3]),
        .I3(Q[1]),
        .I4(Q[0]),
        .I5(n_0_FALSE_DATA_i_4),
        .O(n_0_C_i_3));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT5 #(
    .INIT(32'h00000800)) 
     C_i_4
       (.I0(Q[4]),
        .I1(Q[7]),
        .I2(Q[6]),
        .I3(Q[5]),
        .I4(Q[3]),
        .O(n_0_C_i_4));
FDRE C_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(C0),
        .Q(C),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT4 #(
    .INIT(16'h0002)) 
     D0p0_REG_i_1
       (.I0(n_0_D0p0_REG_i_2),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[7]),
        .O(D0p0));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     D0p0_REG_i_2
       (.I0(Q[4]),
        .I1(Q[2]),
        .I2(Q[3]),
        .I3(Q[5]),
        .I4(Q[6]),
        .I5(I2),
        .O(n_0_D0p0_REG_i_2));
FDRE D0p0_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(D0p0),
        .Q(D0p0_REG),
        .R(1'b0));
LUT3 #(
    .INIT(8'hEA)) 
     EOP_REG1_i_1
       (.I0(EOP),
        .I1(EXTEND_REG1),
        .I2(n_0_EXTEND_reg),
        .O(EOP_REG10));
FDRE EOP_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(EOP_REG10),
        .Q(EOP_REG1),
        .R(I1));
LUT6 #(
    .INIT(64'hFFFFFFFF88888000)) 
     EOP_i_1
       (.I0(T_REG2),
        .I1(R_REG1),
        .I2(RXEVEN),
        .I3(K28p5_REG1),
        .I4(R),
        .I5(n_0_EOP_i_2),
        .O(EOP0));
LUT5 #(
    .INIT(32'hF8888888)) 
     EOP_i_2
       (.I0(RX_IDLE),
        .I1(K28p5_REG1),
        .I2(RXEVEN),
        .I3(D0p0_REG),
        .I4(C_REG1),
        .O(n_0_EOP_i_2));
FDRE EOP_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(EOP0),
        .Q(EOP),
        .R(I1));
LUT3 #(
    .INIT(8'hEA)) 
     EXTEND_ERR_i_1
       (.I0(EXT_ILLEGAL_K_REG2),
        .I1(CGBAD_REG3),
        .I2(EXTEND_REG3),
        .O(EXTEND_ERR0));
FDRE EXTEND_ERR_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(EXTEND_ERR0),
        .Q(EXTEND_ERR),
        .R(SYNC_STATUS_REG0));
FDRE EXTEND_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_EXTEND_reg),
        .Q(EXTEND_REG1),
        .R(1'b0));
FDRE EXTEND_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(EXTEND_REG1),
        .Q(EXTEND_REG2),
        .R(1'b0));
FDRE EXTEND_REG3_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(EXTEND_REG2),
        .Q(EXTEND_REG3),
        .R(1'b0));
LUT6 #(
    .INIT(64'hAA00AA2AAA00AA00)) 
     EXTEND_i_1
       (.I0(I9),
        .I1(RXEVEN),
        .I2(K28p5_REG1),
        .I3(n_0_EXTEND_i_3),
        .I4(S_0),
        .I5(n_0_EXTEND_reg),
        .O(n_0_EXTEND_i_1));
LUT3 #(
    .INIT(8'h80)) 
     EXTEND_i_3
       (.I0(O1),
        .I1(R),
        .I2(R_REG1),
        .O(n_0_EXTEND_i_3));
FDRE EXTEND_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_EXTEND_i_1),
        .Q(n_0_EXTEND_reg),
        .R(1'b0));
FDRE EXT_ILLEGAL_K_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(EXT_ILLEGAL_K),
        .Q(EXT_ILLEGAL_K_REG1),
        .R(SYNC_STATUS_REG0));
FDRE EXT_ILLEGAL_K_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(EXT_ILLEGAL_K_REG1),
        .Q(EXT_ILLEGAL_K_REG2),
        .R(SYNC_STATUS_REG0));
LUT5 #(
    .INIT(32'h00000700)) 
     EXT_ILLEGAL_K_i_1
       (.I0(RXEVEN),
        .I1(K28p5_REG1),
        .I2(R),
        .I3(EXTEND_REG1),
        .I4(S_0),
        .O(EXT_ILLEGAL_K0));
FDRE EXT_ILLEGAL_K_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(EXT_ILLEGAL_K0),
        .Q(EXT_ILLEGAL_K),
        .R(SYNC_STATUS_REG0));
FDRE FALSE_CARRIER_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FALSE_CARRIER),
        .Q(FALSE_CARRIER_REG1),
        .R(1'b0));
FDRE FALSE_CARRIER_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FALSE_CARRIER_REG1),
        .Q(FALSE_CARRIER_REG2),
        .R(1'b0));
FDRE FALSE_CARRIER_REG3_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FALSE_CARRIER_REG2),
        .Q(FALSE_CARRIER_REG3),
        .R(SYNC_STATUS_REG0));
LUT6 #(
    .INIT(64'h0A0E0E0E0A0A0A0A)) 
     FALSE_CARRIER_i_1
       (.I0(n_0_FALSE_CARRIER_i_2),
        .I1(RXSYNC_STATUS),
        .I2(I1),
        .I3(RXEVEN),
        .I4(K28p5_REG1),
        .I5(FALSE_CARRIER),
        .O(n_0_FALSE_CARRIER_i_1));
LUT5 #(
    .INIT(32'h00000020)) 
     FALSE_CARRIER_i_2
       (.I0(I5),
        .I1(S_0),
        .I2(RX_IDLE),
        .I3(K28p5_REG1),
        .I4(n_0_FALSE_CARRIER_i_3),
        .O(n_0_FALSE_CARRIER_i_2));
LUT3 #(
    .INIT(8'hFE)) 
     FALSE_CARRIER_i_3
       (.I0(FALSE_DATA),
        .I1(FALSE_K),
        .I2(FALSE_NIT),
        .O(n_0_FALSE_CARRIER_i_3));
FDRE FALSE_CARRIER_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_FALSE_CARRIER_i_1),
        .Q(FALSE_CARRIER),
        .R(1'b0));
LUT4 #(
    .INIT(16'h000E)) 
     FALSE_DATA_i_1
       (.I0(n_0_FALSE_DATA_i_2),
        .I1(n_0_FALSE_DATA_i_3),
        .I2(RXNOTINTABLE_INT),
        .I3(I2),
        .O(FALSE_DATA0));
LUT6 #(
    .INIT(64'h0000008000808080)) 
     FALSE_DATA_i_2
       (.I0(n_0_FALSE_DATA_i_4),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(Q[2]),
        .I5(Q[4]),
        .O(n_0_FALSE_DATA_i_2));
LUT6 #(
    .INIT(64'h4000000000000040)) 
     FALSE_DATA_i_3
       (.I0(n_0_FALSE_DATA_i_5),
        .I1(Q[2]),
        .I2(Q[7]),
        .I3(n_0_FALSE_DATA_i_6),
        .I4(Q[1]),
        .I5(Q[0]),
        .O(n_0_FALSE_DATA_i_3));
(* SOFT_HLUTNM = "soft_lutpair25" *) 
   LUT3 #(
    .INIT(8'h04)) 
     FALSE_DATA_i_4
       (.I0(Q[7]),
        .I1(Q[6]),
        .I2(Q[5]),
        .O(n_0_FALSE_DATA_i_4));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT2 #(
    .INIT(4'hB)) 
     FALSE_DATA_i_5
       (.I0(Q[6]),
        .I1(Q[5]),
        .O(n_0_FALSE_DATA_i_5));
LUT2 #(
    .INIT(4'h1)) 
     FALSE_DATA_i_6
       (.I0(Q[4]),
        .I1(Q[3]),
        .O(n_0_FALSE_DATA_i_6));
FDRE FALSE_DATA_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FALSE_DATA0),
        .Q(FALSE_DATA),
        .R(I1));
LUT6 #(
    .INIT(64'h0000000040000040)) 
     FALSE_K_i_1
       (.I0(n_0_FALSE_K_i_2),
        .I1(Q[7]),
        .I2(Q[4]),
        .I3(Q[5]),
        .I4(Q[6]),
        .I5(RXNOTINTABLE_INT),
        .O(FALSE_K0));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT5 #(
    .INIT(32'hEFFFFFFF)) 
     FALSE_K_i_2
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(I2),
        .O(n_0_FALSE_K_i_2));
FDRE FALSE_K_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FALSE_K0),
        .Q(FALSE_K),
        .R(I1));
LUT6 #(
    .INIT(64'hAAA0A8080A00A808)) 
     FALSE_NIT_i_1
       (.I0(RXNOTINTABLE_INT),
        .I1(n_0_FALSE_NIT_i_2),
        .I2(Q[7]),
        .I3(n_0_FALSE_NIT_i_3),
        .I4(D_1),
        .I5(n_0_FALSE_NIT_i_4),
        .O(FALSE_NIT0));
LUT6 #(
    .INIT(64'h0000000000808000)) 
     FALSE_NIT_i_2
       (.I0(Q[2]),
        .I1(Q[3]),
        .I2(I2),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(n_0_FALSE_NIT_i_5),
        .O(n_0_FALSE_NIT_i_2));
LUT6 #(
    .INIT(64'hFFFF400040004000)) 
     FALSE_NIT_i_3
       (.I0(n_0_FALSE_K_i_2),
        .I1(Q[6]),
        .I2(Q[5]),
        .I3(Q[4]),
        .I4(n_0_D0p0_REG_i_2),
        .I5(n_0_FALSE_NIT_i_6),
        .O(n_0_FALSE_NIT_i_3));
(* SOFT_HLUTNM = "soft_lutpair30" *) 
   LUT3 #(
    .INIT(8'h28)) 
     FALSE_NIT_i_4
       (.I0(n_0_D0p0_REG_i_2),
        .I1(Q[1]),
        .I2(Q[0]),
        .O(n_0_FALSE_NIT_i_4));
(* SOFT_HLUTNM = "soft_lutpair34" *) 
   LUT3 #(
    .INIT(8'h7F)) 
     FALSE_NIT_i_5
       (.I0(Q[6]),
        .I1(Q[5]),
        .I2(Q[4]),
        .O(n_0_FALSE_NIT_i_5));
(* SOFT_HLUTNM = "soft_lutpair27" *) 
   LUT2 #(
    .INIT(4'h8)) 
     FALSE_NIT_i_6
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(n_0_FALSE_NIT_i_6));
FDRE FALSE_NIT_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FALSE_NIT0),
        .Q(FALSE_NIT),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT4 #(
    .INIT(16'h0004)) 
     FROM_IDLE_D_i_1
       (.I0(K28p5_REG1),
        .I1(RX_IDLE),
        .I2(WAIT_FOR_K),
        .I3(I5),
        .O(FROM_IDLE_D0));
FDRE FROM_IDLE_D_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FROM_IDLE_D0),
        .Q(FROM_IDLE_D),
        .R(SYNC_STATUS_REG0));
LUT6 #(
    .INIT(64'hFFFFA8FFFCFCA8A8)) 
     FROM_RX_CX_i_1
       (.I0(RXCHARISK_REG1),
        .I1(C_REG1),
        .I2(C_REG2),
        .I3(I7),
        .I4(CGBAD),
        .I5(C_REG3),
        .O(FROM_RX_CX0));
FDRE FROM_RX_CX_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FROM_RX_CX0),
        .Q(FROM_RX_CX),
        .R(SYNC_STATUS_REG0));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT4 #(
    .INIT(16'h00E0)) 
     FROM_RX_K_i_1
       (.I0(RXCHARISK_REG1),
        .I1(CGBAD),
        .I2(K28p5_REG2),
        .I3(I5),
        .O(FROM_RX_K0));
FDRE FROM_RX_K_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(FROM_RX_K0),
        .Q(FROM_RX_K),
        .R(SYNC_STATUS_REG0));
FDRE \IDLE_REG_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_IDLE),
        .Q(\n_0_IDLE_REG_reg[0] ),
        .R(I1));
FDRE \IDLE_REG_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_IDLE_REG_reg[0] ),
        .Q(p_0_in1_in),
        .R(I1));
FDRE \IDLE_REG_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(p_0_in1_in),
        .Q(\n_0_IDLE_REG_reg[2] ),
        .R(I1));
FDRE ILLEGAL_K_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(ILLEGAL_K),
        .Q(ILLEGAL_K_REG1),
        .R(SYNC_STATUS_REG0));
FDRE ILLEGAL_K_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(ILLEGAL_K_REG1),
        .Q(ILLEGAL_K_REG2),
        .R(SYNC_STATUS_REG0));
LUT4 #(
    .INIT(16'h0010)) 
     ILLEGAL_K_i_1
       (.I0(R),
        .I1(K28p5_REG1),
        .I2(RXCHARISK_REG1),
        .I3(T),
        .O(ILLEGAL_K0));
FDRE ILLEGAL_K_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(ILLEGAL_K0),
        .Q(ILLEGAL_K),
        .R(SYNC_STATUS_REG0));
FDRE I_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(I),
        .Q(RX_IDLE),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair23" *) 
   LUT5 #(
    .INIT(32'h22220020)) 
     I_i_1
       (.I0(n_0_C_i_2),
        .I1(n_0_I_i_2),
        .I2(K28p5_REG1),
        .I3(I2),
        .I4(I5),
        .O(I0));
LUT6 #(
    .INIT(64'h000001FFFFFFFFFF)) 
     I_i_2
       (.I0(FALSE_DATA),
        .I1(FALSE_K),
        .I2(FALSE_NIT),
        .I3(RX_IDLE),
        .I4(K28p5_REG1),
        .I5(RXEVEN),
        .O(n_0_I_i_2));
FDRE I_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(I0),
        .Q(I),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT5 #(
    .INIT(32'h02000000)) 
     K28p5_REG1_i_1
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(n_0_FALSE_K_i_2),
        .I3(Q[7]),
        .I4(Q[4]),
        .O(K28p5));
FDRE K28p5_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(K28p5),
        .Q(K28p5_REG1),
        .R(1'b0));
FDRE K28p5_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(K28p5_REG1),
        .Q(K28p5_REG2),
        .R(1'b0));
LUT4 #(
    .INIT(16'h0D0C)) 
     RECEIVED_IDLE_i_1
       (.I0(RX_CONFIG_VALID),
        .I1(RX_IDLE),
        .I2(SR),
        .I3(I11),
        .O(O8));
LUT5 #(
    .INIT(32'h44044400)) 
     RECEIVE_i_1
       (.I0(I1),
        .I1(RXSYNC_STATUS),
        .I2(EOP),
        .I3(SOP_REG2),
        .I4(O1),
        .O(n_0_RECEIVE_i_1));
FDRE RECEIVE_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_RECEIVE_i_1),
        .Q(O1),
        .R(1'b0));
LUT4 #(
    .INIT(16'hFFFE)) 
     RUDI_C_i_1
       (.I0(p_1_in),
        .I1(\n_0_RX_CONFIG_VALID_REG_reg[0] ),
        .I2(\n_0_RX_CONFIG_VALID_REG_reg[3] ),
        .I3(p_0_in2_in),
        .O(RUDI_C0));
FDRE RUDI_C_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RUDI_C0),
        .Q(status_vector[0]),
        .R(I1));
LUT2 #(
    .INIT(4'hE)) 
     RUDI_I_i_1
       (.I0(\n_0_IDLE_REG_reg[2] ),
        .I1(p_0_in1_in),
        .O(RUDI_I0));
FDRE RUDI_I_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RUDI_I0),
        .Q(status_vector[1]),
        .R(I1));
FDRE RXCHARISK_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(I2),
        .Q(RXCHARISK_REG1),
        .R(1'b0));
(* srl_bus_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[0]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[0]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(Q[0]),
        .Q(\n_0_RXDATA_REG4_reg[0]_srl4 ));
(* srl_bus_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[1]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[1]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(Q[1]),
        .Q(\n_0_RXDATA_REG4_reg[1]_srl4 ));
(* srl_bus_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[2]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[2]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(Q[2]),
        .Q(\n_0_RXDATA_REG4_reg[2]_srl4 ));
(* srl_bus_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[3]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[3]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(Q[3]),
        .Q(\n_0_RXDATA_REG4_reg[3]_srl4 ));
(* srl_bus_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[4]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[4]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(Q[4]),
        .Q(\n_0_RXDATA_REG4_reg[4]_srl4 ));
(* srl_bus_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[5]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[5]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(Q[5]),
        .Q(\n_0_RXDATA_REG4_reg[5]_srl4 ));
(* srl_bus_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[6]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[6]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(Q[6]),
        .Q(\n_0_RXDATA_REG4_reg[6]_srl4 ));
(* srl_bus_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg " *) 
   (* srl_name = "\U0/gig_ethernet_pcs_pma_1_core/gpcs_pma_inst/RECEIVER/RXDATA_REG4_reg[7]_srl4 " *) 
   SRL16E \RXDATA_REG4_reg[7]_srl4 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(userclk2),
        .D(Q[7]),
        .Q(\n_0_RXDATA_REG4_reg[7]_srl4 ));
FDRE \RXDATA_REG5_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[0]_srl4 ),
        .Q(RXDATA_REG5[0]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[1]_srl4 ),
        .Q(RXDATA_REG5[1]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[2]_srl4 ),
        .Q(RXDATA_REG5[2]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[3]_srl4 ),
        .Q(RXDATA_REG5[3]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[4]_srl4 ),
        .Q(RXDATA_REG5[4]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[5]_srl4 ),
        .Q(RXDATA_REG5[5]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[6]_srl4 ),
        .Q(RXDATA_REG5[6]),
        .R(1'b0));
FDRE \RXDATA_REG5_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXDATA_REG4_reg[7]_srl4 ),
        .Q(RXDATA_REG5[7]),
        .R(1'b0));
LUT4 #(
    .INIT(16'hBBBA)) 
     \RXD[0]_i_1 
       (.I0(SOP_REG3),
        .I1(FALSE_CARRIER_REG3),
        .I2(EXTEND_REG1),
        .I3(RXDATA_REG5[0]),
        .O(\n_0_RXD[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT4 #(
    .INIT(16'h5554)) 
     \RXD[1]_i_1 
       (.I0(SOP_REG3),
        .I1(RXDATA_REG5[1]),
        .I2(EXTEND_REG1),
        .I3(FALSE_CARRIER_REG3),
        .O(\n_0_RXD[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \RXD[2]_i_1 
       (.I0(FALSE_CARRIER_REG3),
        .I1(EXTEND_REG1),
        .I2(RXDATA_REG5[2]),
        .I3(SOP_REG3),
        .O(\n_0_RXD[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair31" *) 
   LUT4 #(
    .INIT(16'h5554)) 
     \RXD[3]_i_1 
       (.I0(SOP_REG3),
        .I1(RXDATA_REG5[3]),
        .I2(EXTEND_REG1),
        .I3(FALSE_CARRIER_REG3),
        .O(\n_0_RXD[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT5 #(
    .INIT(32'hBABBBAAA)) 
     \RXD[4]_i_1 
       (.I0(SOP_REG3),
        .I1(FALSE_CARRIER_REG3),
        .I2(EXTEND_ERR),
        .I3(EXTEND_REG1),
        .I4(RXDATA_REG5[4]),
        .O(\n_0_RXD[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT4 #(
    .INIT(16'h0010)) 
     \RXD[5]_i_1 
       (.I0(FALSE_CARRIER_REG3),
        .I1(EXTEND_REG1),
        .I2(RXDATA_REG5[5]),
        .I3(SOP_REG3),
        .O(\n_0_RXD[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair33" *) 
   LUT4 #(
    .INIT(16'hABAA)) 
     \RXD[6]_i_1 
       (.I0(SOP_REG3),
        .I1(EXTEND_REG1),
        .I2(FALSE_CARRIER_REG3),
        .I3(RXDATA_REG5[6]),
        .O(\n_0_RXD[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair32" *) 
   LUT4 #(
    .INIT(16'h0010)) 
     \RXD[7]_i_1 
       (.I0(FALSE_CARRIER_REG3),
        .I1(EXTEND_REG1),
        .I2(RXDATA_REG5[7]),
        .I3(SOP_REG3),
        .O(\n_0_RXD[7]_i_1 ));
FDRE \RXD_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXD[0]_i_1 ),
        .Q(gmii_rxd[0]),
        .R(I8[1]));
FDRE \RXD_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXD[1]_i_1 ),
        .Q(gmii_rxd[1]),
        .R(I8[1]));
FDRE \RXD_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXD[2]_i_1 ),
        .Q(gmii_rxd[2]),
        .R(I8[1]));
FDRE \RXD_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXD[3]_i_1 ),
        .Q(gmii_rxd[3]),
        .R(I8[1]));
FDRE \RXD_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXD[4]_i_1 ),
        .Q(gmii_rxd[4]),
        .R(I8[1]));
FDRE \RXD_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXD[5]_i_1 ),
        .Q(gmii_rxd[5]),
        .R(I8[1]));
FDRE \RXD_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXD[6]_i_1 ),
        .Q(gmii_rxd[6]),
        .R(I8[1]));
FDRE \RXD_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RXD[7]_i_1 ),
        .Q(gmii_rxd[7]),
        .R(I8[1]));
LUT4 #(
    .INIT(16'h0054)) 
     \RX_CONFIG_REG[15]_i_1 
       (.I0(RXCHARISK_REG1),
        .I1(C_REG1),
        .I2(C_HDR_REMOVED_REG),
        .I3(I2),
        .O(p_0_out));
LUT5 #(
    .INIT(32'h55550040)) 
     \RX_CONFIG_REG[7]_i_1 
       (.I0(I2),
        .I1(C_REG2),
        .I2(I4[0]),
        .I3(I4[1]),
        .I4(C),
        .O(\n_0_RX_CONFIG_REG[7]_i_1 ));
LUT6 #(
    .INIT(64'h808080FF80808000)) 
     RX_CONFIG_REG_NULL_i_1
       (.I0(n_0_RX_CONFIG_REG_NULL_i_2),
        .I1(n_0_RX_CONFIG_REG_NULL_i_3),
        .I2(n_0_RX_CONFIG_REG_NULL_i_4),
        .I3(SR),
        .I4(RX_CONFIG_VALID),
        .I5(I10),
        .O(O7));
LUT5 #(
    .INIT(32'h00000001)) 
     RX_CONFIG_REG_NULL_i_2
       (.I0(O3[1]),
        .I1(O3[6]),
        .I2(O3[2]),
        .I3(O3[3]),
        .I4(O3[0]),
        .O(n_0_RX_CONFIG_REG_NULL_i_2));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     RX_CONFIG_REG_NULL_i_3
       (.I0(O3[8]),
        .I1(O3[7]),
        .I2(O3[15]),
        .I3(SR),
        .I4(O3[12]),
        .I5(O3[13]),
        .O(n_0_RX_CONFIG_REG_NULL_i_3));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     RX_CONFIG_REG_NULL_i_4
       (.I0(O3[10]),
        .I1(O3[14]),
        .I2(O3[4]),
        .I3(O3[5]),
        .I4(O3[11]),
        .I5(O3[9]),
        .O(n_0_RX_CONFIG_REG_NULL_i_4));
(* SOFT_HLUTNM = "soft_lutpair28" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \RX_CONFIG_REG_REG[15]_i_1 
       (.I0(SR),
        .I1(RX_IDLE),
        .O(O4));
FDRE \RX_CONFIG_REG_reg[0] 
       (.C(userclk2),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[0]),
        .Q(O3[0]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[10] 
       (.C(userclk2),
        .CE(p_0_out),
        .D(Q[2]),
        .Q(O3[10]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[11] 
       (.C(userclk2),
        .CE(p_0_out),
        .D(Q[3]),
        .Q(O3[11]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[12] 
       (.C(userclk2),
        .CE(p_0_out),
        .D(Q[4]),
        .Q(O3[12]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[13] 
       (.C(userclk2),
        .CE(p_0_out),
        .D(Q[5]),
        .Q(O3[13]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[14] 
       (.C(userclk2),
        .CE(p_0_out),
        .D(Q[6]),
        .Q(O3[14]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[15] 
       (.C(userclk2),
        .CE(p_0_out),
        .D(Q[7]),
        .Q(O3[15]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[1] 
       (.C(userclk2),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[1]),
        .Q(O3[1]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[2] 
       (.C(userclk2),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[2]),
        .Q(O3[2]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[3] 
       (.C(userclk2),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[3]),
        .Q(O3[3]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[4] 
       (.C(userclk2),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[4]),
        .Q(O3[4]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[5] 
       (.C(userclk2),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[5]),
        .Q(O3[5]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[6] 
       (.C(userclk2),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[6]),
        .Q(O3[6]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[7] 
       (.C(userclk2),
        .CE(\n_0_RX_CONFIG_REG[7]_i_1 ),
        .D(Q[7]),
        .Q(O3[7]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[8] 
       (.C(userclk2),
        .CE(p_0_out),
        .D(Q[0]),
        .Q(O3[8]),
        .R(1'b0));
FDRE \RX_CONFIG_REG_reg[9] 
       (.C(userclk2),
        .CE(p_0_out),
        .D(Q[1]),
        .Q(O3[9]),
        .R(1'b0));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_8 
       (.I0(O3[6]),
        .I1(O5[3]),
        .I2(O3[7]),
        .I3(O5[4]),
        .I4(O5[5]),
        .I5(O3[8]),
        .O(S[1]));
LUT6 #(
    .INIT(64'h9009000000009009)) 
     \RX_CONFIG_SNAPSHOT[15]_i_9 
       (.I0(O3[3]),
        .I1(O5[0]),
        .I2(O3[4]),
        .I3(O5[1]),
        .I4(O5[2]),
        .I5(O3[5]),
        .O(S[0]));
LUT6 #(
    .INIT(64'h0040004000400000)) 
     RX_CONFIG_VALID_INT_i_1
       (.I0(S2),
        .I1(RXSYNC_STATUS),
        .I2(n_0_RX_CONFIG_VALID_INT_i_2),
        .I3(I2),
        .I4(C_HDR_REMOVED_REG),
        .I5(C_REG1),
        .O(RX_CONFIG_VALID_INT0));
(* SOFT_HLUTNM = "soft_lutpair29" *) 
   LUT2 #(
    .INIT(4'h1)) 
     RX_CONFIG_VALID_INT_i_2
       (.I0(RXCHARISK_REG1),
        .I1(CGBAD),
        .O(n_0_RX_CONFIG_VALID_INT_i_2));
FDRE RX_CONFIG_VALID_INT_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_CONFIG_VALID_INT0),
        .Q(RX_CONFIG_VALID),
        .R(I1));
FDRE \RX_CONFIG_VALID_REG_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_CONFIG_VALID),
        .Q(\n_0_RX_CONFIG_VALID_REG_reg[0] ),
        .R(I1));
FDRE \RX_CONFIG_VALID_REG_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_RX_CONFIG_VALID_REG_reg[0] ),
        .Q(p_0_in2_in),
        .R(I1));
FDRE \RX_CONFIG_VALID_REG_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(p_0_in2_in),
        .Q(p_1_in),
        .R(I1));
FDRE \RX_CONFIG_VALID_REG_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(p_1_in),
        .Q(\n_0_RX_CONFIG_VALID_REG_reg[3] ),
        .R(I1));
LUT6 #(
    .INIT(64'h888AAAAA88888888)) 
     RX_DATA_ERROR_i_1
       (.I0(O1),
        .I1(n_0_RX_DATA_ERROR_i_2),
        .I2(R),
        .I3(I7),
        .I4(R_REG1),
        .I5(T_REG2),
        .O(RX_DATA_ERROR0));
LUT5 #(
    .INIT(32'hFFFF0A0E)) 
     RX_DATA_ERROR_i_2
       (.I0(K28p5_REG1),
        .I1(R),
        .I2(R_REG1),
        .I3(T_REG1),
        .I4(n_0_RX_DATA_ERROR_i_4),
        .O(n_0_RX_DATA_ERROR_i_2));
LUT4 #(
    .INIT(16'hFFFE)) 
     RX_DATA_ERROR_i_4
       (.I0(CGBAD_REG3),
        .I1(C_REG1),
        .I2(ILLEGAL_K_REG2),
        .I3(RX_IDLE),
        .O(n_0_RX_DATA_ERROR_i_4));
FDRE RX_DATA_ERROR_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_DATA_ERROR0),
        .Q(RX_DATA_ERROR),
        .R(SYNC_STATUS_REG0));
FDRE #(
    .INIT(1'b0)) 
     RX_DV_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(I3),
        .Q(gmii_rx_dv),
        .R(1'b0));
LUT6 #(
    .INIT(64'h2220222000202220)) 
     RX_ER_i_1
       (.I0(XMIT_DATA),
        .I1(n_0_RX_ER_i_2),
        .I2(O1),
        .I3(RXSYNC_STATUS),
        .I4(n_0_RX_ER_i_3),
        .I5(RX_DATA_ERROR),
        .O(RX_ER0));
LUT2 #(
    .INIT(4'hE)) 
     RX_ER_i_2
       (.I0(I8[1]),
        .I1(I8[0]),
        .O(n_0_RX_ER_i_2));
(* SOFT_HLUTNM = "soft_lutpair26" *) 
   LUT2 #(
    .INIT(4'h1)) 
     RX_ER_i_3
       (.I0(EXTEND_REG1),
        .I1(FALSE_CARRIER_REG3),
        .O(n_0_RX_ER_i_3));
FDRE #(
    .INIT(1'b0)) 
     RX_ER_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(RX_ER0),
        .Q(gmii_rx_er),
        .R(I1));
LUT5 #(
    .INIT(32'h00700050)) 
     RX_INVALID_i_1
       (.I0(n_0_RX_INVALID_i_2),
        .I1(K28p5_REG1),
        .I2(RXSYNC_STATUS),
        .I3(I1),
        .I4(O2),
        .O(n_0_RX_INVALID_i_1));
LUT4 #(
    .INIT(16'h4445)) 
     RX_INVALID_i_2
       (.I0(FROM_RX_CX),
        .I1(I5),
        .I2(FROM_RX_K),
        .I3(FROM_IDLE_D),
        .O(n_0_RX_INVALID_i_2));
FDRE RX_INVALID_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_RX_INVALID_i_1),
        .Q(O2),
        .R(1'b0));
FDRE R_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(R),
        .Q(R_REG1),
        .R(1'b0));
LUT6 #(
    .INIT(64'h2000000000000000)) 
     R_i_1
       (.I0(n_0_R_i_2),
        .I1(Q[3]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(Q[2]),
        .I5(I2),
        .O(K23p7));
(* SOFT_HLUTNM = "soft_lutpair24" *) 
   LUT4 #(
    .INIT(16'h8000)) 
     R_i_2
       (.I0(Q[4]),
        .I1(Q[7]),
        .I2(Q[6]),
        .I3(Q[5]),
        .O(n_0_R_i_2));
FDRE R_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(K23p7),
        .Q(R),
        .R(1'b0));
FDRE SOP_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(SOP),
        .Q(SOP_REG1),
        .R(1'b0));
FDRE SOP_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(SOP_REG1),
        .Q(SOP_REG2),
        .R(1'b0));
FDRE SOP_REG3_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(SOP_REG2),
        .Q(SOP_REG3),
        .R(1'b0));
LUT5 #(
    .INIT(32'h20202000)) 
     SOP_i_1
       (.I0(I5),
        .I1(WAIT_FOR_K),
        .I2(S_0),
        .I3(RX_IDLE),
        .I4(n_0_EXTEND_reg),
        .O(SOP0));
FDRE SOP_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(SOP0),
        .Q(SOP),
        .R(I1));
FDRE SYNC_STATUS_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(1'b1),
        .Q(SYNC_STATUS_REG),
        .R(SYNC_STATUS_REG0));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT5 #(
    .INIT(32'h00002000)) 
     S_i_1
       (.I0(n_0_S_i_2),
        .I1(Q[2]),
        .I2(Q[1]),
        .I3(Q[0]),
        .I4(S2),
        .O(S0));
LUT6 #(
    .INIT(64'h8000000000000000)) 
     S_i_2
       (.I0(Q[5]),
        .I1(Q[6]),
        .I2(Q[7]),
        .I3(Q[4]),
        .I4(Q[3]),
        .I5(I2),
        .O(n_0_S_i_2));
FDRE S_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(S0),
        .Q(S_0),
        .R(1'b0));
FDRE T_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(T),
        .Q(T_REG1),
        .R(1'b0));
FDRE T_REG2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(T_REG1),
        .Q(T_REG2),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair22" *) 
   LUT4 #(
    .INIT(16'h4000)) 
     T_i_1
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(Q[2]),
        .I3(n_0_S_i_2),
        .O(K29p7));
FDRE T_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(K29p7),
        .Q(T),
        .R(1'b0));
LUT6 #(
    .INIT(64'h0222222200002222)) 
     WAIT_FOR_K_i_1
       (.I0(RXSYNC_STATUS),
        .I1(I1),
        .I2(RXEVEN),
        .I3(K28p5_REG1),
        .I4(SYNC_STATUS_REG),
        .I5(WAIT_FOR_K),
        .O(n_0_WAIT_FOR_K_i_1));
FDRE WAIT_FOR_K_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_WAIT_FOR_K_i_1),
        .Q(WAIT_FOR_K),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "SYNCHRONISE" *) 
module gig_ethernet_pcs_pma_1SYNCHRONISE
   (RXEVEN,
    RXSYNC_STATUS,
    encommaalign,
    O1,
    SYNC_STATUS_REG0,
    O2,
    SYNC_STATUS_HELD,
    O3,
    O4,
    SIGNAL_DETECT_MOD,
    userclk2,
    I1,
    RXNOTINTABLE_INT,
    D_1,
    p_0_in,
    I2,
    SR,
    RX_RUDI_INVALID,
    I3,
    Q,
    K28p5_REG1,
    I4);
  output RXEVEN;
  output RXSYNC_STATUS;
  output encommaalign;
  output O1;
  output SYNC_STATUS_REG0;
  output O2;
  output SYNC_STATUS_HELD;
  output O3;
  output O4;
  input SIGNAL_DETECT_MOD;
  input userclk2;
  input I1;
  input RXNOTINTABLE_INT;
  input D_1;
  input p_0_in;
  input I2;
  input [0:0]SR;
  input RX_RUDI_INVALID;
  input I3;
  input [0:0]Q;
  input K28p5_REG1;
  input I4;

  wire D_1;
  wire [1:0]GOOD_CGS;
  wire I1;
  wire I2;
  wire I3;
  wire I4;
  wire K28p5_REG1;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [0:0]Q;
  wire RXEVEN;
  wire RXNOTINTABLE_INT;
  wire RXSYNC_STATUS;
  wire RX_RUDI_INVALID;
  wire SIGNAL_DETECT_MOD;
  wire SIGNAL_DETECT_REG;
  wire [0:0]SR;
  wire SYNC_STATUS_HELD;
  wire SYNC_STATUS_REG0;
  wire encommaalign;
  wire n_0_ENCOMMAALIGN_i_1;
  wire n_0_EVEN_i_1;
  wire \n_0_FSM_onehot_STATE[10]_i_1 ;
  wire \n_0_FSM_onehot_STATE[11]_i_1 ;
  wire \n_0_FSM_onehot_STATE[12]_i_1 ;
  wire \n_0_FSM_onehot_STATE[12]_i_2 ;
  wire \n_0_FSM_onehot_STATE[12]_i_3 ;
  wire \n_0_FSM_onehot_STATE[12]_i_4 ;
  wire \n_0_FSM_onehot_STATE[12]_i_5 ;
  wire \n_0_FSM_onehot_STATE[13]_i_1 ;
  wire \n_0_FSM_onehot_STATE[13]_i_10 ;
  wire \n_0_FSM_onehot_STATE[13]_i_11 ;
  wire \n_0_FSM_onehot_STATE[13]_i_12 ;
  wire \n_0_FSM_onehot_STATE[13]_i_13 ;
  wire \n_0_FSM_onehot_STATE[13]_i_14 ;
  wire \n_0_FSM_onehot_STATE[13]_i_15 ;
  wire \n_0_FSM_onehot_STATE[13]_i_16 ;
  wire \n_0_FSM_onehot_STATE[13]_i_17 ;
  wire \n_0_FSM_onehot_STATE[13]_i_18 ;
  wire \n_0_FSM_onehot_STATE[13]_i_19 ;
  wire \n_0_FSM_onehot_STATE[13]_i_2 ;
  wire \n_0_FSM_onehot_STATE[13]_i_3 ;
  wire \n_0_FSM_onehot_STATE[13]_i_4 ;
  wire \n_0_FSM_onehot_STATE[13]_i_5 ;
  wire \n_0_FSM_onehot_STATE[13]_i_6 ;
  wire \n_0_FSM_onehot_STATE[13]_i_7 ;
  wire \n_0_FSM_onehot_STATE[13]_i_8 ;
  wire \n_0_FSM_onehot_STATE[13]_i_9 ;
  wire \n_0_FSM_onehot_STATE[1]_i_1 ;
  wire \n_0_FSM_onehot_STATE[1]_i_2 ;
  wire \n_0_FSM_onehot_STATE[1]_i_3 ;
  wire \n_0_FSM_onehot_STATE[1]_i_4 ;
  wire \n_0_FSM_onehot_STATE[2]_i_1 ;
  wire \n_0_FSM_onehot_STATE[3]_i_1 ;
  wire \n_0_FSM_onehot_STATE[4]_i_1 ;
  wire \n_0_FSM_onehot_STATE[4]_i_2 ;
  wire \n_0_FSM_onehot_STATE[5]_i_1 ;
  wire \n_0_FSM_onehot_STATE[5]_i_2 ;
  wire \n_0_FSM_onehot_STATE[6]_i_1 ;
  wire \n_0_FSM_onehot_STATE[7]_i_1 ;
  wire \n_0_FSM_onehot_STATE[7]_i_2 ;
  wire \n_0_FSM_onehot_STATE[7]_i_3 ;
  wire \n_0_FSM_onehot_STATE[8]_i_1 ;
  wire \n_0_FSM_onehot_STATE[9]_i_1 ;
  wire \n_0_FSM_onehot_STATE_reg[10] ;
  wire \n_0_FSM_onehot_STATE_reg[11] ;
  wire \n_0_FSM_onehot_STATE_reg[12] ;
  wire \n_0_FSM_onehot_STATE_reg[13] ;
  wire \n_0_FSM_onehot_STATE_reg[1] ;
  wire \n_0_FSM_onehot_STATE_reg[2] ;
  wire \n_0_FSM_onehot_STATE_reg[3] ;
  wire \n_0_FSM_onehot_STATE_reg[4] ;
  wire \n_0_FSM_onehot_STATE_reg[5] ;
  wire \n_0_FSM_onehot_STATE_reg[6] ;
  wire \n_0_FSM_onehot_STATE_reg[7] ;
  wire \n_0_FSM_onehot_STATE_reg[8] ;
  wire \n_0_FSM_onehot_STATE_reg[9] ;
  wire \n_0_GOOD_CGS[0]_i_1 ;
  wire \n_0_GOOD_CGS[1]_i_1 ;
  wire \n_0_GOOD_CGS[1]_i_2 ;
  wire \n_0_GOOD_CGS[1]_i_3 ;
  wire \n_0_GOOD_CGS[1]_i_4 ;
  wire n_0_SYNC_STATUS_i_1;
  wire n_0_SYNC_STATUS_i_2;
  wire n_0_SYNC_STATUS_i_3;
  wire n_0_SYNC_STATUS_i_4;
  wire p_0_in;
  wire userclk2;

LUT6 #(
    .INIT(64'hFFDFFFDFFFDF0000)) 
     ENCOMMAALIGN_i_1
       (.I0(n_0_SYNC_STATUS_i_2),
        .I1(I3),
        .I2(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I3(n_0_SYNC_STATUS_i_3),
        .I4(encommaalign),
        .I5(n_0_SYNC_STATUS_i_4),
        .O(n_0_ENCOMMAALIGN_i_1));
FDRE ENCOMMAALIGN_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_ENCOMMAALIGN_i_1),
        .Q(encommaalign),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT3 #(
    .INIT(8'h4F)) 
     EVEN_i_1
       (.I0(RXSYNC_STATUS),
        .I1(I2),
        .I2(RXEVEN),
        .O(n_0_EVEN_i_1));
FDRE EVEN_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_EVEN_i_1),
        .Q(RXEVEN),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT2 #(
    .INIT(4'h2)) 
     EXTEND_i_2
       (.I0(RXSYNC_STATUS),
        .I1(I1),
        .O(O2));
LUT6 #(
    .INIT(64'h0000008802000000)) 
     \FSM_onehot_STATE[10]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I1(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_7 ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .O(\n_0_FSM_onehot_STATE[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT4 #(
    .INIT(16'h0041)) 
     \FSM_onehot_STATE[11]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I1(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I3(\n_0_FSM_onehot_STATE[12]_i_2 ),
        .O(\n_0_FSM_onehot_STATE[11]_i_1 ));
LUT6 #(
    .INIT(64'h5500000000450000)) 
     \FSM_onehot_STATE[12]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[12]_i_2 ),
        .I1(GOOD_CGS[0]),
        .I2(GOOD_CGS[1]),
        .I3(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .O(\n_0_FSM_onehot_STATE[12]_i_1 ));
LUT2 #(
    .INIT(4'hB)) 
     \FSM_onehot_STATE[12]_i_2 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .O(\n_0_FSM_onehot_STATE[12]_i_2 ));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     \FSM_onehot_STATE[12]_i_3 
       (.I0(\n_0_FSM_onehot_STATE[12]_i_4 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_10 ),
        .I2(\n_0_FSM_onehot_STATE_reg[3] ),
        .I3(\n_0_FSM_onehot_STATE_reg[12] ),
        .I4(\n_0_FSM_onehot_STATE_reg[7] ),
        .I5(\n_0_FSM_onehot_STATE[12]_i_5 ),
        .O(\n_0_FSM_onehot_STATE[12]_i_3 ));
LUT6 #(
    .INIT(64'h6666666F666F6FF6)) 
     \FSM_onehot_STATE[12]_i_4 
       (.I0(\n_0_FSM_onehot_STATE_reg[4] ),
        .I1(\n_0_FSM_onehot_STATE_reg[2] ),
        .I2(\n_0_FSM_onehot_STATE_reg[9] ),
        .I3(\n_0_FSM_onehot_STATE_reg[11] ),
        .I4(\n_0_FSM_onehot_STATE_reg[8] ),
        .I5(\n_0_FSM_onehot_STATE_reg[6] ),
        .O(\n_0_FSM_onehot_STATE[12]_i_4 ));
LUT6 #(
    .INIT(64'hEEEEEEEEEEEEEEE0)) 
     \FSM_onehot_STATE[12]_i_5 
       (.I0(\n_0_FSM_onehot_STATE_reg[4] ),
        .I1(\n_0_FSM_onehot_STATE_reg[2] ),
        .I2(\n_0_FSM_onehot_STATE_reg[9] ),
        .I3(\n_0_FSM_onehot_STATE_reg[11] ),
        .I4(\n_0_FSM_onehot_STATE_reg[8] ),
        .I5(\n_0_FSM_onehot_STATE_reg[6] ),
        .O(\n_0_FSM_onehot_STATE[12]_i_5 ));
LUT3 #(
    .INIT(8'hAB)) 
     \FSM_onehot_STATE[13]_i_1 
       (.I0(I1),
        .I1(SIGNAL_DETECT_REG),
        .I2(Q),
        .O(\n_0_FSM_onehot_STATE[13]_i_1 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \FSM_onehot_STATE[13]_i_10 
       (.I0(\n_0_FSM_onehot_STATE_reg[10] ),
        .I1(\n_0_FSM_onehot_STATE_reg[13] ),
        .I2(\n_0_FSM_onehot_STATE_reg[1] ),
        .I3(\n_0_FSM_onehot_STATE_reg[5] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_10 ));
LUT6 #(
    .INIT(64'h0116FFFFFFFF0116)) 
     \FSM_onehot_STATE[13]_i_11 
       (.I0(\n_0_FSM_onehot_STATE_reg[7] ),
        .I1(\n_0_FSM_onehot_STATE_reg[11] ),
        .I2(\n_0_FSM_onehot_STATE_reg[12] ),
        .I3(\n_0_FSM_onehot_STATE_reg[8] ),
        .I4(\n_0_FSM_onehot_STATE_reg[3] ),
        .I5(\n_0_FSM_onehot_STATE_reg[4] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_11 ));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT4 #(
    .INIT(16'h011F)) 
     \FSM_onehot_STATE[13]_i_12 
       (.I0(\n_0_FSM_onehot_STATE_reg[11] ),
        .I1(\n_0_FSM_onehot_STATE_reg[12] ),
        .I2(\n_0_FSM_onehot_STATE_reg[10] ),
        .I3(\n_0_FSM_onehot_STATE_reg[13] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_12 ));
LUT4 #(
    .INIT(16'h0001)) 
     \FSM_onehot_STATE[13]_i_13 
       (.I0(\n_0_FSM_onehot_STATE_reg[7] ),
        .I1(\n_0_FSM_onehot_STATE_reg[6] ),
        .I2(\n_0_FSM_onehot_STATE_reg[8] ),
        .I3(\n_0_FSM_onehot_STATE_reg[5] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_13 ));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT5 #(
    .INIT(32'h00000009)) 
     \FSM_onehot_STATE[13]_i_14 
       (.I0(\n_0_FSM_onehot_STATE_reg[11] ),
        .I1(\n_0_FSM_onehot_STATE_reg[12] ),
        .I2(\n_0_FSM_onehot_STATE_reg[13] ),
        .I3(\n_0_FSM_onehot_STATE_reg[10] ),
        .I4(\n_0_FSM_onehot_STATE_reg[9] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_14 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \FSM_onehot_STATE[13]_i_15 
       (.I0(\n_0_FSM_onehot_STATE_reg[3] ),
        .I1(\n_0_FSM_onehot_STATE_reg[4] ),
        .I2(\n_0_FSM_onehot_STATE_reg[1] ),
        .I3(\n_0_FSM_onehot_STATE_reg[2] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_15 ));
(* SOFT_HLUTNM = "soft_lutpair38" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA8)) 
     \FSM_onehot_STATE[13]_i_16 
       (.I0(\n_0_FSM_onehot_STATE_reg[9] ),
        .I1(\n_0_FSM_onehot_STATE_reg[13] ),
        .I2(\n_0_FSM_onehot_STATE_reg[10] ),
        .I3(\n_0_FSM_onehot_STATE_reg[11] ),
        .I4(\n_0_FSM_onehot_STATE_reg[12] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_16 ));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT5 #(
    .INIT(32'h00010117)) 
     \FSM_onehot_STATE[13]_i_17 
       (.I0(\n_0_FSM_onehot_STATE_reg[5] ),
        .I1(\n_0_FSM_onehot_STATE_reg[7] ),
        .I2(\n_0_FSM_onehot_STATE_reg[13] ),
        .I3(\n_0_FSM_onehot_STATE_reg[8] ),
        .I4(\n_0_FSM_onehot_STATE_reg[6] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_17 ));
LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_STATE[13]_i_18 
       (.I0(\n_0_FSM_onehot_STATE_reg[11] ),
        .I1(\n_0_FSM_onehot_STATE_reg[12] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_18 ));
(* SOFT_HLUTNM = "soft_lutpair37" *) 
   LUT5 #(
    .INIT(32'h00000001)) 
     \FSM_onehot_STATE[13]_i_19 
       (.I0(\n_0_FSM_onehot_STATE_reg[5] ),
        .I1(\n_0_FSM_onehot_STATE_reg[7] ),
        .I2(\n_0_FSM_onehot_STATE_reg[13] ),
        .I3(\n_0_FSM_onehot_STATE_reg[8] ),
        .I4(\n_0_FSM_onehot_STATE_reg[6] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_19 ));
LUT6 #(
    .INIT(64'h0000F00010101010)) 
     \FSM_onehot_STATE[13]_i_2 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_3 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_7 ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .O(\n_0_FSM_onehot_STATE[13]_i_2 ));
LUT6 #(
    .INIT(64'hFFFEFEFEFFFFFFFF)) 
     \FSM_onehot_STATE[13]_i_3 
       (.I0(RXNOTINTABLE_INT),
        .I1(D_1),
        .I2(p_0_in),
        .I3(RXEVEN),
        .I4(I2),
        .I5(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .O(\n_0_FSM_onehot_STATE[13]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFFFEFFFFFFFF)) 
     \FSM_onehot_STATE[13]_i_4 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_9 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_10 ),
        .I2(\n_0_FSM_onehot_STATE_reg[6] ),
        .I3(\n_0_FSM_onehot_STATE_reg[9] ),
        .I4(\n_0_FSM_onehot_STATE_reg[2] ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_11 ),
        .O(\n_0_FSM_onehot_STATE[13]_i_4 ));
LUT5 #(
    .INIT(32'h00000008)) 
     \FSM_onehot_STATE[13]_i_5 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_12 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_13 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_14 ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_15 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_16 ),
        .O(\n_0_FSM_onehot_STATE[13]_i_5 ));
LUT5 #(
    .INIT(32'h00000007)) 
     \FSM_onehot_STATE[13]_i_6 
       (.I0(I2),
        .I1(RXEVEN),
        .I2(p_0_in),
        .I3(D_1),
        .I4(RXNOTINTABLE_INT),
        .O(\n_0_FSM_onehot_STATE[13]_i_6 ));
LUT2 #(
    .INIT(4'h2)) 
     \FSM_onehot_STATE[13]_i_7 
       (.I0(GOOD_CGS[1]),
        .I1(GOOD_CGS[0]),
        .O(\n_0_FSM_onehot_STATE[13]_i_7 ));
LUT6 #(
    .INIT(64'h0000000000000002)) 
     \FSM_onehot_STATE[13]_i_8 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_17 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_18 ),
        .I2(\n_0_FSM_onehot_STATE_reg[9] ),
        .I3(\n_0_FSM_onehot_STATE_reg[10] ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_15 ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_19 ),
        .O(\n_0_FSM_onehot_STATE[13]_i_8 ));
LUT6 #(
    .INIT(64'hEEEEEEEEEEEEEEE0)) 
     \FSM_onehot_STATE[13]_i_9 
       (.I0(\n_0_FSM_onehot_STATE_reg[3] ),
        .I1(\n_0_FSM_onehot_STATE_reg[4] ),
        .I2(\n_0_FSM_onehot_STATE_reg[8] ),
        .I3(\n_0_FSM_onehot_STATE_reg[12] ),
        .I4(\n_0_FSM_onehot_STATE_reg[11] ),
        .I5(\n_0_FSM_onehot_STATE_reg[7] ),
        .O(\n_0_FSM_onehot_STATE[13]_i_9 ));
LUT6 #(
    .INIT(64'h5FFF4F4F55554444)) 
     \FSM_onehot_STATE[1]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[1]_i_2 ),
        .I1(\n_0_FSM_onehot_STATE[1]_i_3 ),
        .I2(\n_0_FSM_onehot_STATE[1]_i_4 ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .O(\n_0_FSM_onehot_STATE[1]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFF4FCC4444)) 
     \FSM_onehot_STATE[1]_i_2 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I2(I3),
        .I3(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .O(\n_0_FSM_onehot_STATE[1]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT4 #(
    .INIT(16'hCFDD)) 
     \FSM_onehot_STATE[1]_i_3 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I1(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I2(I2),
        .I3(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .O(\n_0_FSM_onehot_STATE[1]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair41" *) 
   LUT3 #(
    .INIT(8'hFB)) 
     \FSM_onehot_STATE[1]_i_4 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I1(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .O(\n_0_FSM_onehot_STATE[1]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair40" *) 
   LUT4 #(
    .INIT(16'h2000)) 
     \FSM_onehot_STATE[2]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[4]_i_2 ),
        .I1(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I2(I2),
        .I3(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .O(\n_0_FSM_onehot_STATE[2]_i_1 ));
LUT6 #(
    .INIT(64'h0000002080800020)) 
     \FSM_onehot_STATE[3]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[4]_i_2 ),
        .I1(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I3(I2),
        .I4(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I5(I3),
        .O(\n_0_FSM_onehot_STATE[3]_i_1 ));
LUT4 #(
    .INIT(16'h0040)) 
     \FSM_onehot_STATE[4]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[7]_i_3 ),
        .I1(I2),
        .I2(\n_0_FSM_onehot_STATE[4]_i_2 ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .O(\n_0_FSM_onehot_STATE[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT2 #(
    .INIT(4'h1)) 
     \FSM_onehot_STATE[4]_i_2 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .O(\n_0_FSM_onehot_STATE[4]_i_2 ));
LUT6 #(
    .INIT(64'h0040004000400141)) 
     \FSM_onehot_STATE[5]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I3(\n_0_FSM_onehot_STATE[5]_i_2 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_3 ),
        .I5(I3),
        .O(\n_0_FSM_onehot_STATE[5]_i_1 ));
LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \FSM_onehot_STATE[5]_i_2 
       (.I0(I2),
        .I1(p_0_in),
        .I2(D_1),
        .I3(RXNOTINTABLE_INT),
        .I4(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .O(\n_0_FSM_onehot_STATE[5]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair35" *) 
   LUT5 #(
    .INIT(32'h02000000)) 
     \FSM_onehot_STATE[6]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .I2(\n_0_FSM_onehot_STATE[7]_i_3 ),
        .I3(I2),
        .I4(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .O(\n_0_FSM_onehot_STATE[6]_i_1 ));
LUT6 #(
    .INIT(64'h000000A0303F0000)) 
     \FSM_onehot_STATE[7]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_7 ),
        .I1(\n_0_FSM_onehot_STATE[7]_i_2 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I3(\n_0_FSM_onehot_STATE[7]_i_3 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .O(\n_0_FSM_onehot_STATE[7]_i_1 ));
LUT3 #(
    .INIT(8'hBF)) 
     \FSM_onehot_STATE[7]_i_2 
       (.I0(I3),
        .I1(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .O(\n_0_FSM_onehot_STATE[7]_i_2 ));
LUT6 #(
    .INIT(64'hFFFFFFFEFFFEFFFE)) 
     \FSM_onehot_STATE[7]_i_3 
       (.I0(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I1(RXNOTINTABLE_INT),
        .I2(D_1),
        .I3(p_0_in),
        .I4(RXEVEN),
        .I5(I2),
        .O(\n_0_FSM_onehot_STATE[7]_i_3 ));
LUT6 #(
    .INIT(64'h0000020200000E02)) 
     \FSM_onehot_STATE[8]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I2(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_7 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .I5(\n_0_FSM_onehot_STATE[12]_i_2 ),
        .O(\n_0_FSM_onehot_STATE[8]_i_1 ));
LUT6 #(
    .INIT(64'h8000850080508000)) 
     \FSM_onehot_STATE[9]_i_1 
       (.I0(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I1(\n_0_FSM_onehot_STATE[13]_i_7 ),
        .I2(\n_0_FSM_onehot_STATE[13]_i_8 ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_5 ),
        .I4(\n_0_FSM_onehot_STATE[12]_i_3 ),
        .I5(\n_0_FSM_onehot_STATE[13]_i_4 ),
        .O(\n_0_FSM_onehot_STATE[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[10] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[10]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[10] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[11] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[11]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[11] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[12] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[12]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[12] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[13] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[13]_i_2 ),
        .Q(\n_0_FSM_onehot_STATE_reg[13] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDSE #(
    .INIT(1'b1)) 
     \FSM_onehot_STATE_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[1]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[1] ),
        .S(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[2]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[2] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[3]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[3] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[4]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[4] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[5]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[5] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[6]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[6] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[7]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[7] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[8] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[8]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[8] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_STATE_reg[9] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_FSM_onehot_STATE[9]_i_1 ),
        .Q(\n_0_FSM_onehot_STATE_reg[9] ),
        .R(\n_0_FSM_onehot_STATE[13]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT3 #(
    .INIT(8'h06)) 
     \GOOD_CGS[0]_i_1 
       (.I0(GOOD_CGS[0]),
        .I1(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I2(\n_0_GOOD_CGS[1]_i_2 ),
        .O(\n_0_GOOD_CGS[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair39" *) 
   LUT4 #(
    .INIT(16'h006A)) 
     \GOOD_CGS[1]_i_1 
       (.I0(GOOD_CGS[1]),
        .I1(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I2(GOOD_CGS[0]),
        .I3(\n_0_GOOD_CGS[1]_i_2 ),
        .O(\n_0_GOOD_CGS[1]_i_1 ));
LUT5 #(
    .INIT(32'hFFFFC008)) 
     \GOOD_CGS[1]_i_2 
       (.I0(n_0_SYNC_STATUS_i_3),
        .I1(\n_0_GOOD_CGS[1]_i_3 ),
        .I2(\n_0_GOOD_CGS[1]_i_4 ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_19 ),
        .I4(I1),
        .O(\n_0_GOOD_CGS[1]_i_2 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \GOOD_CGS[1]_i_3 
       (.I0(\n_0_FSM_onehot_STATE_reg[4] ),
        .I1(\n_0_FSM_onehot_STATE_reg[2] ),
        .I2(\n_0_FSM_onehot_STATE_reg[9] ),
        .I3(\n_0_FSM_onehot_STATE_reg[11] ),
        .I4(\n_0_FSM_onehot_STATE_reg[8] ),
        .I5(\n_0_FSM_onehot_STATE_reg[6] ),
        .O(\n_0_GOOD_CGS[1]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair36" *) 
   LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \GOOD_CGS[1]_i_4 
       (.I0(\n_0_FSM_onehot_STATE_reg[13] ),
        .I1(\n_0_FSM_onehot_STATE_reg[11] ),
        .I2(\n_0_FSM_onehot_STATE_reg[12] ),
        .I3(\n_0_FSM_onehot_STATE_reg[9] ),
        .I4(\n_0_FSM_onehot_STATE_reg[10] ),
        .O(\n_0_GOOD_CGS[1]_i_4 ));
FDRE \GOOD_CGS_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_GOOD_CGS[0]_i_1 ),
        .Q(GOOD_CGS[0]),
        .R(1'b0));
FDRE \GOOD_CGS_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_GOOD_CGS[1]_i_1 ),
        .Q(GOOD_CGS[1]),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT2 #(
    .INIT(4'h2)) 
     MASK_RUDI_CLKCOR_i_2
       (.I0(RXSYNC_STATUS),
        .I1(SR),
        .O(SYNC_STATUS_HELD));
LUT2 #(
    .INIT(4'h8)) 
     RX_DATA_ERROR_i_3
       (.I0(RXEVEN),
        .I1(K28p5_REG1),
        .O(O3));
(* SOFT_HLUTNM = "soft_lutpair44" *) 
   LUT2 #(
    .INIT(4'h1)) 
     RX_DV_i_3
       (.I0(RXSYNC_STATUS),
        .I1(I4),
        .O(O4));
(* SOFT_HLUTNM = "soft_lutpair42" *) 
   LUT3 #(
    .INIT(8'h40)) 
     RX_RUDI_INVALID_REG_i_1
       (.I0(SR),
        .I1(RXSYNC_STATUS),
        .I2(RX_RUDI_INVALID),
        .O(O1));
FDRE SIGNAL_DETECT_REG_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(SIGNAL_DETECT_MOD),
        .Q(SIGNAL_DETECT_REG),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair43" *) 
   LUT2 #(
    .INIT(4'hB)) 
     SYNC_STATUS_REG_i_1
       (.I0(I1),
        .I1(RXSYNC_STATUS),
        .O(SYNC_STATUS_REG0));
LUT6 #(
    .INIT(64'h00200020FFFF0020)) 
     SYNC_STATUS_i_1
       (.I0(n_0_SYNC_STATUS_i_2),
        .I1(I3),
        .I2(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .I3(n_0_SYNC_STATUS_i_3),
        .I4(RXSYNC_STATUS),
        .I5(n_0_SYNC_STATUS_i_4),
        .O(n_0_SYNC_STATUS_i_1));
LUT6 #(
    .INIT(64'h0000000000000004)) 
     SYNC_STATUS_i_2
       (.I0(\n_0_FSM_onehot_STATE[13]_i_19 ),
        .I1(\n_0_GOOD_CGS[1]_i_3 ),
        .I2(\n_0_FSM_onehot_STATE_reg[13] ),
        .I3(\n_0_FSM_onehot_STATE[13]_i_18 ),
        .I4(\n_0_FSM_onehot_STATE_reg[9] ),
        .I5(\n_0_FSM_onehot_STATE_reg[10] ),
        .O(n_0_SYNC_STATUS_i_2));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     SYNC_STATUS_i_3
       (.I0(\n_0_FSM_onehot_STATE_reg[3] ),
        .I1(\n_0_FSM_onehot_STATE_reg[4] ),
        .I2(\n_0_FSM_onehot_STATE_reg[8] ),
        .I3(\n_0_FSM_onehot_STATE_reg[12] ),
        .I4(\n_0_FSM_onehot_STATE_reg[11] ),
        .I5(\n_0_FSM_onehot_STATE_reg[7] ),
        .O(n_0_SYNC_STATUS_i_3));
LUT5 #(
    .INIT(32'h00048014)) 
     SYNC_STATUS_i_4
       (.I0(n_0_SYNC_STATUS_i_3),
        .I1(\n_0_FSM_onehot_STATE[13]_i_19 ),
        .I2(\n_0_GOOD_CGS[1]_i_4 ),
        .I3(\n_0_GOOD_CGS[1]_i_3 ),
        .I4(\n_0_FSM_onehot_STATE[13]_i_6 ),
        .O(n_0_SYNC_STATUS_i_4));
FDRE #(
    .INIT(1'b0)) 
     SYNC_STATUS_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_SYNC_STATUS_i_1),
        .Q(RXSYNC_STATUS),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "TX" *) 
module gig_ethernet_pcs_pma_1TX__parameterized0
   (D,
    O1,
    O2,
    O3,
    O4,
    O5,
    O6,
    O7,
    O8,
    O9,
    O10,
    O11,
    I1,
    XMIT_CONFIG,
    userclk2,
    gmii_tx_en,
    gmii_tx_er,
    XMIT_DATA,
    Q,
    gmii_txd,
    gt0_rxcharisk_out,
    gt0_rxchariscomma_out,
    I2,
    I3);
  output [3:0]D;
  output O1;
  output O2;
  output O3;
  output O4;
  output O5;
  output O6;
  output O7;
  output O8;
  output [7:0]O9;
  output O10;
  output O11;
  input I1;
  input XMIT_CONFIG;
  input userclk2;
  input gmii_tx_en;
  input gmii_tx_er;
  input XMIT_DATA;
  input [1:0]Q;
  input [7:0]gmii_txd;
  input [0:0]gt0_rxcharisk_out;
  input [0:0]gt0_rxchariscomma_out;
  input [7:0]I2;
  input [7:0]I3;

  wire CODE_GRPISK;
  wire CONFIG_K28p5;
  wire [3:0]D;
  wire DISPARITY;
  wire I1;
  wire [7:0]I2;
  wire [7:0]I3;
  wire INSERT_IDLE;
  wire K28p5;
  wire O1;
  wire O10;
  wire O11;
  wire O2;
  wire O3;
  wire O4;
  wire O5;
  wire O6;
  wire O7;
  wire O8;
  wire [7:0]O9;
  wire [1:0]Q;
  wire S;
  wire S0;
  wire T;
  wire T0;
  wire TRIGGER_S;
  wire TRIGGER_S0;
  wire TRIGGER_T;
  wire TXCHARDISPMODE_INT;
  wire TXCHARDISPVAL;
  wire TXCHARISK_INT;
  wire [7:0]TXDATA;
  wire [7:0]TXD_REG1;
  wire [15:5]TX_CONFIG;
  wire TX_EN_REG1;
  wire TX_ER_REG1;
  wire TX_EVEN;
  wire XMIT_CONFIG;
  wire XMIT_CONFIG_INT;
  wire XMIT_DATA;
  wire XMIT_DATA_INT;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire [0:0]gt0_rxchariscomma_out;
  wire [0:0]gt0_rxcharisk_out;
  wire n_0_C1_OR_C2_i_1;
  wire n_0_C1_OR_C2_reg;
  wire n_0_CODE_GRPISK_i_1;
  wire \n_0_CODE_GRP[0]_i_1 ;
  wire \n_0_CODE_GRP[0]_i_2 ;
  wire \n_0_CODE_GRP[1]_i_1 ;
  wire \n_0_CODE_GRP[1]_i_2 ;
  wire \n_0_CODE_GRP[2]_i_1 ;
  wire \n_0_CODE_GRP[2]_i_2 ;
  wire \n_0_CODE_GRP[3]_i_1 ;
  wire \n_0_CODE_GRP[3]_i_2 ;
  wire \n_0_CODE_GRP[4]_i_1 ;
  wire \n_0_CODE_GRP[5]_i_1 ;
  wire \n_0_CODE_GRP[6]_i_1 ;
  wire \n_0_CODE_GRP[6]_i_2 ;
  wire \n_0_CODE_GRP[7]_i_1 ;
  wire \n_0_CODE_GRP[7]_i_2 ;
  wire \n_0_CODE_GRP_CNT_reg[1] ;
  wire \n_0_CODE_GRP_reg[0] ;
  wire \n_0_CONFIG_DATA[0]_i_1 ;
  wire \n_0_CONFIG_DATA[1]_i_1 ;
  wire \n_0_CONFIG_DATA[2]_i_1 ;
  wire \n_0_CONFIG_DATA[3]_i_1 ;
  wire \n_0_CONFIG_DATA[4]_i_1 ;
  wire \n_0_CONFIG_DATA[5]_i_1 ;
  wire \n_0_CONFIG_DATA[6]_i_1 ;
  wire \n_0_CONFIG_DATA[7]_i_1 ;
  wire \n_0_CONFIG_DATA_reg[0] ;
  wire \n_0_CONFIG_DATA_reg[1] ;
  wire \n_0_CONFIG_DATA_reg[2] ;
  wire \n_0_CONFIG_DATA_reg[3] ;
  wire \n_0_CONFIG_DATA_reg[4] ;
  wire \n_0_CONFIG_DATA_reg[5] ;
  wire \n_0_CONFIG_DATA_reg[6] ;
  wire \n_0_CONFIG_DATA_reg[7] ;
  wire n_0_INSERT_IDLE_i_1;
  wire n_0_INSERT_IDLE_i_2;
  wire n_0_INSERT_IDLE_reg;
  wire n_0_K28p5_i_1;
  wire \n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXCHARISK_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[0]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[1]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[2]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[3]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[4]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[5]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[6]_i_1 ;
  wire \n_0_NO_QSGMII_DATA.TXDATA[7]_i_1 ;
  wire \n_0_NO_QSGMII_DISP.DISPARITY_i_1 ;
  wire \n_0_NO_QSGMII_DISP.DISPARITY_i_2 ;
  wire \n_0_NO_QSGMII_DISP.DISPARITY_i_3 ;
  wire n_0_R_i_1__0;
  wire n_0_R_reg;
  wire n_0_SYNC_DISPARITY_i_1;
  wire n_0_SYNC_DISPARITY_reg;
  wire n_0_TX_PACKET_i_1;
  wire n_0_TX_PACKET_reg;
  wire n_0_V_i_1;
  wire n_0_V_i_2;
  wire n_0_V_i_3;
  wire n_0_V_i_4;
  wire n_0_V_reg;
  wire n_0_XMIT_DATA_INT_reg;
  wire p_0_in;
  wire p_0_in18_in;
  wire p_0_in37_in;
  wire p_12_out;
  wire p_1_in;
  wire p_1_in1_in;
  wire p_1_in36_in;
  wire p_35_in;
  wire p_49_in;
  wire [1:0]plusOp_0;
  wire userclk2;

(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT4 #(
    .INIT(16'h3F80)) 
     C1_OR_C2_i_1
       (.I0(XMIT_CONFIG_INT),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .I3(n_0_C1_OR_C2_reg),
        .O(n_0_C1_OR_C2_i_1));
FDRE C1_OR_C2_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_C1_OR_C2_i_1),
        .Q(n_0_C1_OR_C2_reg),
        .R(I1));
LUT6 #(
    .INIT(64'h30303030FFFFFF55)) 
     CODE_GRPISK_i_1
       (.I0(n_0_TX_PACKET_reg),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .I3(n_0_R_reg),
        .I4(\n_0_CODE_GRP[3]_i_2 ),
        .I5(XMIT_CONFIG_INT),
        .O(n_0_CODE_GRPISK_i_1));
FDRE CODE_GRPISK_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_CODE_GRPISK_i_1),
        .Q(CODE_GRPISK),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFFFF000010111011)) 
     \CODE_GRP[0]_i_1 
       (.I0(\n_0_CODE_GRP[0]_i_2 ),
        .I1(Q[1]),
        .I2(S),
        .I3(n_0_V_reg),
        .I4(\n_0_CONFIG_DATA_reg[0] ),
        .I5(XMIT_CONFIG_INT),
        .O(\n_0_CODE_GRP[0]_i_1 ));
LUT5 #(
    .INIT(32'h00010101)) 
     \CODE_GRP[0]_i_2 
       (.I0(S),
        .I1(T),
        .I2(n_0_R_reg),
        .I3(TXD_REG1[0]),
        .I4(n_0_TX_PACKET_reg),
        .O(\n_0_CODE_GRP[0]_i_2 ));
LUT4 #(
    .INIT(16'hF011)) 
     \CODE_GRP[1]_i_1 
       (.I0(\n_0_CODE_GRP[1]_i_2 ),
        .I1(Q[1]),
        .I2(\n_0_CONFIG_DATA_reg[1] ),
        .I3(XMIT_CONFIG_INT),
        .O(\n_0_CODE_GRP[1]_i_1 ));
LUT6 #(
    .INIT(64'h1010101110111011)) 
     \CODE_GRP[1]_i_2 
       (.I0(n_0_V_reg),
        .I1(S),
        .I2(T),
        .I3(n_0_R_reg),
        .I4(TXD_REG1[1]),
        .I5(n_0_TX_PACKET_reg),
        .O(\n_0_CODE_GRP[1]_i_2 ));
LUT6 #(
    .INIT(64'hAFACAFAFAFACAFAC)) 
     \CODE_GRP[2]_i_1 
       (.I0(\n_0_CONFIG_DATA_reg[2] ),
        .I1(\n_0_CODE_GRP[2]_i_2 ),
        .I2(XMIT_CONFIG_INT),
        .I3(Q[1]),
        .I4(S),
        .I5(n_0_V_reg),
        .O(\n_0_CODE_GRP[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT5 #(
    .INIT(32'h55555545)) 
     \CODE_GRP[2]_i_2 
       (.I0(S),
        .I1(TXD_REG1[2]),
        .I2(n_0_TX_PACKET_reg),
        .I3(T),
        .I4(n_0_R_reg),
        .O(\n_0_CODE_GRP[2]_i_2 ));
LUT6 #(
    .INIT(64'hB8B8B8B8BBBBB8BB)) 
     \CODE_GRP[3]_i_1 
       (.I0(\n_0_CONFIG_DATA_reg[3] ),
        .I1(XMIT_CONFIG_INT),
        .I2(\n_0_CODE_GRP[3]_i_2 ),
        .I3(n_0_TX_PACKET_reg),
        .I4(TXD_REG1[3]),
        .I5(n_0_R_reg),
        .O(\n_0_CODE_GRP[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \CODE_GRP[3]_i_2 
       (.I0(T),
        .I1(S),
        .I2(n_0_V_reg),
        .I3(Q[1]),
        .O(\n_0_CODE_GRP[3]_i_2 ));
LUT6 #(
    .INIT(64'hBBBBBBBBBBBBBBB8)) 
     \CODE_GRP[4]_i_1 
       (.I0(\n_0_CONFIG_DATA_reg[4] ),
        .I1(XMIT_CONFIG_INT),
        .I2(\n_0_CODE_GRP[7]_i_2 ),
        .I3(T),
        .I4(n_0_R_reg),
        .I5(TXD_REG1[4]),
        .O(\n_0_CODE_GRP[4]_i_1 ));
LUT6 #(
    .INIT(64'hBBBBBBBBBBBBBBB8)) 
     \CODE_GRP[5]_i_1 
       (.I0(\n_0_CONFIG_DATA_reg[5] ),
        .I1(XMIT_CONFIG_INT),
        .I2(\n_0_CODE_GRP[7]_i_2 ),
        .I3(T),
        .I4(n_0_R_reg),
        .I5(TXD_REG1[5]),
        .O(\n_0_CODE_GRP[5]_i_1 ));
LUT6 #(
    .INIT(64'hFFFF000000EA00EA)) 
     \CODE_GRP[6]_i_1 
       (.I0(\n_0_CODE_GRP[6]_i_2 ),
        .I1(TXD_REG1[6]),
        .I2(n_0_TX_PACKET_reg),
        .I3(Q[1]),
        .I4(\n_0_CONFIG_DATA_reg[6] ),
        .I5(XMIT_CONFIG_INT),
        .O(\n_0_CODE_GRP[6]_i_1 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \CODE_GRP[6]_i_2 
       (.I0(n_0_R_reg),
        .I1(T),
        .I2(n_0_V_reg),
        .I3(S),
        .O(\n_0_CODE_GRP[6]_i_2 ));
LUT6 #(
    .INIT(64'hBBBBBBBBBBBBBBB8)) 
     \CODE_GRP[7]_i_1 
       (.I0(\n_0_CONFIG_DATA_reg[7] ),
        .I1(XMIT_CONFIG_INT),
        .I2(\n_0_CODE_GRP[7]_i_2 ),
        .I3(T),
        .I4(n_0_R_reg),
        .I5(TXD_REG1[7]),
        .O(\n_0_CODE_GRP[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair49" *) 
   LUT4 #(
    .INIT(16'hFEFF)) 
     \CODE_GRP[7]_i_2 
       (.I0(n_0_V_reg),
        .I1(S),
        .I2(Q[1]),
        .I3(n_0_TX_PACKET_reg),
        .O(\n_0_CODE_GRP[7]_i_2 ));
LUT1 #(
    .INIT(2'h1)) 
     \CODE_GRP_CNT[0]_i_1 
       (.I0(TX_EVEN),
        .O(plusOp_0[0]));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \CODE_GRP_CNT[1]_i_1 
       (.I0(\n_0_CODE_GRP_CNT_reg[1] ),
        .I1(TX_EVEN),
        .O(plusOp_0[1]));
FDSE \CODE_GRP_CNT_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(plusOp_0[0]),
        .Q(TX_EVEN),
        .S(I1));
FDSE \CODE_GRP_CNT_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(plusOp_0[1]),
        .Q(\n_0_CODE_GRP_CNT_reg[1] ),
        .S(I1));
FDRE \CODE_GRP_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[0]_i_1 ),
        .Q(\n_0_CODE_GRP_reg[0] ),
        .R(1'b0));
FDRE \CODE_GRP_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[1]_i_1 ),
        .Q(p_1_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[2]_i_1 ),
        .Q(p_0_in18_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[3]_i_1 ),
        .Q(p_0_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[4]_i_1 ),
        .Q(p_1_in1_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[5]_i_1 ),
        .Q(p_1_in36_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[6]_i_1 ),
        .Q(p_35_in),
        .R(1'b0));
FDRE \CODE_GRP_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CODE_GRP[7]_i_1 ),
        .Q(p_0_in37_in),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair57" *) 
   LUT4 #(
    .INIT(16'h8A02)) 
     \CONFIG_DATA[0]_i_1 
       (.I0(TX_EVEN),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(n_0_C1_OR_C2_reg),
        .I3(TX_CONFIG[8]),
        .O(\n_0_CONFIG_DATA[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT3 #(
    .INIT(8'h20)) 
     \CONFIG_DATA[1]_i_1 
       (.I0(n_0_C1_OR_C2_reg),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .O(\n_0_CONFIG_DATA[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT3 #(
    .INIT(8'h07)) 
     \CONFIG_DATA[2]_i_1 
       (.I0(TX_EVEN),
        .I1(n_0_C1_OR_C2_reg),
        .I2(\n_0_CODE_GRP_CNT_reg[1] ),
        .O(\n_0_CONFIG_DATA[2]_i_1 ));
LUT3 #(
    .INIT(8'h83)) 
     \CONFIG_DATA[3]_i_1 
       (.I0(TX_CONFIG[11]),
        .I1(TX_EVEN),
        .I2(\n_0_CODE_GRP_CNT_reg[1] ),
        .O(\n_0_CONFIG_DATA[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT4 #(
    .INIT(16'hD313)) 
     \CONFIG_DATA[4]_i_1 
       (.I0(n_0_C1_OR_C2_reg),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .I3(TX_CONFIG[12]),
        .O(\n_0_CONFIG_DATA[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair47" *) 
   LUT5 #(
    .INIT(32'hDDF311F3)) 
     \CONFIG_DATA[5]_i_1 
       (.I0(n_0_C1_OR_C2_reg),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_CONFIG[5]),
        .I3(TX_EVEN),
        .I4(TX_CONFIG[13]),
        .O(\n_0_CONFIG_DATA[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair54" *) 
   LUT4 #(
    .INIT(16'hE020)) 
     \CONFIG_DATA[6]_i_1 
       (.I0(n_0_C1_OR_C2_reg),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(TX_EVEN),
        .I3(TX_CONFIG[14]),
        .O(\n_0_CONFIG_DATA[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair48" *) 
   LUT5 #(
    .INIT(32'hE2E233FF)) 
     \CONFIG_DATA[7]_i_1 
       (.I0(TX_CONFIG[7]),
        .I1(TX_EVEN),
        .I2(TX_CONFIG[15]),
        .I3(n_0_C1_OR_C2_reg),
        .I4(\n_0_CODE_GRP_CNT_reg[1] ),
        .O(\n_0_CONFIG_DATA[7]_i_1 ));
FDRE \CONFIG_DATA_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[0]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[0] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[1]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[1] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[2]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[2] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[3]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[3] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[4]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[4] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[5]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[5] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[6]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[6] ),
        .R(I1));
FDRE \CONFIG_DATA_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_CONFIG_DATA[7]_i_1 ),
        .Q(\n_0_CONFIG_DATA_reg[7] ),
        .R(I1));
FDRE CONFIG_K28p5_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(XMIT_DATA_INT),
        .Q(CONFIG_K28p5),
        .R(I1));
LUT6 #(
    .INIT(64'h00000000FFFF0100)) 
     INSERT_IDLE_i_1
       (.I0(n_0_TX_PACKET_reg),
        .I1(S),
        .I2(n_0_V_reg),
        .I3(n_0_INSERT_IDLE_i_2),
        .I4(Q[1]),
        .I5(XMIT_CONFIG_INT),
        .O(n_0_INSERT_IDLE_i_1));
(* SOFT_HLUTNM = "soft_lutpair46" *) 
   LUT2 #(
    .INIT(4'h1)) 
     INSERT_IDLE_i_2
       (.I0(T),
        .I1(n_0_R_reg),
        .O(n_0_INSERT_IDLE_i_2));
FDRE INSERT_IDLE_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_INSERT_IDLE_i_1),
        .Q(n_0_INSERT_IDLE_reg),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT2 #(
    .INIT(4'h8)) 
     K28p5_i_1
       (.I0(XMIT_CONFIG_INT),
        .I1(CONFIG_K28p5),
        .O(n_0_K28p5_i_1));
FDRE K28p5_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_K28p5_i_1),
        .Q(K28p5),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair69" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \NO_QSGMII_CHAR.TXCHARDISPMODE_i_1 
       (.I0(n_0_SYNC_DISPARITY_reg),
        .I1(TX_EVEN),
        .O(p_12_out));
FDSE \NO_QSGMII_CHAR.TXCHARDISPMODE_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(p_12_out),
        .Q(TXCHARDISPMODE_INT),
        .S(I1));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT3 #(
    .INIT(8'h40)) 
     \NO_QSGMII_CHAR.TXCHARDISPVAL_i_1 
       (.I0(TX_EVEN),
        .I1(n_0_SYNC_DISPARITY_reg),
        .I2(DISPARITY),
        .O(\n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1 ));
FDRE \NO_QSGMII_CHAR.TXCHARDISPVAL_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_CHAR.TXCHARDISPVAL_i_1 ),
        .Q(TXCHARDISPVAL),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT4 #(
    .INIT(16'h002A)) 
     \NO_QSGMII_DATA.TXCHARISK_i_1 
       (.I0(CODE_GRPISK),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(I1),
        .O(\n_0_NO_QSGMII_DATA.TXCHARISK_i_1 ));
FDRE \NO_QSGMII_DATA.TXCHARISK_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXCHARISK_i_1 ),
        .Q(TXCHARISK_INT),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT4 #(
    .INIT(16'hBF80)) 
     \NO_QSGMII_DATA.TXDATA[0]_i_1 
       (.I0(DISPARITY),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(\n_0_CODE_GRP_reg[0] ),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT4 #(
    .INIT(16'h002A)) 
     \NO_QSGMII_DATA.TXDATA[1]_i_1 
       (.I0(p_1_in),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(I1),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[1]_i_1 ));
LUT5 #(
    .INIT(32'h54440444)) 
     \NO_QSGMII_DATA.TXDATA[2]_i_1 
       (.I0(I1),
        .I1(p_0_in18_in),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(TX_EVEN),
        .I4(DISPARITY),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair51" *) 
   LUT4 #(
    .INIT(16'h002A)) 
     \NO_QSGMII_DATA.TXDATA[3]_i_1 
       (.I0(p_0_in),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(I1),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair56" *) 
   LUT4 #(
    .INIT(16'h7F40)) 
     \NO_QSGMII_DATA.TXDATA[4]_i_1 
       (.I0(DISPARITY),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(p_1_in1_in),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT4 #(
    .INIT(16'h002A)) 
     \NO_QSGMII_DATA.TXDATA[5]_i_1 
       (.I0(p_1_in36_in),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(I1),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair50" *) 
   LUT4 #(
    .INIT(16'h5540)) 
     \NO_QSGMII_DATA.TXDATA[6]_i_1 
       (.I0(I1),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(p_35_in),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair53" *) 
   LUT4 #(
    .INIT(16'hBF80)) 
     \NO_QSGMII_DATA.TXDATA[7]_i_1 
       (.I0(DISPARITY),
        .I1(TX_EVEN),
        .I2(n_0_INSERT_IDLE_reg),
        .I3(p_0_in37_in),
        .O(\n_0_NO_QSGMII_DATA.TXDATA[7]_i_1 ));
FDRE \NO_QSGMII_DATA.TXDATA_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[0]_i_1 ),
        .Q(TXDATA[0]),
        .R(I1));
FDRE \NO_QSGMII_DATA.TXDATA_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[1]_i_1 ),
        .Q(TXDATA[1]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[2]_i_1 ),
        .Q(TXDATA[2]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[3]_i_1 ),
        .Q(TXDATA[3]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[4]_i_1 ),
        .Q(TXDATA[4]),
        .R(I1));
FDRE \NO_QSGMII_DATA.TXDATA_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[5]_i_1 ),
        .Q(TXDATA[5]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[6]_i_1 ),
        .Q(TXDATA[6]),
        .R(1'b0));
FDRE \NO_QSGMII_DATA.TXDATA_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DATA.TXDATA[7]_i_1 ),
        .Q(TXDATA[7]),
        .R(I1));
LUT6 #(
    .INIT(64'h000009990FFF0666)) 
     \NO_QSGMII_DISP.DISPARITY_i_1 
       (.I0(\n_0_NO_QSGMII_DISP.DISPARITY_i_2 ),
        .I1(\n_0_NO_QSGMII_DISP.DISPARITY_i_3 ),
        .I2(TX_EVEN),
        .I3(n_0_INSERT_IDLE_reg),
        .I4(K28p5),
        .I5(DISPARITY),
        .O(\n_0_NO_QSGMII_DISP.DISPARITY_i_1 ));
LUT5 #(
    .INIT(32'hE8818157)) 
     \NO_QSGMII_DISP.DISPARITY_i_2 
       (.I0(p_0_in18_in),
        .I1(p_1_in1_in),
        .I2(p_0_in),
        .I3(\n_0_CODE_GRP_reg[0] ),
        .I4(p_1_in),
        .O(\n_0_NO_QSGMII_DISP.DISPARITY_i_2 ));
LUT3 #(
    .INIT(8'h83)) 
     \NO_QSGMII_DISP.DISPARITY_i_3 
       (.I0(p_0_in37_in),
        .I1(p_1_in36_in),
        .I2(p_35_in),
        .O(\n_0_NO_QSGMII_DISP.DISPARITY_i_3 ));
FDSE \NO_QSGMII_DISP.DISPARITY_reg 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_NO_QSGMII_DISP.DISPARITY_i_1 ),
        .Q(DISPARITY),
        .S(I1));
LUT6 #(
    .INIT(64'h0D0D0D0C0C0C0C0C)) 
     R_i_1__0
       (.I0(S),
        .I1(T),
        .I2(I1),
        .I3(TX_ER_REG1),
        .I4(TX_EVEN),
        .I5(n_0_R_reg),
        .O(n_0_R_i_1__0));
FDRE R_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_R_i_1__0),
        .Q(n_0_R_reg),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair52" *) 
   LUT4 #(
    .INIT(16'h2F20)) 
     SYNC_DISPARITY_i_1
       (.I0(TX_EVEN),
        .I1(\n_0_CODE_GRP_CNT_reg[1] ),
        .I2(XMIT_CONFIG_INT),
        .I3(INSERT_IDLE),
        .O(n_0_SYNC_DISPARITY_i_1));
LUT6 #(
    .INIT(64'hAAAAAAAAAAAAAAAB)) 
     SYNC_DISPARITY_i_2
       (.I0(Q[1]),
        .I1(n_0_R_reg),
        .I2(T),
        .I3(n_0_V_reg),
        .I4(S),
        .I5(n_0_TX_PACKET_reg),
        .O(INSERT_IDLE));
FDRE SYNC_DISPARITY_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_SYNC_DISPARITY_i_1),
        .Q(n_0_SYNC_DISPARITY_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h8888A8AA88888888)) 
     S_i_1__0
       (.I0(n_0_XMIT_DATA_INT_reg),
        .I1(TRIGGER_S),
        .I2(TX_ER_REG1),
        .I3(TX_EVEN),
        .I4(TX_EN_REG1),
        .I5(gmii_tx_en),
        .O(S0));
FDRE S_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(S0),
        .Q(S),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT4 #(
    .INIT(16'h0400)) 
     TRIGGER_S_i_1
       (.I0(TX_EN_REG1),
        .I1(gmii_tx_en),
        .I2(TX_ER_REG1),
        .I3(TX_EVEN),
        .O(TRIGGER_S0));
FDRE TRIGGER_S_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(TRIGGER_S0),
        .Q(TRIGGER_S),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair58" *) 
   LUT2 #(
    .INIT(4'h2)) 
     TRIGGER_T_i_1
       (.I0(TX_EN_REG1),
        .I1(gmii_tx_en),
        .O(p_49_in));
FDRE TRIGGER_T_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(p_49_in),
        .Q(TRIGGER_T),
        .R(I1));
FDRE \TXD_REG1_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_txd[0]),
        .Q(TXD_REG1[0]),
        .R(1'b0));
FDRE \TXD_REG1_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_txd[1]),
        .Q(TXD_REG1[1]),
        .R(1'b0));
FDRE \TXD_REG1_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_txd[2]),
        .Q(TXD_REG1[2]),
        .R(1'b0));
FDRE \TXD_REG1_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_txd[3]),
        .Q(TXD_REG1[3]),
        .R(1'b0));
FDRE \TXD_REG1_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_txd[4]),
        .Q(TXD_REG1[4]),
        .R(1'b0));
FDRE \TXD_REG1_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_txd[5]),
        .Q(TXD_REG1[5]),
        .R(1'b0));
FDRE \TXD_REG1_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_txd[6]),
        .Q(TXD_REG1[6]),
        .R(1'b0));
FDRE \TXD_REG1_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_txd[7]),
        .Q(TXD_REG1[7]),
        .R(1'b0));
FDRE \TX_CONFIG_reg[11] 
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(I3[3]),
        .Q(TX_CONFIG[11]),
        .R(I1));
FDRE \TX_CONFIG_reg[12] 
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(I3[4]),
        .Q(TX_CONFIG[12]),
        .R(I1));
FDRE \TX_CONFIG_reg[13] 
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(I3[5]),
        .Q(TX_CONFIG[13]),
        .R(I1));
FDRE \TX_CONFIG_reg[14] 
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(I3[6]),
        .Q(TX_CONFIG[14]),
        .R(I1));
FDRE \TX_CONFIG_reg[15] 
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(I3[7]),
        .Q(TX_CONFIG[15]),
        .R(I1));
FDRE \TX_CONFIG_reg[5] 
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(I3[0]),
        .Q(TX_CONFIG[5]),
        .R(I1));
FDRE \TX_CONFIG_reg[7] 
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(I3[1]),
        .Q(TX_CONFIG[7]),
        .R(I1));
FDRE \TX_CONFIG_reg[8] 
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(I3[2]),
        .Q(TX_CONFIG[8]),
        .R(I1));
FDRE TX_EN_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_tx_en),
        .Q(TX_EN_REG1),
        .R(1'b0));
FDRE TX_ER_REG1_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(gmii_tx_er),
        .Q(TX_ER_REG1),
        .R(1'b0));
LUT4 #(
    .INIT(16'h5150)) 
     TX_PACKET_i_1
       (.I0(I1),
        .I1(T),
        .I2(S),
        .I3(n_0_TX_PACKET_reg),
        .O(n_0_TX_PACKET_i_1));
FDRE TX_PACKET_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_TX_PACKET_i_1),
        .Q(n_0_TX_PACKET_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'h88888888FFF88888)) 
     T_i_1__0
       (.I0(n_0_V_reg),
        .I1(TRIGGER_T),
        .I2(S),
        .I3(n_0_TX_PACKET_reg),
        .I4(TX_EN_REG1),
        .I5(gmii_tx_en),
        .O(T0));
FDRE T_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(T0),
        .Q(T),
        .R(I1));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXCHARISCOMMA_INT_i_1 
       (.I0(TXCHARISK_INT),
        .I1(Q[0]),
        .I2(gt0_rxchariscomma_out),
        .O(O8));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXCHARISK_INT_i_1 
       (.I0(TXCHARISK_INT),
        .I1(Q[0]),
        .I2(gt0_rxcharisk_out),
        .O(O7));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[0]_i_1 
       (.I0(TXDATA[0]),
        .I1(Q[0]),
        .I2(I2[0]),
        .O(O9[0]));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[1]_i_1 
       (.I0(TXDATA[1]),
        .I1(Q[0]),
        .I2(I2[1]),
        .O(O9[1]));
(* SOFT_HLUTNM = "soft_lutpair68" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[2]_i_1 
       (.I0(TXDATA[2]),
        .I1(Q[0]),
        .I2(I2[2]),
        .O(O9[2]));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[3]_i_1 
       (.I0(TXDATA[3]),
        .I1(Q[0]),
        .I2(I2[3]),
        .O(O9[3]));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[4]_i_1 
       (.I0(TXDATA[4]),
        .I1(Q[0]),
        .I2(I2[4]),
        .O(O9[4]));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[5]_i_1 
       (.I0(TXDATA[5]),
        .I1(Q[0]),
        .I2(I2[5]),
        .O(O9[5]));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[6]_i_1 
       (.I0(TXDATA[6]),
        .I1(Q[0]),
        .I2(I2[6]),
        .O(O9[6]));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.NO_1588.RXDATA_INT[7]_i_1 
       (.I0(TXDATA[7]),
        .I1(Q[0]),
        .I2(I2[7]),
        .O(O9[7]));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.TXCHARDISPMODE_i_1 
       (.I0(TX_EVEN),
        .I1(Q[0]),
        .I2(TXCHARDISPMODE_INT),
        .O(O1));
LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXCHARDISPVAL_i_1 
       (.I0(TXCHARDISPVAL),
        .I1(Q[0]),
        .I2(I1),
        .O(O11));
(* SOFT_HLUTNM = "soft_lutpair62" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \USE_ROCKET_IO.TXCHARISK_i_1 
       (.I0(TX_EVEN),
        .I1(Q[0]),
        .I2(TXCHARISK_INT),
        .O(O6));
(* SOFT_HLUTNM = "soft_lutpair60" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[0]_i_1 
       (.I0(TXDATA[0]),
        .I1(Q[0]),
        .I2(I1),
        .O(D[0]));
(* SOFT_HLUTNM = "soft_lutpair61" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[1]_i_1 
       (.I0(TXDATA[1]),
        .I1(Q[0]),
        .I2(I1),
        .O(D[1]));
(* SOFT_HLUTNM = "soft_lutpair67" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[2]_i_1 
       (.I0(TXDATA[2]),
        .I1(Q[0]),
        .I2(I1),
        .O(O5));
(* SOFT_HLUTNM = "soft_lutpair63" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[3]_i_1 
       (.I0(TXDATA[3]),
        .I1(Q[0]),
        .I2(I1),
        .O(O4));
(* SOFT_HLUTNM = "soft_lutpair66" *) 
   LUT3 #(
    .INIT(8'h54)) 
     \USE_ROCKET_IO.TXDATA[4]_i_1 
       (.I0(I1),
        .I1(TXDATA[4]),
        .I2(Q[0]),
        .O(D[2]));
(* SOFT_HLUTNM = "soft_lutpair64" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[5]_i_1 
       (.I0(TXDATA[5]),
        .I1(Q[0]),
        .I2(I1),
        .O(O3));
(* SOFT_HLUTNM = "soft_lutpair59" *) 
   LUT4 #(
    .INIT(16'h003A)) 
     \USE_ROCKET_IO.TXDATA[6]_i_1 
       (.I0(TXDATA[6]),
        .I1(TX_EVEN),
        .I2(Q[0]),
        .I3(I1),
        .O(D[3]));
(* SOFT_HLUTNM = "soft_lutpair55" *) 
   LUT3 #(
    .INIT(8'h08)) 
     \USE_ROCKET_IO.TXDATA[7]_i_1 
       (.I0(Q[0]),
        .I1(TX_EVEN),
        .I2(I1),
        .O(O10));
(* SOFT_HLUTNM = "soft_lutpair65" *) 
   LUT3 #(
    .INIT(8'h02)) 
     \USE_ROCKET_IO.TXDATA[7]_i_2 
       (.I0(TXDATA[7]),
        .I1(Q[0]),
        .I2(I1),
        .O(O2));
LUT4 #(
    .INIT(16'h3222)) 
     V_i_1
       (.I0(n_0_V_i_2),
        .I1(I1),
        .I2(S),
        .I3(n_0_V_reg),
        .O(n_0_V_i_1));
LUT5 #(
    .INIT(32'h2000AAAA)) 
     V_i_2
       (.I0(n_0_XMIT_DATA_INT_reg),
        .I1(n_0_TX_PACKET_reg),
        .I2(TX_ER_REG1),
        .I3(TX_EN_REG1),
        .I4(n_0_V_i_3),
        .O(n_0_V_i_2));
LUT6 #(
    .INIT(64'h55557555FFFF7555)) 
     V_i_3
       (.I0(gmii_tx_er),
        .I1(n_0_V_i_4),
        .I2(gmii_txd[2]),
        .I3(gmii_txd[3]),
        .I4(gmii_tx_en),
        .I5(n_0_TX_PACKET_reg),
        .O(n_0_V_i_3));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
     V_i_4
       (.I0(gmii_txd[1]),
        .I1(gmii_txd[4]),
        .I2(gmii_txd[6]),
        .I3(gmii_txd[0]),
        .I4(gmii_txd[7]),
        .I5(gmii_txd[5]),
        .O(n_0_V_i_4));
FDRE V_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_V_i_1),
        .Q(n_0_V_reg),
        .R(1'b0));
LUT2 #(
    .INIT(4'h1)) 
     XMIT_CONFIG_INT_i_1
       (.I0(\n_0_CODE_GRP_CNT_reg[1] ),
        .I1(TX_EVEN),
        .O(XMIT_DATA_INT));
FDSE XMIT_CONFIG_INT_reg
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(XMIT_CONFIG),
        .Q(XMIT_CONFIG_INT),
        .S(I1));
FDRE XMIT_DATA_INT_reg
       (.C(userclk2),
        .CE(XMIT_DATA_INT),
        .D(XMIT_DATA),
        .Q(n_0_XMIT_DATA_INT_reg),
        .R(I1));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_GTWIZARD_GT" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_GTWIZARD_GT__parameterized0
   (cplllock,
    CPLLREFCLKLOST,
    O1,
    gt0_eyescandataerror_out,
    txn,
    txp,
    gt0_rxbyteisaligned_out,
    gt0_rxbyterealign_out,
    gt0_rxcommadet_out,
    I,
    O2,
    gt0_rxprbserr_out,
    O3,
    txoutclk,
    O4,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    D,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    O5,
    gt0_rxmonitorout_out,
    O6,
    O7,
    O8,
    O9,
    independent_clock_bufg,
    CPLL_RESET,
    gt0_drpclk_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    rxn,
    rxp,
    gtrefclk,
    gt0_gttxreset_in0_out,
    gt0_qplloutclk_in,
    gt0_qplloutrefclk_in,
    gt0_rxbufreset_in,
    gt0_rxcdrhold_in,
    RXDFELFHOLD,
    gt0_rxdfeagcovrden_in,
    gt0_rxdfelpmreset_in,
    gt0_rxlpmen_in,
    gt0_rxmcommaalignen_in,
    gt0_rxpcsreset_in,
    gt0_rxpolarity_in,
    gt0_rxprbscntreset_in,
    RXUSERRDY,
    userclk,
    TXPD,
    gt0_txpcsreset_in,
    gt0_txpmareset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    TXUSERRDY,
    gt0_rxmonitorsel_in,
    RXPD,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txprbssel_in,
    gt0_txdiffctrl_in,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    Q,
    I1,
    I2,
    I3,
    gt0_gtrxreset_in1_out,
    gt0_rxpmareset_in,
    gt0_drpdi_in,
    gt0_drpwe_in,
    gt0_drpen_in,
    gt0_drpaddr_in);
  output cplllock;
  output CPLLREFCLKLOST;
  output O1;
  output gt0_eyescandataerror_out;
  output txn;
  output txp;
  output gt0_rxbyteisaligned_out;
  output gt0_rxbyterealign_out;
  output gt0_rxcommadet_out;
  output I;
  output O2;
  output gt0_rxprbserr_out;
  output O3;
  output txoutclk;
  output O4;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output [1:0]D;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [15:0]O5;
  output [6:0]gt0_rxmonitorout_out;
  output [1:0]O6;
  output [1:0]O7;
  output [1:0]O8;
  output [1:0]O9;
  input independent_clock_bufg;
  input CPLL_RESET;
  input gt0_drpclk_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input rxn;
  input rxp;
  input gtrefclk;
  input gt0_gttxreset_in0_out;
  input gt0_qplloutclk_in;
  input gt0_qplloutrefclk_in;
  input gt0_rxbufreset_in;
  input gt0_rxcdrhold_in;
  input RXDFELFHOLD;
  input gt0_rxdfeagcovrden_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxlpmen_in;
  input gt0_rxmcommaalignen_in;
  input gt0_rxpcsreset_in;
  input gt0_rxpolarity_in;
  input gt0_rxprbscntreset_in;
  input RXUSERRDY;
  input userclk;
  input [0:0]TXPD;
  input gt0_txpcsreset_in;
  input gt0_txpmareset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input TXUSERRDY;
  input [1:0]gt0_rxmonitorsel_in;
  input [0:0]RXPD;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_txprbssel_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input [15:0]Q;
  input [1:0]I1;
  input [1:0]I2;
  input [1:0]I3;
  input gt0_gtrxreset_in1_out;
  input gt0_rxpmareset_in;
  input [15:0]gt0_drpdi_in;
  input gt0_drpwe_in;
  input gt0_drpen_in;
  input [8:0]gt0_drpaddr_in;

  wire CPLLREFCLKLOST;
  wire CPLL_RESET;
  wire [1:0]D;
  wire DRP_OP_DONE;
  wire GTRXRESET_OUT;
  wire I;
  wire [1:0]I1;
  wire [1:0]I2;
  wire [1:0]I3;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [15:0]O5;
  wire [1:0]O6;
  wire [1:0]O7;
  wire [1:0]O8;
  wire [1:0]O9;
  wire [15:0]Q;
  wire RXDFELFHOLD;
  wire [0:0]RXPD;
  wire RXPMARESET_OUT;
  wire RXUSERRDY;
  wire [0:0]TXPD;
  wire TXUSERRDY;
  wire cplllock;
  wire drp_busy_i1;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire gt0_gtrxreset_in1_out;
  wire gt0_gttxreset_in0_out;
  wire [2:0]gt0_loopback_in;
  wire gt0_qplloutclk_in;
  wire gt0_qplloutrefclk_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire gt0_rxbyteisaligned_out;
  wire gt0_rxbyterealign_out;
  wire gt0_rxcdrhold_in;
  wire gt0_rxcommadet_out;
  wire gt0_rxdfeagcovrden_in;
  wire gt0_rxdfelpmreset_in;
  wire gt0_rxlpmen_in;
  wire gt0_rxmcommaalignen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txpcsreset_in;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gtrefclk;
  wire independent_clock_bufg;
  wire n_0_gthe2_i;
  wire n_10_rxpmarst_seq_i;
  wire n_11_rxpmarst_seq_i;
  wire n_12_rxpmarst_seq_i;
  wire n_13_rxpmarst_seq_i;
  wire n_14_rxpmarst_seq_i;
  wire n_15_rxpmarst_seq_i;
  wire n_16_rxpmarst_seq_i;
  wire n_17_rxpmarst_seq_i;
  wire n_18_rxpmarst_seq_i;
  wire n_19_rxpmarst_seq_i;
  wire n_1_rxpmarst_seq_i;
  wire n_20_rxpmarst_seq_i;
  wire n_21_rxpmarst_seq_i;
  wire n_22_rxpmarst_seq_i;
  wire n_23_rxpmarst_seq_i;
  wire n_24_rxpmarst_seq_i;
  wire n_25_rxpmarst_seq_i;
  wire n_26_rxpmarst_seq_i;
  wire n_27_rxpmarst_seq_i;
  wire n_2_gtrxreset_seq_i;
  wire n_2_rxpmarst_seq_i;
  wire n_3_gtrxreset_seq_i;
  wire n_3_rxpmarst_seq_i;
  wire n_46_gthe2_i;
  wire n_47_gthe2_i;
  wire n_4_gtrxreset_seq_i;
  wire n_4_rxpmarst_seq_i;
  wire n_50_gthe2_i;
  wire n_5_gtrxreset_seq_i;
  wire n_5_rxpmarst_seq_i;
  wire n_6_rxpmarst_seq_i;
  wire n_7_rxpmarst_seq_i;
  wire n_8_rxpmarst_seq_i;
  wire n_9_rxpmarst_seq_i;
  wire [15:0]rd_data;
  wire rxn;
  wire rxp;
  wire txn;
  wire txoutclk;
  wire txp;
  wire userclk;
  wire NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gthe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gthe2_i_RSOSINTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED;
  wire NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_RXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_RXSYNCOUT_UNCONNECTED;
  wire NLW_gthe2_i_RXVALID_UNCONNECTED;
  wire NLW_gthe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXPHINITDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gthe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gthe2_i_TXRATEDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCDONE_UNCONNECTED;
  wire NLW_gthe2_i_TXSYNCOUT_UNCONNECTED;
  wire [15:0]NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:2]NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:2]NLW_gthe2_i_RXCHARISK_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXCHBONDO_UNCONNECTED;
  wire [63:16]NLW_gthe2_i_RXDATA_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXDATAVALID_UNCONNECTED;
  wire [7:2]NLW_gthe2_i_RXDISPERR_UNCONNECTED;
  wire [5:0]NLW_gthe2_i_RXHEADER_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXHEADERVALID_UNCONNECTED;
  wire [7:2]NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [1:0]NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire [2:0]NLW_gthe2_i_RXSTATUS_UNCONNECTED;

FDRE #(
    .INIT(1'b0)) 
     drp_busy_i1_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .D(n_2_gtrxreset_seq_i),
        .Q(drp_busy_i1),
        .R(1'b0));
(* box_type = "PRIMITIVE" *) 
   GTHE2_CHANNEL #(
    .ACJTAG_DEBUG_MODE(1'b0),
    .ACJTAG_MODE(1'b0),
    .ACJTAG_RESET(1'b0),
    .ADAPT_CFG0(20'h00C10),
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(2),
    .ALIGN_MCOMMA_DET("TRUE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("TRUE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .A_RXOSCALRESET(1'b0),
    .CBCC_DATA_SOURCE_SEL("DECODED"),
    .CFOK_CFG(42'h24800040E80),
    .CFOK_CFG2(6'b100000),
    .CFOK_CFG3(6'b100000),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(1),
    .CHAN_BOND_SEQ_1_1(10'b0000000000),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0000000000),
    .CHAN_BOND_SEQ_2_2(10'b0000000000),
    .CHAN_BOND_SEQ_2_3(10'b0000000000),
    .CHAN_BOND_SEQ_2_4(10'b0000000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("TRUE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(36),
    .CLK_COR_MIN_LAT(33),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0110111100),
    .CLK_COR_SEQ_1_2(10'b0001010000),
    .CLK_COR_SEQ_1_3(10'b0000000000),
    .CLK_COR_SEQ_1_4(10'b0000000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0110111100),
    .CLK_COR_SEQ_2_2(10'b0010110101),
    .CLK_COR_SEQ_2_3(10'b0000000000),
    .CLK_COR_SEQ_2_4(10'b0000000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("TRUE"),
    .CLK_COR_SEQ_LEN(2),
    .CPLL_CFG(29'h00BC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("TRUE"),
    .DEC_PCOMMA_DETECT("TRUE"),
    .DEC_VALID_COMMA_ONLY("FALSE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CLK_PHASE_SEL(1'b0),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b000),
    .IS_CLKRSVD0_INVERTED(1'b0),
    .IS_CLKRSVD1_INVERTED(1'b0),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DMONITORCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_SIGVALIDCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .LOOPBACK_CFG(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000000),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'b00000000000000011000010010000000),
    .PMA_RSV2(32'b00011100000000000000000000001010),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(15'b000000000001000),
    .PMA_RSV5(4'b0000),
    .RESET_POWERSAVE_DISABLE(1'b0),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FULL"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(8),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(83'h0002007FE0800C2200018),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("FALSE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00001000000000),
    .RXLPM_LF_CFG(18'b001001000000000000),
    .RXOOB_CFG(7'b0000110),
    .RXOOB_CLK_CFG("PMA"),
    .RXOSCALRESET_TIME(5'b00011),
    .RXOSCALRESET_TIMEOUT(5'b00000),
    .RXOUT_DIV(4),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'hC00002),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPI_CFG0(2'b00),
    .RXPI_CFG1(2'b00),
    .RXPI_CFG2(2'b00),
    .RXPI_CFG3(2'b11),
    .RXPI_CFG4(1'b1),
    .RXPI_CFG5(1'b1),
    .RXPI_CFG6(3'b001),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b1),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RXSYNC_MULTILANE(1'b0),
    .RXSYNC_OVRD(1'b0),
    .RXSYNC_SKIP_DA(1'b0),
    .RX_BIAS_CFG(24'b000011000000000000010000),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(5),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(4'b1010),
    .RX_DATA_WIDTH(20),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(14'b00000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFELPM_CFG0(4'b0110),
    .RX_DFELPM_CFG1(1'b0),
    .RX_DFELPM_KLKH_AGC_STUP_EN(1'b1),
    .RX_DFE_AGC_CFG0(2'b00),
    .RX_DFE_AGC_CFG1(3'b100),
    .RX_DFE_AGC_CFG2(4'b0000),
    .RX_DFE_AGC_OVRDEN(1'b1),
    .RX_DFE_GAIN_CFG(23'h0020C0),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011100000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_H6_CFG(11'b00000100000),
    .RX_DFE_H7_CFG(11'b00000100000),
    .RX_DFE_KL_CFG(33'b001000001000000000000001100010000),
    .RX_DFE_KL_LPM_KH_CFG0(2'b01),
    .RX_DFE_KL_LPM_KH_CFG1(3'b010),
    .RX_DFE_KL_LPM_KH_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KH_OVRDEN(1'b1),
    .RX_DFE_KL_LPM_KL_CFG0(2'b10),
    .RX_DFE_KL_LPM_KL_CFG1(3'b010),
    .RX_DFE_KL_LPM_KL_CFG2(4'b0010),
    .RX_DFE_KL_LPM_KL_OVRDEN(1'b1),
    .RX_DFE_LPM_CFG(16'h0080),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_ST_CFG(54'h00E100000C003F),
    .RX_DFE_UT_CFG(17'b00011100000000000),
    .RX_DFE_VP_CFG(17'b00011101010100011),
    .RX_DISPERR_SEQ_MATCH("TRUE"),
    .RX_INT_DATAWIDTH(0),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b1111),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("TRUE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("2.0"),
    .TERM_RCAL_CFG(15'b100001000010000),
    .TERM_RCAL_OVRD(3'b000),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("TRUE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("FALSE"),
    .TXOOB_CFG(1'b0),
    .TXOUT_DIV(4),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPI_CFG0(2'b00),
    .TXPI_CFG1(2'b00),
    .TXPI_CFG2(2'b00),
    .TXPI_CFG3(1'b0),
    .TXPI_CFG4(1'b0),
    .TXPI_CFG5(3'b100),
    .TXPI_GREY_SEL(1'b0),
    .TXPI_INVSTROBE_SEL(1'b0),
    .TXPI_PPMCLK_SEL("TXUSRCLK2"),
    .TXPI_PPM_CFG(8'b00000000),
    .TXPI_SYNFREQ_PPM(3'b000),
    .TXPMARESET_TIME(5'b00001),
    .TXSYNC_MULTILANE(1'b0),
    .TXSYNC_OVRD(1'b0),
    .TXSYNC_SKIP_DA(1'b0),
    .TX_CLK25_DIV(5),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(20),
    .TX_DEEMPH0(6'b000000),
    .TX_DEEMPH1(6'b000000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(0),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_PRECHARGE_TIME(17'h155CC),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXOUT"),
    .UCODEER_CLR(1'b0),
    .USE_PCS_CLK_PHASE_SEL(1'b0)) 
     gthe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD0(1'b0),
        .CLKRSVD1(1'b0),
        .CPLLFBCLKLOST(n_0_gthe2_i),
        .CPLLLOCK(cplllock),
        .CPLLLOCKDETCLK(independent_clock_bufg),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b0),
        .CPLLREFCLKLOST(CPLLREFCLKLOST),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(CPLL_RESET),
        .DMONFIFORESET(1'b0),
        .DMONITORCLK(1'b0),
        .DMONITOROUT(gt0_dmonitorout_out),
        .DRPADDR({n_19_rxpmarst_seq_i,n_20_rxpmarst_seq_i,n_21_rxpmarst_seq_i,n_22_rxpmarst_seq_i,n_23_rxpmarst_seq_i,n_24_rxpmarst_seq_i,n_25_rxpmarst_seq_i,n_26_rxpmarst_seq_i,n_27_rxpmarst_seq_i}),
        .DRPCLK(gt0_drpclk_in),
        .DRPDI({n_1_rxpmarst_seq_i,n_2_rxpmarst_seq_i,n_3_rxpmarst_seq_i,n_4_rxpmarst_seq_i,n_5_gtrxreset_seq_i,n_5_rxpmarst_seq_i,n_6_rxpmarst_seq_i,n_7_rxpmarst_seq_i,n_8_rxpmarst_seq_i,n_9_rxpmarst_seq_i,n_10_rxpmarst_seq_i,n_11_rxpmarst_seq_i,n_12_rxpmarst_seq_i,n_13_rxpmarst_seq_i,n_14_rxpmarst_seq_i,n_15_rxpmarst_seq_i}),
        .DRPDO(gt0_drpdo_out),
        .DRPEN(n_4_gtrxreset_seq_i),
        .DRPRDY(O1),
        .DRPWE(n_16_rxpmarst_seq_i),
        .EYESCANDATAERROR(gt0_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt0_eyescanreset_in),
        .EYESCANTRIGGER(gt0_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTHRXN(rxn),
        .GTHRXP(rxp),
        .GTHTXN(txn),
        .GTHTXP(txp),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(gtrefclk),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gthe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(GTRXRESET_OUT),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(gt0_gttxreset_in0_out),
        .LOOPBACK(gt0_loopback_in),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gthe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gthe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(gt0_qplloutclk_in),
        .QPLLREFCLK(gt0_qplloutrefclk_in),
        .RESETOVRD(1'b0),
        .RSOSINTDONE(NLW_gthe2_i_RSOSINTDONE_UNCONNECTED),
        .RX8B10BEN(1'b1),
        .RXADAPTSELTEST({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXBUFRESET(gt0_rxbufreset_in),
        .RXBUFSTATUS(gt0_rxbufstatus_out),
        .RXBYTEISALIGNED(gt0_rxbyteisaligned_out),
        .RXBYTEREALIGN(gt0_rxbyterealign_out),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(gt0_rxcdrhold_in),
        .RXCDRLOCK(NLW_gthe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(NLW_gthe2_i_RXCHANBONDSEQ_UNCONNECTED),
        .RXCHANISALIGNED(NLW_gthe2_i_RXCHANISALIGNED_UNCONNECTED),
        .RXCHANREALIGN(NLW_gthe2_i_RXCHANREALIGN_UNCONNECTED),
        .RXCHARISCOMMA({NLW_gthe2_i_RXCHARISCOMMA_UNCONNECTED[7:2],O6}),
        .RXCHARISK({NLW_gthe2_i_RXCHARISK_UNCONNECTED[7:2],O7}),
        .RXCHBONDEN(1'b0),
        .RXCHBONDI({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b0}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO(NLW_gthe2_i_RXCHBONDO_UNCONNECTED[4:0]),
        .RXCHBONDSLAVE(1'b0),
        .RXCLKCORCNT(D),
        .RXCOMINITDET(NLW_gthe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(gt0_rxcommadet_out),
        .RXCOMMADETEN(1'b1),
        .RXCOMSASDET(NLW_gthe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gthe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA({NLW_gthe2_i_RXDATA_UNCONNECTED[63:16],O5}),
        .RXDATAVALID(NLW_gthe2_i_RXDATAVALID_UNCONNECTED[1:0]),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(RXDFELFHOLD),
        .RXDFEAGCOVRDEN(gt0_rxdfeagcovrden_in),
        .RXDFEAGCTRL({1'b1,1'b0,1'b0,1'b0,1'b0}),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(RXDFELFHOLD),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(gt0_rxdfelpmreset_in),
        .RXDFESLIDETAP({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPADAPTEN(1'b0),
        .RXDFESLIDETAPHOLD(1'b0),
        .RXDFESLIDETAPID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXDFESLIDETAPINITOVRDEN(1'b0),
        .RXDFESLIDETAPONLYADAPTEN(1'b0),
        .RXDFESLIDETAPOVRDEN(1'b0),
        .RXDFESLIDETAPSTARTED(NLW_gthe2_i_RXDFESLIDETAPSTARTED_UNCONNECTED),
        .RXDFESLIDETAPSTROBE(1'b0),
        .RXDFESLIDETAPSTROBEDONE(NLW_gthe2_i_RXDFESLIDETAPSTROBEDONE_UNCONNECTED),
        .RXDFESLIDETAPSTROBESTARTED(NLW_gthe2_i_RXDFESLIDETAPSTROBESTARTED_UNCONNECTED),
        .RXDFESTADAPTDONE(NLW_gthe2_i_RXDFESTADAPTDONE_UNCONNECTED),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFETAP6HOLD(1'b0),
        .RXDFETAP6OVRDEN(1'b0),
        .RXDFETAP7HOLD(1'b0),
        .RXDFETAP7OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDISPERR({NLW_gthe2_i_RXDISPERR_UNCONNECTED[7:2],O8}),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gthe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gthe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(1'b0),
        .RXHEADER(NLW_gthe2_i_RXHEADER_UNCONNECTED[5:0]),
        .RXHEADERVALID(NLW_gthe2_i_RXHEADERVALID_UNCONNECTED[1:0]),
        .RXLPMEN(gt0_rxlpmen_in),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(gt0_rxmcommaalignen_in),
        .RXMONITOROUT(gt0_rxmonitorout_out),
        .RXMONITORSEL(gt0_rxmonitorsel_in),
        .RXNOTINTABLE({NLW_gthe2_i_RXNOTINTABLE_UNCONNECTED[7:2],O9}),
        .RXOOBRESET(1'b0),
        .RXOSCALRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSINTCFG({1'b0,1'b1,1'b1,1'b0}),
        .RXOSINTEN(1'b1),
        .RXOSINTHOLD(1'b0),
        .RXOSINTID0({1'b0,1'b0,1'b0,1'b0}),
        .RXOSINTNTRLEN(1'b0),
        .RXOSINTOVRDEN(1'b0),
        .RXOSINTSTARTED(NLW_gthe2_i_RXOSINTSTARTED_UNCONNECTED),
        .RXOSINTSTROBE(1'b0),
        .RXOSINTSTROBEDONE(NLW_gthe2_i_RXOSINTSTROBEDONE_UNCONNECTED),
        .RXOSINTSTROBESTARTED(NLW_gthe2_i_RXOSINTSTROBESTARTED_UNCONNECTED),
        .RXOSINTTESTOVRDEN(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(I),
        .RXOUTCLKFABRIC(NLW_gthe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gthe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(gt0_rxmcommaalignen_in),
        .RXPCSRESET(gt0_rxpcsreset_in),
        .RXPD({RXPD,RXPD}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gthe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gthe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gthe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(RXPMARESET_OUT),
        .RXPMARESETDONE(O2),
        .RXPOLARITY(gt0_rxpolarity_in),
        .RXPRBSCNTRESET(gt0_rxprbscntreset_in),
        .RXPRBSERR(gt0_rxprbserr_out),
        .RXPRBSSEL(gt0_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gthe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gthe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE({1'b0,1'b0,1'b0}),
        .RXRATEDONE(NLW_gthe2_i_RXRATEDONE_UNCONNECTED),
        .RXRATEMODE(1'b0),
        .RXRESETDONE(O3),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gthe2_i_RXSTARTOFSEQ_UNCONNECTED[1:0]),
        .RXSTATUS(NLW_gthe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYNCALLIN(1'b0),
        .RXSYNCDONE(NLW_gthe2_i_RXSYNCDONE_UNCONNECTED),
        .RXSYNCIN(1'b0),
        .RXSYNCMODE(1'b0),
        .RXSYNCOUT(NLW_gthe2_i_RXSYNCOUT_UNCONNECTED),
        .RXSYSCLKSEL({1'b0,1'b0}),
        .RXUSERRDY(RXUSERRDY),
        .RXUSRCLK(userclk),
        .RXUSRCLK2(userclk),
        .RXVALID(NLW_gthe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .SIGVALIDCLK(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b1),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(gt0_txbufstatus_out),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,I1}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,I2}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,I3}),
        .TXCOMFINISH(NLW_gthe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,Q}),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL(gt0_txdiffctrl_in),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b1),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(1'b0),
        .TXDLYSRESETDONE(NLW_gthe2_i_TXDLYSRESETDONE_UNCONNECTED),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(TXPD),
        .TXGEARBOXREADY(NLW_gthe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,1'b0,1'b0}),
        .TXINHIBIT(1'b0),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(txoutclk),
        .TXOUTCLKFABRIC(n_46_gthe2_i),
        .TXOUTCLKPCS(n_47_gthe2_i),
        .TXOUTCLKSEL({1'b1,1'b0,1'b0}),
        .TXPCSRESET(gt0_txpcsreset_in),
        .TXPD({TXPD,TXPD}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(1'b0),
        .TXPHALIGNDONE(NLW_gthe2_i_TXPHALIGNDONE_UNCONNECTED),
        .TXPHALIGNEN(1'b0),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(1'b0),
        .TXPHINITDONE(NLW_gthe2_i_TXPHINITDONE_UNCONNECTED),
        .TXPHOVRDEN(1'b0),
        .TXPIPPMEN(1'b0),
        .TXPIPPMOVRDEN(1'b0),
        .TXPIPPMPD(1'b0),
        .TXPIPPMSEL(1'b0),
        .TXPIPPMSTEPSIZE({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXPISOPD(1'b0),
        .TXPMARESET(gt0_txpmareset_in),
        .TXPMARESETDONE(n_50_gthe2_i),
        .TXPOLARITY(gt0_txpolarity_in),
        .TXPOSTCURSOR(gt0_txpostcursor_in),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt0_txprbsforceerr_in),
        .TXPRBSSEL(gt0_txprbssel_in),
        .TXPRECURSOR(gt0_txprecursor_in),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gthe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gthe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gthe2_i_TXRATEDONE_UNCONNECTED),
        .TXRATEMODE(1'b0),
        .TXRESETDONE(O4),
        .TXSEQUENCE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYNCALLIN(1'b0),
        .TXSYNCDONE(NLW_gthe2_i_TXSYNCDONE_UNCONNECTED),
        .TXSYNCIN(1'b0),
        .TXSYNCMODE(1'b0),
        .TXSYNCOUT(NLW_gthe2_i_TXSYNCOUT_UNCONNECTED),
        .TXSYSCLKSEL({1'b0,1'b0}),
        .TXUSERRDY(TXUSERRDY),
        .TXUSRCLK(userclk),
        .TXUSRCLK2(userclk));
gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_gtwizard_gtrxreset_seq gtrxreset_seq_i
       (.CPLL_RESET(CPLL_RESET),
        .DRPDI(n_5_gtrxreset_seq_i),
        .DRP_OP_DONE(DRP_OP_DONE),
        .GTRXRESET_OUT(GTRXRESET_OUT),
        .I1(O1),
        .I2(n_18_rxpmarst_seq_i),
        .I3(n_17_rxpmarst_seq_i),
        .O1(n_2_gtrxreset_seq_i),
        .O2(O2),
        .O3(n_3_gtrxreset_seq_i),
        .O4(n_4_gtrxreset_seq_i),
        .Q({rd_data[15:12],rd_data[10:0]}),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdo_out({gt0_drpdo_out[15:12],gt0_drpdo_out[10:0]}),
        .gt0_gtrxreset_in1_out(gt0_gtrxreset_in1_out));
gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_gtwizard_rxpmarst_seq rxpmarst_seq_i
       (.CPLL_RESET(CPLL_RESET),
        .DRPADDR({n_19_rxpmarst_seq_i,n_20_rxpmarst_seq_i,n_21_rxpmarst_seq_i,n_22_rxpmarst_seq_i,n_23_rxpmarst_seq_i,n_24_rxpmarst_seq_i,n_25_rxpmarst_seq_i,n_26_rxpmarst_seq_i,n_27_rxpmarst_seq_i}),
        .DRPDI({n_1_rxpmarst_seq_i,n_2_rxpmarst_seq_i,n_3_rxpmarst_seq_i,n_4_rxpmarst_seq_i,n_5_rxpmarst_seq_i,n_6_rxpmarst_seq_i,n_7_rxpmarst_seq_i,n_8_rxpmarst_seq_i,n_9_rxpmarst_seq_i,n_10_rxpmarst_seq_i,n_11_rxpmarst_seq_i,n_12_rxpmarst_seq_i,n_13_rxpmarst_seq_i,n_14_rxpmarst_seq_i,n_15_rxpmarst_seq_i}),
        .DRP_OP_DONE(DRP_OP_DONE),
        .I1(O1),
        .I2(n_3_gtrxreset_seq_i),
        .O1(n_16_rxpmarst_seq_i),
        .O2(O2),
        .O3(n_17_rxpmarst_seq_i),
        .O4(n_18_rxpmarst_seq_i),
        .Q({rd_data[15:12],rd_data[10:0]}),
        .RXPMARESET_OUT(RXPMARESET_OUT),
        .drp_busy_i1(drp_busy_i1),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out({gt0_drpdo_out[15:12],gt0_drpdo_out[10:0]}),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_rxpmareset_in(gt0_rxpmareset_in));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_GTWIZARD" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_GTWIZARD__parameterized0
   (cplllock,
    O1,
    gt0_eyescandataerror_out,
    txn,
    txp,
    gt0_rxbyteisaligned_out,
    gt0_rxbyterealign_out,
    gt0_rxcommadet_out,
    I,
    O2,
    gt0_rxprbserr_out,
    txoutclk,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    D,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    O3,
    gt0_rxmonitorout_out,
    O4,
    O5,
    O6,
    O7,
    O8,
    O9,
    resetdone,
    independent_clock_bufg,
    gt0_drpclk_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    rxn,
    rxp,
    gtrefclk,
    gt0_qplloutclk_in,
    gt0_qplloutrefclk_in,
    gt0_rxbufreset_in,
    gt0_rxcdrhold_in,
    gt0_rxdfeagcovrden_in,
    gt0_rxdfelpmreset_in,
    gt0_rxlpmen_in,
    gt0_rxmcommaalignen_in,
    gt0_rxpcsreset_in,
    gt0_rxpolarity_in,
    gt0_rxprbscntreset_in,
    userclk,
    TXPD,
    gt0_txpcsreset_in,
    gt0_txpmareset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_rxmonitorsel_in,
    RXPD,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txprbssel_in,
    gt0_txdiffctrl_in,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    Q,
    I1,
    I2,
    I3,
    gt0_rxpmareset_in,
    mmcm_locked,
    rxuserclk,
    data_out,
    pma_reset,
    gt0_drpdi_in,
    gt0_drpwe_in,
    gt0_drpen_in,
    gt0_drpaddr_in,
    reset_out0_in,
    reset_out);
  output cplllock;
  output O1;
  output gt0_eyescandataerror_out;
  output txn;
  output txp;
  output gt0_rxbyteisaligned_out;
  output gt0_rxbyterealign_out;
  output gt0_rxcommadet_out;
  output I;
  output O2;
  output gt0_rxprbserr_out;
  output txoutclk;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output [1:0]D;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [15:0]O3;
  output [6:0]gt0_rxmonitorout_out;
  output [1:0]O4;
  output [1:0]O5;
  output [1:0]O6;
  output [1:0]O7;
  output O8;
  output O9;
  output resetdone;
  input independent_clock_bufg;
  input gt0_drpclk_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input rxn;
  input rxp;
  input gtrefclk;
  input gt0_qplloutclk_in;
  input gt0_qplloutrefclk_in;
  input gt0_rxbufreset_in;
  input gt0_rxcdrhold_in;
  input gt0_rxdfeagcovrden_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxlpmen_in;
  input gt0_rxmcommaalignen_in;
  input gt0_rxpcsreset_in;
  input gt0_rxpolarity_in;
  input gt0_rxprbscntreset_in;
  input userclk;
  input [0:0]TXPD;
  input gt0_txpcsreset_in;
  input gt0_txpmareset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input [1:0]gt0_rxmonitorsel_in;
  input [0:0]RXPD;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_txprbssel_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input [15:0]Q;
  input [1:0]I1;
  input [1:0]I2;
  input [1:0]I3;
  input gt0_rxpmareset_in;
  input mmcm_locked;
  input rxuserclk;
  input data_out;
  input pma_reset;
  input [15:0]gt0_drpdi_in;
  input gt0_drpwe_in;
  input gt0_drpen_in;
  input [8:0]gt0_drpaddr_in;
  input reset_out0_in;
  input reset_out;

  wire [1:0]D;
  wire I;
  wire [1:0]I1;
  wire [1:0]I2;
  wire [1:0]I3;
  wire O1;
  wire O2;
  wire [15:0]O3;
  wire [1:0]O4;
  wire [1:0]O5;
  wire [1:0]O6;
  wire [1:0]O7;
  wire O8;
  wire O9;
  wire [15:0]Q;
  wire [0:0]RXPD;
  wire [0:0]TXPD;
  wire cplllock;
  wire data_out;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire [2:0]gt0_loopback_in;
  wire gt0_qplloutclk_in;
  wire gt0_qplloutrefclk_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire gt0_rxbyteisaligned_out;
  wire gt0_rxbyterealign_out;
  wire gt0_rxcdrhold_in;
  wire gt0_rxcommadet_out;
  wire gt0_rxdfeagcovrden_in;
  wire gt0_rxdfelpmreset_in;
  wire gt0_rxlpmen_in;
  wire gt0_rxmcommaalignen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txpcsreset_in;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gtrefclk;
  wire independent_clock_bufg;
  wire mmcm_locked;
  wire pma_reset;
  wire reset_out;
  wire reset_out0_in;
  wire resetdone;
  wire rxn;
  wire rxp;
  wire rxuserclk;
  wire txn;
  wire txoutclk;
  wire txp;
  wire userclk;

gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_GTWIZARD_init__parameterized0 U0
       (.D(D),
        .I(I),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .O1(O1),
        .O2(O2),
        .O3(O3),
        .O4(O4),
        .O5(O5),
        .O6(O6),
        .O7(O7),
        .O8(O8),
        .O9(O9),
        .Q(Q),
        .RXPD(RXPD),
        .TXPD(TXPD),
        .cplllock(cplllock),
        .data_out(data_out),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_qplloutclk_in(gt0_qplloutclk_in),
        .gt0_qplloutrefclk_in(gt0_qplloutrefclk_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxbyteisaligned_out(gt0_rxbyteisaligned_out),
        .gt0_rxbyterealign_out(gt0_rxbyterealign_out),
        .gt0_rxcdrhold_in(gt0_rxcdrhold_in),
        .gt0_rxcommadet_out(gt0_rxcommadet_out),
        .gt0_rxdfeagcovrden_in(gt0_rxdfeagcovrden_in),
        .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),
        .gt0_rxlpmen_in(gt0_rxlpmen_in),
        .gt0_rxmcommaalignen_in(gt0_rxmcommaalignen_in),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxpmareset_in(gt0_rxpmareset_in),
        .gt0_rxpolarity_in(gt0_rxpolarity_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdiffctrl_in(gt0_txdiffctrl_in),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpmareset_in(gt0_txpmareset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txpostcursor_in(gt0_txpostcursor_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txprecursor_in(gt0_txprecursor_in),
        .gtrefclk(gtrefclk),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked(mmcm_locked),
        .pma_reset(pma_reset),
        .reset_out(reset_out),
        .reset_out0_in(reset_out0_in),
        .resetdone(resetdone),
        .rxn(rxn),
        .rxp(rxp),
        .rxuserclk(rxuserclk),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp),
        .userclk(userclk));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_GTWIZARD_init" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_GTWIZARD_init__parameterized0
   (cplllock,
    O1,
    gt0_eyescandataerror_out,
    txn,
    txp,
    gt0_rxbyteisaligned_out,
    gt0_rxbyterealign_out,
    gt0_rxcommadet_out,
    I,
    O2,
    gt0_rxprbserr_out,
    txoutclk,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    D,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    O3,
    gt0_rxmonitorout_out,
    O4,
    O5,
    O6,
    O7,
    O8,
    O9,
    resetdone,
    independent_clock_bufg,
    gt0_drpclk_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    rxn,
    rxp,
    gtrefclk,
    gt0_qplloutclk_in,
    gt0_qplloutrefclk_in,
    gt0_rxbufreset_in,
    gt0_rxcdrhold_in,
    gt0_rxdfeagcovrden_in,
    gt0_rxdfelpmreset_in,
    gt0_rxlpmen_in,
    gt0_rxmcommaalignen_in,
    gt0_rxpcsreset_in,
    gt0_rxpolarity_in,
    gt0_rxprbscntreset_in,
    userclk,
    TXPD,
    gt0_txpcsreset_in,
    gt0_txpmareset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_rxmonitorsel_in,
    RXPD,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txprbssel_in,
    gt0_txdiffctrl_in,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    Q,
    I1,
    I2,
    I3,
    gt0_rxpmareset_in,
    mmcm_locked,
    rxuserclk,
    data_out,
    pma_reset,
    gt0_drpdi_in,
    gt0_drpwe_in,
    gt0_drpen_in,
    gt0_drpaddr_in,
    reset_out0_in,
    reset_out);
  output cplllock;
  output O1;
  output gt0_eyescandataerror_out;
  output txn;
  output txp;
  output gt0_rxbyteisaligned_out;
  output gt0_rxbyterealign_out;
  output gt0_rxcommadet_out;
  output I;
  output O2;
  output gt0_rxprbserr_out;
  output txoutclk;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output [1:0]D;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [15:0]O3;
  output [6:0]gt0_rxmonitorout_out;
  output [1:0]O4;
  output [1:0]O5;
  output [1:0]O6;
  output [1:0]O7;
  output O8;
  output O9;
  output resetdone;
  input independent_clock_bufg;
  input gt0_drpclk_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input rxn;
  input rxp;
  input gtrefclk;
  input gt0_qplloutclk_in;
  input gt0_qplloutrefclk_in;
  input gt0_rxbufreset_in;
  input gt0_rxcdrhold_in;
  input gt0_rxdfeagcovrden_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxlpmen_in;
  input gt0_rxmcommaalignen_in;
  input gt0_rxpcsreset_in;
  input gt0_rxpolarity_in;
  input gt0_rxprbscntreset_in;
  input userclk;
  input [0:0]TXPD;
  input gt0_txpcsreset_in;
  input gt0_txpmareset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input [1:0]gt0_rxmonitorsel_in;
  input [0:0]RXPD;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_txprbssel_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input [15:0]Q;
  input [1:0]I1;
  input [1:0]I2;
  input [1:0]I3;
  input gt0_rxpmareset_in;
  input mmcm_locked;
  input rxuserclk;
  input data_out;
  input pma_reset;
  input [15:0]gt0_drpdi_in;
  input gt0_drpwe_in;
  input gt0_drpen_in;
  input [8:0]gt0_drpaddr_in;
  input reset_out0_in;
  input reset_out;

  wire CPLLREFCLKLOST;
  wire CPLL_RESET;
  wire [1:0]D;
  wire I;
  wire [1:0]I1;
  wire [1:0]I2;
  wire [1:0]I3;
  wire O1;
  wire O2;
  wire [15:0]O3;
  wire [1:0]O4;
  wire [1:0]O5;
  wire [1:0]O6;
  wire [1:0]O7;
  wire O8;
  wire O9;
  wire [15:0]Q;
  wire RXDFELFHOLD;
  wire [0:0]RXPD;
  wire RXUSERRDY;
  wire [0:0]TXPD;
  wire TXUSERRDY;
  wire cplllock;
  wire data_out;
  wire data_out_0;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire gt0_gtrxreset_in1_out;
  wire gt0_gttxreset_in0_out;
  wire [2:0]gt0_loopback_in;
  wire gt0_qplloutclk_in;
  wire gt0_qplloutrefclk_in;
  wire [13:1]gt0_rx_cdrlock_counter0;
  wire gt0_rx_cdrlocked;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire gt0_rxbyteisaligned_out;
  wire gt0_rxbyterealign_out;
  wire gt0_rxcdrhold_in;
  wire gt0_rxcommadet_out;
  wire gt0_rxdfeagcovrden_in;
  wire gt0_rxdfelpmreset_in;
  wire gt0_rxlpmen_in;
  wire gt0_rxmcommaalignen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txpcsreset_in;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gtrefclk;
  wire independent_clock_bufg;
  wire mmcm_locked;
  wire \n_0_gt0_rx_cdrlock_counter[0]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[10]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[11]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_4 ;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_5 ;
  wire \n_0_gt0_rx_cdrlock_counter[12]_i_6 ;
  wire \n_0_gt0_rx_cdrlock_counter[13]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[13]_i_2 ;
  wire \n_0_gt0_rx_cdrlock_counter[13]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[13]_i_5 ;
  wire \n_0_gt0_rx_cdrlock_counter[1]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[2]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[3]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_4 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_5 ;
  wire \n_0_gt0_rx_cdrlock_counter[4]_i_6 ;
  wire \n_0_gt0_rx_cdrlock_counter[5]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[6]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[7]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_3 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_4 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_5 ;
  wire \n_0_gt0_rx_cdrlock_counter[8]_i_6 ;
  wire \n_0_gt0_rx_cdrlock_counter[9]_i_1 ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[0] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[10] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[11] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[12] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[13] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[1] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[2] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[3] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[4] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[5] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[6] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[7] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[8] ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire \n_0_gt0_rx_cdrlock_counter_reg[9] ;
  wire n_0_gt0_rx_cdrlocked_i_1;
  wire n_12_gtwizard_i;
  wire n_14_gtwizard_i;
  wire \n_1_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_1_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_1_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire \n_2_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_2_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_2_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire \n_3_gt0_rx_cdrlock_counter_reg[12]_i_2 ;
  wire \n_3_gt0_rx_cdrlock_counter_reg[4]_i_2 ;
  wire \n_3_gt0_rx_cdrlock_counter_reg[8]_i_2 ;
  wire pma_reset;
  wire reset_out;
  wire reset_out0_in;
  wire resetdone;
  wire rxn;
  wire rxp;
  wire rxuserclk;
  wire txn;
  wire txoutclk;
  wire txp;
  wire userclk;
  wire [3:0]\NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_CO_UNCONNECTED ;
  wire [3:1]\NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_O_UNCONNECTED ;

(* SOFT_HLUTNM = "soft_lutpair133" *) 
   LUT4 #(
    .INIT(16'h00FE)) 
     \gt0_rx_cdrlock_counter[0]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .O(\n_0_gt0_rx_cdrlock_counter[0]_i_1 ));
LUT5 #(
    .INIT(32'hFFFF0001)) 
     \gt0_rx_cdrlock_counter[10]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[10]),
        .O(\n_0_gt0_rx_cdrlock_counter[10]_i_1 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[11]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[11]),
        .O(\n_0_gt0_rx_cdrlock_counter[11]_i_1 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[12]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[12]),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_1 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[12]_i_3 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[12] ),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[12]_i_4 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[11] ),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[12]_i_5 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[10] ),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[12]_i_6 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[9] ),
        .O(\n_0_gt0_rx_cdrlock_counter[12]_i_6 ));
LUT5 #(
    .INIT(32'hFFFF0001)) 
     \gt0_rx_cdrlock_counter[13]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[13]),
        .O(\n_0_gt0_rx_cdrlock_counter[13]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFDFFFFFFFF)) 
     \gt0_rx_cdrlock_counter[13]_i_2 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[10] ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[12] ),
        .I2(\n_0_gt0_rx_cdrlock_counter_reg[2] ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[3] ),
        .I4(\n_0_gt0_rx_cdrlock_counter_reg[1] ),
        .I5(\n_0_gt0_rx_cdrlock_counter_reg[13] ),
        .O(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ));
LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
     \gt0_rx_cdrlock_counter[13]_i_3 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[4] ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[6] ),
        .I2(\n_0_gt0_rx_cdrlock_counter_reg[11] ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[9] ),
        .I4(\n_0_gt0_rx_cdrlock_counter_reg[7] ),
        .I5(\n_0_gt0_rx_cdrlock_counter_reg[8] ),
        .O(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[13]_i_5 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[13] ),
        .O(\n_0_gt0_rx_cdrlock_counter[13]_i_5 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[1]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[1]),
        .O(\n_0_gt0_rx_cdrlock_counter[1]_i_1 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[2]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[2]),
        .O(\n_0_gt0_rx_cdrlock_counter[2]_i_1 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[3]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[3]),
        .O(\n_0_gt0_rx_cdrlock_counter[3]_i_1 ));
LUT5 #(
    .INIT(32'hFFFF0001)) 
     \gt0_rx_cdrlock_counter[4]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[4]),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_1 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[4]_i_3 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[4] ),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[4]_i_4 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[3] ),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[4]_i_5 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[2] ),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[4]_i_6 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[1] ),
        .O(\n_0_gt0_rx_cdrlock_counter[4]_i_6 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[5]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[5]),
        .O(\n_0_gt0_rx_cdrlock_counter[5]_i_1 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[6]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[6]),
        .O(\n_0_gt0_rx_cdrlock_counter[6]_i_1 ));
LUT5 #(
    .INIT(32'hFFFE0000)) 
     \gt0_rx_cdrlock_counter[7]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[7]),
        .O(\n_0_gt0_rx_cdrlock_counter[7]_i_1 ));
LUT5 #(
    .INIT(32'hFFFF0001)) 
     \gt0_rx_cdrlock_counter[8]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[8]),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_1 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[8]_i_3 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[8] ),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[8]_i_4 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[7] ),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[8]_i_5 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[6] ),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \gt0_rx_cdrlock_counter[8]_i_6 
       (.I0(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .O(\n_0_gt0_rx_cdrlock_counter[8]_i_6 ));
LUT5 #(
    .INIT(32'hFFFF0001)) 
     \gt0_rx_cdrlock_counter[9]_i_1 
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlock_counter0[9]),
        .O(\n_0_gt0_rx_cdrlock_counter[9]_i_1 ));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[0] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[0]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[10] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[10]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[10] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[11] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[11]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[11] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[12] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[12]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[12] ),
        .R(data_out_0));
CARRY4 \gt0_rx_cdrlock_counter_reg[12]_i_2 
       (.CI(\n_0_gt0_rx_cdrlock_counter_reg[8]_i_2 ),
        .CO({\n_0_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_1_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_2_gt0_rx_cdrlock_counter_reg[12]_i_2 ,\n_3_gt0_rx_cdrlock_counter_reg[12]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(gt0_rx_cdrlock_counter0[12:9]),
        .S({\n_0_gt0_rx_cdrlock_counter[12]_i_3 ,\n_0_gt0_rx_cdrlock_counter[12]_i_4 ,\n_0_gt0_rx_cdrlock_counter[12]_i_5 ,\n_0_gt0_rx_cdrlock_counter[12]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[13] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[13]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[13] ),
        .R(data_out_0));
CARRY4 \gt0_rx_cdrlock_counter_reg[13]_i_4 
       (.CI(\n_0_gt0_rx_cdrlock_counter_reg[12]_i_2 ),
        .CO(\NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_gt0_rx_cdrlock_counter_reg[13]_i_4_O_UNCONNECTED [3:1],gt0_rx_cdrlock_counter0[13]}),
        .S({1'b0,1'b0,1'b0,\n_0_gt0_rx_cdrlock_counter[13]_i_5 }));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[1] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[1]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[1] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[2] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[2]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[2] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[3] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[3]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[3] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[4] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[4]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[4] ),
        .R(data_out_0));
CARRY4 \gt0_rx_cdrlock_counter_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\n_0_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_1_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_2_gt0_rx_cdrlock_counter_reg[4]_i_2 ,\n_3_gt0_rx_cdrlock_counter_reg[4]_i_2 }),
        .CYINIT(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(gt0_rx_cdrlock_counter0[4:1]),
        .S({\n_0_gt0_rx_cdrlock_counter[4]_i_3 ,\n_0_gt0_rx_cdrlock_counter[4]_i_4 ,\n_0_gt0_rx_cdrlock_counter[4]_i_5 ,\n_0_gt0_rx_cdrlock_counter[4]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[5] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[5]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[6] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[6]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[6] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[7] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[7]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[7] ),
        .R(data_out_0));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[8] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[8]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[8] ),
        .R(data_out_0));
CARRY4 \gt0_rx_cdrlock_counter_reg[8]_i_2 
       (.CI(\n_0_gt0_rx_cdrlock_counter_reg[4]_i_2 ),
        .CO({\n_0_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_1_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_2_gt0_rx_cdrlock_counter_reg[8]_i_2 ,\n_3_gt0_rx_cdrlock_counter_reg[8]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(gt0_rx_cdrlock_counter0[8:5]),
        .S({\n_0_gt0_rx_cdrlock_counter[8]_i_3 ,\n_0_gt0_rx_cdrlock_counter[8]_i_4 ,\n_0_gt0_rx_cdrlock_counter[8]_i_5 ,\n_0_gt0_rx_cdrlock_counter[8]_i_6 }));
FDRE #(
    .INIT(1'b0)) 
     \gt0_rx_cdrlock_counter_reg[9] 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_gt0_rx_cdrlock_counter[9]_i_1 ),
        .Q(\n_0_gt0_rx_cdrlock_counter_reg[9] ),
        .R(data_out_0));
(* SOFT_HLUTNM = "soft_lutpair133" *) 
   LUT5 #(
    .INIT(32'hFFFF0001)) 
     gt0_rx_cdrlocked_i_1
       (.I0(\n_0_gt0_rx_cdrlock_counter[13]_i_2 ),
        .I1(\n_0_gt0_rx_cdrlock_counter_reg[5] ),
        .I2(\n_0_gt0_rx_cdrlock_counter[13]_i_3 ),
        .I3(\n_0_gt0_rx_cdrlock_counter_reg[0] ),
        .I4(gt0_rx_cdrlocked),
        .O(n_0_gt0_rx_cdrlocked_i_1));
FDRE gt0_rx_cdrlocked_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_gt0_rx_cdrlocked_i_1),
        .Q(gt0_rx_cdrlocked),
        .R(data_out_0));
gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_RX_STARTUP_FSM__parameterized0 gt0_rxresetfsm_i
       (.CPLLREFCLKLOST(CPLLREFCLKLOST),
        .I1(O2),
        .I2(n_12_gtwizard_i),
        .O1(O9),
        .RXDFELFHOLD(RXDFELFHOLD),
        .RXUSERRDY(RXUSERRDY),
        .cplllock(cplllock),
        .data_out(data_out),
        .gt0_gtrxreset_in1_out(gt0_gtrxreset_in1_out),
        .gt0_rx_cdrlocked(gt0_rx_cdrlocked),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked(mmcm_locked),
        .pma_reset(pma_reset),
        .reset_out0_in(reset_out0_in),
        .rxuserclk(rxuserclk),
        .userclk(userclk));
gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_TX_STARTUP_FSM__parameterized0 gt0_txresetfsm_i
       (.CPLLREFCLKLOST(CPLLREFCLKLOST),
        .CPLL_RESET(CPLL_RESET),
        .I1(n_14_gtwizard_i),
        .O1(O8),
        .O9(O9),
        .TXUSERRDY(TXUSERRDY),
        .cplllock(cplllock),
        .gt0_gttxreset_in0_out(gt0_gttxreset_in0_out),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked(mmcm_locked),
        .pma_reset(pma_reset),
        .reset_out(reset_out),
        .resetdone(resetdone),
        .userclk(userclk));
gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_GTWIZARD_multi_gt__parameterized0 gtwizard_i
       (.CPLLREFCLKLOST(CPLLREFCLKLOST),
        .CPLL_RESET(CPLL_RESET),
        .D(D),
        .I(I),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .O1(O1),
        .O2(O2),
        .O3(n_12_gtwizard_i),
        .O4(n_14_gtwizard_i),
        .O5(O3),
        .O6(O4),
        .O7(O5),
        .O8(O6),
        .O9(O7),
        .Q(Q),
        .RXDFELFHOLD(RXDFELFHOLD),
        .RXPD(RXPD),
        .RXUSERRDY(RXUSERRDY),
        .TXPD(TXPD),
        .TXUSERRDY(TXUSERRDY),
        .cplllock(cplllock),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_gtrxreset_in1_out(gt0_gtrxreset_in1_out),
        .gt0_gttxreset_in0_out(gt0_gttxreset_in0_out),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_qplloutclk_in(gt0_qplloutclk_in),
        .gt0_qplloutrefclk_in(gt0_qplloutrefclk_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxbyteisaligned_out(gt0_rxbyteisaligned_out),
        .gt0_rxbyterealign_out(gt0_rxbyterealign_out),
        .gt0_rxcdrhold_in(gt0_rxcdrhold_in),
        .gt0_rxcommadet_out(gt0_rxcommadet_out),
        .gt0_rxdfeagcovrden_in(gt0_rxdfeagcovrden_in),
        .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),
        .gt0_rxlpmen_in(gt0_rxlpmen_in),
        .gt0_rxmcommaalignen_in(gt0_rxmcommaalignen_in),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxpmareset_in(gt0_rxpmareset_in),
        .gt0_rxpolarity_in(gt0_rxpolarity_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdiffctrl_in(gt0_txdiffctrl_in),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpmareset_in(gt0_txpmareset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txpostcursor_in(gt0_txpostcursor_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txprecursor_in(gt0_txprecursor_in),
        .gtrefclk(gtrefclk),
        .independent_clock_bufg(independent_clock_bufg),
        .rxn(rxn),
        .rxp(rxp),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp),
        .userclk(userclk));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__41 sync_block_gtrxreset
       (.clk(independent_clock_bufg),
        .data_in(gt0_gtrxreset_in1_out),
        .data_out(data_out_0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_GTWIZARD_multi_gt" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_GTWIZARD_multi_gt__parameterized0
   (cplllock,
    CPLLREFCLKLOST,
    O1,
    gt0_eyescandataerror_out,
    txn,
    txp,
    gt0_rxbyteisaligned_out,
    gt0_rxbyterealign_out,
    gt0_rxcommadet_out,
    I,
    O2,
    gt0_rxprbserr_out,
    O3,
    txoutclk,
    O4,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    D,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    O5,
    gt0_rxmonitorout_out,
    O6,
    O7,
    O8,
    O9,
    independent_clock_bufg,
    CPLL_RESET,
    gt0_drpclk_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    rxn,
    rxp,
    gtrefclk,
    gt0_gttxreset_in0_out,
    gt0_qplloutclk_in,
    gt0_qplloutrefclk_in,
    gt0_rxbufreset_in,
    gt0_rxcdrhold_in,
    RXDFELFHOLD,
    gt0_rxdfeagcovrden_in,
    gt0_rxdfelpmreset_in,
    gt0_rxlpmen_in,
    gt0_rxmcommaalignen_in,
    gt0_rxpcsreset_in,
    gt0_rxpolarity_in,
    gt0_rxprbscntreset_in,
    RXUSERRDY,
    userclk,
    TXPD,
    gt0_txpcsreset_in,
    gt0_txpmareset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    TXUSERRDY,
    gt0_rxmonitorsel_in,
    RXPD,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txprbssel_in,
    gt0_txdiffctrl_in,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    Q,
    I1,
    I2,
    I3,
    gt0_gtrxreset_in1_out,
    gt0_rxpmareset_in,
    gt0_drpdi_in,
    gt0_drpwe_in,
    gt0_drpen_in,
    gt0_drpaddr_in);
  output cplllock;
  output CPLLREFCLKLOST;
  output O1;
  output gt0_eyescandataerror_out;
  output txn;
  output txp;
  output gt0_rxbyteisaligned_out;
  output gt0_rxbyterealign_out;
  output gt0_rxcommadet_out;
  output I;
  output O2;
  output gt0_rxprbserr_out;
  output O3;
  output txoutclk;
  output O4;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output [1:0]D;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [15:0]O5;
  output [6:0]gt0_rxmonitorout_out;
  output [1:0]O6;
  output [1:0]O7;
  output [1:0]O8;
  output [1:0]O9;
  input independent_clock_bufg;
  input CPLL_RESET;
  input gt0_drpclk_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input rxn;
  input rxp;
  input gtrefclk;
  input gt0_gttxreset_in0_out;
  input gt0_qplloutclk_in;
  input gt0_qplloutrefclk_in;
  input gt0_rxbufreset_in;
  input gt0_rxcdrhold_in;
  input RXDFELFHOLD;
  input gt0_rxdfeagcovrden_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxlpmen_in;
  input gt0_rxmcommaalignen_in;
  input gt0_rxpcsreset_in;
  input gt0_rxpolarity_in;
  input gt0_rxprbscntreset_in;
  input RXUSERRDY;
  input userclk;
  input [0:0]TXPD;
  input gt0_txpcsreset_in;
  input gt0_txpmareset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input TXUSERRDY;
  input [1:0]gt0_rxmonitorsel_in;
  input [0:0]RXPD;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_txprbssel_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input [15:0]Q;
  input [1:0]I1;
  input [1:0]I2;
  input [1:0]I3;
  input gt0_gtrxreset_in1_out;
  input gt0_rxpmareset_in;
  input [15:0]gt0_drpdi_in;
  input gt0_drpwe_in;
  input gt0_drpen_in;
  input [8:0]gt0_drpaddr_in;

  wire CPLLREFCLKLOST;
  wire CPLL_RESET;
  wire [1:0]D;
  wire I;
  wire [1:0]I1;
  wire [1:0]I2;
  wire [1:0]I3;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [15:0]O5;
  wire [1:0]O6;
  wire [1:0]O7;
  wire [1:0]O8;
  wire [1:0]O9;
  wire [15:0]Q;
  wire RXDFELFHOLD;
  wire [0:0]RXPD;
  wire RXUSERRDY;
  wire [0:0]TXPD;
  wire TXUSERRDY;
  wire cplllock;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire gt0_gtrxreset_in1_out;
  wire gt0_gttxreset_in0_out;
  wire [2:0]gt0_loopback_in;
  wire gt0_qplloutclk_in;
  wire gt0_qplloutrefclk_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire gt0_rxbyteisaligned_out;
  wire gt0_rxbyterealign_out;
  wire gt0_rxcdrhold_in;
  wire gt0_rxcommadet_out;
  wire gt0_rxdfeagcovrden_in;
  wire gt0_rxdfelpmreset_in;
  wire gt0_rxlpmen_in;
  wire gt0_rxmcommaalignen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txpcsreset_in;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gtrefclk;
  wire independent_clock_bufg;
  wire rxn;
  wire rxp;
  wire txn;
  wire txoutclk;
  wire txp;
  wire userclk;

gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_GTWIZARD_GT__parameterized0 gt0_GTWIZARD_i
       (.CPLLREFCLKLOST(CPLLREFCLKLOST),
        .CPLL_RESET(CPLL_RESET),
        .D(D),
        .I(I),
        .I1(I1),
        .I2(I2),
        .I3(I3),
        .O1(O1),
        .O2(O2),
        .O3(O3),
        .O4(O4),
        .O5(O5),
        .O6(O6),
        .O7(O7),
        .O8(O8),
        .O9(O9),
        .Q(Q),
        .RXDFELFHOLD(RXDFELFHOLD),
        .RXPD(RXPD),
        .RXUSERRDY(RXUSERRDY),
        .TXPD(TXPD),
        .TXUSERRDY(TXUSERRDY),
        .cplllock(cplllock),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_gtrxreset_in1_out(gt0_gtrxreset_in1_out),
        .gt0_gttxreset_in0_out(gt0_gttxreset_in0_out),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_qplloutclk_in(gt0_qplloutclk_in),
        .gt0_qplloutrefclk_in(gt0_qplloutrefclk_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxbyteisaligned_out(gt0_rxbyteisaligned_out),
        .gt0_rxbyterealign_out(gt0_rxbyterealign_out),
        .gt0_rxcdrhold_in(gt0_rxcdrhold_in),
        .gt0_rxcommadet_out(gt0_rxcommadet_out),
        .gt0_rxdfeagcovrden_in(gt0_rxdfeagcovrden_in),
        .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),
        .gt0_rxlpmen_in(gt0_rxlpmen_in),
        .gt0_rxmcommaalignen_in(gt0_rxmcommaalignen_in),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxpmareset_in(gt0_rxpmareset_in),
        .gt0_rxpolarity_in(gt0_rxpolarity_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdiffctrl_in(gt0_txdiffctrl_in),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpmareset_in(gt0_txpmareset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txpostcursor_in(gt0_txpostcursor_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txprecursor_in(gt0_txprecursor_in),
        .gtrefclk(gtrefclk),
        .independent_clock_bufg(independent_clock_bufg),
        .rxn(rxn),
        .rxp(rxp),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp),
        .userclk(userclk));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_RX_STARTUP_FSM" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_RX_STARTUP_FSM__parameterized0
   (O1,
    RXUSERRDY,
    RXDFELFHOLD,
    gt0_gtrxreset_in1_out,
    rxuserclk,
    I1,
    independent_clock_bufg,
    userclk,
    I2,
    mmcm_locked,
    data_out,
    cplllock,
    CPLLREFCLKLOST,
    pma_reset,
    gt0_rx_cdrlocked,
    reset_out0_in);
  output O1;
  output RXUSERRDY;
  output RXDFELFHOLD;
  output gt0_gtrxreset_in1_out;
  input rxuserclk;
  input I1;
  input independent_clock_bufg;
  input userclk;
  input I2;
  input mmcm_locked;
  input data_out;
  input cplllock;
  input CPLLREFCLKLOST;
  input pma_reset;
  input gt0_rx_cdrlocked;
  input reset_out0_in;

  wire CPLLREFCLKLOST;
  wire GTRXRESET;
  wire I1;
  wire I2;
  wire O1;
  wire RXDFELFHOLD;
  wire RXUSERRDY;
  wire [22:0]\adapt_wait_hw.adapt_count_reg ;
  wire check_tlock_max;
  wire cplllock;
  wire cplllock_sync;
  wire data_out;
  wire data_out_0;
  wire data_valid_sync;
  wire gt0_gtrxreset_in1_out;
  wire gt0_rx_cdrlocked;
  wire independent_clock_bufg;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [9:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_locked;
  wire \n_0_FSM_onehot_rx_state[10]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[10]_i_2 ;
  wire \n_0_FSM_onehot_rx_state[10]_i_3 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_10 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_2 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_3 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_4 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_5 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_6 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_7 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_8 ;
  wire \n_0_FSM_onehot_rx_state[11]_i_9 ;
  wire \n_0_FSM_onehot_rx_state[2]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[2]_i_2 ;
  wire \n_0_FSM_onehot_rx_state[3]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[4]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[5]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[5]_i_2 ;
  wire \n_0_FSM_onehot_rx_state[6]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[7]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[7]_i_2 ;
  wire \n_0_FSM_onehot_rx_state[7]_i_3 ;
  wire \n_0_FSM_onehot_rx_state[8]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[9]_i_1 ;
  wire \n_0_FSM_onehot_rx_state[9]_i_2 ;
  wire \n_0_FSM_onehot_rx_state[9]_i_3 ;
  wire \n_0_FSM_onehot_rx_state_reg[10] ;
  wire \n_0_FSM_onehot_rx_state_reg[11] ;
  wire \n_0_FSM_onehot_rx_state_reg[1] ;
  wire \n_0_FSM_onehot_rx_state_reg[2] ;
  wire \n_0_FSM_onehot_rx_state_reg[3] ;
  wire \n_0_FSM_onehot_rx_state_reg[4] ;
  wire \n_0_FSM_onehot_rx_state_reg[5] ;
  wire \n_0_FSM_onehot_rx_state_reg[7] ;
  wire \n_0_FSM_onehot_rx_state_reg[8] ;
  wire n_0_RXDFEAGCHOLD_i_1;
  wire n_0_RXUSERRDY_i_1;
  wire n_0_adapt_count_reset_i_1;
  wire n_0_adapt_count_reset_i_2;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_1 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_10 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_6 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_7 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_8 ;
  wire \n_0_adapt_wait_hw.adapt_count[0]_i_9 ;
  wire \n_0_adapt_wait_hw.adapt_count[12]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[12]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[12]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[12]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count[16]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[16]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[16]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[16]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count[20]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[20]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[20]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[4]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[4]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[4]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[4]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count[8]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count[8]_i_3 ;
  wire \n_0_adapt_wait_hw.adapt_count[8]_i_4 ;
  wire \n_0_adapt_wait_hw.adapt_count[8]_i_5 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_0_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_1 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_2 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_3 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_4 ;
  wire \n_0_adapt_wait_hw.time_out_adapt_i_5 ;
  wire n_0_check_tlock_max_i_1;
  wire n_0_check_tlock_max_reg;
  wire n_0_gtrxreset_i_i_1;
  wire \n_0_init_wait_count[0]_i_1__0 ;
  wire \n_0_init_wait_count[6]_i_1__0 ;
  wire \n_0_init_wait_count[6]_i_3__0 ;
  wire \n_0_init_wait_count[6]_i_4__0 ;
  wire n_0_init_wait_done_i_1__0;
  wire n_0_init_wait_done_i_2__0;
  wire \n_0_mmcm_lock_count[0]_i_1__0 ;
  wire \n_0_mmcm_lock_count[9]_i_1__0 ;
  wire \n_0_mmcm_lock_count[9]_i_2__0 ;
  wire \n_0_mmcm_lock_count[9]_i_4__0 ;
  wire n_0_mmcm_lock_reclocked_i_1__0;
  wire n_0_mmcm_lock_reclocked_i_2__0;
  wire n_0_reset_time_out_i_10;
  wire n_0_reset_time_out_i_1__0;
  wire n_0_reset_time_out_i_3__0;
  wire n_0_reset_time_out_i_4__0;
  wire n_0_reset_time_out_i_5__0;
  wire n_0_reset_time_out_i_6__0;
  wire n_0_reset_time_out_i_7__0;
  wire n_0_reset_time_out_i_8;
  wire n_0_reset_time_out_i_9;
  wire n_0_reset_time_out_reg;
  wire n_0_run_phase_alignment_int_i_1__0;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_run_phase_alignment_int_s3_reg;
  wire n_0_rx_fsm_reset_done_int_i_1;
  wire n_0_rx_fsm_reset_done_int_i_2;
  wire n_0_rx_fsm_reset_done_int_i_3;
  wire n_0_time_out_1us_i_1;
  wire n_0_time_out_1us_i_2;
  wire n_0_time_out_1us_i_3;
  wire n_0_time_out_1us_i_4;
  wire n_0_time_out_1us_i_5;
  wire n_0_time_out_2ms_i_1;
  wire n_0_time_out_2ms_i_2__0;
  wire \n_0_time_out_counter[0]_i_10 ;
  wire \n_0_time_out_counter[0]_i_1__0 ;
  wire \n_0_time_out_counter[0]_i_3__0 ;
  wire \n_0_time_out_counter[0]_i_4__0 ;
  wire \n_0_time_out_counter[0]_i_5__0 ;
  wire \n_0_time_out_counter[0]_i_6__0 ;
  wire \n_0_time_out_counter[0]_i_7__0 ;
  wire \n_0_time_out_counter[0]_i_8 ;
  wire \n_0_time_out_counter[0]_i_9__0 ;
  wire \n_0_time_out_counter[12]_i_2__0 ;
  wire \n_0_time_out_counter[12]_i_3__0 ;
  wire \n_0_time_out_counter[12]_i_4__0 ;
  wire \n_0_time_out_counter[12]_i_5__0 ;
  wire \n_0_time_out_counter[16]_i_2__0 ;
  wire \n_0_time_out_counter[16]_i_3__0 ;
  wire \n_0_time_out_counter[16]_i_4__0 ;
  wire \n_0_time_out_counter[16]_i_5 ;
  wire \n_0_time_out_counter[4]_i_2__0 ;
  wire \n_0_time_out_counter[4]_i_3__0 ;
  wire \n_0_time_out_counter[4]_i_4__0 ;
  wire \n_0_time_out_counter[4]_i_5__0 ;
  wire \n_0_time_out_counter[8]_i_2__0 ;
  wire \n_0_time_out_counter[8]_i_3__0 ;
  wire \n_0_time_out_counter[8]_i_4__0 ;
  wire \n_0_time_out_counter[8]_i_5__0 ;
  wire \n_0_time_out_counter_reg[0]_i_2__0 ;
  wire \n_0_time_out_counter_reg[12]_i_1__0 ;
  wire \n_0_time_out_counter_reg[4]_i_1__0 ;
  wire \n_0_time_out_counter_reg[8]_i_1__0 ;
  wire n_0_time_out_wait_bypass_i_1__0;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_10;
  wire n_0_time_tlock_max_i_11;
  wire n_0_time_tlock_max_i_12;
  wire n_0_time_tlock_max_i_13;
  wire n_0_time_tlock_max_i_14;
  wire n_0_time_tlock_max_i_15;
  wire n_0_time_tlock_max_i_16;
  wire n_0_time_tlock_max_i_17;
  wire n_0_time_tlock_max_i_18;
  wire n_0_time_tlock_max_i_19;
  wire n_0_time_tlock_max_i_1__0;
  wire n_0_time_tlock_max_i_20;
  wire n_0_time_tlock_max_i_21;
  wire n_0_time_tlock_max_i_22;
  wire n_0_time_tlock_max_i_4;
  wire n_0_time_tlock_max_i_5;
  wire n_0_time_tlock_max_i_6;
  wire n_0_time_tlock_max_i_7;
  wire n_0_time_tlock_max_i_9;
  wire n_0_time_tlock_max_reg_i_3;
  wire n_0_time_tlock_max_reg_i_8;
  wire \n_0_wait_bypass_count[0]_i_1__0 ;
  wire \n_0_wait_bypass_count[0]_i_2__0 ;
  wire \n_0_wait_bypass_count[0]_i_4__0 ;
  wire \n_0_wait_bypass_count[0]_i_5__0 ;
  wire \n_0_wait_bypass_count[0]_i_6__0 ;
  wire \n_0_wait_bypass_count[0]_i_7__0 ;
  wire \n_0_wait_bypass_count[0]_i_8__0 ;
  wire \n_0_wait_bypass_count[0]_i_9 ;
  wire \n_0_wait_bypass_count[12]_i_2__0 ;
  wire \n_0_wait_bypass_count[4]_i_2__0 ;
  wire \n_0_wait_bypass_count[4]_i_3__0 ;
  wire \n_0_wait_bypass_count[4]_i_4__0 ;
  wire \n_0_wait_bypass_count[4]_i_5__0 ;
  wire \n_0_wait_bypass_count[8]_i_2__0 ;
  wire \n_0_wait_bypass_count[8]_i_3__0 ;
  wire \n_0_wait_bypass_count[8]_i_4__0 ;
  wire \n_0_wait_bypass_count[8]_i_5__0 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_0_wait_time_cnt[6]_i_1__0 ;
  wire \n_0_wait_time_cnt[6]_i_2__0 ;
  wire \n_0_wait_time_cnt[6]_i_4__0 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_1_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_1_time_out_counter_reg[0]_i_2__0 ;
  wire \n_1_time_out_counter_reg[12]_i_1__0 ;
  wire \n_1_time_out_counter_reg[16]_i_1__0 ;
  wire \n_1_time_out_counter_reg[4]_i_1__0 ;
  wire \n_1_time_out_counter_reg[8]_i_1__0 ;
  wire n_1_time_tlock_max_reg_i_3;
  wire n_1_time_tlock_max_reg_i_8;
  wire \n_1_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_2_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_2_time_out_counter_reg[0]_i_2__0 ;
  wire \n_2_time_out_counter_reg[12]_i_1__0 ;
  wire \n_2_time_out_counter_reg[16]_i_1__0 ;
  wire \n_2_time_out_counter_reg[4]_i_1__0 ;
  wire \n_2_time_out_counter_reg[8]_i_1__0 ;
  wire n_2_time_tlock_max_reg_i_3;
  wire n_2_time_tlock_max_reg_i_8;
  wire \n_2_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_3_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_3_time_out_counter_reg[0]_i_2__0 ;
  wire \n_3_time_out_counter_reg[12]_i_1__0 ;
  wire \n_3_time_out_counter_reg[16]_i_1__0 ;
  wire \n_3_time_out_counter_reg[4]_i_1__0 ;
  wire \n_3_time_out_counter_reg[8]_i_1__0 ;
  wire n_3_time_tlock_max_reg_i_2;
  wire n_3_time_tlock_max_reg_i_3;
  wire n_3_time_tlock_max_reg_i_8;
  wire \n_3_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_4_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_4_time_out_counter_reg[0]_i_2__0 ;
  wire \n_4_time_out_counter_reg[12]_i_1__0 ;
  wire \n_4_time_out_counter_reg[16]_i_1__0 ;
  wire \n_4_time_out_counter_reg[4]_i_1__0 ;
  wire \n_4_time_out_counter_reg[8]_i_1__0 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_5_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_5_time_out_counter_reg[0]_i_2__0 ;
  wire \n_5_time_out_counter_reg[12]_i_1__0 ;
  wire \n_5_time_out_counter_reg[16]_i_1__0 ;
  wire \n_5_time_out_counter_reg[4]_i_1__0 ;
  wire \n_5_time_out_counter_reg[8]_i_1__0 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_6_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_6_time_out_counter_reg[0]_i_2__0 ;
  wire \n_6_time_out_counter_reg[12]_i_1__0 ;
  wire \n_6_time_out_counter_reg[16]_i_1__0 ;
  wire \n_6_time_out_counter_reg[4]_i_1__0 ;
  wire \n_6_time_out_counter_reg[8]_i_1__0 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1__0 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[0]_i_2 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[12]_i_1 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[16]_i_1 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[20]_i_1 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[4]_i_1 ;
  wire \n_7_adapt_wait_hw.adapt_count_reg[8]_i_1 ;
  wire \n_7_time_out_counter_reg[0]_i_2__0 ;
  wire \n_7_time_out_counter_reg[12]_i_1__0 ;
  wire \n_7_time_out_counter_reg[16]_i_1__0 ;
  wire \n_7_time_out_counter_reg[4]_i_1__0 ;
  wire \n_7_time_out_counter_reg[8]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3__0 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1__0 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1__0 ;
  wire [6:1]p_0_in__0;
  wire [9:1]p_0_in__2;
  wire pma_reset;
  wire recclk_mon_count_reset;
  wire reset_out;
  wire reset_out0_in;
  wire reset_time_out;
  wire run_phase_alignment_int;
  wire run_phase_alignment_int_s2;
  wire rx_fsm_reset_done_int_s2;
  wire rx_fsm_reset_done_int_s3;
  wire rxresetdone_s2;
  wire rxresetdone_s3;
  wire rxuserclk;
  wire time_out_1us;
  wire time_out_2ms;
  wire time_out_adapt;
  wire [19:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire time_tlock_max1;
  wire userclk;
  wire [12:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0__0;
  wire [6:0]wait_time_cnt_reg__0;
  wire [3:2]\NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_O_UNCONNECTED ;
  wire NLW_sync_cpllrefclklost_data_out_UNCONNECTED;
  wire NLW_sync_rxpmaresetdone_data_out_UNCONNECTED;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED ;
  wire [3:2]NLW_time_tlock_max_reg_i_2_CO_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_2_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_3_O_UNCONNECTED;
  wire [3:0]NLW_time_tlock_max_reg_i_8_O_UNCONNECTED;
  wire [3:0]\NLW_wait_bypass_count_reg[12]_i_1__0_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[12]_i_1__0_O_UNCONNECTED ;

LUT6 #(
    .INIT(64'hFFFFFFFF00000010)) 
     \FSM_onehot_rx_state[10]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state[10]_i_2 ),
        .I1(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I2(run_phase_alignment_int),
        .I3(time_out_wait_bypass_s3),
        .I4(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I5(\n_0_FSM_onehot_rx_state[10]_i_3 ),
        .O(\n_0_FSM_onehot_rx_state[10]_i_1 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \FSM_onehot_rx_state[10]_i_2 
       (.I0(\n_0_wait_time_cnt[6]_i_4__0 ),
        .I1(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I3(check_tlock_max),
        .O(\n_0_FSM_onehot_rx_state[10]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair102" *) 
   LUT3 #(
    .INIT(8'h40)) 
     \FSM_onehot_rx_state[10]_i_3 
       (.I0(\n_0_FSM_onehot_rx_state_reg[10] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[11] ),
        .I2(n_0_rx_fsm_reset_done_int_i_3),
        .O(\n_0_FSM_onehot_rx_state[10]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFFFFF1F1F1F0)) 
     \FSM_onehot_rx_state[11]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state[11]_i_3 ),
        .I1(wait_time_cnt_reg__0[6]),
        .I2(\n_0_FSM_onehot_rx_state[11]_i_4 ),
        .I3(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I5(\n_0_FSM_onehot_rx_state[11]_i_5 ),
        .O(\n_0_FSM_onehot_rx_state[11]_i_1 ));
LUT4 #(
    .INIT(16'hEEFE)) 
     \FSM_onehot_rx_state[11]_i_10 
       (.I0(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I2(time_out_2ms),
        .I3(n_0_reset_time_out_reg),
        .O(\n_0_FSM_onehot_rx_state[11]_i_10 ));
(* SOFT_HLUTNM = "soft_lutpair101" *) 
   LUT3 #(
    .INIT(8'h40)) 
     \FSM_onehot_rx_state[11]_i_2 
       (.I0(\n_0_FSM_onehot_rx_state_reg[11] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[10] ),
        .I2(n_0_rx_fsm_reset_done_int_i_3),
        .O(\n_0_FSM_onehot_rx_state[11]_i_2 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \FSM_onehot_rx_state[11]_i_3 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[3]),
        .O(\n_0_FSM_onehot_rx_state[11]_i_3 ));
LUT6 #(
    .INIT(64'hFFFFFEEEFFFEFEE8)) 
     \FSM_onehot_rx_state[11]_i_4 
       (.I0(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I1(n_0_adapt_count_reset_i_2),
        .I2(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I4(\n_0_FSM_onehot_rx_state[11]_i_6 ),
        .I5(\n_0_FSM_onehot_rx_state_reg[8] ),
        .O(\n_0_FSM_onehot_rx_state[11]_i_4 ));
LUT5 #(
    .INIT(32'hFFFFFFEA)) 
     \FSM_onehot_rx_state[11]_i_5 
       (.I0(\n_0_FSM_onehot_rx_state[11]_i_7 ),
        .I1(mmcm_lock_reclocked),
        .I2(check_tlock_max),
        .I3(\n_0_FSM_onehot_rx_state[11]_i_8 ),
        .I4(\n_0_FSM_onehot_rx_state[11]_i_9 ),
        .O(\n_0_FSM_onehot_rx_state[11]_i_5 ));
(* SOFT_HLUTNM = "soft_lutpair102" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_rx_state[11]_i_6 
       (.I0(\n_0_FSM_onehot_rx_state_reg[10] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[11] ),
        .O(\n_0_FSM_onehot_rx_state[11]_i_6 ));
LUT6 #(
    .INIT(64'hFFFFFFF000000E0F)) 
     \FSM_onehot_rx_state[11]_i_7 
       (.I0(cplllock_sync),
        .I1(time_out_2ms),
        .I2(\n_0_wait_time_cnt[6]_i_4__0 ),
        .I3(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I4(n_0_adapt_count_reset_i_2),
        .I5(\n_0_FSM_onehot_rx_state_reg[1] ),
        .O(\n_0_FSM_onehot_rx_state[11]_i_7 ));
LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
     \FSM_onehot_rx_state[11]_i_8 
       (.I0(n_0_reset_time_out_i_7__0),
        .I1(init_wait_done),
        .I2(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I4(gt0_rx_cdrlocked),
        .I5(\n_0_FSM_onehot_rx_state_reg[5] ),
        .O(\n_0_FSM_onehot_rx_state[11]_i_8 ));
LUT6 #(
    .INIT(64'hFFFF88A888A888A8)) 
     \FSM_onehot_rx_state[11]_i_9 
       (.I0(check_tlock_max),
        .I1(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I2(time_tlock_max),
        .I3(n_0_reset_time_out_reg),
        .I4(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I5(\n_0_FSM_onehot_rx_state[11]_i_10 ),
        .O(\n_0_FSM_onehot_rx_state[11]_i_9 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFF9E9)) 
     \FSM_onehot_rx_state[2]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I1(\n_0_FSM_onehot_rx_state[10]_i_2 ),
        .I2(run_phase_alignment_int),
        .I3(time_out_wait_bypass_s3),
        .I4(\n_0_FSM_onehot_rx_state[2]_i_2 ),
        .I5(\n_0_FSM_onehot_rx_state[11]_i_4 ),
        .O(\n_0_FSM_onehot_rx_state[2]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFEAFFEAFFEA)) 
     \FSM_onehot_rx_state[2]_i_2 
       (.I0(\n_0_FSM_onehot_rx_state[11]_i_9 ),
        .I1(time_out_2ms),
        .I2(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[10] ),
        .I5(\n_0_FSM_onehot_rx_state_reg[11] ),
        .O(\n_0_FSM_onehot_rx_state[2]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair88" *) 
   LUT4 #(
    .INIT(16'h0002)) 
     \FSM_onehot_rx_state[3]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I2(run_phase_alignment_int),
        .I3(\n_0_FSM_onehot_rx_state[10]_i_2 ),
        .O(\n_0_FSM_onehot_rx_state[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair94" *) 
   LUT4 #(
    .INIT(16'h0200)) 
     \FSM_onehot_rx_state[4]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I3(\n_0_FSM_onehot_rx_state[9]_i_2 ),
        .O(\n_0_FSM_onehot_rx_state[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair90" *) 
   LUT5 #(
    .INIT(32'h00100000)) 
     \FSM_onehot_rx_state[5]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I1(check_tlock_max),
        .I2(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I3(time_out_2ms),
        .I4(\n_0_FSM_onehot_rx_state[5]_i_2 ),
        .O(\n_0_FSM_onehot_rx_state[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair97" *) 
   LUT4 #(
    .INIT(16'h0001)) 
     \FSM_onehot_rx_state[5]_i_2 
       (.I0(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I2(run_phase_alignment_int),
        .I3(\n_0_wait_time_cnt[6]_i_4__0 ),
        .O(\n_0_FSM_onehot_rx_state[5]_i_2 ));
LUT6 #(
    .INIT(64'h0000000400000000)) 
     \FSM_onehot_rx_state[6]_i_1 
       (.I0(check_tlock_max),
        .I1(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I5(\n_0_FSM_onehot_rx_state[7]_i_3 ),
        .O(\n_0_FSM_onehot_rx_state[6]_i_1 ));
LUT6 #(
    .INIT(64'h0000510000000000)) 
     \FSM_onehot_rx_state[7]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I1(time_tlock_max),
        .I2(n_0_reset_time_out_reg),
        .I3(check_tlock_max),
        .I4(\n_0_FSM_onehot_rx_state[7]_i_2 ),
        .I5(\n_0_FSM_onehot_rx_state[7]_i_3 ),
        .O(\n_0_FSM_onehot_rx_state[7]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair93" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     \FSM_onehot_rx_state[7]_i_2 
       (.I0(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[8] ),
        .O(\n_0_FSM_onehot_rx_state[7]_i_2 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_rx_state[7]_i_3 
       (.I0(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I2(run_phase_alignment_int),
        .I3(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[10] ),
        .I5(\n_0_FSM_onehot_rx_state_reg[11] ),
        .O(\n_0_FSM_onehot_rx_state[7]_i_3 ));
LUT4 #(
    .INIT(16'h0400)) 
     \FSM_onehot_rx_state[8]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I3(\n_0_FSM_onehot_rx_state[9]_i_2 ),
        .O(\n_0_FSM_onehot_rx_state[8]_i_1 ));
LUT6 #(
    .INIT(64'h1101000000000000)) 
     \FSM_onehot_rx_state[9]_i_1 
       (.I0(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I2(time_out_2ms),
        .I3(n_0_reset_time_out_reg),
        .I4(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I5(\n_0_FSM_onehot_rx_state[9]_i_2 ),
        .O(\n_0_FSM_onehot_rx_state[9]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_rx_state[9]_i_2 
       (.I0(\n_0_FSM_onehot_rx_state[9]_i_3 ),
        .I1(run_phase_alignment_int),
        .I2(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[11] ),
        .I5(\n_0_FSM_onehot_rx_state_reg[10] ),
        .O(\n_0_FSM_onehot_rx_state[9]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair90" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     \FSM_onehot_rx_state[9]_i_3 
       (.I0(check_tlock_max),
        .I1(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[4] ),
        .O(\n_0_FSM_onehot_rx_state[9]_i_3 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[10] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[10]_i_1 ),
        .Q(\n_0_FSM_onehot_rx_state_reg[10] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[11] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[11]_i_2 ),
        .Q(\n_0_FSM_onehot_rx_state_reg[11] ),
        .R(pma_reset));
FDSE #(
    .INIT(1'b1)) 
     \FSM_onehot_rx_state_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(1'b0),
        .Q(\n_0_FSM_onehot_rx_state_reg[1] ),
        .S(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[2]_i_1 ),
        .Q(\n_0_FSM_onehot_rx_state_reg[2] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[3]_i_1 ),
        .Q(\n_0_FSM_onehot_rx_state_reg[3] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[4]_i_1 ),
        .Q(\n_0_FSM_onehot_rx_state_reg[4] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[5]_i_1 ),
        .Q(\n_0_FSM_onehot_rx_state_reg[5] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[6]_i_1 ),
        .Q(check_tlock_max),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[7]_i_1 ),
        .Q(\n_0_FSM_onehot_rx_state_reg[7] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[8]_i_1 ),
        .Q(\n_0_FSM_onehot_rx_state_reg[8] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_rx_state_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_rx_state[11]_i_1 ),
        .D(\n_0_FSM_onehot_rx_state[9]_i_1 ),
        .Q(run_phase_alignment_int),
        .R(pma_reset));
LUT3 #(
    .INIT(8'hF8)) 
     RXDFEAGCHOLD_i_1
       (.I0(\n_0_FSM_onehot_rx_state[10]_i_3 ),
        .I1(time_out_adapt),
        .I2(RXDFELFHOLD),
        .O(n_0_RXDFEAGCHOLD_i_1));
FDRE RXDFEAGCHOLD_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_RXDFEAGCHOLD_i_1),
        .Q(RXDFELFHOLD),
        .R(pma_reset));
LUT6 #(
    .INIT(64'hCCCCFFFFCCCC0008)) 
     RXUSERRDY_i_1
       (.I0(\n_0_FSM_onehot_rx_state[9]_i_2 ),
        .I1(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I4(\n_0_FSM_onehot_rx_state[3]_i_1 ),
        .I5(RXUSERRDY),
        .O(n_0_RXUSERRDY_i_1));
FDRE #(
    .INIT(1'b0)) 
     RXUSERRDY_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_RXUSERRDY_i_1),
        .Q(RXUSERRDY),
        .R(pma_reset));
LUT6 #(
    .INIT(64'h0F0FFF7F0F0F0000)) 
     adapt_count_reset_i_1
       (.I0(\n_0_FSM_onehot_rx_state[5]_i_2 ),
        .I1(cplllock_sync),
        .I2(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I3(n_0_adapt_count_reset_i_2),
        .I4(\n_0_FSM_onehot_rx_state[3]_i_1 ),
        .I5(recclk_mon_count_reset),
        .O(n_0_adapt_count_reset_i_1));
LUT2 #(
    .INIT(4'hE)) 
     adapt_count_reset_i_2
       (.I0(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I1(check_tlock_max),
        .O(n_0_adapt_count_reset_i_2));
FDSE #(
    .INIT(1'b0)) 
     adapt_count_reset_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_adapt_count_reset_i_1),
        .Q(recclk_mon_count_reset),
        .S(pma_reset));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
     \adapt_wait_hw.adapt_count[0]_i_1 
       (.I0(\n_0_adapt_wait_hw.adapt_count[0]_i_3 ),
        .I1(\n_0_adapt_wait_hw.adapt_count[0]_i_4 ),
        .I2(\adapt_wait_hw.adapt_count_reg [18]),
        .I3(\adapt_wait_hw.adapt_count_reg [17]),
        .I4(\n_0_adapt_wait_hw.adapt_count[0]_i_5 ),
        .I5(\n_0_adapt_wait_hw.adapt_count[0]_i_6 ),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ));
LUT1 #(
    .INIT(2'h1)) 
     \adapt_wait_hw.adapt_count[0]_i_10 
       (.I0(\adapt_wait_hw.adapt_count_reg [0]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_10 ));
LUT6 #(
    .INIT(64'hFFFFF7FFFFFFFFFF)) 
     \adapt_wait_hw.adapt_count[0]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [14]),
        .I1(\adapt_wait_hw.adapt_count_reg [13]),
        .I2(\adapt_wait_hw.adapt_count_reg [16]),
        .I3(\adapt_wait_hw.adapt_count_reg [15]),
        .I4(\adapt_wait_hw.adapt_count_reg [12]),
        .I5(\adapt_wait_hw.adapt_count_reg [11]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_3 ));
LUT4 #(
    .INIT(16'h4000)) 
     \adapt_wait_hw.adapt_count[0]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [19]),
        .I1(\adapt_wait_hw.adapt_count_reg [20]),
        .I2(\adapt_wait_hw.adapt_count_reg [22]),
        .I3(\adapt_wait_hw.adapt_count_reg [21]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair87" *) 
   LUT5 #(
    .INIT(32'hFFEFFFFF)) 
     \adapt_wait_hw.adapt_count[0]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [8]),
        .I1(\adapt_wait_hw.adapt_count_reg [7]),
        .I2(\adapt_wait_hw.adapt_count_reg [0]),
        .I3(\adapt_wait_hw.adapt_count_reg [10]),
        .I4(\adapt_wait_hw.adapt_count_reg [9]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_5 ));
LUT6 #(
    .INIT(64'hF7FFFFFFFFFFFFFF)) 
     \adapt_wait_hw.adapt_count[0]_i_6 
       (.I0(\adapt_wait_hw.adapt_count_reg [4]),
        .I1(\adapt_wait_hw.adapt_count_reg [3]),
        .I2(\adapt_wait_hw.adapt_count_reg [6]),
        .I3(\adapt_wait_hw.adapt_count_reg [5]),
        .I4(\adapt_wait_hw.adapt_count_reg [2]),
        .I5(\adapt_wait_hw.adapt_count_reg [1]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_6 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[0]_i_7 
       (.I0(\adapt_wait_hw.adapt_count_reg [3]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_7 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[0]_i_8 
       (.I0(\adapt_wait_hw.adapt_count_reg [2]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_8 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[0]_i_9 
       (.I0(\adapt_wait_hw.adapt_count_reg [1]),
        .O(\n_0_adapt_wait_hw.adapt_count[0]_i_9 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[12]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [15]),
        .O(\n_0_adapt_wait_hw.adapt_count[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[12]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [14]),
        .O(\n_0_adapt_wait_hw.adapt_count[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[12]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [13]),
        .O(\n_0_adapt_wait_hw.adapt_count[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[12]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [12]),
        .O(\n_0_adapt_wait_hw.adapt_count[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[16]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [19]),
        .O(\n_0_adapt_wait_hw.adapt_count[16]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[16]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [18]),
        .O(\n_0_adapt_wait_hw.adapt_count[16]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[16]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [17]),
        .O(\n_0_adapt_wait_hw.adapt_count[16]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[16]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [16]),
        .O(\n_0_adapt_wait_hw.adapt_count[16]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[20]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [22]),
        .O(\n_0_adapt_wait_hw.adapt_count[20]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[20]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [21]),
        .O(\n_0_adapt_wait_hw.adapt_count[20]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[20]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [20]),
        .O(\n_0_adapt_wait_hw.adapt_count[20]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[4]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [7]),
        .O(\n_0_adapt_wait_hw.adapt_count[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[4]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [6]),
        .O(\n_0_adapt_wait_hw.adapt_count[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[4]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [5]),
        .O(\n_0_adapt_wait_hw.adapt_count[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[4]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [4]),
        .O(\n_0_adapt_wait_hw.adapt_count[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[8]_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [11]),
        .O(\n_0_adapt_wait_hw.adapt_count[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[8]_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [10]),
        .O(\n_0_adapt_wait_hw.adapt_count[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[8]_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [9]),
        .O(\n_0_adapt_wait_hw.adapt_count[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \adapt_wait_hw.adapt_count[8]_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [8]),
        .O(\n_0_adapt_wait_hw.adapt_count[8]_i_5 ));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .Q(\adapt_wait_hw.adapt_count_reg [0]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_1_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_2_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_3_adapt_wait_hw.adapt_count_reg[0]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_5_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_6_adapt_wait_hw.adapt_count_reg[0]_i_2 ,\n_7_adapt_wait_hw.adapt_count_reg[0]_i_2 }),
        .S({\n_0_adapt_wait_hw.adapt_count[0]_i_7 ,\n_0_adapt_wait_hw.adapt_count[0]_i_8 ,\n_0_adapt_wait_hw.adapt_count[0]_i_9 ,\n_0_adapt_wait_hw.adapt_count[0]_i_10 }));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[10] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [10]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[11] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [11]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[12] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [12]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[12]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_1_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_2_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[12]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_5_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[12]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[12]_i_1 }),
        .S({\n_0_adapt_wait_hw.adapt_count[12]_i_2 ,\n_0_adapt_wait_hw.adapt_count[12]_i_3 ,\n_0_adapt_wait_hw.adapt_count[12]_i_4 ,\n_0_adapt_wait_hw.adapt_count[12]_i_5 }));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[13] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [13]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[14] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [14]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[15] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [15]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[16] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [16]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[16]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[12]_i_1 ),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_1_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_2_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[16]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_5_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[16]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[16]_i_1 }),
        .S({\n_0_adapt_wait_hw.adapt_count[16]_i_2 ,\n_0_adapt_wait_hw.adapt_count[16]_i_3 ,\n_0_adapt_wait_hw.adapt_count[16]_i_4 ,\n_0_adapt_wait_hw.adapt_count[16]_i_5 }));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[17] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [17]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[18] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [18]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[19] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [19]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .Q(\adapt_wait_hw.adapt_count_reg [1]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[20] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[20]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [20]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[20]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[16]_i_1 ),
        .CO({\NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_CO_UNCONNECTED [3:2],\n_2_adapt_wait_hw.adapt_count_reg[20]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[20]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_adapt_wait_hw.adapt_count_reg[20]_i_1_O_UNCONNECTED [3],\n_5_adapt_wait_hw.adapt_count_reg[20]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[20]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[20]_i_1 }),
        .S({1'b0,\n_0_adapt_wait_hw.adapt_count[20]_i_2 ,\n_0_adapt_wait_hw.adapt_count[20]_i_3 ,\n_0_adapt_wait_hw.adapt_count[20]_i_4 }));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[21] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[20]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [21]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[22] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[20]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [22]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .Q(\adapt_wait_hw.adapt_count_reg [2]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .Q(\adapt_wait_hw.adapt_count_reg [3]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [4]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[4]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[0]_i_2 ),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_1_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_2_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_5_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[4]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[4]_i_1 }),
        .S({\n_0_adapt_wait_hw.adapt_count[4]_i_2 ,\n_0_adapt_wait_hw.adapt_count[4]_i_3 ,\n_0_adapt_wait_hw.adapt_count[4]_i_4 ,\n_0_adapt_wait_hw.adapt_count[4]_i_5 }));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [5]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_5_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [6]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_4_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [7]),
        .R(recclk_mon_count_reset));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_7_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [8]),
        .R(recclk_mon_count_reset));
CARRY4 \adapt_wait_hw.adapt_count_reg[8]_i_1 
       (.CI(\n_0_adapt_wait_hw.adapt_count_reg[4]_i_1 ),
        .CO({\n_0_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_1_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_2_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_3_adapt_wait_hw.adapt_count_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_5_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_6_adapt_wait_hw.adapt_count_reg[8]_i_1 ,\n_7_adapt_wait_hw.adapt_count_reg[8]_i_1 }),
        .S({\n_0_adapt_wait_hw.adapt_count[8]_i_2 ,\n_0_adapt_wait_hw.adapt_count[8]_i_3 ,\n_0_adapt_wait_hw.adapt_count[8]_i_4 ,\n_0_adapt_wait_hw.adapt_count[8]_i_5 }));
(* counter = "22" *) 
   FDRE \adapt_wait_hw.adapt_count_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_adapt_wait_hw.adapt_count[0]_i_1 ),
        .D(\n_6_adapt_wait_hw.adapt_count_reg[8]_i_1 ),
        .Q(\adapt_wait_hw.adapt_count_reg [9]),
        .R(recclk_mon_count_reset));
LUT6 #(
    .INIT(64'h00000000EAAAAAAA)) 
     \adapt_wait_hw.time_out_adapt_i_1 
       (.I0(time_out_adapt),
        .I1(\n_0_adapt_wait_hw.time_out_adapt_i_2 ),
        .I2(\n_0_adapt_wait_hw.time_out_adapt_i_3 ),
        .I3(\n_0_adapt_wait_hw.time_out_adapt_i_4 ),
        .I4(\n_0_adapt_wait_hw.time_out_adapt_i_5 ),
        .I5(recclk_mon_count_reset),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_1 ));
LUT6 #(
    .INIT(64'h0040000000000000)) 
     \adapt_wait_hw.time_out_adapt_i_2 
       (.I0(\adapt_wait_hw.adapt_count_reg [12]),
        .I1(\adapt_wait_hw.adapt_count_reg [11]),
        .I2(\adapt_wait_hw.adapt_count_reg [15]),
        .I3(\adapt_wait_hw.adapt_count_reg [16]),
        .I4(\adapt_wait_hw.adapt_count_reg [13]),
        .I5(\adapt_wait_hw.adapt_count_reg [14]),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_2 ));
LUT6 #(
    .INIT(64'h0000000010000000)) 
     \adapt_wait_hw.time_out_adapt_i_3 
       (.I0(\adapt_wait_hw.adapt_count_reg [18]),
        .I1(\adapt_wait_hw.adapt_count_reg [17]),
        .I2(\adapt_wait_hw.adapt_count_reg [21]),
        .I3(\adapt_wait_hw.adapt_count_reg [22]),
        .I4(\adapt_wait_hw.adapt_count_reg [20]),
        .I5(\adapt_wait_hw.adapt_count_reg [19]),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair87" *) 
   LUT5 #(
    .INIT(32'h00000040)) 
     \adapt_wait_hw.time_out_adapt_i_4 
       (.I0(\adapt_wait_hw.adapt_count_reg [10]),
        .I1(\adapt_wait_hw.adapt_count_reg [9]),
        .I2(\adapt_wait_hw.adapt_count_reg [0]),
        .I3(\adapt_wait_hw.adapt_count_reg [7]),
        .I4(\adapt_wait_hw.adapt_count_reg [8]),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_4 ));
LUT6 #(
    .INIT(64'h0080000000000000)) 
     \adapt_wait_hw.time_out_adapt_i_5 
       (.I0(\adapt_wait_hw.adapt_count_reg [2]),
        .I1(\adapt_wait_hw.adapt_count_reg [1]),
        .I2(\adapt_wait_hw.adapt_count_reg [5]),
        .I3(\adapt_wait_hw.adapt_count_reg [6]),
        .I4(\adapt_wait_hw.adapt_count_reg [3]),
        .I5(\adapt_wait_hw.adapt_count_reg [4]),
        .O(\n_0_adapt_wait_hw.time_out_adapt_i_5 ));
FDRE #(
    .INIT(1'b0)) 
     \adapt_wait_hw.time_out_adapt_reg 
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(\n_0_adapt_wait_hw.time_out_adapt_i_1 ),
        .Q(time_out_adapt),
        .R(1'b0));
LUT6 #(
    .INIT(64'hF0F0FFFFF0F00020)) 
     check_tlock_max_i_1
       (.I0(\n_0_FSM_onehot_rx_state[7]_i_3 ),
        .I1(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I2(check_tlock_max),
        .I3(\n_0_FSM_onehot_rx_state[7]_i_2 ),
        .I4(\n_0_FSM_onehot_rx_state[3]_i_1 ),
        .I5(n_0_check_tlock_max_reg),
        .O(n_0_check_tlock_max_i_1));
FDRE #(
    .INIT(1'b0)) 
     check_tlock_max_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_check_tlock_max_i_1),
        .Q(n_0_check_tlock_max_reg),
        .R(pma_reset));
LUT6 #(
    .INIT(64'h0F0FFFDF0F0F0000)) 
     gtrxreset_i_i_1
       (.I0(\n_0_FSM_onehot_rx_state[7]_i_3 ),
        .I1(\n_0_FSM_onehot_rx_state[7]_i_2 ),
        .I2(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I3(check_tlock_max),
        .I4(\n_0_FSM_onehot_rx_state[3]_i_1 ),
        .I5(GTRXRESET),
        .O(n_0_gtrxreset_i_i_1));
FDRE #(
    .INIT(1'b0)) 
     gtrxreset_i_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_gtrxreset_i_i_1),
        .Q(GTRXRESET),
        .R(pma_reset));
LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1__0 
       (.I0(init_wait_count_reg__0[0]),
        .O(\n_0_init_wait_count[0]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair104" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1__0 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .O(p_0_in__0[1]));
(* SOFT_HLUTNM = "soft_lutpair96" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \init_wait_count[2]_i_1__0 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(p_0_in__0[2]));
(* SOFT_HLUTNM = "soft_lutpair96" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \init_wait_count[3]_i_1__0 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in__0[3]));
(* SOFT_HLUTNM = "soft_lutpair86" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \init_wait_count[4]_i_1__0 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[4]),
        .O(p_0_in__0[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \init_wait_count[5]_i_1__0 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in__0[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFF7FFFFF)) 
     \init_wait_count[6]_i_1__0 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[3]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\n_0_init_wait_count[6]_i_3__0 ),
        .O(\n_0_init_wait_count[6]_i_1__0 ));
LUT3 #(
    .INIT(8'hD2)) 
     \init_wait_count[6]_i_2__0 
       (.I0(init_wait_count_reg__0[5]),
        .I1(\n_0_init_wait_count[6]_i_4__0 ),
        .I2(init_wait_count_reg__0[6]),
        .O(p_0_in__0[6]));
(* SOFT_HLUTNM = "soft_lutpair104" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \init_wait_count[6]_i_3__0 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_3__0 ));
(* SOFT_HLUTNM = "soft_lutpair86" *) 
   LUT5 #(
    .INIT(32'h7FFFFFFF)) 
     \init_wait_count[6]_i_4__0 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[4]),
        .O(\n_0_init_wait_count[6]_i_4__0 ));
(* counter = "19" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(pma_reset),
        .D(\n_0_init_wait_count[0]_i_1__0 ),
        .Q(init_wait_count_reg__0[0]));
(* counter = "19" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(pma_reset),
        .D(p_0_in__0[1]),
        .Q(init_wait_count_reg__0[1]));
(* counter = "19" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(pma_reset),
        .D(p_0_in__0[2]),
        .Q(init_wait_count_reg__0[2]));
(* counter = "19" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(pma_reset),
        .D(p_0_in__0[3]),
        .Q(init_wait_count_reg__0[3]));
(* counter = "19" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(pma_reset),
        .D(p_0_in__0[4]),
        .Q(init_wait_count_reg__0[4]));
(* counter = "19" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(pma_reset),
        .D(p_0_in__0[5]),
        .Q(init_wait_count_reg__0[5]));
(* counter = "19" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1__0 ),
        .CLR(pma_reset),
        .D(p_0_in__0[6]),
        .Q(init_wait_count_reg__0[6]));
LUT6 #(
    .INIT(64'hFFFFFFFF00008000)) 
     init_wait_done_i_1__0
       (.I0(n_0_init_wait_done_i_2__0),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[6]),
        .I3(init_wait_count_reg__0[5]),
        .I4(\n_0_init_wait_count[6]_i_3__0 ),
        .I5(init_wait_done),
        .O(n_0_init_wait_done_i_1__0));
LUT2 #(
    .INIT(4'h2)) 
     init_wait_done_i_2__0
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(n_0_init_wait_done_i_2__0));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .CLR(pma_reset),
        .D(n_0_init_wait_done_i_1__0),
        .Q(init_wait_done));
LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(\n_0_mmcm_lock_count[0]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair100" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__2[1]));
(* SOFT_HLUTNM = "soft_lutpair100" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \mmcm_lock_count[2]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__2[2]));
(* SOFT_HLUTNM = "soft_lutpair92" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \mmcm_lock_count[3]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__2[3]));
(* SOFT_HLUTNM = "soft_lutpair92" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \mmcm_lock_count[4]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__2[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \mmcm_lock_count[5]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__2[5]));
LUT2 #(
    .INIT(4'h9)) 
     \mmcm_lock_count[6]_i_1__0 
       (.I0(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I1(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__2[6]));
(* SOFT_HLUTNM = "soft_lutpair98" *) 
   LUT3 #(
    .INIT(8'hD2)) 
     \mmcm_lock_count[7]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(p_0_in__2[7]));
(* SOFT_HLUTNM = "soft_lutpair98" *) 
   LUT4 #(
    .INIT(16'hDF20)) 
     \mmcm_lock_count[8]_i_1__0 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(mmcm_lock_count_reg__0[8]),
        .O(p_0_in__2[8]));
LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[9]_i_1__0 
       (.I0(mmcm_lock_i),
        .O(\n_0_mmcm_lock_count[9]_i_1__0 ));
LUT5 #(
    .INIT(32'hDFFFFFFF)) 
     \mmcm_lock_count[9]_i_2__0 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(mmcm_lock_count_reg__0[8]),
        .I4(mmcm_lock_count_reg__0[9]),
        .O(\n_0_mmcm_lock_count[9]_i_2__0 ));
(* SOFT_HLUTNM = "soft_lutpair89" *) 
   LUT5 #(
    .INIT(32'hF7FF0800)) 
     \mmcm_lock_count[9]_i_3__0 
       (.I0(mmcm_lock_count_reg__0[8]),
        .I1(mmcm_lock_count_reg__0[6]),
        .I2(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I3(mmcm_lock_count_reg__0[7]),
        .I4(mmcm_lock_count_reg__0[9]),
        .O(p_0_in__2[9]));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \mmcm_lock_count[9]_i_4__0 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[4]),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[3]),
        .O(\n_0_mmcm_lock_count[9]_i_4__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(\n_0_mmcm_lock_count[0]_i_1__0 ),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[8]),
        .Q(mmcm_lock_count_reg__0[8]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
(* counter = "25" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2__0 ),
        .D(p_0_in__2[9]),
        .Q(mmcm_lock_count_reg__0[9]),
        .R(\n_0_mmcm_lock_count[9]_i_1__0 ));
LUT3 #(
    .INIT(8'hE0)) 
     mmcm_lock_reclocked_i_1__0
       (.I0(mmcm_lock_reclocked),
        .I1(n_0_mmcm_lock_reclocked_i_2__0),
        .I2(mmcm_lock_i),
        .O(n_0_mmcm_lock_reclocked_i_1__0));
(* SOFT_HLUTNM = "soft_lutpair89" *) 
   LUT5 #(
    .INIT(32'h00800000)) 
     mmcm_lock_reclocked_i_2__0
       (.I0(mmcm_lock_count_reg__0[9]),
        .I1(mmcm_lock_count_reg__0[8]),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(\n_0_mmcm_lock_count[9]_i_4__0 ),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(n_0_mmcm_lock_reclocked_i_2__0));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_mmcm_lock_reclocked_i_1__0),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
LUT6 #(
    .INIT(64'h0000000000000008)) 
     reset_time_out_i_10
       (.I0(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I1(gt0_rx_cdrlocked),
        .I2(check_tlock_max),
        .I3(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I5(\n_0_FSM_onehot_rx_state_reg[7] ),
        .O(n_0_reset_time_out_i_10));
LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
     reset_time_out_i_1__0
       (.I0(reset_time_out),
        .I1(n_0_reset_time_out_i_3__0),
        .I2(n_0_reset_time_out_i_4__0),
        .I3(n_0_reset_time_out_i_5__0),
        .I4(n_0_reset_time_out_i_6__0),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_reset_time_out_i_1__0));
LUT6 #(
    .INIT(64'hFFFFFFFFAAAAAAAE)) 
     reset_time_out_i_2__0
       (.I0(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I1(n_0_reset_time_out_i_7__0),
        .I2(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I4(check_tlock_max),
        .I5(n_0_reset_time_out_i_8),
        .O(reset_time_out));
LUT6 #(
    .INIT(64'h0000000000100040)) 
     reset_time_out_i_3__0
       (.I0(\n_0_FSM_onehot_rx_state[11]_i_6 ),
        .I1(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I2(n_0_reset_time_out_i_9),
        .I3(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I4(check_tlock_max),
        .I5(\n_0_FSM_onehot_rx_state[7]_i_2 ),
        .O(n_0_reset_time_out_i_3__0));
(* SOFT_HLUTNM = "soft_lutpair94" *) 
   LUT4 #(
    .INIT(16'h1000)) 
     reset_time_out_i_4__0
       (.I0(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I3(\n_0_FSM_onehot_rx_state[9]_i_2 ),
        .O(n_0_reset_time_out_i_4__0));
(* SOFT_HLUTNM = "soft_lutpair101" *) 
   LUT3 #(
    .INIT(8'h28)) 
     reset_time_out_i_5__0
       (.I0(n_0_rx_fsm_reset_done_int_i_3),
        .I1(\n_0_FSM_onehot_rx_state_reg[10] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[11] ),
        .O(n_0_reset_time_out_i_5__0));
LUT6 #(
    .INIT(64'h8888888F88888F88)) 
     reset_time_out_i_6__0
       (.I0(\n_0_FSM_onehot_rx_state[7]_i_3 ),
        .I1(n_0_reset_time_out_i_10),
        .I2(\n_0_FSM_onehot_rx_state[10]_i_2 ),
        .I3(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I5(run_phase_alignment_int),
        .O(n_0_reset_time_out_i_6__0));
LUT6 #(
    .INIT(64'hFFFFFFEAEAEAFFEA)) 
     reset_time_out_i_7__0
       (.I0(run_phase_alignment_int),
        .I1(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I2(rxresetdone_s3),
        .I3(\n_0_FSM_onehot_rx_state_reg[11] ),
        .I4(data_valid_sync),
        .I5(\n_0_FSM_onehot_rx_state_reg[10] ),
        .O(n_0_reset_time_out_i_7__0));
LUT6 #(
    .INIT(64'hFFFFEA400000EA40)) 
     reset_time_out_i_8
       (.I0(\n_0_FSM_onehot_rx_state_reg[5] ),
        .I1(mmcm_lock_reclocked),
        .I2(check_tlock_max),
        .I3(gt0_rx_cdrlocked),
        .I4(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I5(cplllock_sync),
        .O(n_0_reset_time_out_i_8));
(* SOFT_HLUTNM = "soft_lutpair97" *) 
   LUT3 #(
    .INIT(8'h01)) 
     reset_time_out_i_9
       (.I0(run_phase_alignment_int),
        .I1(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[2] ),
        .O(n_0_reset_time_out_i_9));
FDSE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_reset_time_out_i_1__0),
        .Q(n_0_reset_time_out_reg),
        .S(pma_reset));
(* SOFT_HLUTNM = "soft_lutpair88" *) 
   LUT5 #(
    .INIT(32'hFFEF0002)) 
     run_phase_alignment_int_i_1__0
       (.I0(run_phase_alignment_int),
        .I1(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I3(\n_0_FSM_onehot_rx_state[10]_i_2 ),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1__0),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(userclk),
        .CE(1'b1),
        .D(run_phase_alignment_int_s2),
        .Q(n_0_run_phase_alignment_int_s3_reg),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFC3FFFFF08000000)) 
     rx_fsm_reset_done_int_i_1
       (.I0(n_0_rx_fsm_reset_done_int_i_2),
        .I1(data_valid_sync),
        .I2(\n_0_FSM_onehot_rx_state_reg[10] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[11] ),
        .I4(n_0_rx_fsm_reset_done_int_i_3),
        .I5(O1),
        .O(n_0_rx_fsm_reset_done_int_i_1));
(* SOFT_HLUTNM = "soft_lutpair99" *) 
   LUT2 #(
    .INIT(4'h2)) 
     rx_fsm_reset_done_int_i_2
       (.I0(time_out_1us),
        .I1(n_0_reset_time_out_reg),
        .O(n_0_rx_fsm_reset_done_int_i_2));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     rx_fsm_reset_done_int_i_3
       (.I0(n_0_adapt_count_reset_i_2),
        .I1(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I2(run_phase_alignment_int),
        .I3(\n_0_FSM_onehot_rx_state_reg[1] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I5(\n_0_FSM_onehot_rx_state[7]_i_2 ),
        .O(n_0_rx_fsm_reset_done_int_i_3));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_rx_fsm_reset_done_int_i_1),
        .Q(O1),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     rx_fsm_reset_done_int_s3_reg
       (.C(userclk),
        .CE(1'b1),
        .D(rx_fsm_reset_done_int_s2),
        .Q(rx_fsm_reset_done_int_s3),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     rxresetdone_s3_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(rxresetdone_s2),
        .Q(rxresetdone_s3),
        .R(1'b0));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__35 sync_RXRESETDONE
       (.clk(independent_clock_bufg),
        .data_in(I2),
        .data_out(rxresetdone_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__39 sync_cplllock
       (.clk(independent_clock_bufg),
        .data_in(cplllock),
        .data_out(cplllock_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__40 sync_cpllrefclklost
       (.clk(independent_clock_bufg),
        .data_in(CPLLREFCLKLOST),
        .data_out(NLW_sync_cpllrefclklost_data_out_UNCONNECTED));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__38 sync_data_valid
       (.clk(independent_clock_bufg),
        .data_in(data_out),
        .data_out(data_valid_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__parameterized1 sync_gtrxreset_in
       (.clk(rxuserclk),
        .reset_in(GTRXRESET),
        .reset_out(reset_out));
LUT3 #(
    .INIT(8'hEA)) 
     sync_gtrxreset_in_i_1
       (.I0(GTRXRESET),
        .I1(O1),
        .I2(reset_out0_in),
        .O(gt0_gtrxreset_in1_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__37 sync_mmcm_lock_reclocked
       (.clk(independent_clock_bufg),
        .data_in(mmcm_locked),
        .data_out(mmcm_lock_i));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__31 sync_pmaresetdone_rxclk
       (.clk(rxuserclk),
        .data_in(I1),
        .data_out(data_out_0));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__33 sync_run_phase_alignment_int
       (.clk(userclk),
        .data_in(n_0_run_phase_alignment_int_reg),
        .data_out(run_phase_alignment_int_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__34 sync_rx_fsm_reset_done_int
       (.clk(userclk),
        .data_in(O1),
        .data_out(rx_fsm_reset_done_int_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__32 sync_rxpmaresetdone
       (.clk(independent_clock_bufg),
        .data_in(1'b0),
        .data_out(NLW_sync_rxpmaresetdone_data_out_UNCONNECTED));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__36 sync_time_out_wait_bypass
       (.clk(independent_clock_bufg),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
LUT6 #(
    .INIT(64'h00000000AAAAAAAE)) 
     time_out_1us_i_1
       (.I0(time_out_1us),
        .I1(n_0_time_out_1us_i_2),
        .I2(n_0_time_out_1us_i_3),
        .I3(n_0_time_out_1us_i_4),
        .I4(\n_0_time_out_counter[0]_i_3__0 ),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_out_1us_i_1));
LUT6 #(
    .INIT(64'h0000000000000010)) 
     time_out_1us_i_2
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[8]),
        .I2(time_out_counter_reg[3]),
        .I3(time_out_counter_reg[2]),
        .I4(time_out_counter_reg[9]),
        .I5(n_0_time_out_1us_i_5),
        .O(n_0_time_out_1us_i_2));
(* SOFT_HLUTNM = "soft_lutpair95" *) 
   LUT2 #(
    .INIT(4'hE)) 
     time_out_1us_i_3
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[19]),
        .O(n_0_time_out_1us_i_3));
LUT2 #(
    .INIT(4'hE)) 
     time_out_1us_i_4
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_out_1us_i_4));
LUT2 #(
    .INIT(4'hE)) 
     time_out_1us_i_5
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(n_0_time_out_1us_i_5));
FDRE #(
    .INIT(1'b0)) 
     time_out_1us_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_out_1us_i_1),
        .Q(time_out_1us),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000AAAAABAA)) 
     time_out_2ms_i_1
       (.I0(time_out_2ms),
        .I1(time_out_counter_reg[2]),
        .I2(time_out_counter_reg[3]),
        .I3(n_0_time_out_2ms_i_2__0),
        .I4(\n_0_time_out_counter[0]_i_3__0 ),
        .I5(n_0_reset_time_out_reg),
        .O(n_0_time_out_2ms_i_1));
LUT6 #(
    .INIT(64'h0000000000800000)) 
     time_out_2ms_i_2__0
       (.I0(\n_0_time_out_counter[0]_i_10 ),
        .I1(time_out_counter_reg[13]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[12]),
        .I4(time_out_counter_reg[16]),
        .I5(time_out_counter_reg[17]),
        .O(n_0_time_out_2ms_i_2__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1),
        .Q(time_out_2ms),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair95" *) 
   LUT4 #(
    .INIT(16'h4000)) 
     \time_out_counter[0]_i_10 
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[19]),
        .I2(time_out_counter_reg[9]),
        .I3(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[0]_i_10 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \time_out_counter[0]_i_1__0 
       (.I0(\n_0_time_out_counter[0]_i_3__0 ),
        .I1(\n_0_time_out_counter[0]_i_4__0 ),
        .I2(time_out_counter_reg[2]),
        .I3(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_1__0 ));
LUT4 #(
    .INIT(16'hFFFE)) 
     \time_out_counter[0]_i_3__0 
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[0]),
        .I2(time_out_counter_reg[1]),
        .I3(\n_0_time_out_counter[0]_i_9__0 ),
        .O(\n_0_time_out_counter[0]_i_3__0 ));
LUT6 #(
    .INIT(64'hFFF7FFFFFFFFFFFF)) 
     \time_out_counter[0]_i_4__0 
       (.I0(\n_0_time_out_counter[0]_i_10 ),
        .I1(time_out_counter_reg[16]),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[12]),
        .I4(time_out_counter_reg[10]),
        .I5(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[0]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_5__0 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6__0 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_6__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_7__0 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_7__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_8 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_8 ));
LUT6 #(
    .INIT(64'hFFFFFFFDFFFFFFFF)) 
     \time_out_counter[0]_i_9__0 
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[5]),
        .I2(time_out_counter_reg[14]),
        .I3(time_out_counter_reg[15]),
        .I4(time_out_counter_reg[11]),
        .I5(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[0]_i_9__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2__0 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3__0 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4__0 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5__0 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2__0 
       (.I0(time_out_counter_reg[19]),
        .O(\n_0_time_out_counter[16]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3__0 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4__0 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_5 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2__0 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3__0 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4__0 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5__0 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2__0 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3__0 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4__0 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5__0 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5__0 ));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[0]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[0]_i_2__0 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2__0 ,\n_1_time_out_counter_reg[0]_i_2__0 ,\n_2_time_out_counter_reg[0]_i_2__0 ,\n_3_time_out_counter_reg[0]_i_2__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2__0 ,\n_5_time_out_counter_reg[0]_i_2__0 ,\n_6_time_out_counter_reg[0]_i_2__0 ,\n_7_time_out_counter_reg[0]_i_2__0 }),
        .S({\n_0_time_out_counter[0]_i_5__0 ,\n_0_time_out_counter[0]_i_6__0 ,\n_0_time_out_counter[0]_i_7__0 ,\n_0_time_out_counter[0]_i_8 }));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[10]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[11]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[12]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[12]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[8]_i_1__0 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1__0 ,\n_1_time_out_counter_reg[12]_i_1__0 ,\n_2_time_out_counter_reg[12]_i_1__0 ,\n_3_time_out_counter_reg[12]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1__0 ,\n_5_time_out_counter_reg[12]_i_1__0 ,\n_6_time_out_counter_reg[12]_i_1__0 ,\n_7_time_out_counter_reg[12]_i_1__0 }),
        .S({\n_0_time_out_counter[12]_i_2__0 ,\n_0_time_out_counter[12]_i_3__0 ,\n_0_time_out_counter[12]_i_4__0 ,\n_0_time_out_counter[12]_i_5__0 }));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[13]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[14]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[12]_i_1__0 ),
        .Q(time_out_counter_reg[15]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[16]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[16]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[12]_i_1__0 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1__0_CO_UNCONNECTED [3],\n_1_time_out_counter_reg[16]_i_1__0 ,\n_2_time_out_counter_reg[16]_i_1__0 ,\n_3_time_out_counter_reg[16]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[16]_i_1__0 ,\n_5_time_out_counter_reg[16]_i_1__0 ,\n_6_time_out_counter_reg[16]_i_1__0 ,\n_7_time_out_counter_reg[16]_i_1__0 }),
        .S({\n_0_time_out_counter[16]_i_2__0 ,\n_0_time_out_counter[16]_i_3__0 ,\n_0_time_out_counter[16]_i_4__0 ,\n_0_time_out_counter[16]_i_5 }));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[17]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[18]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[19] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[16]_i_1__0 ),
        .Q(time_out_counter_reg[19]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[1]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[2]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[0]_i_2__0 ),
        .Q(time_out_counter_reg[3]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[4]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[4]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[0]_i_2__0 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1__0 ,\n_1_time_out_counter_reg[4]_i_1__0 ,\n_2_time_out_counter_reg[4]_i_1__0 ,\n_3_time_out_counter_reg[4]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1__0 ,\n_5_time_out_counter_reg[4]_i_1__0 ,\n_6_time_out_counter_reg[4]_i_1__0 ,\n_7_time_out_counter_reg[4]_i_1__0 }),
        .S({\n_0_time_out_counter[4]_i_2__0 ,\n_0_time_out_counter[4]_i_3__0 ,\n_0_time_out_counter[4]_i_4__0 ,\n_0_time_out_counter[4]_i_5__0 }));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[5]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_5_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[6]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_4_time_out_counter_reg[4]_i_1__0 ),
        .Q(time_out_counter_reg[7]),
        .R(n_0_reset_time_out_reg));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_7_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[8]),
        .R(n_0_reset_time_out_reg));
CARRY4 \time_out_counter_reg[8]_i_1__0 
       (.CI(\n_0_time_out_counter_reg[4]_i_1__0 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1__0 ,\n_1_time_out_counter_reg[8]_i_1__0 ,\n_2_time_out_counter_reg[8]_i_1__0 ,\n_3_time_out_counter_reg[8]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1__0 ,\n_5_time_out_counter_reg[8]_i_1__0 ,\n_6_time_out_counter_reg[8]_i_1__0 ,\n_7_time_out_counter_reg[8]_i_1__0 }),
        .S({\n_0_time_out_counter[8]_i_2__0 ,\n_0_time_out_counter[8]_i_3__0 ,\n_0_time_out_counter[8]_i_4__0 ,\n_0_time_out_counter[8]_i_5__0 }));
(* counter = "21" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1__0 ),
        .D(\n_6_time_out_counter_reg[8]_i_1__0 ),
        .Q(time_out_counter_reg[9]),
        .R(n_0_reset_time_out_reg));
LUT6 #(
    .INIT(64'hFF00FF0400000000)) 
     time_out_wait_bypass_i_1__0
       (.I0(\n_0_wait_bypass_count[0]_i_4__0 ),
        .I1(wait_bypass_count_reg[7]),
        .I2(\n_0_wait_bypass_count[0]_i_5__0 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(rx_fsm_reset_done_int_s3),
        .I5(n_0_run_phase_alignment_int_s3_reg),
        .O(n_0_time_out_wait_bypass_i_1__0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(userclk),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1__0),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_10
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[8]),
        .O(n_0_time_tlock_max_i_10));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_11
       (.I0(time_out_counter_reg[14]),
        .I1(time_out_counter_reg[15]),
        .O(n_0_time_tlock_max_i_11));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_12
       (.I0(time_out_counter_reg[13]),
        .I1(time_out_counter_reg[12]),
        .O(n_0_time_tlock_max_i_12));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_13
       (.I0(time_out_counter_reg[10]),
        .I1(time_out_counter_reg[11]),
        .O(n_0_time_tlock_max_i_13));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_14
       (.I0(time_out_counter_reg[9]),
        .I1(time_out_counter_reg[8]),
        .O(n_0_time_tlock_max_i_14));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_15
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(n_0_time_tlock_max_i_15));
LUT2 #(
    .INIT(4'h8)) 
     time_tlock_max_i_16
       (.I0(time_out_counter_reg[4]),
        .I1(time_out_counter_reg[5]),
        .O(n_0_time_tlock_max_i_16));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_17
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[3]),
        .O(n_0_time_tlock_max_i_17));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_18
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[1]),
        .O(n_0_time_tlock_max_i_18));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_19
       (.I0(time_out_counter_reg[6]),
        .I1(time_out_counter_reg[7]),
        .O(n_0_time_tlock_max_i_19));
(* SOFT_HLUTNM = "soft_lutpair99" *) 
   LUT4 #(
    .INIT(16'h00EA)) 
     time_tlock_max_i_1__0
       (.I0(time_tlock_max),
        .I1(time_tlock_max1),
        .I2(n_0_check_tlock_max_reg),
        .I3(n_0_reset_time_out_reg),
        .O(n_0_time_tlock_max_i_1__0));
LUT2 #(
    .INIT(4'h2)) 
     time_tlock_max_i_20
       (.I0(time_out_counter_reg[5]),
        .I1(time_out_counter_reg[4]),
        .O(n_0_time_tlock_max_i_20));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_21
       (.I0(time_out_counter_reg[3]),
        .I1(time_out_counter_reg[2]),
        .O(n_0_time_tlock_max_i_21));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_22
       (.I0(time_out_counter_reg[1]),
        .I1(time_out_counter_reg[0]),
        .O(n_0_time_tlock_max_i_22));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_4
       (.I0(time_out_counter_reg[18]),
        .I1(time_out_counter_reg[19]),
        .O(n_0_time_tlock_max_i_4));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_5
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[17]),
        .O(n_0_time_tlock_max_i_5));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_6
       (.I0(time_out_counter_reg[19]),
        .I1(time_out_counter_reg[18]),
        .O(n_0_time_tlock_max_i_6));
LUT2 #(
    .INIT(4'h1)) 
     time_tlock_max_i_7
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[16]),
        .O(n_0_time_tlock_max_i_7));
LUT2 #(
    .INIT(4'hE)) 
     time_tlock_max_i_9
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[13]),
        .O(n_0_time_tlock_max_i_9));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1__0),
        .Q(time_tlock_max),
        .R(1'b0));
CARRY4 time_tlock_max_reg_i_2
       (.CI(n_0_time_tlock_max_reg_i_3),
        .CO({NLW_time_tlock_max_reg_i_2_CO_UNCONNECTED[3:2],time_tlock_max1,n_3_time_tlock_max_reg_i_2}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,n_0_time_tlock_max_i_4,n_0_time_tlock_max_i_5}),
        .O(NLW_time_tlock_max_reg_i_2_O_UNCONNECTED[3:0]),
        .S({1'b0,1'b0,n_0_time_tlock_max_i_6,n_0_time_tlock_max_i_7}));
CARRY4 time_tlock_max_reg_i_3
       (.CI(n_0_time_tlock_max_reg_i_8),
        .CO({n_0_time_tlock_max_reg_i_3,n_1_time_tlock_max_reg_i_3,n_2_time_tlock_max_reg_i_3,n_3_time_tlock_max_reg_i_3}),
        .CYINIT(1'b0),
        .DI({time_out_counter_reg[15],n_0_time_tlock_max_i_9,1'b0,n_0_time_tlock_max_i_10}),
        .O(NLW_time_tlock_max_reg_i_3_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_11,n_0_time_tlock_max_i_12,n_0_time_tlock_max_i_13,n_0_time_tlock_max_i_14}));
CARRY4 time_tlock_max_reg_i_8
       (.CI(1'b0),
        .CO({n_0_time_tlock_max_reg_i_8,n_1_time_tlock_max_reg_i_8,n_2_time_tlock_max_reg_i_8,n_3_time_tlock_max_reg_i_8}),
        .CYINIT(1'b0),
        .DI({n_0_time_tlock_max_i_15,n_0_time_tlock_max_i_16,n_0_time_tlock_max_i_17,n_0_time_tlock_max_i_18}),
        .O(NLW_time_tlock_max_reg_i_8_O_UNCONNECTED[3:0]),
        .S({n_0_time_tlock_max_i_19,n_0_time_tlock_max_i_20,n_0_time_tlock_max_i_21,n_0_time_tlock_max_i_22}));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1__0 
       (.I0(n_0_run_phase_alignment_int_s3_reg),
        .O(\n_0_wait_bypass_count[0]_i_1__0 ));
LUT4 #(
    .INIT(16'h00FB)) 
     \wait_bypass_count[0]_i_2__0 
       (.I0(\n_0_wait_bypass_count[0]_i_4__0 ),
        .I1(wait_bypass_count_reg[7]),
        .I2(\n_0_wait_bypass_count[0]_i_5__0 ),
        .I3(rx_fsm_reset_done_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_2__0 ));
LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_4__0 
       (.I0(wait_bypass_count_reg[2]),
        .I1(wait_bypass_count_reg[3]),
        .I2(wait_bypass_count_reg[4]),
        .I3(wait_bypass_count_reg[1]),
        .I4(wait_bypass_count_reg[5]),
        .I5(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[0]_i_4__0 ));
LUT6 #(
    .INIT(64'hFFFDFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_5__0 
       (.I0(wait_bypass_count_reg[8]),
        .I1(wait_bypass_count_reg[11]),
        .I2(wait_bypass_count_reg[10]),
        .I3(wait_bypass_count_reg[6]),
        .I4(wait_bypass_count_reg[0]),
        .I5(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[0]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_6__0 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_6__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7__0 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_7__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8__0 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_8__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_9 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_9 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2__0 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2__0 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3__0 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4__0 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5__0 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2__0 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3__0 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4__0 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5__0 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[0] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[0]_i_3__0 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3__0 ,\n_1_wait_bypass_count_reg[0]_i_3__0 ,\n_2_wait_bypass_count_reg[0]_i_3__0 ,\n_3_wait_bypass_count_reg[0]_i_3__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3__0 ,\n_5_wait_bypass_count_reg[0]_i_3__0 ,\n_6_wait_bypass_count_reg[0]_i_3__0 ,\n_7_wait_bypass_count_reg[0]_i_3__0 }),
        .S({\n_0_wait_bypass_count[0]_i_6__0 ,\n_0_wait_bypass_count[0]_i_7__0 ,\n_0_wait_bypass_count[0]_i_8__0 ,\n_0_wait_bypass_count[0]_i_9 }));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[10] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[11] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[12] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1__0 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[12]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1__0 ),
        .CO(\NLW_wait_bypass_count_reg[12]_i_1__0_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[12]_i_1__0_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[12]_i_1__0 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[12]_i_2__0 }));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[1] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[2] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[3] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3__0 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[4] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[4]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3__0 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1__0 ,\n_1_wait_bypass_count_reg[4]_i_1__0 ,\n_2_wait_bypass_count_reg[4]_i_1__0 ,\n_3_wait_bypass_count_reg[4]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1__0 ,\n_5_wait_bypass_count_reg[4]_i_1__0 ,\n_6_wait_bypass_count_reg[4]_i_1__0 ,\n_7_wait_bypass_count_reg[4]_i_1__0 }),
        .S({\n_0_wait_bypass_count[4]_i_2__0 ,\n_0_wait_bypass_count[4]_i_3__0 ,\n_0_wait_bypass_count[4]_i_4__0 ,\n_0_wait_bypass_count[4]_i_5__0 }));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[5] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[6] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[7] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1__0 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[8] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
CARRY4 \wait_bypass_count_reg[8]_i_1__0 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1__0 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1__0 ,\n_1_wait_bypass_count_reg[8]_i_1__0 ,\n_2_wait_bypass_count_reg[8]_i_1__0 ,\n_3_wait_bypass_count_reg[8]_i_1__0 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1__0 ,\n_5_wait_bypass_count_reg[8]_i_1__0 ,\n_6_wait_bypass_count_reg[8]_i_1__0 ,\n_7_wait_bypass_count_reg[8]_i_1__0 }),
        .S({\n_0_wait_bypass_count[8]_i_2__0 ,\n_0_wait_bypass_count[8]_i_3__0 ,\n_0_wait_bypass_count[8]_i_4__0 ,\n_0_wait_bypass_count[8]_i_5__0 }));
(* counter = "23" *) 
   FDRE \wait_bypass_count_reg[9] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2__0 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1__0 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1__0 ));
(* RETAIN_INVERTER *) 
   (* SOFT_HLUTNM = "soft_lutpair103" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1__0 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__0[0]));
(* SOFT_HLUTNM = "soft_lutpair103" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1__0 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__0[1]));
LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1__0 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__0[2]));
(* SOFT_HLUTNM = "soft_lutpair91" *) 
   LUT4 #(
    .INIT(16'hFE01)) 
     \wait_time_cnt[3]_i_1__0 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0__0[3]));
(* SOFT_HLUTNM = "soft_lutpair91" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1__0 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0__0[4]));
LUT6 #(
    .INIT(64'hF0F0F0F0F0F0F0E1)) 
     \wait_time_cnt[5]_i_1__0 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[4]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0__0[5]));
LUT5 #(
    .INIT(32'h0000000E)) 
     \wait_time_cnt[6]_i_1__0 
       (.I0(\n_0_FSM_onehot_rx_state_reg[2] ),
        .I1(check_tlock_max),
        .I2(\n_0_FSM_onehot_rx_state_reg[4] ),
        .I3(run_phase_alignment_int),
        .I4(\n_0_wait_time_cnt[6]_i_4__0 ),
        .O(\n_0_wait_time_cnt[6]_i_1__0 ));
LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_2__0 
       (.I0(\n_0_FSM_onehot_rx_state[11]_i_3 ),
        .I1(wait_time_cnt_reg__0[6]),
        .O(\n_0_wait_time_cnt[6]_i_2__0 ));
LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[6]_i_3__0 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_FSM_onehot_rx_state[11]_i_3 ),
        .O(wait_time_cnt0__0[6]));
(* SOFT_HLUTNM = "soft_lutpair93" *) 
   LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \wait_time_cnt[6]_i_4__0 
       (.I0(\n_0_FSM_onehot_rx_state_reg[11] ),
        .I1(\n_0_FSM_onehot_rx_state_reg[10] ),
        .I2(\n_0_FSM_onehot_rx_state_reg[8] ),
        .I3(\n_0_FSM_onehot_rx_state_reg[3] ),
        .I4(\n_0_FSM_onehot_rx_state_reg[7] ),
        .O(\n_0_wait_time_cnt[6]_i_4__0 ));
(* counter = "20" *) 
   FDRE \wait_time_cnt_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
(* counter = "20" *) 
   FDRE \wait_time_cnt_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[1]),
        .Q(wait_time_cnt_reg__0[1]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
(* counter = "20" *) 
   FDSE \wait_time_cnt_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
(* counter = "20" *) 
   FDRE \wait_time_cnt_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
(* counter = "20" *) 
   FDRE \wait_time_cnt_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[4]),
        .Q(wait_time_cnt_reg__0[4]),
        .R(\n_0_wait_time_cnt[6]_i_1__0 ));
(* counter = "20" *) 
   FDSE \wait_time_cnt_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
(* counter = "20" *) 
   FDSE \wait_time_cnt_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_wait_time_cnt[6]_i_2__0 ),
        .D(wait_time_cnt0__0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(\n_0_wait_time_cnt[6]_i_1__0 ));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_TX_STARTUP_FSM" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_TX_STARTUP_FSM__parameterized0
   (O1,
    CPLL_RESET,
    TXUSERRDY,
    gt0_gttxreset_in0_out,
    resetdone,
    userclk,
    independent_clock_bufg,
    I1,
    mmcm_locked,
    cplllock,
    CPLLREFCLKLOST,
    pma_reset,
    reset_out,
    O9);
  output O1;
  output CPLL_RESET;
  output TXUSERRDY;
  output gt0_gttxreset_in0_out;
  output resetdone;
  input userclk;
  input independent_clock_bufg;
  input I1;
  input mmcm_locked;
  input cplllock;
  input CPLLREFCLKLOST;
  input pma_reset;
  input reset_out;
  input O9;

  wire CPLLREFCLKLOST;
  wire CPLL_RESET;
  wire GTTXRESET;
  wire I1;
  wire O1;
  wire O9;
  wire TXUSERRDY;
  wire clear;
  wire cplllock;
  wire cplllock_sync;
  wire data_out;
  wire gt0_gttxreset_in0_out;
  wire independent_clock_bufg;
  wire [6:0]init_wait_count_reg__0;
  wire init_wait_done;
  wire [9:0]mmcm_lock_count_reg__0;
  wire mmcm_lock_i;
  wire mmcm_lock_reclocked;
  wire mmcm_locked;
  wire n_0_CPLL_RESET_i_1;
  wire \n_0_FSM_onehot_tx_state[10]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_10 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_11 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_2 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_3 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_4 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_5 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_6 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_7 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_8 ;
  wire \n_0_FSM_onehot_tx_state[10]_i_9 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_2 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_3 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_4 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_5 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_6 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_7 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_8 ;
  wire \n_0_FSM_onehot_tx_state[2]_i_9 ;
  wire \n_0_FSM_onehot_tx_state[3]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[3]_i_2 ;
  wire \n_0_FSM_onehot_tx_state[3]_i_3 ;
  wire \n_0_FSM_onehot_tx_state[4]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[5]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[6]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[7]_i_2 ;
  wire \n_0_FSM_onehot_tx_state[8]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[8]_i_2 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_1 ;
  wire \n_0_FSM_onehot_tx_state[9]_i_2 ;
  wire \n_0_FSM_onehot_tx_state_reg[0] ;
  wire \n_0_FSM_onehot_tx_state_reg[10] ;
  wire \n_0_FSM_onehot_tx_state_reg[1] ;
  wire \n_0_FSM_onehot_tx_state_reg[2] ;
  wire \n_0_FSM_onehot_tx_state_reg[3] ;
  wire \n_0_FSM_onehot_tx_state_reg[4] ;
  wire \n_0_FSM_onehot_tx_state_reg[5] ;
  wire \n_0_FSM_onehot_tx_state_reg[6] ;
  wire \n_0_FSM_onehot_tx_state_reg[7] ;
  wire \n_0_FSM_onehot_tx_state_reg[8] ;
  wire n_0_TXUSERRDY_i_1;
  wire n_0_gttxreset_i_i_1;
  wire n_0_gttxreset_i_i_2;
  wire \n_0_init_wait_count[0]_i_1 ;
  wire \n_0_init_wait_count[6]_i_1 ;
  wire \n_0_init_wait_count[6]_i_3 ;
  wire \n_0_init_wait_count[6]_i_4 ;
  wire n_0_init_wait_done_i_1;
  wire n_0_init_wait_done_i_2;
  wire \n_0_mmcm_lock_count[0]_i_1 ;
  wire \n_0_mmcm_lock_count[9]_i_1 ;
  wire \n_0_mmcm_lock_count[9]_i_2 ;
  wire \n_0_mmcm_lock_count[9]_i_4 ;
  wire n_0_mmcm_lock_reclocked_i_1;
  wire n_0_mmcm_lock_reclocked_i_2;
  wire n_0_pll_reset_asserted_i_1;
  wire n_0_pll_reset_asserted_reg;
  wire n_0_reset_time_out_i_1;
  wire n_0_reset_time_out_i_3;
  wire n_0_reset_time_out_i_4;
  wire n_0_reset_time_out_i_5;
  wire n_0_reset_time_out_i_6;
  wire n_0_reset_time_out_i_7;
  wire n_0_run_phase_alignment_int_i_1;
  wire n_0_run_phase_alignment_int_i_2;
  wire n_0_run_phase_alignment_int_reg;
  wire n_0_time_out_2ms_i_1__0;
  wire n_0_time_out_2ms_i_2;
  wire n_0_time_out_500us_i_1;
  wire n_0_time_out_500us_i_2;
  wire \n_0_time_out_counter[0]_i_1 ;
  wire \n_0_time_out_counter[0]_i_10__0 ;
  wire \n_0_time_out_counter[0]_i_3 ;
  wire \n_0_time_out_counter[0]_i_4 ;
  wire \n_0_time_out_counter[0]_i_5 ;
  wire \n_0_time_out_counter[0]_i_6 ;
  wire \n_0_time_out_counter[0]_i_7 ;
  wire \n_0_time_out_counter[0]_i_8__0 ;
  wire \n_0_time_out_counter[0]_i_9 ;
  wire \n_0_time_out_counter[12]_i_2 ;
  wire \n_0_time_out_counter[12]_i_3 ;
  wire \n_0_time_out_counter[12]_i_4 ;
  wire \n_0_time_out_counter[12]_i_5 ;
  wire \n_0_time_out_counter[16]_i_2 ;
  wire \n_0_time_out_counter[16]_i_3 ;
  wire \n_0_time_out_counter[16]_i_4 ;
  wire \n_0_time_out_counter[4]_i_2 ;
  wire \n_0_time_out_counter[4]_i_3 ;
  wire \n_0_time_out_counter[4]_i_4 ;
  wire \n_0_time_out_counter[4]_i_5 ;
  wire \n_0_time_out_counter[8]_i_2 ;
  wire \n_0_time_out_counter[8]_i_3 ;
  wire \n_0_time_out_counter[8]_i_4 ;
  wire \n_0_time_out_counter[8]_i_5 ;
  wire \n_0_time_out_counter_reg[0]_i_2 ;
  wire \n_0_time_out_counter_reg[12]_i_1 ;
  wire \n_0_time_out_counter_reg[4]_i_1 ;
  wire \n_0_time_out_counter_reg[8]_i_1 ;
  wire n_0_time_out_wait_bypass_i_1;
  wire n_0_time_out_wait_bypass_reg;
  wire n_0_time_tlock_max_i_1;
  wire n_0_time_tlock_max_i_2;
  wire n_0_time_tlock_max_i_3;
  wire n_0_tx_fsm_reset_done_int_i_1;
  wire n_0_tx_fsm_reset_done_int_i_2;
  wire n_0_tx_fsm_reset_done_int_i_3;
  wire \n_0_wait_bypass_count[0]_i_1 ;
  wire \n_0_wait_bypass_count[0]_i_10 ;
  wire \n_0_wait_bypass_count[0]_i_2 ;
  wire \n_0_wait_bypass_count[0]_i_4 ;
  wire \n_0_wait_bypass_count[0]_i_5 ;
  wire \n_0_wait_bypass_count[0]_i_6 ;
  wire \n_0_wait_bypass_count[0]_i_7 ;
  wire \n_0_wait_bypass_count[0]_i_8 ;
  wire \n_0_wait_bypass_count[0]_i_9__0 ;
  wire \n_0_wait_bypass_count[12]_i_2 ;
  wire \n_0_wait_bypass_count[12]_i_3 ;
  wire \n_0_wait_bypass_count[12]_i_4 ;
  wire \n_0_wait_bypass_count[12]_i_5 ;
  wire \n_0_wait_bypass_count[16]_i_2 ;
  wire \n_0_wait_bypass_count[4]_i_2 ;
  wire \n_0_wait_bypass_count[4]_i_3 ;
  wire \n_0_wait_bypass_count[4]_i_4 ;
  wire \n_0_wait_bypass_count[4]_i_5 ;
  wire \n_0_wait_bypass_count[8]_i_2 ;
  wire \n_0_wait_bypass_count[8]_i_3 ;
  wire \n_0_wait_bypass_count[8]_i_4 ;
  wire \n_0_wait_bypass_count[8]_i_5 ;
  wire \n_0_wait_bypass_count_reg[0]_i_3 ;
  wire \n_0_wait_bypass_count_reg[12]_i_1 ;
  wire \n_0_wait_bypass_count_reg[4]_i_1 ;
  wire \n_0_wait_bypass_count_reg[8]_i_1 ;
  wire \n_0_wait_time_cnt[6]_i_4 ;
  wire \n_0_wait_time_cnt[6]_i_5 ;
  wire \n_0_wait_time_cnt[6]_i_6 ;
  wire \n_1_time_out_counter_reg[0]_i_2 ;
  wire \n_1_time_out_counter_reg[12]_i_1 ;
  wire \n_1_time_out_counter_reg[4]_i_1 ;
  wire \n_1_time_out_counter_reg[8]_i_1 ;
  wire \n_1_wait_bypass_count_reg[0]_i_3 ;
  wire \n_1_wait_bypass_count_reg[12]_i_1 ;
  wire \n_1_wait_bypass_count_reg[4]_i_1 ;
  wire \n_1_wait_bypass_count_reg[8]_i_1 ;
  wire \n_2_time_out_counter_reg[0]_i_2 ;
  wire \n_2_time_out_counter_reg[12]_i_1 ;
  wire \n_2_time_out_counter_reg[16]_i_1 ;
  wire \n_2_time_out_counter_reg[4]_i_1 ;
  wire \n_2_time_out_counter_reg[8]_i_1 ;
  wire \n_2_wait_bypass_count_reg[0]_i_3 ;
  wire \n_2_wait_bypass_count_reg[12]_i_1 ;
  wire \n_2_wait_bypass_count_reg[4]_i_1 ;
  wire \n_2_wait_bypass_count_reg[8]_i_1 ;
  wire \n_3_time_out_counter_reg[0]_i_2 ;
  wire \n_3_time_out_counter_reg[12]_i_1 ;
  wire \n_3_time_out_counter_reg[16]_i_1 ;
  wire \n_3_time_out_counter_reg[4]_i_1 ;
  wire \n_3_time_out_counter_reg[8]_i_1 ;
  wire \n_3_wait_bypass_count_reg[0]_i_3 ;
  wire \n_3_wait_bypass_count_reg[12]_i_1 ;
  wire \n_3_wait_bypass_count_reg[4]_i_1 ;
  wire \n_3_wait_bypass_count_reg[8]_i_1 ;
  wire \n_4_time_out_counter_reg[0]_i_2 ;
  wire \n_4_time_out_counter_reg[12]_i_1 ;
  wire \n_4_time_out_counter_reg[4]_i_1 ;
  wire \n_4_time_out_counter_reg[8]_i_1 ;
  wire \n_4_wait_bypass_count_reg[0]_i_3 ;
  wire \n_4_wait_bypass_count_reg[12]_i_1 ;
  wire \n_4_wait_bypass_count_reg[4]_i_1 ;
  wire \n_4_wait_bypass_count_reg[8]_i_1 ;
  wire \n_5_time_out_counter_reg[0]_i_2 ;
  wire \n_5_time_out_counter_reg[12]_i_1 ;
  wire \n_5_time_out_counter_reg[16]_i_1 ;
  wire \n_5_time_out_counter_reg[4]_i_1 ;
  wire \n_5_time_out_counter_reg[8]_i_1 ;
  wire \n_5_wait_bypass_count_reg[0]_i_3 ;
  wire \n_5_wait_bypass_count_reg[12]_i_1 ;
  wire \n_5_wait_bypass_count_reg[4]_i_1 ;
  wire \n_5_wait_bypass_count_reg[8]_i_1 ;
  wire \n_6_time_out_counter_reg[0]_i_2 ;
  wire \n_6_time_out_counter_reg[12]_i_1 ;
  wire \n_6_time_out_counter_reg[16]_i_1 ;
  wire \n_6_time_out_counter_reg[4]_i_1 ;
  wire \n_6_time_out_counter_reg[8]_i_1 ;
  wire \n_6_wait_bypass_count_reg[0]_i_3 ;
  wire \n_6_wait_bypass_count_reg[12]_i_1 ;
  wire \n_6_wait_bypass_count_reg[4]_i_1 ;
  wire \n_6_wait_bypass_count_reg[8]_i_1 ;
  wire \n_7_time_out_counter_reg[0]_i_2 ;
  wire \n_7_time_out_counter_reg[12]_i_1 ;
  wire \n_7_time_out_counter_reg[16]_i_1 ;
  wire \n_7_time_out_counter_reg[4]_i_1 ;
  wire \n_7_time_out_counter_reg[8]_i_1 ;
  wire \n_7_wait_bypass_count_reg[0]_i_3 ;
  wire \n_7_wait_bypass_count_reg[12]_i_1 ;
  wire \n_7_wait_bypass_count_reg[16]_i_1 ;
  wire \n_7_wait_bypass_count_reg[4]_i_1 ;
  wire \n_7_wait_bypass_count_reg[8]_i_1 ;
  wire [6:1]p_0_in;
  wire [9:1]p_0_in__1;
  wire pma_reset;
  wire reset_out;
  wire reset_time_out;
  wire reset_time_out_0;
  wire resetdone;
  wire run_phase_alignment_int;
  wire run_phase_alignment_int_s3;
  wire sel;
  wire time_out_2ms;
  wire time_out_500us;
  wire [18:0]time_out_counter_reg;
  wire time_out_wait_bypass_s2;
  wire time_out_wait_bypass_s3;
  wire time_tlock_max;
  wire tx_fsm_reset_done_int;
  wire tx_fsm_reset_done_int_s2;
  wire tx_fsm_reset_done_int_s3;
  wire txresetdone_s2;
  wire txresetdone_s3;
  wire userclk;
  wire [16:0]wait_bypass_count_reg;
  wire [6:0]wait_time_cnt0;
  wire [6:0]wait_time_cnt_reg__0;
  wire NLW_sync_cpllrefclklost_data_out_UNCONNECTED;
  wire [3:2]\NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED ;
  wire [3:1]\NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED ;

LUT3 #(
    .INIT(8'h74)) 
     CPLL_RESET_i_1
       (.I0(n_0_pll_reset_asserted_reg),
        .I1(\n_0_FSM_onehot_tx_state[3]_i_1 ),
        .I2(CPLL_RESET),
        .O(n_0_CPLL_RESET_i_1));
FDRE #(
    .INIT(1'b0)) 
     CPLL_RESET_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_CPLL_RESET_i_1),
        .Q(CPLL_RESET),
        .R(pma_reset));
LUT6 #(
    .INIT(64'h0000000000000040)) 
     \FSM_onehot_tx_state[0]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I2(n_0_tx_fsm_reset_done_int_i_3),
        .I3(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I5(run_phase_alignment_int),
        .O(tx_fsm_reset_done_int));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFEFEE)) 
     \FSM_onehot_tx_state[10]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[10]_i_3 ),
        .I1(\n_0_FSM_onehot_tx_state[10]_i_4 ),
        .I2(sel),
        .I3(\n_0_FSM_onehot_tx_state[10]_i_5 ),
        .I4(\n_0_FSM_onehot_tx_state[10]_i_6 ),
        .I5(\n_0_FSM_onehot_tx_state[10]_i_7 ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair113" *) 
   LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \FSM_onehot_tx_state[10]_i_10 
       (.I0(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[1] ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_10 ));
(* SOFT_HLUTNM = "soft_lutpair123" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_tx_state[10]_i_11 
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[3] ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_11 ));
LUT6 #(
    .INIT(64'h0000010000000000)) 
     \FSM_onehot_tx_state[10]_i_2 
       (.I0(n_0_tx_fsm_reset_done_int_i_2),
        .I1(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I3(run_phase_alignment_int),
        .I4(time_out_wait_bypass_s3),
        .I5(n_0_tx_fsm_reset_done_int_i_3),
        .O(\n_0_FSM_onehot_tx_state[10]_i_2 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFEA)) 
     \FSM_onehot_tx_state[10]_i_3 
       (.I0(\n_0_FSM_onehot_tx_state[10]_i_8 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I2(n_0_run_phase_alignment_int_i_2),
        .I3(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I4(run_phase_alignment_int),
        .I5(\n_0_FSM_onehot_tx_state[10]_i_9 ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_3 ));
LUT5 #(
    .INIT(32'h8F888888)) 
     \FSM_onehot_tx_state[10]_i_4 
       (.I0(txresetdone_s3),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(cplllock_sync),
        .I3(n_0_pll_reset_asserted_reg),
        .I4(\n_0_FSM_onehot_tx_state_reg[2] ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair110" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     \FSM_onehot_tx_state[10]_i_5 
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_5 ));
LUT6 #(
    .INIT(64'hFFFFFFEAEAEAEAEA)) 
     \FSM_onehot_tx_state[10]_i_6 
       (.I0(\n_0_FSM_onehot_tx_state[2]_i_2 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I2(mmcm_lock_reclocked),
        .I3(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I4(n_0_run_phase_alignment_int_i_2),
        .I5(\n_0_FSM_onehot_tx_state[3]_i_3 ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_6 ));
LUT6 #(
    .INIT(64'h0000003200000033)) 
     \FSM_onehot_tx_state[10]_i_7 
       (.I0(cplllock_sync),
        .I1(\n_0_FSM_onehot_tx_state[10]_i_10 ),
        .I2(time_out_2ms),
        .I3(\n_0_FSM_onehot_tx_state[10]_i_11 ),
        .I4(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[4] ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_7 ));
LUT5 #(
    .INIT(32'hFFFFEEE0)) 
     \FSM_onehot_tx_state[10]_i_8 
       (.I0(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I4(\n_0_FSM_onehot_tx_state[2]_i_9 ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_8 ));
LUT5 #(
    .INIT(32'h8F888888)) 
     \FSM_onehot_tx_state[10]_i_9 
       (.I0(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I1(init_wait_done),
        .I2(reset_time_out),
        .I3(time_tlock_max),
        .I4(\n_0_FSM_onehot_tx_state_reg[6] ),
        .O(\n_0_FSM_onehot_tx_state[10]_i_9 ));
LUT6 #(
    .INIT(64'hFFFFFFFEFFFAFFFE)) 
     \FSM_onehot_tx_state[2]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state[2]_i_2 ),
        .I1(\n_0_FSM_onehot_tx_state[2]_i_3 ),
        .I2(\n_0_FSM_onehot_tx_state[2]_i_4 ),
        .I3(\n_0_FSM_onehot_tx_state[2]_i_5 ),
        .I4(\n_0_FSM_onehot_tx_state[2]_i_6 ),
        .I5(\n_0_FSM_onehot_tx_state[3]_i_3 ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_1 ));
LUT6 #(
    .INIT(64'hF888F888F8F8F888)) 
     \FSM_onehot_tx_state[2]_i_2 
       (.I0(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I1(\n_0_wait_time_cnt[6]_i_4 ),
        .I2(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I4(time_out_500us),
        .I5(reset_time_out),
        .O(\n_0_FSM_onehot_tx_state[2]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair110" *) 
   LUT5 #(
    .INIT(32'h00020003)) 
     \FSM_onehot_tx_state[2]_i_3 
       (.I0(time_out_2ms),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[4] ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_3 ));
LUT6 #(
    .INIT(64'hFFFF020002000200)) 
     \FSM_onehot_tx_state[2]_i_4 
       (.I0(time_tlock_max),
        .I1(reset_time_out),
        .I2(mmcm_lock_reclocked),
        .I3(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I4(run_phase_alignment_int),
        .I5(\n_0_FSM_onehot_tx_state[2]_i_7 ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFEAEAEA)) 
     \FSM_onehot_tx_state[2]_i_5 
       (.I0(\n_0_FSM_onehot_tx_state[2]_i_8 ),
        .I1(time_out_wait_bypass_s3),
        .I2(run_phase_alignment_int),
        .I3(\n_0_FSM_onehot_tx_state[3]_i_2 ),
        .I4(n_0_tx_fsm_reset_done_int_i_2),
        .I5(\n_0_FSM_onehot_tx_state[2]_i_9 ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_5 ));
(* SOFT_HLUTNM = "soft_lutpair112" *) 
   LUT5 #(
    .INIT(32'hFFFFFFFE)) 
     \FSM_onehot_tx_state[2]_i_6 
       (.I0(run_phase_alignment_int),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[2] ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_6 ));
(* SOFT_HLUTNM = "soft_lutpair106" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_tx_state[2]_i_7 
       (.I0(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[10] ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_7 ));
(* SOFT_HLUTNM = "soft_lutpair111" *) 
   LUT2 #(
    .INIT(4'hE)) 
     \FSM_onehot_tx_state[2]_i_8 
       (.I0(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[1] ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_8 ));
LUT6 #(
    .INIT(64'hFFFFFAA8FAA8FAA8)) 
     \FSM_onehot_tx_state[2]_i_9 
       (.I0(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[6] ),
        .O(\n_0_FSM_onehot_tx_state[2]_i_9 ));
LUT6 #(
    .INIT(64'h0000000000000100)) 
     \FSM_onehot_tx_state[3]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I4(\n_0_FSM_onehot_tx_state[3]_i_2 ),
        .I5(\n_0_FSM_onehot_tx_state[3]_i_3 ),
        .O(\n_0_FSM_onehot_tx_state[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair118" *) 
   LUT3 #(
    .INIT(8'hFE)) 
     \FSM_onehot_tx_state[3]_i_2 
       (.I0(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(run_phase_alignment_int),
        .O(\n_0_FSM_onehot_tx_state[3]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair108" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     \FSM_onehot_tx_state[3]_i_3 
       (.I0(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[7] ),
        .O(\n_0_FSM_onehot_tx_state[3]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair108" *) 
   LUT5 #(
    .INIT(32'h00020000)) 
     \FSM_onehot_tx_state[4]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I4(\n_0_FSM_onehot_tx_state[8]_i_2 ),
        .O(\n_0_FSM_onehot_tx_state[4]_i_1 ));
LUT6 #(
    .INIT(64'h0000010000000000)) 
     \FSM_onehot_tx_state[5]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I4(time_out_2ms),
        .I5(\n_0_FSM_onehot_tx_state[8]_i_2 ),
        .O(\n_0_FSM_onehot_tx_state[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair107" *) 
   LUT5 #(
    .INIT(32'h00100000)) 
     \FSM_onehot_tx_state[6]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I4(\n_0_FSM_onehot_tx_state[8]_i_2 ),
        .O(\n_0_FSM_onehot_tx_state[6]_i_1 ));
LUT6 #(
    .INIT(64'h0000FD0000000000)) 
     \FSM_onehot_tx_state[7]_i_1 
       (.I0(time_tlock_max),
        .I1(reset_time_out),
        .I2(mmcm_lock_reclocked),
        .I3(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I5(\n_0_FSM_onehot_tx_state[7]_i_2 ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_tx_state[7]_i_2 
       (.I0(\n_0_FSM_onehot_tx_state[3]_i_3 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I3(run_phase_alignment_int),
        .I4(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[10] ),
        .O(\n_0_FSM_onehot_tx_state[7]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair107" *) 
   LUT5 #(
    .INIT(32'h00040000)) 
     \FSM_onehot_tx_state[8]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I4(\n_0_FSM_onehot_tx_state[8]_i_2 ),
        .O(\n_0_FSM_onehot_tx_state[8]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_tx_state[8]_i_2 
       (.I0(n_0_tx_fsm_reset_done_int_i_2),
        .I1(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I3(run_phase_alignment_int),
        .I4(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[0] ),
        .O(\n_0_FSM_onehot_tx_state[8]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair106" *) 
   LUT5 #(
    .INIT(32'h51000000)) 
     \FSM_onehot_tx_state[9]_i_1 
       (.I0(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I1(time_out_500us),
        .I2(reset_time_out),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I4(\n_0_FSM_onehot_tx_state[9]_i_2 ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_1 ));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     \FSM_onehot_tx_state[9]_i_2 
       (.I0(run_phase_alignment_int),
        .I1(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I3(\n_0_FSM_onehot_tx_state[3]_i_3 ),
        .I4(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[1] ),
        .O(\n_0_FSM_onehot_tx_state[9]_i_2 ));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(tx_fsm_reset_done_int),
        .Q(\n_0_FSM_onehot_tx_state_reg[0] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[10] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[10]_i_2 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[10] ),
        .R(pma_reset));
FDSE #(
    .INIT(1'b1)) 
     \FSM_onehot_tx_state_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(1'b0),
        .Q(\n_0_FSM_onehot_tx_state_reg[1] ),
        .S(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[2]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[2] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[3]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[3] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[4]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[4] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[5]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[5] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[6]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[6] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[7]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[7] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[8]_i_1 ),
        .Q(\n_0_FSM_onehot_tx_state_reg[8] ),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     \FSM_onehot_tx_state_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_FSM_onehot_tx_state[10]_i_1 ),
        .D(\n_0_FSM_onehot_tx_state[9]_i_1 ),
        .Q(run_phase_alignment_int),
        .R(pma_reset));
(* SOFT_HLUTNM = "soft_lutpair118" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     TXUSERRDY_i_1
       (.I0(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I1(n_0_reset_time_out_i_5),
        .I2(TXUSERRDY),
        .O(n_0_TXUSERRDY_i_1));
FDRE #(
    .INIT(1'b0)) 
     TXUSERRDY_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_TXUSERRDY_i_1),
        .Q(TXUSERRDY),
        .R(pma_reset));
(* SOFT_HLUTNM = "soft_lutpair120" *) 
   LUT3 #(
    .INIT(8'hEA)) 
     gthe2_i_i_3
       (.I0(GTTXRESET),
        .I1(O1),
        .I2(reset_out),
        .O(gt0_gttxreset_in0_out));
LUT6 #(
    .INIT(64'h3333FFF733330000)) 
     gttxreset_i_i_1
       (.I0(n_0_gttxreset_i_i_2),
        .I1(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I4(\n_0_FSM_onehot_tx_state[3]_i_1 ),
        .I5(GTTXRESET),
        .O(n_0_gttxreset_i_i_1));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     gttxreset_i_i_2
       (.I0(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I2(\n_0_FSM_onehot_tx_state[3]_i_2 ),
        .I3(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[4] ),
        .O(n_0_gttxreset_i_i_2));
FDRE #(
    .INIT(1'b0)) 
     gttxreset_i_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_gttxreset_i_i_1),
        .Q(GTTXRESET),
        .R(pma_reset));
LUT1 #(
    .INIT(2'h1)) 
     \init_wait_count[0]_i_1 
       (.I0(init_wait_count_reg__0[0]),
        .O(\n_0_init_wait_count[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair121" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \init_wait_count[1]_i_1 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .O(p_0_in[1]));
(* SOFT_HLUTNM = "soft_lutpair117" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \init_wait_count[2]_i_1 
       (.I0(init_wait_count_reg__0[1]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[2]),
        .O(p_0_in[2]));
(* SOFT_HLUTNM = "soft_lutpair117" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \init_wait_count[3]_i_1 
       (.I0(init_wait_count_reg__0[2]),
        .I1(init_wait_count_reg__0[0]),
        .I2(init_wait_count_reg__0[1]),
        .I3(init_wait_count_reg__0[3]),
        .O(p_0_in[3]));
(* SOFT_HLUTNM = "soft_lutpair105" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \init_wait_count[4]_i_1 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[4]),
        .O(p_0_in[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \init_wait_count[5]_i_1 
       (.I0(init_wait_count_reg__0[4]),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[1]),
        .I4(init_wait_count_reg__0[3]),
        .I5(init_wait_count_reg__0[5]),
        .O(p_0_in[5]));
LUT6 #(
    .INIT(64'hFFFFFFFFFF7FFFFF)) 
     \init_wait_count[6]_i_1 
       (.I0(init_wait_count_reg__0[5]),
        .I1(init_wait_count_reg__0[6]),
        .I2(init_wait_count_reg__0[3]),
        .I3(init_wait_count_reg__0[4]),
        .I4(init_wait_count_reg__0[2]),
        .I5(\n_0_init_wait_count[6]_i_3 ),
        .O(\n_0_init_wait_count[6]_i_1 ));
LUT3 #(
    .INIT(8'hD2)) 
     \init_wait_count[6]_i_2 
       (.I0(init_wait_count_reg__0[5]),
        .I1(\n_0_init_wait_count[6]_i_4 ),
        .I2(init_wait_count_reg__0[6]),
        .O(p_0_in[6]));
(* SOFT_HLUTNM = "soft_lutpair121" *) 
   LUT2 #(
    .INIT(4'hB)) 
     \init_wait_count[6]_i_3 
       (.I0(init_wait_count_reg__0[0]),
        .I1(init_wait_count_reg__0[1]),
        .O(\n_0_init_wait_count[6]_i_3 ));
(* SOFT_HLUTNM = "soft_lutpair105" *) 
   LUT5 #(
    .INIT(32'h7FFFFFFF)) 
     \init_wait_count[6]_i_4 
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[1]),
        .I2(init_wait_count_reg__0[0]),
        .I3(init_wait_count_reg__0[2]),
        .I4(init_wait_count_reg__0[4]),
        .O(\n_0_init_wait_count[6]_i_4 ));
(* counter = "15" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(pma_reset),
        .D(\n_0_init_wait_count[0]_i_1 ),
        .Q(init_wait_count_reg__0[0]));
(* counter = "15" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(pma_reset),
        .D(p_0_in[1]),
        .Q(init_wait_count_reg__0[1]));
(* counter = "15" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(pma_reset),
        .D(p_0_in[2]),
        .Q(init_wait_count_reg__0[2]));
(* counter = "15" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(pma_reset),
        .D(p_0_in[3]),
        .Q(init_wait_count_reg__0[3]));
(* counter = "15" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(pma_reset),
        .D(p_0_in[4]),
        .Q(init_wait_count_reg__0[4]));
(* counter = "15" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(pma_reset),
        .D(p_0_in[5]),
        .Q(init_wait_count_reg__0[5]));
(* counter = "15" *) 
   FDCE #(
    .INIT(1'b0)) 
     \init_wait_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_init_wait_count[6]_i_1 ),
        .CLR(pma_reset),
        .D(p_0_in[6]),
        .Q(init_wait_count_reg__0[6]));
LUT6 #(
    .INIT(64'hFFFFFFFF00008000)) 
     init_wait_done_i_1
       (.I0(n_0_init_wait_done_i_2),
        .I1(init_wait_count_reg__0[2]),
        .I2(init_wait_count_reg__0[6]),
        .I3(init_wait_count_reg__0[5]),
        .I4(\n_0_init_wait_count[6]_i_3 ),
        .I5(init_wait_done),
        .O(n_0_init_wait_done_i_1));
LUT2 #(
    .INIT(4'h2)) 
     init_wait_done_i_2
       (.I0(init_wait_count_reg__0[3]),
        .I1(init_wait_count_reg__0[4]),
        .O(n_0_init_wait_done_i_2));
FDCE #(
    .INIT(1'b0)) 
     init_wait_done_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .CLR(pma_reset),
        .D(n_0_init_wait_done_i_1),
        .Q(init_wait_done));
LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[0]_i_1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .O(\n_0_mmcm_lock_count[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair119" *) 
   LUT2 #(
    .INIT(4'h6)) 
     \mmcm_lock_count[1]_i_1 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .O(p_0_in__1[1]));
(* SOFT_HLUTNM = "soft_lutpair119" *) 
   LUT3 #(
    .INIT(8'h78)) 
     \mmcm_lock_count[2]_i_1 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .O(p_0_in__1[2]));
(* SOFT_HLUTNM = "soft_lutpair115" *) 
   LUT4 #(
    .INIT(16'h7F80)) 
     \mmcm_lock_count[3]_i_1 
       (.I0(mmcm_lock_count_reg__0[2]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[1]),
        .I3(mmcm_lock_count_reg__0[3]),
        .O(p_0_in__1[3]));
(* SOFT_HLUTNM = "soft_lutpair115" *) 
   LUT5 #(
    .INIT(32'h7FFF8000)) 
     \mmcm_lock_count[4]_i_1 
       (.I0(mmcm_lock_count_reg__0[1]),
        .I1(mmcm_lock_count_reg__0[0]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[3]),
        .I4(mmcm_lock_count_reg__0[4]),
        .O(p_0_in__1[4]));
LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
     \mmcm_lock_count[5]_i_1 
       (.I0(mmcm_lock_count_reg__0[4]),
        .I1(mmcm_lock_count_reg__0[3]),
        .I2(mmcm_lock_count_reg__0[2]),
        .I3(mmcm_lock_count_reg__0[0]),
        .I4(mmcm_lock_count_reg__0[1]),
        .I5(mmcm_lock_count_reg__0[5]),
        .O(p_0_in__1[5]));
LUT2 #(
    .INIT(4'h9)) 
     \mmcm_lock_count[6]_i_1 
       (.I0(\n_0_mmcm_lock_count[9]_i_4 ),
        .I1(mmcm_lock_count_reg__0[6]),
        .O(p_0_in__1[6]));
(* SOFT_HLUTNM = "soft_lutpair116" *) 
   LUT3 #(
    .INIT(8'hD2)) 
     \mmcm_lock_count[7]_i_1 
       (.I0(mmcm_lock_count_reg__0[6]),
        .I1(\n_0_mmcm_lock_count[9]_i_4 ),
        .I2(mmcm_lock_count_reg__0[7]),
        .O(p_0_in__1[7]));
(* SOFT_HLUTNM = "soft_lutpair116" *) 
   LUT4 #(
    .INIT(16'hDF20)) 
     \mmcm_lock_count[8]_i_1 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[9]_i_4 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(mmcm_lock_count_reg__0[8]),
        .O(p_0_in__1[8]));
LUT1 #(
    .INIT(2'h1)) 
     \mmcm_lock_count[9]_i_1 
       (.I0(mmcm_lock_i),
        .O(\n_0_mmcm_lock_count[9]_i_1 ));
LUT5 #(
    .INIT(32'hDFFFFFFF)) 
     \mmcm_lock_count[9]_i_2 
       (.I0(mmcm_lock_count_reg__0[7]),
        .I1(\n_0_mmcm_lock_count[9]_i_4 ),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(mmcm_lock_count_reg__0[8]),
        .I4(mmcm_lock_count_reg__0[9]),
        .O(\n_0_mmcm_lock_count[9]_i_2 ));
(* SOFT_HLUTNM = "soft_lutpair114" *) 
   LUT5 #(
    .INIT(32'hF7FF0800)) 
     \mmcm_lock_count[9]_i_3 
       (.I0(mmcm_lock_count_reg__0[8]),
        .I1(mmcm_lock_count_reg__0[6]),
        .I2(\n_0_mmcm_lock_count[9]_i_4 ),
        .I3(mmcm_lock_count_reg__0[7]),
        .I4(mmcm_lock_count_reg__0[9]),
        .O(p_0_in__1[9]));
LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
     \mmcm_lock_count[9]_i_4 
       (.I0(mmcm_lock_count_reg__0[0]),
        .I1(mmcm_lock_count_reg__0[1]),
        .I2(mmcm_lock_count_reg__0[4]),
        .I3(mmcm_lock_count_reg__0[5]),
        .I4(mmcm_lock_count_reg__0[2]),
        .I5(mmcm_lock_count_reg__0[3]),
        .O(\n_0_mmcm_lock_count[9]_i_4 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(\n_0_mmcm_lock_count[0]_i_1 ),
        .Q(mmcm_lock_count_reg__0[0]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[1]),
        .Q(mmcm_lock_count_reg__0[1]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[2]),
        .Q(mmcm_lock_count_reg__0[2]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[3]),
        .Q(mmcm_lock_count_reg__0[3]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[4]),
        .Q(mmcm_lock_count_reg__0[4]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[5]),
        .Q(mmcm_lock_count_reg__0[5]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[6]),
        .Q(mmcm_lock_count_reg__0[6]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[7]),
        .Q(mmcm_lock_count_reg__0[7]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[8]),
        .Q(mmcm_lock_count_reg__0[8]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
(* counter = "24" *) 
   FDRE #(
    .INIT(1'b0)) 
     \mmcm_lock_count_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_mmcm_lock_count[9]_i_2 ),
        .D(p_0_in__1[9]),
        .Q(mmcm_lock_count_reg__0[9]),
        .R(\n_0_mmcm_lock_count[9]_i_1 ));
LUT3 #(
    .INIT(8'hE0)) 
     mmcm_lock_reclocked_i_1
       (.I0(mmcm_lock_reclocked),
        .I1(n_0_mmcm_lock_reclocked_i_2),
        .I2(mmcm_lock_i),
        .O(n_0_mmcm_lock_reclocked_i_1));
(* SOFT_HLUTNM = "soft_lutpair114" *) 
   LUT5 #(
    .INIT(32'h00800000)) 
     mmcm_lock_reclocked_i_2
       (.I0(mmcm_lock_count_reg__0[9]),
        .I1(mmcm_lock_count_reg__0[8]),
        .I2(mmcm_lock_count_reg__0[6]),
        .I3(\n_0_mmcm_lock_count[9]_i_4 ),
        .I4(mmcm_lock_count_reg__0[7]),
        .O(n_0_mmcm_lock_reclocked_i_2));
FDRE #(
    .INIT(1'b0)) 
     mmcm_lock_reclocked_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_mmcm_lock_reclocked_i_1),
        .Q(mmcm_lock_reclocked),
        .R(1'b0));
LUT5 #(
    .INIT(32'hF733F700)) 
     pll_reset_asserted_i_1
       (.I0(\n_0_FSM_onehot_tx_state[8]_i_2 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I2(\n_0_FSM_onehot_tx_state[10]_i_5 ),
        .I3(n_0_pll_reset_asserted_reg),
        .I4(\n_0_FSM_onehot_tx_state[3]_i_1 ),
        .O(n_0_pll_reset_asserted_i_1));
FDRE #(
    .INIT(1'b0)) 
     pll_reset_asserted_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_pll_reset_asserted_i_1),
        .Q(n_0_pll_reset_asserted_reg),
        .R(pma_reset));
LUT6 #(
    .INIT(64'hAAAAAAABAAAAAAA8)) 
     reset_time_out_i_1
       (.I0(reset_time_out_0),
        .I1(n_0_reset_time_out_i_3),
        .I2(n_0_reset_time_out_i_4),
        .I3(n_0_reset_time_out_i_5),
        .I4(n_0_reset_time_out_i_6),
        .I5(reset_time_out),
        .O(n_0_reset_time_out_i_1));
LUT5 #(
    .INIT(32'hCCAACCF0)) 
     reset_time_out_i_2
       (.I0(cplllock_sync),
        .I1(init_wait_done),
        .I2(n_0_reset_time_out_i_7),
        .I3(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[4] ),
        .O(reset_time_out_0));
LUT6 #(
    .INIT(64'h0001001400000000)) 
     reset_time_out_i_3
       (.I0(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I4(run_phase_alignment_int),
        .I5(n_0_tx_fsm_reset_done_int_i_3),
        .O(n_0_reset_time_out_i_3));
(* SOFT_HLUTNM = "soft_lutpair111" *) 
   LUT5 #(
    .INIT(32'h00001000)) 
     reset_time_out_i_4
       (.I0(\n_0_FSM_onehot_tx_state[3]_i_3 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I3(init_wait_done),
        .I4(\n_0_FSM_onehot_tx_state[2]_i_6 ),
        .O(n_0_reset_time_out_i_4));
LUT6 #(
    .INIT(64'hFFFFFFFF00000008)) 
     reset_time_out_i_5
       (.I0(n_0_tx_fsm_reset_done_int_i_3),
        .I1(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I2(run_phase_alignment_int),
        .I3(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I4(n_0_tx_fsm_reset_done_int_i_2),
        .I5(\n_0_FSM_onehot_tx_state[3]_i_1 ),
        .O(n_0_reset_time_out_i_5));
LUT6 #(
    .INIT(64'h0100000000000000)) 
     reset_time_out_i_6
       (.I0(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I4(cplllock_sync),
        .I5(\n_0_FSM_onehot_tx_state[8]_i_2 ),
        .O(n_0_reset_time_out_i_6));
LUT5 #(
    .INIT(32'hBBBBB888)) 
     reset_time_out_i_7
       (.I0(mmcm_lock_reclocked),
        .I1(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I2(txresetdone_s3),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[10] ),
        .O(n_0_reset_time_out_i_7));
FDRE #(
    .INIT(1'b0)) 
     reset_time_out_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_reset_time_out_i_1),
        .Q(reset_time_out),
        .R(pma_reset));
(* SOFT_HLUTNM = "soft_lutpair120" *) 
   LUT2 #(
    .INIT(4'h8)) 
     resetdone_INST_0
       (.I0(O1),
        .I1(O9),
        .O(resetdone));
LUT5 #(
    .INIT(32'hCCFFCC08)) 
     run_phase_alignment_int_i_1
       (.I0(n_0_tx_fsm_reset_done_int_i_3),
        .I1(run_phase_alignment_int),
        .I2(n_0_run_phase_alignment_int_i_2),
        .I3(\n_0_FSM_onehot_tx_state[3]_i_1 ),
        .I4(n_0_run_phase_alignment_int_reg),
        .O(n_0_run_phase_alignment_int_i_1));
(* SOFT_HLUTNM = "soft_lutpair112" *) 
   LUT4 #(
    .INIT(16'hFFFE)) 
     run_phase_alignment_int_i_2
       (.I0(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[8] ),
        .O(n_0_run_phase_alignment_int_i_2));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_run_phase_alignment_int_i_1),
        .Q(n_0_run_phase_alignment_int_reg),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     run_phase_alignment_int_s3_reg
       (.C(userclk),
        .CE(1'b1),
        .D(data_out),
        .Q(run_phase_alignment_int_s3),
        .R(1'b0));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__26 sync_TXRESETDONE
       (.clk(independent_clock_bufg),
        .data_in(I1),
        .data_out(txresetdone_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__29 sync_cplllock
       (.clk(independent_clock_bufg),
        .data_in(cplllock),
        .data_out(cplllock_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__30 sync_cpllrefclklost
       (.clk(independent_clock_bufg),
        .data_in(CPLLREFCLKLOST),
        .data_out(NLW_sync_cpllrefclklost_data_out_UNCONNECTED));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__28 sync_mmcm_lock_reclocked
       (.clk(independent_clock_bufg),
        .data_in(mmcm_locked),
        .data_out(mmcm_lock_i));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__24 sync_run_phase_alignment_int
       (.clk(userclk),
        .data_in(n_0_run_phase_alignment_int_reg),
        .data_out(data_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__27 sync_time_out_wait_bypass
       (.clk(independent_clock_bufg),
        .data_in(n_0_time_out_wait_bypass_reg),
        .data_out(time_out_wait_bypass_s2));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__25 sync_tx_fsm_reset_done_int
       (.clk(userclk),
        .data_in(O1),
        .data_out(tx_fsm_reset_done_int_s2));
LUT4 #(
    .INIT(16'h00AE)) 
     time_out_2ms_i_1__0
       (.I0(time_out_2ms),
        .I1(n_0_time_out_2ms_i_2),
        .I2(\n_0_time_out_counter[0]_i_5 ),
        .I3(reset_time_out),
        .O(n_0_time_out_2ms_i_1__0));
LUT6 #(
    .INIT(64'h0000000000000800)) 
     time_out_2ms_i_2
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[18]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[12]),
        .I4(time_out_counter_reg[5]),
        .I5(\n_0_time_out_counter[0]_i_3 ),
        .O(n_0_time_out_2ms_i_2));
FDRE #(
    .INIT(1'b0)) 
     time_out_2ms_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_out_2ms_i_1__0),
        .Q(time_out_2ms),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000AAAAAAAE)) 
     time_out_500us_i_1
       (.I0(time_out_500us),
        .I1(n_0_time_out_500us_i_2),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[18]),
        .I4(\n_0_time_out_counter[0]_i_5 ),
        .I5(reset_time_out),
        .O(n_0_time_out_500us_i_1));
LUT6 #(
    .INIT(64'h0040000000000000)) 
     time_out_500us_i_2
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[10]),
        .I2(time_out_counter_reg[5]),
        .I3(time_out_counter_reg[11]),
        .I4(time_out_counter_reg[15]),
        .I5(time_out_counter_reg[16]),
        .O(n_0_time_out_500us_i_2));
FDRE #(
    .INIT(1'b0)) 
     time_out_500us_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_out_500us_i_1),
        .Q(time_out_500us),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFBFFFF)) 
     \time_out_counter[0]_i_1 
       (.I0(\n_0_time_out_counter[0]_i_3 ),
        .I1(\n_0_time_out_counter[0]_i_4 ),
        .I2(\n_0_time_out_counter[0]_i_5 ),
        .I3(time_out_counter_reg[10]),
        .I4(time_out_counter_reg[12]),
        .I5(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[0]_i_1 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \time_out_counter[0]_i_10__0 
       (.I0(time_out_counter_reg[2]),
        .I1(time_out_counter_reg[1]),
        .I2(time_out_counter_reg[6]),
        .I3(time_out_counter_reg[8]),
        .I4(time_out_counter_reg[3]),
        .I5(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[0]_i_10__0 ));
LUT3 #(
    .INIT(8'hEF)) 
     \time_out_counter[0]_i_3 
       (.I0(time_out_counter_reg[16]),
        .I1(time_out_counter_reg[15]),
        .I2(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[0]_i_3 ));
LUT2 #(
    .INIT(4'h8)) 
     \time_out_counter[0]_i_4 
       (.I0(time_out_counter_reg[17]),
        .I1(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[0]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFDFFFF)) 
     \time_out_counter[0]_i_5 
       (.I0(time_out_counter_reg[7]),
        .I1(time_out_counter_reg[14]),
        .I2(\n_0_time_out_counter[0]_i_10__0 ),
        .I3(time_out_counter_reg[13]),
        .I4(time_out_counter_reg[9]),
        .I5(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_6 
       (.I0(time_out_counter_reg[3]),
        .O(\n_0_time_out_counter[0]_i_6 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_7 
       (.I0(time_out_counter_reg[2]),
        .O(\n_0_time_out_counter[0]_i_7 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[0]_i_8__0 
       (.I0(time_out_counter_reg[1]),
        .O(\n_0_time_out_counter[0]_i_8__0 ));
LUT1 #(
    .INIT(2'h1)) 
     \time_out_counter[0]_i_9 
       (.I0(time_out_counter_reg[0]),
        .O(\n_0_time_out_counter[0]_i_9 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_2 
       (.I0(time_out_counter_reg[15]),
        .O(\n_0_time_out_counter[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_3 
       (.I0(time_out_counter_reg[14]),
        .O(\n_0_time_out_counter[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_4 
       (.I0(time_out_counter_reg[13]),
        .O(\n_0_time_out_counter[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[12]_i_5 
       (.I0(time_out_counter_reg[12]),
        .O(\n_0_time_out_counter[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_2 
       (.I0(time_out_counter_reg[18]),
        .O(\n_0_time_out_counter[16]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_3 
       (.I0(time_out_counter_reg[17]),
        .O(\n_0_time_out_counter[16]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[16]_i_4 
       (.I0(time_out_counter_reg[16]),
        .O(\n_0_time_out_counter[16]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_2 
       (.I0(time_out_counter_reg[7]),
        .O(\n_0_time_out_counter[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_3 
       (.I0(time_out_counter_reg[6]),
        .O(\n_0_time_out_counter[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_4 
       (.I0(time_out_counter_reg[5]),
        .O(\n_0_time_out_counter[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[4]_i_5 
       (.I0(time_out_counter_reg[4]),
        .O(\n_0_time_out_counter[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_2 
       (.I0(time_out_counter_reg[11]),
        .O(\n_0_time_out_counter[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_3 
       (.I0(time_out_counter_reg[10]),
        .O(\n_0_time_out_counter[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_4 
       (.I0(time_out_counter_reg[9]),
        .O(\n_0_time_out_counter[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \time_out_counter[8]_i_5 
       (.I0(time_out_counter_reg[8]),
        .O(\n_0_time_out_counter[8]_i_5 ));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[0] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[0]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\n_0_time_out_counter_reg[0]_i_2 ,\n_1_time_out_counter_reg[0]_i_2 ,\n_2_time_out_counter_reg[0]_i_2 ,\n_3_time_out_counter_reg[0]_i_2 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_time_out_counter_reg[0]_i_2 ,\n_5_time_out_counter_reg[0]_i_2 ,\n_6_time_out_counter_reg[0]_i_2 ,\n_7_time_out_counter_reg[0]_i_2 }),
        .S({\n_0_time_out_counter[0]_i_6 ,\n_0_time_out_counter[0]_i_7 ,\n_0_time_out_counter[0]_i_8__0 ,\n_0_time_out_counter[0]_i_9 }));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[10] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[10]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[11] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[11]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[12] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[12]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[12]_i_1 
       (.CI(\n_0_time_out_counter_reg[8]_i_1 ),
        .CO({\n_0_time_out_counter_reg[12]_i_1 ,\n_1_time_out_counter_reg[12]_i_1 ,\n_2_time_out_counter_reg[12]_i_1 ,\n_3_time_out_counter_reg[12]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[12]_i_1 ,\n_5_time_out_counter_reg[12]_i_1 ,\n_6_time_out_counter_reg[12]_i_1 ,\n_7_time_out_counter_reg[12]_i_1 }),
        .S({\n_0_time_out_counter[12]_i_2 ,\n_0_time_out_counter[12]_i_3 ,\n_0_time_out_counter[12]_i_4 ,\n_0_time_out_counter[12]_i_5 }));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[13] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[13]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[14] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[14]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[15] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[12]_i_1 ),
        .Q(time_out_counter_reg[15]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[16] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[16]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[16]_i_1 
       (.CI(\n_0_time_out_counter_reg[12]_i_1 ),
        .CO({\NLW_time_out_counter_reg[16]_i_1_CO_UNCONNECTED [3:2],\n_2_time_out_counter_reg[16]_i_1 ,\n_3_time_out_counter_reg[16]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_time_out_counter_reg[16]_i_1_O_UNCONNECTED [3],\n_5_time_out_counter_reg[16]_i_1 ,\n_6_time_out_counter_reg[16]_i_1 ,\n_7_time_out_counter_reg[16]_i_1 }),
        .S({1'b0,\n_0_time_out_counter[16]_i_2 ,\n_0_time_out_counter[16]_i_3 ,\n_0_time_out_counter[16]_i_4 }));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[17] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[17]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[18] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[16]_i_1 ),
        .Q(time_out_counter_reg[18]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[1] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[1]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[2] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[2]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[3] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[0]_i_2 ),
        .Q(time_out_counter_reg[3]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[4] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[4]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[4]_i_1 
       (.CI(\n_0_time_out_counter_reg[0]_i_2 ),
        .CO({\n_0_time_out_counter_reg[4]_i_1 ,\n_1_time_out_counter_reg[4]_i_1 ,\n_2_time_out_counter_reg[4]_i_1 ,\n_3_time_out_counter_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[4]_i_1 ,\n_5_time_out_counter_reg[4]_i_1 ,\n_6_time_out_counter_reg[4]_i_1 ,\n_7_time_out_counter_reg[4]_i_1 }),
        .S({\n_0_time_out_counter[4]_i_2 ,\n_0_time_out_counter[4]_i_3 ,\n_0_time_out_counter[4]_i_4 ,\n_0_time_out_counter[4]_i_5 }));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[5] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[5]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[6] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_5_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[6]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[7] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_4_time_out_counter_reg[4]_i_1 ),
        .Q(time_out_counter_reg[7]),
        .R(reset_time_out));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[8] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_7_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[8]),
        .R(reset_time_out));
CARRY4 \time_out_counter_reg[8]_i_1 
       (.CI(\n_0_time_out_counter_reg[4]_i_1 ),
        .CO({\n_0_time_out_counter_reg[8]_i_1 ,\n_1_time_out_counter_reg[8]_i_1 ,\n_2_time_out_counter_reg[8]_i_1 ,\n_3_time_out_counter_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_time_out_counter_reg[8]_i_1 ,\n_5_time_out_counter_reg[8]_i_1 ,\n_6_time_out_counter_reg[8]_i_1 ,\n_7_time_out_counter_reg[8]_i_1 }),
        .S({\n_0_time_out_counter[8]_i_2 ,\n_0_time_out_counter[8]_i_3 ,\n_0_time_out_counter[8]_i_4 ,\n_0_time_out_counter[8]_i_5 }));
(* counter = "17" *) 
   FDRE #(
    .INIT(1'b0)) 
     \time_out_counter_reg[9] 
       (.C(independent_clock_bufg),
        .CE(\n_0_time_out_counter[0]_i_1 ),
        .D(\n_6_time_out_counter_reg[8]_i_1 ),
        .Q(time_out_counter_reg[9]),
        .R(reset_time_out));
LUT6 #(
    .INIT(64'hFF00FF0100000000)) 
     time_out_wait_bypass_i_1
       (.I0(\n_0_wait_bypass_count[0]_i_4 ),
        .I1(\n_0_wait_bypass_count[0]_i_5 ),
        .I2(\n_0_wait_bypass_count[0]_i_6 ),
        .I3(n_0_time_out_wait_bypass_reg),
        .I4(tx_fsm_reset_done_int_s3),
        .I5(run_phase_alignment_int_s3),
        .O(n_0_time_out_wait_bypass_i_1));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_reg
       (.C(userclk),
        .CE(1'b1),
        .D(n_0_time_out_wait_bypass_i_1),
        .Q(n_0_time_out_wait_bypass_reg),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     time_out_wait_bypass_s3_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(time_out_wait_bypass_s2),
        .Q(time_out_wait_bypass_s3),
        .R(1'b0));
LUT6 #(
    .INIT(64'h00000000AAAAAAAE)) 
     time_tlock_max_i_1
       (.I0(time_tlock_max),
        .I1(n_0_time_tlock_max_i_2),
        .I2(time_out_counter_reg[17]),
        .I3(time_out_counter_reg[18]),
        .I4(n_0_time_tlock_max_i_3),
        .I5(reset_time_out),
        .O(n_0_time_tlock_max_i_1));
LUT6 #(
    .INIT(64'h0000000000400000)) 
     time_tlock_max_i_2
       (.I0(time_out_counter_reg[12]),
        .I1(time_out_counter_reg[14]),
        .I2(time_out_counter_reg[10]),
        .I3(time_out_counter_reg[7]),
        .I4(time_out_counter_reg[5]),
        .I5(\n_0_time_out_counter[0]_i_3 ),
        .O(n_0_time_tlock_max_i_2));
LUT4 #(
    .INIT(16'hFFFB)) 
     time_tlock_max_i_3
       (.I0(time_out_counter_reg[0]),
        .I1(time_out_counter_reg[9]),
        .I2(time_out_counter_reg[13]),
        .I3(\n_0_time_out_counter[0]_i_10__0 ),
        .O(n_0_time_tlock_max_i_3));
FDRE #(
    .INIT(1'b0)) 
     time_tlock_max_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_time_tlock_max_i_1),
        .Q(time_tlock_max),
        .R(1'b0));
LUT6 #(
    .INIT(64'hFFFFFFFF00001000)) 
     tx_fsm_reset_done_int_i_1
       (.I0(run_phase_alignment_int),
        .I1(n_0_tx_fsm_reset_done_int_i_2),
        .I2(n_0_tx_fsm_reset_done_int_i_3),
        .I3(\n_0_FSM_onehot_tx_state_reg[10] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[8] ),
        .I5(O1),
        .O(n_0_tx_fsm_reset_done_int_i_1));
(* SOFT_HLUTNM = "soft_lutpair113" *) 
   LUT2 #(
    .INIT(4'hE)) 
     tx_fsm_reset_done_int_i_2
       (.I0(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[6] ),
        .O(n_0_tx_fsm_reset_done_int_i_2));
LUT6 #(
    .INIT(64'h0000000000000001)) 
     tx_fsm_reset_done_int_i_3
       (.I0(\n_0_FSM_onehot_tx_state_reg[1] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[0] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[7] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I4(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I5(\n_0_FSM_onehot_tx_state_reg[4] ),
        .O(n_0_tx_fsm_reset_done_int_i_3));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(n_0_tx_fsm_reset_done_int_i_1),
        .Q(O1),
        .R(pma_reset));
FDRE #(
    .INIT(1'b0)) 
     tx_fsm_reset_done_int_s3_reg
       (.C(userclk),
        .CE(1'b1),
        .D(tx_fsm_reset_done_int_s2),
        .Q(tx_fsm_reset_done_int_s3),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     txresetdone_s3_reg
       (.C(independent_clock_bufg),
        .CE(1'b1),
        .D(txresetdone_s2),
        .Q(txresetdone_s3),
        .R(1'b0));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_1 
       (.I0(run_phase_alignment_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_1 ));
LUT1 #(
    .INIT(2'h1)) 
     \wait_bypass_count[0]_i_10 
       (.I0(wait_bypass_count_reg[0]),
        .O(\n_0_wait_bypass_count[0]_i_10 ));
LUT4 #(
    .INIT(16'h00FE)) 
     \wait_bypass_count[0]_i_2 
       (.I0(\n_0_wait_bypass_count[0]_i_4 ),
        .I1(\n_0_wait_bypass_count[0]_i_5 ),
        .I2(\n_0_wait_bypass_count[0]_i_6 ),
        .I3(tx_fsm_reset_done_int_s3),
        .O(\n_0_wait_bypass_count[0]_i_2 ));
LUT5 #(
    .INIT(32'h7FFFFFFF)) 
     \wait_bypass_count[0]_i_4 
       (.I0(wait_bypass_count_reg[4]),
        .I1(wait_bypass_count_reg[9]),
        .I2(wait_bypass_count_reg[0]),
        .I3(wait_bypass_count_reg[2]),
        .I4(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_4 ));
LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_5 
       (.I0(wait_bypass_count_reg[7]),
        .I1(wait_bypass_count_reg[15]),
        .I2(wait_bypass_count_reg[10]),
        .I3(wait_bypass_count_reg[6]),
        .I4(wait_bypass_count_reg[13]),
        .I5(wait_bypass_count_reg[14]),
        .O(\n_0_wait_bypass_count[0]_i_5 ));
LUT6 #(
    .INIT(64'hFDFFFFFFFFFFFFFF)) 
     \wait_bypass_count[0]_i_6 
       (.I0(wait_bypass_count_reg[1]),
        .I1(wait_bypass_count_reg[11]),
        .I2(wait_bypass_count_reg[8]),
        .I3(wait_bypass_count_reg[12]),
        .I4(wait_bypass_count_reg[5]),
        .I5(wait_bypass_count_reg[16]),
        .O(\n_0_wait_bypass_count[0]_i_6 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_7 
       (.I0(wait_bypass_count_reg[3]),
        .O(\n_0_wait_bypass_count[0]_i_7 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_8 
       (.I0(wait_bypass_count_reg[2]),
        .O(\n_0_wait_bypass_count[0]_i_8 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[0]_i_9__0 
       (.I0(wait_bypass_count_reg[1]),
        .O(\n_0_wait_bypass_count[0]_i_9__0 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_2 
       (.I0(wait_bypass_count_reg[15]),
        .O(\n_0_wait_bypass_count[12]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_3 
       (.I0(wait_bypass_count_reg[14]),
        .O(\n_0_wait_bypass_count[12]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_4 
       (.I0(wait_bypass_count_reg[13]),
        .O(\n_0_wait_bypass_count[12]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[12]_i_5 
       (.I0(wait_bypass_count_reg[12]),
        .O(\n_0_wait_bypass_count[12]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[16]_i_2 
       (.I0(wait_bypass_count_reg[16]),
        .O(\n_0_wait_bypass_count[16]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_2 
       (.I0(wait_bypass_count_reg[7]),
        .O(\n_0_wait_bypass_count[4]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_3 
       (.I0(wait_bypass_count_reg[6]),
        .O(\n_0_wait_bypass_count[4]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_4 
       (.I0(wait_bypass_count_reg[5]),
        .O(\n_0_wait_bypass_count[4]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[4]_i_5 
       (.I0(wait_bypass_count_reg[4]),
        .O(\n_0_wait_bypass_count[4]_i_5 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_2 
       (.I0(wait_bypass_count_reg[11]),
        .O(\n_0_wait_bypass_count[8]_i_2 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_3 
       (.I0(wait_bypass_count_reg[10]),
        .O(\n_0_wait_bypass_count[8]_i_3 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_4 
       (.I0(wait_bypass_count_reg[9]),
        .O(\n_0_wait_bypass_count[8]_i_4 ));
LUT1 #(
    .INIT(2'h2)) 
     \wait_bypass_count[8]_i_5 
       (.I0(wait_bypass_count_reg[8]),
        .O(\n_0_wait_bypass_count[8]_i_5 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[0] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[0]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\n_0_wait_bypass_count_reg[0]_i_3 ,\n_1_wait_bypass_count_reg[0]_i_3 ,\n_2_wait_bypass_count_reg[0]_i_3 ,\n_3_wait_bypass_count_reg[0]_i_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\n_4_wait_bypass_count_reg[0]_i_3 ,\n_5_wait_bypass_count_reg[0]_i_3 ,\n_6_wait_bypass_count_reg[0]_i_3 ,\n_7_wait_bypass_count_reg[0]_i_3 }),
        .S({\n_0_wait_bypass_count[0]_i_7 ,\n_0_wait_bypass_count[0]_i_8 ,\n_0_wait_bypass_count[0]_i_9__0 ,\n_0_wait_bypass_count[0]_i_10 }));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[10] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[10]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[11] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[11]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[12] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[12]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[12]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[8]_i_1 ),
        .CO({\n_0_wait_bypass_count_reg[12]_i_1 ,\n_1_wait_bypass_count_reg[12]_i_1 ,\n_2_wait_bypass_count_reg[12]_i_1 ,\n_3_wait_bypass_count_reg[12]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[12]_i_1 ,\n_5_wait_bypass_count_reg[12]_i_1 ,\n_6_wait_bypass_count_reg[12]_i_1 ,\n_7_wait_bypass_count_reg[12]_i_1 }),
        .S({\n_0_wait_bypass_count[12]_i_2 ,\n_0_wait_bypass_count[12]_i_3 ,\n_0_wait_bypass_count[12]_i_4 ,\n_0_wait_bypass_count[12]_i_5 }));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[13] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[13]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[14] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[14]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[15] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[12]_i_1 ),
        .Q(wait_bypass_count_reg[15]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[16] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[16]_i_1 ),
        .Q(wait_bypass_count_reg[16]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[16]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[12]_i_1 ),
        .CO(\NLW_wait_bypass_count_reg[16]_i_1_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_wait_bypass_count_reg[16]_i_1_O_UNCONNECTED [3:1],\n_7_wait_bypass_count_reg[16]_i_1 }),
        .S({1'b0,1'b0,1'b0,\n_0_wait_bypass_count[16]_i_2 }));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[1] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[1]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[2] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[2]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[3] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[0]_i_3 ),
        .Q(wait_bypass_count_reg[3]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[4] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[4]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[4]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[0]_i_3 ),
        .CO({\n_0_wait_bypass_count_reg[4]_i_1 ,\n_1_wait_bypass_count_reg[4]_i_1 ,\n_2_wait_bypass_count_reg[4]_i_1 ,\n_3_wait_bypass_count_reg[4]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[4]_i_1 ,\n_5_wait_bypass_count_reg[4]_i_1 ,\n_6_wait_bypass_count_reg[4]_i_1 ,\n_7_wait_bypass_count_reg[4]_i_1 }),
        .S({\n_0_wait_bypass_count[4]_i_2 ,\n_0_wait_bypass_count[4]_i_3 ,\n_0_wait_bypass_count[4]_i_4 ,\n_0_wait_bypass_count[4]_i_5 }));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[5] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[5]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[6] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_5_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[6]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[7] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_4_wait_bypass_count_reg[4]_i_1 ),
        .Q(wait_bypass_count_reg[7]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[8] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_7_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[8]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
CARRY4 \wait_bypass_count_reg[8]_i_1 
       (.CI(\n_0_wait_bypass_count_reg[4]_i_1 ),
        .CO({\n_0_wait_bypass_count_reg[8]_i_1 ,\n_1_wait_bypass_count_reg[8]_i_1 ,\n_2_wait_bypass_count_reg[8]_i_1 ,\n_3_wait_bypass_count_reg[8]_i_1 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\n_4_wait_bypass_count_reg[8]_i_1 ,\n_5_wait_bypass_count_reg[8]_i_1 ,\n_6_wait_bypass_count_reg[8]_i_1 ,\n_7_wait_bypass_count_reg[8]_i_1 }),
        .S({\n_0_wait_bypass_count[8]_i_2 ,\n_0_wait_bypass_count[8]_i_3 ,\n_0_wait_bypass_count[8]_i_4 ,\n_0_wait_bypass_count[8]_i_5 }));
(* counter = "18" *) 
   FDRE \wait_bypass_count_reg[9] 
       (.C(userclk),
        .CE(\n_0_wait_bypass_count[0]_i_2 ),
        .D(\n_6_wait_bypass_count_reg[8]_i_1 ),
        .Q(wait_bypass_count_reg[9]),
        .R(\n_0_wait_bypass_count[0]_i_1 ));
(* RETAIN_INVERTER *) 
   (* SOFT_HLUTNM = "soft_lutpair122" *) 
   LUT1 #(
    .INIT(2'h1)) 
     \wait_time_cnt[0]_i_1 
       (.I0(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[0]));
(* SOFT_HLUTNM = "soft_lutpair122" *) 
   LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[1]_i_1 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[1]));
LUT3 #(
    .INIT(8'hA9)) 
     \wait_time_cnt[2]_i_1 
       (.I0(wait_time_cnt_reg__0[2]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0[2]));
(* SOFT_HLUTNM = "soft_lutpair109" *) 
   LUT4 #(
    .INIT(16'hFE01)) 
     \wait_time_cnt[3]_i_1 
       (.I0(wait_time_cnt_reg__0[1]),
        .I1(wait_time_cnt_reg__0[0]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[3]),
        .O(wait_time_cnt0[3]));
(* SOFT_HLUTNM = "soft_lutpair109" *) 
   LUT5 #(
    .INIT(32'hAAAAAAA9)) 
     \wait_time_cnt[4]_i_1 
       (.I0(wait_time_cnt_reg__0[4]),
        .I1(wait_time_cnt_reg__0[3]),
        .I2(wait_time_cnt_reg__0[2]),
        .I3(wait_time_cnt_reg__0[0]),
        .I4(wait_time_cnt_reg__0[1]),
        .O(wait_time_cnt0[4]));
LUT6 #(
    .INIT(64'hF0F0F0F0F0F0F0E1)) 
     \wait_time_cnt[5]_i_1 
       (.I0(wait_time_cnt_reg__0[3]),
        .I1(wait_time_cnt_reg__0[2]),
        .I2(wait_time_cnt_reg__0[5]),
        .I3(wait_time_cnt_reg__0[4]),
        .I4(wait_time_cnt_reg__0[1]),
        .I5(wait_time_cnt_reg__0[0]),
        .O(wait_time_cnt0[5]));
LUT6 #(
    .INIT(64'h000000001F1C1110)) 
     \wait_time_cnt[6]_i_1 
       (.I0(\n_0_wait_time_cnt[6]_i_4 ),
        .I1(\n_0_FSM_onehot_tx_state_reg[4] ),
        .I2(\n_0_FSM_onehot_tx_state_reg[6] ),
        .I3(\n_0_FSM_onehot_tx_state_reg[2] ),
        .I4(\n_0_wait_time_cnt[6]_i_5 ),
        .I5(\n_0_FSM_onehot_tx_state[3]_i_2 ),
        .O(clear));
LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_2 
       (.I0(\n_0_wait_time_cnt[6]_i_6 ),
        .I1(wait_time_cnt_reg__0[6]),
        .O(sel));
LUT2 #(
    .INIT(4'h9)) 
     \wait_time_cnt[6]_i_3 
       (.I0(wait_time_cnt_reg__0[6]),
        .I1(\n_0_wait_time_cnt[6]_i_6 ),
        .O(wait_time_cnt0[6]));
LUT2 #(
    .INIT(4'hE)) 
     \wait_time_cnt[6]_i_4 
       (.I0(\n_0_FSM_onehot_tx_state_reg[3] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .O(\n_0_wait_time_cnt[6]_i_4 ));
(* SOFT_HLUTNM = "soft_lutpair123" *) 
   LUT2 #(
    .INIT(4'h1)) 
     \wait_time_cnt[6]_i_5 
       (.I0(\n_0_FSM_onehot_tx_state_reg[5] ),
        .I1(\n_0_FSM_onehot_tx_state_reg[7] ),
        .O(\n_0_wait_time_cnt[6]_i_5 ));
LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
     \wait_time_cnt[6]_i_6 
       (.I0(wait_time_cnt_reg__0[0]),
        .I1(wait_time_cnt_reg__0[1]),
        .I2(wait_time_cnt_reg__0[4]),
        .I3(wait_time_cnt_reg__0[5]),
        .I4(wait_time_cnt_reg__0[2]),
        .I5(wait_time_cnt_reg__0[3]),
        .O(\n_0_wait_time_cnt[6]_i_6 ));
(* counter = "16" *) 
   FDRE \wait_time_cnt_reg[0] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[0]),
        .Q(wait_time_cnt_reg__0[0]),
        .R(clear));
(* counter = "16" *) 
   FDRE \wait_time_cnt_reg[1] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[1]),
        .Q(wait_time_cnt_reg__0[1]),
        .R(clear));
(* counter = "16" *) 
   FDSE \wait_time_cnt_reg[2] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[2]),
        .Q(wait_time_cnt_reg__0[2]),
        .S(clear));
(* counter = "16" *) 
   FDRE \wait_time_cnt_reg[3] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[3]),
        .Q(wait_time_cnt_reg__0[3]),
        .R(clear));
(* counter = "16" *) 
   FDRE \wait_time_cnt_reg[4] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[4]),
        .Q(wait_time_cnt_reg__0[4]),
        .R(clear));
(* counter = "16" *) 
   FDSE \wait_time_cnt_reg[5] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[5]),
        .Q(wait_time_cnt_reg__0[5]),
        .S(clear));
(* counter = "16" *) 
   FDSE \wait_time_cnt_reg[6] 
       (.C(independent_clock_bufg),
        .CE(sel),
        .D(wait_time_cnt0[6]),
        .Q(wait_time_cnt_reg__0[6]),
        .S(clear));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_block" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_block
   (gt0_drprdy_out,
    status_vector,
    gmii_isolate,
    gt0_rxnotintable_out,
    gmii_rxd,
    gmii_rx_er,
    gt0_rxdisperr_out,
    cplllock,
    gt0_eyescandataerror_out,
    txn,
    txp,
    gt0_rxbyteisaligned_out,
    gt0_rxbyterealign_out,
    gt0_rxcommadet_out,
    gt0_rxpmaresetdone_out,
    gt0_rxprbserr_out,
    txoutclk,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    gt0_rxmonitorout_out,
    O1,
    O2,
    gt0_rxchariscomma_out,
    gt0_rxcharisk_out,
    resetdone,
    rxoutclk,
    gmii_rx_dv,
    an_interrupt,
    userclk2,
    reset,
    mmcm_locked,
    an_restart_config,
    gmii_txd,
    signal_detect,
    gmii_tx_en,
    gmii_tx_er,
    configuration_vector,
    userclk,
    independent_clock_bufg,
    gt0_drpclk_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    rxn,
    rxp,
    gtrefclk,
    gt0_qplloutclk_in,
    gt0_qplloutrefclk_in,
    gt0_rxbufreset_in,
    gt0_rxcdrhold_in,
    gt0_rxdfeagcovrden_in,
    gt0_rxdfelpmreset_in,
    gt0_rxlpmen_in,
    gt0_rxpcsreset_in,
    gt0_rxpolarity_in,
    gt0_rxprbscntreset_in,
    gt0_txpcsreset_in,
    gt0_txpmareset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_rxmonitorsel_in,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txprbssel_in,
    gt0_txdiffctrl_in,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    gt0_rxpmareset_in,
    pma_reset,
    rxuserclk,
    an_adv_config_vector,
    gt0_drpdi_in,
    gt0_drpwe_in,
    gt0_drpen_in,
    gt0_drpaddr_in);
  output gt0_drprdy_out;
  output [12:0]status_vector;
  output gmii_isolate;
  output [0:0]gt0_rxnotintable_out;
  output [7:0]gmii_rxd;
  output gmii_rx_er;
  output [0:0]gt0_rxdisperr_out;
  output cplllock;
  output gt0_eyescandataerror_out;
  output txn;
  output txp;
  output gt0_rxbyteisaligned_out;
  output gt0_rxbyterealign_out;
  output gt0_rxcommadet_out;
  output gt0_rxpmaresetdone_out;
  output gt0_rxprbserr_out;
  output txoutclk;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [6:0]gt0_rxmonitorout_out;
  output O1;
  output O2;
  output [0:0]gt0_rxchariscomma_out;
  output [0:0]gt0_rxcharisk_out;
  output resetdone;
  output rxoutclk;
  output gmii_rx_dv;
  output an_interrupt;
  input userclk2;
  input reset;
  input mmcm_locked;
  input an_restart_config;
  input [7:0]gmii_txd;
  input signal_detect;
  input gmii_tx_en;
  input gmii_tx_er;
  input [4:0]configuration_vector;
  input userclk;
  input independent_clock_bufg;
  input gt0_drpclk_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input rxn;
  input rxp;
  input gtrefclk;
  input gt0_qplloutclk_in;
  input gt0_qplloutrefclk_in;
  input gt0_rxbufreset_in;
  input gt0_rxcdrhold_in;
  input gt0_rxdfeagcovrden_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxlpmen_in;
  input gt0_rxpcsreset_in;
  input gt0_rxpolarity_in;
  input gt0_rxprbscntreset_in;
  input gt0_txpcsreset_in;
  input gt0_txpmareset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input [1:0]gt0_rxmonitorsel_in;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_txprbssel_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input gt0_rxpmareset_in;
  input pma_reset;
  input rxuserclk;
  input [6:0]an_adv_config_vector;
  input [15:0]gt0_drpdi_in;
  input gt0_drpwe_in;
  input gt0_drpen_in;
  input [8:0]gt0_drpaddr_in;

  wire I;
  wire O1;
  wire O2;
  wire [6:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire cplllock;
  wire data_out;
  wire encommaalign;
  wire gmii_isolate;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drprdy_out;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire [2:0]gt0_loopback_in;
  wire gt0_qplloutclk_in;
  wire gt0_qplloutrefclk_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire gt0_rxbyteisaligned_out;
  wire gt0_rxbyterealign_out;
  wire gt0_rxcdrhold_in;
  wire [0:0]gt0_rxchariscomma_out;
  wire [0:0]gt0_rxcharisk_out;
  wire gt0_rxcommadet_out;
  wire gt0_rxdfeagcovrden_in;
  wire gt0_rxdfelpmreset_in;
  wire [0:0]gt0_rxdisperr_out;
  wire gt0_rxlpmen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire [0:0]gt0_rxnotintable_out;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpmaresetdone_out;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txpcsreset_in;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gtrefclk;
  wire independent_clock_bufg;
  wire mmcm_locked;
  wire n_0_rxrecclkbufmr;
  wire n_24_gig_ethernet_pcs_pma_1_core;
  wire pma_reset;
  wire powerdown;
  wire reset;
  wire resetdone;
  wire rxbuferr;
  wire [1:0]rxclkcorcnt;
  wire [7:0]rxdata;
  wire rxn;
  wire rxoutclk;
  wire rxp;
  wire rxreset;
  wire rxuserclk;
  wire signal_detect;
  wire [12:0]status_vector;
  wire toggle;
  wire txbuferr;
  wire txchardispmode;
  wire txchardispval;
  wire txcharisk;
  wire [7:0]txdata;
  wire txn;
  wire txoutclk;
  wire txp;
  wire txreset;
  wire userclk;
  wire userclk2;

gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_v14_2__parameterized0 gig_ethernet_pcs_pma_1_core
       (.D(txdata),
        .I1(rxdata),
        .I2(rxclkcorcnt),
        .O1(n_24_gig_ethernet_pcs_pma_1_core),
        .Q({gmii_isolate,powerdown}),
        .an_adv_config_vector(an_adv_config_vector),
        .an_interrupt(an_interrupt),
        .an_restart_config(an_restart_config),
        .configuration_vector(configuration_vector),
        .data_out(data_out),
        .encommaalign(encommaalign),
        .gmii_rx_dv(gmii_rx_dv),
        .gmii_rx_er(gmii_rx_er),
        .gmii_rxd(gmii_rxd),
        .gmii_tx_en(gmii_tx_en),
        .gmii_tx_er(gmii_tx_er),
        .gmii_txd(gmii_txd),
        .gt0_rxchariscomma_out(gt0_rxchariscomma_out),
        .gt0_rxcharisk_out(gt0_rxcharisk_out),
        .gt0_rxdisperr_out(gt0_rxdisperr_out),
        .gt0_rxnotintable_out(gt0_rxnotintable_out),
        .mmcm_locked(mmcm_locked),
        .reset(reset),
        .rxbuferr(rxbuferr),
        .rxreset(rxreset),
        .signal_detect(signal_detect),
        .status_vector(status_vector),
        .toggle(toggle),
        .txbuferr(txbuferr),
        .txchardispmode(txchardispmode),
        .txchardispval(txchardispval),
        .txcharisk(txcharisk),
        .txreset(txreset),
        .userclk2(userclk2));
(* box_type = "PRIMITIVE" *) 
   BUFMR rxrecclkbufmr
       (.I(I),
        .O(n_0_rxrecclkbufmr));
(* box_type = "PRIMITIVE" *) 
   BUFR #(
    .BUFR_DIVIDE("BYPASS"),
    .SIM_DEVICE("7SERIES")) 
     rxrecclkbufr
       (.CE(1'b1),
        .CLR(1'b0),
        .I(n_0_rxrecclkbufmr),
        .O(rxoutclk));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0 sync_block_reset_done
       (.clk(userclk2),
        .data_in(resetdone),
        .data_out(data_out));
gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_transceiver__parameterized0 transceiver_inst
       (.D(txdata),
        .I(I),
        .I1(n_24_gig_ethernet_pcs_pma_1_core),
        .O1(gt0_drprdy_out),
        .O2(gt0_rxpmaresetdone_out),
        .O3(O1),
        .O4(O2),
        .O5(rxclkcorcnt),
        .O6(rxdata),
        .Q(powerdown),
        .SR(rxreset),
        .cplllock(cplllock),
        .encommaalign(encommaalign),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_qplloutclk_in(gt0_qplloutclk_in),
        .gt0_qplloutrefclk_in(gt0_qplloutrefclk_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxbyteisaligned_out(gt0_rxbyteisaligned_out),
        .gt0_rxbyterealign_out(gt0_rxbyterealign_out),
        .gt0_rxcdrhold_in(gt0_rxcdrhold_in),
        .gt0_rxchariscomma_out(gt0_rxchariscomma_out),
        .gt0_rxcharisk_out(gt0_rxcharisk_out),
        .gt0_rxcommadet_out(gt0_rxcommadet_out),
        .gt0_rxdfeagcovrden_in(gt0_rxdfeagcovrden_in),
        .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),
        .gt0_rxdisperr_out(gt0_rxdisperr_out),
        .gt0_rxlpmen_in(gt0_rxlpmen_in),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxnotintable_out(gt0_rxnotintable_out),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxpmareset_in(gt0_rxpmareset_in),
        .gt0_rxpolarity_in(gt0_rxpolarity_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdiffctrl_in(gt0_txdiffctrl_in),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpmareset_in(gt0_txpmareset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txpostcursor_in(gt0_txpostcursor_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txprecursor_in(gt0_txprecursor_in),
        .gtrefclk(gtrefclk),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked(mmcm_locked),
        .pma_reset(pma_reset),
        .resetdone(resetdone),
        .rxbuferr(rxbuferr),
        .rxn(rxn),
        .rxp(rxp),
        .rxuserclk(rxuserclk),
        .status_vector(status_vector[1]),
        .toggle(toggle),
        .txbuferr(txbuferr),
        .txchardispmode(txchardispmode),
        .txchardispval(txchardispval),
        .txcharisk(txcharisk),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp),
        .txreset(txreset),
        .userclk(userclk),
        .userclk2(userclk2));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_gtwizard_gtrxreset_seq" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_gtwizard_gtrxreset_seq
   (GTRXRESET_OUT,
    DRP_OP_DONE,
    O1,
    O3,
    O4,
    DRPDI,
    Q,
    gt0_gtrxreset_in1_out,
    gt0_drpclk_in,
    O2,
    CPLL_RESET,
    I1,
    I2,
    I3,
    gt0_drpdo_out);
  output GTRXRESET_OUT;
  output DRP_OP_DONE;
  output O1;
  output O3;
  output O4;
  output [0:0]DRPDI;
  output [14:0]Q;
  input gt0_gtrxreset_in1_out;
  input gt0_drpclk_in;
  input O2;
  input CPLL_RESET;
  input I1;
  input I2;
  input I3;
  input [14:0]gt0_drpdo_out;

  wire CPLL_RESET;
  wire [0:0]DRPDI;
  wire DRP_OP_DONE;
  wire GTRXRESET_OUT;
  wire I1;
  wire I2;
  wire I3;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [14:0]Q;
  wire data_out;
  wire gt0_drpclk_in;
  wire [14:0]gt0_drpdo_out;
  wire gt0_gtrxreset_in1_out;
  wire gtrxreset_i;
  wire gtrxreset_s;
  wire gtrxreset_ss;
  wire n_0_drp_op_done_o_i_1;
  wire \n_0_rd_data[15]_i_1 ;
  wire \n_0_state[0]_i_2 ;
  wire n_0_sync_rst_sync;
  wire [2:0]next_state;
  wire reset_out;
  wire rxpmaresetdone_s;
  wire rxpmaresetdone_ss;
  wire rxpmaresetdone_sss;
  wire [2:0]state;

(* RETAIN_INVERTER *) 
   (* SOFT_HLUTNM = "soft_lutpair125" *) 
   LUT1 #(
    .INIT(2'h1)) 
     drp_busy_i1_i_1
       (.I0(DRP_OP_DONE),
        .O(O1));
(* SOFT_HLUTNM = "soft_lutpair124" *) 
   LUT5 #(
    .INIT(32'hFFFF8000)) 
     drp_op_done_o_i_1
       (.I0(state[2]),
        .I1(state[0]),
        .I2(I1),
        .I3(state[1]),
        .I4(DRP_OP_DONE),
        .O(n_0_drp_op_done_o_i_1));
FDCE drp_op_done_o_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(gtrxreset_ss),
        .D(n_0_drp_op_done_o_i_1),
        .Q(DRP_OP_DONE));
LUT5 #(
    .INIT(32'h8BB888B8)) 
     gthe2_i_i_1
       (.I0(I2),
        .I1(DRP_OP_DONE),
        .I2(state[0]),
        .I3(state[2]),
        .I4(state[1]),
        .O(O4));
(* SOFT_HLUTNM = "soft_lutpair124" *) 
   LUT4 #(
    .INIT(16'hF9FF)) 
     gthe2_i_i_32
       (.I0(state[0]),
        .I1(state[2]),
        .I2(DRP_OP_DONE),
        .I3(state[1]),
        .O(O3));
(* SOFT_HLUTNM = "soft_lutpair125" *) 
   LUT5 #(
    .INIT(32'h8888B888)) 
     gthe2_i_i_8
       (.I0(I3),
        .I1(DRP_OP_DONE),
        .I2(state[1]),
        .I3(state[2]),
        .I4(state[0]),
        .O(DRPDI));
(* SOFT_HLUTNM = "soft_lutpair126" *) 
   LUT4 #(
    .INIT(16'h0FDA)) 
     gtrxreset_o_i_1
       (.I0(state[0]),
        .I1(gtrxreset_ss),
        .I2(state[2]),
        .I3(state[1]),
        .O(gtrxreset_i));
FDCE gtrxreset_o_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(gtrxreset_i),
        .Q(GTRXRESET_OUT));
FDCE gtrxreset_s_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(reset_out),
        .Q(gtrxreset_s));
FDCE gtrxreset_ss_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(gtrxreset_s),
        .Q(gtrxreset_ss));
LUT4 #(
    .INIT(16'h0008)) 
     \rd_data[15]_i_1 
       (.I0(state[1]),
        .I1(I1),
        .I2(state[0]),
        .I3(state[2]),
        .O(\n_0_rd_data[15]_i_1 ));
FDCE \rd_data_reg[0] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[0]),
        .Q(Q[0]));
FDCE \rd_data_reg[10] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[10]),
        .Q(Q[10]));
FDCE \rd_data_reg[12] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[11]),
        .Q(Q[11]));
FDCE \rd_data_reg[13] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[12]),
        .Q(Q[12]));
FDCE \rd_data_reg[14] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[13]),
        .Q(Q[13]));
FDCE \rd_data_reg[15] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[14]),
        .Q(Q[14]));
FDCE \rd_data_reg[1] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[1]),
        .Q(Q[1]));
FDCE \rd_data_reg[2] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[2]),
        .Q(Q[2]));
FDCE \rd_data_reg[3] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[3]),
        .Q(Q[3]));
FDCE \rd_data_reg[4] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[4]),
        .Q(Q[4]));
FDCE \rd_data_reg[5] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[5]),
        .Q(Q[5]));
FDCE \rd_data_reg[6] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[6]),
        .Q(Q[6]));
FDCE \rd_data_reg[7] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[7]),
        .Q(Q[7]));
FDCE \rd_data_reg[8] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[8]),
        .Q(Q[8]));
FDCE \rd_data_reg[9] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[9]),
        .Q(Q[9]));
FDCE rxpmaresetdone_s_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(data_out),
        .Q(rxpmaresetdone_s));
FDCE rxpmaresetdone_ss_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(rxpmaresetdone_s),
        .Q(rxpmaresetdone_ss));
FDCE rxpmaresetdone_sss_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(rxpmaresetdone_ss),
        .Q(rxpmaresetdone_sss));
LUT6 #(
    .INIT(64'h3F330C00FCE2FCE2)) 
     \state[0]_i_1 
       (.I0(gtrxreset_ss),
        .I1(state[1]),
        .I2(I1),
        .I3(state[2]),
        .I4(\n_0_state[0]_i_2 ),
        .I5(state[0]),
        .O(next_state[0]));
LUT3 #(
    .INIT(8'h8A)) 
     \state[0]_i_2 
       (.I0(state[2]),
        .I1(rxpmaresetdone_ss),
        .I2(rxpmaresetdone_sss),
        .O(\n_0_state[0]_i_2 ));
LUT6 #(
    .INIT(64'h0FFF0F0F4040F0F0)) 
     \state[1]_i_1 
       (.I0(rxpmaresetdone_ss),
        .I1(rxpmaresetdone_sss),
        .I2(state[0]),
        .I3(I1),
        .I4(state[2]),
        .I5(state[1]),
        .O(next_state[1]));
(* SOFT_HLUTNM = "soft_lutpair126" *) 
   LUT4 #(
    .INIT(16'h7FA0)) 
     \state[2]_i_1 
       (.I0(state[0]),
        .I1(I1),
        .I2(state[1]),
        .I3(state[2]),
        .O(next_state[2]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[0] 
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[0]),
        .Q(state[0]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[1] 
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[1]),
        .Q(state[1]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[2] 
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[2]),
        .Q(state[2]));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__8 sync_gtrxreset_in
       (.clk(gt0_drpclk_in),
        .reset_in(gt0_gtrxreset_in1_out),
        .reset_out(reset_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync sync_rst_sync
       (.clk(gt0_drpclk_in),
        .reset_in(CPLL_RESET),
        .reset_out(n_0_sync_rst_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__22 sync_rxpmaresetdone
       (.clk(gt0_drpclk_in),
        .data_in(O2),
        .data_out(data_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_gtwizard_rxpmarst_seq" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_gtwizard_rxpmarst_seq
   (RXPMARESET_OUT,
    DRPDI,
    O1,
    O3,
    O4,
    DRPADDR,
    gt0_drpclk_in,
    O2,
    gt0_rxpmareset_in,
    CPLL_RESET,
    I1,
    drp_busy_i1,
    DRP_OP_DONE,
    gt0_drpdi_in,
    Q,
    I2,
    gt0_drpwe_in,
    gt0_drpen_in,
    gt0_drpaddr_in,
    gt0_drpdo_out);
  output RXPMARESET_OUT;
  output [14:0]DRPDI;
  output O1;
  output O3;
  output O4;
  output [8:0]DRPADDR;
  input gt0_drpclk_in;
  input O2;
  input gt0_rxpmareset_in;
  input CPLL_RESET;
  input I1;
  input drp_busy_i1;
  input DRP_OP_DONE;
  input [15:0]gt0_drpdi_in;
  input [14:0]Q;
  input I2;
  input gt0_drpwe_in;
  input gt0_drpen_in;
  input [8:0]gt0_drpaddr_in;
  input [14:0]gt0_drpdo_out;

  wire CPLL_RESET;
  wire [8:0]DRPADDR;
  wire [14:0]DRPDI;
  wire DRP_OP_DONE;
  wire I1;
  wire I2;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [14:0]Q;
  wire RXPMARESET_OUT;
  wire data_out;
  wire drp_busy_i1;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [14:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drpwe_in;
  wire gt0_rxpmareset_in;
  wire n_0_gthe2_i_i_30;
  wire n_0_gthe2_i_i_31;
  wire \n_0_rd_data[15]_i_1__0 ;
  wire \n_0_rd_data_reg[0] ;
  wire \n_0_rd_data_reg[10] ;
  wire \n_0_rd_data_reg[12] ;
  wire \n_0_rd_data_reg[13] ;
  wire \n_0_rd_data_reg[14] ;
  wire \n_0_rd_data_reg[15] ;
  wire \n_0_rd_data_reg[1] ;
  wire \n_0_rd_data_reg[2] ;
  wire \n_0_rd_data_reg[3] ;
  wire \n_0_rd_data_reg[4] ;
  wire \n_0_rd_data_reg[5] ;
  wire \n_0_rd_data_reg[6] ;
  wire \n_0_rd_data_reg[7] ;
  wire \n_0_rd_data_reg[8] ;
  wire \n_0_rd_data_reg[9] ;
  wire \n_0_state[0]_i_2__0 ;
  wire \n_0_state[0]_i_3 ;
  wire \n_0_state[1]_i_1__0 ;
  wire \n_0_state[2]_i_1__0 ;
  wire n_0_sync_rst_sync;
  wire [3:0]next_state;
  wire reset_out;
  wire rxpmareset_i;
  wire rxpmareset_s;
  wire rxpmareset_ss;
  wire [3:0]state;

LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_10
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[9]),
        .I2(\n_0_rd_data_reg[9] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[9]),
        .I5(I2),
        .O(DRPDI[9]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_11
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[8]),
        .I2(\n_0_rd_data_reg[8] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[8]),
        .I5(I2),
        .O(DRPDI[8]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_12
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[7]),
        .I2(\n_0_rd_data_reg[7] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[7]),
        .I5(I2),
        .O(DRPDI[7]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_13
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[6]),
        .I2(\n_0_rd_data_reg[6] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[6]),
        .I5(I2),
        .O(DRPDI[6]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_14
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[5]),
        .I2(\n_0_rd_data_reg[5] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[5]),
        .I5(I2),
        .O(DRPDI[5]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_15
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[4]),
        .I2(\n_0_rd_data_reg[4] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[4]),
        .I5(I2),
        .O(DRPDI[4]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_16
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[3]),
        .I2(\n_0_rd_data_reg[3] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[3]),
        .I5(I2),
        .O(DRPDI[3]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_17
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[2]),
        .I2(\n_0_rd_data_reg[2] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[2]),
        .I5(I2),
        .O(DRPDI[2]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_18
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[1]),
        .I2(\n_0_rd_data_reg[1] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[1]),
        .I5(I2),
        .O(DRPDI[1]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_19
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[0]),
        .I2(\n_0_rd_data_reg[0] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[0]),
        .I5(I2),
        .O(DRPDI[0]));
(* SOFT_HLUTNM = "soft_lutpair128" *) 
   LUT4 #(
    .INIT(16'h4FFF)) 
     gthe2_i_i_2
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpwe_in),
        .I2(n_0_gthe2_i_i_31),
        .I3(I2),
        .O(O1));
(* SOFT_HLUTNM = "soft_lutpair128" *) 
   LUT2 #(
    .INIT(4'h2)) 
     gthe2_i_i_20
       (.I0(gt0_drpaddr_in[8]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[8]));
(* SOFT_HLUTNM = "soft_lutpair129" *) 
   LUT2 #(
    .INIT(4'h2)) 
     gthe2_i_i_21
       (.I0(gt0_drpaddr_in[7]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[7]));
(* SOFT_HLUTNM = "soft_lutpair129" *) 
   LUT2 #(
    .INIT(4'h2)) 
     gthe2_i_i_22
       (.I0(gt0_drpaddr_in[6]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[6]));
(* SOFT_HLUTNM = "soft_lutpair130" *) 
   LUT2 #(
    .INIT(4'h2)) 
     gthe2_i_i_23
       (.I0(gt0_drpaddr_in[5]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[5]));
(* SOFT_HLUTNM = "soft_lutpair130" *) 
   LUT2 #(
    .INIT(4'hE)) 
     gthe2_i_i_24
       (.I0(gt0_drpaddr_in[4]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[4]));
(* SOFT_HLUTNM = "soft_lutpair131" *) 
   LUT2 #(
    .INIT(4'h2)) 
     gthe2_i_i_25
       (.I0(gt0_drpaddr_in[3]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[3]));
(* SOFT_HLUTNM = "soft_lutpair131" *) 
   LUT2 #(
    .INIT(4'h2)) 
     gthe2_i_i_26
       (.I0(gt0_drpaddr_in[2]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[2]));
(* SOFT_HLUTNM = "soft_lutpair132" *) 
   LUT2 #(
    .INIT(4'h2)) 
     gthe2_i_i_27
       (.I0(gt0_drpaddr_in[1]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[1]));
(* SOFT_HLUTNM = "soft_lutpair132" *) 
   LUT2 #(
    .INIT(4'hE)) 
     gthe2_i_i_28
       (.I0(gt0_drpaddr_in[0]),
        .I1(n_0_gthe2_i_i_30),
        .O(DRPADDR[0]));
LUT6 #(
    .INIT(64'hBBEEAAFF11440004)) 
     gthe2_i_i_29
       (.I0(state[3]),
        .I1(state[0]),
        .I2(drp_busy_i1),
        .I3(state[2]),
        .I4(state[1]),
        .I5(gt0_drpen_in),
        .O(O4));
LUT6 #(
    .INIT(64'h0000EFEEFFFFFFFF)) 
     gthe2_i_i_30
       (.I0(state[1]),
        .I1(state[2]),
        .I2(drp_busy_i1),
        .I3(state[0]),
        .I4(state[3]),
        .I5(DRP_OP_DONE),
        .O(n_0_gthe2_i_i_30));
LUT5 #(
    .INIT(32'hFFDFDFFF)) 
     gthe2_i_i_31
       (.I0(DRP_OP_DONE),
        .I1(state[3]),
        .I2(state[1]),
        .I3(state[0]),
        .I4(state[2]),
        .O(n_0_gthe2_i_i_31));
LUT6 #(
    .INIT(64'hCCCCCCCC0F00008C)) 
     gthe2_i_i_33
       (.I0(drp_busy_i1),
        .I1(gt0_drpdi_in[11]),
        .I2(state[0]),
        .I3(state[1]),
        .I4(state[2]),
        .I5(state[3]),
        .O(O3));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_4
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[15]),
        .I2(\n_0_rd_data_reg[15] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[14]),
        .I5(I2),
        .O(DRPDI[14]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_5
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[14]),
        .I2(\n_0_rd_data_reg[14] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[13]),
        .I5(I2),
        .O(DRPDI[13]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_6
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[13]),
        .I2(\n_0_rd_data_reg[13] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[12]),
        .I5(I2),
        .O(DRPDI[12]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_7
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[12]),
        .I2(\n_0_rd_data_reg[12] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[11]),
        .I5(I2),
        .O(DRPDI[11]));
LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
     gthe2_i_i_9
       (.I0(n_0_gthe2_i_i_30),
        .I1(gt0_drpdi_in[10]),
        .I2(\n_0_rd_data_reg[10] ),
        .I3(n_0_gthe2_i_i_31),
        .I4(Q[10]),
        .I5(I2),
        .O(DRPDI[10]));
LUT5 #(
    .INIT(32'h00000400)) 
     \rd_data[15]_i_1__0 
       (.I0(state[0]),
        .I1(I1),
        .I2(state[3]),
        .I3(state[1]),
        .I4(state[2]),
        .O(\n_0_rd_data[15]_i_1__0 ));
FDCE \rd_data_reg[0] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[0]),
        .Q(\n_0_rd_data_reg[0] ));
FDCE \rd_data_reg[10] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[10]),
        .Q(\n_0_rd_data_reg[10] ));
FDCE \rd_data_reg[12] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[11]),
        .Q(\n_0_rd_data_reg[12] ));
FDCE \rd_data_reg[13] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[12]),
        .Q(\n_0_rd_data_reg[13] ));
FDCE \rd_data_reg[14] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[13]),
        .Q(\n_0_rd_data_reg[14] ));
FDCE \rd_data_reg[15] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[14]),
        .Q(\n_0_rd_data_reg[15] ));
FDCE \rd_data_reg[1] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[1]),
        .Q(\n_0_rd_data_reg[1] ));
FDCE \rd_data_reg[2] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[2]),
        .Q(\n_0_rd_data_reg[2] ));
FDCE \rd_data_reg[3] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[3]),
        .Q(\n_0_rd_data_reg[3] ));
FDCE \rd_data_reg[4] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[4]),
        .Q(\n_0_rd_data_reg[4] ));
FDCE \rd_data_reg[5] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[5]),
        .Q(\n_0_rd_data_reg[5] ));
FDCE \rd_data_reg[6] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[6]),
        .Q(\n_0_rd_data_reg[6] ));
FDCE \rd_data_reg[7] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[7]),
        .Q(\n_0_rd_data_reg[7] ));
FDCE \rd_data_reg[8] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[8]),
        .Q(\n_0_rd_data_reg[8] ));
FDCE \rd_data_reg[9] 
       (.C(gt0_drpclk_in),
        .CE(\n_0_rd_data[15]_i_1__0 ),
        .CLR(n_0_sync_rst_sync),
        .D(gt0_drpdo_out[9]),
        .Q(\n_0_rd_data_reg[9] ));
LUT5 #(
    .INIT(32'h00F00200)) 
     rxpmareset_o_i_1
       (.I0(rxpmareset_ss),
        .I1(state[1]),
        .I2(state[2]),
        .I3(state[3]),
        .I4(state[0]),
        .O(rxpmareset_i));
FDCE rxpmareset_o_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(rxpmareset_i),
        .Q(RXPMARESET_OUT));
FDCE rxpmareset_s_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(reset_out),
        .Q(rxpmareset_s));
FDCE rxpmareset_ss_reg
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(rxpmareset_s),
        .Q(rxpmareset_ss));
LUT6 #(
    .INIT(64'hFFFFFFFF2EFC0000)) 
     \state[0]_i_1__0 
       (.I0(data_out),
        .I1(state[1]),
        .I2(I1),
        .I3(state[0]),
        .I4(\n_0_state[0]_i_2__0 ),
        .I5(\n_0_state[0]_i_3 ),
        .O(next_state[0]));
(* SOFT_HLUTNM = "soft_lutpair127" *) 
   LUT2 #(
    .INIT(4'h2)) 
     \state[0]_i_2__0 
       (.I0(state[2]),
        .I1(state[3]),
        .O(\n_0_state[0]_i_2__0 ));
LUT6 #(
    .INIT(64'h0000000000002230)) 
     \state[0]_i_3 
       (.I0(I1),
        .I1(state[0]),
        .I2(rxpmareset_ss),
        .I3(state[1]),
        .I4(state[2]),
        .I5(state[3]),
        .O(\n_0_state[0]_i_3 ));
LUT6 #(
    .INIT(64'h0050003F00FF0000)) 
     \state[1]_i_1__0 
       (.I0(I1),
        .I1(data_out),
        .I2(state[2]),
        .I3(state[3]),
        .I4(state[1]),
        .I5(state[0]),
        .O(\n_0_state[1]_i_1__0 ));
(* SOFT_HLUTNM = "soft_lutpair127" *) 
   LUT5 #(
    .INIT(32'h15405540)) 
     \state[2]_i_1__0 
       (.I0(state[3]),
        .I1(state[0]),
        .I2(state[1]),
        .I3(state[2]),
        .I4(I1),
        .O(\n_0_state[2]_i_1__0 ));
LUT6 #(
    .INIT(64'h0000000AC0000000)) 
     \state[3]_i_1 
       (.I0(rxpmareset_ss),
        .I1(I1),
        .I2(state[0]),
        .I3(state[1]),
        .I4(state[2]),
        .I5(state[3]),
        .O(next_state[3]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[0] 
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[0]),
        .Q(state[0]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[1] 
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(\n_0_state[1]_i_1__0 ),
        .Q(state[1]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[2] 
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(\n_0_state[2]_i_1__0 ),
        .Q(state[2]));
FDCE #(
    .INIT(1'b0)) 
     \state_reg[3] 
       (.C(gt0_drpclk_in),
        .CE(1'b1),
        .CLR(n_0_sync_rst_sync),
        .D(next_state[3]),
        .Q(state[3]));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__23 sync_RXPMARESETDONE
       (.clk(gt0_drpclk_in),
        .data_in(O2),
        .data_out(data_out));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__parameterized1__4 sync_rst_sync
       (.clk(gt0_drpclk_in),
        .reset_in(CPLL_RESET),
        .reset_out(n_0_sync_rst_sync));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__parameterized1__3 sync_rxpmareset_in
       (.clk(gt0_drpclk_in),
        .reset_in(gt0_rxpmareset_in),
        .reset_out(reset_out));
endmodule

(* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) (* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_reset_sync" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__5
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__6
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__7
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_reset_sync" *) (* INITIALISE = "2'b11" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__8
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b1)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_reset_sync" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__parameterized1
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_reset_sync" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__parameterized1__3
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_reset_sync" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__parameterized1__4
   (reset_in,
    clk,
    reset_out);
  input reset_in;
  input clk;
  output reset_out;

  wire clk;
  wire reset_in;
  wire reset_out;
  wire reset_sync_reg1;
  wire reset_sync_reg2;
  wire reset_sync_reg3;
  wire reset_sync_reg4;
  wire reset_sync_reg5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync1
       (.C(clk),
        .CE(1'b1),
        .D(1'b0),
        .PRE(reset_in),
        .Q(reset_sync_reg1));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync2
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg1),
        .PRE(reset_in),
        .Q(reset_sync_reg2));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync3
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg2),
        .PRE(reset_in),
        .Q(reset_sync_reg3));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync4
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg3),
        .PRE(reset_in),
        .Q(reset_sync_reg4));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync5
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg4),
        .PRE(reset_in),
        .Q(reset_sync_reg5));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FDP" *) 
   (* box_type = "PRIMITIVE" *) 
   FDPE #(
    .INIT(1'b0)) 
     reset_sync6
       (.C(clk),
        .CE(1'b1),
        .D(reset_sync_reg5),
        .PRE(1'b0),
        .Q(reset_out));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__22
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__23
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__24
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__25
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__26
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__27
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__28
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__29
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__30
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__31
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__32
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__33
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__34
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__35
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__36
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__37
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__38
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__39
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__40
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__41
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_sync_block" *) (* INITIALISE = "2'b00" *) (* dont_touch = "yes" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__42
   (clk,
    data_in,
    data_out);
  input clk;
  input data_in;
  output data_out;

  wire clk;
  wire data_in;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;

(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(clk),
        .CE(1'b1),
        .D(data_in),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(clk),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(clk),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(clk),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(clk),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(clk),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_1_transceiver" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_transceiver__parameterized0
   (cplllock,
    O1,
    gt0_eyescandataerror_out,
    txn,
    txp,
    gt0_rxbyteisaligned_out,
    gt0_rxbyterealign_out,
    gt0_rxcommadet_out,
    I,
    O2,
    gt0_rxprbserr_out,
    txoutclk,
    gt0_dmonitorout_out,
    gt0_drpdo_out,
    gt0_txbufstatus_out,
    gt0_rxbufstatus_out,
    gt0_rxmonitorout_out,
    O3,
    O4,
    toggle,
    gt0_rxchariscomma_out,
    gt0_rxcharisk_out,
    gt0_rxdisperr_out,
    gt0_rxnotintable_out,
    rxbuferr,
    txbuferr,
    O5,
    O6,
    resetdone,
    encommaalign,
    userclk,
    txreset,
    SR,
    independent_clock_bufg,
    gt0_drpclk_in,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    rxn,
    rxp,
    gtrefclk,
    gt0_qplloutclk_in,
    gt0_qplloutrefclk_in,
    gt0_rxbufreset_in,
    gt0_rxcdrhold_in,
    gt0_rxdfeagcovrden_in,
    gt0_rxdfelpmreset_in,
    gt0_rxlpmen_in,
    gt0_rxpcsreset_in,
    gt0_rxpolarity_in,
    gt0_rxprbscntreset_in,
    gt0_txpcsreset_in,
    gt0_txpmareset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_rxmonitorsel_in,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_txprbssel_in,
    gt0_txdiffctrl_in,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    gt0_rxpmareset_in,
    mmcm_locked,
    rxuserclk,
    userclk2,
    txchardispmode,
    txchardispval,
    txcharisk,
    status_vector,
    Q,
    pma_reset,
    I1,
    D,
    gt0_drpdi_in,
    gt0_drpwe_in,
    gt0_drpen_in,
    gt0_drpaddr_in);
  output cplllock;
  output O1;
  output gt0_eyescandataerror_out;
  output txn;
  output txp;
  output gt0_rxbyteisaligned_out;
  output gt0_rxbyterealign_out;
  output gt0_rxcommadet_out;
  output I;
  output O2;
  output gt0_rxprbserr_out;
  output txoutclk;
  output [14:0]gt0_dmonitorout_out;
  output [15:0]gt0_drpdo_out;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  output [6:0]gt0_rxmonitorout_out;
  output O3;
  output O4;
  output toggle;
  output [0:0]gt0_rxchariscomma_out;
  output [0:0]gt0_rxcharisk_out;
  output [0:0]gt0_rxdisperr_out;
  output [0:0]gt0_rxnotintable_out;
  output rxbuferr;
  output txbuferr;
  output [1:0]O5;
  output [7:0]O6;
  output resetdone;
  input encommaalign;
  input userclk;
  input txreset;
  input [0:0]SR;
  input independent_clock_bufg;
  input gt0_drpclk_in;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input rxn;
  input rxp;
  input gtrefclk;
  input gt0_qplloutclk_in;
  input gt0_qplloutrefclk_in;
  input gt0_rxbufreset_in;
  input gt0_rxcdrhold_in;
  input gt0_rxdfeagcovrden_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxlpmen_in;
  input gt0_rxpcsreset_in;
  input gt0_rxpolarity_in;
  input gt0_rxprbscntreset_in;
  input gt0_txpcsreset_in;
  input gt0_txpmareset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input [1:0]gt0_rxmonitorsel_in;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_txprbssel_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input gt0_rxpmareset_in;
  input mmcm_locked;
  input rxuserclk;
  input userclk2;
  input txchardispmode;
  input txchardispval;
  input txcharisk;
  input [0:0]status_vector;
  input [0:0]Q;
  input pma_reset;
  input I1;
  input [7:0]D;
  input [15:0]gt0_drpdi_in;
  input gt0_drpwe_in;
  input gt0_drpen_in;
  input [8:0]gt0_drpaddr_in;

  wire [7:0]D;
  wire I;
  wire I1;
  wire O1;
  wire O2;
  wire O3;
  wire O4;
  wire [1:0]O5;
  wire [7:0]O6;
  wire [0:0]Q;
  wire [0:0]SR;
  wire cplllock;
  wire data_out;
  wire data_valid_reg;
  wire encommaalign;
  wire [14:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr_in;
  wire gt0_drpclk_in;
  wire [15:0]gt0_drpdi_in;
  wire [15:0]gt0_drpdo_out;
  wire gt0_drpen_in;
  wire gt0_drpwe_in;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire [2:0]gt0_loopback_in;
  wire gt0_qplloutclk_in;
  wire gt0_qplloutrefclk_in;
  wire gt0_rxbufreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire gt0_rxbyteisaligned_out;
  wire gt0_rxbyterealign_out;
  wire gt0_rxcdrhold_in;
  wire [0:0]gt0_rxchariscomma_out;
  wire [1:0]gt0_rxchariscomma_out_3;
  wire [0:0]gt0_rxcharisk_out;
  wire [1:0]gt0_rxcharisk_out_2;
  wire [1:0]gt0_rxclkcorcnt_out;
  wire gt0_rxcommadet_out;
  wire [15:0]gt0_rxdata_out;
  wire gt0_rxdfeagcovrden_in;
  wire gt0_rxdfelpmreset_in;
  wire [0:0]gt0_rxdisperr_out;
  wire [1:0]gt0_rxdisperr_out_1;
  wire gt0_rxlpmen_in;
  wire gt0_rxmcommaalignen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire [0:0]gt0_rxnotintable_out;
  wire [1:0]gt0_rxnotintable_out_0;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [1:0]gt0_txbufstatus_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txpcsreset_in;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gtrefclk;
  wire independent_clock_bufg;
  wire mmcm_locked;
  wire n_0_rxchariscomma_i_1;
  wire n_0_rxcharisk_i_1;
  wire \n_0_rxdata[0]_i_1 ;
  wire \n_0_rxdata[1]_i_1 ;
  wire \n_0_rxdata[2]_i_1 ;
  wire \n_0_rxdata[3]_i_1 ;
  wire \n_0_rxdata[4]_i_1 ;
  wire \n_0_rxdata[5]_i_1 ;
  wire \n_0_rxdata[6]_i_1 ;
  wire \n_0_rxdata[7]_i_1 ;
  wire n_0_rxdisperr_i_1;
  wire n_0_rxnotintable_i_1;
  wire n_0_toggle_i_1;
  wire \n_0_txbufstatus_reg_reg[1] ;
  wire \n_0_txcharisk_double_reg[0] ;
  wire \n_0_txcharisk_double_reg[1] ;
  wire p_0_in_4;
  wire pma_reset;
  wire reset_out;
  wire reset_out0_in;
  wire resetdone;
  wire rxbuferr;
  wire [1:0]rxchariscomma_double;
  wire [1:0]rxchariscomma_reg__0;
  wire [1:0]rxcharisk_double;
  wire [1:0]rxcharisk_reg__0;
  wire [15:0]rxdata_double;
  wire [15:0]rxdata_reg__0;
  wire [1:0]rxdisperr_double;
  wire [1:0]rxdisperr_reg__0;
  wire rxn;
  wire [1:0]rxnotintable_double;
  wire [1:0]rxnotintable_reg__0;
  wire rxp;
  wire rxpowerdown;
  wire rxpowerdown_double;
  wire rxpowerdown_reg__0;
  wire rxuserclk;
  wire [0:0]status_vector;
  wire toggle;
  wire txbuferr;
  wire txchardispmode;
  wire [1:0]txchardispmode_double;
  wire [1:0]txchardispmode_int;
  wire txchardispmode_reg;
  wire txchardispval;
  wire [1:0]txchardispval_double;
  wire [1:0]txchardispval_int;
  wire txchardispval_reg;
  wire txcharisk;
  wire [1:0]txcharisk_int;
  wire txcharisk_reg;
  wire [15:0]txdata_double;
  wire [15:0]txdata_int;
  wire [7:0]txdata_reg;
  wire txn;
  wire txoutclk;
  wire txp;
  wire txpowerdown;
  wire txpowerdown_double;
  wire txpowerdown_reg__0;
  wire txreset;
  wire userclk;
  wire userclk2;

FDRE data_valid_reg_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(status_vector),
        .Q(data_valid_reg),
        .R(1'b0));
gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_GTWIZARD__parameterized0 gtwizard_inst
       (.D(gt0_rxclkcorcnt_out),
        .I(I),
        .I1(txchardispmode_int),
        .I2(txchardispval_int),
        .I3(txcharisk_int),
        .O1(O1),
        .O2(O2),
        .O3(gt0_rxdata_out),
        .O4(gt0_rxchariscomma_out_3),
        .O5(gt0_rxcharisk_out_2),
        .O6(gt0_rxdisperr_out_1),
        .O7(gt0_rxnotintable_out_0),
        .O8(O3),
        .O9(O4),
        .Q(txdata_int),
        .RXPD(rxpowerdown),
        .TXPD(txpowerdown),
        .cplllock(cplllock),
        .data_out(data_out),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr_in(gt0_drpaddr_in),
        .gt0_drpclk_in(gt0_drpclk_in),
        .gt0_drpdi_in(gt0_drpdi_in),
        .gt0_drpdo_out(gt0_drpdo_out),
        .gt0_drpen_in(gt0_drpen_in),
        .gt0_drpwe_in(gt0_drpwe_in),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_qplloutclk_in(gt0_qplloutclk_in),
        .gt0_qplloutrefclk_in(gt0_qplloutrefclk_in),
        .gt0_rxbufreset_in(gt0_rxbufreset_in),
        .gt0_rxbufstatus_out(gt0_rxbufstatus_out),
        .gt0_rxbyteisaligned_out(gt0_rxbyteisaligned_out),
        .gt0_rxbyterealign_out(gt0_rxbyterealign_out),
        .gt0_rxcdrhold_in(gt0_rxcdrhold_in),
        .gt0_rxcommadet_out(gt0_rxcommadet_out),
        .gt0_rxdfeagcovrden_in(gt0_rxdfeagcovrden_in),
        .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),
        .gt0_rxlpmen_in(gt0_rxlpmen_in),
        .gt0_rxmcommaalignen_in(gt0_rxmcommaalignen_in),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxpmareset_in(gt0_rxpmareset_in),
        .gt0_rxpolarity_in(gt0_rxpolarity_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_txbufstatus_out(gt0_txbufstatus_out),
        .gt0_txdiffctrl_in(gt0_txdiffctrl_in),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txpmareset_in(gt0_txpmareset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txpostcursor_in(gt0_txpostcursor_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txprecursor_in(gt0_txprecursor_in),
        .gtrefclk(gtrefclk),
        .independent_clock_bufg(independent_clock_bufg),
        .mmcm_locked(mmcm_locked),
        .pma_reset(pma_reset),
        .reset_out(reset_out),
        .reset_out0_in(reset_out0_in),
        .resetdone(resetdone),
        .rxn(rxn),
        .rxp(rxp),
        .rxuserclk(rxuserclk),
        .txn(txn),
        .txoutclk(txoutclk),
        .txp(txp),
        .userclk(userclk));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__5 reclock_encommaalign
       (.clk(userclk),
        .reset_in(encommaalign),
        .reset_out(gt0_rxmcommaalignen_in));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__7 reclock_rxreset
       (.clk(userclk),
        .reset_in(SR),
        .reset_out(reset_out0_in));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b11" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_reset_sync__6 reclock_txreset
       (.clk(userclk),
        .reset_in(txreset),
        .reset_out(reset_out));
FDRE rxbuferr_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(p_0_in_4),
        .Q(rxbuferr),
        .R(1'b0));
FDRE \rxbufstatus_reg_reg[2] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxbufstatus_out[2]),
        .Q(p_0_in_4),
        .R(1'b0));
FDRE \rxchariscomma_double_reg[0] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxchariscomma_reg__0[0]),
        .Q(rxchariscomma_double[0]),
        .R(SR));
FDRE \rxchariscomma_double_reg[1] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxchariscomma_reg__0[1]),
        .Q(rxchariscomma_double[1]),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair134" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     rxchariscomma_i_1
       (.I0(rxchariscomma_double[1]),
        .I1(toggle),
        .I2(rxchariscomma_double[0]),
        .O(n_0_rxchariscomma_i_1));
FDRE rxchariscomma_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_rxchariscomma_i_1),
        .Q(gt0_rxchariscomma_out),
        .R(SR));
FDRE \rxchariscomma_reg_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxchariscomma_out_3[0]),
        .Q(rxchariscomma_reg__0[0]),
        .R(1'b0));
FDRE \rxchariscomma_reg_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxchariscomma_out_3[1]),
        .Q(rxchariscomma_reg__0[1]),
        .R(1'b0));
FDRE \rxcharisk_double_reg[0] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxcharisk_reg__0[0]),
        .Q(rxcharisk_double[0]),
        .R(SR));
FDRE \rxcharisk_double_reg[1] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxcharisk_reg__0[1]),
        .Q(rxcharisk_double[1]),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair134" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     rxcharisk_i_1
       (.I0(rxcharisk_double[1]),
        .I1(toggle),
        .I2(rxcharisk_double[0]),
        .O(n_0_rxcharisk_i_1));
FDRE rxcharisk_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_rxcharisk_i_1),
        .Q(gt0_rxcharisk_out),
        .R(SR));
FDRE \rxcharisk_reg_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxcharisk_out_2[0]),
        .Q(rxcharisk_reg__0[0]),
        .R(1'b0));
FDRE \rxcharisk_reg_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxcharisk_out_2[1]),
        .Q(rxcharisk_reg__0[1]),
        .R(1'b0));
FDRE \rxclkcorcnt_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gt0_rxclkcorcnt_out[0]),
        .Q(O5[0]),
        .R(1'b0));
FDRE \rxclkcorcnt_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(gt0_rxclkcorcnt_out[1]),
        .Q(O5[1]),
        .R(1'b0));
(* SOFT_HLUTNM = "soft_lutpair139" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxdata[0]_i_1 
       (.I0(rxdata_double[8]),
        .I1(toggle),
        .I2(rxdata_double[0]),
        .O(\n_0_rxdata[0]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair139" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxdata[1]_i_1 
       (.I0(rxdata_double[9]),
        .I1(toggle),
        .I2(rxdata_double[1]),
        .O(\n_0_rxdata[1]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair138" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxdata[2]_i_1 
       (.I0(rxdata_double[10]),
        .I1(toggle),
        .I2(rxdata_double[2]),
        .O(\n_0_rxdata[2]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair137" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxdata[3]_i_1 
       (.I0(rxdata_double[11]),
        .I1(toggle),
        .I2(rxdata_double[3]),
        .O(\n_0_rxdata[3]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair138" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxdata[4]_i_1 
       (.I0(rxdata_double[12]),
        .I1(toggle),
        .I2(rxdata_double[4]),
        .O(\n_0_rxdata[4]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair137" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxdata[5]_i_1 
       (.I0(rxdata_double[13]),
        .I1(toggle),
        .I2(rxdata_double[5]),
        .O(\n_0_rxdata[5]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair136" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxdata[6]_i_1 
       (.I0(rxdata_double[14]),
        .I1(toggle),
        .I2(rxdata_double[6]),
        .O(\n_0_rxdata[6]_i_1 ));
(* SOFT_HLUTNM = "soft_lutpair136" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     \rxdata[7]_i_1 
       (.I0(rxdata_double[15]),
        .I1(toggle),
        .I2(rxdata_double[7]),
        .O(\n_0_rxdata[7]_i_1 ));
FDRE \rxdata_double_reg[0] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[0]),
        .Q(rxdata_double[0]),
        .R(SR));
FDRE \rxdata_double_reg[10] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[10]),
        .Q(rxdata_double[10]),
        .R(SR));
FDRE \rxdata_double_reg[11] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[11]),
        .Q(rxdata_double[11]),
        .R(SR));
FDRE \rxdata_double_reg[12] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[12]),
        .Q(rxdata_double[12]),
        .R(SR));
FDRE \rxdata_double_reg[13] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[13]),
        .Q(rxdata_double[13]),
        .R(SR));
FDRE \rxdata_double_reg[14] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[14]),
        .Q(rxdata_double[14]),
        .R(SR));
FDRE \rxdata_double_reg[15] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[15]),
        .Q(rxdata_double[15]),
        .R(SR));
FDRE \rxdata_double_reg[1] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[1]),
        .Q(rxdata_double[1]),
        .R(SR));
FDRE \rxdata_double_reg[2] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[2]),
        .Q(rxdata_double[2]),
        .R(SR));
FDRE \rxdata_double_reg[3] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[3]),
        .Q(rxdata_double[3]),
        .R(SR));
FDRE \rxdata_double_reg[4] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[4]),
        .Q(rxdata_double[4]),
        .R(SR));
FDRE \rxdata_double_reg[5] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[5]),
        .Q(rxdata_double[5]),
        .R(SR));
FDRE \rxdata_double_reg[6] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[6]),
        .Q(rxdata_double[6]),
        .R(SR));
FDRE \rxdata_double_reg[7] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[7]),
        .Q(rxdata_double[7]),
        .R(SR));
FDRE \rxdata_double_reg[8] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[8]),
        .Q(rxdata_double[8]),
        .R(SR));
FDRE \rxdata_double_reg[9] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdata_reg__0[9]),
        .Q(rxdata_double[9]),
        .R(SR));
FDRE \rxdata_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_rxdata[0]_i_1 ),
        .Q(O6[0]),
        .R(SR));
FDRE \rxdata_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_rxdata[1]_i_1 ),
        .Q(O6[1]),
        .R(SR));
FDRE \rxdata_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_rxdata[2]_i_1 ),
        .Q(O6[2]),
        .R(SR));
FDRE \rxdata_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_rxdata[3]_i_1 ),
        .Q(O6[3]),
        .R(SR));
FDRE \rxdata_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_rxdata[4]_i_1 ),
        .Q(O6[4]),
        .R(SR));
FDRE \rxdata_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_rxdata[5]_i_1 ),
        .Q(O6[5]),
        .R(SR));
FDRE \rxdata_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_rxdata[6]_i_1 ),
        .Q(O6[6]),
        .R(SR));
FDRE \rxdata_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_rxdata[7]_i_1 ),
        .Q(O6[7]),
        .R(SR));
FDRE \rxdata_reg_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[0]),
        .Q(rxdata_reg__0[0]),
        .R(1'b0));
FDRE \rxdata_reg_reg[10] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[10]),
        .Q(rxdata_reg__0[10]),
        .R(1'b0));
FDRE \rxdata_reg_reg[11] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[11]),
        .Q(rxdata_reg__0[11]),
        .R(1'b0));
FDRE \rxdata_reg_reg[12] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[12]),
        .Q(rxdata_reg__0[12]),
        .R(1'b0));
FDRE \rxdata_reg_reg[13] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[13]),
        .Q(rxdata_reg__0[13]),
        .R(1'b0));
FDRE \rxdata_reg_reg[14] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[14]),
        .Q(rxdata_reg__0[14]),
        .R(1'b0));
FDRE \rxdata_reg_reg[15] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[15]),
        .Q(rxdata_reg__0[15]),
        .R(1'b0));
FDRE \rxdata_reg_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[1]),
        .Q(rxdata_reg__0[1]),
        .R(1'b0));
FDRE \rxdata_reg_reg[2] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[2]),
        .Q(rxdata_reg__0[2]),
        .R(1'b0));
FDRE \rxdata_reg_reg[3] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[3]),
        .Q(rxdata_reg__0[3]),
        .R(1'b0));
FDRE \rxdata_reg_reg[4] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[4]),
        .Q(rxdata_reg__0[4]),
        .R(1'b0));
FDRE \rxdata_reg_reg[5] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[5]),
        .Q(rxdata_reg__0[5]),
        .R(1'b0));
FDRE \rxdata_reg_reg[6] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[6]),
        .Q(rxdata_reg__0[6]),
        .R(1'b0));
FDRE \rxdata_reg_reg[7] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[7]),
        .Q(rxdata_reg__0[7]),
        .R(1'b0));
FDRE \rxdata_reg_reg[8] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[8]),
        .Q(rxdata_reg__0[8]),
        .R(1'b0));
FDRE \rxdata_reg_reg[9] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdata_out[9]),
        .Q(rxdata_reg__0[9]),
        .R(1'b0));
FDRE \rxdisperr_double_reg[0] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdisperr_reg__0[0]),
        .Q(rxdisperr_double[0]),
        .R(SR));
FDRE \rxdisperr_double_reg[1] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxdisperr_reg__0[1]),
        .Q(rxdisperr_double[1]),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair135" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     rxdisperr_i_1
       (.I0(rxdisperr_double[1]),
        .I1(toggle),
        .I2(rxdisperr_double[0]),
        .O(n_0_rxdisperr_i_1));
FDRE rxdisperr_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_rxdisperr_i_1),
        .Q(gt0_rxdisperr_out),
        .R(SR));
FDRE \rxdisperr_reg_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdisperr_out_1[0]),
        .Q(rxdisperr_reg__0[0]),
        .R(1'b0));
FDRE \rxdisperr_reg_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxdisperr_out_1[1]),
        .Q(rxdisperr_reg__0[1]),
        .R(1'b0));
FDRE \rxnotintable_double_reg[0] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxnotintable_reg__0[0]),
        .Q(rxnotintable_double[0]),
        .R(SR));
FDRE \rxnotintable_double_reg[1] 
       (.C(userclk2),
        .CE(toggle),
        .D(rxnotintable_reg__0[1]),
        .Q(rxnotintable_double[1]),
        .R(SR));
(* SOFT_HLUTNM = "soft_lutpair135" *) 
   LUT3 #(
    .INIT(8'hB8)) 
     rxnotintable_i_1
       (.I0(rxnotintable_double[1]),
        .I1(toggle),
        .I2(rxnotintable_double[0]),
        .O(n_0_rxnotintable_i_1));
FDRE rxnotintable_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_rxnotintable_i_1),
        .Q(gt0_rxnotintable_out),
        .R(SR));
FDRE \rxnotintable_reg_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxnotintable_out_0[0]),
        .Q(rxnotintable_reg__0[0]),
        .R(1'b0));
FDRE \rxnotintable_reg_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_rxnotintable_out_0[1]),
        .Q(rxnotintable_reg__0[1]),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     rxpowerdown_double_reg
       (.C(userclk2),
        .CE(toggle),
        .D(rxpowerdown_reg__0),
        .Q(rxpowerdown_double),
        .R(SR));
FDRE #(
    .INIT(1'b0)) 
     rxpowerdown_reg
       (.C(userclk),
        .CE(1'b1),
        .D(rxpowerdown_double),
        .Q(rxpowerdown),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     rxpowerdown_reg_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(Q),
        .Q(rxpowerdown_reg__0),
        .R(SR));
(* DONT_TOUCH *) 
   (* INITIALISE = "2'b00" *) 
   gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_1_sync_block__parameterized0__42 sync_block_data_valid
       (.clk(independent_clock_bufg),
        .data_in(data_valid_reg),
        .data_out(data_out));
LUT1 #(
    .INIT(2'h1)) 
     toggle_i_1
       (.I0(toggle),
        .O(n_0_toggle_i_1));
FDRE toggle_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(n_0_toggle_i_1),
        .Q(toggle),
        .R(txreset));
FDRE txbuferr_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(\n_0_txbufstatus_reg_reg[1] ),
        .Q(txbuferr),
        .R(1'b0));
FDRE \txbufstatus_reg_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(gt0_txbufstatus_out[1]),
        .Q(\n_0_txbufstatus_reg_reg[1] ),
        .R(1'b0));
FDRE \txchardispmode_double_reg[0] 
       (.C(userclk2),
        .CE(I1),
        .D(txchardispmode_reg),
        .Q(txchardispmode_double[0]),
        .R(txreset));
FDRE \txchardispmode_double_reg[1] 
       (.C(userclk2),
        .CE(I1),
        .D(txchardispmode),
        .Q(txchardispmode_double[1]),
        .R(txreset));
FDRE \txchardispmode_int_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(txchardispmode_double[0]),
        .Q(txchardispmode_int[0]),
        .R(1'b0));
FDRE \txchardispmode_int_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(txchardispmode_double[1]),
        .Q(txchardispmode_int[1]),
        .R(1'b0));
FDRE txchardispmode_reg_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(txchardispmode),
        .Q(txchardispmode_reg),
        .R(txreset));
FDRE \txchardispval_double_reg[0] 
       (.C(userclk2),
        .CE(I1),
        .D(txchardispval_reg),
        .Q(txchardispval_double[0]),
        .R(txreset));
FDRE \txchardispval_double_reg[1] 
       (.C(userclk2),
        .CE(I1),
        .D(txchardispval),
        .Q(txchardispval_double[1]),
        .R(txreset));
FDRE \txchardispval_int_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(txchardispval_double[0]),
        .Q(txchardispval_int[0]),
        .R(1'b0));
FDRE \txchardispval_int_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(txchardispval_double[1]),
        .Q(txchardispval_int[1]),
        .R(1'b0));
FDRE txchardispval_reg_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(txchardispval),
        .Q(txchardispval_reg),
        .R(txreset));
FDRE \txcharisk_double_reg[0] 
       (.C(userclk2),
        .CE(I1),
        .D(txcharisk_reg),
        .Q(\n_0_txcharisk_double_reg[0] ),
        .R(txreset));
FDRE \txcharisk_double_reg[1] 
       (.C(userclk2),
        .CE(I1),
        .D(txcharisk),
        .Q(\n_0_txcharisk_double_reg[1] ),
        .R(txreset));
FDRE \txcharisk_int_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(\n_0_txcharisk_double_reg[0] ),
        .Q(txcharisk_int[0]),
        .R(1'b0));
FDRE \txcharisk_int_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(\n_0_txcharisk_double_reg[1] ),
        .Q(txcharisk_int[1]),
        .R(1'b0));
FDRE txcharisk_reg_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(txcharisk),
        .Q(txcharisk_reg),
        .R(txreset));
FDRE \txdata_double_reg[0] 
       (.C(userclk2),
        .CE(I1),
        .D(txdata_reg[0]),
        .Q(txdata_double[0]),
        .R(txreset));
FDRE \txdata_double_reg[10] 
       (.C(userclk2),
        .CE(I1),
        .D(D[2]),
        .Q(txdata_double[10]),
        .R(txreset));
FDRE \txdata_double_reg[11] 
       (.C(userclk2),
        .CE(I1),
        .D(D[3]),
        .Q(txdata_double[11]),
        .R(txreset));
FDRE \txdata_double_reg[12] 
       (.C(userclk2),
        .CE(I1),
        .D(D[4]),
        .Q(txdata_double[12]),
        .R(txreset));
FDRE \txdata_double_reg[13] 
       (.C(userclk2),
        .CE(I1),
        .D(D[5]),
        .Q(txdata_double[13]),
        .R(txreset));
FDRE \txdata_double_reg[14] 
       (.C(userclk2),
        .CE(I1),
        .D(D[6]),
        .Q(txdata_double[14]),
        .R(txreset));
FDRE \txdata_double_reg[15] 
       (.C(userclk2),
        .CE(I1),
        .D(D[7]),
        .Q(txdata_double[15]),
        .R(txreset));
FDRE \txdata_double_reg[1] 
       (.C(userclk2),
        .CE(I1),
        .D(txdata_reg[1]),
        .Q(txdata_double[1]),
        .R(txreset));
FDRE \txdata_double_reg[2] 
       (.C(userclk2),
        .CE(I1),
        .D(txdata_reg[2]),
        .Q(txdata_double[2]),
        .R(txreset));
FDRE \txdata_double_reg[3] 
       (.C(userclk2),
        .CE(I1),
        .D(txdata_reg[3]),
        .Q(txdata_double[3]),
        .R(txreset));
FDRE \txdata_double_reg[4] 
       (.C(userclk2),
        .CE(I1),
        .D(txdata_reg[4]),
        .Q(txdata_double[4]),
        .R(txreset));
FDRE \txdata_double_reg[5] 
       (.C(userclk2),
        .CE(I1),
        .D(txdata_reg[5]),
        .Q(txdata_double[5]),
        .R(txreset));
FDRE \txdata_double_reg[6] 
       (.C(userclk2),
        .CE(I1),
        .D(txdata_reg[6]),
        .Q(txdata_double[6]),
        .R(txreset));
FDRE \txdata_double_reg[7] 
       (.C(userclk2),
        .CE(I1),
        .D(txdata_reg[7]),
        .Q(txdata_double[7]),
        .R(txreset));
FDRE \txdata_double_reg[8] 
       (.C(userclk2),
        .CE(I1),
        .D(D[0]),
        .Q(txdata_double[8]),
        .R(txreset));
FDRE \txdata_double_reg[9] 
       (.C(userclk2),
        .CE(I1),
        .D(D[1]),
        .Q(txdata_double[9]),
        .R(txreset));
FDRE \txdata_int_reg[0] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[0]),
        .Q(txdata_int[0]),
        .R(1'b0));
FDRE \txdata_int_reg[10] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[10]),
        .Q(txdata_int[10]),
        .R(1'b0));
FDRE \txdata_int_reg[11] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[11]),
        .Q(txdata_int[11]),
        .R(1'b0));
FDRE \txdata_int_reg[12] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[12]),
        .Q(txdata_int[12]),
        .R(1'b0));
FDRE \txdata_int_reg[13] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[13]),
        .Q(txdata_int[13]),
        .R(1'b0));
FDRE \txdata_int_reg[14] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[14]),
        .Q(txdata_int[14]),
        .R(1'b0));
FDRE \txdata_int_reg[15] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[15]),
        .Q(txdata_int[15]),
        .R(1'b0));
FDRE \txdata_int_reg[1] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[1]),
        .Q(txdata_int[1]),
        .R(1'b0));
FDRE \txdata_int_reg[2] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[2]),
        .Q(txdata_int[2]),
        .R(1'b0));
FDRE \txdata_int_reg[3] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[3]),
        .Q(txdata_int[3]),
        .R(1'b0));
FDRE \txdata_int_reg[4] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[4]),
        .Q(txdata_int[4]),
        .R(1'b0));
FDRE \txdata_int_reg[5] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[5]),
        .Q(txdata_int[5]),
        .R(1'b0));
FDRE \txdata_int_reg[6] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[6]),
        .Q(txdata_int[6]),
        .R(1'b0));
FDRE \txdata_int_reg[7] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[7]),
        .Q(txdata_int[7]),
        .R(1'b0));
FDRE \txdata_int_reg[8] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[8]),
        .Q(txdata_int[8]),
        .R(1'b0));
FDRE \txdata_int_reg[9] 
       (.C(userclk),
        .CE(1'b1),
        .D(txdata_double[9]),
        .Q(txdata_int[9]),
        .R(1'b0));
FDRE \txdata_reg_reg[0] 
       (.C(userclk2),
        .CE(1'b1),
        .D(D[0]),
        .Q(txdata_reg[0]),
        .R(txreset));
FDRE \txdata_reg_reg[1] 
       (.C(userclk2),
        .CE(1'b1),
        .D(D[1]),
        .Q(txdata_reg[1]),
        .R(txreset));
FDRE \txdata_reg_reg[2] 
       (.C(userclk2),
        .CE(1'b1),
        .D(D[2]),
        .Q(txdata_reg[2]),
        .R(txreset));
FDRE \txdata_reg_reg[3] 
       (.C(userclk2),
        .CE(1'b1),
        .D(D[3]),
        .Q(txdata_reg[3]),
        .R(txreset));
FDRE \txdata_reg_reg[4] 
       (.C(userclk2),
        .CE(1'b1),
        .D(D[4]),
        .Q(txdata_reg[4]),
        .R(txreset));
FDRE \txdata_reg_reg[5] 
       (.C(userclk2),
        .CE(1'b1),
        .D(D[5]),
        .Q(txdata_reg[5]),
        .R(txreset));
FDRE \txdata_reg_reg[6] 
       (.C(userclk2),
        .CE(1'b1),
        .D(D[6]),
        .Q(txdata_reg[6]),
        .R(txreset));
FDRE \txdata_reg_reg[7] 
       (.C(userclk2),
        .CE(1'b1),
        .D(D[7]),
        .Q(txdata_reg[7]),
        .R(txreset));
FDRE #(
    .INIT(1'b0)) 
     txpowerdown_double_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(txpowerdown_reg__0),
        .Q(txpowerdown_double),
        .R(txreset));
FDRE #(
    .INIT(1'b0)) 
     txpowerdown_reg
       (.C(userclk),
        .CE(1'b1),
        .D(txpowerdown_double),
        .Q(txpowerdown),
        .R(1'b0));
FDRE #(
    .INIT(1'b0)) 
     txpowerdown_reg_reg
       (.C(userclk2),
        .CE(1'b1),
        .D(Q),
        .Q(txpowerdown_reg__0),
        .R(txreset));
endmodule

(* ORIG_REF_NAME = "gig_ethernet_pcs_pma_v14_2" *) 
module gig_ethernet_pcs_pma_1gig_ethernet_pcs_pma_v14_2__parameterized0
   (txreset,
    rxreset,
    gmii_rx_er,
    status_vector,
    txchardispmode,
    txcharisk,
    encommaalign,
    gmii_rx_dv,
    an_interrupt,
    txchardispval,
    Q,
    O1,
    gmii_rxd,
    D,
    userclk2,
    gmii_tx_en,
    gmii_tx_er,
    gt0_rxnotintable_out,
    rxbuferr,
    txbuferr,
    gt0_rxdisperr_out,
    an_restart_config,
    reset,
    mmcm_locked,
    gmii_txd,
    data_out,
    an_adv_config_vector,
    gt0_rxcharisk_out,
    gt0_rxchariscomma_out,
    toggle,
    I1,
    signal_detect,
    configuration_vector,
    I2);
  output txreset;
  output rxreset;
  output gmii_rx_er;
  output [12:0]status_vector;
  output txchardispmode;
  output txcharisk;
  output encommaalign;
  output gmii_rx_dv;
  output an_interrupt;
  output txchardispval;
  output [1:0]Q;
  output O1;
  output [7:0]gmii_rxd;
  output [7:0]D;
  input userclk2;
  input gmii_tx_en;
  input gmii_tx_er;
  input [0:0]gt0_rxnotintable_out;
  input rxbuferr;
  input txbuferr;
  input [0:0]gt0_rxdisperr_out;
  input an_restart_config;
  input reset;
  input mmcm_locked;
  input [7:0]gmii_txd;
  input data_out;
  input [6:0]an_adv_config_vector;
  input [0:0]gt0_rxcharisk_out;
  input [0:0]gt0_rxchariscomma_out;
  input toggle;
  input [7:0]I1;
  input signal_detect;
  input [4:0]configuration_vector;
  input [1:0]I2;

  wire [7:0]D;
  wire [7:0]I1;
  wire [1:0]I2;
  wire O1;
  wire [1:0]Q;
  wire [6:0]an_adv_config_vector;
  wire an_interrupt;
  wire an_restart_config;
  wire [4:0]configuration_vector;
  wire data_out;
  wire encommaalign;
  wire gmii_rx_dv;
  wire gmii_rx_er;
  wire [7:0]gmii_rxd;
  wire gmii_tx_en;
  wire gmii_tx_er;
  wire [7:0]gmii_txd;
  wire [0:0]gt0_rxchariscomma_out;
  wire [0:0]gt0_rxcharisk_out;
  wire [0:0]gt0_rxdisperr_out;
  wire [0:0]gt0_rxnotintable_out;
  wire mmcm_locked;
  wire reset;
  wire rxbuferr;
  wire rxreset;
  wire signal_detect;
  wire [12:0]status_vector;
  wire toggle;
  wire txbuferr;
  wire txchardispmode;
  wire txchardispval;
  wire txcharisk;
  wire txreset;
  wire userclk2;

gig_ethernet_pcs_pma_1GPCS_PMA_GEN gpcs_pma_inst
       (.D(D),
        .I1(I1),
        .I2(I2),
        .O1(rxreset),
        .O2(O1),
        .Q(Q),
        .SR(txreset),
        .an_adv_config_vector(an_adv_config_vector),
        .an_interrupt(an_interrupt),
        .an_restart_config(an_restart_config),
        .configuration_vector(configuration_vector),
        .data_out(data_out),
        .encommaalign(encommaalign),
        .gmii_rx_dv(gmii_rx_dv),
        .gmii_rx_er(gmii_rx_er),
        .gmii_rxd(gmii_rxd),
        .gmii_tx_en(gmii_tx_en),
        .gmii_tx_er(gmii_tx_er),
        .gmii_txd(gmii_txd),
        .gt0_rxchariscomma_out(gt0_rxchariscomma_out),
        .gt0_rxcharisk_out(gt0_rxcharisk_out),
        .gt0_rxdisperr_out(gt0_rxdisperr_out),
        .gt0_rxnotintable_out(gt0_rxnotintable_out),
        .mmcm_locked(mmcm_locked),
        .reset(reset),
        .rxbuferr(rxbuferr),
        .signal_detect(signal_detect),
        .status_vector(status_vector),
        .toggle(toggle),
        .txbuferr(txbuferr),
        .txchardispmode(txchardispmode),
        .txchardispval(txchardispval),
        .txcharisk(txcharisk),
        .userclk2(userclk2));
endmodule

(* ORIG_REF_NAME = "sync_block" *) 
module gig_ethernet_pcs_pma_1sync_block__parameterized0
   (MASK_RUDI_BUFERR_TIMER0,
    data_out,
    SIGNAL_DETECT_MOD,
    p_0_in,
    Q,
    signal_detect,
    userclk2);
  output MASK_RUDI_BUFERR_TIMER0;
  output data_out;
  output SIGNAL_DETECT_MOD;
  input p_0_in;
  input [0:0]Q;
  input signal_detect;
  input userclk2;

  wire MASK_RUDI_BUFERR_TIMER0;
  wire [0:0]Q;
  wire SIGNAL_DETECT_MOD;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire p_0_in;
  wire signal_detect;
  wire userclk2;

(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT3 #(
    .INIT(8'h20)) 
     \MASK_RUDI_BUFERR_TIMER[8]_i_4 
       (.I0(p_0_in),
        .I1(Q),
        .I2(data_out),
        .O(MASK_RUDI_BUFERR_TIMER0));
(* SOFT_HLUTNM = "soft_lutpair45" *) 
   LUT2 #(
    .INIT(4'h2)) 
     SIGNAL_DETECT_REG_i_1
       (.I0(data_out),
        .I1(Q),
        .O(SIGNAL_DETECT_MOD));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg1
       (.C(userclk2),
        .CE(1'b1),
        .D(signal_detect),
        .Q(data_sync1),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg2
       (.C(userclk2),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg3
       (.C(userclk2),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg4
       (.C(userclk2),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg5
       (.C(userclk2),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
(* ASYNC_REG *) 
   (* SHREG_EXTRACT = "no" *) 
   (* XILINX_LEGACY_PRIM = "FD" *) 
   (* box_type = "PRIMITIVE" *) 
   FDRE #(
    .INIT(1'b0)) 
     data_sync_reg6
       (.C(userclk2),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
