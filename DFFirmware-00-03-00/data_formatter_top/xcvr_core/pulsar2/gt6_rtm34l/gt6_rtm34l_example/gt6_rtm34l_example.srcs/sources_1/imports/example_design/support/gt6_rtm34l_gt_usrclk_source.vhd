------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 3.2
--  \   \         Application : 7 Series FPGAs Transceivers Wizard 
--  /   /         Filename : gt6_rtm34l_gt_usrclk_source.vhd
-- /___/   /\      
-- \   \  /  \ 
--  \___\/\___\ 
--
--
-- Module gt6_rtm34l_GT_USRCLK_SOURCE (for use with GTs)
-- Generated by Xilinx 7 Series FPGAs Transceivers 7 Series FPGAs Transceivers Wizard
-- 
-- 
-- (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

--***********************************Entity Declaration*******************************
entity gt6_rtm34l_GT_USRCLK_SOURCE is
port
(
    Q1_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
    Q1_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;
    Q1_CLK0_GTREFCLK_OUT                    : out  std_logic;
    Q4_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
    Q4_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;
    Q4_CLK0_GTREFCLK_OUT                    : out  std_logic;
    Q7_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
    Q7_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;
    Q7_CLK0_GTREFCLK_OUT                    : out  std_logic;
 
    GT0_TXUSRCLK_OUT             : out std_logic;
    GT0_TXUSRCLK2_OUT            : out std_logic;
    GT0_TXOUTCLK_IN              : in  std_logic;
    GT0_RXUSRCLK_OUT             : out std_logic;
    GT0_RXUSRCLK2_OUT            : out std_logic;
 
    GT1_TXUSRCLK_OUT             : out std_logic;
    GT1_TXUSRCLK2_OUT            : out std_logic;
    GT1_TXOUTCLK_IN              : in  std_logic;
    GT1_RXUSRCLK_OUT             : out std_logic;
    GT1_RXUSRCLK2_OUT            : out std_logic;
 
    GT2_TXUSRCLK_OUT             : out std_logic;
    GT2_TXUSRCLK2_OUT            : out std_logic;
    GT2_TXOUTCLK_IN              : in  std_logic;
    GT2_RXUSRCLK_OUT             : out std_logic;
    GT2_RXUSRCLK2_OUT            : out std_logic;
 
    GT3_TXUSRCLK_OUT             : out std_logic;
    GT3_TXUSRCLK2_OUT            : out std_logic;
    GT3_TXOUTCLK_IN              : in  std_logic;
    GT3_RXUSRCLK_OUT             : out std_logic;
    GT3_RXUSRCLK2_OUT            : out std_logic;
 
    GT4_TXUSRCLK_OUT             : out std_logic;
    GT4_TXUSRCLK2_OUT            : out std_logic;
    GT4_TXOUTCLK_IN              : in  std_logic;
    GT4_RXUSRCLK_OUT             : out std_logic;
    GT4_RXUSRCLK2_OUT            : out std_logic;
 
    GT5_TXUSRCLK_OUT             : out std_logic;
    GT5_TXUSRCLK2_OUT            : out std_logic;
    GT5_TXOUTCLK_IN              : in  std_logic;
    GT5_RXUSRCLK_OUT             : out std_logic;
    GT5_RXUSRCLK2_OUT            : out std_logic;
 
    GT6_TXUSRCLK_OUT             : out std_logic;
    GT6_TXUSRCLK2_OUT            : out std_logic;
    GT6_TXOUTCLK_IN              : in  std_logic;
    GT6_RXUSRCLK_OUT             : out std_logic;
    GT6_RXUSRCLK2_OUT            : out std_logic;
 
    GT7_TXUSRCLK_OUT             : out std_logic;
    GT7_TXUSRCLK2_OUT            : out std_logic;
    GT7_TXOUTCLK_IN              : in  std_logic;
    GT7_RXUSRCLK_OUT             : out std_logic;
    GT7_RXUSRCLK2_OUT            : out std_logic;
 
    GT8_TXUSRCLK_OUT             : out std_logic;
    GT8_TXUSRCLK2_OUT            : out std_logic;
    GT8_TXOUTCLK_IN              : in  std_logic;
    GT8_RXUSRCLK_OUT             : out std_logic;
    GT8_RXUSRCLK2_OUT            : out std_logic;
 
    GT9_TXUSRCLK_OUT             : out std_logic;
    GT9_TXUSRCLK2_OUT            : out std_logic;
    GT9_TXOUTCLK_IN              : in  std_logic;
    GT9_RXUSRCLK_OUT             : out std_logic;
    GT9_RXUSRCLK2_OUT            : out std_logic;
 
    GT10_TXUSRCLK_OUT             : out std_logic;
    GT10_TXUSRCLK2_OUT            : out std_logic;
    GT10_TXOUTCLK_IN              : in  std_logic;
    GT10_RXUSRCLK_OUT             : out std_logic;
    GT10_RXUSRCLK2_OUT            : out std_logic;
 
    GT11_TXUSRCLK_OUT             : out std_logic;
    GT11_TXUSRCLK2_OUT            : out std_logic;
    GT11_TXOUTCLK_IN              : in  std_logic;
    GT11_RXUSRCLK_OUT             : out std_logic;
    GT11_RXUSRCLK2_OUT            : out std_logic;
 
    GT12_TXUSRCLK_OUT             : out std_logic;
    GT12_TXUSRCLK2_OUT            : out std_logic;
    GT12_TXOUTCLK_IN              : in  std_logic;
    GT12_RXUSRCLK_OUT             : out std_logic;
    GT12_RXUSRCLK2_OUT            : out std_logic;
 
    GT13_TXUSRCLK_OUT             : out std_logic;
    GT13_TXUSRCLK2_OUT            : out std_logic;
    GT13_TXOUTCLK_IN              : in  std_logic;
    GT13_RXUSRCLK_OUT             : out std_logic;
    GT13_RXUSRCLK2_OUT            : out std_logic;
 
    GT14_TXUSRCLK_OUT             : out std_logic;
    GT14_TXUSRCLK2_OUT            : out std_logic;
    GT14_TXOUTCLK_IN              : in  std_logic;
    GT14_RXUSRCLK_OUT             : out std_logic;
    GT14_RXUSRCLK2_OUT            : out std_logic;
 
    GT15_TXUSRCLK_OUT             : out std_logic;
    GT15_TXUSRCLK2_OUT            : out std_logic;
    GT15_TXOUTCLK_IN              : in  std_logic;
    GT15_RXUSRCLK_OUT             : out std_logic;
    GT15_RXUSRCLK2_OUT            : out std_logic;
 
    GT16_TXUSRCLK_OUT             : out std_logic;
    GT16_TXUSRCLK2_OUT            : out std_logic;
    GT16_TXOUTCLK_IN              : in  std_logic;
    GT16_RXUSRCLK_OUT             : out std_logic;
    GT16_RXUSRCLK2_OUT            : out std_logic;
 
    GT17_TXUSRCLK_OUT             : out std_logic;
    GT17_TXUSRCLK2_OUT            : out std_logic;
    GT17_TXOUTCLK_IN              : in  std_logic;
    GT17_RXUSRCLK_OUT             : out std_logic;
    GT17_RXUSRCLK2_OUT            : out std_logic;
 
    GT18_TXUSRCLK_OUT             : out std_logic;
    GT18_TXUSRCLK2_OUT            : out std_logic;
    GT18_TXOUTCLK_IN              : in  std_logic;
    GT18_RXUSRCLK_OUT             : out std_logic;
    GT18_RXUSRCLK2_OUT            : out std_logic;
 
    GT19_TXUSRCLK_OUT             : out std_logic;
    GT19_TXUSRCLK2_OUT            : out std_logic;
    GT19_TXOUTCLK_IN              : in  std_logic;
    GT19_RXUSRCLK_OUT             : out std_logic;
    GT19_RXUSRCLK2_OUT            : out std_logic;
 
    GT20_TXUSRCLK_OUT             : out std_logic;
    GT20_TXUSRCLK2_OUT            : out std_logic;
    GT20_TXOUTCLK_IN              : in  std_logic;
    GT20_RXUSRCLK_OUT             : out std_logic;
    GT20_RXUSRCLK2_OUT            : out std_logic;
 
    GT21_TXUSRCLK_OUT             : out std_logic;
    GT21_TXUSRCLK2_OUT            : out std_logic;
    GT21_TXOUTCLK_IN              : in  std_logic;
    GT21_RXUSRCLK_OUT             : out std_logic;
    GT21_RXUSRCLK2_OUT            : out std_logic;
 
    GT22_TXUSRCLK_OUT             : out std_logic;
    GT22_TXUSRCLK2_OUT            : out std_logic;
    GT22_TXOUTCLK_IN              : in  std_logic;
    GT22_RXUSRCLK_OUT             : out std_logic;
    GT22_RXUSRCLK2_OUT            : out std_logic;
 
    GT23_TXUSRCLK_OUT             : out std_logic;
    GT23_TXUSRCLK2_OUT            : out std_logic;
    GT23_TXOUTCLK_IN              : in  std_logic;
    GT23_RXUSRCLK_OUT             : out std_logic;
    GT23_RXUSRCLK2_OUT            : out std_logic;
 
    GT24_TXUSRCLK_OUT             : out std_logic;
    GT24_TXUSRCLK2_OUT            : out std_logic;
    GT24_TXOUTCLK_IN              : in  std_logic;
    GT24_RXUSRCLK_OUT             : out std_logic;
    GT24_RXUSRCLK2_OUT            : out std_logic;
 
    GT25_TXUSRCLK_OUT             : out std_logic;
    GT25_TXUSRCLK2_OUT            : out std_logic;
    GT25_TXOUTCLK_IN              : in  std_logic;
    GT25_RXUSRCLK_OUT             : out std_logic;
    GT25_RXUSRCLK2_OUT            : out std_logic;
 
    GT26_TXUSRCLK_OUT             : out std_logic;
    GT26_TXUSRCLK2_OUT            : out std_logic;
    GT26_TXOUTCLK_IN              : in  std_logic;
    GT26_RXUSRCLK_OUT             : out std_logic;
    GT26_RXUSRCLK2_OUT            : out std_logic;
 
    GT27_TXUSRCLK_OUT             : out std_logic;
    GT27_TXUSRCLK2_OUT            : out std_logic;
    GT27_TXOUTCLK_IN              : in  std_logic;
    GT27_RXUSRCLK_OUT             : out std_logic;
    GT27_RXUSRCLK2_OUT            : out std_logic;
 
    GT28_TXUSRCLK_OUT             : out std_logic;
    GT28_TXUSRCLK2_OUT            : out std_logic;
    GT28_TXOUTCLK_IN              : in  std_logic;
    GT28_RXUSRCLK_OUT             : out std_logic;
    GT28_RXUSRCLK2_OUT            : out std_logic;
 
    GT29_TXUSRCLK_OUT             : out std_logic;
    GT29_TXUSRCLK2_OUT            : out std_logic;
    GT29_TXOUTCLK_IN              : in  std_logic;
    GT29_RXUSRCLK_OUT             : out std_logic;
    GT29_RXUSRCLK2_OUT            : out std_logic;
 
    GT30_TXUSRCLK_OUT             : out std_logic;
    GT30_TXUSRCLK2_OUT            : out std_logic;
    GT30_TXOUTCLK_IN              : in  std_logic;
    GT30_RXUSRCLK_OUT             : out std_logic;
    GT30_RXUSRCLK2_OUT            : out std_logic;
 
    GT31_TXUSRCLK_OUT             : out std_logic;
    GT31_TXUSRCLK2_OUT            : out std_logic;
    GT31_TXOUTCLK_IN              : in  std_logic;
    GT31_RXUSRCLK_OUT             : out std_logic;
    GT31_RXUSRCLK2_OUT            : out std_logic;
 
    GT32_TXUSRCLK_OUT             : out std_logic;
    GT32_TXUSRCLK2_OUT            : out std_logic;
    GT32_TXOUTCLK_IN              : in  std_logic;
    GT32_RXUSRCLK_OUT             : out std_logic;
    GT32_RXUSRCLK2_OUT            : out std_logic;
 
    GT33_TXUSRCLK_OUT             : out std_logic;
    GT33_TXUSRCLK2_OUT            : out std_logic;
    GT33_TXOUTCLK_IN              : in  std_logic;
    GT33_RXUSRCLK_OUT             : out std_logic;
    GT33_RXUSRCLK2_OUT            : out std_logic;
    DRPCLK_IN                          : in  std_logic;
    DRPCLK_OUT                         : out std_logic
);


end gt6_rtm34l_GT_USRCLK_SOURCE;

architecture RTL of gt6_rtm34l_GT_USRCLK_SOURCE is

component GT6_RTM34L_CLOCK_MODULE is
generic
(
    MULT                : real              := 2.0;
    DIVIDE              : integer           := 2;    
    CLK_PERIOD          : real              := 6.4;    
    OUT0_DIVIDE         : real              := 2.0;
    OUT1_DIVIDE         : integer           := 2;
    OUT2_DIVIDE         : integer           := 2;
    OUT3_DIVIDE         : integer           := 2
);
port
 (-- Clock in ports
  CLK_IN           : in     std_logic;
  -- Clock out ports
  CLK0_OUT          : out    std_logic;
  CLK1_OUT          : out    std_logic;
  CLK2_OUT          : out    std_logic;
  CLK3_OUT          : out    std_logic;
  -- Status and control signals
  MMCM_RESET_IN     : in     std_logic;
  MMCM_LOCKED_OUT   : out    std_logic
 );
end component;

--*********************************Wire Declarations**********************************

    signal   tied_to_ground_i     :   std_logic;
    signal   tied_to_vcc_i        :   std_logic;
 
    signal   gt0_txoutclk_i :   std_logic;
 
    signal   gt1_txoutclk_i :   std_logic;
 
    signal   gt2_txoutclk_i :   std_logic;
 
    signal   gt3_txoutclk_i :   std_logic;
 
    signal   gt4_txoutclk_i :   std_logic;
 
    signal   gt5_txoutclk_i :   std_logic;
 
    signal   gt6_txoutclk_i :   std_logic;
 
    signal   gt7_txoutclk_i :   std_logic;
 
    signal   gt8_txoutclk_i :   std_logic;
 
    signal   gt9_txoutclk_i :   std_logic;
 
    signal   gt10_txoutclk_i :   std_logic;
 
    signal   gt11_txoutclk_i :   std_logic;
 
    signal   gt12_txoutclk_i :   std_logic;
 
    signal   gt13_txoutclk_i :   std_logic;
 
    signal   gt14_txoutclk_i :   std_logic;
 
    signal   gt15_txoutclk_i :   std_logic;
 
    signal   gt16_txoutclk_i :   std_logic;
 
    signal   gt17_txoutclk_i :   std_logic;
 
    signal   gt18_txoutclk_i :   std_logic;
 
    signal   gt19_txoutclk_i :   std_logic;
 
    signal   gt20_txoutclk_i :   std_logic;
 
    signal   gt21_txoutclk_i :   std_logic;
 
    signal   gt22_txoutclk_i :   std_logic;
 
    signal   gt23_txoutclk_i :   std_logic;
 
    signal   gt24_txoutclk_i :   std_logic;
 
    signal   gt25_txoutclk_i :   std_logic;
 
    signal   gt26_txoutclk_i :   std_logic;
 
    signal   gt27_txoutclk_i :   std_logic;
 
    signal   gt28_txoutclk_i :   std_logic;
 
    signal   gt29_txoutclk_i :   std_logic;
 
    signal   gt30_txoutclk_i :   std_logic;
 
    signal   gt31_txoutclk_i :   std_logic;
 
    signal   gt32_txoutclk_i :   std_logic;
 
    signal   gt33_txoutclk_i :   std_logic;

    attribute syn_noclockbuf : boolean;
    signal   q1_clk0_gtrefclk :   std_logic;
    attribute syn_noclockbuf of q1_clk0_gtrefclk : signal is true;
    signal   q4_clk0_gtrefclk :   std_logic;
    attribute syn_noclockbuf of q4_clk0_gtrefclk : signal is true;
    signal   q7_clk0_gtrefclk :   std_logic;
    attribute syn_noclockbuf of q7_clk0_gtrefclk : signal is true;

    signal  gt0_txusrclk_i                  : std_logic;
    signal  gt12_txusrclk_i                 : std_logic;
    signal  gt24_txusrclk_i                 : std_logic;


begin

--*********************************** Beginning of Code *******************************

    --  Static signal Assigments    
    tied_to_ground_i         <= '0';
    tied_to_vcc_i            <= '1';
    gt0_txoutclk_i                               <= GT0_TXOUTCLK_IN;
    gt1_txoutclk_i                               <= GT1_TXOUTCLK_IN;
    gt2_txoutclk_i                               <= GT2_TXOUTCLK_IN;
    gt3_txoutclk_i                               <= GT3_TXOUTCLK_IN;
    gt4_txoutclk_i                               <= GT4_TXOUTCLK_IN;
    gt5_txoutclk_i                               <= GT5_TXOUTCLK_IN;
    gt6_txoutclk_i                               <= GT6_TXOUTCLK_IN;
    gt7_txoutclk_i                               <= GT7_TXOUTCLK_IN;
    gt8_txoutclk_i                               <= GT8_TXOUTCLK_IN;
    gt9_txoutclk_i                               <= GT9_TXOUTCLK_IN;
    gt10_txoutclk_i                              <= GT10_TXOUTCLK_IN;
    gt11_txoutclk_i                              <= GT11_TXOUTCLK_IN;
    gt12_txoutclk_i                              <= GT12_TXOUTCLK_IN;
    gt13_txoutclk_i                              <= GT13_TXOUTCLK_IN;
    gt14_txoutclk_i                              <= GT14_TXOUTCLK_IN;
    gt15_txoutclk_i                              <= GT15_TXOUTCLK_IN;
    gt16_txoutclk_i                              <= GT16_TXOUTCLK_IN;
    gt17_txoutclk_i                              <= GT17_TXOUTCLK_IN;
    gt18_txoutclk_i                              <= GT18_TXOUTCLK_IN;
    gt19_txoutclk_i                              <= GT19_TXOUTCLK_IN;
    gt20_txoutclk_i                              <= GT20_TXOUTCLK_IN;
    gt21_txoutclk_i                              <= GT21_TXOUTCLK_IN;
    gt22_txoutclk_i                              <= GT22_TXOUTCLK_IN;
    gt23_txoutclk_i                              <= GT23_TXOUTCLK_IN;
    gt24_txoutclk_i                              <= GT24_TXOUTCLK_IN;
    gt25_txoutclk_i                              <= GT25_TXOUTCLK_IN;
    gt26_txoutclk_i                              <= GT26_TXOUTCLK_IN;
    gt27_txoutclk_i                              <= GT27_TXOUTCLK_IN;
    gt28_txoutclk_i                              <= GT28_TXOUTCLK_IN;
    gt29_txoutclk_i                              <= GT29_TXOUTCLK_IN;
    gt30_txoutclk_i                              <= GT30_TXOUTCLK_IN;
    gt31_txoutclk_i                              <= GT31_TXOUTCLK_IN;
    gt32_txoutclk_i                              <= GT32_TXOUTCLK_IN;
    gt33_txoutclk_i                              <= GT33_TXOUTCLK_IN;

    Q1_CLK0_GTREFCLK_OUT                         <= q1_clk0_gtrefclk;
    Q4_CLK0_GTREFCLK_OUT                         <= q4_clk0_gtrefclk;
    Q7_CLK0_GTREFCLK_OUT                         <= q7_clk0_gtrefclk;

    --IBUFDS_GTE2
    ibufds_instq1_clk0 : IBUFDS_GTE2  
    port map
    (
        O               => 	q1_clk0_gtrefclk,
        ODIV2           =>    open,
        CEB             => 	tied_to_ground_i,
        I               => 	Q1_CLK0_GTREFCLK_PAD_P_IN,
        IB              => 	Q1_CLK0_GTREFCLK_PAD_N_IN
    );
    --IBUFDS_GTE2
    ibufds_instq4_clk0 : IBUFDS_GTE2  
    port map
    (
        O               => 	q4_clk0_gtrefclk,
        ODIV2           =>    open,
        CEB             => 	tied_to_ground_i,
        I               => 	Q4_CLK0_GTREFCLK_PAD_P_IN,
        IB              => 	Q4_CLK0_GTREFCLK_PAD_N_IN
    );
    --IBUFDS_GTE2
    ibufds_instq7_clk0 : IBUFDS_GTE2  
    port map
    (
        O               => 	q7_clk0_gtrefclk,
        ODIV2           =>    open,
        CEB             => 	tied_to_ground_i,
        I               => 	Q7_CLK0_GTREFCLK_PAD_P_IN,
        IB              => 	Q7_CLK0_GTREFCLK_PAD_N_IN
    );


   --IBUFDS_DRP_CLK : IBUFDS
   --port map
   --  (
   --     I  => DRPCLK_IN_P,
   --     IB => DRPCLK_IN_N,
   --     O  => DRPCLK_IN
   --  );
 
   --DRP_CLK_BUFG : BUFG 
   --port map 
   -- (
   --     I    => DRPCLK_IN,
   --     O    => DRPCLK_OUT 
   -- );
    
    DRPCLK_OUT <= DRPCLK_IN;
    -- Instantiate a MMCM module to divide the reference clock. Uses internal feedback
    -- for improved jitter performance, and to avoid consuming an additional BUFG

    txoutclk_bufg0_i : BUFG
    port map
    (
        I                               =>      gt0_txoutclk_i,
        O                               =>      gt0_txusrclk_i
    );


    txoutclk_bufg1_i : BUFG
    port map
    (
        I                               =>      gt12_txoutclk_i,
        O                               =>      gt12_txusrclk_i
    );


    txoutclk_bufg2_i : BUFG
    port map
    (
        I                               =>      gt24_txoutclk_i,
        O                               =>      gt24_txusrclk_i
    );



 
GT0_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT0_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT0_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT0_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT1_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT1_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT1_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT1_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT2_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT2_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT2_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT2_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT3_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT3_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT3_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT3_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT4_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT4_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT4_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT4_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT5_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT5_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT5_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT5_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT6_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT6_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT6_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT6_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT7_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT7_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT7_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT7_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT8_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT8_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT8_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT8_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT9_TXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT9_TXUSRCLK2_OUT                            <= gt0_txusrclk_i;
GT9_RXUSRCLK_OUT                             <= gt0_txusrclk_i;
GT9_RXUSRCLK2_OUT                            <= gt0_txusrclk_i;
 
GT10_TXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT10_TXUSRCLK2_OUT                           <= gt0_txusrclk_i;
GT10_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT10_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT11_TXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT11_TXUSRCLK2_OUT                           <= gt0_txusrclk_i;
GT11_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT11_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT12_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT12_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT12_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT12_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT13_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT13_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT13_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT13_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT14_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT14_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT14_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT14_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT15_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT15_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT15_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT15_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT16_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT16_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT16_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT16_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT17_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT17_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT17_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT17_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT18_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT18_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT18_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT18_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT19_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT19_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT19_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT19_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT20_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT20_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT20_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT20_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT21_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT21_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT21_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT21_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT22_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT22_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT22_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT22_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT23_TXUSRCLK_OUT                            <= gt12_txusrclk_i;
GT23_TXUSRCLK2_OUT                           <= gt12_txusrclk_i;
GT23_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT23_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT24_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT24_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT24_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT24_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT25_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT25_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT25_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT25_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT26_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT26_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT26_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT26_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT27_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT27_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT27_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT27_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT28_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT28_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT28_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT28_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT29_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT29_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT29_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT29_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT30_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT30_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT30_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT30_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT31_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT31_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT31_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT31_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT32_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT32_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT32_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT32_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
 
GT33_TXUSRCLK_OUT                            <= gt24_txusrclk_i;
GT33_TXUSRCLK2_OUT                           <= gt24_txusrclk_i;
GT33_RXUSRCLK_OUT                            <= gt0_txusrclk_i;
GT33_RXUSRCLK2_OUT                           <= gt0_txusrclk_i;
end RTL;

