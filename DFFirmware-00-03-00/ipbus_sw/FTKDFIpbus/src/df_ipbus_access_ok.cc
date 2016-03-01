// written by yasuyuki.okumura@cern.ch 

#include <FTKDFIpbus/df_ipbus_access_ok.hh>
#include <stdio.h>

const uint32_t df_ipbus_access_ok::SW_CONF_UPDATE_MASK_FMC_INPUT_NUMBER_OF_EXPECTED_MODULES    = 0X1;
const uint32_t df_ipbus_access_ok::SW_CONF_UPDATE_MASK_SLINK_OUTPUT_NUMBER_OF_EXPECTED_MODULES = 0X2;

const uint32_t df_ipbus_access_ok::m_lut_type_mod2idx = 0;
const uint32_t df_ipbus_access_ok::m_lut_type_idx2mod = 1;
const uint32_t df_ipbus_access_ok::m_lut_type_pixmod2dst = 2;
const uint32_t df_ipbus_access_ok::m_lut_type_sctmod2dst = 3;
const uint32_t df_ipbus_access_ok::m_lut_type_pixmod2ftkplane = 4;
const uint32_t df_ipbus_access_ok::m_lut_type_pixmod2tower = 5;
const uint32_t df_ipbus_access_ok::m_lut_type_sctmod2ftkplane = 6;
const uint32_t df_ipbus_access_ok::m_lut_type_sctmod2tower = 7;

//===============================
df_ipbus_access_ok::df_ipbus_access_ok(const std::string& connection_file, 
				       const std::string& device_id)
  : m_connection_file(connection_file), m_device_id(device_id), m_enable_fmc_lanes_mask(0X0),
    m_timeout_period(100)
{
  connection_inst();
  set_lut_constants();
}

//===============================
void 
df_ipbus_access_ok::connection_inst()
{
  m_manager = new uhal::ConnectionManager( m_connection_file );
  m_hw      = new uhal::HwInterface(m_manager->getDevice(m_device_id));
  m_hw->setTimeoutPeriod(m_timeout_period);
}

//===============================
void
df_ipbus_access_ok::set_timeout_period(const uint32_t& value)
{
  m_timeout_period = value;
  m_hw->setTimeoutPeriod(m_timeout_period);
}

//===============================
void
df_ipbus_access_ok::gtrxtx_reset_begin()
{
  single_access_write("reg.gt_link_controller.transceiver_reset", 0X1);
}

//===============================
void
df_ipbus_access_ok::gtrxtx_reset_end()
{
  single_access_write("reg.gt_link_controller.transceiver_reset", 0X0);
}

//===============================
void
df_ipbus_access_ok::pll_reset_begin()
{
  single_access_write("reg.gt_link_controller.pll_reset", 0X1);
}

//===============================
void
df_ipbus_access_ok::pll_reset_end()
{
  single_access_write("reg.gt_link_controller.pll_reset", 0X0);
}

