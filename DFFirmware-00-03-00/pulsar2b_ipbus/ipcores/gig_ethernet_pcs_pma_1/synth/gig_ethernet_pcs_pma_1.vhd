--------------------------------------------------------------------------------
-- File       : gig_ethernet_pcs_pma_1.vhd
-- Author     : Xilinx Inc.
--------------------------------------------------------------------------------
-- (c) Copyright 2009 Xilinx, Inc. All rights reserved.
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
-- 
--------------------------------------------------------------------------------
-- Description: This Core Block Level wrapper connects the core to a  
--              Series-7 Transceiver.
--
--
--   ------------------------------------------------------------
--   |                      Core Block wrapper                  |
--   |                                                          |
--   |        ------------------          -----------------     |
--   |        |      Core      |          | Transceiver   |     |
--   |        |                |          |               |     |
--   |        |                |          |               |     |
--   |        |                |          |               |     |
-- ---------->| GMII           |--------->|           TXP |-------->
--   |        | Tx             |          |           TXN |     |
--   |        |                |          |               |     |
--   |        |                |          |               |     |
--   |        |                |          |               |     |
--   |        |                |          |               |     |
--   |        |                |          |               |     |
--   |        | GMII           |          |           RXP |     |
-- <----------| Rx             |<---------|           RXN |<--------
--   |        |                |          |               |     |
--   |        ------------------          -----------------     |
--   |                                                          |
--   ------------------------------------------------------------
--
--


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 



--------------------------------------------------------------------------------
-- The entity declaration for the Core Block wrapper.
--------------------------------------------------------------------------------

entity gig_ethernet_pcs_pma_1 is
      port(
      -- Transceiver Interface
      ---------------------


      gtrefclk                 : in  std_logic;                           -- Very high quality 125MHz clock for GT transceiver.
      txp                  : out std_logic;                    -- Differential +ve of serial transmission from PMA to PMD.
      txn                  : out std_logic;                    -- Differential -ve of serial transmission from PMA to PMD.
      rxp                  : in std_logic;                     -- Differential +ve for serial reception from PMD to PMA.
      rxn                  : in std_logic;                     -- Differential -ve for serial reception from PMD to PMA.
      resetdone                : out std_logic;                           -- The GT transceiver has completed its reset cycle
      cplllock                : out std_logic;                           -- The GT transceiver has completed its reset cycle
      txoutclk                 : out std_logic;                           -- txoutclk from GT transceiver (62.5MHz)
      rxoutclk                 : out std_logic;                           -- txoutclk from GT transceiver (62.5MHz)
      userclk                  : in  std_logic;                           -- 125MHz global clock.
      userclk2                 : in  std_logic;                           -- 125MHz global clock.
      rxuserclk                  : in  std_logic;                           -- 125MHz global clock.
      rxuserclk2                 : in  std_logic;                           -- 125MHz global clock.
      pma_reset                : in  std_logic;                           -- transceiver PMA reset signal
      mmcm_locked              : in  std_logic;                           -- MMCM Locked
      independent_clock_bufg : in std_logic;                   -- 200MHz independent cloc,

      -- GMII Interface
      -----------------
      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.


      an_interrupt         : out std_logic;                    -- Interrupt to processor to signal that Auto-Negotiation has completed
      an_adv_config_vector : in std_logic_vector(15 downto 0); -- Alternate interface to program REG4 (AN ADV)
      an_restart_config    : in std_logic;                     -- Alternate signal to modify AN restart bit in REG0


      -- General IO's
      ---------------
      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
      gt0_txpmareset_in         : in  std_logic;
      gt0_txpcsreset_in         : in  std_logic;
      gt0_rxpmareset_in         : in  std_logic;
      gt0_rxpcsreset_in         : in  std_logic;
      gt0_rxbufreset_in         : in  std_logic;
      gt0_rxpmaresetdone_out    : out std_logic;
      gt0_rxbufstatus_out       : out std_logic_vector(2 downto 0);
      gt0_txbufstatus_out       : out std_logic_vector(1 downto 0);
      gt0_dmonitorout_out       : out std_logic_vector(16 downto 0);
      gt0_drpaddr_in            : in   std_logic_vector(8 downto 0);
      gt0_drpclk_in             : in   std_logic;
      gt0_drpdi_in              : in   std_logic_vector(15 downto 0);
      gt0_drpdo_out             : out  std_logic_vector(15 downto 0);
      gt0_drpen_in              : in   std_logic;
      gt0_drprdy_out            : out  std_logic;
      gt0_drpwe_in              : in   std_logic;
      gt0_rxchariscomma_out     : out std_logic_vector(1 downto 0);
      gt0_rxcharisk_out         : out std_logic_vector(1 downto 0);
      gt0_rxbyteisaligned_out   : out std_logic;
      gt0_rxbyterealign_out     : out std_logic;
      gt0_rxcommadet_out        : out std_logic;
      gt0_txpolarity_in         : in  std_logic;
      gt0_txdiffctrl_in         : in  std_logic_vector(3 downto 0);
      gt0_txpostcursor_in       : in  std_logic_vector(4 downto 0);
      gt0_txprecursor_in        : in  std_logic_vector(4 downto 0);
      gt0_rxpolarity_in         : in  std_logic;
      gt0_rxdfelpmreset_in      : in  std_logic;
      gt0_rxdfeagcovrden_in     : in  std_logic;
      gt0_rxlpmen_in            : in  std_logic;
      gt0_txprbssel_in          : in  std_logic_vector(2 downto 0);
      gt0_txprbsforceerr_in     : in  std_logic;
      gt0_rxprbscntreset_in     : in  std_logic;
      gt0_rxprbserr_out         : out std_logic;
      gt0_rxprbssel_in          : in  std_logic_vector(2 downto 0);
      gt0_loopback_in           : in  std_logic_vector(2 downto 0);
      gt0_txresetdone_out       : out std_logic;
      gt0_rxresetdone_out       : out std_logic;
      gt0_rxdisperr_out         : out std_logic_vector(1 downto 0);
      gt0_rxnotintable_out      : out std_logic_vector(1 downto 0);
      gt0_eyescanreset_in       : in  std_logic;
      gt0_eyescandataerror_out  : out std_logic;
      gt0_eyescantrigger_in     : in  std_logic;
      gt0_rxcdrhold_in          : in  std_logic;
      gt0_rxmonitorout_out      : out std_logic_vector(6 downto 0);
      gt0_rxmonitorsel_in       : in  std_logic_vector(1 downto 0);
     
      signal_detect        : in std_logic;                      -- Input from PMD to indicate presence of optical input.
      gt0_qplloutclk_in      : in  std_logic;
      gt0_qplloutrefclk_in   : in  std_logic

      );
