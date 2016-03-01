// written by yasuyuki.okumura@cern.ch 

#ifndef __DF_IPBUS_ACCESS_OK_HH__
#define __DF_IPBUS_ACCESS_OK_HH__

#include "uhal/uhal.hpp"
#include "uhal/ClientFactory.hpp"
#include <string>
#include <stdint.h>
#include <vector>
#include <map>

class df_ipbus_access_ok {
public:
  df_ipbus_access_ok(const std::string& connection_file, 
		     const std::string& device_id);
  ~df_ipbus_access_ok(){};
  
private:
  uhal::ConnectionManager* m_manager;
  uhal::HwInterface*       m_hw;
  const std::string m_connection_file; 
  const std::string m_device_id;
  void connection_inst();
  void set_lut_constants();
  std::vector<uint32_t>* m_addr_width;
  std::vector<uint32_t>* m_addr_max;
  uint32_t m_timeout_period;
  
public:
  uhal::HwInterface* get_hardware(){return m_hw;};
  std::string get_uri(){return m_hw->uri();};
  std::string get_connection_file(){return m_connection_file; };
  std::string get_device_id(){return m_device_id;};
  void set_timeout_period(const uint32_t& value);
  uint32_t get_timeout_period(){return m_timeout_period;};
  
  void standard_reset_configuration();
  void clock_phase_configuration(const uint32_t& im_fpga_id,
				 const uint32_t& inv_configuration,
				 const uint32_t& delay_configuration);
  void expected_nummodules_information_configuration(const uint32_t& lane_id,
						     const uint32_t& update_mask,
						     const uint32_t& value);
  void gt_configuration(const uint32_t& gt_id,
			const uint32_t& rxpolarity,
			const uint32_t& txpolarity,
			const uint32_t& force_ready_mode,
			const uint32_t& to_altera_fpga);
  void gt_monitor(const uint32_t& gt_id,
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
		  );
  void phase_scan(const uint32_t& im_fpga_id);
  void gtrxtx_reset_begin();
  void gtrxtx_reset_end();
  void pll_reset_begin();
  void pll_reset_end();
  void single_access_write(const std::string& node, 
			   const uint32_t& write_value);
  bool single_access_write_read(const std::string& node, 
				const uint32_t& write_value);
  bool single_access_read(const std::string& node, 
			  uint32_t& read_value);
  void spy_reset();
  void spy_restart();
  void spy_freeze();
  bool spy_dump_individual_lane(const uint32_t& lane_id, std::vector<uint32_t>& dout);
  bool read_32bit_counter(const uint32_t& type_id, const uint32_t& lane_id, uint32_t& dout);
  void write_lut(const uint32_t& lut_type_id,
		 const uint32_t& lut_addr,
		 const uint32_t& lut_data,
		 const uint32_t& lut_lane_enable_mask);
  bool read_lut(const uint32_t& lut_type_id,
		const uint32_t& lut_addr,
		const uint32_t& lut_lane_id,
		uint32_t& lut_data);
  bool dump_lut(const uint32_t& lut_type_id,
		const uint32_t& lut_lane_id,
		std::vector<uint32_t>& dout);
  bool i2c_single_access_write(const uint32_t& i2c_addr,
			       const uint32_t& value);
  bool i2c_single_access_read(const uint32_t& i2c_addr,
			      uint32_t& value);
  
  // for configuration
  void set_imfpga2clkinv(const std::map<uint32_t, uint32_t>& _imfpga2clkinv_) {m_imfpga2clkinv=_imfpga2clkinv_;}
  void set_imfpga2clkdelay(const std::map<uint32_t, uint32_t>& _imfpga2clkdelay_) {m_imfpga2clkdelay=_imfpga2clkdelay_;}
  void set_gtch2rxpolarity(const std::map<uint32_t, uint32_t>& _gtch2rxpolarity_) {m_gtch2rxpolarity=_gtch2rxpolarity_;}
  void set_gtch2txpolarity(const std::map<uint32_t, uint32_t>& _gtch2txpolarity_) {m_gtch2txpolarity=_gtch2txpolarity_;}
  void set_gtch2force_ready_mode(const std::map<uint32_t, uint32_t>& _gtch2force_ready_mode_) {m_gtch2force_ready_mode=_gtch2force_ready_mode_;}
  void set_gtch2to_altera_fpga(const std::map<uint32_t, uint32_t>& _gtch2to_altera_fpga_) {m_gtch2to_altera_fpga=_gtch2to_altera_fpga_;}
  void set_enable_fmc_lanes_mask(const uint32_t& _enable_fmc_lanes_mask_) 
  {m_enable_fmc_lanes_mask=_enable_fmc_lanes_mask_;}
  void set_this_board_mask_special_for_test(const uint32_t& _this_board_mask_ido_, 
					    const uint32_t& _this_board_mask_ili_) {
    m_this_board_mask_ido=_this_board_mask_ido_;
    m_this_board_mask_ili=_this_board_mask_ili_;}
  void set_this_board_mask(const uint32_t& _this_board_mask_) {
    m_this_board_mask_ido=_this_board_mask_;
    m_this_board_mask_ili=_this_board_mask_;}
  void set_fmcin2nummodules(const std::map<uint32_t, uint32_t>& _fmcin2nummodules_) 
  {m_fmcin2nummodules=_fmcin2nummodules_;}
  void set_slinkout2nummodules(const std::map<uint32_t, uint32_t>& _slinkout2nummodules_) 
  {m_slinkout2nummodules=_slinkout2nummodules_;}
  void set_centralswlaneid2destinationmask(const std::map<uint32_t, uint32_t>& _centralswlaneid2destinationmask_)
  {m_centralswlaneid2destinationmask=_centralswlaneid2destinationmask_;}
  
