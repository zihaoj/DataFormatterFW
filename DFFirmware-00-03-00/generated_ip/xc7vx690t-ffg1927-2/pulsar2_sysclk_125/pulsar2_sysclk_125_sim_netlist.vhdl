-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
-- Date        : Tue Feb 23 09:43:31 2016
-- Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
-- Command     : write_vhdl -force -mode funcsim
--               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/pulsar2_sysclk_125/pulsar2_sysclk_125_sim_netlist.vhdl
-- Design      : pulsar2_sysclk_125
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_sysclk_125_pulsar2_sysclk_125_clk_wiz is
  port (
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC;
    FMC_COMMON_CLK : out STD_LOGIC;
    MAIN_LOGIC_CLK : out STD_LOGIC;
    CLK50 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_sysclk_125_pulsar2_sysclk_125_clk_wiz : entity is "pulsar2_sysclk_125_clk_wiz";
end pulsar2_sysclk_125_pulsar2_sysclk_125_clk_wiz;

architecture STRUCTURE of pulsar2_sysclk_125_pulsar2_sysclk_125_clk_wiz is
  signal CLK50_pulsar2_sysclk_125 : STD_LOGIC;
  signal FMC_COMMON_CLK_pulsar2_sysclk_125 : STD_LOGIC;
  signal MAIN_LOGIC_CLK_pulsar2_sysclk_125 : STD_LOGIC;
  signal clk_in1_pulsar2_sysclk_125 : STD_LOGIC;
  signal clkfbout_buf_pulsar2_sysclk_125 : STD_LOGIC;
  signal clkfbout_pulsar2_sysclk_125 : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_PSDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcm_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkf_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkin1_ibufgds : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of clkin1_ibufgds : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of clkin1_ibufgds : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of clkin1_ibufgds : label is "AUTO";
  attribute BOX_TYPE of clkout1_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout2_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of clkout3_buf : label is "PRIMITIVE";
  attribute BOX_TYPE of mmcm_adv_inst : label is "PRIMITIVE";
begin
clkf_buf: unisim.vcomponents.BUFG
     port map (
      I => clkfbout_pulsar2_sysclk_125,
      O => clkfbout_buf_pulsar2_sysclk_125
    );
clkin1_ibufgds: unisim.vcomponents.IBUFDS
    generic map(
      DQS_BIAS => "FALSE",
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => clk_in1_p,
      IB => clk_in1_n,
      O => clk_in1_pulsar2_sysclk_125
    );
clkout1_buf: unisim.vcomponents.BUFG
     port map (
      I => FMC_COMMON_CLK_pulsar2_sysclk_125,
      O => FMC_COMMON_CLK
    );
clkout2_buf: unisim.vcomponents.BUFG
     port map (
      I => MAIN_LOGIC_CLK_pulsar2_sysclk_125,
      O => MAIN_LOGIC_CLK
    );
clkout3_buf: unisim.vcomponents.BUFG
     port map (
      I => CLK50_pulsar2_sysclk_125,
      O => CLK50
    );
mmcm_adv_inst: unisim.vcomponents.MMCME2_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT_F => 5.000000,
      CLKFBOUT_PHASE => 0.000000,
      CLKFBOUT_USE_FINE_PS => false,
      CLKIN1_PERIOD => 5.000000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE_F => 5.000000,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT0_USE_FINE_PS => false,
      CLKOUT1_DIVIDE => 8,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT1_USE_FINE_PS => false,
      CLKOUT2_DIVIDE => 20,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT2_USE_FINE_PS => false,
      CLKOUT3_DIVIDE => 1,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT3_USE_FINE_PS => false,
      CLKOUT4_CASCADE => false,
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT4_USE_FINE_PS => false,
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      CLKOUT5_USE_FINE_PS => false,
      CLKOUT6_DIVIDE => 1,
      CLKOUT6_DUTY_CYCLE => 0.500000,
      CLKOUT6_PHASE => 0.000000,
      CLKOUT6_USE_FINE_PS => false,
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 1,
      IS_CLKINSEL_INVERTED => '0',
      IS_PSEN_INVERTED => '0',
      IS_PSINCDEC_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.010000,
      SS_EN => "FALSE",
      SS_MODE => "CENTER_HIGH",
      SS_MOD_PERIOD => 10000,
      STARTUP_WAIT => false
    )
        port map (
      CLKFBIN => clkfbout_buf_pulsar2_sysclk_125,
      CLKFBOUT => clkfbout_pulsar2_sysclk_125,
      CLKFBOUTB => NLW_mmcm_adv_inst_CLKFBOUTB_UNCONNECTED,
      CLKFBSTOPPED => NLW_mmcm_adv_inst_CLKFBSTOPPED_UNCONNECTED,
      CLKIN1 => clk_in1_pulsar2_sysclk_125,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKINSTOPPED => NLW_mmcm_adv_inst_CLKINSTOPPED_UNCONNECTED,
      CLKOUT0 => FMC_COMMON_CLK_pulsar2_sysclk_125,
      CLKOUT0B => NLW_mmcm_adv_inst_CLKOUT0B_UNCONNECTED,
      CLKOUT1 => MAIN_LOGIC_CLK_pulsar2_sysclk_125,
      CLKOUT1B => NLW_mmcm_adv_inst_CLKOUT1B_UNCONNECTED,
      CLKOUT2 => CLK50_pulsar2_sysclk_125,
      CLKOUT2B => NLW_mmcm_adv_inst_CLKOUT2B_UNCONNECTED,
      CLKOUT3 => NLW_mmcm_adv_inst_CLKOUT3_UNCONNECTED,
      CLKOUT3B => NLW_mmcm_adv_inst_CLKOUT3B_UNCONNECTED,
      CLKOUT4 => NLW_mmcm_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_mmcm_adv_inst_CLKOUT5_UNCONNECTED,
      CLKOUT6 => NLW_mmcm_adv_inst_CLKOUT6_UNCONNECTED,
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_mmcm_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_mmcm_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => locked,
      PSCLK => '0',
      PSDONE => NLW_mmcm_adv_inst_PSDONE_UNCONNECTED,
      PSEN => '0',
      PSINCDEC => '0',
      PWRDWN => '0',
      RST => reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_sysclk_125 is
  port (
    clk_in1_p : in STD_LOGIC;
    clk_in1_n : in STD_LOGIC;
    FMC_COMMON_CLK : out STD_LOGIC;
    MAIN_LOGIC_CLK : out STD_LOGIC;
    CLK50 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of pulsar2_sysclk_125 : entity is true;
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of pulsar2_sysclk_125 : entity is "pulsar2_sysclk_125,clk_wiz_v5_2_0,{component_name=pulsar2_sysclk_125,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=MMCM,num_out_clk=3,clkin1_period=5.0,clkin2_period=10.0,use_power_down=false,use_reset=true,use_locked=true,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}";
end pulsar2_sysclk_125;

architecture STRUCTURE of pulsar2_sysclk_125 is
begin
inst: entity work.pulsar2_sysclk_125_pulsar2_sysclk_125_clk_wiz
     port map (
      CLK50 => CLK50,
      FMC_COMMON_CLK => FMC_COMMON_CLK,
      MAIN_LOGIC_CLK => MAIN_LOGIC_CLK,
      clk_in1_n => clk_in1_n,
      clk_in1_p => clk_in1_p,
      locked => locked,
      reset => reset
    );
end STRUCTURE;
