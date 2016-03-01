# NOTE : 
#    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_switch/df_switch_element_1ch_in.vhd
#    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_switch/df_switch_element_v2.vhd

# version without "short_fwft_fifo" (instead fifo_cc_w36_d512 is used) 
# compiling issue should be solved (2014.05.26)
#    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_switch/df_switch_element.vhd

# remove the event ID check in order to extend the size of buffer
# /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_switch/df_switch_2ch_merger_v2.vhd

read_vhdl {
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/clk_wiz_v3_6.vhd          
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/clock_div.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/clocks_7s_serdes.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/eth_7s_1000basex_new.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/emac_hostbus_decl.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_package.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_trans_decl.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_addr_decode.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_ctrlreg.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_register_interface.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_ctrl.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_peephole_ram.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_pkt_ctr.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_ram.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/ipbus_reg.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/stretcher.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/transactor_cfg.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/transactor_if.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/transactor_sm.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/transactor.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/trans_arb.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_buffer_selector.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_build_arp.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_build_payload.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_build_ping.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_build_resend.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_build_status.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_byte_sum.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_clock_crossing_if.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_do_rx_reset.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_dualportram_rx.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_dualportram_tx.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_dualportram.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_if_flat.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_ipaddr_block.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_packet_parser.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_rarp_block.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_rxram_mux.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_rxram_shim.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_rxtransactor_if_simple.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_status_buffer.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_tx_mux.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2b_ipbus/vhd/udp_txtransactor_if_simple.vhd

    


    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/data_formatter_constants.vhd
    
    fmcLib.vhd.im
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/FMC_RX_CLOCK.BUFMR.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/variable_delay_fmc.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_rx_front.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_ic_w36_d512/fwft_ic_w36_d512_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_ic_w36_d512_f256/fwft_ic_w36_d512_f256_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_rx_frame.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_rx_mapper_fpga_to_detword.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_rx_parity.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_rx_interface.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_rx_mapper_fmc_to_fpga.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_tx_interface.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_tx_clockfoward.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_tx_mapper_fmc_to_fpga.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_fifo_w36_d1024_fwft/pulsar2_fifo_w36_d1024_fwft_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/fmc_input_buffer/fmc_input_buffer.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_fmc_interface/fmc_rx_data_checker.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/df_fmc_interface.vhd

    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_decoder/add_df_internalframe.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_decoder/df_input_handler.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_pixmod2dest/input_pixmod2dest_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_sctmod2dest/input_sctmod2dest_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_mod2idx/input_mod2idx_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_idx2mod/input_idx2mod_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_switch/df_switch_element_v3.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_cc_w36_d512/fwft_cc_w36_d512_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/df_input_data_operator.vhd

    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2ftkplane/output_pixmod2ftkplane_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2tower/output_pixmod2tower_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2ftkplane/output_sctmod2ftkplane_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2tower/output_sctmod2tower_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2duplication/output_pixmod2duplication_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2duplication/output_sctmod2duplication_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_decoder/df_output_preparation_v2.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_decoder/df_output_duplicator.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_switch/df_switch_2ch_merger_v2.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_switch/df_switch_matrix_32x32.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_decoder/df_eventid_comparator.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_decoder/df_output_slink_packer_v2.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/event_sorting_buffer/event_sorting_buffer_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/df_output_data_operator_v2.vhd

    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/prbs/user_logic_prbs.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/prbs/prbs_any.vhd    

    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/slink32handler/LSC/core_holalsc.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/slink32handler/LSC/holalsc_gtx.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/slink32handler/LSC/core_holalscLib.vhd
    
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/slink32handler/TLK_GT_Interface/tlk_gtx_interface.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/slink32handler/TLK_GT_Interface/tlk_gtx_interfaceLib.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/XFIFOLSC/XFIFOLSC_my_wrapper.vhd
    
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l/example_design/gt64_rtm34l_rx_startup_fsm.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l/example_design/gt64_rtm34l_sync_block.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l/example_design/gt64_rtm34l_tx_startup_fsm.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l_example/gt64_rtm34l_example.srcs/sources_1/imports/example_design/support/gt64_rtm34l_common.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l_example/gt64_rtm34l_example.srcs/sources_1/imports/example_design/support/gt64_rtm34l_common_reset.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l_example/gt64_rtm34l_example.srcs/sources_1/imports/example_design/support/gt64_rtm34l_gt_usrclk_source.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l_example/gt64_rtm34l_example.srcs/sources_1/imports/example_design/support/gt64_rtm34l_support.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l_gt.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l_init.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l/gt64_rtm34l_multi_gt.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm34l_interface.vhd    
    
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r/example_design/gt64_rtm6r_rx_startup_fsm.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r/example_design/gt64_rtm6r_sync_block.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r/example_design/gt64_rtm6r_tx_startup_fsm.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r_example/gt64_rtm6r_example.srcs/sources_1/imports/example_design/support/gt64_rtm6r_common.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r_example/gt64_rtm6r_example.srcs/sources_1/imports/example_design/support/gt64_rtm6r_common_reset.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r_example/gt64_rtm6r_example.srcs/sources_1/imports/example_design/support/gt64_rtm6r_gt_usrclk_source.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r_example/gt64_rtm6r_example.srcs/sources_1/imports/example_design/support/gt64_rtm6r_support.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r_gt.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r_init.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r/gt64_rtm6r_multi_gt.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt64_rtm6r_interface.vhd
    
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20/example_design/gt625_fab20_rx_startup_fsm.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20/example_design/gt625_fab20_sync_block.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20/example_design/gt625_fab20_tx_startup_fsm.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20_example/gt625_fab20_example.srcs/sources_1/imports/example_design/support/gt625_fab20_common.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20_example/gt625_fab20_example.srcs/sources_1/imports/example_design/support/gt625_fab20_common_reset.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20_example/gt625_fab20_example.srcs/sources_1/imports/example_design/support/gt625_fab20_gt_usrclk_source.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20_example/gt625_fab20_example.srcs/sources_1/imports/example_design/support/gt625_fab20_support.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20_gt.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20_init.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20/gt625_fab20_multi_gt.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/xcvr_core/2b/gt625_fab20_interface.vhd    
    
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/df_transceiver.vhd
    
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_switch/df_switch_element_1ch_in.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_cc_w36_d512_for_ilrx/fwft_cc_w36_d512_for_ilrx_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/df_internallink_input.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_decoder/remove_df_internallink_destination_word.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_decoder/add_df_internallink_destination_word.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/df_internallink_output.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/data_formatter_top/df_main.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_link/ilink_interface.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_link/pattern_chk.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/pulsar2_df_internal_link/pattern_gen.vhd

    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/i2c_interface/i2c_master.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/my_pulse_generator.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/my_readonly_register.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/my_writable_register.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/spy_buffer_core/GrayCounter.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/spy_buffer_core/spybufferlib.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/spy_buffer_core/spy_buffer_core_d4096.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/spy_buffer_multilanes_d4096_multi_clock_domain.vhd    
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_simple_dpram_w36_d4096/pulsar2_simple_dpram_w36_d4096_my_wrapper.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/spy_buffer_core/spy_buffer_core_d1024.vhd
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/my_registers/spy_buffer_multilanes_d1024_multi_clock_domain.vhd    
    /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_simple_dpram_w36_d1024/pulsar2_simple_dpram_w36_d1024_my_wrapper.vhd
    
    user_interface_df_top.vhd
    
    df_top.vhd
}

