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

void dump_lib();
void dump_ucf();

void set_phase_scan_mode()
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
  std::ifstream input("PulsarIIa_FMC.csv");
  
  set_phase_scan_mode();
  
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
  std::cout<<"  constant num_fmc_per_mainfpga : integer := 2;"<<std::endl;  // 2 for pulsar2a, 4 for pulsar2b
  std::cout<<"  constant num_fpga_for_each_mainfpga : integer := num_fpga_per_fmc*num_fmc_per_mainfpga;"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  type lvds_pairs_for_each_fpga_t is array (0 to num_fpga_for_each_mainfpga-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);"<<std::endl;
  std::cout<<"  type lvds_pairs_for_each_fmc_t is array (0 to num_fmc_per_mainfpga-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);"<<std::endl;
  std::cout<<"  type rx_fmc_to_fpga_bit_mapping_array_t is array (0 to lvds_pairs_for_rx_in_each_fpga-1)"<<std::endl;
  std::cout<<"    of integer range 0 to total_low_pin_count_fmc-1;"<<std::endl;
  std::cout<<"  type data_type_for_imfpga_input_lanes_t  is array (0 to num_fpga_for_each_mainfpga-1)"<<std::endl;
  std::cout<<"    of std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);"<<std::endl;
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
  
  std::cout<<"  -- ###############################################################################################"<<std::endl;
  std::cout<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  -- <config> From this line :: FTKIM-DF pin assignment"<<std::endl;
  std::cout<<"  -- ########################################################"<<std::endl;
  std::cout<<"  constant fpga_to_spare_bit_mapping  : integer :="<<rx_ctrl_space<<";"<<std::endl;
  std::cout<<"  constant fpga_to_parity_bit_mapping : integer :="<<rx_ctrl_parity<<";"<<std::endl;
  std::cout<<"  constant fpga_to_soft_reset_bit_mapping : integer :="<<soft_reset_fmc_to_fpga_bit_mapping[0]<<";"<<std::endl;
  
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

  std::cout<<"  constant swap_mask_fmc1_soft_reset : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]];
  std::cout<<"';"<<std::endl;
  std::cout<<"  constant swap_mask_fmc2_soft_reset : std_logic :='";
  std::cout<<(swap_mask_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[0]];
  std::cout<<"';"<<std::endl;
  
  std::cout<<std::endl;
  
  std::cout<<"  -- ###############################################################################################"<<std::endl;
  std::cout<<"  constant number_of_banks_for_each_fpga : integer := 3;"<<std::endl; // 3 for Pulsar2a, 2 for Pulsar2a
  std::cout<<"  type bank_position_map_from_fmc_t is array(total_low_pin_count_fmc-1 downto 0) of integer;"<<std::endl;
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
  std::cout<<"  constant swap_mask_tx_clk_forward : std_logic_vector(0 to num_fmc_per_mainfpga-1) :="<<std::endl;
  std::cout<<"    (swap_mask_fmc1(tx_clock_forward_bit_position_in_all_FMC_LA_pin_count),"<<std::endl;
  std::cout<<"     swap_mask_fmc2(tx_clock_forward_bit_position_in_all_FMC_LA_pin_count)"<<std::endl;
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
  //=====================   FB1 (RX)   ========================
  
  // FB1_RX_LVDS series :
  for (int iChan=0; iChan<rx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout<<"NET FB1_RX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FB1_RX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + rx_fmc_to_fpga0_bit_mapping.size();
    std::cout<<"NET FB1_RX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FB1_RX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  
  // FB1_CLK series :
  std::cout<<"NET FB1_CLK0_P LOC="<<(pins_pos_clk_fmcs[0])[0]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB1_CLK0_N LOC="<<(pins_neg_clk_fmcs[0])[0]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB1_CLK1_P LOC="<<(pins_pos_clk_fmcs[0])[1]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB1_CLK1_N LOC="<<(pins_neg_clk_fmcs[0])[1]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  
  //===========================================================
  //=====================   FB2 (RX)  =========================
  
  // FB2_RX_LVDS series :
  for (int iChan=0; iChan<rx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout<<"NET FB2_RX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FB2_RX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  for (int iChan=0; iChan<rx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = rx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + rx_fmc_to_fpga0_bit_mapping.size();
    std::cout<<"NET FB2_RX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FB2_RX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  
  // FB2_CLK series :
  std::cout<<"NET FB2_CLK0_P LOC="<<(pins_pos_clk_fmcs[1])[0]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB2_CLK0_N LOC="<<(pins_neg_clk_fmcs[1])[0]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB2_CLK1_P LOC="<<(pins_pos_clk_fmcs[1])[1]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB2_CLK1_N LOC="<<(pins_neg_clk_fmcs[1])[1]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  
  //===========================================================
  //=====================   FB1 (TX)   ========================
  
  // FB1_TX_LVDS series :
  for (int iChan=0; iChan<tx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout<<"NET FB1_TX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FB1_TX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  for (int iChan=0; iChan<tx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + tx_fmc_to_fpga0_bit_mapping.size();
    std::cout<<"NET FB1_TX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FB1_TX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[0])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  
  // FB1_CLK series :
  const int fwdclk_bitpos = fwdclk_fmc_to_fpga_bit_mapping[0];
  std::cout<<"NET FB1_TX_FWD_CLK_P LOC="<<(pins_pos_la_fmcs[0])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB1_TX_FWD_CLK_N LOC="<<(pins_neg_la_fmcs[0])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  
  std::cout<<"NET FB1_SOFT_RESET_P LOC="<<(pins_pos_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB1_SOFT_RESET_N LOC="<<(pins_neg_la_fmcs[0])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS_25;" << std::endl;

  //===========================================================
  //=====================   FB2 (TX)  =========================
  
  // FB2_TX_LVDS series :
  for (int iChan=0; iChan<tx_fmc_to_fpga0_bit_mapping.size(); iChan++) { // FPGA0
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga0_bit_mapping[iChan];
    std::cout<<"NET FB2_TX_LVDS_P("<<iChan<<") LOC="<< (pins_pos_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FB2_TX_LVDS_N("<<iChan<<") LOC="<< (pins_neg_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  for (int iChan=0; iChan<tx_fmc_to_fpga1_bit_mapping.size(); iChan++) { // FPGA1
    const FMC_CHANNEL_ID pair_id = tx_fmc_to_fpga1_bit_mapping[iChan];
    int channel_id_total = iChan + tx_fmc_to_fpga0_bit_mapping.size();
    std::cout<<"NET FB2_TX_LVDS_P("<<channel_id_total<<") LOC="<< (pins_pos_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
    std::cout<<"NET FB2_TX_LVDS_N("<<channel_id_total<<") LOC="<< (pins_neg_la_fmcs[1])[pair_id] <<" | IOSTANDARD=LVDS_25;"<<std::endl;
  }
  
  // FB2_CLK series :
  std::cout<<"NET FB2_TX_FWD_CLK_P LOC="<<(pins_pos_la_fmcs[1])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB2_TX_FWD_CLK_N LOC="<<(pins_neg_la_fmcs[1])[fwdclk_bitpos]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  
  std::cout<<"NET FB2_SOFT_RESET_P LOC="<<(pins_pos_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS_25;" << std::endl;
  std::cout<<"NET FB2_SOFT_RESET_N LOC="<<(pins_neg_la_fmcs[1])[soft_reset_fmc_to_fpga_bit_mapping[0]]<<" | IOSTANDARD=LVDS_25;" << std::endl;

}
