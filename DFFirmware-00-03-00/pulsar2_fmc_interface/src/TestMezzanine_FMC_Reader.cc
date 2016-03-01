// ========================================================
// EDIT void set() according to the schematics & pin assign
// for FMC interface
// ========================================================

#include <fstream>
#include <sstream>
#include <string>
#include <iostream>

#include <vector>
#include <map>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

enum FMC_CHANNEL_ID {LA00=0, LA01, LA02, LA03, LA04, LA05, LA06, LA07, LA08, LA09,
		     LA10,   LA11, LA12, LA13, LA14, LA15, LA16, LA17, LA18, LA19,
		     LA20,   LA21, LA22, LA23, LA24, LA25, LA26, LA27, LA28, LA29,
		     LA30,   LA31, LA32, LA33};

// ON FMC connector
std::map<int, FMC_CHANNEL_ID> rx_fmc_to_fpga0_bit_mapping;
std::map<int, FMC_CHANNEL_ID> rx_fmc_to_fpga1_bit_mapping;
std::map<int, FMC_CHANNEL_ID> tx_fmc_to_fpga0_bit_mapping;
std::map<int, FMC_CHANNEL_ID> tx_fmc_to_fpga1_bit_mapping;
std::map<int, FMC_CHANNEL_ID> fwdclk_fmc_to_fpga_bit_mapping;
std::map<int, FMC_CHANNEL_ID> soft_reset_fmc_to_fpga_bit_mapping;

// data format after DDR encord at receiver side for each FPGA
int rx_ctrl_space;
int rx_ctrl_parity;
std::map<int, int> rx_sctword;
std::map<int, int> rx_pixword;

// data format inside of each word
std::map<int, int> rx_dataword;
std::map<int, int> rx_ctrlword;

std::string ctrl_invalid_word;
std::string ctrl_first_byte_of_data;
std::string ctrl_another_byte_of_data;
std::string ctrl_first_byte_of_ctrl;
std::string ctrl_another_byte_of_ctrl;
std::string ctrl_idleword;
std::string data_idleword;

int bitpos_in_txline_spy_freeze;
int bitpos_in_txline_sct_hold;
int bitpos_in_txline_pix_hold;
int bitpos_in_txline_user_signal0;
int bitpos_in_txline_user_signal1;
int bitpos_in_txline_user_signal2;

// storage for info extracted data from file
const int NUM_LA_PAIRS  = 34;
const int NUM_CLK_PAIRS = 2;
  
std::vector<std::string> swap_mask_la_fmc1(NUM_LA_PAIRS);
std::vector<std::string> swap_mask_la_fmc2(NUM_LA_PAIRS);
std::vector<std::string> swap_mask_la_fmcs[2] = {swap_mask_la_fmc1, swap_mask_la_fmc2};
  
std::vector<std::string> swap_mask_clk_fmc1(NUM_CLK_PAIRS);
std::vector<std::string> swap_mask_clk_fmc2(NUM_CLK_PAIRS);
std::vector<std::string> swap_mask_clk_fmcs[2] = {swap_mask_clk_fmc1, swap_mask_clk_fmc2};
//================================================================

std::vector<std::string> pins_pos_la_fmc1(NUM_LA_PAIRS);
std::vector<std::string> pins_pos_la_fmc2(NUM_LA_PAIRS);
std::vector<std::string> pins_pos_la_fmcs[2] = {pins_pos_la_fmc1, pins_pos_la_fmc2};
  
std::vector<std::string> pins_pos_clk_fmc1(NUM_CLK_PAIRS);
std::vector<std::string> pins_pos_clk_fmc2(NUM_CLK_PAIRS);
std::vector<std::string> pins_pos_clk_fmcs[2] = {pins_pos_clk_fmc1, pins_pos_clk_fmc2};
//================================================================

std::vector<std::string> pins_neg_la_fmc1(NUM_LA_PAIRS);
std::vector<std::string> pins_neg_la_fmc2(NUM_LA_PAIRS);
std::vector<std::string> pins_neg_la_fmcs[2] = {pins_neg_la_fmc1, pins_neg_la_fmc2};
  
