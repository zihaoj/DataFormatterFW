// written by yasuyuki.okumura@cern.ch 

#include <FTKDFIpbus/df_ipbus_access_ok.hh>
#include <uhal/log/log.hpp>

#include <fstream>
#include <string>
#include <sstream>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

using namespace uhal;

static const uint32_t number_of_im_fpga=0X8;

std::string ultostr(const uint32_t &value)
{
  char buf[BUFSIZ];
  snprintf(buf, sizeof(buf), "%u", value);
  return std::string(buf);
}

std::string SpyLaneName[] = {"LSC Ch00",
			     "LSC Ch01",
			     "LSC Ch02",
			     "LSC Ch03",
			     "LSC Ch04",
			     "LSC Ch05",
			     "LSC Ch06",
			     "LSC Ch07",
			     "LSC Ch08",
			     "LSC Ch09",
			     "LSC Ch10",
			     "LSC Ch11",
			     "LSC Ch12",
			     "LSC Ch13",
			     "LSC Ch14",
			     "LSC Ch15",
			     "LSC Ch16",
			     "LSC Ch17",
			     "LSC Ch18",
			     "LSC Ch19",
			     "LSC Ch20",
			     "LSC Ch21",
			     "LSC Ch22",
			     "LSC Ch23",
			     "LSC Ch24",
			     "LSC Ch25",
			     "LSC Ch26",
			     "LSC Ch27",
			     "LSC Ch28",
			     "LSC Ch29",
			     "LSC Ch30",
			     "LSC Ch31",
			     "LSC Ch32",
			     "LSC Ch33",
			     "INPUT Ch00",
			     "INPUT Ch01",
			     "INPUT Ch02",
			     "INPUT Ch03",
			     "INPUT Ch04",
			     "INPUT Ch05",
			     "INPUT Ch06",
			     "INPUT Ch07",
			     "INPUT Ch08",
			     "INPUT Ch09",
			     "INPUT Ch10",
			     "INPUT Ch11",
			     "INPUT Ch12",
			     "INPUT Ch13",
			     "INPUT Ch14",
			     "INPUT Ch15",
			     "FB0 FPGA0 RAW",
			     "FB0 FPGA1 RAW",
			     "FB1 FPGA0 RAW",
			     "FB1 FPGA1 RAW",
			     "FB2 FPGA0 RAW",
			     "FB2 FPGA1 RAW",
			     "FB3 FPGA0 RAW",
			     "FB3 FPGA1 RAW"};

void standard_configuration(df_ipbus_access_ok& df, 
			    const bool& use_default_setup_for_fermilab_test_mezzanine, 
			    const std::string& configuration_filename,
			    const std::string& transceiver_configuration_filename);
void counter_dump(df_ipbus_access_ok& df);
void demonstration(df_ipbus_access_ok& df, const uint32_t& repeat);
void set_parameters(df_ipbus_access_ok& df,
		    const std::string& configuration_filename);
void set_transceiver_parameters(df_ipbus_access_ok& df,
				const std::string& transceiver_configuration_filename);
void set_ftkim_parameters(df_ipbus_access_ok& df);
void set_fnaltm_parameters(df_ipbus_access_ok& df);
void set_transceiver_parameters_test(df_ipbus_access_ok& df);
void set_internal_communication_parameters_test(df_ipbus_access_ok& df);
void speedtest(df_ipbus_access_ok& df, const uint32_t& repeat);

//============================================================
void print_usage (const std::string& default_connection_file,
		  const std::string& default_transceiver_configuration_file) 
{
  printf("-h          : produce help message \n");
  printf("-M          : mode (see below) \n");
  printf("-C <string> : connection file URI (default %s) \n", default_connection_file.c_str());
  printf("-D <string> : device ID  \n");  
  printf("-d          : loglevel=debug (default loglevel=warning) \n");
  printf("----------------------------------- \n");
  printf("MODE options \n");
  printf("1  : Standard Configuration -F <configuration filename> (-X <transceiver configuration filename>) \n");
  printf("     (-t for default Fermilab Test Mezzanine) \n");
  printf("     note : default transceiver configuration file is %s \n", default_transceiver_configuration_file.c_str());
  printf("2  : Word counter monitoring / Demonstation with Fermilab Test Mezzanine (-R <uint32>; number of repetation) \n");
  printf("3  : Clock Set -L <uint32> (IM-FPGA 0..7) -V <uint32> (delay value) (-i for inv configuration) \n");  
  printf("4  : Phase Scan -L <uint32> (IM-FPGA 0..7) \n");
  printf("5  : Spy Buffer Dump (-L <uint32> to lane selection) \n");
  printf("6  : Readout 32bit Counter (-T <uint32> -L <uint32> to lane selection) \n");
  printf("     (T is type of target counter 0:ctrl, 1:data, 2:xoff) \n");
  printf("7  : Access LUT data (-T <uint32> -L <uint32> -A <RAM address> -w/-r -V <uint32> -E <uint32>) \n");
  printf("     (T is type of target look up table. see note.txt in the directory) \n");
  printf("     (E is enable-lane-mask bit pattern, where '1' is to be filled for lanes to be updated.) \n");
  printf("8  : Dump LUT (-T <uint32> -L <uint32>) \n");
  printf("9  : GT CHANNEL MONITOR \n");
  printf("10 : SLINK Reset \n");
  printf("11 : speed test (-R <int>) \n");
  printf("100: Single Command \n");
  printf("200: Single Command I2C \n");
  printf("----------------------------------- \n");
  printf("For single command (mode=100) \n");
  printf("-N <string> : node name (registre name) \n");
  printf("-r          : read access (default) \n");
  printf("-w          : write access \n");
  printf("-V <uint32> : write value (valid in only write access) \n");
  printf("----------------------------------- \n");
  printf("For I2C single command (mode=200) \n");
  printf("-A <uint32> : i2c address (7bit) \n");
  printf("-r          : read access (default) \n");
  printf("-w          : write access \n");
  printf("-V <uint32> : write value (valid in only write access) \n");
}

