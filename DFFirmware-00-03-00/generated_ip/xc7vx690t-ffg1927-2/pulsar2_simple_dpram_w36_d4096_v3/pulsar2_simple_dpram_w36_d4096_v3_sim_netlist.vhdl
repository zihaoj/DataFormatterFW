-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
-- Date        : Tue Feb 23 09:46:03 2016
-- Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
-- Command     : write_vhdl -force -mode funcsim
--               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/pulsar2_simple_dpram_w36_d4096_v3/pulsar2_simple_dpram_w36_d4096_v3_sim_netlist.vhdl
-- Design      : pulsar2_simple_dpram_w36_d4096_v3
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7vx690tffg1927-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_decoder is
  port (
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    dbiterr : out STD_LOGIC;
    sbiterr : out STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 35 downto 0 );
    clkb : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : in STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_decoder : entity is "blk_mem_gen_ecc_decoder";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_decoder;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_decoder is
  signal DECIN_REG : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal \doutb[10]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[22]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[23]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[24]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[25]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[28]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[32]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[32]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \doutb[33]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[34]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[35]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[8]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \doutb[9]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal sbiterr_INST_0_i_1_n_0 : STD_LOGIC;
  signal sel0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \doutb[0]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \doutb[10]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \doutb[10]_INST_0_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \doutb[11]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \doutb[12]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \doutb[13]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \doutb[14]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \doutb[15]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \doutb[16]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \doutb[17]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \doutb[18]_INST_0\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \doutb[19]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \doutb[1]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \doutb[20]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \doutb[21]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \doutb[22]_INST_0_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \doutb[23]_INST_0\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \doutb[23]_INST_0_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \doutb[24]_INST_0\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \doutb[24]_INST_0_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \doutb[25]_INST_0\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \doutb[25]_INST_0_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \doutb[27]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \doutb[28]_INST_0_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \doutb[2]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \doutb[30]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \doutb[31]_INST_0\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \doutb[32]_INST_0_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \doutb[32]_INST_0_i_2\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \doutb[33]_INST_0_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \doutb[34]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \doutb[34]_INST_0_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \doutb[35]_INST_0\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \doutb[35]_INST_0_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \doutb[3]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \doutb[4]_INST_0\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \doutb[5]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \doutb[6]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \doutb[8]_INST_0_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \doutb[9]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \doutb[9]_INST_0_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of sbiterr_INST_0 : label is "soft_lutpair23";
begin
dbiterr_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F0F0F0F0F0F0F0E"
    )
        port map (
      I0 => sel0(5),
      I1 => \doutb[28]_INST_0_i_1_n_0\,
      I2 => sel0(7),
      I3 => sel0(1),
      I4 => sel0(0),
      I5 => sel0(4),
      O => dbiterr
    );
\doutb[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[10]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(0),
      O => doutb(0)
    );
\doutb[10]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[10]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(10),
      O => doutb(10)
    );
\doutb[10]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FBFFFFFF"
    )
        port map (
      I0 => sel0(5),
      I1 => sel0(7),
      I2 => sel0(4),
      I3 => sel0(1),
      I4 => sel0(0),
      O => \doutb[10]_INST_0_i_1_n_0\
    );
\doutb[11]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[23]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(11),
      O => doutb(11)
    );
\doutb[12]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[24]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(12),
      O => doutb(12)
    );
\doutb[13]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[25]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(13),
      O => doutb(13)
    );
\doutb[14]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[22]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(14),
      O => doutb(14)
    );
\doutb[15]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[23]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(15),
      O => doutb(15)
    );
\doutb[16]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[24]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(16),
      O => doutb(16)
    );
\doutb[17]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[25]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(17),
      O => doutb(17)
    );
\doutb[18]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[22]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(18),
      O => doutb(18)
    );
\doutb[19]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[23]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(19),
      O => doutb(19)
    );
\doutb[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[8]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(1),
      O => doutb(1)
    );
\doutb[20]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[24]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(20),
      O => doutb(20)
    );
\doutb[21]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[25]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(21),
      O => doutb(21)
    );
\doutb[22]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[22]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(22),
      O => doutb(22)
    );
\doutb[22]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEFFFFF"
    )
        port map (
      I0 => sel0(1),
      I1 => sel0(0),
      I2 => sel0(4),
      I3 => sel0(5),
      I4 => sel0(7),
      O => \doutb[22]_INST_0_i_1_n_0\
    );
\doutb[23]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[23]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(23),
      O => doutb(23)
    );
\doutb[23]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFDFFFFF"
    )
        port map (
      I0 => sel0(0),
      I1 => sel0(1),
      I2 => sel0(4),
      I3 => sel0(5),
      I4 => sel0(7),
      O => \doutb[23]_INST_0_i_1_n_0\
    );
\doutb[24]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[24]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(24),
      O => doutb(24)
    );
\doutb[24]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFF7FF"
    )
        port map (
      I0 => sel0(1),
      I1 => sel0(7),
      I2 => sel0(5),
      I3 => sel0(4),
      I4 => sel0(0),
      O => \doutb[24]_INST_0_i_1_n_0\
    );
\doutb[25]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[25]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(25),
      O => doutb(25)
    );
\doutb[25]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FFFFFF"
    )
        port map (
      I0 => sel0(1),
      I1 => sel0(7),
      I2 => sel0(5),
      I3 => sel0(4),
      I4 => sel0(0),
      O => \doutb[25]_INST_0_i_1_n_0\
    );
\doutb[26]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[34]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(26),
      O => doutb(26)
    );
\doutb[27]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE01"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[35]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(27),
      O => doutb(27)
    );
\doutb[28]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEFFFFF00100000"
    )
        port map (
      I0 => \doutb[28]_INST_0_i_1_n_0\,
      I1 => sel0(4),
      I2 => sel0(1),
      I3 => \doutb[32]_INST_0_i_2_n_0\,
      I4 => sel0(0),
      I5 => DECIN_REG(28),
      O => doutb(28)
    );
\doutb[28]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      O => \doutb[28]_INST_0_i_1_n_0\
    );
\doutb[29]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFFFFFF04000000"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[33]_INST_0_i_1_n_0\,
      I3 => sel0(5),
      I4 => sel0(7),
      I5 => DECIN_REG(29),
      O => doutb(29)
    );
\doutb[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[9]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(2),
      O => doutb(2)
    );
\doutb[30]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[34]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(30),
      O => doutb(30)
    );
\doutb[31]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[35]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(31),
      O => doutb(31)
    );
\doutb[32]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEFFFFF00100000"
    )
        port map (
      I0 => \doutb[32]_INST_0_i_1_n_0\,
      I1 => sel0(4),
      I2 => sel0(1),
      I3 => \doutb[32]_INST_0_i_2_n_0\,
      I4 => sel0(0),
      I5 => DECIN_REG(32),
      O => doutb(32)
    );
\doutb[32]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      O => \doutb[32]_INST_0_i_1_n_0\
    );
\doutb[32]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => sel0(7),
      I1 => sel0(5),
      O => \doutb[32]_INST_0_i_2_n_0\
    );
\doutb[33]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFFFFFF04000000"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[33]_INST_0_i_1_n_0\,
      I3 => sel0(5),
      I4 => sel0(7),
      I5 => DECIN_REG(33),
      O => doutb(33)
    );
\doutb[33]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => sel0(1),
      I1 => sel0(0),
      I2 => sel0(4),
      O => \doutb[33]_INST_0_i_1_n_0\
    );
\doutb[34]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[34]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(34),
      O => doutb(34)
    );
\doutb[34]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EFFFFFFF"
    )
        port map (
      I0 => sel0(4),
      I1 => sel0(1),
      I2 => sel0(0),
      I3 => sel0(5),
      I4 => sel0(7),
      O => \doutb[34]_INST_0_i_1_n_0\
    );
\doutb[35]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[35]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(35),
      O => doutb(35)
    );
\doutb[35]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFBFFF"
    )
        port map (
      I0 => sel0(4),
      I1 => sel0(1),
      I2 => sel0(7),
      I3 => sel0(5),
      I4 => sel0(0),
      O => \doutb[35]_INST_0_i_1_n_0\
    );
\doutb[3]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(3),
      I1 => sel0(2),
      I2 => \doutb[10]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(3),
      O => doutb(3)
    );
\doutb[4]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[8]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(4),
      O => doutb(4)
    );
\doutb[5]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[9]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(5),
      O => doutb(5)
    );
\doutb[6]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FB04"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[10]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(6),
      O => doutb(6)
    );
\doutb[7]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00004000"
    )
        port map (
      I0 => \doutb[33]_INST_0_i_1_n_0\,
      I1 => sel0(3),
      I2 => sel0(2),
      I3 => sel0(7),
      I4 => sel0(5),
      I5 => DECIN_REG(7),
      O => doutb(7)
    );
\doutb[8]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[8]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(8),
      O => doutb(8)
    );
\doutb[8]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFEFFF"
    )
        port map (
      I0 => sel0(4),
      I1 => sel0(1),
      I2 => sel0(0),
      I3 => sel0(7),
      I4 => sel0(5),
      O => \doutb[8]_INST_0_i_1_n_0\
    );
\doutb[9]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F708"
    )
        port map (
      I0 => sel0(2),
      I1 => sel0(3),
      I2 => \doutb[9]_INST_0_i_1_n_0\,
      I3 => DECIN_REG(9),
      O => doutb(9)
    );
\doutb[9]_INST_0_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFBFF"
    )
        port map (
      I0 => sel0(5),
      I1 => sel0(7),
      I2 => sel0(4),
      I3 => sel0(1),
      I4 => sel0(0),
      O => \doutb[9]_INST_0_i_1_n_0\
    );
sbiterr_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => sel0(7),
      I1 => sbiterr_INST_0_i_1_n_0,
      O => sbiterr
    );
sbiterr_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"11111555FFFFFFFF"
    )
        port map (
      I0 => sel0(4),
      I1 => sel0(3),
      I2 => sel0(0),
      I3 => sel0(1),
      I4 => sel0(2),
      I5 => sel0(5),
      O => sbiterr_INST_0_i_1_n_0
    );
\softecc_outreg.DECIN_REG_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(0),
      Q => DECIN_REG(0),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(10),
      Q => DECIN_REG(10),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(11),
      Q => DECIN_REG(11),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(12),
      Q => DECIN_REG(12),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(13),
      Q => DECIN_REG(13),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(14),
      Q => DECIN_REG(14),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(15),
      Q => DECIN_REG(15),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(16),
      Q => DECIN_REG(16),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(17),
      Q => DECIN_REG(17),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(18),
      Q => DECIN_REG(18),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(19),
      Q => DECIN_REG(19),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(1),
      Q => DECIN_REG(1),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(20),
      Q => DECIN_REG(20),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(21),
      Q => DECIN_REG(21),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(22),
      Q => DECIN_REG(22),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(23),
      Q => DECIN_REG(23),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(24),
      Q => DECIN_REG(24),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(25),
      Q => DECIN_REG(25),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(26),
      Q => DECIN_REG(26),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(27),
      Q => DECIN_REG(27),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(28),
      Q => DECIN_REG(28),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(29),
      Q => DECIN_REG(29),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(2),
      Q => DECIN_REG(2),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(30),
      Q => DECIN_REG(30),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(31),
      Q => DECIN_REG(31),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[32]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(32),
      Q => DECIN_REG(32),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[33]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(33),
      Q => DECIN_REG(33),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[34]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(34),
      Q => DECIN_REG(34),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[35]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(35),
      Q => DECIN_REG(35),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(3),
      Q => DECIN_REG(3),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(4),
      Q => DECIN_REG(4),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(5),
      Q => DECIN_REG(5),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(6),
      Q => DECIN_REG(6),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(7),
      Q => DECIN_REG(7),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(8),
      Q => DECIN_REG(8),
      R => '0'
    );
\softecc_outreg.DECIN_REG_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => D(9),
      Q => DECIN_REG(9),
      R => '0'
    );
