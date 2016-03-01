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
int rx_ctrl_parity_pix;
int rx_ctrl_parity_sct;
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

// storage for info extracted data from file
const int NUM_LA_PAIRS  = 34;
const int NUM_CLK_PAIRS = 2;
  
std::vector<std::string> swap_mask_la_fmc1(NUM_LA_PAIRS);
std::vector<std::string> swap_mask_la_fmc2(NUM_LA_PAIRS);
std::vector<std::string> swap_mask_la_fmc3(NUM_LA_PAIRS);
std::vector<std::string> swap_mask_la_fmc4(NUM_LA_PAIRS);
std::vector<std::string> swap_mask_la_fmcs[4] = {swap_mask_la_fmc1, swap_mask_la_fmc2, swap_mask_la_fmc3, swap_mask_la_fmc4};
  
std::vector<std::string> swap_mask_clk_fmc1(NUM_CLK_PAIRS);
std::vector<std::string> swap_mask_clk_fmc2(NUM_CLK_PAIRS);
std::vector<std::string> swap_mask_clk_fmc3(NUM_CLK_PAIRS);
std::vector<std::string> swap_mask_clk_fmc4(NUM_CLK_PAIRS);
std::vector<std::string> swap_mask_clk_fmcs[4] = {swap_mask_clk_fmc1, swap_mask_clk_fmc2, swap_mask_clk_fmc3, swap_mask_clk_fmc4};
//================================================================

std::vector<std::string> pins_pos_la_fmc1(NUM_LA_PAIRS);
std::vector<std::string> pins_pos_la_fmc2(NUM_LA_PAIRS);
std::vector<std::string> pins_pos_la_fmc3(NUM_LA_PAIRS);
std::vector<std::string> pins_pos_la_fmc4(NUM_LA_PAIRS);
std::vector<std::string> pins_pos_la_fmcs[4] = {pins_pos_la_fmc1, pins_pos_la_fmc2, pins_pos_la_fmc3, pins_pos_la_fmc4};
  
std::vector<std::string> pins_pos_clk_fmc1(NUM_CLK_PAIRS);
std::vector<std::string> pins_pos_clk_fmc2(NUM_CLK_PAIRS);
std::vector<std::string> pins_pos_clk_fmc3(NUM_CLK_PAIRS);
std::vector<std::string> pins_pos_clk_fmc4(NUM_CLK_PAIRS);
std::vector<std::string> pins_pos_clk_fmcs[4] = {pins_pos_clk_fmc1, pins_pos_clk_fmc2, pins_pos_clk_fmc3, pins_pos_clk_fmc4};
//================================================================
  
std::vector<std::string> pins_neg_la_fmc1(NUM_LA_PAIRS);
std::vector<std::string> pins_neg_la_fmc2(NUM_LA_PAIRS);
std::vector<std::string> pins_neg_la_fmc3(NUM_LA_PAIRS);
std::vector<std::string> pins_neg_la_fmc4(NUM_LA_PAIRS);
std::vector<std::string> pins_neg_la_fmcs[4] = {pins_neg_la_fmc1, pins_neg_la_fmc2, pins_neg_la_fmc3, pins_neg_la_fmc4};
  
std::vector<std::string> pins_neg_clk_fmc1(NUM_CLK_PAIRS);
std::vector<std::string> pins_neg_clk_fmc2(NUM_CLK_PAIRS);
std::vector<std::string> pins_neg_clk_fmc3(NUM_CLK_PAIRS);
std::vector<std::string> pins_neg_clk_fmc4(NUM_CLK_PAIRS);
std::vector<std::string> pins_neg_clk_fmcs[4] = {pins_neg_clk_fmc1, pins_neg_clk_fmc2, pins_neg_clk_fmc3, pins_neg_clk_fmc4};
//================================================================
  
std::vector<std::string> bankid_la_fmc1(NUM_LA_PAIRS);
std::vector<std::string> bankid_la_fmc2(NUM_LA_PAIRS);
std::vector<std::string> bankid_la_fmc3(NUM_LA_PAIRS);
std::vector<std::string> bankid_la_fmc4(NUM_LA_PAIRS);
std::vector<std::string> bankid_la_fmcs[4] = {bankid_la_fmc1, bankid_la_fmc2, bankid_la_fmc3, bankid_la_fmc4};
  
std::vector<std::string> bankid_clk_fmc1(NUM_CLK_PAIRS);
std::vector<std::string> bankid_clk_fmc2(NUM_CLK_PAIRS);
std::vector<std::string> bankid_clk_fmc3(NUM_CLK_PAIRS);
std::vector<std::string> bankid_clk_fmc4(NUM_CLK_PAIRS);
std::vector<std::string> bankid_clk_fmcs[4] = {bankid_clk_fmc1, bankid_clk_fmc2, bankid_clk_fmc3, bankid_clk_fmc4};
//================================================================

void dump_lib();
void dump_ucf();