//============================================================
int main ( int argc,char* argv[] )
{
  uhal::setLogLevelTo ( Warning() );
  int c;
  const std::string default_connection_file = std::string(getenv("DF_IPUBUS_CONFIG")) + "/connections.xml";
  std::string connection_file = std::string("file://") + default_connection_file;
  std::string configuration_filename("configuration.txt");
  const std::string default_transceiver_configuration_filename = std::string(getenv("DF_IPUBUS_CONFIG")) + "/transceiver_configuration.txt";
  std::string transceiver_configuration_filename = default_transceiver_configuration_filename;
  std::string device_id("");
  bool rc = false;
  std::string node("");
  bool is_write_access(false);
  uint32_t value(0X0);
  uint32_t lane_id(0X0);
  bool results = true;
  int mode=0X0;
  uint32_t addr(0X0);
  uint32_t type_id(0X0);
  uint32_t lut_lane_mask(0X0);
  bool inv_configuration(false);
  uint32_t repeat(0X0);
  bool use_default_setup_for_fermilab_test_mezzanine(false);
  
  while ((c = getopt (argc, argv, "wrhC:D:N:V:dM:L:T:E:iA:R:tF:X:")) != -1) {
    switch (c)
      {
      case 'h':
	print_usage(default_connection_file,
		    default_transceiver_configuration_filename);
	return EXIT_SUCCESS;
      case 'M':
	mode=strtoul(optarg, NULL, 0);
	break;
      case 'C':
	connection_file=std::string("file://")+optarg;
	break;
      case 'D':
	rc=true;
	device_id=optarg;
	break;
      case 'N':
	node=optarg;
	break;
      case 'w':
	is_write_access=true;
	break;
      case 'V':
	value=strtoul(optarg, NULL, 0);
	break;
      case 'd':
	uhal::setLogLevelTo ( Debug() );
	break;
      case 'A':
	addr=strtoul(optarg, NULL, 0);
	break;
      case 'r':
	is_write_access=false;
	break;
      case 'L':
	lane_id=strtoul(optarg, NULL, 0);
	break;
      case 'T':
	type_id=strtoul(optarg, NULL, 0);
	break;
      case 'E':
	lut_lane_mask=strtoul(optarg, NULL, 0);	
	break;
      case 'i':
	inv_configuration = true;
	break;
      case 'R':
	repeat=strtoul(optarg, NULL, 0);
	break;
      case 't':
	use_default_setup_for_fermilab_test_mezzanine = true;
	break;
      case 'F':
	configuration_filename = optarg;
	break;
      case 'X':
	transceiver_configuration_filename = optarg;
	break;
      default:
	print_usage(default_connection_file,
		    default_transceiver_configuration_filename);
	return EXIT_FAILURE;
      }
  }
  
  if (not rc) {
    print_usage(default_connection_file,
		default_transceiver_configuration_filename);
    return EXIT_FAILURE;    
  }
  
  df_ipbus_access_ok df(connection_file, device_id);
  
  
  if        (mode==1)   { // ===================================================
    standard_configuration(df, use_default_setup_for_fermilab_test_mezzanine, configuration_filename, transceiver_configuration_filename);
   
  } else if (mode==2)   { // ===================================================
    demonstration(df, repeat);
    
  } else if (mode==3)   { // ===================================================
    uint32_t inv_command = (inv_configuration) ? 0x1 : 0x0;
    df.clock_phase_configuration(lane_id, inv_command, value);
    
  } else if (mode==4)   { // ===================================================
    df.phase_scan(lane_id);
    
  } else if (mode==5)   { // ===================================================
    std::vector<uint32_t> dout;
    df.spy_dump_individual_lane(lane_id, dout);
    for (int iWord=0, nWords=dout.size(); iWord<nWords; iWord++) {
      printf("[Lane:%10s] Address:%4d - 0X%08x \n", SpyLaneName[lane_id].c_str(), iWord, dout[iWord]);
    }

  } else if (mode==6)   { // ===================================================
    uint32_t dout;
    df.read_32bit_counter(type_id, lane_id, dout);
    printf("[Type:%2d Lane:%2d] read 0X%08x \n", type_id, lane_id, dout);

  } else if (mode==7)   { // ===================================================
    if (is_write_access) {
      df.write_lut(type_id, addr, value, lut_lane_mask);
    } 
    else {
      df.read_lut(type_id, addr, lane_id, value);
      printf("[Device:%5s Type:%2d Lane:%2d Address:0X%04x] read 0X%08x \n", 
	     device_id.c_str(), node.c_str(), type_id, lane_id, addr, value);
    }

  } else if (mode==8)   { // ===================================================
    std::vector<uint32_t> dout;
    df.dump_lut(type_id, lane_id, dout);
    for (int iWord=0, nWords=dout.size(); iWord<nWords; iWord++) {
      printf("[Type:%2d Lane:%2d Address:%4d] read 0X%08x \n", type_id, lane_id, iWord, dout[iWord]);
    }    
    
  } else if (mode==9)   { // ===================================================
    const uint32_t nGtChannel=58; // 34 + 24
    uint32_t gt_rxpolarity;
    uint32_t gt_txpolarity;
    uint32_t force_ready_mode;
    uint32_t to_altera_fpga;
    uint32_t gt_rxbyteisaligned;
    uint32_t gt_tx_reset_done;
    uint32_t gt_rx_reset_done;
    uint32_t gt_pll_lock;
    uint32_t slink_testled_n;
    uint32_t slink_lderrled_n;
    uint32_t slink_lupled_n;
    uint32_t slink_flowctrlled_n;
    uint32_t slink_activityled_n;
    uint32_t slink_lrl;
    for (int iGt=0; iGt<nGtChannel; iGt++) {
      df.gt_monitor(iGt, gt_rxpolarity, gt_txpolarity,
		    force_ready_mode, to_altera_fpga, gt_rxbyteisaligned,
		    gt_tx_reset_done, gt_rx_reset_done, gt_pll_lock,
		    slink_testled_n, slink_lderrled_n,
		    slink_lupled_n, slink_flowctrlled_n, slink_activityled_n,
		    slink_lrl);
      printf("GT=[%2d] :  RXFLIP=[%3s] TXFLIP=[%3s] "
	     "FORCE_READY=[%3s] TO_ALTERA=[%3s] BYTEALIGNE=[%4s] "
	     "TX_RST=[%4s] RX_RST=[%4s] PLL[%9s] "
	     "SLINK : TEST=[%4s] LDERR=[%4s] LUP=[%4s] FLOWCTRL=[%4s] ACTIVITY=[%4s] LRL=[%1x]\n",
	     iGt,
	     gt_rxpolarity==0X0 ? "OFF" : "ON", 
	     gt_txpolarity==0X0 ? "OFF" : "ON",
	     force_ready_mode==0X0 ? "OFF" : "ON",
	     to_altera_fpga==0X0 ? "OFF" : "ON", 
	     gt_rxbyteisaligned==0X0 ? "YET" : "DONE",
	     gt_tx_reset_done==0X0 ? "YET" : "DONE",
	     gt_rx_reset_done==0X0 ? "YET" : "DONE",
	     gt_pll_lock==0X0 ? "NOT LOCKED"  : "LOCKED",
	     slink_testled_n==0X0 ? "ON" : "OFF",
	     slink_lderrled_n==0X0 ? "BAD" : "GOOD",
	     slink_lupled_n==0X0 ? "GOOD" : "BAD",
	     slink_flowctrlled_n==0X0 ? "ON" : "OFF",
	     slink_activityled_n==0X0 ? "YES" : "NO",
	     slink_lrl);
    }
  } else if (mode==10) { // ===================================================
    df.single_access_write("reg.gt_link_controller.slink_reset", 0x1);
    df.single_access_write("reg.gt_link_controller.slink_reset", 0x0);

  } else if (mode==11) { // ===================================================
    speedtest(df, repeat);
  } else if (mode==100) { // ===================================================
    if (is_write_access) {
      df.single_access_write(node, value);
      printf("[Device:%5s Node:%20s] write 0X%08x \n", device_id.c_str(), node.c_str(), value);
    } 
    else {
      if(not df.single_access_read(node, value)) {results=false;}
      printf("[Device:%5s Node:%20s] read :0X%08x \n", device_id.c_str(), node.c_str(), value);
    }
    
  } else if (mode==200) { // ===================================================
    if (is_write_access) {
      if (not df.i2c_single_access_write(addr, value)) {
	fprintf(stderr, "I2c error in Device:%5s Address:0X%02x Write:0X%02x \n", device_id.c_str(), addr, value);
      }
      printf("[I2c Device:%5s Address:0X%02x] write 0X%02x \n", device_id.c_str(), addr, value);
    } 
    else {
      if (not df.i2c_single_access_read(addr, value)) {
	fprintf(stderr, "I2c error in Device:%5s Address:0X%02x Read \n", device_id.c_str(), addr);
      }
      printf("[I2c Device:%5s Address:0X%02x] read 0X%02x \n", device_id.c_str(), addr, value);
    }
  } else {
    print_usage(default_connection_file,
		default_transceiver_configuration_filename);
    results = false;
  }
  
  return (results) ? EXIT_SUCCESS : EXIT_FAILURE;  
}