end gig_ethernet_pcs_pma_1;


architecture wrapper of gig_ethernet_pcs_pma_1 is

   attribute DowngradeIPIdentifiedWarnings: string;
   attribute DowngradeIPIdentifiedWarnings of wrapper : architecture is "yes";

   component gig_ethernet_pcs_pma_1_block
      port(
      -- Transceiver Interface
      ---------------------

      gtrefclk                 : in  std_logic;                           -- Very high quality 125MHz clock for GT transceiver.
      
      txp                  : out std_logic;                    -- Differential +ve of serial transmission from PMA to PMD.
      txn                  : out std_logic;                    -- Differential -ve of serial transmission from PMA to PMD.
      rxp                  : in std_logic;                     -- Differential +ve for serial reception from PMD to PMA.
      rxn                  : in std_logic;                     -- Differential -ve for serial reception from PMD to PMA.
      resetdone                : out std_logic;                           -- The GT transceiver has completed its reset cycle
      cplllock                : out std_logic;                           -- The GT transceiver has completed its reset cycle
      txoutclk                 : out std_logic;                           -- txoutclk from GT transceiver (62.5MHz)
      rxoutclk                 : out std_logic;                           -- txoutclk from GT transceiver (62.5MHz)
      userclk                  : in  std_logic;                           -- 125MHz global clock.
      userclk2                 : in  std_logic;                           -- 125MHz global clock.
      rxuserclk                  : in  std_logic;                           -- 125MHz global clock.
      rxuserclk2                 : in  std_logic;                           -- 125MHz global clock.
      independent_clock_bufg : in std_logic;                   -- 200MHz independent cloc,
      pma_reset                : in  std_logic;                           -- transceiver PMA reset signal
      mmcm_locked              : in  std_logic;                           -- MMCM Locked
      -- GMII Interface
      -----------------
      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.


      an_interrupt         : out std_logic;                    -- Interrupt to processor to signal that Auto-Negotiation has completed
      an_adv_config_vector : in std_logic_vector(15 downto 0); -- Alternate interface to program REG4 (AN ADV)
      an_restart_config    : in std_logic;                     -- Alternate signal to modify AN restart bit in REG0

      -- General IO's
      ---------------
      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
      gt0_txpmareset_in         : in  std_logic;
      gt0_txpcsreset_in         : in  std_logic;
      gt0_rxpmareset_in         : in  std_logic;
      gt0_rxpcsreset_in         : in  std_logic;
      gt0_rxbufreset_in         : in  std_logic;
      gt0_rxpmaresetdone_out    : out std_logic;
      gt0_rxbufstatus_out       : out std_logic_vector(2 downto 0);
      gt0_txbufstatus_out       : out std_logic_vector(1 downto 0);
      gt0_dmonitorout_out       : out std_logic_vector(16 downto 0);
      gt0_drpaddr_in            : in   std_logic_vector(8 downto 0);
      gt0_drpclk_in             : in   std_logic;
      gt0_drpdi_in              : in   std_logic_vector(15 downto 0);
      gt0_drpdo_out             : out  std_logic_vector(15 downto 0);
      gt0_drpen_in              : in   std_logic;
      gt0_drprdy_out            : out  std_logic;
      gt0_drpwe_in              : in   std_logic;
      gt0_rxchariscomma_out     : out std_logic_vector(1 downto 0);
      gt0_rxcharisk_out         : out std_logic_vector(1 downto 0);
      gt0_rxbyteisaligned_out   : out std_logic;
      gt0_rxbyterealign_out     : out std_logic;
      gt0_rxcommadet_out        : out std_logic;
      gt0_txpolarity_in         : in  std_logic;
      gt0_txdiffctrl_in         : in  std_logic_vector(3 downto 0);
      gt0_txpostcursor_in       : in  std_logic_vector(4 downto 0);
      gt0_txprecursor_in        : in  std_logic_vector(4 downto 0);
      gt0_rxpolarity_in         : in  std_logic;
      gt0_rxdfelpmreset_in      : in  std_logic;
      gt0_rxdfeagcovrden_in     : in  std_logic;
      gt0_rxlpmen_in            : in  std_logic;
      gt0_txprbssel_in          : in  std_logic_vector(2 downto 0);
      gt0_txprbsforceerr_in     : in  std_logic;
      gt0_rxprbscntreset_in     : in  std_logic;
      gt0_rxprbserr_out         : out std_logic;
      gt0_rxprbssel_in          : in  std_logic_vector(2 downto 0);
      gt0_loopback_in           : in  std_logic_vector(2 downto 0);
      gt0_txresetdone_out       : out std_logic;
      gt0_rxresetdone_out       : out std_logic;
      gt0_rxdisperr_out         : out std_logic_vector(1 downto 0);
      gt0_rxnotintable_out      : out std_logic_vector(1 downto 0);
      gt0_eyescanreset_in       : in  std_logic;
      gt0_eyescandataerror_out  : out std_logic;
      gt0_eyescantrigger_in     : in  std_logic;
      gt0_rxcdrhold_in          : in  std_logic;
      gt0_rxmonitorout_out      : out std_logic_vector(6 downto 0);
      gt0_rxmonitorsel_in       : in  std_logic_vector(1 downto 0);
  
      signal_detect        : in std_logic;                      -- Input from PMD to indicate presence of optical input.

      gt0_qplloutclk_in      : in  std_logic;
      gt0_qplloutrefclk_in   : in  std_logic

      );
   end component;