//===============================
void
df_ipbus_access_ok::standard_reset_configuration()
{  
  pll_reset_begin();
  pll_reset_end();
  gtrxtx_reset_begin();
  gtrxtx_reset_end();
  sleep (1);
  
  single_access_write("reg.reset", 0X0);
  single_access_write("reg.gt_link_controller", 0X0);
  single_access_write("reg.fmc_user_signal", 0X0);
  single_access_write("reg.spy_controller", 0X0);
  
  single_access_write("reg.reset.reset_delay", 0X1);
  single_access_write("reg.reset.disable_fmc_input", 0X1);
  single_access_write("reg.reset.reset_parity_checker", 0X1);
  single_access_write("reg.reset.fmcin_logic_reset", 0X1);
  single_access_write("reg.reset.main_state_machine_reset", 0X1);
  single_access_write("reg.reset.i2c_state_machine_reset", 0X1);
  single_access_write("reg.reset.configurable_parameter_reset", 0X1);
  
  single_access_write("reg.gt_link_controller.slink_reset", 0X1);
  single_access_write("reg.gt_link_controller.slink_ureset", 0X0);
  single_access_write("reg.gt_link_controller.slink_utest", 0X0);
  
  single_access_write("reg.fmc_user_signal.mezzanine_reset", 0X1);
  sleep(0.2);
  single_access_write("reg.fmc_user_signal.mezzanine_trigger", 0X0);
  
  single_access_write("reg.fmc_user_signal.mezzanine_reset", 0X1);
  single_access_write("reg.gt_link_controller.slink_reset", 0X1);
  
  spy_reset();
  single_access_write("reg.fmc_user_signal.mezzanine_reset", 0X0);
  single_access_write("reg.reset.configurable_parameter_reset", 0X0);
  single_access_write("reg.reset.i2c_state_machine_reset", 0X0);
  
  // clock delay setting
  single_access_write("reg.reset.reset_delay", 0X0);
  clock_phase_configuration();
  
  // gt configuration
  gt_configuration();
  
  // configurations
  single_access_write("reg.enable_fmc_lanes_mask", m_enable_fmc_lanes_mask);
  single_access_write("reg.this_board_mask_ido", m_this_board_mask_ido);
  single_access_write("reg.this_board_mask_ili", m_this_board_mask_ili);
  expected_nummodules_information_configuration(); // both FMCIN / SLINKOUT
  
  // lut / internal link switching configuration
  lut_configuration();
  internal_link_mask_configuration();
  
  //  Reset Procedure - Enable FMC input
  single_access_write("reg.reset.disable_fmc_input", 0X0);
  //  Reset Procedure - fmc input state machine reset
  single_access_write("reg.reset.fmcin_logic_reset", 0X0);
  sleep (0.5);
  //  Reset Procedure - release main state machine reset
  single_access_write("reg.reset.main_state_machine_reset", 0X0);
  sleep (0.5);
  //  Reset Procedure - release SLINK
  single_access_write("reg.gt_link_controller.slink_reset", 0X0);
  //  Reset Procedure - release Sync Done
  single_access_write("reg.reset.reset_parity_checker", 0X0);
  
  spy_restart();
  
  uint32_t value_spy_controller(0X0);
  uint32_t value_reset(0X0);
  uint32_t value_fmc_user_signal(0X0);
  uint32_t value_gt_link_controller(0X0);
  
  single_access_read("reg.reset", value_reset);
  single_access_read("reg.gt_link_controller", value_gt_link_controller);
  single_access_read("reg.fmc_user_signal", value_fmc_user_signal);
  single_access_read("reg.spy_controller", value_spy_controller);
  
  single_access_write("reg.reset.counter_parameter_reset", 0X1);
  single_access_write("reg.reset.counter_parameter_reset", 0X0);
  
  printf("after reset reg.reset=0x%08x gt_link_controller=0x%08x fmc_user_signal=0x%08x spy_controller=0x%08x \n",
	 value_reset, value_gt_link_controller, value_fmc_user_signal, value_spy_controller);
  if (not (value_reset==0X0 and 
	   value_gt_link_controller==0X0 and 
	   value_fmc_user_signal==0X0 and 
	   value_spy_controller==0X0) ) {
    printf("[NOTE] : Some of the reset parameter are not released yet\n");
  }  
}

//===============================
void
df_ipbus_access_ok::clock_phase_configuration(const uint32_t& im_fpga_id,
					      const uint32_t& inv_configuration,
					      const uint32_t& delay_configuration)
{
  const uint32_t ce_command   = (0X1 << im_fpga_id);
  const uint32_t ce_disable   = (0X0);
  const uint32_t inv_command_mask  = (0X1 << im_fpga_id);
  const uint32_t address_inv = m_hw->getNode("reg.fmc_config_clk_inv").getAddress();
  m_hw->getClient().write ( address_inv, inv_configuration, inv_command_mask);
  m_hw->dispatch();
  
  for (uint32_t iDelay=0; iDelay<delay_configuration; iDelay++) {
    single_access_write("reg.fmc_config_clkdelay_ce", ce_command);
    single_access_write("reg.fmc_config_clkdelay_ce", ce_disable);
  }
}

//===============================
void
df_ipbus_access_ok::gt_configuration(const uint32_t& gt_id,
				     const uint32_t& gt_rxpolarity,
				     const uint32_t& gt_txpolarity,
				     const uint32_t& force_ready_mode,
				     const uint32_t& to_altera_fpga)
{
  m_hw->getNode("reg.gt_link_monitor_configure_laneselector").write(gt_id);
  m_hw->getNode("reg.gt_link_configuration.gt_rxpolarity").write(gt_rxpolarity);
  m_hw->getNode("reg.gt_link_configuration.gt_txpolarity").write(gt_txpolarity);
  m_hw->getNode("reg.gt_link_configuration.force_ready_mode").write(force_ready_mode);
  m_hw->getNode("reg.gt_link_configuration.to_altera_fpga").write(to_altera_fpga);
  m_hw->dispatch();
  
  single_access_write("reg.gt_link_configuration_wen.wen", 0X1);
  single_access_write("reg.gt_link_configuration_wen.wen", 0X0);
}