void set(bool DO_SPECIAL_CONFIGURATION_FOR_IM_TEST)
{
  // -------------------------------------------------
  // -- 8 bits SCT data / 3 bits SCT ctrl
  // -- 8 bits PIX data / 3 bits PIX ctrl
  // -- 2 bits for parity (pix / sct)
  // -- ========
  // -- RX 24 bits / FPGA ==> 12 lvds pairs
  // -- 
  // -- CTRL TX 3 bits / FPGA ==> 3 lvds pairs (SDR)
  // -- CLOCK forwarding TX 1 pair
  // -- RESET 2 bits (eventually 1 bit + 1 trigger)
  // -------------------------------------------------
  // -- 
  // -- 24 pairs for RX from one FMC
  // --  6 pairs for TX to one FMC
  // --  2 pairs for clock fowarding to one FMC
  // --  2 pairs for Reset signals
  // -------------------------------------------------
  
  //=========================================================================================
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
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 8, LA30)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 9, LA27)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(10, LA21)); // channel in FPGA - channel in FMC
  rx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>(11, LA19)); // channel in FPGA - channel in FMC
  
  // tx
  tx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA05)); // channel in FPGA - channel in FMC
  tx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA00)); // channel in FPGA - channel in FMC
  tx_fmc_to_fpga0_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 2, LA16)); // channel in FPGA - channel in FMC
  
  // tx
  tx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA20)); // channel in FPGA - channel in FMC
  tx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA18)); // channel in FPGA - channel in FMC
  tx_fmc_to_fpga1_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 2, LA32)); // channel in FPGA - channel in FMC
  
  // clock
  if (not DO_SPECIAL_CONFIGURATION_FOR_IM_TEST) {
    fwdclk_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA01)); // channel in FPGA - channel in FMC // For FNAL Test mezzanine
  } else {
    fwdclk_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA17)); // channel in FPGA - channel in FMC // For FTK IM
  }
  
  // RESET
  soft_reset_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 0, LA04)); // (RESET0) channel in FPGA - channel in FMC
  soft_reset_fmc_to_fpga_bit_mapping.insert(std::pair<int, FMC_CHANNEL_ID>( 1, LA23)); // (RESET1) channel in FPGA - channel in FMC
  
  //=========================================================================================
  rx_ctrl_parity_sct = 11; // channel in RX_DDR2-ENCODED data
  rx_ctrl_parity_pix = 23; // channel in RX_DDR2-ENCODED data
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
  
  // 3-bit control
  //  CTRL[2]=FIRST CTRL[1]=DV, CTRL[0]=CTRL, ,
  ctrl_invalid_word="\"000\"";
  ctrl_first_byte_of_data="\"110\"";
  ctrl_another_byte_of_data="\"010\"";
  ctrl_first_byte_of_ctrl="\"111\"";
  ctrl_another_byte_of_ctrl="\"011\"";
  ctrl_idleword="\"101\"";
  data_idleword="\"01010101\"";
  bitpos_in_txline_spy_freeze   = 0;
  bitpos_in_txline_sct_hold     = 1;
  bitpos_in_txline_pix_hold     = 2;
}

//=========================================================================================
int main(int argc, char* argv[])
{
  std::ifstream input("PulsarIIb_FMC.csv");
  
  bool DO_SPECIAL_CONFIGURATION_FOR_IM_TEST = false;

  if (argc!=2) {
    std::cout << "usage ./iib.exe <1:FTK_IM or 0:FNAL_TM> " << std::endl;
    exit(EXIT_FAILURE);
  } else if (std::string(argv[1])=="0") { // FNAL_TM
    DO_SPECIAL_CONFIGURATION_FOR_IM_TEST = false;
  } else if (std::string(argv[1])=="1") { // FTK_IM
    DO_SPECIAL_CONFIGURATION_FOR_IM_TEST = true;
  } else {
    std::cout << "usage ./iia.exe <1:FTK_IM or 0:FNAL_TM> # Note : the argument should be either of \"1\" or \"0\"." << std::endl;
    exit(EXIT_FAILURE);
  }
  
  set(DO_SPECIAL_CONFIGURATION_FOR_IM_TEST);

  
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
      (pins_pos_clk_fmcs[fmc_id])[chan]  = PINLOC1; // pulsar 2a - 1st=neg, pulsar 2b - 1st=pos
      (pins_neg_clk_fmcs[fmc_id])[chan]  = PINLOC2; // pulsar 2a - 2nd=pos, pulsar 2b - 1st=neg
      (bankid_clk_fmcs[fmc_id])[chan]    = bankid_str;      
    } else {
      (swap_mask_la_fmcs[fmc_id])[chan] = swap_mask;
      (pins_pos_la_fmcs[fmc_id])[chan]  = PINLOC1; // pulsar 2a - 1st=neg, pulsar 2b - 1st=pos
      (pins_neg_la_fmcs[fmc_id])[chan]  = PINLOC2; // pulsar 2a - 2nd=pos, pulsar 2b - 1st=neg
      (bankid_la_fmcs[fmc_id])[chan]    = bankid_str;
    }
  }
  
  dump_lib();
  std::cout << std::endl;
  std::cout << std::endl;
  std::cout << std::endl;
  std::cout << std::endl;
  std::cout << "## UCF output" << std::endl;
  dump_ucf();

}