import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_sysclk_125/pulsar2_sysclk_125.xci
#import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_sysclk_100/pulsar2_sysclk_100.xci
#import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_sysclk/pulsar2_sysclk.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/short_fwft_fifo_d32_w32/short_fwft_fifo_d32_w32.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/short_fwft_fifo_d64_w32/short_fwft_fifo_d64_w32.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_ic_w36_d512_f256/fwft_ic_w36_d512_f256.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_ic_w36_d512/fwft_ic_w36_d512.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_fifo_w36_d1024_fwft/pulsar2_fifo_w36_d1024_fwft.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_pixmod2dest/input_pixmod2dest.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_sctmod2dest/input_sctmod2dest.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_mod2idx/input_mod2idx.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_idx2mod/input_idx2mod.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_cc_w36_d512/fwft_cc_w36_d512.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_cc_w36_d512_for_ilrx/fwft_cc_w36_d512_for_ilrx.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2ftkplane/output_pixmod2ftkplane.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2tower/output_pixmod2tower.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2ftkplane/output_sctmod2ftkplane.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2tower/output_sctmod2tower.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2duplication/output_pixmod2duplication.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2duplication/output_sctmod2duplication.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/XFIFOLSC/XFIFOLSC.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_simple_dpram_w36_d4096/pulsar2_simple_dpram_w36_d4096.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_simple_dpram_w36_d1024/pulsar2_simple_dpram_w36_d1024.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/event_sorting_buffer/event_sorting_buffer.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/gig_ethernet_pcs_pma_1/gig_ethernet_pcs_pma_1.xci
import_ip -files /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/tri_mode_ethernet_mac_0/tri_mode_ethernet_mac_0.xci

# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_sysclk_125/pulsar2_sysclk_125.xci
# #read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_sysclk_100/pulsar2_sysclk_100.xci
# #read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_sysclk/pulsar2_sysclk.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_ic_w36_d512/fwft_ic_w36_d512.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_fifo_w36_d1024_fwft/pulsar2_fifo_w36_d1024_fwft.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_pixmod2dest/input_pixmod2dest.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_sctmod2dest/input_sctmod2dest.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_mod2idx/input_mod2idx.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/input_idx2mod/input_idx2mod.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_cc_w36_d512/fwft_cc_w36_d512.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/fwft_cc_w36_d512_for_ilrx/fwft_cc_w36_d512_for_ilrx.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2ftkplane/output_pixmod2ftkplane.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2tower/output_pixmod2tower.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2ftkplane/output_sctmod2ftkplane.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2tower/output_sctmod2tower.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_pixmod2duplication/output_pixmod2duplication.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/output_sctmod2duplication/output_sctmod2duplication.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/XFIFOLSC/XFIFOLSC.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_simple_dpram_w36_d4096/pulsar2_simple_dpram_w36_d4096.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/pulsar2_simple_dpram_w36_d1024/pulsar2_simple_dpram_w36_d1024.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/event_sorting_buffer/event_sorting_buffer.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/gig_ethernet_pcs_pma_1/gig_ethernet_pcs_pma_1.xci
# read_ip /cygdrive/c/Users/nilic/Desktop/data_formatter_firmware_pro-00-00-02-branch/generated_ip/xc7vx690t-ffg1927-2/tri_mode_ethernet_mac_0/tri_mode_ethernet_mac_0.xci

get_files -all -of [get_files pulsar2_sysclk_125.xci]
get_files -all -of [get_files fwft_ic_w36_d512_f256.xci]
get_files -all -of [get_files fwft_ic_w36_d512.xci]
get_files -all -of [get_files short_fwft_fifo_d32_w32.xci]
get_files -all -of [get_files short_fwft_fifo_d64_w32.xci]
get_files -all -of [get_files pulsar2_fifo_w36_d1024_fwft.xci]
get_files -all -of [get_files input_pixmod2dest.xci]
get_files -all -of [get_files input_sctmod2dest.xci]
get_files -all -of [get_files input_mod2idx.xci]
get_files -all -of [get_files input_idx2mod.xci]
get_files -all -of [get_files fwft_cc_w36_d512.xci]
get_files -all -of [get_files fwft_cc_w36_d512_for_ilrx.xci]
get_files -all -of [get_files output_pixmod2ftkplane.xci]
get_files -all -of [get_files output_pixmod2tower.xci]
get_files -all -of [get_files output_sctmod2ftkplane.xci]
get_files -all -of [get_files output_sctmod2tower.xci]
get_files -all -of [get_files output_pixmod2duplication.xci]
get_files -all -of [get_files output_sctmod2duplication.xci]
get_files -all -of [get_files XFIFOLSC.xci]
get_files -all -of [get_files pulsar2_simple_dpram_w36_d4096.xci]
get_files -all -of [get_files pulsar2_simple_dpram_w36_d1024.xci]
get_files -all -of [get_files event_sorting_buffer.xci]
get_files -all -of [get_files gig_ethernet_pcs_pma_1.xci]
get_files -all -of [get_files tri_mode_ethernet_mac_0.xci]

generate_target {all} [get_ips pulsar2_sysclk_125]
generate_target {all} [get_ips fwft_ic_w36_d512_f256]
generate_target {all} [get_ips fwft_ic_w36_d512]
generate_target {all} [get_ips short_fwft_fifo_d64_w32]
generate_target {all} [get_ips short_fwft_fifo_d32_w32]
generate_target {all} [get_ips pulsar2_fifo_w36_d1024_fwft]
generate_target {all} [get_ips input_pixmod2dest]
generate_target {all} [get_ips input_sctmod2dest]
generate_target {all} [get_ips input_mod2idx]
generate_target {all} [get_ips input_idx2mod]
generate_target {all} [get_ips fwft_cc_w36_d512]
generate_target {all} [get_ips fwft_cc_w36_d512_for_ilrx]
generate_target {all} [get_ips output_pixmod2ftkplane]
generate_target {all} [get_ips output_pixmod2tower]
generate_target {all} [get_ips output_sctmod2ftkplane]
generate_target {all} [get_ips output_sctmod2tower]
generate_target {all} [get_ips output_pixmod2duplication]
generate_target {all} [get_ips output_sctmod2duplication]
generate_target {all} [get_ips XFIFOLSC]
generate_target {all} [get_ips pulsar2_simple_dpram_w36_d4096]
generate_target {all} [get_ips pulsar2_simple_dpram_w36_d1024]
generate_target {all} [get_ips event_sorting_buffer]
generate_target {all} [get_ips gig_ethernet_pcs_pma_1]
generate_target {all} [get_ips tri_mode_ethernet_mac_0]