//===============================
void
df_ipbus_access_ok::gt_monitor(const uint32_t& gt_id,
			       uint32_t& gt_rxpolarity,
			       uint32_t& gt_txpolarity,
			       uint32_t& force_ready_mode,
			       uint32_t& to_altera_fpga,
			       uint32_t& gt_rxbyteisaligned,
			       uint32_t& gt_tx_reset_done,
			       uint32_t& gt_rx_reset_done,
			       uint32_t& gt_pll_lock,
			       uint32_t& slink_testled_n,
			       uint32_t& slink_lderrled_n,
			       uint32_t& slink_lupled_n,
			       uint32_t& slink_flowctrlled_n,
			       uint32_t& slink_activityled_n,
			       uint32_t& slink_lrl
			       )
{
  single_access_write("reg.gt_link_monitor_configure_laneselector", gt_id);
  uhal::ValWord< uint32_t > mem_gt_rxpolarity=m_hw->getNode("reg.gt_link_configuration_read.gt_rxpolarity").read();
  uhal::ValWord< uint32_t > mem_gt_txpolarity=m_hw->getNode("reg.gt_link_configuration_read.gt_txpolarity").read();
  uhal::ValWord< uint32_t > mem_force_ready_mode=m_hw->getNode("reg.gt_link_configuration_read.force_ready_mode").read();
  uhal::ValWord< uint32_t > mem_to_altera_fpga=m_hw->getNode("reg.gt_link_configuration_read.to_altera_fpga").read();
  
  uhal::ValWord< uint32_t > mem_gt_rxbyteisaligned=m_hw->getNode("reg.gt_link_monitor.gt_rxbyteisaligned").read();
  uhal::ValWord< uint32_t > mem_gt_tx_reset_done=m_hw->getNode("reg.gt_link_monitor.gt_tx_reset_done").read();
  uhal::ValWord< uint32_t > mem_gt_rx_reset_done=m_hw->getNode("reg.gt_link_monitor.gt_rx_reset_done").read();
  uhal::ValWord< uint32_t > mem_gt_pll_lock=m_hw->getNode("reg.gt_link_monitor.gt_pll_lock").read();
  uhal::ValWord< uint32_t > mem_slink_testled_n=m_hw->getNode("reg.gt_link_monitor.slink_testled_n").read();
  uhal::ValWord< uint32_t > mem_slink_lderrled_n=m_hw->getNode("reg.gt_link_monitor.slink_lderrled_n").read();
  uhal::ValWord< uint32_t > mem_slink_lupled_n=m_hw->getNode("reg.gt_link_monitor.slink_lupled_n").read();
  uhal::ValWord< uint32_t > mem_slink_flowctrlled_n=m_hw->getNode("reg.gt_link_monitor.slink_flowctrlled_n").read();
  uhal::ValWord< uint32_t > mem_slink_activityled_n=m_hw->getNode("reg.gt_link_monitor.slink_activityled_n").read();
  uhal::ValWord< uint32_t > mem_slink_lrl=m_hw->getNode("reg.gt_slink_lrl_monitor").read();
  
  m_hw->dispatch();
  
  gt_rxpolarity=mem_gt_rxpolarity.value();
  gt_txpolarity=mem_gt_txpolarity.value();
  gt_pll_lock=mem_gt_pll_lock.value();
  force_ready_mode=mem_force_ready_mode.value();
  to_altera_fpga=mem_to_altera_fpga.value();
  gt_rxbyteisaligned=mem_gt_rxbyteisaligned.value();
  gt_tx_reset_done=mem_gt_tx_reset_done.value();
  gt_rx_reset_done=mem_gt_rx_reset_done.value();
  slink_testled_n=mem_slink_testled_n.value();
  slink_lderrled_n=mem_slink_lderrled_n.value();
  slink_lupled_n=mem_slink_lupled_n.value();
  slink_flowctrlled_n=mem_slink_flowctrlled_n.value();
  slink_activityled_n=mem_slink_activityled_n.value();
  slink_lrl=mem_slink_lrl.value();
}