ATTRIBUTE CORE_GENERATION_INFO : STRING;
ATTRIBUTE CORE_GENERATION_INFO OF wrapper : ARCHITECTURE IS "gig_ethernet_pcs_pma_1,gig_ethernet_pcs_pma_v14_2,{x_ipProduct=Vivado 2014.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=gig_ethernet_pcs_pma,x_ipVersion=14.2,x_ipCoreRevision=0,x_ipLanguage=VHDL,c_elaboration_transient_dir=.,c_component_name=gig_ethernet_pcs_pma_1,c_family=virtex7,c_is_sgmii=false,c_use_transceiver=true,c_use_tbi=false,c_use_lvds=false,c_has_an=true,c_has_mdio=false,c_has_ext_mdio=false,c_sgmii_phy_mode=false,c_dynamic_switching=false,c_transceiver_mode=A,c_sgmii_fabric_buffer=true,c_1588=0,gt_rx_byte_width=1,C_EMAC_IF_TEMAC=true,C_PHYADDR=1,EXAMPLE_SIMULATION=0,c_support_level=false,c_sub_core_name=gig_ethernet_pcs_pma_1_gt,c_transceivercontrol=true}";
ATTRIBUTE X_CORE_INFO : STRING;
ATTRIBUTE X_CORE_INFO OF wrapper: ARCHITECTURE IS "gig_ethernet_pcs_pma_v14_2,Vivado 2014.1";