\softecc_outreg.SYNDROME_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clkb,
      CE => '1',
      D => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(0),
      Q => sel0(7),
      R => '0'
    );
\softecc_outreg.SYNDROME_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clkb,
      CE => '1',
      D => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(1),
      Q => sel0(0),
      R => '0'
    );
\softecc_outreg.SYNDROME_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clkb,
      CE => '1',
      D => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(2),
      Q => sel0(1),
      R => '0'
    );
\softecc_outreg.SYNDROME_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clkb,
      CE => '1',
      D => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(3),
      Q => sel0(2),
      R => '0'
    );
\softecc_outreg.SYNDROME_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clkb,
      CE => '1',
      D => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(4),
      Q => sel0(3),
      R => '0'
    );
\softecc_outreg.SYNDROME_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clkb,
      CE => '1',
      D => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(5),
      Q => sel0(4),
      R => '0'
    );
\softecc_outreg.SYNDROME_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clkb,
      CE => '1',
      D => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(6),
      Q => sel0(5),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_encoder is
  port (
    ENCOUT : out STD_LOGIC_VECTOR ( 42 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_encoder : entity is "blk_mem_gen_ecc_encoder";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_encoder;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_encoder is
  signal p_33_in34_in : STD_LOGIC;
  signal p_35_in : STD_LOGIC;
  signal p_36_in : STD_LOGIC;
  signal p_37_in : STD_LOGIC;
  signal p_38_in : STD_LOGIC;
  signal p_39_in : STD_LOGIC;
  signal p_42_out : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[0]_i_2_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[0]_i_3_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[0]_i_4_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[1]_i_2_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[1]_i_3_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[1]_i_4_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[1]_i_5_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[2]_i_2_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[2]_i_3_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[2]_i_4_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[2]_i_5_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[3]_i_2_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[3]_i_3_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[3]_i_4_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[4]_i_2_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[4]_i_3_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[5]_i_2_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[5]_i_3_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[5]_i_4_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[6]_i_2_n_0\ : STD_LOGIC;
  signal \softecc_inreg.ENC_CHKBITS_REG[6]_i_3_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \softecc_inreg.ENC_CHKBITS_REG[1]_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \softecc_inreg.ENC_CHKBITS_REG[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \softecc_inreg.ENC_CHKBITS_REG[2]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \softecc_inreg.ENC_CHKBITS_REG[3]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \softecc_inreg.ENC_CHKBITS_REG[5]_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \softecc_inreg.ENC_CHKBITS_REG[5]_i_4\ : label is "soft_lutpair1";
begin
\softecc_inreg.ENCIN_REG_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(0),
      Q => ENCOUT(0),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(10),
      Q => ENCOUT(10),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(11),
      Q => ENCOUT(11),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(12),
      Q => ENCOUT(12),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(13),
      Q => ENCOUT(13),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(14),
      Q => ENCOUT(14),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(15),
      Q => ENCOUT(15),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(16),
      Q => ENCOUT(16),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(17),
      Q => ENCOUT(17),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(18),
      Q => ENCOUT(18),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(19),
      Q => ENCOUT(19),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(1),
      Q => ENCOUT(1),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(20),
      Q => ENCOUT(20),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(21),
      Q => ENCOUT(21),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(22),
      Q => ENCOUT(22),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(23),
      Q => ENCOUT(23),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(24),
      Q => ENCOUT(24),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(25),
      Q => ENCOUT(25),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(26),
      Q => ENCOUT(26),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(27),
      Q => ENCOUT(27),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(28),
      Q => ENCOUT(28),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(29),
      Q => ENCOUT(29),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(2),
      Q => ENCOUT(2),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(30),
      Q => ENCOUT(30),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(31),
      Q => ENCOUT(31),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[32]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(32),
      Q => ENCOUT(32),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[33]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(33),
      Q => ENCOUT(33),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[34]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(34),
      Q => ENCOUT(34),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[35]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(35),
      Q => ENCOUT(35),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(3),
      Q => ENCOUT(3),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(4),
      Q => ENCOUT(4),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(5),
      Q => ENCOUT(5),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(6),
      Q => ENCOUT(6),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(7),
      Q => ENCOUT(7),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(8),
      Q => ENCOUT(8),
      R => '0'
    );
\softecc_inreg.ENCIN_REG_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => dina(9),
      Q => ENCOUT(9),
      R => '0'
    );
\softecc_inreg.ENC_CHKBITS_REG[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \softecc_inreg.ENC_CHKBITS_REG[0]_i_2_n_0\,
      I1 => \softecc_inreg.ENC_CHKBITS_REG[0]_i_3_n_0\,
      I2 => \softecc_inreg.ENC_CHKBITS_REG[0]_i_4_n_0\,
      I3 => dina(7),
      I4 => dina(18),
      I5 => dina(23),
      O => p_42_out
    );
\softecc_inreg.ENC_CHKBITS_REG[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(32),
      I1 => dina(27),
      I2 => dina(29),
      I3 => dina(24),
      I4 => dina(21),
      I5 => dina(10),
      O => \softecc_inreg.ENC_CHKBITS_REG[0]_i_2_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => dina(2),
      I1 => dina(11),
      I2 => dina(4),
      I3 => dina(17),
      I4 => dina(33),
      O => \softecc_inreg.ENC_CHKBITS_REG[0]_i_3_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(5),
      I1 => dina(12),
      I2 => dina(1),
      I3 => dina(0),
      I4 => dina(14),
      I5 => dina(26),
      O => \softecc_inreg.ENC_CHKBITS_REG[0]_i_4_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \softecc_inreg.ENC_CHKBITS_REG[1]_i_2_n_0\,
      I1 => \softecc_inreg.ENC_CHKBITS_REG[1]_i_3_n_0\,
      I2 => dina(0),
      I3 => dina(23),
      I4 => dina(1),
      I5 => \softecc_inreg.ENC_CHKBITS_REG[1]_i_4_n_0\,
      O => p_39_in
    );
\softecc_inreg.ENC_CHKBITS_REG[1]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => dina(17),
      I1 => dina(10),
      I2 => dina(3),
      O => \softecc_inreg.ENC_CHKBITS_REG[1]_i_2_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[1]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \softecc_inreg.ENC_CHKBITS_REG[1]_i_5_n_0\,
      I1 => dina(13),
      I2 => dina(6),
      I3 => dina(25),
      O => \softecc_inreg.ENC_CHKBITS_REG[1]_i_3_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(21),
      I1 => dina(15),
      I2 => dina(26),
      I3 => dina(32),
      I4 => dina(11),
      I5 => dina(4),
      O => \softecc_inreg.ENC_CHKBITS_REG[1]_i_4_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[1]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => dina(28),
      I1 => dina(19),
      I2 => dina(34),
      I3 => dina(8),
      I4 => dina(30),
      O => \softecc_inreg.ENC_CHKBITS_REG[1]_i_5_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => dina(17),
      I1 => dina(10),
      I2 => dina(3),
      I3 => \softecc_inreg.ENC_CHKBITS_REG[2]_i_2_n_0\,
      I4 => \softecc_inreg.ENC_CHKBITS_REG[2]_i_3_n_0\,
      O => p_38_in
    );
\softecc_inreg.ENC_CHKBITS_REG[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => dina(25),
      I1 => dina(24),
      I2 => dina(21),
      I3 => dina(20),
      O => \softecc_inreg.ENC_CHKBITS_REG[2]_i_2_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => \softecc_inreg.ENC_CHKBITS_REG[2]_i_4_n_0\,
      I1 => \softecc_inreg.ENC_CHKBITS_REG[2]_i_5_n_0\,
      I2 => dina(13),
      I3 => dina(28),
      I4 => dina(6),
      O => \softecc_inreg.ENC_CHKBITS_REG[2]_i_3_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(27),
      I1 => dina(32),
      I2 => dina(5),
      I3 => dina(0),
      I4 => dina(2),
      I5 => dina(12),
      O => \softecc_inreg.ENC_CHKBITS_REG[2]_i_4_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[2]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => dina(9),
      I1 => dina(35),
      I2 => dina(16),
      I3 => dina(31),
      O => \softecc_inreg.ENC_CHKBITS_REG[2]_i_5_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(3),
      I1 => dina(10),
      I2 => dina(17),
      I3 => \softecc_inreg.ENC_CHKBITS_REG[3]_i_2_n_0\,
      I4 => \softecc_inreg.ENC_CHKBITS_REG[3]_i_3_n_0\,
      I5 => \softecc_inreg.ENC_CHKBITS_REG[3]_i_4_n_0\,
      O => p_37_in
    );
\softecc_inreg.ENC_CHKBITS_REG[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => dina(25),
      I1 => dina(16),
      I2 => dina(8),
      I3 => dina(15),
      I4 => dina(30),
      O => \softecc_inreg.ENC_CHKBITS_REG[3]_i_2_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => dina(32),
      I1 => dina(22),
      I2 => dina(23),
      I3 => dina(31),
      I4 => dina(9),
      O => \softecc_inreg.ENC_CHKBITS_REG[3]_i_3_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[3]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(29),
      I1 => dina(14),
      I2 => dina(24),
      I3 => dina(7),
      I4 => dina(1),
      I5 => dina(2),
      O => \softecc_inreg.ENC_CHKBITS_REG[3]_i_4_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(23),
      I1 => dina(22),
      I2 => dina(35),
      I3 => dina(9),
      I4 => \softecc_inreg.ENC_CHKBITS_REG[4]_i_2_n_0\,
      I5 => \softecc_inreg.ENC_CHKBITS_REG[4]_i_3_n_0\,
      O => p_36_in
    );
\softecc_inreg.ENC_CHKBITS_REG[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(19),
      I1 => dina(6),
      I2 => dina(10),
      I3 => dina(33),
      I4 => dina(34),
      I5 => dina(8),
      O => \softecc_inreg.ENC_CHKBITS_REG[4]_i_2_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => \softecc_inreg.ENC_CHKBITS_REG[2]_i_2_n_0\,
      I1 => dina(7),
      I2 => dina(5),
      I3 => dina(18),
      I4 => dina(4),
      O => \softecc_inreg.ENC_CHKBITS_REG[4]_i_3_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \softecc_inreg.ENC_CHKBITS_REG[5]_i_2_n_0\,
      I1 => dina(17),
      I2 => \softecc_inreg.ENC_CHKBITS_REG[5]_i_3_n_0\,
      I3 => dina(13),
      I4 => dina(16),
      I5 => \softecc_inreg.ENC_CHKBITS_REG[5]_i_4_n_0\,
      O => p_35_in
    );
\softecc_inreg.ENC_CHKBITS_REG[5]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => dina(22),
      I1 => dina(23),
      O => \softecc_inreg.ENC_CHKBITS_REG[5]_i_2_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => dina(19),
      I1 => dina(12),
      I2 => dina(14),
      I3 => dina(15),
      I4 => dina(11),
      O => \softecc_inreg.ENC_CHKBITS_REG[5]_i_3_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[5]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => dina(20),
      I1 => dina(21),
      I2 => dina(24),
      I3 => dina(25),
      I4 => dina(18),
      O => \softecc_inreg.ENC_CHKBITS_REG[5]_i_4_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => dina(29),
      I1 => \softecc_inreg.ENC_CHKBITS_REG[6]_i_2_n_0\,
      I2 => dina(35),
      I3 => dina(31),
      I4 => dina(28),
      I5 => \softecc_inreg.ENC_CHKBITS_REG[6]_i_3_n_0\,
      O => p_33_in34_in
    );
\softecc_inreg.ENC_CHKBITS_REG[6]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => dina(32),
      I1 => dina(27),
      O => \softecc_inreg.ENC_CHKBITS_REG[6]_i_2_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG[6]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => dina(34),
      I1 => dina(30),
      I2 => dina(26),
      I3 => dina(33),
      O => \softecc_inreg.ENC_CHKBITS_REG[6]_i_3_n_0\
    );