  void set_lane_mod2idx(std::map<std::pair<uint32_t, uint32_t>, uint32_t> _lane_mod2idx_)
  {m_lane_mod2idx=_lane_mod2idx_;}
  void set_lane_idx2mod(std::map<std::pair<uint32_t, uint32_t>, uint32_t> _lane_idx2mod_)
  {m_lane_idx2mod=_lane_idx2mod_;}
  void set_pixmod2dst(std::map<uint32_t, uint32_t> _pixmod2dst_){m_pixmod2dst=_pixmod2dst_;}
  void set_sctmod2dst(std::map<uint32_t, uint32_t> _sctmod2dst_){m_sctmod2dst=_sctmod2dst_;}
  void set_pixmod2tower(std::map<uint32_t, uint32_t> _pixmod2tower_){m_pixmod2tower=_pixmod2tower_;}
  void set_sctmod2tower(std::map<uint32_t, uint32_t> _sctmod2tower_){m_sctmod2tower=_sctmod2tower_;}
  void set_pixmod2ftkplane(std::map<uint32_t, uint32_t> _pixmod2ftkplane_){m_pixmod2ftkplane=_pixmod2ftkplane_;}
  void set_sctmod2ftkplane(std::map<uint32_t, uint32_t> _sctmod2ftkplane_){m_sctmod2ftkplane=_sctmod2ftkplane_;}
  
private:
  void clock_phase_configuration();
  std::map<uint32_t, uint32_t> m_imfpga2clkinv;
  std::map<uint32_t, uint32_t> m_imfpga2clkdelay;
  void gt_configuration();
  std::map<uint32_t, uint32_t> m_gtch2rxpolarity;
  std::map<uint32_t, uint32_t> m_gtch2txpolarity;
  std::map<uint32_t, uint32_t> m_gtch2force_ready_mode;
  std::map<uint32_t, uint32_t> m_gtch2to_altera_fpga;
  uint32_t m_enable_fmc_lanes_mask;
  uint32_t m_this_board_mask_ido;
  uint32_t m_this_board_mask_ili;
  void expected_nummodules_information_configuration();
  std::map<uint32_t, uint32_t> m_fmcin2nummodules;
  std::map<uint32_t, uint32_t> m_slinkout2nummodules;
  static const uint32_t SW_CONF_UPDATE_MASK_FMC_INPUT_NUMBER_OF_EXPECTED_MODULES;
  static const uint32_t SW_CONF_UPDATE_MASK_SLINK_OUTPUT_NUMBER_OF_EXPECTED_MODULES;
  void internal_link_mask_configuration(const uint32_t& central_switch_output_lane_id,
					const uint32_t& mask_pattern);
  void internal_link_mask_configuration();
  
  std::map<std::pair<uint32_t, uint32_t>, uint32_t> m_lane_mod2idx;
  std::map<std::pair<uint32_t, uint32_t>, uint32_t> m_lane_idx2mod;
  std::map<uint32_t, uint32_t> m_pixmod2dst;
  std::map<uint32_t, uint32_t> m_sctmod2dst;
  std::map<uint32_t, uint32_t> m_pixmod2tower;
  std::map<uint32_t, uint32_t> m_sctmod2tower;
  std::map<uint32_t, uint32_t> m_pixmod2ftkplane;
  std::map<uint32_t, uint32_t> m_sctmod2ftkplane;
  
  std::map<uint32_t, uint32_t> m_centralswlaneid2destinationmask;
  
  void write_lut(const uint32_t& lut_addr,
		 const uint32_t& lut_data,
		 const uint32_t& lut_lane_enable_mask);
  void lut_configuration();  
  static const uint32_t m_lut_type_mod2idx;
  static const uint32_t m_lut_type_idx2mod;
  static const uint32_t m_lut_type_pixmod2dst;
  static const uint32_t m_lut_type_sctmod2dst;
  static const uint32_t m_lut_type_pixmod2tower;
  static const uint32_t m_lut_type_sctmod2tower;
  static const uint32_t m_lut_type_pixmod2ftkplane;
  static const uint32_t m_lut_type_sctmod2ftkplane;
};

#endif