// ===================================================
void standard_configuration(df_ipbus_access_ok& df, 
			    const bool& use_default_setup_for_fermilab_test_mezzanine,
			    const std::string& configuration_filename,
			    const std::string& transceiver_configuration_filename)
{
  if (not use_default_setup_for_fermilab_test_mezzanine) { 
    set_parameters            (df, configuration_filename);
    set_transceiver_parameters(df, transceiver_configuration_filename);
  } else {
    set_fnaltm_parameters(df);
  }
  
  df.standard_reset_configuration();
}

//============================================================
void demonstration(df_ipbus_access_ok& df, const uint32_t& repeat)
{
  
  for (uint32_t irepeat=0; irepeat<repeat; irepeat++) {
    df.single_access_write("reg.fmc_user_signal.mezzanine_trigger", 0X1);
    df.single_access_write("reg.fmc_user_signal.mezzanine_trigger", 0X0);
  }
  
  counter_dump(df);
}

//============================================================
void speedtest(df_ipbus_access_ok& df, const uint32_t& repeat)
{
  time_t begin, end;
  time(&begin);
  const Node& reg=df.get_hardware()->getNode("reg.fb_i2c_address.address");
  for (int ii=0; ii<repeat; ii++) {
    reg.write(0X1);  
    df.get_hardware()->dispatch(); // send transaction
  }
  time(&end);
  printf("repeat=%10d %10.3f[s] \n", repeat, difftime(end, begin) );
}