\softecc_inreg.ENC_CHKBITS_REG_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clka,
      CE => '1',
      D => p_42_out,
      Q => ENCOUT(36),
      R => '0'
    );
\softecc_inreg.ENC_CHKBITS_REG_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clka,
      CE => '1',
      D => p_39_in,
      Q => ENCOUT(37),
      R => '0'
    );
\softecc_inreg.ENC_CHKBITS_REG_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clka,
      CE => '1',
      D => p_38_in,
      Q => ENCOUT(38),
      R => '0'
    );
\softecc_inreg.ENC_CHKBITS_REG_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clka,
      CE => '1',
      D => p_37_in,
      Q => ENCOUT(39),
      R => '0'
    );
\softecc_inreg.ENC_CHKBITS_REG_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clka,
      CE => '1',
      D => p_36_in,
      Q => ENCOUT(40),
      R => '0'
    );
\softecc_inreg.ENC_CHKBITS_REG_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clka,
      CE => '1',
      D => p_35_in,
      Q => ENCOUT(41),
      R => '0'
    );
\softecc_inreg.ENC_CHKBITS_REG_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clka,
      CE => '1',
      D => p_33_in34_in,
      Q => ENCOUT(42),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper is
  port (
    DOBDO : out STD_LOGIC_VECTOR ( 7 downto 0 );
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[3]\ : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \softecc_outreg.SYNDROME_reg[3]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[4]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[2]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[2]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[4]_0\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 8 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_14\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper : entity is "blk_mem_gen_prim_wrapper";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper is
  signal \^d\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^dobdo\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \softecc_outreg.SYNDROME[3]_i_5_n_0\ : STD_LOGIC;
  signal \^softecc_outreg.syndrome_reg[2]_0\ : STD_LOGIC;
  signal \^softecc_outreg.syndrome_reg[3]_0\ : STD_LOGIC;
  signal \^softecc_outreg.syndrome_reg[4]_0\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 8 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "INDEPENDENT";
  attribute box_type : string;
  attribute box_type of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
begin
  D(0) <= \^d\(0);
  DOBDO(7 downto 0) <= \^dobdo\(7 downto 0);
  \softecc_outreg.SYNDROME_reg[2]_0\ <= \^softecc_outreg.syndrome_reg[2]_0\;
  \softecc_outreg.SYNDROME_reg[3]_0\ <= \^softecc_outreg.syndrome_reg[3]_0\;
  \softecc_outreg.SYNDROME_reg[4]_0\ <= \^softecc_outreg.syndrome_reg[4]_0\;
\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 9,
      READ_WIDTH_B => 9,
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 9,
      WRITE_WIDTH_B => 9
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 3) => Q(11 downto 0),
      ADDRARDADDR(2 downto 0) => B"111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 3) => addrb(11 downto 0),
      ADDRBWRADDR(2 downto 0) => B"111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clkb,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 8) => B"000000000000000000000000",
      DIADI(7 downto 0) => ENCOUT(7 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 1) => B"000",
      DIPADIP(0) => ENCOUT(8),
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\(31 downto 0),
      DOBDO(31 downto 8) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\(31 downto 8),
      DOBDO(7 downto 0) => \^dobdo\(7 downto 0),
      DOPADOP(3 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\(3 downto 0),
      DOPBDOP(3 downto 1) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\(3 downto 1),
      DOPBDOP(0) => \^d\(0),
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => ena_i,
      ENBWREN => enb,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => enb,
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"1111",
      WEBWE(7 downto 0) => B"00000000"
    );
\softecc_outreg.SYNDROME[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\,
      I1 => \softecc_outreg.SYNDROME[3]_i_5_n_0\,
      I2 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\,
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\,
      I4 => \^softecc_outreg.syndrome_reg[3]_0\,
      I5 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\,
      O => \softecc_outreg.SYNDROME_reg[3]\(0)
    );
\softecc_outreg.SYNDROME[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\,
      I1 => \softecc_outreg.SYNDROME[3]_i_5_n_0\,
      I2 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\,
      I3 => \^dobdo\(6),
      I4 => \^dobdo\(0),
      I5 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6\,
      O => \softecc_outreg.SYNDROME_reg[3]\(1)
    );
\softecc_outreg.SYNDROME[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^softecc_outreg.syndrome_reg[2]_0\,
      I1 => \^softecc_outreg.syndrome_reg[4]_0\,
      I2 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12\(2),
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7\(0),
      I4 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8\(0),
      I5 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7\(1),
      O => \softecc_outreg.SYNDROME_reg[2]\
    );
\softecc_outreg.SYNDROME[2]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^dobdo\(0),
      I1 => \^dobdo\(6),
      O => \^softecc_outreg.syndrome_reg[2]_0\
    );
\softecc_outreg.SYNDROME[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7\(2),
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8\(1),
      I2 => \^softecc_outreg.syndrome_reg[3]_0\,
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9\,
      I4 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10\,
      I5 => \softecc_outreg.SYNDROME[3]_i_5_n_0\,
      O => \softecc_outreg.SYNDROME_reg[3]\(2)
    );
\softecc_outreg.SYNDROME[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11\,
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12\(0),
      I2 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13\(0),
      I3 => \^dobdo\(3),
      I4 => \^dobdo\(2),
      O => \^softecc_outreg.syndrome_reg[3]_0\
    );
\softecc_outreg.SYNDROME[3]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^d\(0),
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12\(1),
      I2 => \^dobdo\(1),
      O => \softecc_outreg.SYNDROME[3]_i_5_n_0\
    );
\softecc_outreg.SYNDROME[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^dobdo\(6),
      I1 => \^d\(0),
      I2 => \^dobdo\(4),
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13\(1),
      I4 => \^dobdo\(7),
      I5 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13\(2),
      O => \softecc_outreg.SYNDROME_reg[4]\
    );
\softecc_outreg.SYNDROME[4]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^dobdo\(5),
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_14\(0),
      O => \^softecc_outreg.syndrome_reg[4]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized0\ is
  port (
    DOBDO : out STD_LOGIC_VECTOR ( 7 downto 0 );
    DOPBDOP : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[5]\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \softecc_outreg.SYNDROME_reg[5]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[3]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[1]\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 8 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized0\ : entity is "blk_mem_gen_prim_wrapper";
end \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized0\;

architecture STRUCTURE of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized0\ is
  signal \^dobdo\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^dopbdop\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \softecc_outreg.SYNDROME[1]_i_5_n_0\ : STD_LOGIC;
  signal \softecc_outreg.SYNDROME[5]_i_3_n_0\ : STD_LOGIC;
  signal \^softecc_outreg.syndrome_reg[5]_0\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 8 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "INDEPENDENT";
  attribute box_type : string;
  attribute box_type of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \softecc_outreg.SYNDROME[1]_i_5\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \softecc_outreg.SYNDROME[3]_i_4\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \softecc_outreg.SYNDROME[5]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \softecc_outreg.SYNDROME[5]_i_4\ : label is "soft_lutpair25";
begin
  DOBDO(7 downto 0) <= \^dobdo\(7 downto 0);
  DOPBDOP(0) <= \^dopbdop\(0);
  \softecc_outreg.SYNDROME_reg[5]_0\ <= \^softecc_outreg.syndrome_reg[5]_0\;
\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 9,
      READ_WIDTH_B => 9,
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 9,
      WRITE_WIDTH_B => 9
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 3) => Q(11 downto 0),
      ADDRARDADDR(2 downto 0) => B"111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 3) => addrb(11 downto 0),
      ADDRBWRADDR(2 downto 0) => B"111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clkb,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 8) => B"000000000000000000000000",
      DIADI(7 downto 0) => ENCOUT(7 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 1) => B"000",
      DIPADIP(0) => ENCOUT(8),
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\(31 downto 0),
      DOBDO(31 downto 8) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\(31 downto 8),
      DOBDO(7 downto 0) => \^dobdo\(7 downto 0),
      DOPADOP(3 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\(3 downto 0),
      DOPBDOP(3 downto 1) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\(3 downto 1),
      DOPBDOP(0) => \^dopbdop\(0),
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => ena_i,
      ENBWREN => enb,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => enb,
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"1111",
      WEBWE(7 downto 0) => B"00000000"
    );
\softecc_outreg.SYNDROME[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => D(2),
      I1 => \softecc_outreg.SYNDROME[1]_i_5_n_0\,
      I2 => D(0),
      I3 => \^dobdo\(2),
      I4 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\(0),
      I5 => D(3),
      O => \softecc_outreg.SYNDROME_reg[1]\
    );
\softecc_outreg.SYNDROME[1]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^dobdo\(4),
      I1 => \^dopbdop\(0),
      O => \softecc_outreg.SYNDROME[1]_i_5_n_0\
    );
\softecc_outreg.SYNDROME[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\,
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\,
      I2 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\,
      I3 => \^dopbdop\(0),
      I4 => \^dobdo\(4),
      I5 => \^dobdo\(3),
      O => \softecc_outreg.SYNDROME_reg[5]\(0)
    );
\softecc_outreg.SYNDROME[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^dobdo\(7),
      I1 => \^dobdo\(5),
      O => \softecc_outreg.SYNDROME_reg[3]\
    );
\softecc_outreg.SYNDROME[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\,
      I1 => \softecc_outreg.SYNDROME[5]_i_3_n_0\,
      I2 => \^softecc_outreg.syndrome_reg[5]_0\,
      I3 => \^dobdo\(5),
      I4 => \^dobdo\(7),
      O => \softecc_outreg.SYNDROME_reg[5]\(1)
    );
\softecc_outreg.SYNDROME[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"96696996"
    )
        port map (
      I0 => \^dobdo\(6),
      I1 => D(1),
      I2 => D(2),
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\(1),
      I4 => \^dobdo\(2),
      O => \softecc_outreg.SYNDROME[5]_i_3_n_0\
    );
\softecc_outreg.SYNDROME[5]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^dopbdop\(0),
      I1 => \^dobdo\(4),
      I2 => \^dobdo\(3),
      O => \^softecc_outreg.syndrome_reg[5]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized1\ is
  port (
    D : out STD_LOGIC_VECTOR ( 8 downto 0 );
    \softecc_outreg.SYNDROME_reg[4]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[4]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[4]_1\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[1]\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 8 downto 0 );
    DOBDO : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized1\ : entity is "blk_mem_gen_prim_wrapper";
end \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized1\;

architecture STRUCTURE of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized1\ is
  signal \^d\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal \^softecc_outreg.syndrome_reg[4]_0\ : STD_LOGIC;
  signal \^softecc_outreg.syndrome_reg[4]_1\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 8 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "INDEPENDENT";
  attribute box_type : string;
  attribute box_type of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
begin
  D(8 downto 0) <= \^d\(8 downto 0);
  \softecc_outreg.SYNDROME_reg[4]_0\ <= \^softecc_outreg.syndrome_reg[4]_0\;
  \softecc_outreg.SYNDROME_reg[4]_1\ <= \^softecc_outreg.syndrome_reg[4]_1\;
\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 9,
      READ_WIDTH_B => 9,
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 9,
      WRITE_WIDTH_B => 9
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 3) => Q(11 downto 0),
      ADDRARDADDR(2 downto 0) => B"111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 3) => addrb(11 downto 0),
      ADDRBWRADDR(2 downto 0) => B"111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clkb,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 8) => B"000000000000000000000000",
      DIADI(7 downto 0) => ENCOUT(7 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 1) => B"000",
      DIPADIP(0) => ENCOUT(8),
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\(31 downto 0),
      DOBDO(31 downto 8) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\(31 downto 8),
      DOBDO(7 downto 0) => \^d\(7 downto 0),
      DOPADOP(3 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\(3 downto 0),
      DOPBDOP(3 downto 1) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\(3 downto 1),
      DOPBDOP(0) => \^d\(8),
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => ena_i,
      ENBWREN => enb,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => enb,
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"1111",
      WEBWE(7 downto 0) => B"00000000"
    );