//==============================
void
df_ipbus_access_ok::expected_nummodules_information_configuration(const uint32_t& lane_id,
								  const uint32_t& update_mask,
								  // type=X01 : input FMC expected number
								  // type=X02 : output SLINK expected number
								  const uint32_t& value)
{
  single_access_write("reg.expected_number_of_module", value);
  single_access_write("reg.switching_configuration_lane_selector", lane_id);
  switch (update_mask) {
  case SW_CONF_UPDATE_MASK_FMC_INPUT_NUMBER_OF_EXPECTED_MODULES:
    single_access_write("reg.update_switching_configuration_enable.fmc_input_number_of_expected_modules",0X1);
    single_access_write("reg.update_switching_configuration_enable.fmc_input_number_of_expected_modules",0X0);
    break;
  case SW_CONF_UPDATE_MASK_SLINK_OUTPUT_NUMBER_OF_EXPECTED_MODULES:
    single_access_write("reg.update_switching_configuration_enable.slink_output_number_of_expected_modules",0X1);
    single_access_write("reg.update_switching_configuration_enable.slink_output_number_of_expected_modules",0X0);
    break;
  default:
    fprintf(stderr, "err> undefined update mask for switching configuration update_mask=0X%08x \n", update_mask);
    single_access_write("reg.update_switching_configuration_enable.slink_output_number_of_expected_modules",0X0);
    break;
  }
}

//==============================
void
df_ipbus_access_ok::internal_link_mask_configuration(const uint32_t& central_switch_output_lane_id,
						     const uint32_t& mask_pattern)
{
  single_access_write("reg.internallink_destination_words", mask_pattern);
  single_access_write("reg.switching_configuration_lane_selector", central_switch_output_lane_id);
  single_access_write("reg.update_switching_configuration_enable.central_switch_output_to_destination_port",0X1);
  single_access_write("reg.update_switching_configuration_enable.central_switch_output_to_destination_port",0X0);
}

//===============================
void
df_ipbus_access_ok::phase_scan(const uint32_t& im_fpga_id)
{
  const uint32_t ce_command   = (0X1 << im_fpga_id);
  const uint32_t ce_disable   = (0X0);
  const uint32_t nInvSettings = 2;
  const uint32_t nDelaySteps  = 32;
  
  single_access_write("reg.reset.reset_delay", 0X1);
  single_access_write("reg.reset.reset_delay", 0X0);  

  for (uint32_t iInvSetting=0; iInvSetting<nInvSettings; iInvSetting++) {
    const uint32_t inv_command = (iInvSetting << im_fpga_id);
    single_access_write("reg.fmc_config_clk_inv", inv_command);
    
    for (uint32_t iDelay=0; iDelay<nDelaySteps; iDelay++) {
      single_access_write("reg.fmc_config_clkdelay_ce", ce_command);
      single_access_write("reg.fmc_config_clkdelay_ce", ce_disable);      
      single_access_write("reg.reset.reset_parity_checker", 0X1);
      single_access_write("reg.reset.reset_parity_checker", 0X0);
      sleep(0.1);
      uint32_t value(0X0);
      
      single_access_read ("reg.fmcin_parity_check_ok", value);
      bool results = ((value & (0X1 << im_fpga_id))==0X0) ? false : true;
      printf("IM_FPGA=%2d : Inv=%1d : ClkDelay=%2d Result=%4s (PARITY_OK=%08x) \n", 
	     im_fpga_id, iInvSetting, iDelay, results ? "GOOD" : "NG", value);
    }
  }
}

//===============================
void
df_ipbus_access_ok::single_access_write(const std::string& node, 
					const uint32_t& write_value)
{
  m_hw->getNode (node).write(write_value);
  m_hw->dispatch(); // send transaction
}
 
//===============================
bool
df_ipbus_access_ok::single_access_write_read(const std::string& node, 
					     const uint32_t& write_value)
{
  m_hw->getNode (node).write(write_value);
  uhal::ValWord< uint32_t > mem = m_hw->getNode (node).read();
  m_hw->dispatch(); // send transaction
  
  if (not mem.valid()) {return false;}
  return (mem.value()==write_value);
}

//===============================
bool
df_ipbus_access_ok::single_access_read(const std::string& node, 
				       uint32_t& read_value)
{
  uhal::ValWord< uint32_t > mem = m_hw->getNode ( node ).read();
  m_hw->dispatch(); // send transaction
  read_value = mem.value();
  return mem.valid();
}

//===============================
void
df_ipbus_access_ok::spy_freeze()
{
  single_access_write("reg.spy_controller.spy_freeze", 0X1);
}