//============================================================
void counter_dump(df_ipbus_access_ok& df)
{
  const uint32_t n_slink_lsc_lane_offset =  0;
  const uint32_t n_slink_lsc_lanes       = 34;
  const uint32_t n_fmc_input_lane_offset = n_slink_lsc_lane_offset + n_slink_lsc_lanes;
  const uint32_t n_fmc_input_lanes       = 16;
  const uint32_t n_raw_input_lane_offset = n_fmc_input_lane_offset + n_fmc_input_lanes;
  const uint32_t n_raw_input_lanes       = 8;
  const uint32_t n_odo_in_lane_offset    = n_raw_input_lane_offset + n_raw_input_lanes;
  const uint32_t n_odo_in_lanes          = 32;
  const uint32_t n_ilo_in_lane_offset    = n_odo_in_lane_offset + n_odo_in_lanes;
  const uint32_t n_ilo_in_lanes          = 32;
  const uint32_t n_output_switch_in_lane_offset  = n_ilo_in_lane_offset + n_ilo_in_lanes;
  const uint32_t n_output_switch_in_lanes        = 32;
  const uint32_t n_output_switch_out_lane_offset = n_output_switch_in_lane_offset + n_output_switch_in_lanes;
  const uint32_t n_output_switch_out_lanes       = 32;
  const uint32_t n_output_event_sorter_in_lane_offset = n_output_switch_out_lane_offset + n_output_switch_out_lanes;
  const uint32_t n_output_event_sorter_in_lanes       = 34;
  const uint32_t n_central_switch_out_lane_offset = n_output_event_sorter_in_lane_offset + n_output_event_sorter_in_lanes;
  const uint32_t n_central_switch_out_lanes       = 32;
  const uint32_t n_internallink_output_switch_in_lane_offset  = n_central_switch_out_lane_offset + n_central_switch_out_lanes;
  const uint32_t n_internallink_output_switch_in_lanes        = 32;
  const uint32_t n_internallink_output_switch_out_lane_offset = n_internallink_output_switch_in_lane_offset + n_internallink_output_switch_in_lanes;
  const uint32_t n_internallink_output_switch_out_lanes       = 32;
  const uint32_t n_internal_link_out_lane_offset = n_internallink_output_switch_out_lane_offset + n_internallink_output_switch_out_lanes;
  const uint32_t n_internal_link_out_lanes       = 24;
  const uint32_t n_input_switch_lane_offset = n_internal_link_out_lane_offset + n_internal_link_out_lanes;
  const uint32_t n_input_switch_lanes       = 16;
  const uint32_t n_internal_event_counter_lane_offset = n_input_switch_lane_offset + n_input_switch_lanes;
  const uint32_t n_internal_event_counter_lanes       = 16;
  const uint32_t n_frame_path_lane_offset =  n_internal_event_counter_lane_offset + n_internal_event_counter_lanes;
  const uint32_t n_frame_path_lanes       =  1;
  const uint32_t n_couter_total = n_frame_path_lane_offset + n_frame_path_lanes;
  
  const uint32_t n_type = 4;
  const std::string type_name[n_type] = {"ctrl", "data", "xoff", "xoffmon"};
  
  std::vector<uint32_t> data_counter(n_couter_total);
  std::vector<uint32_t> xoff_counter(n_couter_total);
  std::vector<uint32_t> ctrl_counter(n_couter_total);
  std::vector<uint32_t> xoff_monitor(n_couter_total);
  
  uint32_t enable_fmc_lanes_mask = 0X0;
  df.single_access_read("reg.enable_fmc_lanes_mask", enable_fmc_lanes_mask);
  
  uint32_t input_xoff = 0X0;
  df.single_access_read("reg.input_buffer_xoff", input_xoff);
  
  for (uint32_t ilane=0; ilane<n_couter_total; ilane++) {
    
    uint32_t dout[n_type]={0X0, 0X0, 0X0, 0X0};    
    for (uint32_t itype=0; itype<n_type; itype++) {
      df.read_32bit_counter(itype, ilane, dout[itype]);
    }
    ctrl_counter[ilane]    = dout[0];
    data_counter[ilane]    = dout[1];
    xoff_counter[ilane]    = dout[2];
    xoff_monitor[ilane]    = dout[3];
  }
  
  printf("    %1s %1s | %1s %10s %10s | %1s %10s %10s | %1s %10s | %1s %10s | %1s %10s | %1s %15s | %1s %10s %10s | %1s %10s %10s || %1s %13s | %1s %13s | %1s %13s | %1s %13s | %1s %13s\n",
	 "", "", 
	 "", "FMCIN", "",
	 "", "INPUTSW IN", "last evt",
	 "", "ODO IN",
	 "", "OUTSW IN",
	 "", "OUTSW OUT",
	 "", "PACKER IN (MOD)",
	 "", "PACKER IN", "(FRAME)",
	 "", "SLINK OUT", "",
	 "", "CENTSW IN",
	 "", "CENTSW OUT",
	 "", "INTOUTSW IN",
	 "", "INTOUTSW OUT",
	 "", "IntLink TX");
  
  for (int ii=0; ii<34; ii++) {
    printf("%2d: %1s %1s | %1s %10s %10s | %1s %10s (%8s) | %1s %10s | %1s %10s | %1s %10s | %1s %15s | %1s %10s %10s | %1s %10s %10s || %1s %13s | %1s %13s | %1s %13s | %1s %13s | %1s %13s\n",
	   ii,
	   (ii<n_fmc_input_lanes)          ? ((enable_fmc_lanes_mask & (0X1<<ii))==0)?                    "" : "E" : "-",
	   (ii<n_fmc_input_lanes)          ? ((input_xoff>>ii)&0X1)==0X0 ?                              "" : "X" : "-",
	   (ii<n_fmc_input_lanes)          ? (xoff_monitor[n_fmc_input_lane_offset+ii]==0X0) ?          "R" : "I" : "-", // idle or read mode
	   (ii<n_fmc_input_lanes)          ? ultostr(ctrl_counter[n_fmc_input_lane_offset         + ii]).c_str() : "-",
	   (ii<n_fmc_input_lanes)          ? ultostr(data_counter[n_fmc_input_lane_offset         + ii]).c_str() : "-",
	   (ii<n_input_switch_lanes)       ? (xoff_monitor[n_input_switch_lane_offset+ii]==0X0) ?             "" : "X" : "-",
	   (ii<n_input_switch_lanes)       ? ultostr(data_counter[n_input_switch_lane_offset            + ii]).c_str() : "-",
	   (ii<n_internal_event_counter_lanes) ? ultostr(data_counter[n_internal_event_counter_lane_offset + ii]).c_str() : "-",
	   (ii<n_odo_in_lanes)             ? (xoff_monitor[n_odo_in_lane_offset+ii]==0X0) ?             "" : "X" : "-",
	   (ii<n_odo_in_lanes)             ? ultostr(data_counter[n_odo_in_lane_offset            + ii]).c_str() : "-",
	   (ii<n_output_switch_in_lanes)   ? (xoff_monitor[n_output_switch_in_lane_offset+ii]==0X0) ?   "" : "X" : "-",
	   (ii<n_output_switch_in_lanes)   ? ultostr(data_counter[n_output_switch_in_lane_offset  + ii]).c_str() : "-",
	   (ii<n_output_switch_out_lanes)  ? (xoff_monitor[n_output_switch_out_lane_offset+ii]==0X0) ?  "" : "X" : "-",
	   (ii<n_output_switch_out_lanes)  ? ultostr(data_counter[n_output_switch_out_lane_offset + ii]).c_str() : "-",
	   (ii<n_output_event_sorter_in_lanes)  ? (xoff_monitor[n_output_event_sorter_in_lane_offset+ii]==0X0) ?  "" : "X" : "-",
	   (ii<n_output_event_sorter_in_lanes)  ? ultostr(data_counter[n_output_event_sorter_in_lane_offset + ii]).c_str() : "-",
	   (ii<n_frame_path_lanes)          ? (xoff_monitor[n_frame_path_lane_offset+ii]==0X0) ?          "" : "X" : "-",
	   (ii<n_frame_path_lanes)          ? ultostr(ctrl_counter[n_frame_path_lane_offset         + ii]).c_str() : "-",
	   (ii<n_frame_path_lanes)          ? ultostr(data_counter[n_frame_path_lane_offset         + ii]).c_str() : "-",
	   (ii<n_slink_lsc_lanes)           ? (xoff_monitor[n_slink_lsc_lane_offset+ii]==0X0) ?          "" : "X" : "-",
	   (ii<n_slink_lsc_lanes)          ? ultostr(ctrl_counter[n_slink_lsc_lane_offset         + ii]).c_str() : "-",
	   (ii<n_slink_lsc_lanes)          ? ultostr(data_counter[n_slink_lsc_lane_offset         + ii]).c_str() : "-",
	   (ii<n_ilo_in_lanes)             ? (xoff_monitor[n_ilo_in_lane_offset+ii]==0X0) ?             "" : "X" : "-",
	   (ii<n_ilo_in_lanes)             ? ultostr(data_counter[n_ilo_in_lane_offset            + ii]).c_str() : "-",
	   (ii<n_central_switch_out_lanes) ? (xoff_monitor[n_central_switch_out_lane_offset+ii]==0X0) ? "" : "X" : "-",
	   (ii<n_central_switch_out_lanes) ? ultostr(data_counter[n_central_switch_out_lane_offset+ ii]).c_str() : "-",
	   (ii<n_internallink_output_switch_in_lanes)   ? (xoff_monitor[n_internallink_output_switch_in_lane_offset+ii]==0X0) ?   "" : "X" : "-",
	   (ii<n_internallink_output_switch_in_lanes)   ? ultostr(data_counter[n_internallink_output_switch_in_lane_offset  + ii]).c_str() : "-",
	   (ii<n_internallink_output_switch_out_lanes)  ? (xoff_monitor[n_internallink_output_switch_out_lane_offset+ii]==0X0) ?  "" : "X" : "-",
	   (ii<n_internallink_output_switch_out_lanes)  ? ultostr(data_counter[n_internallink_output_switch_out_lane_offset + ii]).c_str() : "-",
	   (ii<n_internal_link_out_lanes)  ? (xoff_monitor[n_internal_link_out_lane_offset+ii]==0X0) ?  "" : "X" : "-",
	   (ii<n_internal_link_out_lanes)  ? ultostr(data_counter[n_internal_link_out_lane_offset + ii]).c_str() : "-"
	   );
  }
  
}