\softecc_outreg.SYNDROME[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(1),
      I1 => \^d\(5),
      I2 => \^d\(3),
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\(0),
      I4 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\(1),
      I5 => DOBDO(1),
      O => \softecc_outreg.SYNDROME_reg[1]\
    );
\softecc_outreg.SYNDROME[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => DOBDO(1),
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(0),
      I2 => \^softecc_outreg.syndrome_reg[4]_0\,
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\,
      I4 => \^softecc_outreg.syndrome_reg[4]_1\,
      I5 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\,
      O => \softecc_outreg.SYNDROME_reg[4]\(0)
    );
\softecc_outreg.SYNDROME[4]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^d\(7),
      I1 => \^d\(6),
      I2 => DOBDO(0),
      O => \^softecc_outreg.syndrome_reg[4]_1\
    );
\softecc_outreg.SYNDROME[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^d\(0),
      I1 => \^d\(3),
      I2 => \^d\(5),
      I3 => \^d\(1),
      I4 => \^d\(4),
      I5 => \^d\(2),
      O => \^softecc_outreg.syndrome_reg[4]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized2\ is
  port (
    DOBDO : out STD_LOGIC_VECTOR ( 7 downto 0 );
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[6]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[6]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[0]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[1]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[3]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[0]_0\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 8 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized2\ : entity is "blk_mem_gen_prim_wrapper";
end \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized2\;

architecture STRUCTURE of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized2\ is
  signal \^d\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^dobdo\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \softecc_outreg.SYNDROME[6]_i_2_n_0\ : STD_LOGIC;
  signal \^softecc_outreg.syndrome_reg[1]\ : STD_LOGIC;
  signal \^softecc_outreg.syndrome_reg[6]_0\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 8 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "INDEPENDENT";
  attribute box_type : string;
  attribute box_type of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
begin
  D(0) <= \^d\(0);
  DOBDO(7 downto 0) <= \^dobdo\(7 downto 0);
  \softecc_outreg.SYNDROME_reg[1]\ <= \^softecc_outreg.syndrome_reg[1]\;
  \softecc_outreg.SYNDROME_reg[6]_0\ <= \^softecc_outreg.syndrome_reg[6]_0\;
\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 9,
      READ_WIDTH_B => 9,
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 9,
      WRITE_WIDTH_B => 9
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 3) => Q(11 downto 0),
      ADDRARDADDR(2 downto 0) => B"111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 3) => addrb(11 downto 0),
      ADDRBWRADDR(2 downto 0) => B"111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clkb,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 8) => B"000000000000000000000000",
      DIADI(7 downto 0) => ENCOUT(7 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 1) => B"000",
      DIPADIP(0) => ENCOUT(8),
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\(31 downto 0),
      DOBDO(31 downto 8) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\(31 downto 8),
      DOBDO(7 downto 0) => \^dobdo\(7 downto 0),
      DOPADOP(3 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\(3 downto 0),
      DOPBDOP(3 downto 1) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\(3 downto 1),
      DOPBDOP(0) => \^d\(0),
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => ena_i,
      ENBWREN => enb,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => enb,
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"1111",
      WEBWE(7 downto 0) => B"00000000"
    );
\softecc_outreg.SYNDROME[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^softecc_outreg.syndrome_reg[6]_0\,
      I1 => \^softecc_outreg.syndrome_reg[1]\,
      I2 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\,
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\,
      I4 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\,
      I5 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\,
      O => \softecc_outreg.SYNDROME_reg[0]\
    );
\softecc_outreg.SYNDROME[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \^dobdo\(2),
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(1),
      I2 => \^dobdo\(6),
      I3 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\(0),
      I4 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(0),
      I5 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(2),
      O => \softecc_outreg.SYNDROME_reg[0]_0\
    );
\softecc_outreg.SYNDROME[1]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^dobdo\(7),
      I1 => \^dobdo\(3),
      I2 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(5),
      O => \^softecc_outreg.syndrome_reg[1]\
    );
\softecc_outreg.SYNDROME[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(4),
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(3),
      I2 => \^dobdo\(3),
      I3 => \^dobdo\(2),
      I4 => \^dobdo\(4),
      I5 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(1),
      O => \softecc_outreg.SYNDROME_reg[3]\
    );
\softecc_outreg.SYNDROME[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(5),
      I1 => \^dobdo\(3),
      I2 => \^dobdo\(7),
      I3 => \softecc_outreg.SYNDROME[6]_i_2_n_0\,
      I4 => \^softecc_outreg.syndrome_reg[6]_0\,
      I5 => \^dobdo\(5),
      O => \softecc_outreg.SYNDROME_reg[6]\(0)
    );
\softecc_outreg.SYNDROME[6]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => \^d\(0),
      I1 => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\(1),
      I2 => \^dobdo\(6),
      I3 => \^dobdo\(2),
      O => \softecc_outreg.SYNDROME[6]_i_2_n_0\
    );