//===============================
void
df_ipbus_access_ok::spy_restart()
{
  single_access_write("reg.spy_controller.spy_freeze", 0X0);
}

//===============================
void
df_ipbus_access_ok::spy_reset()
{
  single_access_write("reg.spy_controller.spy_reset", 0X1);
  single_access_write("reg.spy_controller.spy_reset", 0X0);
}

//===============================
bool
df_ipbus_access_ok::spy_dump_individual_lane(const uint32_t& lane_id,
					     std::vector<uint32_t>& dout)
{
  const uint32_t depth = 4096;
  bool rc = true;
  
  spy_freeze();
  std::vector<uint32_t> dump_data(depth);
  
  single_access_write("reg.spy_laneselector", lane_id);
  
  for (uint32_t iAddr=0; iAddr<depth; iAddr++) {
    single_access_write("reg.spy_readaddr", iAddr);
    uint32_t value(0X0);
    if(not single_access_read("reg.spy_readout", value)) {
      rc = false;
    }
    dump_data[iAddr] = value;
  }
  
  spy_restart();
  dout = dump_data;
  
  return rc;
}

//===============================
bool
df_ipbus_access_ok::read_32bit_counter(const uint32_t& type_id,
				       const uint32_t& lane_id, 
				       uint32_t& dout)
{
  bool rc = true;
  single_access_write("reg.readout_32bit_counter_lane_selector.type", type_id);
  single_access_write("reg.readout_32bit_counter_lane_selector.lane", lane_id);
  
  if(not single_access_read("reg.readout_32bit_counter", dout)) {
    rc = false;
  }
  
  return rc;
}

//==============================
bool
df_ipbus_access_ok::read_lut(const uint32_t& lut_type_id,
			     const uint32_t& lut_addr,
			     const uint32_t& lut_lane_id,
			     uint32_t& lut_data)
{
  bool rc(true);
  
  const uint32_t val_lut_configuration_selector     = (lut_type_id&0X000000FF);
  const uint32_t val_lut_configuration_read_lane    = (lut_lane_id&0X000000FF);
  const uint32_t val_lut_configuration_addr_confin  = (lut_addr&0X0000FFFF);
  const uint32_t val_lut_configuration_wen_distable = 0X0;
  
  single_access_write("reg.lut_configuration_wen_confin", val_lut_configuration_wen_distable);
  m_hw->getNode ("reg.lut_configuration_selector").write(val_lut_configuration_selector);
  m_hw->getNode ("reg.lut_configuration_read_lane").write(val_lut_configuration_read_lane);
  m_hw->getNode ("reg.lut_configuration_addr_confin").write(val_lut_configuration_addr_confin);
  m_hw->dispatch(); // send transaction  
  
  if (not single_access_read("reg.lut_configuration_data_confout", lut_data)) {rc=false;}
  
  return rc;
}

//==============================
void
df_ipbus_access_ok::write_lut(const uint32_t& lut_type_id,
			      const uint32_t& lut_addr,
			      const uint32_t& lut_data,
			      const uint32_t& lut_lane_enable_mask)
{
  const uint32_t val_lut_configuration_selector     = (lut_type_id&0X000000FF);
  const uint32_t val_lut_configuration_addr_confin  = (lut_addr&0X0000FFFF);
  const uint32_t val_lut_configuration_data_confin  = (lut_data&0XFFFFFFFF);
  const uint32_t val_lut_configuration_wen_distable = 0X0;
  
  single_access_write("reg.lut_configuration_wen_confin", val_lut_configuration_wen_distable);
  m_hw->getNode ("reg.lut_configuration_selector").write(val_lut_configuration_selector);
  m_hw->getNode ("reg.lut_configuration_addr_confin").write(val_lut_configuration_addr_confin);
  m_hw->getNode ("reg.lut_configuration_data_confin").write(val_lut_configuration_data_confin);
  m_hw->dispatch(); // send transaction
  single_access_write("reg.lut_configuration_wen_confin", lut_lane_enable_mask);
  single_access_write("reg.lut_configuration_wen_confin", val_lut_configuration_wen_distable);
}

