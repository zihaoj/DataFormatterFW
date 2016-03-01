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
std::string idle_reference_mezz;

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
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA01)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA02)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 2, LA03)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 3, LA04)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 4, LA05)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 5, LA06)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 6, LA07)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 7, LA08)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 8, LA09)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 9, LA10)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(10, LA11)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(11, LA12)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(12, LA13)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(13, LA14)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(14, LA15)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(15, LA16)); // channel in FPGA - channel in FMC
  
  // channels mezzanine FPGA1 -> main FPGA
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA18)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA19)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 2, LA20)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 3, LA21)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 4, LA22)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 5, LA23)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 6, LA24)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 7, LA25)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 8, LA26)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 9, LA27)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(10, LA28)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(11, LA29)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(12, LA30)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(13, LA31)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(14, LA32)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(15, LA33)); // channel in FPGA - channel in FMC
  
  fwdclk_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA00)); // channel in FPGA - channel in FMC
  
  soft_reset_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA17)); // channel in FPGA - channel in FMC  
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
    std::cout<<"NET FPGA0_LVDS_DATA_OUT_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FPGA0_LVDS_DATA_OUT_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga1_bit_mapping[iChan];
    std::cout<<"NET FPGA1_LVDS_DATA_OUT_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FPGA1_LVDS_DATA_OUT_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  
  // FB1_CLK series :
  std::cout<<"NET FPGA0_CLK_N LOC="<<(pins_neg_clk_fmcs[0])[0]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FPGA0_CLK_P LOC="<<(pins_pos_clk_fmcs[0])[0]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FPGA1_CLK_N LOC="<<(pins_neg_clk_fmcs[0])[1]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FPGA1_CLK_P LOC="<<(pins_pos_clk_fmcs[0])[1]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  
  //=====================   MAIN->MEZZ   ========================
  // FB1_CLK series :
  const int fwdclk_bitpos = fwdclk_fmc_to_fpga_bit_mapping[0];
  std::cout<<"NET FWD_CLK_N LOC="<<(pins_neg_la_fmcs[0])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FWD_CLK_P LOC="<<(pins_pos_la_fmcs[0])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  
  std::cout<<"NET SOFT_RESET_IN_N LOC="<<(pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET SOFT_RESET_IN_P LOC="<<(pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS_25;" << std::endl;

  std::cout << std::endl;
  std::cout << std::endl;
  std::cout << std::endl;
  std::cout<<"  constant swap_mask_test_mezzanine_la : std_logic_vector(total_low_pin_count_fmc-1 downto 0) :=\"";
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(swap_mask_la_fmcs[0])[NUM_LA_PAIRS-iChan-1];
  }
  std::cout<<"\";"<<std::endl;
}