void dump_lib()
{
  std::cout<<"  -- number of lvds pairs between main FPGA and Mezzanine Cards"<<std::endl;
  std::cout<<"  constant lvds_pairs_for_rx_in_each_fpga : integer := "<< rx_fmc_to_fpga1_bit_mapping.size()<<";"<<std::endl;
  std::cout<<"  constant lvds_pairs_for_rx_in_each_mezzanine : integer :="<< 2*rx_fmc_to_fpga1_bit_mapping.size()<<";"<< std::endl;
  std::cout<<"  constant total_low_pin_count_fmc : integer := "<<NUM_LA_PAIRS<<";"<< std::endl;
  std::cout<<"  constant num_fpga_per_fmc  : integer := 2;"<<std::endl;
  std::cout<<"  constant num_fmc_per_board : integer := 4;"<<std::endl;
  std::cout<<"  constant num_fpga_on_board : integer := num_fpga_per_fmc*num_fmc_per_board;"<<std::endl;
  std::cout<<"  constant num_fmc_per_mainfpga : integer := 4;"<<std::endl;  // 2 for pulsar2a, 4 for pulsar2b
  std::cout<<"  constant num_fpga_for_each_mainfpga : integer := num_fpga_per_fmc*num_fmc_per_mainfpga;"<<std::endl;
  std::cout<<"  constant width_of_decoded_word : integer := 32; -- DATA FORMAT DETERMINATION"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  constant lvds_pairs_for_tx_in_each_fpga : integer := "<<tx_fmc_to_fpga0_bit_mapping.size()<<"; "<<std::endl;
  std::cout<<"  constant lvds_pairs_for_tx_in_each_mezzanine : integer :=lvds_pairs_for_tx_in_each_fpga*num_fpga_per_fmc;"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- per clock means,"<<std::endl;
  std::cout<<"  -- sent data during one clock cycle"<<std::endl;
  std::cout<<"  constant data_width_in_each_clockcycle : integer :="<<rx_dataword.size()<<";"<<std::endl;
  std::cout<<"  constant ctrl_width_in_each_clockcycle : integer :="<<rx_ctrlword.size()<<"; -- to be 2"<<std::endl;
  std::cout<<"  constant word_width_in_each_clockcycle : integer := data_width_in_each_clockcycle + ctrl_width_in_each_clockcycle;"<<std::endl;
  // 8bit TX bit position
  std::cout<<"  constant bitpos_in_txline_spy_freeze   : integer := " << bitpos_in_txline_spy_freeze << ";"<<std::endl;
  std::cout<<"  constant bitpos_in_txline_sct_hold     : integer := " << bitpos_in_txline_sct_hold << ";"<<std::endl;
  std::cout<<"  constant bitpos_in_txline_pix_hold     : integer := " << bitpos_in_txline_pix_hold << ";"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  type lvds_pairs_for_each_fpga_t is array (0 to num_fpga_for_each_mainfpga-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);"<<std::endl;
  std::cout<<"  type lvds_pairs_for_each_fmc_t is array (0 to num_fmc_per_board-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);"<<std::endl;
  std::cout<<"  type rx_fmc_to_fpga_bit_mapping_array_t is array (0 to lvds_pairs_for_rx_in_each_fpga-1)"<<std::endl;
  std::cout<<"    of integer range 0 to total_low_pin_count_fmc-1;"<<std::endl;
  std::cout<<"  type data_type_for_imfpga_output_lanes_t is array (0 to num_fpga_for_each_mainfpga-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(width_of_decoded_word-1 downto 0);"<<std::endl;
  std::cout<<"  type data_type_for_imfpga_input_lanes_t  is array (0 to num_fpga_for_each_mainfpga-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);"<<std::endl;
  std::cout<<"  type data_type_for_imfpga_output_lanes_tx_t  is array (0 to num_fpga_for_each_mainfpga-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0);"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  type data_type_for_fullwidth_data_from_imfpga_t  is array (0 to num_fpga_for_each_mainfpga-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  type tx_fmc_to_fpga_bit_mapping_array_t is array (0 to lvds_pairs_for_tx_in_each_fpga-1)"<<std::endl;
  std::cout<<"    of integer range 0 to total_low_pin_count_fmc-1;"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> From this line :: FROM FTK IM Schematics in LA pin count (0 - 33)"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  constant rx_fmc_to_fpga0_bit_mapping_in_all_FMC_LA_pin_count : rx_fmc_to_fpga_bit_mapping_array_t"<<std::endl;
  //  := (  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14);
  std::cout<<"    := (";
  for (int iChan=0; iChan<rx_fmc_to_fpga0_bit_mapping.size(); iChan++) {
    std::cout<<rx_fmc_to_fpga0_bit_mapping[iChan];
    if (iChan!=rx_fmc_to_fpga0_bit_mapping.size()-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant rx_fmc_to_fpga1_bit_mapping_in_all_FMC_LA_pin_count : rx_fmc_to_fpga_bit_mapping_array_t"<<std::endl;
  //  := ( 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30);
  std::cout<<"    := (";
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) {
    std::cout<<rx_fmc_to_fpga1_bit_mapping[iChan];
    if (iChan!=rx_fmc_to_fpga1_bit_mapping.size()-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant tx_fmc_to_fpga0_bit_mapping_in_all_FMC_LA_pin_count : tx_fmc_to_fpga_bit_mapping_array_t"<<std::endl;
  //  := ( 15, 16);
  std::cout<<"    := (";
  for (int iChan=0; iChan<tx_fmc_to_fpga0_bit_mapping.size(); iChan++) {
    std::cout<<tx_fmc_to_fpga0_bit_mapping[iChan];
    if (iChan!=tx_fmc_to_fpga0_bit_mapping.size()-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant tx_fmc_to_fpga1_bit_mapping_in_all_FMC_LA_pin_count : tx_fmc_to_fpga_bit_mapping_array_t"<<std::endl;
  //  := ( 31, 32);
  std::cout<<"    := (";
  for (int iChan=0; iChan<tx_fmc_to_fpga1_bit_mapping.size(); iChan++) {
    std::cout<<tx_fmc_to_fpga1_bit_mapping[iChan];
    if (iChan!=tx_fmc_to_fpga1_bit_mapping.size()-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant tx_clock_forward_bit_position_in_all_FMC_LA_pin_count : integer := "<<
    fwdclk_fmc_to_fpga_bit_mapping[0]<<";"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> Until this line :: FROM FTK IM Schematics in LA pin count (0 - 33)"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> From this line :: FROM FTK IM Schematics"<<std::endl;
  std::cout<<"  -- NEEDED to encode the data to match the interface format (to divide the"<<std::endl;
  std::cout<<"  -- data into FPGA units)"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  constant rx_fmc_to_fpga0_bit_mapping : rx_fmc_to_fpga_bit_mapping_array_t"<<std::endl;
  //  := (  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13);
  //  ** RULE for logical pin assignment for RX (FBX_LVDS_RX_P/N) **
  //  ** Lower half bits : FPGA0  **
  //  ** Lower half bits : FPGA1  **
  int channel_id_rx = 0;
  std::cout<<"    := (";
  for (; channel_id_rx<rx_fmc_to_fpga0_bit_mapping.size(); channel_id_rx++) {
    std::cout<<channel_id_rx;
    if (channel_id_rx!=rx_fmc_to_fpga0_bit_mapping.size()-1)std::cout<<", ";    
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant rx_fmc_to_fpga1_bit_mapping : rx_fmc_to_fpga_bit_mapping_array_t"<<std::endl;
  //  := ( 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27);
  std::cout<<"    := (";
  for (; channel_id_rx<2*rx_fmc_to_fpga1_bit_mapping.size(); channel_id_rx++) {
    std::cout<<channel_id_rx;
    if (channel_id_rx!=2*rx_fmc_to_fpga1_bit_mapping.size()-1)std::cout<<", ";    
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant tx_fmc_to_fpga0_bit_mapping : tx_fmc_to_fpga_bit_mapping_array_t"<<std::endl;
  //  := (  0,  1);
  //  ** RULE for logical pin assignment for TX  (FBX_LVDS_TX_P/N) **
  //  ** Lower half bits : FPGA0  **
  //  ** Lower half bits : FPGA1  **
  int channel_id_tx = 0;
  std::cout<<"    := (";
  for (; channel_id_tx<tx_fmc_to_fpga0_bit_mapping.size(); channel_id_tx++) {
    std::cout<<channel_id_tx;
    if (channel_id_tx!=tx_fmc_to_fpga0_bit_mapping.size()-1)std::cout<<", ";    
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant tx_fmc_to_fpga1_bit_mapping : tx_fmc_to_fpga_bit_mapping_array_t"<<std::endl;
  //  := (  2,  3);
  std::cout<<"    := (";
  for (; channel_id_tx<tx_fmc_to_fpga0_bit_mapping.size()+tx_fmc_to_fpga1_bit_mapping.size(); channel_id_tx++) {
    std::cout<<channel_id_tx;
    if (channel_id_tx!=tx_fmc_to_fpga0_bit_mapping.size()+tx_fmc_to_fpga1_bit_mapping.size()-1)std::cout<<", ";    
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> Until this line :: FROM FTK IM Schematics"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<std::endl;
  std::cout<<std::endl;
  std::cout<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  type fpga_to_data_bit_mapping_array_t is array (0 to data_width_in_each_clockcycle-1) of integer range 0 to 2*lvds_pairs_for_rx_in_each_fpga-1;"<<std::endl;
  std::cout<<"  type fpga_to_ctrl_bit_mapping_array_t is array (0 to ctrl_width_in_each_clockcycle-1) of integer range 0 to 2*lvds_pairs_for_rx_in_each_fpga-1;"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> From this line :: FROM Bit assignment in FPGA logic NOTE"<<std::endl;
  std::cout<<"  -- total number of bit should be equarl to or less than 2*lvds_pairs_for_rx_in_each_fpga"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  constant detword_to_data_bit_mapping : fpga_to_data_bit_mapping_array_t := ("; //0,  1,  2,  3,  4,  5,  6, 7);
  for (int iChan=0; iChan<rx_dataword.size(); iChan++) {
    std::cout<<rx_dataword[iChan];
    if (iChan!=rx_dataword.size()-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant detword_to_ctrl_bit_mapping : fpga_to_ctrl_bit_mapping_array_t := ("; //8,  9, 10, 11, 12);
  for (int iChan=0; iChan<rx_ctrlword.size(); iChan++) {
    std::cout<<rx_ctrlword[iChan];
    if (iChan!=rx_ctrlword.size()-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> Until this line :: FROM Bit assignment in FPGA logic"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ###############################################################################################"<<std::endl;
  std::cout<<"  type fpga_to_det_mapping_array_t is array (0 to word_width_in_each_clockcycle-1) of integer range 0 to 2*lvds_pairs_for_rx_in_each_fpga-1;"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> From this line :: FTKIM-DF pin assignment"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  constant fpga_to_sctword_bit_mapping : fpga_to_det_mapping_array_t := ("; // 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12);
  for (int iChan=0; iChan<rx_sctword.size(); iChan++) {
    std::cout<<rx_sctword[iChan];
    if (iChan!=rx_sctword.size()-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant fpga_to_pixword_bit_mapping : fpga_to_det_mapping_array_t := ("; //14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26);
  for (int iChan=0; iChan<rx_pixword.size(); iChan++) {
    std::cout<<rx_pixword[iChan];
    if (iChan!=rx_pixword.size()-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  constant fpga_to_parity_sct_bit_mapping : integer :="<<rx_ctrl_parity_sct<<";"<<std::endl;
  std::cout<<"  constant fpga_to_parity_pix_bit_mapping : integer :="<<rx_ctrl_parity_pix<<";"<<std::endl;
  std::cout<<"  constant fpga_to_soft_reset0_bit_mapping : integer :="<<soft_reset_fmc_to_fpga_bit_mapping[0]<<";"<<std::endl;
  std::cout<<"  constant fpga_to_soft_reset1_bit_mapping : integer :="<<soft_reset_fmc_to_fpga_bit_mapping[1]<<";"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> From this line :: FTKIM-DF pin assignment"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> From this line :: FROM IM - DF bit assignment"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  constant ctrl_invalid_word         : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0) := "
	   <<ctrl_invalid_word<<";"<<std::endl;
  std::cout<<"  constant ctrl_first_byte_of_data   : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0) := "
	   <<ctrl_first_byte_of_data<<";"<<std::endl;
  std::cout<<"  constant ctrl_another_byte_of_data : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0) := "
	   <<ctrl_another_byte_of_data<<";"<<std::endl;
  std::cout<<"  constant ctrl_first_byte_of_ctrl   : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0) := "
	   <<ctrl_first_byte_of_ctrl<<";"<<std::endl;
  std::cout<<"  constant ctrl_another_byte_of_ctrl : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0) := "
	   <<ctrl_another_byte_of_ctrl<<";"<<std::endl;
  std::cout<<"  constant ctrl_idleword             : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0) := "
	   <<ctrl_idleword<<";"<<std::endl;
  std::cout<<"  constant data_idleword             : std_logic_vector(data_width_in_each_clockcycle-1 downto 0) := "
	   <<data_idleword<<";"<<std::endl;

  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> Until this line :: FROM IM - DF bit assignment"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> From this line :: FROM Pulsar IIb Schematics"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  constant swap_mask_fmc3 : std_logic_vector(total_low_pin_count_fmc-1 downto 0) :=\"";
  //  "0000"       &    -- LA33-LA30
  //  "0000000001" &    -- LA29-LA20
  //  "1100100111" &    -- LA19-LA10
  //  "0011000010";     -- LA09-LA00
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(swap_mask_la_fmcs[2])[NUM_LA_PAIRS-iChan-1]; // [0]=Pulsar2a, [2]=Pulsar2b
  }
  std::cout<<"\";"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  constant swap_mask_fmc4 : std_logic_vector(total_low_pin_count_fmc-1 downto 0) :=\"";
  //  "1111"       &    -- LA33-LA30
  //  "0100000111" &    -- LA29-LA20
  //  "0111001100" &    -- LA19-LA10
  //  "1011000001";     -- LA09-LA00  
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(swap_mask_la_fmcs[3])[NUM_LA_PAIRS-iChan-1]; // [1]=Pulsar2a, [3]=Pulsar2b
  }
  std::cout<<"\";"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  constant swap_mask_fmc1 : std_logic_vector(total_low_pin_count_fmc-1 downto 0) :=\"";
  //  "1111"       &    -- LA33-LA30
  //  "1010111111" &    -- LA29-LA20
  //  "1111111011" &    -- LA19-LA10
  //  "0110110111";     -- LA09-LA00
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(swap_mask_la_fmcs[0])[NUM_LA_PAIRS-iChan-1];
  }
  std::cout<<"\";"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  constant swap_mask_fmc2 : std_logic_vector(total_low_pin_count_fmc-1 downto 0) :=\"";
  //  "1111"       &    -- LA33-LA30
  //  "1101111101" &    -- LA29-LA20
  //  "0111111110" &    -- LA19-LA10
  //  "1111111111";     -- LA09-LA00
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(swap_mask_la_fmcs[1])[NUM_LA_PAIRS-iChan-1];
  }
  std::cout<<"\";"<<std::endl;
  
  std::cout<<"  constant swap_mask_fmc1_soft_reset0 : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]];
  std::cout<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc2_soft_reset0 : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[0]];
  std::cout<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc3_soft_reset0 : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[0]];
  std::cout<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc4_soft_reset0 : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[0]];
  std::cout<<"';"<<std::endl;
  
  std::cout<<"  constant swap_mask_fmc1_soft_reset1 : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]];
  std::cout<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc2_soft_reset1 : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[1]];
  std::cout<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc3_soft_reset1 : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[1]];
  std::cout<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc4_soft_reset1 : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[1]];
  std::cout<<"';"<<std::endl;
  
  std::cout<<"  -- ###############################################################################################"<<std::endl;
  std::cout<<"  constant number_of_banks_for_each_fpga : integer := 3;"<<std::endl; // 3 for Pulsar2a, 2 for Pulsar2a
  std::cout<<"  -- 0 for Bank37 / 1 for Bank39"<<std::endl;
  std::cout<<"  type bank_position_map_from_fmc_t is array(total_low_pin_count_fmc-1 downto 0) of integer;"<<std::endl;
  std::cout<<"  constant bank_position_fmc3 : bank_position_map_from_fmc_t := (";
  //  1,1,1,1,                -- LA33-LA30
  //  0,0,0,0,1,1,0,0,0,0,    -- LA29-LA20
  //--0,1,0,0,0,1,1,0,1,0,    -- LA19-LA10
  //  0,1,0,0,0,1,0,0,1,0,    -- LA19-LA10
  //--0,1,0,0,1,0,0,0,0,0,    -- LA09-LA00
  //  0,0,0,0,1,0,0,0,0,0);   -- LA09-LA00
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(bankid_la_fmcs[2])[NUM_LA_PAIRS-1-iChan]; // [0]=Pulsar2a, [2]=Pulsar2b
    if (iChan!=NUM_LA_PAIRS-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  -- 0 for Bank38 / 1 for Bank39"<<std::endl;
  std::cout<<"  constant bank_position_fmc4 : bank_position_map_from_fmc_t := (";
  //  0,0,1,1,                -- LA33-LA30
  //--0,0,1,0,0,0,0,0,0,1,    -- LA29-LA20
  //  0,0,1,0,1,0,0,0,0,1,    -- LA29-LA20
  //--0,1,1,0,0,0,0,0,0,0,    -- LA19-LA10
  //  1,1,1,0,0,0,0,0,0,0,    -- LA19-LA10
  //  1,0,0,0,0,0,0,1,1,1);   -- LA09-LA00  
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(bankid_la_fmcs[3])[NUM_LA_PAIRS-1-iChan]; // [1]=Pulsar2a, [3]=Pulsar2b
    if (iChan!=NUM_LA_PAIRS-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  -- 0 for Bank18 / 1 for Bank19"<<std::endl;
  std::cout<<"  constant bank_position_fmc1 : bank_position_map_from_fmc_t := (";
  //  1,1,0,0,                -- LA33-LA30
  //  0,0,1,0,1,1,1,0,0,0,    -- LA29-LA20
  //  1,0,1,0,1,0,0,1,0,0,    -- LA19-LA10
  //  0,1,0,0,1,0,0,0,0,0);   -- LA09-LA00
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(bankid_la_fmcs[0])[NUM_LA_PAIRS-1-iChan];
    if (iChan!=NUM_LA_PAIRS-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  -- 0 for Bank17 / 1 for Bank19"<<std::endl;
  std::cout<<"  constant bank_position_fmc2 : bank_position_map_from_fmc_t := (";
  //  0,0,0,0,                -- LA33-LA30
  //  1,1,0,0,0,0,1,1,0,1,    -- LA29-LA20
  //  1,0,0,0,0,0,0,0,0,1,    -- LA19-LA10
  //  1,0,0,0,0,0,0,1,0,1);   -- LA09-LA00  
  for (int iChan=0; iChan<NUM_LA_PAIRS; iChan++) {
    std::cout<<(bankid_la_fmcs[1])[NUM_LA_PAIRS-1-iChan];
    if (iChan!=NUM_LA_PAIRS-1)std::cout<<", ";
  }
  std::cout<<");"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> Until this line :: FROM Pulsar IIb Schematics"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  constant swap_mask_tx_clk_forward : std_logic_vector(0 to num_fmc_per_board-1) :="<<std::endl;
  std::cout<<"    (swap_mask_fmc1(tx_clock_forward_bit_position_in_all_FMC_LA_pin_count),"<<std::endl;
  std::cout<<"     swap_mask_fmc2(tx_clock_forward_bit_position_in_all_FMC_LA_pin_count),"<<std::endl;
  std::cout<<"     swap_mask_fmc3(tx_clock_forward_bit_position_in_all_FMC_LA_pin_count),"<<std::endl;
  std::cout<<"     swap_mask_fmc4(tx_clock_forward_bit_position_in_all_FMC_LA_pin_count)"<<std::endl;
  std::cout<<"     );"<<std::endl;
  std::cout<<std::endl;
  std::cout<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ###############################################################################################"<<std::endl;
  std::cout<<"  constant swap_mask_fmc2_clk0 : std_logic := '"<<(swap_mask_clk_fmcs[1])[0]<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc2_clk1 : std_logic := '"<<(swap_mask_clk_fmcs[1])[1]<<"';"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  constant swap_mask_fmc1_clk0 : std_logic := '"<<(swap_mask_clk_fmcs[0])[0]<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc1_clk1 : std_logic := '"<<(swap_mask_clk_fmcs[0])[1]<<"';"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  constant swap_mask_fmc3_clk0 : std_logic := '"<<(swap_mask_clk_fmcs[2])[0]<<"';"<<std::endl; // fmcs[2] for Pulsar2B
  std::cout<<"  constant swap_mask_fmc3_clk1 : std_logic := '"<<(swap_mask_clk_fmcs[2])[1]<<"';"<<std::endl; // fmcs[2] for Pulsar2B
  std::cout<<std::endl;
  std::cout<<"  constant swap_mask_fmc4_clk0 : std_logic := '"<<(swap_mask_clk_fmcs[3])[0]<<"';"<<std::endl; // fmcs[3] for Pulsar2B
  std::cout<<"  constant swap_mask_fmc4_clk1 : std_logic := '"<<(swap_mask_clk_fmcs[3])[1]<<"';"<<std::endl; // fmcs[3] for Pulsar2B

}

void dump_ucf()
{
  int total_rx_pairs_for_each_fmc = rx_fmc_to_fpga0_bit_mapping.size() + rx_fmc_to_fpga1_bit_mapping.size();
  
  //  ** RULE for logical pin assignment for RX (FBX_LVDS_RX_P/N) **
  //  ** Lower half bits : FPGA0  **
  //  ** Lower half bits : FPGA1  **
  
  //  ** RULE for logical pin assignment for TX (FBX_LVDS_RX_P/N) **
  //  ** Lower half bits : FPGA0  **
  //  ** Lower half bits : FPGA1  **
  
  //===========================================================
  //=====================   FB1   =============================
  
  // FB1_RX_LVDS series :
  for (int iChan=0; iChan<rx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[pair_id] << " [get_ports FB1_RX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[pair_id] << " [get_ports FB1_RX_LVDS_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_RX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_RX_LVDS_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FB1_RX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB1_RX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + rx_fmc_to_fpga0_bit_mapping.size();
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[pair_id] << " [get_ports FB1_RX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[pair_id] << " [get_ports FB1_RX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_RX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_RX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    //std::cout<<"NET FB1_RX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB1_RX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  
  // FB1_CLK series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[0])[0] << " [get_ports FB1_CLK0_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[0])[0] << " [get_ports FB1_CLK0_N]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[0])[1] << " [get_ports FB1_CLK1_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[0])[1] << " [get_ports FB1_CLK1_N]" << std::endl;
  
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_CLK0_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_CLK0_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_CLK1_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_CLK1_N]" << std::endl;
  
  //std::cout<<"NET FB1_CLK0_P LOC="<<(pins_pos_clk_fmcs[0])[0]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB1_CLK0_N LOC="<<(pins_neg_clk_fmcs[0])[0]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB1_CLK1_P LOC="<<(pins_pos_clk_fmcs[0])[1]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB1_CLK1_N LOC="<<(pins_neg_clk_fmcs[0])[1]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  //===========================================================
  //=====================   FB2   =============================
  
  // FB2_RX_LVDS series :
  for (int iChan=0; iChan<rx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[1])[pair_id] << " [get_ports FB2_RX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[1])[pair_id] << " [get_ports FB2_RX_LVDS_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_RX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_RX_LVDS_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FB2_RX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB2_RX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + rx_fmc_to_fpga0_bit_mapping.size();
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[1])[pair_id] << " [get_ports FB2_RX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[1])[pair_id] << " [get_ports FB2_RX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_RX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_RX_LVDS_N[" << channel_id_total << "] ]" << std::endl;    
    //std::cout<<"NET FB2_RX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB2_RX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  
  // FB2_CLK series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[1])[0] << " [get_ports FB2_CLK0_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[1])[0] << " [get_ports FB2_CLK0_N]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[1])[1] << " [get_ports FB2_CLK1_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[1])[1] << " [get_ports FB2_CLK1_N]" << std::endl;
  
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_CLK0_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_CLK0_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_CLK1_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_CLK1_N]" << std::endl;
  //std::cout<<"NET FB2_CLK0_P LOC="<<(pins_pos_clk_fmcs[1])[0]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB2_CLK0_N LOC="<<(pins_neg_clk_fmcs[1])[0]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB2_CLK1_P LOC="<<(pins_pos_clk_fmcs[1])[1]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB2_CLK1_N LOC="<<(pins_neg_clk_fmcs[1])[1]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  //===========================================================
  //=====================   FB3   =============================
  
  // FB3_RX_LVDS series :
  for (int iChan=0; iChan<rx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[2])[pair_id] << " [get_ports FB3_RX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[2])[pair_id] << " [get_ports FB3_RX_LVDS_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_RX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_RX_LVDS_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FB3_RX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[2])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB3_RX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[2])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + rx_fmc_to_fpga0_bit_mapping.size();
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[2])[pair_id] << " [get_ports FB3_RX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[2])[pair_id] << " [get_ports FB3_RX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_RX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_RX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    //std::cout<<"NET FB3_RX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[2])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB3_RX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[2])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  
  // FB3_CLK series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[2])[0] << " [get_ports FB3_CLK0_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[2])[0] << " [get_ports FB3_CLK0_N]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[2])[1] << " [get_ports FB3_CLK1_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[2])[1] << " [get_ports FB3_CLK1_N]" << std::endl;
  
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_CLK0_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_CLK0_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_CLK1_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_CLK1_N]" << std::endl;
  //std::cout<<"NET FB3_CLK0_P LOC="<<(pins_pos_clk_fmcs[2])[0]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB3_CLK0_N LOC="<<(pins_neg_clk_fmcs[2])[0]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB3_CLK1_P LOC="<<(pins_pos_clk_fmcs[2])[1]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB3_CLK1_N LOC="<<(pins_neg_clk_fmcs[2])[1]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  //===========================================================
  //=====================   FB4   =============================
  
  // FB4_RX_LVDS series :
  for (int iChan=0; iChan<rx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[3])[pair_id] << " [get_ports FB4_RX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[3])[pair_id] << " [get_ports FB4_RX_LVDS_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_RX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_RX_LVDS_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FB4_RX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[3])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB4_RX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[3])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + rx_fmc_to_fpga0_bit_mapping.size();
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[3])[pair_id] << " [get_ports FB4_RX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[3])[pair_id] << " [get_ports FB4_RX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_RX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_RX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    //std::cout<<"NET FB4_RX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[3])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB4_RX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[3])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  
  // FB4_CLK series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[3])[0] << " [get_ports FB4_CLK0_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[3])[0] << " [get_ports FB4_CLK0_N]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_clk_fmcs[3])[1] << " [get_ports FB4_CLK1_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_clk_fmcs[3])[1] << " [get_ports FB4_CLK1_N]" << std::endl;
  
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_CLK0_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_CLK0_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_CLK1_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_CLK1_N]" << std::endl;
  //std::cout<<"NET FB4_CLK0_P LOC="<<(pins_pos_clk_fmcs[3])[0]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB4_CLK0_N LOC="<<(pins_neg_clk_fmcs[3])[0]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB4_CLK1_P LOC="<<(pins_pos_clk_fmcs[3])[1]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB4_CLK1_N LOC="<<(pins_neg_clk_fmcs[3])[1]<<" | IOSTANDARD=LVDS;" << std::endl;

  //===========================================================
  //=====================   FB1 (TX)   ========================
  
  // FB1_TX_LVDS series :
  for (int iChan=0; iChan<tx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[pair_id] << " [get_ports FB1_TX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[pair_id] << " [get_ports FB1_TX_LVDS_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_TX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_TX_LVDS_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FB1_TX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB1_TX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  for (int iChan=0; iChan<tx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + tx_fmc_to_fpga0_bit_mapping.size();
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[pair_id] << " [get_ports FB1_TX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[pair_id] << " [get_ports FB1_TX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_TX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_TX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    //std::cout<<"NET FB1_TX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB1_TX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  
  // FB1_CLK series :
  const int fwdclk_bitpos = fwdclk_fmc_to_fpga_bit_mapping[0];
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[fwdclk_bitpos] << " [get_ports FB1_TX_FWD_CLK_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[fwdclk_bitpos] << " [get_ports FB1_TX_FWD_CLK_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_TX_FWD_CLK_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_TX_FWD_CLK_N]" << std::endl;
  //std::cout<<"NET FB1_TX_FWD_CLK_P LOC="<<(pins_pos_la_fmcs[0])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB1_TX_FWD_CLK_N LOC="<<(pins_neg_la_fmcs[0])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  // FB1_RESET series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports FB1_SOFT_RESET0_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports FB1_SOFT_RESET0_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_SOFT_RESET0_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_SOFT_RESET0_N]" << std::endl;
  //std::cout<<"NET FB1_SOFT_RESET0_P LOC="<<(pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB1_SOFT_RESET0_N LOC="<<(pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS;" << std::endl;

  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports FB1_SOFT_RESET1_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports FB1_SOFT_RESET1_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_SOFT_RESET1_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB1_SOFT_RESET1_N]" << std::endl;
  //std::cout<<"NET FB1_SOFT_RESET1_P LOC="<<(pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB1_SOFT_RESET1_N LOC="<<(pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  //===========================================================
  //=====================   FB2 (TX)  =========================
  
  // FB2_TX_LVDS series :
  for (int iChan=0; iChan<tx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[1])[pair_id] << " [get_ports FB2_TX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[1])[pair_id] << " [get_ports FB2_TX_LVDS_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_TX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_TX_LVDS_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FB2_TX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB2_TX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  for (int iChan=0; iChan<tx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + tx_fmc_to_fpga0_bit_mapping.size();
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[1])[pair_id] << " [get_ports FB2_TX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[1])[pair_id] << " [get_ports FB2_TX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_TX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_TX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    //std::cout<<"NET FB2_TX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB2_TX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  
  // FB2_CLK series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[1])[fwdclk_bitpos] << " [get_ports FB2_TX_FWD_CLK_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[1])[fwdclk_bitpos] << " [get_ports FB2_TX_FWD_CLK_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_TX_FWD_CLK_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_TX_FWD_CLK_N]" << std::endl;
  //std::cout<<"NET FB2_TX_FWD_CLK_P LOC="<<(pins_pos_la_fmcs[1])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB2_TX_FWD_CLK_N LOC="<<(pins_neg_la_fmcs[1])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  // FB2_RESET series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports FB2_SOFT_RESET0_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports FB2_SOFT_RESET0_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_SOFT_RESET0_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_SOFT_RESET0_N]" << std::endl;
  //std::cout<<"NET FB2_SOFT_RESET0_P LOC="<<(pins_pos_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB2_SOFT_RESET0_N LOC="<<(pins_neg_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS;" << std::endl;

  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports FB2_SOFT_RESET1_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports FB2_SOFT_RESET1_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_SOFT_RESET1_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB2_SOFT_RESET1_N]" << std::endl;  
  //std::cout<<"NET FB2_SOFT_RESET1_P LOC="<<(pins_pos_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB2_SOFT_RESET1_N LOC="<<(pins_neg_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS;" << std::endl;

  //===========================================================
  //=====================   FB3 (TX)   ========================
  
  // FB3_TX_LVDS series :
  for (int iChan=0; iChan<tx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[2])[pair_id] << " [get_ports FB3_TX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[2])[pair_id] << " [get_ports FB3_TX_LVDS_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_TX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_TX_LVDS_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FB3_TX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[2])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB3_TX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[2])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  for (int iChan=0; iChan<tx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + tx_fmc_to_fpga0_bit_mapping.size();
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[2])[pair_id] << " [get_ports FB3_TX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[2])[pair_id] << " [get_ports FB3_TX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_TX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_TX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    //std::cout<<"NET FB3_TX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[2])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB3_TX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[2])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  
  // FB3_CLK series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[2])[fwdclk_bitpos] << " [get_ports FB3_TX_FWD_CLK_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[2])[fwdclk_bitpos] << " [get_ports FB3_TX_FWD_CLK_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_TX_FWD_CLK_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_TX_FWD_CLK_N]" << std::endl;
  //std::cout<<"NET FB3_TX_FWD_CLK_P LOC="<<(pins_pos_la_fmcs[2])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB3_TX_FWD_CLK_N LOC="<<(pins_neg_la_fmcs[2])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  // FB3_RESET series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports FB3_SOFT_RESET0_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports FB3_SOFT_RESET0_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_SOFT_RESET0_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_SOFT_RESET0_N]" << std::endl;
  //std::cout<<"NET FB3_SOFT_RESET0_P LOC="<<(pins_pos_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB3_SOFT_RESET0_N LOC="<<(pins_neg_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports FB3_SOFT_RESET1_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports FB3_SOFT_RESET1_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_SOFT_RESET1_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB3_SOFT_RESET1_N]" << std::endl;
  //std::cout<<"NET FB3_SOFT_RESET1_P LOC="<<(pins_pos_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB3_SOFT_RESET1_N LOC="<<(pins_neg_la_fmcs[2])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  //===========================================================
  //=====================   FB4 (TX)   ========================
  
  // FB4_TX_LVDS series :
  for (int iChan=0; iChan<tx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[3])[pair_id] << " [get_ports FB4_TX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[3])[pair_id] << " [get_ports FB4_TX_LVDS_N[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_TX_LVDS_P[" << iChan << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_TX_LVDS_N[" << iChan << "] ]" << std::endl;
    //std::cout<<"NET FB4_TX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[3])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB4_TX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[3])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  for (int iChan=0; iChan<tx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + tx_fmc_to_fpga0_bit_mapping.size();
    std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[3])[pair_id] << " [get_ports FB4_TX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[3])[pair_id] << " [get_ports FB4_TX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_TX_LVDS_P[" << channel_id_total << "] ]" << std::endl;
    std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_TX_LVDS_N[" << channel_id_total << "] ]" << std::endl;
    //std::cout<<"NET FB4_TX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[3])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
    //std::cout<<"NET FB4_TX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[3])[pair_id] <<" | IOSTANDARD=LVDS;"<<std::endl;
  }
  
  // FB4_CLK series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[3])[fwdclk_bitpos] << " [get_ports FB4_TX_FWD_CLK_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[3])[fwdclk_bitpos] << " [get_ports FB4_TX_FWD_CLK_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_TX_FWD_CLK_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_TX_FWD_CLK_N]" << std::endl;
  //std::cout<<"NET FB4_TX_FWD_CLK_P LOC="<<(pins_pos_la_fmcs[3])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB4_TX_FWD_CLK_N LOC="<<(pins_neg_la_fmcs[3])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  // FB4_RESET series :
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports FB4_SOFT_RESET0_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[0]] << " [get_ports FB4_SOFT_RESET0_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_SOFT_RESET0_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_SOFT_RESET0_N]" << std::endl;
  //std::cout<<"NET FB4_SOFT_RESET0_P LOC="<<(pins_pos_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB4_SOFT_RESET0_N LOC="<<(pins_neg_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS;" << std::endl;
  
  std::cout << "set_property PACKAGE_PIN " << (pins_pos_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports FB4_SOFT_RESET1_P]" << std::endl;
  std::cout << "set_property PACKAGE_PIN " << (pins_neg_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[1]] << " [get_ports FB4_SOFT_RESET1_N]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_SOFT_RESET1_P]" << std::endl;
  std::cout << "set_property IOSTANDARD LVDS [get_ports FB4_SOFT_RESET1_N]" << std::endl;
  //std::cout<<"NET FB4_SOFT_RESET1_P LOC="<<(pins_pos_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS;" << std::endl;
  //std::cout<<"NET FB4_SOFT_RESET1_N LOC="<<(pins_neg_la_fmcs[3])[soft_reset_fmc_to_fpga_bit_mapping[1]]<<" | IOSTANDARD=LVDS;" << std::endl;

}