//==============================
void
df_ipbus_access_ok::write_lut(const uint32_t& lut_addr,
			      const uint32_t& lut_data,
			      const uint32_t& lut_lane_enable_mask)
{
  const uint32_t val_lut_configuration_addr_confin  = (lut_addr&0X0000FFFF);
  const uint32_t val_lut_configuration_data_confin  = (lut_data&0XFFFFFFFF);
  const uint32_t val_lut_configuration_wen_distable = 0X0;
  
  single_access_write("reg.lut_configuration_wen_confin", val_lut_configuration_wen_distable);
  m_hw->getNode ("reg.lut_configuration_addr_confin").write(val_lut_configuration_addr_confin);
  m_hw->getNode ("reg.lut_configuration_data_confin").write(val_lut_configuration_data_confin);
  m_hw->dispatch(); // send transaction
  single_access_write("reg.lut_configuration_wen_confin", lut_lane_enable_mask);
  single_access_write("reg.lut_configuration_wen_confin", val_lut_configuration_wen_distable);
}

//==============================
bool
df_ipbus_access_ok::dump_lut(const uint32_t& lut_type_id,
			     const uint32_t& lut_lane_id,
			     std::vector<uint32_t>& dout)
{
  bool rc(true);
  
  const uint32_t addr_max = (*m_addr_max)[lut_type_id];
  std::vector<uint32_t> dump_data(addr_max);
  
  for (uint32_t iAddr=0; iAddr<addr_max; iAddr++) {
    uint32_t lut_data(0X0);
    read_lut(lut_type_id, iAddr, lut_lane_id, lut_data);
    dump_data[iAddr] = lut_data;
  }
  
  dout = dump_data;
  return rc;
}

//==============================
bool
df_ipbus_access_ok::i2c_single_access_write(const uint32_t& i2c_addr,
					    const uint32_t& value)
{
  const uint32_t addr_7bit = (i2c_addr& (m_hw->getNode("reg.fb_i2c_address.address").getMask()) );
  m_hw->getNode("reg.fb_i2c_address.address").write(addr_7bit);
  m_hw->getNode("reg.fb_i2c_address.is_read_access").write(0X0);
  m_hw->getNode("reg.fb_i2c_data_from_master").write(value);
  m_hw->dispatch(); // send transaction
  single_access_write("reg.fb_i2c_enable.enable", 0X1);
  single_access_write("reg.fb_i2c_enable.enable", 0X0);
  
  uhal::ValWord< uint32_t > busy     = m_hw->getNode ("reg.fb_i2c_status.busy").read();
  uhal::ValWord< uint32_t > ackerror = m_hw->getNode ("reg.fb_i2c_status.ack_error").read();
  m_hw->dispatch(); // send transaction
  
  const uint32_t timeout = 100;
  uint32_t trial = 0;
  if ( busy.value()==0X0 and ackerror.value()==0X0 ) {return true;}
  while ( not (busy.value()==0X0 and ackerror.value()==0X0)) {
    busy     = m_hw->getNode ("reg.fb_i2c_status.busy").read();
    ackerror = m_hw->getNode ("reg.fb_i2c_status.ack_error").read();
    m_hw->dispatch(); // send transaction
    trial++;
    if (trial>timeout) {return false;}
  }
  return true;
}

//==============================
bool
df_ipbus_access_ok::i2c_single_access_read(const uint32_t& i2c_addr,
					   uint32_t& value)
{
  const uint32_t addr_7bit = (i2c_addr& (m_hw->getNode("reg.fb_i2c_address.address").getMask()) );
  m_hw->getNode("reg.fb_i2c_address.address").write(addr_7bit);
  m_hw->getNode("reg.fb_i2c_address.is_read_access").write(0X1);
  m_hw->dispatch(); // send transaction
  single_access_write("reg.fb_i2c_enable.enable", 0X1);
  single_access_write("reg.fb_i2c_enable.enable", 0X0);
  single_access_read("reg.fb_i2c_data_from_slave", value);
  
  uhal::ValWord< uint32_t > busy     = m_hw->getNode ("reg.fb_i2c_status.busy").read();
  uhal::ValWord< uint32_t > ackerror = m_hw->getNode ("reg.fb_i2c_status.ack_error").read();
  m_hw->dispatch(); // send transaction
  
  const uint32_t timeout = 100;
  uint32_t trial = 0;
  if ( busy.value()==0X0 and ackerror.value()==0X0 ) {return true;}
  while ( not (busy.value()==0X0 and ackerror.value()==0X0)) {
    busy     = m_hw->getNode ("reg.fb_i2c_status.busy").read();
    ackerror = m_hw->getNode ("reg.fb_i2c_status.ack_error").read();
    m_hw->dispatch(); // send transaction
    trial++;
    if (trial>timeout) {return false;}
  }
  return true;  
}