void 
set_ftkim_parameters(df_ipbus_access_ok& df)
{
  df.set_this_board_mask(0X00000001);
  
  // CLOCK INV for four IM FPGA
  std::map<uint32_t, uint32_t> imfpga2clkinv;
  //                                                (IM FPGA ID, INV)
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         0,   0)); // FTKIM setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         1,   0)); // FTKIM setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         2,   0)); // FTKIM setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         3,   0)); // FTKIM setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         4,   0)); // FTKIM setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         5,   0)); // FTKIM setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         6,   0)); // FTKIM setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         7,   0)); // FTKIM setting
  df.set_imfpga2clkinv(imfpga2clkinv);
  
  // CLOCK DELAY INV for four IM FPGA
  std::map<uint32_t, uint32_t> imfpga2clkdelay;  
  //                                                  (IM FPGA ID, DELAY)
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         0,    16)); // FTKIM setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         1,    16)); // FTKIM setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         2,    12)); // FTKIM setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         3,    12)); // FTKIM setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         4,    19)); // FTKIM setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         5,    19)); // FTKIM setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         6,    18)); // FTKIM setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         7,    18)); // FTKIM setting
  df.set_imfpga2clkdelay(imfpga2clkdelay);
  
  set_transceiver_parameters_test(df);
  set_internal_communication_parameters_test(df);
  
  // INPUT Enable Mask
  uint32_t enable_fmc_lanes_mask = 0X0050; //
  df.set_enable_fmc_lanes_mask(enable_fmc_lanes_mask);
  
  std::map<uint32_t, uint32_t> fmcin2nummodules;
  //                                                   (FMC, #Module)
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  0,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  1,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  2,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  3,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  4,       7)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  5,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  6,       7)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  7,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  8,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  9,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 10,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 11,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 12,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 13,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 14,       0)); // FTKIM setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 15,       0)); // FTKIM setting
  df.set_fmcin2nummodules(fmcin2nummodules);
  
  // LUT configuration
  std::map<std::pair<uint32_t, uint32_t>, uint32_t> lane_mod2idx;
  std::map<std::pair<uint32_t, uint32_t>, uint32_t> lane_idx2mod;
  
  // temporally !! the module list should be made lane-by-lane
  for (int iLane=0; iLane<16; iLane++) {
    //                                                          (( lane,   addr) ,  data)
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0000),      0)); // FTKIM setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      0), 0X0000)); // FTKIM setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0002),      1)); // FTKIM setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      1), 0X0002)); // FTKIM setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0010),      2)); // FTKIM setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      2), 0X0010)); // FTKIM setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0060),      3)); // FTKIM setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      3), 0X0060)); // FTKIM setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0062),      4)); // FTKIM setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      4), 0X0062)); // FTKIM setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0070),      5)); // FTKIM setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      5), 0X0070)); // FTKIM setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0072),      6)); // FTKIM setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      6), 0X0072)); // FTKIM setting // pixel
  }
  df.set_lane_mod2idx(lane_mod2idx);
  df.set_lane_idx2mod(lane_idx2mod);
  
  // only eight module (4 for pixel, 4 for sct) is described here, although we have to configure everything in the final system
  std::map<uint32_t, uint32_t> pixmod2dst;
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X00000001)); // FTKIM setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0002, 0X00000001)); // FTKIM setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0010, 0X00000001)); // FTKIM setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0060, 0X00000001)); // FTKIM setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0062, 0X00000001)); // FTKIM setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0070, 0X00000001)); // FTKIM setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0072, 0X00000001)); // FTKIM setting
  df.set_pixmod2dst(pixmod2dst);
  
  std::map<uint32_t, uint32_t> pixmod2ftkplane;
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X0000000F)); // FTKIM setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0002, 0X0000000F)); // FTKIM setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0010, 0X0000000F)); // FTKIM setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0060, 0X0000000F)); // FTKIM setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0062, 0X0000000F)); // FTKIM setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0070, 0X0000000F)); // FTKIM setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0072, 0X0000000F)); // FTKIM setting
  df.set_pixmod2ftkplane(pixmod2ftkplane);
  
  std::map<uint32_t, uint32_t> pixmod2tower;
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X1)); // FTKIM setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0002, 0X1)); // FTKIM setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0010, 0X1)); // FTKIM setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0060, 0X1)); // FTKIM setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0062, 0X1)); // FTKIM setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0070, 0X1)); // FTKIM setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0072, 0X1)); // FTKIM setting
  df.set_pixmod2tower(pixmod2tower);
  
  std::map<uint32_t, uint32_t> sctmod2dst;
  // sctmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X00000001)); // FTKIM setting
  // sctmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0400, 0X00000001)); // FTKIM setting
  // sctmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0800, 0X00000001)); // FTKIM setting
  // sctmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0C00, 0X00000001)); // FTKIM setting
  df.set_sctmod2dst(sctmod2dst);
  
  std::map<uint32_t, uint32_t> sctmod2ftkplane;
  // sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X0000000C)); // FTKIM setting
  // sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0400, 0X0000000C)); // FTKIM setting
  // sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0800, 0X0000000C)); // FTKIM setting
  // sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0C00, 0X0000000C)); // FTKIM setting
  df.set_sctmod2ftkplane(sctmod2ftkplane);
  
  std::map<uint32_t, uint32_t> sctmod2tower;
  // sctmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X1)); // FTKIM setting
  // sctmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0400, 0X1)); // FTKIM setting
  // sctmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0800, 0X1)); // FTKIM setting
  // sctmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0C00, 0X1)); // FTKIM setting
  df.set_sctmod2tower(sctmod2tower);  
  
  std::map<uint32_t, uint32_t> slinkout2nummodules;
  //                                                      (SLINK, #Module)
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    0,      14)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    1,      14)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    2,      14)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    3,      14)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    4,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    5,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    6,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    7,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    8,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    9,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   10,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   11,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   12,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   13,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   14,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   15,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   16,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   17,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   18,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   19,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   20,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   21,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   22,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   23,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   24,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   25,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   26,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   27,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   28,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   29,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   30,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   31,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   32,       0)); // FTKIM setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   33,       0)); // FTKIM setting
  df.set_slinkout2nummodules(slinkout2nummodules);
}

