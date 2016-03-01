-- (c) Copyright 1995-2015 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:gig_ethernet_pcs_pma:15.1
-- IP Revision: 0

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT gig_ethernet_pcs_pma_1
  PORT (
    gtrefclk_bufg : IN STD_LOGIC;
    gtrefclk : IN STD_LOGIC;
    txn : OUT STD_LOGIC;
    txp : OUT STD_LOGIC;
    rxn : IN STD_LOGIC;
    rxp : IN STD_LOGIC;
    independent_clock_bufg : IN STD_LOGIC;
    txoutclk : OUT STD_LOGIC;
    rxoutclk : OUT STD_LOGIC;
    resetdone : OUT STD_LOGIC;
    cplllock : OUT STD_LOGIC;
    mmcm_reset : OUT STD_LOGIC;
    userclk : IN STD_LOGIC;
    userclk2 : IN STD_LOGIC;
    pma_reset : IN STD_LOGIC;
    mmcm_locked : IN STD_LOGIC;
    rxuserclk : IN STD_LOGIC;
    rxuserclk2 : IN STD_LOGIC;
    gmii_txd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    gmii_tx_en : IN STD_LOGIC;
    gmii_tx_er : IN STD_LOGIC;
    gmii_rxd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    gmii_rx_dv : OUT STD_LOGIC;
    gmii_rx_er : OUT STD_LOGIC;
    gmii_isolate : OUT STD_LOGIC;
    configuration_vector : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    an_interrupt : OUT STD_LOGIC;
    an_adv_config_vector : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    an_restart_config : IN STD_LOGIC;
    status_vector : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    reset : IN STD_LOGIC;
    signal_detect : IN STD_LOGIC;
    gt0_qplloutclk_in : IN STD_LOGIC;
    gt0_qplloutrefclk_in : IN STD_LOGIC;
    gt0_rxchariscomma_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    gt0_rxcharisk_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    gt0_rxbyteisaligned_out : OUT STD_LOGIC;
    gt0_rxbyterealign_out : OUT STD_LOGIC;
    gt0_rxcommadet_out : OUT STD_LOGIC;
    gt0_txpolarity_in : IN STD_LOGIC;
    gt0_txdiffctrl_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    gt0_txpostcursor_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    gt0_txprecursor_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    gt0_rxpolarity_in : IN STD_LOGIC;
    gt0_txinhibit_in : IN STD_LOGIC;
    gt0_txprbssel_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    gt0_txprbsforceerr_in : IN STD_LOGIC;
    gt0_rxprbscntreset_in : IN STD_LOGIC;
    gt0_rxprbserr_out : OUT STD_LOGIC;
    gt0_rxprbssel_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    gt0_loopback_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    gt0_txresetdone_out : OUT STD_LOGIC;
    gt0_rxresetdone_out : OUT STD_LOGIC;
    gt0_rxpmaresetdone_out : OUT STD_LOGIC;
    gt0_rxdisperr_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    gt0_txbufstatus_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    gt0_rxnotintable_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    gt0_eyescanreset_in : IN STD_LOGIC;
    gt0_eyescandataerror_out : OUT STD_LOGIC;
    gt0_eyescantrigger_in : IN STD_LOGIC;
    gt0_rxcdrhold_in : IN STD_LOGIC;
    gt0_rxpmareset_in : IN STD_LOGIC;
    gt0_txpmareset_in : IN STD_LOGIC;
    gt0_rxpcsreset_in : IN STD_LOGIC;
    gt0_txpcsreset_in : IN STD_LOGIC;
    gt0_rxbufreset_in : IN STD_LOGIC;
    gt0_rxbufstatus_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    gt0_rxdfelpmreset_in : IN STD_LOGIC;
    gt0_rxdfeagcovrden_in : IN STD_LOGIC;
    gt0_rxlpmen_in : IN STD_LOGIC;
    gt0_rxmonitorout_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    gt0_rxmonitorsel_in : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    gt0_drpaddr_in : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    gt0_drpclk_in : IN STD_LOGIC;
    gt0_drpdi_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    gt0_drpdo_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    gt0_drpen_in : IN STD_LOGIC;
    gt0_drprdy_out : OUT STD_LOGIC;
    gt0_drpwe_in : IN STD_LOGIC;
    gt0_dmonitorout_out : OUT STD_LOGIC_VECTOR(14 DOWNTO 0)
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : gig_ethernet_pcs_pma_1
  PORT MAP (
    gtrefclk_bufg => gtrefclk_bufg,
    gtrefclk => gtrefclk,
    txn => txn,
    txp => txp,
    rxn => rxn,
    rxp => rxp,
    independent_clock_bufg => independent_clock_bufg,
    txoutclk => txoutclk,
    rxoutclk => rxoutclk,
    resetdone => resetdone,
    cplllock => cplllock,
    mmcm_reset => mmcm_reset,
    userclk => userclk,
    userclk2 => userclk2,
    pma_reset => pma_reset,
    mmcm_locked => mmcm_locked,
    rxuserclk => rxuserclk,
    rxuserclk2 => rxuserclk2,
    gmii_txd => gmii_txd,
    gmii_tx_en => gmii_tx_en,
    gmii_tx_er => gmii_tx_er,
    gmii_rxd => gmii_rxd,
    gmii_rx_dv => gmii_rx_dv,
    gmii_rx_er => gmii_rx_er,
    gmii_isolate => gmii_isolate,
    configuration_vector => configuration_vector,
    an_interrupt => an_interrupt,
    an_adv_config_vector => an_adv_config_vector,
    an_restart_config => an_restart_config,
    status_vector => status_vector,
    reset => reset,
    signal_detect => signal_detect,
    gt0_qplloutclk_in => gt0_qplloutclk_in,
    gt0_qplloutrefclk_in => gt0_qplloutrefclk_in,
    gt0_rxchariscomma_out => gt0_rxchariscomma_out,
    gt0_rxcharisk_out => gt0_rxcharisk_out,
    gt0_rxbyteisaligned_out => gt0_rxbyteisaligned_out,
    gt0_rxbyterealign_out => gt0_rxbyterealign_out,
    gt0_rxcommadet_out => gt0_rxcommadet_out,
    gt0_txpolarity_in => gt0_txpolarity_in,
    gt0_txdiffctrl_in => gt0_txdiffctrl_in,
    gt0_txpostcursor_in => gt0_txpostcursor_in,
    gt0_txprecursor_in => gt0_txprecursor_in,
    gt0_rxpolarity_in => gt0_rxpolarity_in,
    gt0_txinhibit_in => gt0_txinhibit_in,
    gt0_txprbssel_in => gt0_txprbssel_in,
    gt0_txprbsforceerr_in => gt0_txprbsforceerr_in,
    gt0_rxprbscntreset_in => gt0_rxprbscntreset_in,
    gt0_rxprbserr_out => gt0_rxprbserr_out,
    gt0_rxprbssel_in => gt0_rxprbssel_in,
    gt0_loopback_in => gt0_loopback_in,
    gt0_txresetdone_out => gt0_txresetdone_out,
    gt0_rxresetdone_out => gt0_rxresetdone_out,
    gt0_rxpmaresetdone_out => gt0_rxpmaresetdone_out,
    gt0_rxdisperr_out => gt0_rxdisperr_out,
    gt0_txbufstatus_out => gt0_txbufstatus_out,
    gt0_rxnotintable_out => gt0_rxnotintable_out,
    gt0_eyescanreset_in => gt0_eyescanreset_in,
    gt0_eyescandataerror_out => gt0_eyescandataerror_out,
    gt0_eyescantrigger_in => gt0_eyescantrigger_in,
    gt0_rxcdrhold_in => gt0_rxcdrhold_in,
    gt0_rxpmareset_in => gt0_rxpmareset_in,
    gt0_txpmareset_in => gt0_txpmareset_in,
    gt0_rxpcsreset_in => gt0_rxpcsreset_in,
    gt0_txpcsreset_in => gt0_txpcsreset_in,
    gt0_rxbufreset_in => gt0_rxbufreset_in,
    gt0_rxbufstatus_out => gt0_rxbufstatus_out,
    gt0_rxdfelpmreset_in => gt0_rxdfelpmreset_in,
    gt0_rxdfeagcovrden_in => gt0_rxdfeagcovrden_in,
    gt0_rxlpmen_in => gt0_rxlpmen_in,
    gt0_rxmonitorout_out => gt0_rxmonitorout_out,
    gt0_rxmonitorsel_in => gt0_rxmonitorsel_in,
    gt0_drpaddr_in => gt0_drpaddr_in,
    gt0_drpclk_in => gt0_drpclk_in,
    gt0_drpdi_in => gt0_drpdi_in,
    gt0_drpdo_out => gt0_drpdo_out,
    gt0_drpen_in => gt0_drpen_in,
    gt0_drprdy_out => gt0_drprdy_out,
    gt0_drpwe_in => gt0_drpwe_in,
    gt0_dmonitorout_out => gt0_dmonitorout_out
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file gig_ethernet_pcs_pma_1.vhd when simulating
-- the core, gig_ethernet_pcs_pma_1. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