//==============================
void
df_ipbus_access_ok::set_lut_constants()
{
  const uint32_t nTypeLUT = 8;
  
  m_addr_width = new std::vector<uint32_t> (nTypeLUT);
  (*m_addr_width)[0]=14;
  (*m_addr_width)[1]=9;
  (*m_addr_width)[2]=11;
  (*m_addr_width)[3]=13;
  (*m_addr_width)[4]=11;
  (*m_addr_width)[5]=11;
  (*m_addr_width)[6]=13;
  (*m_addr_width)[7]=13;
  
  m_addr_max = new std::vector<uint32_t> (nTypeLUT);
  for (uint32_t iType=0; iType<nTypeLUT; iType++) {
    (*m_addr_max)[iType] = (0X1 << ((*m_addr_width)[iType]) );
  }
}

//==============================
void
df_ipbus_access_ok::clock_phase_configuration()
{
  std::map<uint32_t, uint32_t>::const_iterator       itc=m_imfpga2clkdelay.begin();
  const std::map<uint32_t, uint32_t>::const_iterator ite=m_imfpga2clkdelay.end();
  
  for (; itc!=ite; itc++) {
    const uint32_t& imfpga_id = itc->first;
    const uint32_t& clkdelay  = itc->second;
    if (m_imfpga2clkinv.find(imfpga_id)==m_imfpga2clkinv.end()) {
      fprintf(stderr, "err> m_imfpga2clkinv does not have imfpga_id=%d. check. \n", imfpga_id);
    }
    const uint32_t& clkinv = m_imfpga2clkinv[imfpga_id];
    clock_phase_configuration(imfpga_id, clkinv, clkdelay);
  }
}

//==============================
void
df_ipbus_access_ok::gt_configuration()
{
  std::map<uint32_t, uint32_t>::const_iterator       itc=m_gtch2rxpolarity.begin();
  const std::map<uint32_t, uint32_t>::const_iterator ite=m_gtch2rxpolarity.end();
  
  for (; itc!=ite; itc++) {
    const uint32_t& gtch_id       = itc->first;
    if ((m_gtch2txpolarity.find(gtch_id)==m_gtch2txpolarity.end()) or
	(m_gtch2force_ready_mode.find(gtch_id)==m_gtch2force_ready_mode.end()) or
	(m_gtch2to_altera_fpga.find(gtch_id)==m_gtch2to_altera_fpga.end())
	) {
      fprintf(stderr, "err> check gt_id=%d has set of parameters properly \n", gtch_id);
    }
    
    const uint32_t& gt_rxpolarity = itc->second;
    const uint32_t& gt_txpolarity = m_gtch2txpolarity[gtch_id];
    const uint32_t& force_ready_mode = m_gtch2force_ready_mode[gtch_id];
    const uint32_t& to_altera_fpga = m_gtch2to_altera_fpga[gtch_id];
    
    gt_configuration(gtch_id, gt_rxpolarity, gt_txpolarity, force_ready_mode, to_altera_fpga);
  }
}

//==============================
void
df_ipbus_access_ok::internal_link_mask_configuration()
{
  std::map<uint32_t, uint32_t>::const_iterator       itc=m_centralswlaneid2destinationmask.begin();
  const std::map<uint32_t, uint32_t>::const_iterator ite=m_centralswlaneid2destinationmask.end();
  
  for (; itc!=ite; itc++) {
    const uint32_t& lane_id  = itc->first;
    const uint32_t& internallink_destination_mask = itc->second;
    internal_link_mask_configuration(lane_id,
				     internallink_destination_mask);
  }
}

//==============================
void
df_ipbus_access_ok::expected_nummodules_information_configuration()
{
  std::map<uint32_t, uint32_t>::const_iterator itc1       = m_fmcin2nummodules.begin();
  const std::map<uint32_t, uint32_t>::const_iterator ite1 = m_fmcin2nummodules.end();
  
  for (; itc1!=ite1; itc1++) {
    const uint32_t& lane_id = itc1->first;
    const uint32_t& value   = itc1->second;
    expected_nummodules_information_configuration(lane_id,
						  SW_CONF_UPDATE_MASK_FMC_INPUT_NUMBER_OF_EXPECTED_MODULES,
						  value);
  }
  
  std::map<uint32_t, uint32_t>::const_iterator itc2       = m_slinkout2nummodules.begin();
  const std::map<uint32_t, uint32_t>::const_iterator ite2 = m_slinkout2nummodules.end();
  
  for (; itc2!=ite2; itc2++) {
    const uint32_t& lane_id = itc2->first;
    const uint32_t& value   = itc2->second;
    expected_nummodules_information_configuration(lane_id,
						  SW_CONF_UPDATE_MASK_SLINK_OUTPUT_NUMBER_OF_EXPECTED_MODULES,
						  value);
  }
}