begin



   U0 : gig_ethernet_pcs_pma_1_block
      port map(
      -- Transceiver Interface
      ---------------------

      gtrefclk                 => gtrefclk,
          txp                  => txp,
          txn                  => txn,
          rxp                  => rxp,
          rxn                  => rxn,
      resetdone                => resetdone,
      cplllock                 => cplllock,                           -- The GT transceiver has completed its reset cycle
      txoutclk                 => txoutclk,
      rxoutclk                 => rxoutclk,
      userclk                  => userclk,
      userclk2                 => userclk2,
      rxuserclk                  => rxuserclk,
      rxuserclk2                 => rxuserclk2,
          independent_clock_bufg => independent_clock_bufg,
      pma_reset                => pma_reset,
      mmcm_locked              => mmcm_locked,
      -- GMII Interface
      -----------------
          gmii_txd             => gmii_txd,
          gmii_tx_en           => gmii_tx_en,
          gmii_tx_er           => gmii_tx_er,
          gmii_rxd             => gmii_rxd,
          gmii_rx_dv           => gmii_rx_dv,
          gmii_rx_er           => gmii_rx_er,
          gmii_isolate         => gmii_isolate,

      -- Management: Alternative to MDIO Interface
      --------------------------------------------

          configuration_vector => configuration_vector,


          an_interrupt         => an_interrupt,
          an_adv_config_vector => an_adv_config_vector,
          an_restart_config    => an_restart_config,

      -- General IO's
      ---------------
          status_vector        => status_vector,
          reset                => reset,

      gt0_txpmareset_in         => gt0_txpmareset_in,
      gt0_txpcsreset_in         => gt0_txpcsreset_in,
      gt0_rxpmareset_in         => gt0_rxpmareset_in,
      gt0_rxpcsreset_in         => gt0_rxpcsreset_in,
      gt0_rxbufreset_in         => gt0_rxbufreset_in,
      gt0_rxpmaresetdone_out    => gt0_rxpmaresetdone_out,
      gt0_rxbufstatus_out       => gt0_rxbufstatus_out   ,
      gt0_txbufstatus_out       => gt0_txbufstatus_out   ,
      gt0_dmonitorout_out       => gt0_dmonitorout_out   ,
      gt0_drpaddr_in            => gt0_drpaddr_in,
      gt0_drpclk_in             => gt0_drpclk_in,
      gt0_drpdi_in              => gt0_drpdi_in,
      gt0_drpdo_out             => gt0_drpdo_out,
      gt0_drpen_in              => gt0_drpen_in,
      gt0_drprdy_out            => gt0_drprdy_out,
      gt0_drpwe_in              => gt0_drpwe_in,
      gt0_rxchariscomma_out     => gt0_rxchariscomma_out,
      gt0_rxcharisk_out         => gt0_rxcharisk_out,
      gt0_rxbyteisaligned_out   => gt0_rxbyteisaligned_out,
      gt0_rxbyterealign_out     => gt0_rxbyterealign_out,
      gt0_rxcommadet_out        => gt0_rxcommadet_out,
      gt0_txpolarity_in         => gt0_txpolarity_in,
      gt0_txdiffctrl_in         => gt0_txdiffctrl_in,
      gt0_txpostcursor_in       => gt0_txpostcursor_in,
      gt0_txprecursor_in        => gt0_txprecursor_in,
      gt0_rxpolarity_in         => gt0_rxpolarity_in,
      gt0_rxdfelpmreset_in      => gt0_rxdfelpmreset_in,
      gt0_rxdfeagcovrden_in     => gt0_rxdfeagcovrden_in,
      gt0_rxlpmen_in            => gt0_rxlpmen_in,
      gt0_txprbssel_in          => gt0_txprbssel_in,
      gt0_txprbsforceerr_in     => gt0_txprbsforceerr_in,
      gt0_rxprbscntreset_in     => gt0_rxprbscntreset_in,
      gt0_rxprbserr_out         => gt0_rxprbserr_out,
      gt0_rxprbssel_in          => gt0_rxprbssel_in,
      gt0_loopback_in           => gt0_loopback_in,
      gt0_txresetdone_out       => gt0_txresetdone_out,
      gt0_rxresetdone_out       => gt0_rxresetdone_out,
      gt0_rxdisperr_out         => gt0_rxdisperr_out,
      gt0_rxnotintable_out      => gt0_rxnotintable_out,
      gt0_eyescanreset_in       => gt0_eyescanreset_in,
      gt0_eyescandataerror_out  => gt0_eyescandataerror_out,
      gt0_eyescantrigger_in     => gt0_eyescantrigger_in,
      gt0_rxcdrhold_in          => gt0_rxcdrhold_in,
      gt0_rxmonitorout_out      => gt0_rxmonitorout_out,
      gt0_rxmonitorsel_in       => gt0_rxmonitorsel_in,
   
   

          signal_detect        => signal_detect,

      gt0_qplloutclk_in      => gt0_qplloutclk_in,
      gt0_qplloutrefclk_in   => gt0_qplloutrefclk_in

      );
end wrapper;