std::vector<std::string> pins_neg_clk_fmc1(NUM_CLK_PAIRS);
std::vector<std::string> pins_neg_clk_fmc2(NUM_CLK_PAIRS);
std::vector<std::string> pins_neg_clk_fmcs[2] = {pins_neg_clk_fmc1, pins_neg_clk_fmc2};
//================================================================
  
std::vector<std::string> bankid_la_fmc1(NUM_LA_PAIRS);
std::vector<std::string> bankid_la_fmc2(NUM_LA_PAIRS);
std::vector<std::string> bankid_la_fmcs[2] = {bankid_la_fmc1, bankid_la_fmc2};
  
std::vector<std::string> bankid_clk_fmc1(NUM_CLK_PAIRS);
std::vector<std::string> bankid_clk_fmc2(NUM_CLK_PAIRS);
std::vector<std::string> bankid_clk_fmcs[2] = {bankid_clk_fmc1, bankid_clk_fmc2};
//================================================================

void dump_ucf();

void set()
{
  // -------------------------------------------------
  // -- 8 bits SCT data / 5 bits SCT data
  // -- 8 bits PIX data / 5 bits PIX data
  // -- 2 bits for parity & spare
  // -- ========
  // -- RX 28 bits / FPGA ==> 14 lvds pairs
  // -- 
  // -- CTRL TX 4 bits / FPGA ==> 2 lvds pairs
  // -- CLOCK forwarding TX 1 pair
  // -------------------------------------------------
  // -- 
  // -- 28 pairs for RX from one FMC
  // --  4 pairs for TX to one FMC
  // --  2 pairs for clock fowarding to one FMC
  // -------------------------------------------------

  // configuration from the schematics of IM
  // channels mezzanine FPGA0 -> main FPGA
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA07)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA08)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 2, LA09)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 3, LA11)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 4, LA12)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 5, LA13)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 6, LA14)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 7, LA15)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 8, LA02)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 9, LA03)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(10, LA06)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(11, LA10)); // channel in FPGA - channel in FMC
  
  // channels mezzanine FPGA1 -> main FPGA
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA29)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA25)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 2, LA22)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 3, LA33)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 4, LA26)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 5, LA24)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 6, LA28)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 7, LA31)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 8, LA19)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 9, LA21)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(10, LA27)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(11, LA30)); // channel in FPGA - channel in FMC
  
  // tx
  tx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA05)); // channel in FPGA - channel in FMC
  tx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA00)); // channel in FPGA - channel in FMC
  tx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 2, LA16)); // channel in FPGA - channel in FMC
  
  // tx
  tx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA20)); // channel in FPGA - channel in FMC
  tx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA18)); // channel in FPGA - channel in FMC
  tx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 2, LA32)); // channel in FPGA - channel in FMC
  
  // clock 
  fwdclk_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA01)); // channel in FPGA - channel in FMC
  
  // RESET
  soft_reset_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA04)); // (RESET0) channel in FPGA - channel in FMC
  soft_reset_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA23)); // (RESET1) channel in FPGA - channel in FMC
  
  //=========================================================================================
  rx_ctrl_space  = 11; // channel in RX_DDR2-ENCODED data
  rx_ctrl_parity = 23; // channel in RX_DDR2-ENCODED data
  rx_sctword.insert(std::pair<int, int>( 0,  0)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 1,  1)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 2,  2)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 3,  3)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 4,  4)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 5,  5)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 6,  6)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 7,  7)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 8,  8)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>( 9,  9)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_sctword.insert(std::pair<int, int>(10, 10)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  
  rx_pixword.insert(std::pair<int, int>( 0, 12)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 1, 13)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 2, 14)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 3, 15)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 4, 16)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 5, 17)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 6, 18)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 7, 19)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 8, 20)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>( 9, 21)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_pixword.insert(std::pair<int, int>(10, 22)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  
  //=========================================================================================
  rx_dataword.insert(std::pair<int, int>( 0,  0)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_dataword.insert(std::pair<int, int>( 1,  1)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_dataword.insert(std::pair<int, int>( 2,  2)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_dataword.insert(std::pair<int, int>( 3,  3)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_dataword.insert(std::pair<int, int>( 4,  4)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_dataword.insert(std::pair<int, int>( 5,  5)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_dataword.insert(std::pair<int, int>( 6,  6)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  rx_dataword.insert(std::pair<int, int>( 7,  7)); // bitpos in word - bitpos in RX_DDR2-ENDODED data total
  
  rx_ctrlword.insert(std::pair<int, int>( 0,  8)); // bitpos in word - bitpos in RX_DDR2-ENDODED ctrl total
  rx_ctrlword.insert(std::pair<int, int>( 1,  9)); // bitpos in word - bitpos in RX_DDR2-ENDODED ctrl total
  rx_ctrlword.insert(std::pair<int, int>( 2, 10)); // bitpos in word - bitpos in RX_DDR2-ENDODED ctrl total
}

//=========================================================================================
int main()
{
  std::ifstream input("TestMezzanine_FMC.csv");
  
  set();
  
  char line[BUFSIZ];
  
  int bank, fmc, chan;
  char fmcHL[BUFSIZ];
  char upperChPN[BUFSIZ];
  char PINLOC1[BUFSIZ];
  char PINLOC2[BUFSIZ];
  char swap[BUFSIZ];
  char bankid[BUFSIZ];
  
  while (not (input.eof())) {
    input.getline(line, sizeof(line));
    
    if (strcmp(line, "")==0) continue;
    if (sscanf(line,"%d %d %s %d %s %s %s %s %s",
	       &bank, &fmc, fmcHL, &chan, upperChPN, PINLOC1, PINLOC2, swap, bankid) != 9) {
      std::cout << "check the file format. \",\" should be replaced by \" \"."  << std::endl;
    }
    
    std::string fmcHL_str(fmcHL);
    if (fmcHL_str == "H") continue;
    
    const int         fmc_id     = fmc-1; 
    const std::string swap_mask  = (swap);
    const std::string bankid_str = (bankid);
    
    if (fmcHL_str == "CLK") {
      (swap_mask_clk_fmcs[fmc_id])[chan] = swap_mask;
      (pins_neg_clk_fmcs[fmc_id])[chan]  = PINLOC1; // pulsar 2a - 1st=neg, pulsar 2b - 1st=pos
      (pins_pos_clk_fmcs[fmc_id])[chan]  = PINLOC2; // pulsar 2a - 2nd=pos, pulsar 2b - 1st=neg
      (bankid_clk_fmcs[fmc_id])[chan]    = bankid_str;      
    } else {
      (swap_mask_la_fmcs[fmc_id])[chan] = swap_mask;
      (pins_neg_la_fmcs[fmc_id])[chan]  = PINLOC1; // pulsar 2a - 1st=neg, pulsar 2b - 1st=pos
      (pins_pos_la_fmcs[fmc_id])[chan]  = PINLOC2; // pulsar 2a - 2nd=pos, pulsar 2b - 1st=neg
      (bankid_la_fmcs[fmc_id])[chan]    = bankid_str;
    }
  }
  
  dump_ucf();
}

void dump_ucf()
{
  int total_rx_pairs_for_each_fmc = rx_fmc_to_fpga0_bit_mapping.size() + rx_fmc_to_fpga1_bit_mapping.size();
  
  //=====================   MEZZ->MAIN   ========================
  for (int iChan=0; iChan<rx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[pair_id] << " [get_ports FPGA0_LVDS_DATA_OUT_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[pair_id] << " [get_ports FPGA0_LVDS_DATA_OUT_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA0_LVDS_DATA_OUT_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA0_LVDS_DATA_OUT_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FPGA0_LVDS_DATA_OUT_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    //std::cout<<"NET FPGA0_LVDS_DATA_OUT_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga1_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[pair_id] << " [get_ports FPGA1_LVDS_DATA_OUT_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[pair_id] << " [get_ports FPGA1_LVDS_DATA_OUT_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA1_LVDS_DATA_OUT_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA1_LVDS_DATA_OUT_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FPGA1_LVDS_DATA_OUT_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    //std::cout<<"NET FPGA1_LVDS_DATA_OUT_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  
  // FB1_CLK series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[0])[0] << " [get_ports FPGA0_CLK_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[0])[0] << " [get_ports FPGA0_CLK_N]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[0])[1] << " [get_ports FPGA1_CLK_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[0])[1] << " [get_ports FPGA1_CLK_N]" << std::endl;
  
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA0_CLK_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA0_CLK_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA1_CLK_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA1_CLK_N]" << std::endl;
  //std::cout<<"NET FPGA0_CLK_N LOC="<<(pins_neg_clk_fmcs[0])[0]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  //std::cout<<"NET FPGA0_CLK_P LOC="<<(pins_pos_clk_fmcs[0])[0]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  //std::cout<<"NET FPGA1_CLK_N LOC="<<(pins_neg_clk_fmcs[0])[1]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  //std::cout<<"NET FPGA1_CLK_P LOC="<<(pins_pos_clk_fmcs[0])[1]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  
  //=====================   MAIN->MEZZ   ========================
  for (int iChan=0; iChan<tx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[pair_id] << " [get_ports FPGA0_LVDS_DATA_IN_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[pair_id] << " [get_ports FPGA0_LVDS_DATA_IN_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA0_LVDS_DATA_IN_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA0_LVDS_DATA_IN_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FPGA0_LVDS_DATA_IN_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    //std::cout<<"NET FPGA0_LVDS_DATA_IN_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  for (int iChan=0; iChan<tx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga1_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[pair_id] << " [get_ports FPGA1_LVDS_DATA_IN_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[pair_id] << " [get_ports FPGA1_LVDS_DATA_IN_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA1_LVDS_DATA_IN_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS_25 [get_ports FPGA1_LVDS_DATA_IN_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FPGA1_LVDS_DATA_IN_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    //std::cout<<"NET FPGA1_LVDS_DATA_IN_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  
  // FB1_CLK series :
  const int fwdclk_bitpos = fwdclk_fmc_to_fpga_bit_mapping[0];
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[fwdclk_bitpos] << " [get_ports FWD_CLK_N ]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[fwdclk_bitpos] << " [get_ports FWD_CLK_P ]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports get_ports FWD_CLK_N ]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports get_ports FWD_CLK_P ]" << std::endl;
  //std::cout<<"NET FWD_CLK_N LOC="<<(pins_neg_la_fmcs[0])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  //std::cout<<"NET FWD_CLK_P LOC="<<(pins_pos_la_fmcs[0])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports SOFT_RESET0_IN_N ]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports SOFT_RESET0_IN_P ]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports SOFT_RESET1_IN_N ]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports SOFT_RESET1_IN_P ]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports SOFT_RESET0_IN_N ]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports SOFT_RESET0_IN_P ]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports SOFT_RESET1_IN_N ]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS_25 [get_ports SOFT_RESET1_IN_P ]" << std::endl;
  //std::cout<<"NET SOFT_RESET0_IN_N LOC="<<(pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  //std::cout<<"NET SOFT_RESET0_IN_P LOC="<<(pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  //std::cout<<"NET SOFT_RESET1_IN_N LOC="<<(pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  //std::cout<<"NET SOFT_RESET1_IN_P LOC="<<(pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS_25;" << std::endl;

  std::cout << std::endl;
  std::cout << std::endl;
  std::cout << std::endl;
  std::cout<<"  constant swap_mask_test_mezzanine_la : std_logic_vector(total_low_pin_count_fmc-1 downto 0) :=\"";
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(swap_mask_la_fmcs[0])[NUM_LA_PAIRS-iChan-1];
  }
  std::cout<<"\";"<<std::endl;
}