\softecc_outreg.SYNDROME[6]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^dobdo\(1),
      I1 => \^dobdo\(4),
      I2 => \^dobdo\(0),
      O => \^softecc_outreg.syndrome_reg[6]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized3\ is
  port (
    DOBDO : out STD_LOGIC_VECTOR ( 5 downto 0 );
    \softecc_outreg.SYNDROME_reg[0]\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized3\ : entity is "blk_mem_gen_prim_wrapper";
end \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized3\;

architecture STRUCTURE of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized3\ is
  signal \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_77\ : STD_LOGIC;
  signal \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_92\ : STD_LOGIC;
  signal \^dobdo\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal doutb_i : STD_LOGIC_VECTOR ( 36 to 36 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 31 downto 8 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\ : STD_LOGIC_VECTOR ( 8 downto 0 );
  attribute CLOCK_DOMAINS : string;
  attribute CLOCK_DOMAINS of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "INDEPENDENT";
  attribute box_type : string;
  attribute box_type of \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : label is "PRIMITIVE";
begin
  DOBDO(5 downto 0) <= \^dobdo\(5 downto 0);
\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\: unisim.vcomponents.RAMB36E1
    generic map(
      DOA_REG => 1,
      DOB_REG => 1,
      EN_ECC_READ => false,
      EN_ECC_WRITE => false,
      INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_41 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_42 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_43 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_A => X"000000000",
      INIT_B => X"000000000",
      INIT_FILE => "NONE",
      IS_CLKARDCLK_INVERTED => '0',
      IS_CLKBWRCLK_INVERTED => '0',
      IS_ENARDEN_INVERTED => '0',
      IS_ENBWREN_INVERTED => '0',
      IS_RSTRAMARSTRAM_INVERTED => '0',
      IS_RSTRAMB_INVERTED => '0',
      IS_RSTREGARSTREG_INVERTED => '0',
      IS_RSTREGB_INVERTED => '0',
      RAM_EXTENSION_A => "NONE",
      RAM_EXTENSION_B => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      READ_WIDTH_A => 9,
      READ_WIDTH_B => 9,
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "7SERIES",
      SRVAL_A => X"000000000",
      SRVAL_B => X"000000000",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      WRITE_WIDTH_A => 9,
      WRITE_WIDTH_B => 9
    )
        port map (
      ADDRARDADDR(15) => '1',
      ADDRARDADDR(14 downto 3) => Q(11 downto 0),
      ADDRARDADDR(2 downto 0) => B"111",
      ADDRBWRADDR(15) => '1',
      ADDRBWRADDR(14 downto 3) => addrb(11 downto 0),
      ADDRBWRADDR(2 downto 0) => B"111",
      CASCADEINA => '0',
      CASCADEINB => '0',
      CASCADEOUTA => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED\,
      CASCADEOUTB => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED\,
      CLKARDCLK => clka,
      CLKBWRCLK => clkb,
      DBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED\,
      DIADI(31 downto 7) => B"0000000000000000000000000",
      DIADI(6 downto 0) => ENCOUT(6 downto 0),
      DIBDI(31 downto 0) => B"00000000000000000000000000000000",
      DIPADIP(3 downto 0) => B"0000",
      DIPBDIP(3 downto 0) => B"0000",
      DOADO(31 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED\(31 downto 0),
      DOBDO(31 downto 8) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED\(31 downto 8),
      DOBDO(7) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_77\,
      DOBDO(6 downto 1) => \^dobdo\(5 downto 0),
      DOBDO(0) => doutb_i(36),
      DOPADOP(3 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED\(3 downto 0),
      DOPBDOP(3 downto 1) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED\(3 downto 1),
      DOPBDOP(0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_92\,
      ECCPARITY(7 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED\(7 downto 0),
      ENARDEN => ena_i,
      ENBWREN => enb,
      INJECTDBITERR => '0',
      INJECTSBITERR => '0',
      RDADDRECC(8 downto 0) => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED\(8 downto 0),
      REGCEAREGCE => '0',
      REGCEB => enb,
      RSTRAMARSTRAM => '0',
      RSTRAMB => '0',
      RSTREGARSTREG => '0',
      RSTREGB => '0',
      SBITERR => \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED\,
      WEA(3 downto 0) => B"1111",
      WEBWE(7 downto 0) => B"00000000"
    );
\softecc_outreg.SYNDROME[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6996966996696996"
    )
        port map (
      I0 => doutb_i(36),
      I1 => \^dobdo\(2),
      I2 => \^dobdo\(1),
      I3 => \^dobdo\(5),
      I4 => \^dobdo\(3),
      I5 => \^dobdo\(0),
      O => \softecc_outreg.SYNDROME_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width is
  port (
    DOBDO : out STD_LOGIC_VECTOR ( 7 downto 0 );
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[3]\ : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \softecc_outreg.SYNDROME_reg[3]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[4]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[2]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[2]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[4]_0\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 8 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13\ : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width : entity is "blk_mem_gen_prim_width";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width is
begin
\prim_noinit.ram\: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper
     port map (
      D(0) => D(0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12\(2 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11\(2 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13\(2 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12\(2 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_14\(0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13\(0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7\(2 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6\(2 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8\(1 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7\(1 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8\,
      DOBDO(7 downto 0) => DOBDO(7 downto 0),
      ENCOUT(8 downto 0) => ENCOUT(8 downto 0),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[2]\ => \softecc_outreg.SYNDROME_reg[2]\,
      \softecc_outreg.SYNDROME_reg[2]_0\ => \softecc_outreg.SYNDROME_reg[2]_0\,
      \softecc_outreg.SYNDROME_reg[3]\(2 downto 0) => \softecc_outreg.SYNDROME_reg[3]\(2 downto 0),
      \softecc_outreg.SYNDROME_reg[3]_0\ => \softecc_outreg.SYNDROME_reg[3]_0\,
      \softecc_outreg.SYNDROME_reg[4]\ => \softecc_outreg.SYNDROME_reg[4]\,
      \softecc_outreg.SYNDROME_reg[4]_0\ => \softecc_outreg.SYNDROME_reg[4]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized0\ is
  port (
    DOBDO : out STD_LOGIC_VECTOR ( 7 downto 0 );
    DOPBDOP : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[5]\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \softecc_outreg.SYNDROME_reg[5]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[3]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[1]\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 8 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized0\ : entity is "blk_mem_gen_prim_width";
end \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized0\;

architecture STRUCTURE of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized0\ is
begin
\prim_noinit.ram\: entity work.\pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized0\
     port map (
      D(3 downto 0) => D(3 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\(1 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\(1 downto 0),
      DOBDO(7 downto 0) => DOBDO(7 downto 0),
      DOPBDOP(0) => DOPBDOP(0),
      ENCOUT(8 downto 0) => ENCOUT(8 downto 0),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[1]\ => \softecc_outreg.SYNDROME_reg[1]\,
      \softecc_outreg.SYNDROME_reg[3]\ => \softecc_outreg.SYNDROME_reg[3]\,
      \softecc_outreg.SYNDROME_reg[5]\(1 downto 0) => \softecc_outreg.SYNDROME_reg[5]\(1 downto 0),
      \softecc_outreg.SYNDROME_reg[5]_0\ => \softecc_outreg.SYNDROME_reg[5]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized1\ is
  port (
    D : out STD_LOGIC_VECTOR ( 8 downto 0 );
    \softecc_outreg.SYNDROME_reg[4]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[4]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[4]_1\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[1]\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 8 downto 0 );
    DOBDO : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized1\ : entity is "blk_mem_gen_prim_width";
end \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized1\;

architecture STRUCTURE of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized1\ is
begin
\prim_noinit.ram\: entity work.\pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized1\
     port map (
      D(8 downto 0) => D(8 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\(1 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\(1 downto 0),
      DOBDO(1 downto 0) => DOBDO(1 downto 0),
      ENCOUT(8 downto 0) => ENCOUT(8 downto 0),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[1]\ => \softecc_outreg.SYNDROME_reg[1]\,
      \softecc_outreg.SYNDROME_reg[4]\(0) => \softecc_outreg.SYNDROME_reg[4]\(0),
      \softecc_outreg.SYNDROME_reg[4]_0\ => \softecc_outreg.SYNDROME_reg[4]_0\,
      \softecc_outreg.SYNDROME_reg[4]_1\ => \softecc_outreg.SYNDROME_reg[4]_1\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized2\ is
  port (
    DOBDO : out STD_LOGIC_VECTOR ( 7 downto 0 );
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[6]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \softecc_outreg.SYNDROME_reg[6]_0\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[0]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[1]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[3]\ : out STD_LOGIC;
    \softecc_outreg.SYNDROME_reg[0]_0\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 8 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized2\ : entity is "blk_mem_gen_prim_width";
end \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized2\;

architecture STRUCTURE of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized2\ is
begin
\prim_noinit.ram\: entity work.\pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized2\
     port map (
      D(0) => D(0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(5 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(5 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\(1 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(1 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\ => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\,
      DOBDO(7 downto 0) => DOBDO(7 downto 0),
      ENCOUT(8 downto 0) => ENCOUT(8 downto 0),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[0]\ => \softecc_outreg.SYNDROME_reg[0]\,
      \softecc_outreg.SYNDROME_reg[0]_0\ => \softecc_outreg.SYNDROME_reg[0]_0\,
      \softecc_outreg.SYNDROME_reg[1]\ => \softecc_outreg.SYNDROME_reg[1]\,
      \softecc_outreg.SYNDROME_reg[3]\ => \softecc_outreg.SYNDROME_reg[3]\,
      \softecc_outreg.SYNDROME_reg[6]\(0) => \softecc_outreg.SYNDROME_reg[6]\(0),
      \softecc_outreg.SYNDROME_reg[6]_0\ => \softecc_outreg.SYNDROME_reg[6]_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized3\ is
  port (
    DOBDO : out STD_LOGIC_VECTOR ( 5 downto 0 );
    \softecc_outreg.SYNDROME_reg[0]\ : out STD_LOGIC;
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized3\ : entity is "blk_mem_gen_prim_width";
end \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized3\;

architecture STRUCTURE of \pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized3\ is
begin
\prim_noinit.ram\: entity work.\pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized3\
     port map (
      DOBDO(5 downto 0) => DOBDO(5 downto 0),
      ENCOUT(6 downto 0) => ENCOUT(6 downto 0),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[0]\ => \softecc_outreg.SYNDROME_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_input_block is
  port (
    ENCOUT : out STD_LOGIC_VECTOR ( 42 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_input_block : entity is "blk_mem_input_block";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_input_block;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_input_block is
begin
\s6_softecc.s6_ecc_encoder\: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_encoder
     port map (
      ENCOUT(42 downto 0) => ENCOUT(42 downto 0),
      clka => clka,
      dina(35 downto 0) => dina(35 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_output_block is
  port (
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    dbiterr : out STD_LOGIC;
    sbiterr : out STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 35 downto 0 );
    clkb : in STD_LOGIC;
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ : in STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_output_block : entity is "blk_mem_output_block";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_output_block;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_output_block is
begin
\gen_decoder_sdp.s6_ecc_decoder_sdp\: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_decoder
     port map (
      D(35 downto 0) => D(35 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(6 downto 0) => \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(6 downto 0),
      clkb => clkb,
      dbiterr => dbiterr,
      doutb(35 downto 0) => doutb(35 downto 0),
      sbiterr => sbiterr
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_generic_cstr is
  port (
    D : out STD_LOGIC_VECTOR ( 35 downto 0 );
    \softecc_outreg.rdaddrecc_in_reg[11]\ : out STD_LOGIC_VECTOR ( 11 downto 0 );
    \softecc_outreg.SYNDROME_reg[6]\ : out STD_LOGIC_VECTOR ( 6 downto 0 );
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    ena_i : in STD_LOGIC;
    enb : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 11 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    ENCOUT : in STD_LOGIC_VECTOR ( 42 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_generic_cstr : entity is "blk_mem_gen_generic_cstr";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_generic_cstr;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_generic_cstr is
  signal \^d\ : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal doutb_i : STD_LOGIC_VECTOR ( 42 downto 37 );
  signal \ramloop[0].ram.r_n_12\ : STD_LOGIC;
  signal \ramloop[0].ram.r_n_13\ : STD_LOGIC;
  signal \ramloop[0].ram.r_n_14\ : STD_LOGIC;
  signal \ramloop[0].ram.r_n_15\ : STD_LOGIC;
  signal \ramloop[0].ram.r_n_16\ : STD_LOGIC;
  signal \ramloop[1].ram.r_n_11\ : STD_LOGIC;
  signal \ramloop[1].ram.r_n_12\ : STD_LOGIC;
  signal \ramloop[1].ram.r_n_13\ : STD_LOGIC;
  signal \ramloop[2].ram.r_n_10\ : STD_LOGIC;
  signal \ramloop[2].ram.r_n_11\ : STD_LOGIC;
  signal \ramloop[2].ram.r_n_12\ : STD_LOGIC;
  signal \ramloop[3].ram.r_n_10\ : STD_LOGIC;
  signal \ramloop[3].ram.r_n_11\ : STD_LOGIC;
  signal \ramloop[3].ram.r_n_12\ : STD_LOGIC;
  signal \ramloop[3].ram.r_n_13\ : STD_LOGIC;
  signal \ramloop[3].ram.r_n_14\ : STD_LOGIC;
  signal \ramloop[4].ram.r_n_6\ : STD_LOGIC;
  signal rdaddrecc_lat : STD_LOGIC_VECTOR ( 11 downto 0 );
begin
  D(35 downto 0) <= \^d\(35 downto 0);
\ramloop[0].ram.r\: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width
     port map (
      D(0) => \^d\(8),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ => \ramloop[2].ram.r_n_10\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ => \ramloop[4].ram.r_n_6\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ => \ramloop[3].ram.r_n_11\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10\ => \ramloop[2].ram.r_n_11\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11\(2 downto 1) => \^d\(16 downto 15),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11\(0) => \^d\(10),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12\(2 downto 0) => \^d\(34 downto 32),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13\(0) => \^d\(35),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ => \ramloop[3].ram.r_n_14\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ => \ramloop[2].ram.r_n_12\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ => \ramloop[1].ram.r_n_13\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5\ => \ramloop[3].ram.r_n_12\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6\(2) => \^d\(23),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6\(1 downto 0) => \^d\(21 downto 20),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7\(1 downto 0) => doutb_i(39 downto 38),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8\ => \ramloop[3].ram.r_n_13\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9\ => \ramloop[1].ram.r_n_12\,
      DOBDO(7 downto 0) => \^d\(7 downto 0),
      ENCOUT(8 downto 0) => ENCOUT(8 downto 0),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[2]\ => \ramloop[0].ram.r_n_14\,
      \softecc_outreg.SYNDROME_reg[2]_0\ => \ramloop[0].ram.r_n_15\,
      \softecc_outreg.SYNDROME_reg[3]\(2) => \softecc_outreg.SYNDROME_reg[6]\(3),
      \softecc_outreg.SYNDROME_reg[3]\(1 downto 0) => \softecc_outreg.SYNDROME_reg[6]\(1 downto 0),
      \softecc_outreg.SYNDROME_reg[3]_0\ => \ramloop[0].ram.r_n_12\,
      \softecc_outreg.SYNDROME_reg[4]\ => \ramloop[0].ram.r_n_13\,
      \softecc_outreg.SYNDROME_reg[4]_0\ => \ramloop[0].ram.r_n_16\
    );
\ramloop[1].ram.r\: entity work.\pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized0\
     port map (
      D(3) => \^d\(28),
      D(2 downto 1) => \^d\(25 downto 24),
      D(0) => \^d\(4),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\ => \ramloop[0].ram.r_n_14\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ => \ramloop[0].ram.r_n_12\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ => \ramloop[3].ram.r_n_10\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ => \ramloop[2].ram.r_n_10\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\(1) => doutb_i(41),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\(0) => doutb_i(37),
      DOBDO(7 downto 0) => \^d\(16 downto 9),
      DOPBDOP(0) => \^d\(17),
      ENCOUT(8 downto 0) => ENCOUT(17 downto 9),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[1]\ => \ramloop[1].ram.r_n_13\,
      \softecc_outreg.SYNDROME_reg[3]\ => \ramloop[1].ram.r_n_12\,
      \softecc_outreg.SYNDROME_reg[5]\(1) => \softecc_outreg.SYNDROME_reg[6]\(5),
      \softecc_outreg.SYNDROME_reg[5]\(0) => \softecc_outreg.SYNDROME_reg[6]\(2),
      \softecc_outreg.SYNDROME_reg[5]_0\ => \ramloop[1].ram.r_n_11\
    );
\ramloop[2].ram.r\: entity work.\pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized1\
     port map (
      D(8 downto 0) => \^d\(26 downto 18),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(0) => doutb_i(40),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\ => \ramloop[0].ram.r_n_13\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ => \ramloop[0].ram.r_n_16\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\(1) => \^d\(32),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\(0) => \^d\(3),
      DOBDO(1 downto 0) => \^d\(10 downto 9),
      ENCOUT(8 downto 0) => ENCOUT(26 downto 18),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[1]\ => \ramloop[2].ram.r_n_12\,
      \softecc_outreg.SYNDROME_reg[4]\(0) => \softecc_outreg.SYNDROME_reg[6]\(4),
      \softecc_outreg.SYNDROME_reg[4]_0\ => \ramloop[2].ram.r_n_10\,
      \softecc_outreg.SYNDROME_reg[4]_1\ => \ramloop[2].ram.r_n_11\
    );
\ramloop[3].ram.r\: entity work.\pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized2\
     port map (
      D(0) => \^d\(35),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(5) => \^d\(26),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(4) => \^d\(22),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(3) => \^d\(17),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(2) => \^d\(11),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(1) => \^d\(7),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(0) => \^d\(4),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0\(1 downto 0) => doutb_i(42 downto 41),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1\ => \ramloop[0].ram.r_n_15\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2\ => \ramloop[1].ram.r_n_12\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3\ => \ramloop[1].ram.r_n_11\,
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4\ => \ramloop[0].ram.r_n_16\,
      DOBDO(7 downto 0) => \^d\(34 downto 27),
      ENCOUT(8 downto 0) => ENCOUT(35 downto 27),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[0]\ => \ramloop[3].ram.r_n_11\,
      \softecc_outreg.SYNDROME_reg[0]_0\ => \ramloop[3].ram.r_n_14\,
      \softecc_outreg.SYNDROME_reg[1]\ => \ramloop[3].ram.r_n_12\,
      \softecc_outreg.SYNDROME_reg[3]\ => \ramloop[3].ram.r_n_13\,
      \softecc_outreg.SYNDROME_reg[6]\(0) => \softecc_outreg.SYNDROME_reg[6]\(6),
      \softecc_outreg.SYNDROME_reg[6]_0\ => \ramloop[3].ram.r_n_10\
    );
\ramloop[4].ram.r\: entity work.\pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized3\
     port map (
      DOBDO(5 downto 0) => doutb_i(42 downto 37),
      ENCOUT(6 downto 0) => ENCOUT(42 downto 36),
      Q(11 downto 0) => Q(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[0]\ => \ramloop[4].ram.r_n_6\
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(0),
      Q => rdaddrecc_lat(0),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(10),
      Q => rdaddrecc_lat(10),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(11),
      Q => rdaddrecc_lat(11),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(1),
      Q => rdaddrecc_lat(1),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(2),
      Q => rdaddrecc_lat(2),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(3),
      Q => rdaddrecc_lat(3),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(4),
      Q => rdaddrecc_lat(4),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(5),
      Q => rdaddrecc_lat(5),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(6),
      Q => rdaddrecc_lat(6),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(7),
      Q => rdaddrecc_lat(7),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(8),
      Q => rdaddrecc_lat(8),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_lat_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => addrb(9),
      Q => rdaddrecc_lat(9),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(0),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(0),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(10),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(10),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(11),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(11),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(1),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(1),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(2),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(2),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(3),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(3),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(4),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(4),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(5),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(5),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(6),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(6),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(7),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(7),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(8),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(8),
      R => '0'
    );
\softecc_addrb_lat_del.rdaddrecc_reg_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => enb,
      D => rdaddrecc_lat(9),
      Q => \softecc_outreg.rdaddrecc_in_reg[11]\(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_top is
  port (
    rdaddrecc : out STD_LOGIC_VECTOR ( 11 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    dbiterr : out STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dina : in STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_top : entity is "blk_mem_gen_top";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_top;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_top is
  signal addra_i : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal dina_i : STD_LOGIC_VECTOR ( 42 downto 0 );
  signal doutb_i : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal ena_i : STD_LOGIC;
  signal \gen_decoder_sdp.s6_ecc_decoder_sdp/SYNDROME_REG\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal rdaddrecc_reg : STD_LOGIC_VECTOR ( 11 downto 0 );
begin
inblk: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_input_block
     port map (
      ENCOUT(42 downto 0) => dina_i(42 downto 0),
      clka => clka,
      dina(35 downto 0) => dina(35 downto 0)
    );
outblk: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_output_block
     port map (
      D(35 downto 0) => doutb_i(35 downto 0),
      \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram\(6 downto 0) => \gen_decoder_sdp.s6_ecc_decoder_sdp/SYNDROME_REG\(6 downto 0),
      clkb => clkb,
      dbiterr => dbiterr,
      doutb(35 downto 0) => doutb(35 downto 0),
      sbiterr => sbiterr
    );
\softecc_inreg.addra_in_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(0),
      Q => addra_i(0),
      R => '0'
    );
\softecc_inreg.addra_in_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(10),
      Q => addra_i(10),
      R => '0'
    );
\softecc_inreg.addra_in_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(11),
      Q => addra_i(11),
      R => '0'
    );
\softecc_inreg.addra_in_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(1),
      Q => addra_i(1),
      R => '0'
    );
\softecc_inreg.addra_in_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(2),
      Q => addra_i(2),
      R => '0'
    );
\softecc_inreg.addra_in_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(3),
      Q => addra_i(3),
      R => '0'
    );
\softecc_inreg.addra_in_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(4),
      Q => addra_i(4),
      R => '0'
    );
\softecc_inreg.addra_in_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(5),
      Q => addra_i(5),
      R => '0'
    );
\softecc_inreg.addra_in_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(6),
      Q => addra_i(6),
      R => '0'
    );
\softecc_inreg.addra_in_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(7),
      Q => addra_i(7),
      R => '0'
    );
\softecc_inreg.addra_in_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(8),
      Q => addra_i(8),
      R => '0'
    );
\softecc_inreg.addra_in_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => addra(9),
      Q => addra_i(9),
      R => '0'
    );
\softecc_inreg.wea_in_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clka,
      CE => '1',
      D => wea(0),
      Q => ena_i,
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(0),
      Q => rdaddrecc(0),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(10),
      Q => rdaddrecc(10),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(11),
      Q => rdaddrecc(11),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(1),
      Q => rdaddrecc(1),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(2),
      Q => rdaddrecc(2),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(3),
      Q => rdaddrecc(3),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(4),
      Q => rdaddrecc(4),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(5),
      Q => rdaddrecc(5),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(6),
      Q => rdaddrecc(6),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(7),
      Q => rdaddrecc(7),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(8),
      Q => rdaddrecc(8),
      R => '0'
    );
\softecc_outreg.rdaddrecc_in_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clkb,
      CE => '1',
      D => rdaddrecc_reg(9),
      Q => rdaddrecc(9),
      R => '0'
    );
\valid.cstr\: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_generic_cstr
     port map (
      D(35 downto 0) => doutb_i(35 downto 0),
      ENCOUT(42 downto 0) => dina_i(42 downto 0),
      Q(11 downto 0) => addra_i(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      ena_i => ena_i,
      enb => enb,
      \softecc_outreg.SYNDROME_reg[6]\(6 downto 0) => \gen_decoder_sdp.s6_ecc_decoder_sdp/SYNDROME_REG\(6 downto 0),
      \softecc_outreg.rdaddrecc_in_reg[11]\(11 downto 0) => rdaddrecc_reg(11 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0_synth is
  port (
    rdaddrecc : out STD_LOGIC_VECTOR ( 11 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    dbiterr : out STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dina : in STD_LOGIC_VECTOR ( 35 downto 0 );
    clka : in STD_LOGIC;
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0_synth : entity is "blk_mem_gen_v8_3_0_synth";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0_synth;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0_synth is
begin
\gnativebmg.native_blk_mem_gen\: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_top
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      dbiterr => dbiterr,
      dina(35 downto 0) => dina(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      enb => enb,
      rdaddrecc(11 downto 0) => rdaddrecc(11 downto 0),
      sbiterr => sbiterr,
      wea(0) => wea(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    regcea : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 35 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 35 downto 0 );
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    regceb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 35 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    injectsbiterr : in STD_LOGIC;
    injectdbiterr : in STD_LOGIC;
    eccpipece : in STD_LOGIC;
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC;
    rdaddrecc : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sleep : in STD_LOGIC;
    deepsleep : in STD_LOGIC;
    shutdown : in STD_LOGIC;
    rsta_busy : out STD_LOGIC;
    rstb_busy : out STD_LOGIC;
    s_aclk : in STD_LOGIC;
    s_aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 35 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 35 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    s_axi_injectsbiterr : in STD_LOGIC;
    s_axi_injectdbiterr : in STD_LOGIC;
    s_axi_sbiterr : out STD_LOGIC;
    s_axi_dbiterr : out STD_LOGIC;
    s_axi_rdaddrecc : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute C_ADDRA_WIDTH : integer;
  attribute C_ADDRA_WIDTH of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 12;
  attribute C_ADDRB_WIDTH : integer;
  attribute C_ADDRB_WIDTH of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 12;
  attribute C_ALGORITHM : integer;
  attribute C_ALGORITHM of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 4;
  attribute C_AXI_SLAVE_TYPE : integer;
  attribute C_AXI_SLAVE_TYPE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_BYTE_SIZE : integer;
  attribute C_BYTE_SIZE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 9;
  attribute C_COMMON_CLK : integer;
  attribute C_COMMON_CLK of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_COUNT_18K_BRAM : string;
  attribute C_COUNT_18K_BRAM of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "0";
  attribute C_COUNT_36K_BRAM : string;
  attribute C_COUNT_36K_BRAM of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "5";
  attribute C_CTRL_ECC_ALGO : string;
  attribute C_CTRL_ECC_ALGO of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "NONE";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "0";
  attribute C_DISABLE_WARN_BHV_COLL : integer;
  attribute C_DISABLE_WARN_BHV_COLL of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_DISABLE_WARN_BHV_RANGE : integer;
  attribute C_DISABLE_WARN_BHV_RANGE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "./";
  attribute C_ENABLE_32BIT_ADDRESS : integer;
  attribute C_ENABLE_32BIT_ADDRESS of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_EN_DEEPSLEEP_PIN : integer;
  attribute C_EN_DEEPSLEEP_PIN of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_EN_ECC_PIPE : integer;
  attribute C_EN_ECC_PIPE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_EN_RDADDRA_CHG : integer;
  attribute C_EN_RDADDRA_CHG of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_EN_RDADDRB_CHG : integer;
  attribute C_EN_RDADDRB_CHG of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_EN_SAFETY_CKT : integer;
  attribute C_EN_SAFETY_CKT of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_EN_SHUTDOWN_PIN : integer;
  attribute C_EN_SHUTDOWN_PIN of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_EN_SLEEP_PIN : integer;
  attribute C_EN_SLEEP_PIN of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_EST_POWER_SUMMARY : string;
  attribute C_EST_POWER_SUMMARY of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "Estimated Power for IP     :     20.4007 mW";
  attribute C_FAMILY : string;
  attribute C_FAMILY of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "virtex7";
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_ENA : integer;
  attribute C_HAS_ENA of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_ENB : integer;
  attribute C_HAS_ENB of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_HAS_INJECTERR : integer;
  attribute C_HAS_INJECTERR of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_A : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_B : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_HAS_MUX_OUTPUT_REGS_A : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_B : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_REGCEA : integer;
  attribute C_HAS_REGCEA of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_REGCEB : integer;
  attribute C_HAS_REGCEB of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_RSTA : integer;
  attribute C_HAS_RSTA of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_RSTB : integer;
  attribute C_HAS_RSTB of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_HAS_SOFTECC_INPUT_REGS_A : integer;
  attribute C_HAS_SOFTECC_INPUT_REGS_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B : integer;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_INITA_VAL : string;
  attribute C_INITA_VAL of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "0";
  attribute C_INITB_VAL : string;
  attribute C_INITB_VAL of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "0";
  attribute C_INIT_FILE : string;
  attribute C_INIT_FILE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "pulsar2_simple_dpram_w36_d4096_v3.mem";
  attribute C_INIT_FILE_NAME : string;
  attribute C_INIT_FILE_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "no_coe_file_loaded";
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_LOAD_INIT_FILE : integer;
  attribute C_LOAD_INIT_FILE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_MUX_PIPELINE_STAGES : integer;
  attribute C_MUX_PIPELINE_STAGES of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_PRIM_TYPE : integer;
  attribute C_PRIM_TYPE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_READ_DEPTH_A : integer;
  attribute C_READ_DEPTH_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 4096;
  attribute C_READ_DEPTH_B : integer;
  attribute C_READ_DEPTH_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 4096;
  attribute C_READ_WIDTH_A : integer;
  attribute C_READ_WIDTH_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 36;
  attribute C_READ_WIDTH_B : integer;
  attribute C_READ_WIDTH_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 36;
  attribute C_RSTRAM_A : integer;
  attribute C_RSTRAM_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_RSTRAM_B : integer;
  attribute C_RSTRAM_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_RST_PRIORITY_A : string;
  attribute C_RST_PRIORITY_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "CE";
  attribute C_RST_PRIORITY_B : string;
  attribute C_RST_PRIORITY_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "CE";
  attribute C_SIM_COLLISION_CHECK : string;
  attribute C_SIM_COLLISION_CHECK of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "ALL";
  attribute C_USE_BRAM_BLOCK : integer;
  attribute C_USE_BRAM_BLOCK of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_USE_BYTE_WEA : integer;
  attribute C_USE_BYTE_WEA of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_USE_BYTE_WEB : integer;
  attribute C_USE_BYTE_WEB of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_USE_DEFAULT_DATA : integer;
  attribute C_USE_DEFAULT_DATA of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_USE_SOFTECC : integer;
  attribute C_USE_SOFTECC of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_USE_URAM : integer;
  attribute C_USE_URAM of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 0;
  attribute C_WEA_WIDTH : integer;
  attribute C_WEA_WIDTH of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_WEB_WIDTH : integer;
  attribute C_WEB_WIDTH of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 1;
  attribute C_WRITE_DEPTH_A : integer;
  attribute C_WRITE_DEPTH_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 4096;
  attribute C_WRITE_DEPTH_B : integer;
  attribute C_WRITE_DEPTH_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 4096;
  attribute C_WRITE_MODE_A : string;
  attribute C_WRITE_MODE_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "READ_FIRST";
  attribute C_WRITE_MODE_B : string;
  attribute C_WRITE_MODE_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "WRITE_FIRST";
  attribute C_WRITE_WIDTH_A : integer;
  attribute C_WRITE_WIDTH_A of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 36;
  attribute C_WRITE_WIDTH_B : integer;
  attribute C_WRITE_WIDTH_B of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is 36;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "virtex7";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "blk_mem_gen_v8_3_0";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 : entity is "yes";
end pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 is
  signal \<const0>\ : STD_LOGIC;
begin
  douta(35) <= \<const0>\;
  douta(34) <= \<const0>\;
  douta(33) <= \<const0>\;
  douta(32) <= \<const0>\;
  douta(31) <= \<const0>\;
  douta(30) <= \<const0>\;
  douta(29) <= \<const0>\;
  douta(28) <= \<const0>\;
  douta(27) <= \<const0>\;
  douta(26) <= \<const0>\;
  douta(25) <= \<const0>\;
  douta(24) <= \<const0>\;
  douta(23) <= \<const0>\;
  douta(22) <= \<const0>\;
  douta(21) <= \<const0>\;
  douta(20) <= \<const0>\;
  douta(19) <= \<const0>\;
  douta(18) <= \<const0>\;
  douta(17) <= \<const0>\;
  douta(16) <= \<const0>\;
  douta(15) <= \<const0>\;
  douta(14) <= \<const0>\;
  douta(13) <= \<const0>\;
  douta(12) <= \<const0>\;
  douta(11) <= \<const0>\;
  douta(10) <= \<const0>\;
  douta(9) <= \<const0>\;
  douta(8) <= \<const0>\;
  douta(7) <= \<const0>\;
  douta(6) <= \<const0>\;
  douta(5) <= \<const0>\;
  douta(4) <= \<const0>\;
  douta(3) <= \<const0>\;
  douta(2) <= \<const0>\;
  douta(1) <= \<const0>\;
  douta(0) <= \<const0>\;
  rsta_busy <= \<const0>\;
  rstb_busy <= \<const0>\;
  s_axi_arready <= \<const0>\;
  s_axi_awready <= \<const0>\;
  s_axi_bid(3) <= \<const0>\;
  s_axi_bid(2) <= \<const0>\;
  s_axi_bid(1) <= \<const0>\;
  s_axi_bid(0) <= \<const0>\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_bvalid <= \<const0>\;
  s_axi_dbiterr <= \<const0>\;
  s_axi_rdaddrecc(11) <= \<const0>\;
  s_axi_rdaddrecc(10) <= \<const0>\;
  s_axi_rdaddrecc(9) <= \<const0>\;
  s_axi_rdaddrecc(8) <= \<const0>\;
  s_axi_rdaddrecc(7) <= \<const0>\;
  s_axi_rdaddrecc(6) <= \<const0>\;
  s_axi_rdaddrecc(5) <= \<const0>\;
  s_axi_rdaddrecc(4) <= \<const0>\;
  s_axi_rdaddrecc(3) <= \<const0>\;
  s_axi_rdaddrecc(2) <= \<const0>\;
  s_axi_rdaddrecc(1) <= \<const0>\;
  s_axi_rdaddrecc(0) <= \<const0>\;
  s_axi_rdata(35) <= \<const0>\;
  s_axi_rdata(34) <= \<const0>\;
  s_axi_rdata(33) <= \<const0>\;
  s_axi_rdata(32) <= \<const0>\;
  s_axi_rdata(31) <= \<const0>\;
  s_axi_rdata(30) <= \<const0>\;
  s_axi_rdata(29) <= \<const0>\;
  s_axi_rdata(28) <= \<const0>\;
  s_axi_rdata(27) <= \<const0>\;
  s_axi_rdata(26) <= \<const0>\;
  s_axi_rdata(25) <= \<const0>\;
  s_axi_rdata(24) <= \<const0>\;
  s_axi_rdata(23) <= \<const0>\;
  s_axi_rdata(22) <= \<const0>\;
  s_axi_rdata(21) <= \<const0>\;
  s_axi_rdata(20) <= \<const0>\;
  s_axi_rdata(19) <= \<const0>\;
  s_axi_rdata(18) <= \<const0>\;
  s_axi_rdata(17) <= \<const0>\;
  s_axi_rdata(16) <= \<const0>\;
  s_axi_rdata(15) <= \<const0>\;
  s_axi_rdata(14) <= \<const0>\;
  s_axi_rdata(13) <= \<const0>\;
  s_axi_rdata(12) <= \<const0>\;
  s_axi_rdata(11) <= \<const0>\;
  s_axi_rdata(10) <= \<const0>\;
  s_axi_rdata(9) <= \<const0>\;
  s_axi_rdata(8) <= \<const0>\;
  s_axi_rdata(7) <= \<const0>\;
  s_axi_rdata(6) <= \<const0>\;
  s_axi_rdata(5) <= \<const0>\;
  s_axi_rdata(4) <= \<const0>\;
  s_axi_rdata(3) <= \<const0>\;
  s_axi_rdata(2) <= \<const0>\;
  s_axi_rdata(1) <= \<const0>\;
  s_axi_rdata(0) <= \<const0>\;
  s_axi_rid(3) <= \<const0>\;
  s_axi_rid(2) <= \<const0>\;
  s_axi_rid(1) <= \<const0>\;
  s_axi_rid(0) <= \<const0>\;
  s_axi_rlast <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
  s_axi_rvalid <= \<const0>\;
  s_axi_sbiterr <= \<const0>\;
  s_axi_wready <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst_blk_mem_gen: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0_synth
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      dbiterr => dbiterr,
      dina(35 downto 0) => dina(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      enb => enb,
      rdaddrecc(11 downto 0) => rdaddrecc(11 downto 0),
      sbiterr => sbiterr,
      wea(0) => wea(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pulsar2_simple_dpram_w36_d4096_v3 is
  port (
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 11 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 35 downto 0 );
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 11 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 35 downto 0 );
    sbiterr : out STD_LOGIC;
    dbiterr : out STD_LOGIC;
    rdaddrecc : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of pulsar2_simple_dpram_w36_d4096_v3 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of pulsar2_simple_dpram_w36_d4096_v3 : entity is "pulsar2_simple_dpram_w36_d4096_v3,blk_mem_gen_v8_3_0,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of pulsar2_simple_dpram_w36_d4096_v3 : entity is "pulsar2_simple_dpram_w36_d4096_v3,blk_mem_gen_v8_3_0,{x_ipProduct=Vivado 2015.3,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=blk_mem_gen,x_ipVersion=8.3,x_ipCoreRevision=0,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_FAMILY=virtex7,C_XDEVICEFAMILY=virtex7,C_ELABORATION_DIR=./,C_INTERFACE_TYPE=0,C_AXI_TYPE=1,C_AXI_SLAVE_TYPE=0,C_USE_BRAM_BLOCK=0,C_ENABLE_32BIT_ADDRESS=0,C_CTRL_ECC_ALGO=NONE,C_HAS_AXI_ID=0,C_AXI_ID_WIDTH=4,C_MEM_TYPE=1,C_BYTE_SIZE=9,C_ALGORITHM=1,C_PRIM_TYPE=1,C_LOAD_INIT_FILE=0,C_INIT_FILE_NAME=no_coe_file_loaded,C_INIT_FILE=pulsar2_simple_dpram_w36_d4096_v3.mem,C_USE_DEFAULT_DATA=0,C_DEFAULT_DATA=0,C_HAS_RSTA=0,C_RST_PRIORITY_A=CE,C_RSTRAM_A=0,C_INITA_VAL=0,C_HAS_ENA=0,C_HAS_REGCEA=0,C_USE_BYTE_WEA=0,C_WEA_WIDTH=1,C_WRITE_MODE_A=READ_FIRST,C_WRITE_WIDTH_A=36,C_READ_WIDTH_A=36,C_WRITE_DEPTH_A=4096,C_READ_DEPTH_A=4096,C_ADDRA_WIDTH=12,C_HAS_RSTB=0,C_RST_PRIORITY_B=CE,C_RSTRAM_B=0,C_INITB_VAL=0,C_HAS_ENB=1,C_HAS_REGCEB=0,C_USE_BYTE_WEB=0,C_WEB_WIDTH=1,C_WRITE_MODE_B=WRITE_FIRST,C_WRITE_WIDTH_B=36,C_READ_WIDTH_B=36,C_WRITE_DEPTH_B=4096,C_READ_DEPTH_B=4096,C_ADDRB_WIDTH=12,C_HAS_MEM_OUTPUT_REGS_A=0,C_HAS_MEM_OUTPUT_REGS_B=1,C_HAS_MUX_OUTPUT_REGS_A=0,C_HAS_MUX_OUTPUT_REGS_B=0,C_MUX_PIPELINE_STAGES=0,C_HAS_SOFTECC_INPUT_REGS_A=1,C_HAS_SOFTECC_OUTPUT_REGS_B=1,C_USE_SOFTECC=1,C_USE_ECC=0,C_EN_ECC_PIPE=0,C_HAS_INJECTERR=0,C_SIM_COLLISION_CHECK=ALL,C_COMMON_CLK=0,C_DISABLE_WARN_BHV_COLL=0,C_EN_SLEEP_PIN=0,C_USE_URAM=0,C_EN_RDADDRA_CHG=0,C_EN_RDADDRB_CHG=0,C_EN_DEEPSLEEP_PIN=0,C_EN_SHUTDOWN_PIN=0,C_EN_SAFETY_CKT=0,C_DISABLE_WARN_BHV_RANGE=0,C_COUNT_36K_BRAM=5,C_COUNT_18K_BRAM=0,C_EST_POWER_SUMMARY=Estimated Power for IP     _     20.4007 mW}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of pulsar2_simple_dpram_w36_d4096_v3 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of pulsar2_simple_dpram_w36_d4096_v3 : entity is "blk_mem_gen_v8_3_0,Vivado 2015.3";
end pulsar2_simple_dpram_w36_d4096_v3;

architecture STRUCTURE of pulsar2_simple_dpram_w36_d4096_v3 is
  signal NLW_U0_rsta_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_rstb_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_arready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_awready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_bvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_dbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rlast_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_rvalid_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_sbiterr_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_wready_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_douta_UNCONNECTED : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal NLW_U0_s_axi_bid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_s_axi_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_U0_s_axi_rdaddrecc_UNCONNECTED : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal NLW_U0_s_axi_rdata_UNCONNECTED : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal NLW_U0_s_axi_rid_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_U0_s_axi_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  attribute C_ADDRA_WIDTH : integer;
  attribute C_ADDRA_WIDTH of U0 : label is 12;
  attribute C_ADDRB_WIDTH : integer;
  attribute C_ADDRB_WIDTH of U0 : label is 12;
  attribute C_ALGORITHM : integer;
  attribute C_ALGORITHM of U0 : label is 1;
  attribute C_AXI_ID_WIDTH : integer;
  attribute C_AXI_ID_WIDTH of U0 : label is 4;
  attribute C_AXI_SLAVE_TYPE : integer;
  attribute C_AXI_SLAVE_TYPE of U0 : label is 0;
  attribute C_AXI_TYPE : integer;
  attribute C_AXI_TYPE of U0 : label is 1;
  attribute C_BYTE_SIZE : integer;
  attribute C_BYTE_SIZE of U0 : label is 9;
  attribute C_COMMON_CLK : integer;
  attribute C_COMMON_CLK of U0 : label is 0;
  attribute C_COUNT_18K_BRAM : string;
  attribute C_COUNT_18K_BRAM of U0 : label is "0";
  attribute C_COUNT_36K_BRAM : string;
  attribute C_COUNT_36K_BRAM of U0 : label is "5";
  attribute C_CTRL_ECC_ALGO : string;
  attribute C_CTRL_ECC_ALGO of U0 : label is "NONE";
  attribute C_DEFAULT_DATA : string;
  attribute C_DEFAULT_DATA of U0 : label is "0";
  attribute C_DISABLE_WARN_BHV_COLL : integer;
  attribute C_DISABLE_WARN_BHV_COLL of U0 : label is 0;
  attribute C_DISABLE_WARN_BHV_RANGE : integer;
  attribute C_DISABLE_WARN_BHV_RANGE of U0 : label is 0;
  attribute C_ELABORATION_DIR : string;
  attribute C_ELABORATION_DIR of U0 : label is "./";
  attribute C_ENABLE_32BIT_ADDRESS : integer;
  attribute C_ENABLE_32BIT_ADDRESS of U0 : label is 0;
  attribute C_EN_DEEPSLEEP_PIN : integer;
  attribute C_EN_DEEPSLEEP_PIN of U0 : label is 0;
  attribute C_EN_ECC_PIPE : integer;
  attribute C_EN_ECC_PIPE of U0 : label is 0;
  attribute C_EN_RDADDRA_CHG : integer;
  attribute C_EN_RDADDRA_CHG of U0 : label is 0;
  attribute C_EN_RDADDRB_CHG : integer;
  attribute C_EN_RDADDRB_CHG of U0 : label is 0;
  attribute C_EN_SAFETY_CKT : integer;
  attribute C_EN_SAFETY_CKT of U0 : label is 0;
  attribute C_EN_SHUTDOWN_PIN : integer;
  attribute C_EN_SHUTDOWN_PIN of U0 : label is 0;
  attribute C_EN_SLEEP_PIN : integer;
  attribute C_EN_SLEEP_PIN of U0 : label is 0;
  attribute C_EST_POWER_SUMMARY : string;
  attribute C_EST_POWER_SUMMARY of U0 : label is "Estimated Power for IP     :     20.4007 mW";
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "virtex7";
  attribute C_HAS_AXI_ID : integer;
  attribute C_HAS_AXI_ID of U0 : label is 0;
  attribute C_HAS_ENA : integer;
  attribute C_HAS_ENA of U0 : label is 0;
  attribute C_HAS_ENB : integer;
  attribute C_HAS_ENB of U0 : label is 1;
  attribute C_HAS_INJECTERR : integer;
  attribute C_HAS_INJECTERR of U0 : label is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_A : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_MEM_OUTPUT_REGS_B : integer;
  attribute C_HAS_MEM_OUTPUT_REGS_B of U0 : label is 1;
  attribute C_HAS_MUX_OUTPUT_REGS_A : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_A of U0 : label is 0;
  attribute C_HAS_MUX_OUTPUT_REGS_B : integer;
  attribute C_HAS_MUX_OUTPUT_REGS_B of U0 : label is 0;
  attribute C_HAS_REGCEA : integer;
  attribute C_HAS_REGCEA of U0 : label is 0;
  attribute C_HAS_REGCEB : integer;
  attribute C_HAS_REGCEB of U0 : label is 0;
  attribute C_HAS_RSTA : integer;
  attribute C_HAS_RSTA of U0 : label is 0;
  attribute C_HAS_RSTB : integer;
  attribute C_HAS_RSTB of U0 : label is 0;
  attribute C_HAS_SOFTECC_INPUT_REGS_A : integer;
  attribute C_HAS_SOFTECC_INPUT_REGS_A of U0 : label is 1;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B : integer;
  attribute C_HAS_SOFTECC_OUTPUT_REGS_B of U0 : label is 1;
  attribute C_INITA_VAL : string;
  attribute C_INITA_VAL of U0 : label is "0";
  attribute C_INITB_VAL : string;
  attribute C_INITB_VAL of U0 : label is "0";
  attribute C_INIT_FILE : string;
  attribute C_INIT_FILE of U0 : label is "pulsar2_simple_dpram_w36_d4096_v3.mem";
  attribute C_INIT_FILE_NAME : string;
  attribute C_INIT_FILE_NAME of U0 : label is "no_coe_file_loaded";
  attribute C_INTERFACE_TYPE : integer;
  attribute C_INTERFACE_TYPE of U0 : label is 0;
  attribute C_LOAD_INIT_FILE : integer;
  attribute C_LOAD_INIT_FILE of U0 : label is 0;
  attribute C_MEM_TYPE : integer;
  attribute C_MEM_TYPE of U0 : label is 1;
  attribute C_MUX_PIPELINE_STAGES : integer;
  attribute C_MUX_PIPELINE_STAGES of U0 : label is 0;
  attribute C_PRIM_TYPE : integer;
  attribute C_PRIM_TYPE of U0 : label is 1;
  attribute C_READ_DEPTH_A : integer;
  attribute C_READ_DEPTH_A of U0 : label is 4096;
  attribute C_READ_DEPTH_B : integer;
  attribute C_READ_DEPTH_B of U0 : label is 4096;
  attribute C_READ_WIDTH_A : integer;
  attribute C_READ_WIDTH_A of U0 : label is 36;
  attribute C_READ_WIDTH_B : integer;
  attribute C_READ_WIDTH_B of U0 : label is 36;
  attribute C_RSTRAM_A : integer;
  attribute C_RSTRAM_A of U0 : label is 0;
  attribute C_RSTRAM_B : integer;
  attribute C_RSTRAM_B of U0 : label is 0;
  attribute C_RST_PRIORITY_A : string;
  attribute C_RST_PRIORITY_A of U0 : label is "CE";
  attribute C_RST_PRIORITY_B : string;
  attribute C_RST_PRIORITY_B of U0 : label is "CE";
  attribute C_SIM_COLLISION_CHECK : string;
  attribute C_SIM_COLLISION_CHECK of U0 : label is "ALL";
  attribute C_USE_BRAM_BLOCK : integer;
  attribute C_USE_BRAM_BLOCK of U0 : label is 0;
  attribute C_USE_BYTE_WEA : integer;
  attribute C_USE_BYTE_WEA of U0 : label is 0;
  attribute C_USE_BYTE_WEB : integer;
  attribute C_USE_BYTE_WEB of U0 : label is 0;
  attribute C_USE_DEFAULT_DATA : integer;
  attribute C_USE_DEFAULT_DATA of U0 : label is 0;
  attribute C_USE_ECC : integer;
  attribute C_USE_ECC of U0 : label is 0;
  attribute C_USE_SOFTECC : integer;
  attribute C_USE_SOFTECC of U0 : label is 1;
  attribute C_USE_URAM : integer;
  attribute C_USE_URAM of U0 : label is 0;
  attribute C_WEA_WIDTH : integer;
  attribute C_WEA_WIDTH of U0 : label is 1;
  attribute C_WEB_WIDTH : integer;
  attribute C_WEB_WIDTH of U0 : label is 1;
  attribute C_WRITE_DEPTH_A : integer;
  attribute C_WRITE_DEPTH_A of U0 : label is 4096;
  attribute C_WRITE_DEPTH_B : integer;
  attribute C_WRITE_DEPTH_B of U0 : label is 4096;
  attribute C_WRITE_MODE_A : string;
  attribute C_WRITE_MODE_A of U0 : label is "READ_FIRST";
  attribute C_WRITE_MODE_B : string;
  attribute C_WRITE_MODE_B of U0 : label is "WRITE_FIRST";
  attribute C_WRITE_WIDTH_A : integer;
  attribute C_WRITE_WIDTH_A of U0 : label is 36;
  attribute C_WRITE_WIDTH_B : integer;
  attribute C_WRITE_WIDTH_B of U0 : label is 36;
  attribute C_XDEVICEFAMILY : string;
  attribute C_XDEVICEFAMILY of U0 : label is "virtex7";
  attribute downgradeipidentifiedwarnings of U0 : label is "yes";
  attribute x_interface_info : string;
  attribute x_interface_info of U0 : label is "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT";
begin
U0: entity work.pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0
     port map (
      addra(11 downto 0) => addra(11 downto 0),
      addrb(11 downto 0) => addrb(11 downto 0),
      clka => clka,
      clkb => clkb,
      dbiterr => dbiterr,
      deepsleep => '0',
      dina(35 downto 0) => dina(35 downto 0),
      dinb(35 downto 0) => B"000000000000000000000000000000000000",
      douta(35 downto 0) => NLW_U0_douta_UNCONNECTED(35 downto 0),
      doutb(35 downto 0) => doutb(35 downto 0),
      eccpipece => '0',
      ena => '0',
      enb => enb,
      injectdbiterr => '0',
      injectsbiterr => '0',
      rdaddrecc(11 downto 0) => rdaddrecc(11 downto 0),
      regcea => '0',
      regceb => '0',
      rsta => '0',
      rsta_busy => NLW_U0_rsta_busy_UNCONNECTED,
      rstb => '0',
      rstb_busy => NLW_U0_rstb_busy_UNCONNECTED,
      s_aclk => '0',
      s_aresetn => '0',
      s_axi_araddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_arburst(1 downto 0) => B"00",
      s_axi_arid(3 downto 0) => B"0000",
      s_axi_arlen(7 downto 0) => B"00000000",
      s_axi_arready => NLW_U0_s_axi_arready_UNCONNECTED,
      s_axi_arsize(2 downto 0) => B"000",
      s_axi_arvalid => '0',
      s_axi_awaddr(31 downto 0) => B"00000000000000000000000000000000",
      s_axi_awburst(1 downto 0) => B"00",
      s_axi_awid(3 downto 0) => B"0000",
      s_axi_awlen(7 downto 0) => B"00000000",
      s_axi_awready => NLW_U0_s_axi_awready_UNCONNECTED,
      s_axi_awsize(2 downto 0) => B"000",
      s_axi_awvalid => '0',
      s_axi_bid(3 downto 0) => NLW_U0_s_axi_bid_UNCONNECTED(3 downto 0),
      s_axi_bready => '0',
      s_axi_bresp(1 downto 0) => NLW_U0_s_axi_bresp_UNCONNECTED(1 downto 0),
      s_axi_bvalid => NLW_U0_s_axi_bvalid_UNCONNECTED,
      s_axi_dbiterr => NLW_U0_s_axi_dbiterr_UNCONNECTED,
      s_axi_injectdbiterr => '0',
      s_axi_injectsbiterr => '0',
      s_axi_rdaddrecc(11 downto 0) => NLW_U0_s_axi_rdaddrecc_UNCONNECTED(11 downto 0),
      s_axi_rdata(35 downto 0) => NLW_U0_s_axi_rdata_UNCONNECTED(35 downto 0),
      s_axi_rid(3 downto 0) => NLW_U0_s_axi_rid_UNCONNECTED(3 downto 0),
      s_axi_rlast => NLW_U0_s_axi_rlast_UNCONNECTED,
      s_axi_rready => '0',
      s_axi_rresp(1 downto 0) => NLW_U0_s_axi_rresp_UNCONNECTED(1 downto 0),
      s_axi_rvalid => NLW_U0_s_axi_rvalid_UNCONNECTED,
      s_axi_sbiterr => NLW_U0_s_axi_sbiterr_UNCONNECTED,
      s_axi_wdata(35 downto 0) => B"000000000000000000000000000000000000",
      s_axi_wlast => '0',
      s_axi_wready => NLW_U0_s_axi_wready_UNCONNECTED,
      s_axi_wstrb(0) => '0',
      s_axi_wvalid => '0',
      sbiterr => sbiterr,
      shutdown => '0',
      sleep => '0',
      wea(0) => wea(0),
      web(0) => '0'
    );
end STRUCTURE;