void set_fnaltm_parameters(df_ipbus_access_ok& df)
{
  df.set_this_board_mask_special_for_test(0X00000001, 
					  0X00000002);
  //df.set_this_board_mask(0X00000001);
  
  // CLOCK INV for four IM FPGA
  std::map<uint32_t, uint32_t> imfpga2clkinv;
  //                                                (IM FPGA ID, INV)
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         0,   1)); // TEST MEZZANINE setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         1,   1)); // TEST MEZZANINE setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         2,   1)); // TEST MEZZANINE setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         3,   1)); // TEST MEZZANINE setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         4,   1)); // TEST MEZZANINE setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         5,   1)); // TEST MEZZANINE setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         6,   1)); // TEST MEZZANINE setting
  imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(         7,   1)); // TEST MEZZANINE setting
  df.set_imfpga2clkinv(imfpga2clkinv);
  
  // CLOCK DELAY INV for four IM FPGA
  std::map<uint32_t, uint32_t> imfpga2clkdelay;  
  //                                                  (IM FPGA ID, DELAY)
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         0,    18)); // TEST MEZZANINE setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         1,    18)); // TEST MEZZANINE setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         2,    12)); // TEST MEZZANINE setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         3,    12)); // TEST MEZZANINE setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         4,    12)); // TEST MEZZANINE setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         5,    12)); // TEST MEZZANINE setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         6,    12)); // TEST MEZZANINE setting
  imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(         7,    12)); // TEST MEZZANINE setting
  df.set_imfpga2clkdelay(imfpga2clkdelay);
  
  set_transceiver_parameters_test(df);
  set_internal_communication_parameters_test(df);
  
  // INPUT Enable Mask
  uint32_t enable_fmc_lanes_mask = 0X0001; //
  df.set_enable_fmc_lanes_mask(enable_fmc_lanes_mask);
  
  std::map<uint32_t, uint32_t> fmcin2nummodules;
  //                                                   (FMC, #Module)
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  0,       8)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  1,       8)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  2,       8)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  3,       8)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  4,       8)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  5,       8)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  6,       8)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  7,       8)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  8,       0)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(  9,       0)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 10,       0)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 11,       0)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 12,       0)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 13,       0)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 14,       0)); // TEST MEZZANINE setting
  fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>( 15,       0)); // TEST MEZZANINE setting
  df.set_fmcin2nummodules(fmcin2nummodules);
  
  // LUT configuration
  std::map<std::pair<uint32_t, uint32_t>, uint32_t> lane_mod2idx;
  std::map<std::pair<uint32_t, uint32_t>, uint32_t> lane_idx2mod;
  
  // temporally !! the module list should be made lane-by-lane
  for (int iLane=0; iLane<16; iLane++) {
    //                                                          (( lane,   addr) ,  data)
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0000),      0)); // TEST MEZZANINE setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      0), 0X0000)); // TEST MEZZANINE setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0100),      1)); // TEST MEZZANINE setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      1), 0X0100)); // TEST MEZZANINE setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0200),      2)); // TEST MEZZANINE setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      2), 0X0200)); // TEST MEZZANINE setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x0300),      3)); // TEST MEZZANINE setting // pixel
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      3), 0X0300)); // TEST MEZZANINE setting // pixel
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x2000),      4)); // TEST MEZZANINE setting // SCT
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      4), 0X2000)); // TEST MEZZANINE setting // SCT
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x2400),      5)); // TEST MEZZANINE setting // SCT
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      5), 0X2400)); // TEST MEZZANINE setting // SCT
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x2800),      6)); // TEST MEZZANINE setting // SCT
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      6), 0X2800)); // TEST MEZZANINE setting // SCT
    
    lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane, 0x2C00),      7)); // TEST MEZZANINE setting // SCT
    lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>(std::pair<uint32_t, uint32_t>(iLane,      7), 0X2C00)); // TEST MEZZANINE setting // SCT
  }
  df.set_lane_mod2idx(lane_mod2idx);
  df.set_lane_idx2mod(lane_idx2mod);
  
  // only eight module (4 for pixel, 4 for sct) is described here, although we have to configure everything in the final system
  std::map<uint32_t, uint32_t> pixmod2dst;
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X00000002)); // TEST MEZZANINE setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0100, 0X00000002)); // TEST MEZZANINE setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0200, 0X00000002)); // TEST MEZZANINE setting
  pixmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0300, 0X00000002)); // TEST MEZZANINE setting
  df.set_pixmod2dst(pixmod2dst);
  
  std::map<uint32_t, uint32_t> pixmod2ftkplane;
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X1FF)); // TEST MEZZANINE setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0100, 0X1FF)); // TEST MEZZANINE setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0200, 0X1FF)); // TEST MEZZANINE setting
  pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0300, 0X1FF)); // TEST MEZZANINE setting
  df.set_pixmod2ftkplane(pixmod2ftkplane);
  
  std::map<uint32_t, uint32_t> pixmod2tower;
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X3)); // TEST MEZZANINE setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0100, 0X3)); // TEST MEZZANINE setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0200, 0X3)); // TEST MEZZANINE setting
  pixmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0300, 0X3)); // TEST MEZZANINE setting
  df.set_pixmod2tower(pixmod2tower);
  
  std::map<uint32_t, uint32_t> sctmod2dst;
  sctmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X00000002)); // TEST MEZZANINE setting
  sctmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0400, 0X00000002)); // TEST MEZZANINE setting
  sctmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0800, 0X00000002)); // TEST MEZZANINE setting
  sctmod2dst.insert(std::pair<uint32_t, uint32_t>(0X0C00, 0X00000002)); // TEST MEZZANINE setting
  df.set_sctmod2dst(sctmod2dst);
  
  std::map<uint32_t, uint32_t> sctmod2ftkplane;
  sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X1FF)); // TEST MEZZANINE setting
  sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0400, 0X1FF)); // TEST MEZZANINE setting
  sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0800, 0X1FF)); // TEST MEZZANINE setting
  sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(0X0C00, 0X1FF)); // TEST MEZZANINE setting
  df.set_sctmod2ftkplane(sctmod2ftkplane);
  
  std::map<uint32_t, uint32_t> sctmod2tower;
  sctmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0000, 0X3)); // TEST MEZZANINE setting
  sctmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0400, 0X3)); // TEST MEZZANINE setting
  sctmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0800, 0X3)); // TEST MEZZANINE setting
  sctmod2tower.insert(std::pair<uint32_t, uint32_t>(0X0C00, 0X3)); // TEST MEZZANINE setting
  df.set_sctmod2tower(sctmod2tower);
  
  std::map<uint32_t, uint32_t> slinkout2nummodules;
  //                                                      (SLINK, #Module)
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    0,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    1,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    2,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    3,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    4,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    5,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    6,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    7,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    8,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(    9,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   10,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   11,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   12,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   13,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   14,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   15,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   16,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   17,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   18,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   19,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   20,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   21,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   22,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   23,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   24,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   25,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   26,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   27,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   28,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   29,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   30,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   31,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   32,       8)); // TEST MEZZANINE setting
  slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(   33,       8)); // TEST MEZZANINE setting
  df.set_slinkout2nummodules(slinkout2nummodules);
}