//==============================
void
df_ipbus_access_ok::lut_configuration()
{
  // mod2idx
  single_access_write("reg.lut_configuration_selector", (0XFF&m_lut_type_mod2idx));
  std::map<std::pair<uint32_t, uint32_t>, uint32_t>::const_iterator itc1 = m_lane_mod2idx.begin();
  std::map<std::pair<uint32_t, uint32_t>, uint32_t>::const_iterator ite1 = m_lane_mod2idx.end();
  for (; itc1!=ite1; itc1++) {
    const uint32_t& lane_id  = itc1->first.first;
    const uint32_t lane_mask = (0X1 << lane_id);
    write_lut(itc1->first.second,
	      itc1->second,
	      lane_mask);
  }
  
  // idx2mod
  single_access_write("reg.lut_configuration_selector", (0XFF&m_lut_type_idx2mod));
  itc1 = m_lane_idx2mod.begin();
  ite1 = m_lane_idx2mod.end();
  for (; itc1!=ite1; itc1++) {
    const uint32_t& lane_id  = itc1->first.first;
    const uint32_t lane_mask = (0X1 << lane_id);
    write_lut(itc1->first.second,
	      itc1->second,
	      lane_mask);
  }
  
  // pixmod2dst
  single_access_write("reg.lut_configuration_selector", (0XFF&m_lut_type_pixmod2dst));
  std::map<uint32_t, uint32_t>::const_iterator itc2 = m_pixmod2dst.begin();
  std::map<uint32_t, uint32_t>::const_iterator ite2 = m_pixmod2dst.end();
  for (; itc2!=ite2; itc2++) {
    const uint32_t lane_mask = 0X0000FFFF;
    write_lut(itc2->first,
	      itc2->second,
	      lane_mask);
  }
  
  // sctmod2dst
  single_access_write("reg.lut_configuration_selector", (0XFF&m_lut_type_sctmod2dst));
  itc2 = m_sctmod2dst.begin();
  ite2 = m_sctmod2dst.end();
  for (; itc2!=ite2; itc2++) {
    const uint32_t lane_mask = 0X0000FFFF;
    write_lut(itc2->first,
	      itc2->second,
	      lane_mask);
  }
  
  // pixmod2tower
  single_access_write("reg.lut_configuration_selector", (0XFF&m_lut_type_pixmod2tower));
  itc2 = m_pixmod2tower.begin();
  ite2 = m_pixmod2tower.end();
  for (; itc2!=ite2; itc2++) {
    const uint32_t lane_mask = 0XFFFFFFFF;
    write_lut(itc2->first,
	      itc2->second,
	      lane_mask);
  }
  
  // sctmod2tower
  single_access_write("reg.lut_configuration_selector", (0XFF&m_lut_type_sctmod2tower));
  itc2 = m_sctmod2tower.begin();
  ite2 = m_sctmod2tower.end();
  for (; itc2!=ite2; itc2++) {
    const uint32_t lane_mask = 0XFFFFFFFF;
    write_lut(itc2->first,
	      itc2->second,
	      lane_mask);
  }
  
  // pixmod2ftkplane
  single_access_write("reg.lut_configuration_selector", (0XFF&m_lut_type_pixmod2ftkplane));
  itc2 = m_pixmod2ftkplane.begin();
  ite2 = m_pixmod2ftkplane.end();
  for (; itc2!=ite2; itc2++) {
    const uint32_t lane_mask = 0XFFFFFFFF;
    write_lut(itc2->first,
	      itc2->second,
	      lane_mask);
  }
  
  // sctmod2ftkplane
  single_access_write("reg.lut_configuration_selector", (0XFF&m_lut_type_sctmod2ftkplane));
  itc2 = m_sctmod2ftkplane.begin();
  ite2 = m_sctmod2ftkplane.end();
  for (; itc2!=ite2; itc2++) {
    const uint32_t lane_mask = 0XFFFFFFFF;
    write_lut(itc2->first,
	      itc2->second,
	      lane_mask);
  }
  
}
