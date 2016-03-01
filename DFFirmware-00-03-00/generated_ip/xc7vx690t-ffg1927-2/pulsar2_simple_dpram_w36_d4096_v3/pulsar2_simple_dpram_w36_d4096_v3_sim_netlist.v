// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (lin64) Build 1368829 Mon Sep 28 20:06:39 MDT 2015
// Date        : Tue Feb 23 09:46:03 2016
// Host        : stanford-atlas-01.cern.ch running 64-bit Scientific Linux CERN SLC release 6.7 (Carbon)
// Command     : write_verilog -force -mode funcsim
//               /afs/cern.ch/work/z/zijiang/DFFirmwareBT/data_formatter_top/implementation/dummy/my_project.srcs/sources_1/ip/pulsar2_simple_dpram_w36_d4096_v3/pulsar2_simple_dpram_w36_d4096_v3_sim_netlist.v
// Design      : pulsar2_simple_dpram_w36_d4096_v3
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "pulsar2_simple_dpram_w36_d4096_v3,blk_mem_gen_v8_3_0,{}" *) (* core_generation_info = "pulsar2_simple_dpram_w36_d4096_v3,blk_mem_gen_v8_3_0,{x_ipProduct=Vivado 2015.3,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=blk_mem_gen,x_ipVersion=8.3,x_ipCoreRevision=0,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_FAMILY=virtex7,C_XDEVICEFAMILY=virtex7,C_ELABORATION_DIR=./,C_INTERFACE_TYPE=0,C_AXI_TYPE=1,C_AXI_SLAVE_TYPE=0,C_USE_BRAM_BLOCK=0,C_ENABLE_32BIT_ADDRESS=0,C_CTRL_ECC_ALGO=NONE,C_HAS_AXI_ID=0,C_AXI_ID_WIDTH=4,C_MEM_TYPE=1,C_BYTE_SIZE=9,C_ALGORITHM=1,C_PRIM_TYPE=1,C_LOAD_INIT_FILE=0,C_INIT_FILE_NAME=no_coe_file_loaded,C_INIT_FILE=pulsar2_simple_dpram_w36_d4096_v3.mem,C_USE_DEFAULT_DATA=0,C_DEFAULT_DATA=0,C_HAS_RSTA=0,C_RST_PRIORITY_A=CE,C_RSTRAM_A=0,C_INITA_VAL=0,C_HAS_ENA=0,C_HAS_REGCEA=0,C_USE_BYTE_WEA=0,C_WEA_WIDTH=1,C_WRITE_MODE_A=READ_FIRST,C_WRITE_WIDTH_A=36,C_READ_WIDTH_A=36,C_WRITE_DEPTH_A=4096,C_READ_DEPTH_A=4096,C_ADDRA_WIDTH=12,C_HAS_RSTB=0,C_RST_PRIORITY_B=CE,C_RSTRAM_B=0,C_INITB_VAL=0,C_HAS_ENB=1,C_HAS_REGCEB=0,C_USE_BYTE_WEB=0,C_WEB_WIDTH=1,C_WRITE_MODE_B=WRITE_FIRST,C_WRITE_WIDTH_B=36,C_READ_WIDTH_B=36,C_WRITE_DEPTH_B=4096,C_READ_DEPTH_B=4096,C_ADDRB_WIDTH=12,C_HAS_MEM_OUTPUT_REGS_A=0,C_HAS_MEM_OUTPUT_REGS_B=1,C_HAS_MUX_OUTPUT_REGS_A=0,C_HAS_MUX_OUTPUT_REGS_B=0,C_MUX_PIPELINE_STAGES=0,C_HAS_SOFTECC_INPUT_REGS_A=1,C_HAS_SOFTECC_OUTPUT_REGS_B=1,C_USE_SOFTECC=1,C_USE_ECC=0,C_EN_ECC_PIPE=0,C_HAS_INJECTERR=0,C_SIM_COLLISION_CHECK=ALL,C_COMMON_CLK=0,C_DISABLE_WARN_BHV_COLL=0,C_EN_SLEEP_PIN=0,C_USE_URAM=0,C_EN_RDADDRA_CHG=0,C_EN_RDADDRB_CHG=0,C_EN_DEEPSLEEP_PIN=0,C_EN_SHUTDOWN_PIN=0,C_EN_SAFETY_CKT=0,C_DISABLE_WARN_BHV_RANGE=0,C_COUNT_36K_BRAM=5,C_COUNT_18K_BRAM=0,C_EST_POWER_SUMMARY=Estimated Power for IP     _     20.4007 mW}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "blk_mem_gen_v8_3_0,Vivado 2015.3" *) 
(* NotValidForBitStream *)
module pulsar2_simple_dpram_w36_d4096_v3
   (clka,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb,
    sbiterr,
    dbiterr,
    rdaddrecc);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [35:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [11:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [35:0]doutb;
  output sbiterr;
  output dbiterr;
  output [11:0]rdaddrecc;

  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire dbiterr;
  wire [35:0]dina;
  wire [35:0]doutb;
  wire enb;
  wire [11:0]rdaddrecc;
  wire sbiterr;
  wire [0:0]wea;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire [35:0]NLW_U0_douta_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [35:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "5" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     20.4007 mW" *) 
  (* C_FAMILY = "virtex7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "1" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "1" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "pulsar2_simple_dpram_w36_d4096_v3.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "4096" *) 
  (* C_READ_DEPTH_B = "4096" *) 
  (* C_READ_WIDTH_A = "36" *) 
  (* C_READ_WIDTH_B = "36" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "1" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "4096" *) 
  (* C_WRITE_DEPTH_B = "4096" *) 
  (* C_WRITE_MODE_A = "READ_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "36" *) 
  (* C_WRITE_WIDTH_B = "36" *) 
  (* C_XDEVICEFAMILY = "virtex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) 
  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(dbiterr),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[35:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(rdaddrecc),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[35:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(sbiterr),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_ecc_decoder" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_decoder
   (doutb,
    dbiterr,
    sbiterr,
    D,
    clkb,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram );
  output [35:0]doutb;
  output dbiterr;
  output sbiterr;
  input [35:0]D;
  input clkb;
  input [6:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;

  wire [35:0]D;
  wire [35:0]DECIN_REG;
  wire [6:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire clkb;
  wire dbiterr;
  wire [35:0]doutb;
  wire \doutb[10]_INST_0_i_1_n_0 ;
  wire \doutb[22]_INST_0_i_1_n_0 ;
  wire \doutb[23]_INST_0_i_1_n_0 ;
  wire \doutb[24]_INST_0_i_1_n_0 ;
  wire \doutb[25]_INST_0_i_1_n_0 ;
  wire \doutb[28]_INST_0_i_1_n_0 ;
  wire \doutb[32]_INST_0_i_1_n_0 ;
  wire \doutb[32]_INST_0_i_2_n_0 ;
  wire \doutb[33]_INST_0_i_1_n_0 ;
  wire \doutb[34]_INST_0_i_1_n_0 ;
  wire \doutb[35]_INST_0_i_1_n_0 ;
  wire \doutb[8]_INST_0_i_1_n_0 ;
  wire \doutb[9]_INST_0_i_1_n_0 ;
  wire sbiterr;
  wire sbiterr_INST_0_i_1_n_0;
  wire [7:0]sel0;

  LUT6 #(
    .INIT(64'h0F0F0F0F0F0F0F0E)) 
    dbiterr_INST_0
       (.I0(sel0[5]),
        .I1(\doutb[28]_INST_0_i_1_n_0 ),
        .I2(sel0[7]),
        .I3(sel0[1]),
        .I4(sel0[0]),
        .I5(sel0[4]),
        .O(dbiterr));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \doutb[0]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[10]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[0]),
        .O(doutb[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hF708)) 
    \doutb[10]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[10]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[10]),
        .O(doutb[10]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hFBFFFFFF)) 
    \doutb[10]_INST_0_i_1 
       (.I0(sel0[5]),
        .I1(sel0[7]),
        .I2(sel0[4]),
        .I3(sel0[1]),
        .I4(sel0[0]),
        .O(\doutb[10]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \doutb[11]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[23]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[11]),
        .O(doutb[11]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \doutb[12]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[24]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[12]),
        .O(doutb[12]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \doutb[13]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[25]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[13]),
        .O(doutb[13]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[14]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[22]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[14]),
        .O(doutb[14]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[15]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[23]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[15]),
        .O(doutb[15]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[16]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[24]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[16]),
        .O(doutb[16]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[17]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[25]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[17]),
        .O(doutb[17]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[18]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[22]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[18]),
        .O(doutb[18]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[19]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[23]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[19]),
        .O(doutb[19]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[1]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[8]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[1]),
        .O(doutb[1]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[20]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[24]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[20]),
        .O(doutb[20]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[21]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[25]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[21]),
        .O(doutb[21]));
  LUT4 #(
    .INIT(16'hF708)) 
    \doutb[22]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[22]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[22]),
        .O(doutb[22]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hFFEFFFFF)) 
    \doutb[22]_INST_0_i_1 
       (.I0(sel0[1]),
        .I1(sel0[0]),
        .I2(sel0[4]),
        .I3(sel0[5]),
        .I4(sel0[7]),
        .O(\doutb[22]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT4 #(
    .INIT(16'hF708)) 
    \doutb[23]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[23]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[23]),
        .O(doutb[23]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hFFDFFFFF)) 
    \doutb[23]_INST_0_i_1 
       (.I0(sel0[0]),
        .I1(sel0[1]),
        .I2(sel0[4]),
        .I3(sel0[5]),
        .I4(sel0[7]),
        .O(\doutb[23]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hF708)) 
    \doutb[24]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[24]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[24]),
        .O(doutb[24]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hFFFFF7FF)) 
    \doutb[24]_INST_0_i_1 
       (.I0(sel0[1]),
        .I1(sel0[7]),
        .I2(sel0[5]),
        .I3(sel0[4]),
        .I4(sel0[0]),
        .O(\doutb[24]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'hF708)) 
    \doutb[25]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[25]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[25]),
        .O(doutb[25]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hF7FFFFFF)) 
    \doutb[25]_INST_0_i_1 
       (.I0(sel0[1]),
        .I1(sel0[7]),
        .I2(sel0[5]),
        .I3(sel0[4]),
        .I4(sel0[0]),
        .O(\doutb[25]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFE01)) 
    \doutb[26]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[34]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[26]),
        .O(doutb[26]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hFE01)) 
    \doutb[27]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[35]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[27]),
        .O(doutb[27]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00100000)) 
    \doutb[28]_INST_0 
       (.I0(\doutb[28]_INST_0_i_1_n_0 ),
        .I1(sel0[4]),
        .I2(sel0[1]),
        .I3(\doutb[32]_INST_0_i_2_n_0 ),
        .I4(sel0[0]),
        .I5(DECIN_REG[28]),
        .O(doutb[28]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \doutb[28]_INST_0_i_1 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .O(\doutb[28]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF04000000)) 
    \doutb[29]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[33]_INST_0_i_1_n_0 ),
        .I3(sel0[5]),
        .I4(sel0[7]),
        .I5(DECIN_REG[29]),
        .O(doutb[29]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[2]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[9]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[2]),
        .O(doutb[2]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[30]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[34]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[30]),
        .O(doutb[30]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[31]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[35]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[31]),
        .O(doutb[31]));
  LUT6 #(
    .INIT(64'hFFEFFFFF00100000)) 
    \doutb[32]_INST_0 
       (.I0(\doutb[32]_INST_0_i_1_n_0 ),
        .I1(sel0[4]),
        .I2(sel0[1]),
        .I3(\doutb[32]_INST_0_i_2_n_0 ),
        .I4(sel0[0]),
        .I5(DECIN_REG[32]),
        .O(doutb[32]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \doutb[32]_INST_0_i_1 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .O(\doutb[32]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \doutb[32]_INST_0_i_2 
       (.I0(sel0[7]),
        .I1(sel0[5]),
        .O(\doutb[32]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFBFFFFFF04000000)) 
    \doutb[33]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[33]_INST_0_i_1_n_0 ),
        .I3(sel0[5]),
        .I4(sel0[7]),
        .I5(DECIN_REG[33]),
        .O(doutb[33]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \doutb[33]_INST_0_i_1 
       (.I0(sel0[1]),
        .I1(sel0[0]),
        .I2(sel0[4]),
        .O(\doutb[33]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[34]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[34]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[34]),
        .O(doutb[34]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hEFFFFFFF)) 
    \doutb[34]_INST_0_i_1 
       (.I0(sel0[4]),
        .I1(sel0[1]),
        .I2(sel0[0]),
        .I3(sel0[5]),
        .I4(sel0[7]),
        .O(\doutb[34]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[35]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[35]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[35]),
        .O(doutb[35]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFFFFBFFF)) 
    \doutb[35]_INST_0_i_1 
       (.I0(sel0[4]),
        .I1(sel0[1]),
        .I2(sel0[7]),
        .I3(sel0[5]),
        .I4(sel0[0]),
        .O(\doutb[35]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[3]_INST_0 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(\doutb[10]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[3]),
        .O(doutb[3]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[4]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[8]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[4]),
        .O(doutb[4]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[5]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[9]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[5]),
        .O(doutb[5]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hFB04)) 
    \doutb[6]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[10]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[6]),
        .O(doutb[6]));
  LUT6 #(
    .INIT(64'hFFFFBFFF00004000)) 
    \doutb[7]_INST_0 
       (.I0(\doutb[33]_INST_0_i_1_n_0 ),
        .I1(sel0[3]),
        .I2(sel0[2]),
        .I3(sel0[7]),
        .I4(sel0[5]),
        .I5(DECIN_REG[7]),
        .O(doutb[7]));
  LUT4 #(
    .INIT(16'hF708)) 
    \doutb[8]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[8]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[8]),
        .O(doutb[8]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hFFFFEFFF)) 
    \doutb[8]_INST_0_i_1 
       (.I0(sel0[4]),
        .I1(sel0[1]),
        .I2(sel0[0]),
        .I3(sel0[7]),
        .I4(sel0[5]),
        .O(\doutb[8]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'hF708)) 
    \doutb[9]_INST_0 
       (.I0(sel0[2]),
        .I1(sel0[3]),
        .I2(\doutb[9]_INST_0_i_1_n_0 ),
        .I3(DECIN_REG[9]),
        .O(doutb[9]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFFFFFBFF)) 
    \doutb[9]_INST_0_i_1 
       (.I0(sel0[5]),
        .I1(sel0[7]),
        .I2(sel0[4]),
        .I3(sel0[1]),
        .I4(sel0[0]),
        .O(\doutb[9]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h8)) 
    sbiterr_INST_0
       (.I0(sel0[7]),
        .I1(sbiterr_INST_0_i_1_n_0),
        .O(sbiterr));
  LUT6 #(
    .INIT(64'h11111555FFFFFFFF)) 
    sbiterr_INST_0_i_1
       (.I0(sel0[4]),
        .I1(sel0[3]),
        .I2(sel0[0]),
        .I3(sel0[1]),
        .I4(sel0[2]),
        .I5(sel0[5]),
        .O(sbiterr_INST_0_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[0] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[0]),
        .Q(DECIN_REG[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[10] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[10]),
        .Q(DECIN_REG[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[11] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[11]),
        .Q(DECIN_REG[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[12] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[12]),
        .Q(DECIN_REG[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[13] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[13]),
        .Q(DECIN_REG[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[14] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[14]),
        .Q(DECIN_REG[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[15] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[15]),
        .Q(DECIN_REG[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[16] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[16]),
        .Q(DECIN_REG[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[17] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[17]),
        .Q(DECIN_REG[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[18] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[18]),
        .Q(DECIN_REG[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[19] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[19]),
        .Q(DECIN_REG[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[1] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[1]),
        .Q(DECIN_REG[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[20] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[20]),
        .Q(DECIN_REG[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[21] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[21]),
        .Q(DECIN_REG[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[22] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[22]),
        .Q(DECIN_REG[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[23] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[23]),
        .Q(DECIN_REG[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[24] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[24]),
        .Q(DECIN_REG[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[25] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[25]),
        .Q(DECIN_REG[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[26] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[26]),
        .Q(DECIN_REG[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[27] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[27]),
        .Q(DECIN_REG[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[28] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[28]),
        .Q(DECIN_REG[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[29] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[29]),
        .Q(DECIN_REG[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[2] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[2]),
        .Q(DECIN_REG[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[30] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[30]),
        .Q(DECIN_REG[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[31] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[31]),
        .Q(DECIN_REG[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[32] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[32]),
        .Q(DECIN_REG[32]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[33] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[33]),
        .Q(DECIN_REG[33]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[34] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[34]),
        .Q(DECIN_REG[34]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[35] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[35]),
        .Q(DECIN_REG[35]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[3] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[3]),
        .Q(DECIN_REG[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[4] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[4]),
        .Q(DECIN_REG[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[5] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[5]),
        .Q(DECIN_REG[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[6] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[6]),
        .Q(DECIN_REG[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[7] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[7]),
        .Q(DECIN_REG[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[8] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[8]),
        .Q(DECIN_REG[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.DECIN_REG_reg[9] 
       (.C(clkb),
        .CE(1'b1),
        .D(D[9]),
        .Q(DECIN_REG[9]),
        .R(1'b0));
  FDRE \softecc_outreg.SYNDROME_reg[0] 
       (.C(clkb),
        .CE(1'b1),
        .D(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [0]),
        .Q(sel0[7]),
        .R(1'b0));
  FDRE \softecc_outreg.SYNDROME_reg[1] 
       (.C(clkb),
        .CE(1'b1),
        .D(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [1]),
        .Q(sel0[0]),
        .R(1'b0));
  FDRE \softecc_outreg.SYNDROME_reg[2] 
       (.C(clkb),
        .CE(1'b1),
        .D(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [2]),
        .Q(sel0[1]),
        .R(1'b0));
  FDRE \softecc_outreg.SYNDROME_reg[3] 
       (.C(clkb),
        .CE(1'b1),
        .D(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [3]),
        .Q(sel0[2]),
        .R(1'b0));
  FDRE \softecc_outreg.SYNDROME_reg[4] 
       (.C(clkb),
        .CE(1'b1),
        .D(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [4]),
        .Q(sel0[3]),
        .R(1'b0));
  FDRE \softecc_outreg.SYNDROME_reg[5] 
       (.C(clkb),
        .CE(1'b1),
        .D(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [5]),
        .Q(sel0[4]),
        .R(1'b0));
  FDRE \softecc_outreg.SYNDROME_reg[6] 
       (.C(clkb),
        .CE(1'b1),
        .D(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram [6]),
        .Q(sel0[5]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_ecc_encoder" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_encoder
   (ENCOUT,
    dina,
    clka);
  output [42:0]ENCOUT;
  input [35:0]dina;
  input clka;

  wire [42:0]ENCOUT;
  wire clka;
  wire [35:0]dina;
  wire p_33_in34_in;
  wire p_35_in;
  wire p_36_in;
  wire p_37_in;
  wire p_38_in;
  wire p_39_in;
  wire p_42_out;
  wire \softecc_inreg.ENC_CHKBITS_REG[0]_i_2_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[0]_i_3_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[0]_i_4_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[1]_i_2_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[1]_i_3_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[1]_i_4_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[1]_i_5_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[2]_i_2_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[2]_i_3_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[2]_i_4_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[2]_i_5_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[3]_i_2_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[3]_i_3_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[3]_i_4_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[4]_i_2_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[4]_i_3_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[5]_i_2_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[5]_i_3_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[5]_i_4_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[6]_i_2_n_0 ;
  wire \softecc_inreg.ENC_CHKBITS_REG[6]_i_3_n_0 ;

  FDRE \softecc_inreg.ENCIN_REG_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[0]),
        .Q(ENCOUT[0]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[10] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[10]),
        .Q(ENCOUT[10]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[11] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[11]),
        .Q(ENCOUT[11]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[12] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[12]),
        .Q(ENCOUT[12]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[13] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[13]),
        .Q(ENCOUT[13]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[14] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[14]),
        .Q(ENCOUT[14]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[15] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[15]),
        .Q(ENCOUT[15]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[16] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[16]),
        .Q(ENCOUT[16]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[17] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[17]),
        .Q(ENCOUT[17]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[18] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[18]),
        .Q(ENCOUT[18]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[19] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[19]),
        .Q(ENCOUT[19]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[1]),
        .Q(ENCOUT[1]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[20] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[20]),
        .Q(ENCOUT[20]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[21] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[21]),
        .Q(ENCOUT[21]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[22] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[22]),
        .Q(ENCOUT[22]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[23] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[23]),
        .Q(ENCOUT[23]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[24] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[24]),
        .Q(ENCOUT[24]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[25] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[25]),
        .Q(ENCOUT[25]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[26] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[26]),
        .Q(ENCOUT[26]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[27] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[27]),
        .Q(ENCOUT[27]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[28] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[28]),
        .Q(ENCOUT[28]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[29] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[29]),
        .Q(ENCOUT[29]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[2]),
        .Q(ENCOUT[2]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[30] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[30]),
        .Q(ENCOUT[30]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[31] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[31]),
        .Q(ENCOUT[31]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[32] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[32]),
        .Q(ENCOUT[32]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[33] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[33]),
        .Q(ENCOUT[33]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[34] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[34]),
        .Q(ENCOUT[34]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[35] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[35]),
        .Q(ENCOUT[35]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[3]),
        .Q(ENCOUT[3]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[4]),
        .Q(ENCOUT[4]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[5] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[5]),
        .Q(ENCOUT[5]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[6] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[6]),
        .Q(ENCOUT[6]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[7] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[7]),
        .Q(ENCOUT[7]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[8] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[8]),
        .Q(ENCOUT[8]),
        .R(1'b0));
  FDRE \softecc_inreg.ENCIN_REG_reg[9] 
       (.C(clka),
        .CE(1'b1),
        .D(dina[9]),
        .Q(ENCOUT[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[0]_i_1 
       (.I0(\softecc_inreg.ENC_CHKBITS_REG[0]_i_2_n_0 ),
        .I1(\softecc_inreg.ENC_CHKBITS_REG[0]_i_3_n_0 ),
        .I2(\softecc_inreg.ENC_CHKBITS_REG[0]_i_4_n_0 ),
        .I3(dina[7]),
        .I4(dina[18]),
        .I5(dina[23]),
        .O(p_42_out));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[0]_i_2 
       (.I0(dina[32]),
        .I1(dina[27]),
        .I2(dina[29]),
        .I3(dina[24]),
        .I4(dina[21]),
        .I5(dina[10]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[0]_i_3 
       (.I0(dina[2]),
        .I1(dina[11]),
        .I2(dina[4]),
        .I3(dina[17]),
        .I4(dina[33]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[0]_i_4 
       (.I0(dina[5]),
        .I1(dina[12]),
        .I2(dina[1]),
        .I3(dina[0]),
        .I4(dina[14]),
        .I5(dina[26]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[1]_i_1 
       (.I0(\softecc_inreg.ENC_CHKBITS_REG[1]_i_2_n_0 ),
        .I1(\softecc_inreg.ENC_CHKBITS_REG[1]_i_3_n_0 ),
        .I2(dina[0]),
        .I3(dina[23]),
        .I4(dina[1]),
        .I5(\softecc_inreg.ENC_CHKBITS_REG[1]_i_4_n_0 ),
        .O(p_39_in));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \softecc_inreg.ENC_CHKBITS_REG[1]_i_2 
       (.I0(dina[17]),
        .I1(dina[10]),
        .I2(dina[3]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[1]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \softecc_inreg.ENC_CHKBITS_REG[1]_i_3 
       (.I0(\softecc_inreg.ENC_CHKBITS_REG[1]_i_5_n_0 ),
        .I1(dina[13]),
        .I2(dina[6]),
        .I3(dina[25]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[1]_i_4 
       (.I0(dina[21]),
        .I1(dina[15]),
        .I2(dina[26]),
        .I3(dina[32]),
        .I4(dina[11]),
        .I5(dina[4]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[1]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[1]_i_5 
       (.I0(dina[28]),
        .I1(dina[19]),
        .I2(dina[34]),
        .I3(dina[8]),
        .I4(dina[30]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[1]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[2]_i_1 
       (.I0(dina[17]),
        .I1(dina[10]),
        .I2(dina[3]),
        .I3(\softecc_inreg.ENC_CHKBITS_REG[2]_i_2_n_0 ),
        .I4(\softecc_inreg.ENC_CHKBITS_REG[2]_i_3_n_0 ),
        .O(p_38_in));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h6996)) 
    \softecc_inreg.ENC_CHKBITS_REG[2]_i_2 
       (.I0(dina[25]),
        .I1(dina[24]),
        .I2(dina[21]),
        .I3(dina[20]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[2]_i_3 
       (.I0(\softecc_inreg.ENC_CHKBITS_REG[2]_i_4_n_0 ),
        .I1(\softecc_inreg.ENC_CHKBITS_REG[2]_i_5_n_0 ),
        .I2(dina[13]),
        .I3(dina[28]),
        .I4(dina[6]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[2]_i_4 
       (.I0(dina[27]),
        .I1(dina[32]),
        .I2(dina[5]),
        .I3(dina[0]),
        .I4(dina[2]),
        .I5(dina[12]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[2]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \softecc_inreg.ENC_CHKBITS_REG[2]_i_5 
       (.I0(dina[9]),
        .I1(dina[35]),
        .I2(dina[16]),
        .I3(dina[31]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[2]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[3]_i_1 
       (.I0(dina[3]),
        .I1(dina[10]),
        .I2(dina[17]),
        .I3(\softecc_inreg.ENC_CHKBITS_REG[3]_i_2_n_0 ),
        .I4(\softecc_inreg.ENC_CHKBITS_REG[3]_i_3_n_0 ),
        .I5(\softecc_inreg.ENC_CHKBITS_REG[3]_i_4_n_0 ),
        .O(p_37_in));
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[3]_i_2 
       (.I0(dina[25]),
        .I1(dina[16]),
        .I2(dina[8]),
        .I3(dina[15]),
        .I4(dina[30]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[3]_i_3 
       (.I0(dina[32]),
        .I1(dina[22]),
        .I2(dina[23]),
        .I3(dina[31]),
        .I4(dina[9]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[3]_i_4 
       (.I0(dina[29]),
        .I1(dina[14]),
        .I2(dina[24]),
        .I3(dina[7]),
        .I4(dina[1]),
        .I5(dina[2]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[4]_i_1 
       (.I0(dina[23]),
        .I1(dina[22]),
        .I2(dina[35]),
        .I3(dina[9]),
        .I4(\softecc_inreg.ENC_CHKBITS_REG[4]_i_2_n_0 ),
        .I5(\softecc_inreg.ENC_CHKBITS_REG[4]_i_3_n_0 ),
        .O(p_36_in));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[4]_i_2 
       (.I0(dina[19]),
        .I1(dina[6]),
        .I2(dina[10]),
        .I3(dina[33]),
        .I4(dina[34]),
        .I5(dina[8]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[4]_i_3 
       (.I0(\softecc_inreg.ENC_CHKBITS_REG[2]_i_2_n_0 ),
        .I1(dina[7]),
        .I2(dina[5]),
        .I3(dina[18]),
        .I4(dina[4]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[5]_i_1 
       (.I0(\softecc_inreg.ENC_CHKBITS_REG[5]_i_2_n_0 ),
        .I1(dina[17]),
        .I2(\softecc_inreg.ENC_CHKBITS_REG[5]_i_3_n_0 ),
        .I3(dina[13]),
        .I4(dina[16]),
        .I5(\softecc_inreg.ENC_CHKBITS_REG[5]_i_4_n_0 ),
        .O(p_35_in));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \softecc_inreg.ENC_CHKBITS_REG[5]_i_2 
       (.I0(dina[22]),
        .I1(dina[23]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[5]_i_3 
       (.I0(dina[19]),
        .I1(dina[12]),
        .I2(dina[14]),
        .I3(dina[15]),
        .I4(dina[11]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[5]_i_4 
       (.I0(dina[20]),
        .I1(dina[21]),
        .I2(dina[24]),
        .I3(dina[25]),
        .I4(dina[18]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_inreg.ENC_CHKBITS_REG[6]_i_1 
       (.I0(dina[29]),
        .I1(\softecc_inreg.ENC_CHKBITS_REG[6]_i_2_n_0 ),
        .I2(dina[35]),
        .I3(dina[31]),
        .I4(dina[28]),
        .I5(\softecc_inreg.ENC_CHKBITS_REG[6]_i_3_n_0 ),
        .O(p_33_in34_in));
  LUT2 #(
    .INIT(4'h6)) 
    \softecc_inreg.ENC_CHKBITS_REG[6]_i_2 
       (.I0(dina[32]),
        .I1(dina[27]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[6]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h6996)) 
    \softecc_inreg.ENC_CHKBITS_REG[6]_i_3 
       (.I0(dina[34]),
        .I1(dina[30]),
        .I2(dina[26]),
        .I3(dina[33]),
        .O(\softecc_inreg.ENC_CHKBITS_REG[6]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_inreg.ENC_CHKBITS_REG_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(p_42_out),
        .Q(ENCOUT[36]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_inreg.ENC_CHKBITS_REG_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(p_39_in),
        .Q(ENCOUT[37]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_inreg.ENC_CHKBITS_REG_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(p_38_in),
        .Q(ENCOUT[38]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_inreg.ENC_CHKBITS_REG_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(p_37_in),
        .Q(ENCOUT[39]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_inreg.ENC_CHKBITS_REG_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(p_36_in),
        .Q(ENCOUT[40]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_inreg.ENC_CHKBITS_REG_reg[5] 
       (.C(clka),
        .CE(1'b1),
        .D(p_35_in),
        .Q(ENCOUT[41]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_inreg.ENC_CHKBITS_REG_reg[6] 
       (.C(clka),
        .CE(1'b1),
        .D(p_33_in34_in),
        .Q(ENCOUT[42]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_generic_cstr
   (D,
    \softecc_outreg.rdaddrecc_in_reg[11] ,
    \softecc_outreg.SYNDROME_reg[6] ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT);
  output [35:0]D;
  output [11:0]\softecc_outreg.rdaddrecc_in_reg[11] ;
  output [6:0]\softecc_outreg.SYNDROME_reg[6] ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [42:0]ENCOUT;

  wire [35:0]D;
  wire [42:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire [42:37]doutb_i;
  wire ena_i;
  wire enb;
  wire \ramloop[0].ram.r_n_12 ;
  wire \ramloop[0].ram.r_n_13 ;
  wire \ramloop[0].ram.r_n_14 ;
  wire \ramloop[0].ram.r_n_15 ;
  wire \ramloop[0].ram.r_n_16 ;
  wire \ramloop[1].ram.r_n_11 ;
  wire \ramloop[1].ram.r_n_12 ;
  wire \ramloop[1].ram.r_n_13 ;
  wire \ramloop[2].ram.r_n_10 ;
  wire \ramloop[2].ram.r_n_11 ;
  wire \ramloop[2].ram.r_n_12 ;
  wire \ramloop[3].ram.r_n_10 ;
  wire \ramloop[3].ram.r_n_11 ;
  wire \ramloop[3].ram.r_n_12 ;
  wire \ramloop[3].ram.r_n_13 ;
  wire \ramloop[3].ram.r_n_14 ;
  wire \ramloop[4].ram.r_n_6 ;
  wire [11:0]rdaddrecc_lat;
  wire [6:0]\softecc_outreg.SYNDROME_reg[6] ;
  wire [11:0]\softecc_outreg.rdaddrecc_in_reg[11] ;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.D(D[8]),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\ramloop[2].ram.r_n_10 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\ramloop[4].ram.r_n_6 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\ramloop[3].ram.r_n_11 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 (\ramloop[2].ram.r_n_11 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ({D[16:15],D[10]}),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 (D[34:32]),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 (D[35]),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 (\ramloop[3].ram.r_n_14 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 (\ramloop[2].ram.r_n_12 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 (\ramloop[1].ram.r_n_13 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 (\ramloop[3].ram.r_n_12 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ({D[23],D[21:20]}),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 (doutb_i[39:38]),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 (\ramloop[3].ram.r_n_13 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 (\ramloop[1].ram.r_n_12 ),
        .DOBDO(D[7:0]),
        .ENCOUT(ENCOUT[8:0]),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[2] (\ramloop[0].ram.r_n_14 ),
        .\softecc_outreg.SYNDROME_reg[2]_0 (\ramloop[0].ram.r_n_15 ),
        .\softecc_outreg.SYNDROME_reg[3] ({\softecc_outreg.SYNDROME_reg[6] [3],\softecc_outreg.SYNDROME_reg[6] [1:0]}),
        .\softecc_outreg.SYNDROME_reg[3]_0 (\ramloop[0].ram.r_n_12 ),
        .\softecc_outreg.SYNDROME_reg[4] (\ramloop[0].ram.r_n_13 ),
        .\softecc_outreg.SYNDROME_reg[4]_0 (\ramloop[0].ram.r_n_16 ));
  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.D({D[28],D[25:24],D[4]}),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\ramloop[0].ram.r_n_14 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\ramloop[0].ram.r_n_12 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\ramloop[3].ram.r_n_10 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 (\ramloop[2].ram.r_n_10 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ({doutb_i[41],doutb_i[37]}),
        .DOBDO(D[16:9]),
        .DOPBDOP(D[17]),
        .ENCOUT(ENCOUT[17:9]),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[1] (\ramloop[1].ram.r_n_13 ),
        .\softecc_outreg.SYNDROME_reg[3] (\ramloop[1].ram.r_n_12 ),
        .\softecc_outreg.SYNDROME_reg[5] ({\softecc_outreg.SYNDROME_reg[6] [5],\softecc_outreg.SYNDROME_reg[6] [2]}),
        .\softecc_outreg.SYNDROME_reg[5]_0 (\ramloop[1].ram.r_n_11 ));
  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.D(D[26:18]),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (doutb_i[40]),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\ramloop[0].ram.r_n_13 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\ramloop[0].ram.r_n_16 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ({D[32],D[3]}),
        .DOBDO(D[10:9]),
        .ENCOUT(ENCOUT[26:18]),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[1] (\ramloop[2].ram.r_n_12 ),
        .\softecc_outreg.SYNDROME_reg[4] (\softecc_outreg.SYNDROME_reg[6] [4]),
        .\softecc_outreg.SYNDROME_reg[4]_0 (\ramloop[2].ram.r_n_10 ),
        .\softecc_outreg.SYNDROME_reg[4]_1 (\ramloop[2].ram.r_n_11 ));
  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.D(D[35]),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ({D[26],D[22],D[17],D[11],D[7],D[4]}),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (doutb_i[42:41]),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\ramloop[0].ram.r_n_15 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 (\ramloop[1].ram.r_n_12 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 (\ramloop[1].ram.r_n_11 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 (\ramloop[0].ram.r_n_16 ),
        .DOBDO(D[34:27]),
        .ENCOUT(ENCOUT[35:27]),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[0] (\ramloop[3].ram.r_n_11 ),
        .\softecc_outreg.SYNDROME_reg[0]_0 (\ramloop[3].ram.r_n_14 ),
        .\softecc_outreg.SYNDROME_reg[1] (\ramloop[3].ram.r_n_12 ),
        .\softecc_outreg.SYNDROME_reg[3] (\ramloop[3].ram.r_n_13 ),
        .\softecc_outreg.SYNDROME_reg[6] (\softecc_outreg.SYNDROME_reg[6] [6]),
        .\softecc_outreg.SYNDROME_reg[6]_0 (\ramloop[3].ram.r_n_10 ));
  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized3 \ramloop[4].ram.r 
       (.DOBDO(doutb_i),
        .ENCOUT(ENCOUT[42:36]),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[0] (\ramloop[4].ram.r_n_6 ));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[0] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[0]),
        .Q(rdaddrecc_lat[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[10] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[10]),
        .Q(rdaddrecc_lat[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[11] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[11]),
        .Q(rdaddrecc_lat[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[1] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[1]),
        .Q(rdaddrecc_lat[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[2] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[2]),
        .Q(rdaddrecc_lat[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[3] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[3]),
        .Q(rdaddrecc_lat[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[4] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[4]),
        .Q(rdaddrecc_lat[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[5] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[5]),
        .Q(rdaddrecc_lat[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[6] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[6]),
        .Q(rdaddrecc_lat[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[7] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[7]),
        .Q(rdaddrecc_lat[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[8] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[8]),
        .Q(rdaddrecc_lat[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_lat_reg[9] 
       (.C(clkb),
        .CE(enb),
        .D(addrb[9]),
        .Q(rdaddrecc_lat[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[0] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[0]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[10] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[10]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[11] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[11]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[1] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[1]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[2] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[2]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[3] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[3]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[4] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[4]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[5] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[5]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[6] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[6]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[7] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[7]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[8] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[8]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_addrb_lat_del.rdaddrecc_reg_reg[9] 
       (.C(clkb),
        .CE(enb),
        .D(rdaddrecc_lat[9]),
        .Q(\softecc_outreg.rdaddrecc_in_reg[11] [9]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width
   (DOBDO,
    D,
    \softecc_outreg.SYNDROME_reg[3] ,
    \softecc_outreg.SYNDROME_reg[3]_0 ,
    \softecc_outreg.SYNDROME_reg[4] ,
    \softecc_outreg.SYNDROME_reg[2] ,
    \softecc_outreg.SYNDROME_reg[2]_0 ,
    \softecc_outreg.SYNDROME_reg[4]_0 ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 );
  output [7:0]DOBDO;
  output [0:0]D;
  output [2:0]\softecc_outreg.SYNDROME_reg[3] ;
  output \softecc_outreg.SYNDROME_reg[3]_0 ;
  output \softecc_outreg.SYNDROME_reg[4] ;
  output \softecc_outreg.SYNDROME_reg[2] ;
  output \softecc_outreg.SYNDROME_reg[2]_0 ;
  output \softecc_outreg.SYNDROME_reg[4]_0 ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [8:0]ENCOUT;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ;
  input [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ;
  input [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 ;
  input [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ;
  input [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 ;

  wire [0:0]D;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 ;
  wire [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ;
  wire [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ;
  wire [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ;
  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 ;
  wire [7:0]DOBDO;
  wire [8:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME_reg[2] ;
  wire \softecc_outreg.SYNDROME_reg[2]_0 ;
  wire [2:0]\softecc_outreg.SYNDROME_reg[3] ;
  wire \softecc_outreg.SYNDROME_reg[3]_0 ;
  wire \softecc_outreg.SYNDROME_reg[4] ;
  wire \softecc_outreg.SYNDROME_reg[4]_0 ;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper \prim_noinit.ram 
       (.D(D),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_14 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 ),
        .DOBDO(DOBDO),
        .ENCOUT(ENCOUT),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[2] (\softecc_outreg.SYNDROME_reg[2] ),
        .\softecc_outreg.SYNDROME_reg[2]_0 (\softecc_outreg.SYNDROME_reg[2]_0 ),
        .\softecc_outreg.SYNDROME_reg[3] (\softecc_outreg.SYNDROME_reg[3] ),
        .\softecc_outreg.SYNDROME_reg[3]_0 (\softecc_outreg.SYNDROME_reg[3]_0 ),
        .\softecc_outreg.SYNDROME_reg[4] (\softecc_outreg.SYNDROME_reg[4] ),
        .\softecc_outreg.SYNDROME_reg[4]_0 (\softecc_outreg.SYNDROME_reg[4]_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized0
   (DOBDO,
    DOPBDOP,
    \softecc_outreg.SYNDROME_reg[5] ,
    \softecc_outreg.SYNDROME_reg[5]_0 ,
    \softecc_outreg.SYNDROME_reg[3] ,
    \softecc_outreg.SYNDROME_reg[1] ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ,
    D,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 );
  output [7:0]DOBDO;
  output [0:0]DOPBDOP;
  output [1:0]\softecc_outreg.SYNDROME_reg[5] ;
  output \softecc_outreg.SYNDROME_reg[5]_0 ;
  output \softecc_outreg.SYNDROME_reg[3] ;
  output \softecc_outreg.SYNDROME_reg[1] ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [8:0]ENCOUT;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  input [3:0]D;
  input [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;

  wire [3:0]D;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  wire [7:0]DOBDO;
  wire [0:0]DOPBDOP;
  wire [8:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME_reg[1] ;
  wire \softecc_outreg.SYNDROME_reg[3] ;
  wire [1:0]\softecc_outreg.SYNDROME_reg[5] ;
  wire \softecc_outreg.SYNDROME_reg[5]_0 ;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized0 \prim_noinit.ram 
       (.D(D),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ),
        .DOBDO(DOBDO),
        .DOPBDOP(DOPBDOP),
        .ENCOUT(ENCOUT),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[1] (\softecc_outreg.SYNDROME_reg[1] ),
        .\softecc_outreg.SYNDROME_reg[3] (\softecc_outreg.SYNDROME_reg[3] ),
        .\softecc_outreg.SYNDROME_reg[5] (\softecc_outreg.SYNDROME_reg[5] ),
        .\softecc_outreg.SYNDROME_reg[5]_0 (\softecc_outreg.SYNDROME_reg[5]_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized1
   (D,
    \softecc_outreg.SYNDROME_reg[4] ,
    \softecc_outreg.SYNDROME_reg[4]_0 ,
    \softecc_outreg.SYNDROME_reg[4]_1 ,
    \softecc_outreg.SYNDROME_reg[1] ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT,
    DOBDO,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 );
  output [8:0]D;
  output [0:0]\softecc_outreg.SYNDROME_reg[4] ;
  output \softecc_outreg.SYNDROME_reg[4]_0 ;
  output \softecc_outreg.SYNDROME_reg[4]_1 ;
  output \softecc_outreg.SYNDROME_reg[1] ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [8:0]ENCOUT;
  input [1:0]DOBDO;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;

  wire [8:0]D;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire [1:0]DOBDO;
  wire [8:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME_reg[1] ;
  wire [0:0]\softecc_outreg.SYNDROME_reg[4] ;
  wire \softecc_outreg.SYNDROME_reg[4]_0 ;
  wire \softecc_outreg.SYNDROME_reg[4]_1 ;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized1 \prim_noinit.ram 
       (.D(D),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .DOBDO(DOBDO),
        .ENCOUT(ENCOUT),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[1] (\softecc_outreg.SYNDROME_reg[1] ),
        .\softecc_outreg.SYNDROME_reg[4] (\softecc_outreg.SYNDROME_reg[4] ),
        .\softecc_outreg.SYNDROME_reg[4]_0 (\softecc_outreg.SYNDROME_reg[4]_0 ),
        .\softecc_outreg.SYNDROME_reg[4]_1 (\softecc_outreg.SYNDROME_reg[4]_1 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized2
   (DOBDO,
    D,
    \softecc_outreg.SYNDROME_reg[6] ,
    \softecc_outreg.SYNDROME_reg[6]_0 ,
    \softecc_outreg.SYNDROME_reg[0] ,
    \softecc_outreg.SYNDROME_reg[1] ,
    \softecc_outreg.SYNDROME_reg[3] ,
    \softecc_outreg.SYNDROME_reg[0]_0 ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 );
  output [7:0]DOBDO;
  output [0:0]D;
  output [0:0]\softecc_outreg.SYNDROME_reg[6] ;
  output \softecc_outreg.SYNDROME_reg[6]_0 ;
  output \softecc_outreg.SYNDROME_reg[0] ;
  output \softecc_outreg.SYNDROME_reg[1] ;
  output \softecc_outreg.SYNDROME_reg[3] ;
  output \softecc_outreg.SYNDROME_reg[0]_0 ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [8:0]ENCOUT;
  input [5:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  input [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;

  wire [0:0]D;
  wire [5:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  wire [7:0]DOBDO;
  wire [8:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME_reg[0] ;
  wire \softecc_outreg.SYNDROME_reg[0]_0 ;
  wire \softecc_outreg.SYNDROME_reg[1] ;
  wire \softecc_outreg.SYNDROME_reg[3] ;
  wire [0:0]\softecc_outreg.SYNDROME_reg[6] ;
  wire \softecc_outreg.SYNDROME_reg[6]_0 ;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized2 \prim_noinit.ram 
       (.D(D),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ),
        .DOBDO(DOBDO),
        .ENCOUT(ENCOUT),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[0] (\softecc_outreg.SYNDROME_reg[0] ),
        .\softecc_outreg.SYNDROME_reg[0]_0 (\softecc_outreg.SYNDROME_reg[0]_0 ),
        .\softecc_outreg.SYNDROME_reg[1] (\softecc_outreg.SYNDROME_reg[1] ),
        .\softecc_outreg.SYNDROME_reg[3] (\softecc_outreg.SYNDROME_reg[3] ),
        .\softecc_outreg.SYNDROME_reg[6] (\softecc_outreg.SYNDROME_reg[6] ),
        .\softecc_outreg.SYNDROME_reg[6]_0 (\softecc_outreg.SYNDROME_reg[6]_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_width__parameterized3
   (DOBDO,
    \softecc_outreg.SYNDROME_reg[0] ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT);
  output [5:0]DOBDO;
  output \softecc_outreg.SYNDROME_reg[0] ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [6:0]ENCOUT;

  wire [5:0]DOBDO;
  wire [6:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME_reg[0] ;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized3 \prim_noinit.ram 
       (.DOBDO(DOBDO),
        .ENCOUT(ENCOUT),
        .Q(Q),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[0] (\softecc_outreg.SYNDROME_reg[0] ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper
   (DOBDO,
    D,
    \softecc_outreg.SYNDROME_reg[3] ,
    \softecc_outreg.SYNDROME_reg[3]_0 ,
    \softecc_outreg.SYNDROME_reg[4] ,
    \softecc_outreg.SYNDROME_reg[2] ,
    \softecc_outreg.SYNDROME_reg[2]_0 ,
    \softecc_outreg.SYNDROME_reg[4]_0 ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_14 );
  output [7:0]DOBDO;
  output [0:0]D;
  output [2:0]\softecc_outreg.SYNDROME_reg[3] ;
  output \softecc_outreg.SYNDROME_reg[3]_0 ;
  output \softecc_outreg.SYNDROME_reg[4] ;
  output \softecc_outreg.SYNDROME_reg[2] ;
  output \softecc_outreg.SYNDROME_reg[2]_0 ;
  output \softecc_outreg.SYNDROME_reg[4]_0 ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [8:0]ENCOUT;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ;
  input [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ;
  input [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ;
  input [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 ;
  input [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 ;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_14 ;

  wire [0:0]D;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ;
  wire [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 ;
  wire [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_14 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ;
  wire [2:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 ;
  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 ;
  wire [7:0]DOBDO;
  wire [8:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME[3]_i_5_n_0 ;
  wire \softecc_outreg.SYNDROME_reg[2] ;
  wire \softecc_outreg.SYNDROME_reg[2]_0 ;
  wire [2:0]\softecc_outreg.SYNDROME_reg[3] ;
  wire \softecc_outreg.SYNDROME_reg[3]_0 ;
  wire \softecc_outreg.SYNDROME_reg[4] ;
  wire \softecc_outreg.SYNDROME_reg[4]_0 ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,Q,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ENCOUT[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,ENCOUT[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:0]),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],DOBDO}),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],D}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_i),
        .ENBWREN(enb),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b1,1'b1,1'b1,1'b1}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[0]_i_1 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .I1(\softecc_outreg.SYNDROME[3]_i_5_n_0 ),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .I4(\softecc_outreg.SYNDROME_reg[3]_0 ),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ),
        .O(\softecc_outreg.SYNDROME_reg[3] [0]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[1]_i_1 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ),
        .I1(\softecc_outreg.SYNDROME[3]_i_5_n_0 ),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ),
        .I3(DOBDO[6]),
        .I4(DOBDO[0]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_6 ),
        .O(\softecc_outreg.SYNDROME_reg[3] [1]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[2]_i_2 
       (.I0(\softecc_outreg.SYNDROME_reg[2]_0 ),
        .I1(\softecc_outreg.SYNDROME_reg[4]_0 ),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 [2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 [0]),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 [0]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 [1]),
        .O(\softecc_outreg.SYNDROME_reg[2] ));
  LUT2 #(
    .INIT(4'h6)) 
    \softecc_outreg.SYNDROME[2]_i_3 
       (.I0(DOBDO[0]),
        .I1(DOBDO[6]),
        .O(\softecc_outreg.SYNDROME_reg[2]_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[3]_i_1 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_7 [2]),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_8 [1]),
        .I2(\softecc_outreg.SYNDROME_reg[3]_0 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_9 ),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_10 ),
        .I5(\softecc_outreg.SYNDROME[3]_i_5_n_0 ),
        .O(\softecc_outreg.SYNDROME_reg[3] [2]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_outreg.SYNDROME[3]_i_2 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_11 ),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 [0]),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 [0]),
        .I3(DOBDO[3]),
        .I4(DOBDO[2]),
        .O(\softecc_outreg.SYNDROME_reg[3]_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \softecc_outreg.SYNDROME[3]_i_5 
       (.I0(D),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_12 [1]),
        .I2(DOBDO[1]),
        .O(\softecc_outreg.SYNDROME[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[4]_i_2 
       (.I0(DOBDO[6]),
        .I1(D),
        .I2(DOBDO[4]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 [1]),
        .I4(DOBDO[7]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_13 [2]),
        .O(\softecc_outreg.SYNDROME_reg[4] ));
  LUT2 #(
    .INIT(4'h6)) 
    \softecc_outreg.SYNDROME[4]_i_4 
       (.I0(DOBDO[5]),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_14 ),
        .O(\softecc_outreg.SYNDROME_reg[4]_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized0
   (DOBDO,
    DOPBDOP,
    \softecc_outreg.SYNDROME_reg[5] ,
    \softecc_outreg.SYNDROME_reg[5]_0 ,
    \softecc_outreg.SYNDROME_reg[3] ,
    \softecc_outreg.SYNDROME_reg[1] ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ,
    D,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 );
  output [7:0]DOBDO;
  output [0:0]DOPBDOP;
  output [1:0]\softecc_outreg.SYNDROME_reg[5] ;
  output \softecc_outreg.SYNDROME_reg[5]_0 ;
  output \softecc_outreg.SYNDROME_reg[3] ;
  output \softecc_outreg.SYNDROME_reg[1] ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [8:0]ENCOUT;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  input [3:0]D;
  input [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;

  wire [3:0]D;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  wire [7:0]DOBDO;
  wire [0:0]DOPBDOP;
  wire [8:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME[1]_i_5_n_0 ;
  wire \softecc_outreg.SYNDROME[5]_i_3_n_0 ;
  wire \softecc_outreg.SYNDROME_reg[1] ;
  wire \softecc_outreg.SYNDROME_reg[3] ;
  wire [1:0]\softecc_outreg.SYNDROME_reg[5] ;
  wire \softecc_outreg.SYNDROME_reg[5]_0 ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,Q,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ENCOUT[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,ENCOUT[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:0]),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],DOBDO}),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],DOPBDOP}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_i),
        .ENBWREN(enb),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b1,1'b1,1'b1,1'b1}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[1]_i_3 
       (.I0(D[2]),
        .I1(\softecc_outreg.SYNDROME[1]_i_5_n_0 ),
        .I2(D[0]),
        .I3(DOBDO[2]),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 [0]),
        .I5(D[3]),
        .O(\softecc_outreg.SYNDROME_reg[1] ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \softecc_outreg.SYNDROME[1]_i_5 
       (.I0(DOBDO[4]),
        .I1(DOPBDOP),
        .O(\softecc_outreg.SYNDROME[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[2]_i_1 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .I3(DOPBDOP),
        .I4(DOBDO[4]),
        .I5(DOBDO[3]),
        .O(\softecc_outreg.SYNDROME_reg[5] [0]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \softecc_outreg.SYNDROME[3]_i_4 
       (.I0(DOBDO[7]),
        .I1(DOBDO[5]),
        .O(\softecc_outreg.SYNDROME_reg[3] ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_outreg.SYNDROME[5]_i_1 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ),
        .I1(\softecc_outreg.SYNDROME[5]_i_3_n_0 ),
        .I2(\softecc_outreg.SYNDROME_reg[5]_0 ),
        .I3(DOBDO[5]),
        .I4(DOBDO[7]),
        .O(\softecc_outreg.SYNDROME_reg[5] [1]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \softecc_outreg.SYNDROME[5]_i_3 
       (.I0(DOBDO[6]),
        .I1(D[1]),
        .I2(D[2]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 [1]),
        .I4(DOBDO[2]),
        .O(\softecc_outreg.SYNDROME[5]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \softecc_outreg.SYNDROME[5]_i_4 
       (.I0(DOPBDOP),
        .I1(DOBDO[4]),
        .I2(DOBDO[3]),
        .O(\softecc_outreg.SYNDROME_reg[5]_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized1
   (D,
    \softecc_outreg.SYNDROME_reg[4] ,
    \softecc_outreg.SYNDROME_reg[4]_0 ,
    \softecc_outreg.SYNDROME_reg[4]_1 ,
    \softecc_outreg.SYNDROME_reg[1] ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT,
    DOBDO,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 );
  output [8:0]D;
  output [0:0]\softecc_outreg.SYNDROME_reg[4] ;
  output \softecc_outreg.SYNDROME_reg[4]_0 ;
  output \softecc_outreg.SYNDROME_reg[4]_1 ;
  output \softecc_outreg.SYNDROME_reg[1] ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [8:0]ENCOUT;
  input [1:0]DOBDO;
  input [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  input [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;

  wire [8:0]D;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  wire [1:0]DOBDO;
  wire [8:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME_reg[1] ;
  wire [0:0]\softecc_outreg.SYNDROME_reg[4] ;
  wire \softecc_outreg.SYNDROME_reg[4]_0 ;
  wire \softecc_outreg.SYNDROME_reg[4]_1 ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,Q,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ENCOUT[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,ENCOUT[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:0]),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],D[7:0]}),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],D[8]}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_i),
        .ENBWREN(enb),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b1,1'b1,1'b1,1'b1}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[1]_i_2 
       (.I0(D[1]),
        .I1(D[5]),
        .I2(D[3]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 [0]),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 [1]),
        .I5(DOBDO[1]),
        .O(\softecc_outreg.SYNDROME_reg[1] ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[4]_i_1 
       (.I0(DOBDO[1]),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ),
        .I2(\softecc_outreg.SYNDROME_reg[4]_0 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ),
        .I4(\softecc_outreg.SYNDROME_reg[4]_1 ),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .O(\softecc_outreg.SYNDROME_reg[4] ));
  LUT3 #(
    .INIT(8'h96)) 
    \softecc_outreg.SYNDROME[4]_i_3 
       (.I0(D[7]),
        .I1(D[6]),
        .I2(DOBDO[0]),
        .O(\softecc_outreg.SYNDROME_reg[4]_1 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[5]_i_2 
       (.I0(D[0]),
        .I1(D[3]),
        .I2(D[5]),
        .I3(D[1]),
        .I4(D[4]),
        .I5(D[2]),
        .O(\softecc_outreg.SYNDROME_reg[4]_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized2
   (DOBDO,
    D,
    \softecc_outreg.SYNDROME_reg[6] ,
    \softecc_outreg.SYNDROME_reg[6]_0 ,
    \softecc_outreg.SYNDROME_reg[0] ,
    \softecc_outreg.SYNDROME_reg[1] ,
    \softecc_outreg.SYNDROME_reg[3] ,
    \softecc_outreg.SYNDROME_reg[0]_0 ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 );
  output [7:0]DOBDO;
  output [0:0]D;
  output [0:0]\softecc_outreg.SYNDROME_reg[6] ;
  output \softecc_outreg.SYNDROME_reg[6]_0 ;
  output \softecc_outreg.SYNDROME_reg[0] ;
  output \softecc_outreg.SYNDROME_reg[1] ;
  output \softecc_outreg.SYNDROME_reg[3] ;
  output \softecc_outreg.SYNDROME_reg[0]_0 ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [8:0]ENCOUT;
  input [5:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  input [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  input \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ;

  wire [0:0]D;
  wire [5:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 ;
  wire [1:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ;
  wire [7:0]DOBDO;
  wire [8:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME[6]_i_2_n_0 ;
  wire \softecc_outreg.SYNDROME_reg[0] ;
  wire \softecc_outreg.SYNDROME_reg[0]_0 ;
  wire \softecc_outreg.SYNDROME_reg[1] ;
  wire \softecc_outreg.SYNDROME_reg[3] ;
  wire [0:0]\softecc_outreg.SYNDROME_reg[6] ;
  wire \softecc_outreg.SYNDROME_reg[6]_0 ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,Q,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ENCOUT[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,ENCOUT[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:0]),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],DOBDO}),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],D}),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_i),
        .ENBWREN(enb),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b1,1'b1,1'b1,1'b1}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[0]_i_3 
       (.I0(\softecc_outreg.SYNDROME_reg[6]_0 ),
        .I1(\softecc_outreg.SYNDROME_reg[1] ),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_2 ),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_3 ),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_4 ),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_5 ),
        .O(\softecc_outreg.SYNDROME_reg[0] ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[0]_i_4 
       (.I0(DOBDO[2]),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [1]),
        .I2(DOBDO[6]),
        .I3(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 [0]),
        .I4(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [0]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [2]),
        .O(\softecc_outreg.SYNDROME_reg[0]_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \softecc_outreg.SYNDROME[1]_i_4 
       (.I0(DOBDO[7]),
        .I1(DOBDO[3]),
        .I2(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [5]),
        .O(\softecc_outreg.SYNDROME_reg[1] ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[3]_i_3 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [4]),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [3]),
        .I2(DOBDO[3]),
        .I3(DOBDO[2]),
        .I4(DOBDO[4]),
        .I5(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [1]),
        .O(\softecc_outreg.SYNDROME_reg[3] ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[6]_i_1 
       (.I0(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_0 [5]),
        .I1(DOBDO[3]),
        .I2(DOBDO[7]),
        .I3(\softecc_outreg.SYNDROME[6]_i_2_n_0 ),
        .I4(\softecc_outreg.SYNDROME_reg[6]_0 ),
        .I5(DOBDO[5]),
        .O(\softecc_outreg.SYNDROME_reg[6] ));
  LUT4 #(
    .INIT(16'h6996)) 
    \softecc_outreg.SYNDROME[6]_i_2 
       (.I0(D),
        .I1(\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_1 [1]),
        .I2(DOBDO[6]),
        .I3(DOBDO[2]),
        .O(\softecc_outreg.SYNDROME[6]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \softecc_outreg.SYNDROME[6]_i_3 
       (.I0(DOBDO[1]),
        .I1(DOBDO[4]),
        .I2(DOBDO[0]),
        .O(\softecc_outreg.SYNDROME_reg[6]_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_prim_wrapper__parameterized3
   (DOBDO,
    \softecc_outreg.SYNDROME_reg[0] ,
    clka,
    clkb,
    ena_i,
    enb,
    Q,
    addrb,
    ENCOUT);
  output [5:0]DOBDO;
  output \softecc_outreg.SYNDROME_reg[0] ;
  input clka;
  input clkb;
  input ena_i;
  input enb;
  input [11:0]Q;
  input [11:0]addrb;
  input [6:0]ENCOUT;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_77 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_92 ;
  wire [5:0]DOBDO;
  wire [6:0]ENCOUT;
  wire [11:0]Q;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire [36:36]doutb_i;
  wire ena_i;
  wire enb;
  wire \softecc_outreg.SYNDROME_reg[0] ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* CLOCK_DOMAINS = "INDEPENDENT" *) 
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,Q,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb,1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,ENCOUT}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:0]),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_77 ,DOBDO,doutb_i}),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_n_92 }),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_i),
        .ENBWREN(enb),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(enb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b1,1'b1,1'b1,1'b1}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \softecc_outreg.SYNDROME[0]_i_2 
       (.I0(doutb_i),
        .I1(DOBDO[2]),
        .I2(DOBDO[1]),
        .I3(DOBDO[5]),
        .I4(DOBDO[3]),
        .I5(DOBDO[0]),
        .O(\softecc_outreg.SYNDROME_reg[0] ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_top
   (rdaddrecc,
    doutb,
    dbiterr,
    sbiterr,
    dina,
    clka,
    clkb,
    enb,
    addrb,
    wea,
    addra);
  output [11:0]rdaddrecc;
  output [35:0]doutb;
  output dbiterr;
  output sbiterr;
  input [35:0]dina;
  input clka;
  input clkb;
  input enb;
  input [11:0]addrb;
  input [0:0]wea;
  input [11:0]addra;

  wire [11:0]addra;
  wire [11:0]addra_i;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire dbiterr;
  wire [35:0]dina;
  wire [42:0]dina_i;
  wire [35:0]doutb;
  wire [35:0]doutb_i;
  wire ena_i;
  wire enb;
  wire [6:0]\gen_decoder_sdp.s6_ecc_decoder_sdp/SYNDROME_REG ;
  wire [11:0]rdaddrecc;
  wire [11:0]rdaddrecc_reg;
  wire sbiterr;
  wire [0:0]wea;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_input_block inblk
       (.ENCOUT(dina_i),
        .clka(clka),
        .dina(dina));
  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_output_block outblk
       (.D(doutb_i),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\gen_decoder_sdp.s6_ecc_decoder_sdp/SYNDROME_REG ),
        .clkb(clkb),
        .dbiterr(dbiterr),
        .doutb(doutb),
        .sbiterr(sbiterr));
  FDRE \softecc_inreg.addra_in_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[0]),
        .Q(addra_i[0]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[10] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[10]),
        .Q(addra_i[10]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[11] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[11]),
        .Q(addra_i[11]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[1] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[1]),
        .Q(addra_i[1]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[2] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[2]),
        .Q(addra_i[2]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[3] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[3]),
        .Q(addra_i[3]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[4] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[4]),
        .Q(addra_i[4]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[5] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[5]),
        .Q(addra_i[5]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[6] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[6]),
        .Q(addra_i[6]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[7] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[7]),
        .Q(addra_i[7]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[8] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[8]),
        .Q(addra_i[8]),
        .R(1'b0));
  FDRE \softecc_inreg.addra_in_reg[9] 
       (.C(clka),
        .CE(1'b1),
        .D(addra[9]),
        .Q(addra_i[9]),
        .R(1'b0));
  FDRE \softecc_inreg.wea_in_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(wea),
        .Q(ena_i),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[0] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[0]),
        .Q(rdaddrecc[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[10] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[10]),
        .Q(rdaddrecc[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[11] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[11]),
        .Q(rdaddrecc[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[1] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[1]),
        .Q(rdaddrecc[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[2] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[2]),
        .Q(rdaddrecc[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[3] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[3]),
        .Q(rdaddrecc[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[4] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[4]),
        .Q(rdaddrecc[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[5] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[5]),
        .Q(rdaddrecc[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[6] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[6]),
        .Q(rdaddrecc[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[7] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[7]),
        .Q(rdaddrecc[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[8] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[8]),
        .Q(rdaddrecc[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \softecc_outreg.rdaddrecc_in_reg[9] 
       (.C(clkb),
        .CE(1'b1),
        .D(rdaddrecc_reg[9]),
        .Q(rdaddrecc[9]),
        .R(1'b0));
  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_generic_cstr \valid.cstr 
       (.D(doutb_i),
        .ENCOUT(dina_i),
        .Q(addra_i),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .ena_i(ena_i),
        .enb(enb),
        .\softecc_outreg.SYNDROME_reg[6] (\gen_decoder_sdp.s6_ecc_decoder_sdp/SYNDROME_REG ),
        .\softecc_outreg.rdaddrecc_in_reg[11] (rdaddrecc_reg));
endmodule

(* C_ADDRA_WIDTH = "12" *) (* C_ADDRB_WIDTH = "12" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "0" *) 
(* C_COUNT_36K_BRAM = "5" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     20.4007 mW" *) 
(* C_FAMILY = "virtex7" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "0" *) 
(* C_HAS_ENB = "1" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "1" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "1" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "1" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "pulsar2_simple_dpram_w36_d4096_v3.mem" *) 
(* C_INIT_FILE_NAME = "no_coe_file_loaded" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "0" *) 
(* C_MEM_TYPE = "1" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "4096" *) (* C_READ_DEPTH_B = "4096" *) (* C_READ_WIDTH_A = "36" *) 
(* C_READ_WIDTH_B = "36" *) (* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) 
(* C_RST_PRIORITY_A = "CE" *) (* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) 
(* C_USE_BRAM_BLOCK = "0" *) (* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) 
(* C_USE_DEFAULT_DATA = "0" *) (* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "1" *) 
(* C_USE_URAM = "0" *) (* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) 
(* C_WRITE_DEPTH_A = "4096" *) (* C_WRITE_DEPTH_B = "4096" *) (* C_WRITE_MODE_A = "READ_FIRST" *) 
(* C_WRITE_MODE_B = "WRITE_FIRST" *) (* C_WRITE_WIDTH_A = "36" *) (* C_WRITE_WIDTH_B = "36" *) 
(* C_XDEVICEFAMILY = "virtex7" *) (* ORIG_REF_NAME = "blk_mem_gen_v8_3_0" *) (* downgradeipidentifiedwarnings = "yes" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [11:0]addra;
  input [35:0]dina;
  output [35:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [11:0]addrb;
  input [35:0]dinb;
  output [35:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [11:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [35:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [35:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [11:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire dbiterr;
  wire [35:0]dina;
  wire [35:0]dinb;
  wire [35:0]doutb;
  wire eccpipece;
  wire ena;
  wire enb;
  wire injectdbiterr;
  wire injectsbiterr;
  wire [11:0]rdaddrecc;
  wire regcea;
  wire regceb;
  wire rsta;
  wire rstb;
  wire s_aclk;
  wire s_aresetn;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire [2:0]s_axi_awsize;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_injectdbiterr;
  wire s_axi_injectsbiterr;
  wire s_axi_rready;
  wire [35:0]s_axi_wdata;
  wire s_axi_wlast;
  wire [0:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire sbiterr;
  wire sleep;
  wire [0:0]wea;
  wire [0:0]web;

  assign douta[35] = \<const0> ;
  assign douta[34] = \<const0> ;
  assign douta[33] = \<const0> ;
  assign douta[32] = \<const0> ;
  assign douta[31] = \<const0> ;
  assign douta[30] = \<const0> ;
  assign douta[29] = \<const0> ;
  assign douta[28] = \<const0> ;
  assign douta[27] = \<const0> ;
  assign douta[26] = \<const0> ;
  assign douta[25] = \<const0> ;
  assign douta[24] = \<const0> ;
  assign douta[23] = \<const0> ;
  assign douta[22] = \<const0> ;
  assign douta[21] = \<const0> ;
  assign douta[20] = \<const0> ;
  assign douta[19] = \<const0> ;
  assign douta[18] = \<const0> ;
  assign douta[17] = \<const0> ;
  assign douta[16] = \<const0> ;
  assign douta[15] = \<const0> ;
  assign douta[14] = \<const0> ;
  assign douta[13] = \<const0> ;
  assign douta[12] = \<const0> ;
  assign douta[11] = \<const0> ;
  assign douta[10] = \<const0> ;
  assign douta[9] = \<const0> ;
  assign douta[8] = \<const0> ;
  assign douta[7] = \<const0> ;
  assign douta[6] = \<const0> ;
  assign douta[5] = \<const0> ;
  assign douta[4] = \<const0> ;
  assign douta[3] = \<const0> ;
  assign douta[2] = \<const0> ;
  assign douta[1] = \<const0> ;
  assign douta[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[3] = \<const0> ;
  assign s_axi_bid[2] = \<const0> ;
  assign s_axi_bid[1] = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[11] = \<const0> ;
  assign s_axi_rdaddrecc[10] = \<const0> ;
  assign s_axi_rdaddrecc[9] = \<const0> ;
  assign s_axi_rdaddrecc[8] = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rdata[35] = \<const0> ;
  assign s_axi_rdata[34] = \<const0> ;
  assign s_axi_rdata[33] = \<const0> ;
  assign s_axi_rdata[32] = \<const0> ;
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[3] = \<const0> ;
  assign s_axi_rid[2] = \<const0> ;
  assign s_axi_rid[1] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign s_axi_wready = \<const0> ;
  GND GND
       (.G(\<const0> ));
  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0_synth inst_blk_mem_gen
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(dbiterr),
        .dina(dina),
        .doutb(doutb),
        .enb(enb),
        .rdaddrecc(rdaddrecc),
        .sbiterr(sbiterr),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_3_0_synth" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_v8_3_0_synth
   (rdaddrecc,
    doutb,
    dbiterr,
    sbiterr,
    dina,
    clka,
    clkb,
    enb,
    addrb,
    wea,
    addra);
  output [11:0]rdaddrecc;
  output [35:0]doutb;
  output dbiterr;
  output sbiterr;
  input [35:0]dina;
  input clka;
  input clkb;
  input enb;
  input [11:0]addrb;
  input [0:0]wea;
  input [11:0]addra;

  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire dbiterr;
  wire [35:0]dina;
  wire [35:0]doutb;
  wire enb;
  wire [11:0]rdaddrecc;
  wire sbiterr;
  wire [0:0]wea;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_top \gnativebmg.native_blk_mem_gen 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(dbiterr),
        .dina(dina),
        .doutb(doutb),
        .enb(enb),
        .rdaddrecc(rdaddrecc),
        .sbiterr(sbiterr),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_input_block" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_input_block
   (ENCOUT,
    dina,
    clka);
  output [42:0]ENCOUT;
  input [35:0]dina;
  input clka;

  wire [42:0]ENCOUT;
  wire clka;
  wire [35:0]dina;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_encoder \s6_softecc.s6_ecc_encoder 
       (.ENCOUT(ENCOUT),
        .clka(clka),
        .dina(dina));
endmodule

(* ORIG_REF_NAME = "blk_mem_output_block" *) 
module pulsar2_simple_dpram_w36_d4096_v3_blk_mem_output_block
   (doutb,
    dbiterr,
    sbiterr,
    D,
    clkb,
    \DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram );
  output [35:0]doutb;
  output dbiterr;
  output sbiterr;
  input [35:0]D;
  input clkb;
  input [6:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;

  wire [35:0]D;
  wire [6:0]\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ;
  wire clkb;
  wire dbiterr;
  wire [35:0]doutb;
  wire sbiterr;

  pulsar2_simple_dpram_w36_d4096_v3_blk_mem_gen_ecc_decoder \gen_decoder_sdp.s6_ecc_decoder_sdp 
       (.D(D),
        .\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram (\DEVICE_7SERIES.NO_BMM_INFO.SDP.SIMPLE_PRIM36.ram ),
        .clkb(clkb),
        .dbiterr(dbiterr),
        .doutb(doutb),
        .sbiterr(sbiterr));
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
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
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