void set_transceiver_parameters_test(df_ipbus_access_ok& df)
{
  // GT RXPOLARITY
  std::map<uint32_t, uint32_t> gtch2rxpolarity;
  //                                                  (GT ID, RXPOLARITY)
  // 00 - 33 SLINK OUTPUT  < 00 - 33 >
  // 34 - 57 INTERNAL LINK < 34 - 57 >
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    0,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    1,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    2,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    3,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    4,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    5,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    6,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    7,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    8,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(    9,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   10,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   11,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   12,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   13,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   14,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   15,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   16,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   17,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   18,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   19,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   20,          1)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   21,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   22,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   23,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   24,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   25,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   26,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   27,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   28,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   29,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   30,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   31,          1)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   32,          1)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   33,          1)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   34,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   35,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   36,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   37,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   38,          1)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   39,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   40,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   41,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   42,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   43,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   44,          1)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   45,          1)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   46,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   47,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   48,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   49,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   50,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   51,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   52,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   53,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   54,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   55,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   56,          0)); // common setting
  gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(   57,          0)); // common setting
  df.set_gtch2rxpolarity(gtch2rxpolarity);
  
  // GT TXPOLARITY
  std::map<uint32_t, uint32_t> gtch2txpolarity;
  //                                                  (GT ID, TXPOLARITY)
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    0,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    1,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    2,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    3,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    4,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    5,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    6,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    7,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    8,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(    9,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   10,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   11,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   12,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   13,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   14,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   15,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   16,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   17,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   18,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   19,          1)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   20,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   21,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   22,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   23,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   24,          1)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   25,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   26,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   27,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   28,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   29,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   30,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   31,          1)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   32,          1)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   33,          1)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   34,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   35,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   36,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   37,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   38,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   39,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   40,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   41,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   42,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   43,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   44,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   45,          1)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   46,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   47,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   48,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   49,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   50,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   51,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   52,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   53,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   54,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   55,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   56,          0)); // common setting
  gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(   57,          1)); // common setting
  df.set_gtch2txpolarity(gtch2txpolarity);
  
  // GT FORCE_READY_MODE
  std::map<uint32_t, uint32_t> gtch2force_ready_mode;
  //                                                        (GT ID, FORCE_READY_MODE)
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    0,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    1,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    2,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    3,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    4,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    5,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    6,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    7,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    8,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(    9,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   10,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   11,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   12,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   13,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   14,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   15,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   16,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   17,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   18,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   19,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   20,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   21,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   22,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   23,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   24,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   25,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   26,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   27,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   28,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   29,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   30,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   31,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   32,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   33,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   34,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   35,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   36,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   37,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   38,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   39,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   40,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   41,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   42,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   43,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   44,                0)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   45,                0)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   46,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   47,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   48,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   49,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   50,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   51,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   52,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   53,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   54,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   55,                1)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   56,                0)); // common setting
  gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(   57,                0)); // common setting
  df.set_gtch2force_ready_mode(gtch2force_ready_mode);
  
  // TO_ALTERA_FPGA MODE
  std::map<uint32_t, uint32_t> gtch2to_altera_fpga;
  //                                                      (GT ID, TO_ALTERA_FPGA)
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    0,              1)); // common setting 
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    1,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    2,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    3,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    4,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    5,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    6,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    7,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    8,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(    9,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   10,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   11,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   12,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   13,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   14,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   15,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   16,              0)); // common setting 
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   17,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   18,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   19,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   20,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   21,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   22,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   23,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   24,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   25,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   26,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   27,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   28,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   29,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   30,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   31,              1)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   32,              1)); // common setting 
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   33,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   34,              0)); // common setting 
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   35,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   36,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   37,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   38,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   39,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   40,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   41,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   42,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   43,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   44,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   45,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   46,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   47,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   48,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   49,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   50,              0)); // common setting 
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   51,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   52,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   53,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   54,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   55,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   56,              0)); // common setting
  gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(   57,              0)); // common setting
  df.set_gtch2to_altera_fpga(gtch2to_altera_fpga);
}

void set_internal_communication_parameters_test(df_ipbus_access_ok& df) 
{
  std::map<uint32_t, uint32_t> centralswlaneid2destinationmask;
  //                                                                  (lane,   mask) => see "local destination table"
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   0, 0X0000)); // common setting shelf1 slot3
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   1, 0X4000)); // common setting shelf2 slot3
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   2, 0X4000)); // common setting shelf3 slot3
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   3, 0X8000)); // common setting shelf4 slot3
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   4, 0X0001)); // common setting shelf1 slot4
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   5, 0X4000)); // common setting shelf2 slot4
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   6, 0X4000)); // common setting shelf3 slot4
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   7, 0X8000)); // common setting shelf4 slot4
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   8, 0X0100)); // common setting shelf1 slot5
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(   9, 0X4000)); // common setting shelf2 slot5
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  10, 0X4000)); // common setting shelf3 slot5
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  11, 0X8000)); // common setting shelf4 slot5
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  12, 0X0010)); // common setting shelf1 slot6
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  13, 0X4000)); // common setting shelf2 slot6
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  14, 0X4000)); // common setting shelf3 slot6
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  15, 0X8000)); // common setting shelf4 slot6
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  16, 0X1000)); // common setting shelf1 slot7
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  17, 0X4000)); // common setting shelf2 slot7
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  18, 0X8000)); // common setting shelf3 slot7
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  19, 0X8000)); // common setting shelf4 slot7
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  20, 0X0004)); // common setting shelf1 slot8
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  21, 0X4000)); // common setting shelf2 slot8
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  22, 0X8000)); // common setting shelf3 slot8
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  23, 0X8000)); // common setting shelf4 slot8
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  24, 0X0400)); // common setting shelf1 slot9
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  25, 0X4000)); // common setting shelf2 slot9
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  26, 0X8000)); // common setting shelf3 slot9
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  27, 0X8000)); // common setting shelf4 slot9
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  28, 0X0040)); // common setting shelf1 slot10
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  29, 0X4000)); // common setting shelf2 slot10
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  30, 0X8000)); // common setting shelf3 slot10
  centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(  31, 0X8000)); // common setting shelf4 slot10
  df.set_centralswlaneid2destinationmask(centralswlaneid2destinationmask);
}

void 
set_parameters(df_ipbus_access_ok& df,
	       const std::string& configuration_filename
	       )
{
  uint32_t this_board_mask(0X00000001);
  std::map<uint32_t, uint32_t> imfpga2clkinv;
  std::map<uint32_t, uint32_t> imfpga2clkdelay;  
  uint32_t enable_fmc_lanes_mask(0X0001);
  uint32_t this_board_mask_internal_link_input(0XFFFF);
  bool use_different_this_board_mask_for_internal_link_input(false);
  std::map<uint32_t, uint32_t> fmcin2nummodules;    
  std::map<std::pair<uint32_t, uint32_t>, uint32_t> lane_mod2idx;
  std::map<std::pair<uint32_t, uint32_t>, uint32_t> lane_idx2mod;
  std::map<uint32_t, uint32_t> pixmod2dst;
  std::map<uint32_t, uint32_t> pixmod2ftkplane;
  std::map<uint32_t, uint32_t> pixmod2tower;
  std::map<uint32_t, uint32_t> sctmod2dst;
  std::map<uint32_t, uint32_t> sctmod2ftkplane;
  std::map<uint32_t, uint32_t> sctmod2tower;
  std::map<uint32_t, uint32_t> slinkout2nummodules;
  std::map<uint32_t, uint32_t> centralswlaneid2destinationmask;
  
  std::ifstream configuration_file(configuration_filename.c_str());
  if (not (configuration_file.is_open())) {
    fprintf(stderr, "failed in open %s\n", configuration_filename.c_str());
    exit(EXIT_FAILURE);
  }   
  
  std::string       line_str;  
  while (getline(configuration_file, line_str))  {
    std::stringstream line_ss(line_str);
    std::string       c1, c2, c3, c4;
    line_ss >> c1 >> c2 >> c3 >> c4;
    
    if (c1.find("#")!=std::string::npos) {
      continue;
    }
    
    if (c1=="this_board_mask") {
      this_board_mask = strtoul(c2.c_str(), NULL, 0);
    }

    else if (c1=="this_board_mask_internal_link_input") {
      use_different_this_board_mask_for_internal_link_input = true;
      this_board_mask_internal_link_input = strtoul(c2.c_str(), NULL, 0);
    }
    
    else if (c1=="imfpga2clkinv") {
      imfpga2clkinv.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							 strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="imfpga2clkdelay") {
      imfpga2clkdelay.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							   strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="enable_fmc_lanes_mask") {
      enable_fmc_lanes_mask = strtoul(c2.c_str(), NULL, 0);
    }
      
    else if (c1=="fmcin2nummodules") {
      fmcin2nummodules.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							    strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="lane_mod2idx") {
      lane_mod2idx.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>
			  (std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							 strtoul(c3.c_str(), NULL, 0)),
			   strtoul(c4.c_str(), NULL, 0)) 
			  );
    }
      
    else if (c1=="lane_idx2mod") {
      lane_idx2mod.insert(std::pair<std::pair<uint32_t, uint32_t>, uint32_t>
			  (std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							 strtoul(c3.c_str(), NULL, 0)),
			   strtoul(c4.c_str(), NULL, 0)) 
			  );
    }
      
    else if (c1=="pixmod2dst") {
      pixmod2dst.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
						      strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="pixmod2ftkplane") {
      pixmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							   strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="pixmod2tower") {
      pixmod2tower.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="sctmod2dst") {
      sctmod2dst.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
						      strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="sctmod2ftkplane") {
      sctmod2ftkplane.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							   strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="sctmod2tower") {
      sctmod2tower.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							strtoul(c3.c_str(), NULL, 0)));
    }
      
    else if (c1=="slinkout2nummodules") {
      slinkout2nummodules.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							       strtoul(c3.c_str(), NULL, 0)));
    }
    else if (c1=="centralswlaneid2destinationmask") {
      centralswlaneid2destinationmask.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
									   strtoul(c3.c_str(), NULL, 0)));
    }
    else if (c1=="") {
    }
    
    else {
      fprintf(stderr, "undefined name = %s\n", c1.c_str());
      exit(EXIT_FAILURE);
    }
  }
  
  if (use_different_this_board_mask_for_internal_link_input) {
    // special setting for single board testing
    df.set_this_board_mask_special_for_test(this_board_mask, 
					    this_board_mask_internal_link_input);
  }
  else  {
    // default
    df.set_this_board_mask(this_board_mask); 
  }
  df.set_imfpga2clkinv(imfpga2clkinv);
  df.set_imfpga2clkdelay(imfpga2clkdelay);
  df.set_enable_fmc_lanes_mask(enable_fmc_lanes_mask);
  df.set_fmcin2nummodules(fmcin2nummodules);
  df.set_lane_mod2idx(lane_mod2idx);
  df.set_lane_idx2mod(lane_idx2mod);
  df.set_pixmod2dst(pixmod2dst);
  df.set_pixmod2ftkplane(pixmod2ftkplane);
  df.set_pixmod2tower(pixmod2tower);    
  df.set_sctmod2dst(sctmod2dst);
  df.set_sctmod2ftkplane(sctmod2ftkplane);
  df.set_sctmod2tower(sctmod2tower);
  df.set_slinkout2nummodules(slinkout2nummodules);
  df.set_centralswlaneid2destinationmask(centralswlaneid2destinationmask);
}

void 
set_transceiver_parameters(df_ipbus_access_ok& df,
			   const std::string& transceiver_configuration_filename)
{
  std::map<uint32_t, uint32_t> gtch2rxpolarity;
  std::map<uint32_t, uint32_t> gtch2txpolarity;
  std::map<uint32_t, uint32_t> gtch2force_ready_mode;
  std::map<uint32_t, uint32_t> gtch2to_altera_fpga;
  
  std::ifstream transceiver_configuration_file(transceiver_configuration_filename.c_str());
  if (not (transceiver_configuration_file.is_open())) {
    fprintf(stderr, "failed in open %s\n", transceiver_configuration_filename.c_str());
    exit(EXIT_FAILURE);
  }   
  
  std::string       line_str;  
  while (getline(transceiver_configuration_file, line_str))  {
    std::stringstream line_ss(line_str);
    std::string       c1, c2, c3, c4;
    line_ss >> c1 >> c2 >> c3 >> c4;
    
    if (c1.find("#")!=std::string::npos) {
      continue;
    }
    
    if (c1=="gtch2rxpolarity") {
      gtch2rxpolarity.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							   strtoul(c3.c_str(), NULL, 0)));
    } else if (c1=="gtch2txpolarity") {
      gtch2txpolarity.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							   strtoul(c3.c_str(), NULL, 0)));
    } else if (c1=="gtch2force_ready_mode") {
      gtch2force_ready_mode.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
								 strtoul(c3.c_str(), NULL, 0)));
    } else if (c1=="gtch2to_altera_fpga") {
      gtch2to_altera_fpga.insert(std::pair<uint32_t, uint32_t>(strtoul(c2.c_str(), NULL, 0),
							       strtoul(c3.c_str(), NULL, 0)));
    } else if (c1=="") {
    } else {
      fprintf(stderr, "undefined name = %s\n", c1.c_str());
      exit(EXIT_FAILURE);
    }
  }  
  
  df.set_gtch2rxpolarity(gtch2rxpolarity);
  df.set_gtch2txpolarity(gtch2txpolarity);
  df.set_gtch2force_ready_mode(gtch2force_ready_mode);
  df.set_gtch2to_altera_fpga(gtch2to_altera_fpga);
}
