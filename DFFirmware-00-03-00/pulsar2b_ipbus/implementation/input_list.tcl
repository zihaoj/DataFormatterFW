

read_vhdl {

    ../vhd/chipscope_icon.vhd
    ../vhd/clk_wiz_v3_6.vhd            
    ../vhd/clock_div.vhd
    ../vhd/clocks_7s_serdes.vhd
    ../vhd/eth_7s_1000basex_new.vhd
    ../vhd/emac_hostbus_decl.vhd
    ../vhd/ipbus_package.vhd
    ../vhd/ipbus_trans_decl.vhd
    ../vhd/ipbus_addr_decode.vhd
    ../vhd/ipbus_ctrlreg.vhd
    ../vhd/ipbus_ctrl.vhd
    ../vhd/ipbus_fabric.vhd
    ../vhd/ipbus_peephole_ram.vhd
    ../vhd/ipbus_pkt_ctr.vhd
    ../vhd/ipbus_ram.vhd
    ../vhd/ipbus_reg.vhd
    ../vhd/slaves.vhd
    ../vhd/stretcher.vhd
    ../vhd/top_kc705_basex.vhd
    ../vhd/transactor_cfg.vhd
    ../vhd/transactor_if.vhd
    ../vhd/transactor_sm.vhd
    ../vhd/transactor.vhd
    ../vhd/trans_arb.vhd
    ../vhd/udp_buffer_selector.vhd
    ../vhd/udp_build_arp.vhd
    ../vhd/udp_build_payload.vhd
    ../vhd/udp_build_ping.vhd
    ../vhd/udp_build_resend.vhd
    ../vhd/udp_build_status.vhd
    ../vhd/udp_byte_sum.vhd
    ../vhd/udp_clock_crossing_if.vhd
    ../vhd/udp_do_rx_reset.vhd
    ../vhd/udp_dualportram_rx.vhd
    ../vhd/udp_dualportram_tx.vhd
    ../vhd/udp_dualportram.vhd
    ../vhd/udp_if_flat.vhd
    ../vhd/udp_ipaddr_block.vhd
    ../vhd/udp_packet_parser.vhd
    ../vhd/udp_rarp_block.vhd
    ../vhd/udp_rxram_mux.vhd
    ../vhd/udp_rxram_shim.vhd
    ../vhd/udp_rxtransactor_if_simple.vhd
    ../vhd/udp_status_buffer.vhd
    ../vhd/udp_tx_mux.vhd
    ../vhd/udp_txtransactor_if_simple.vhd                     

}

# import_ip
import_ip -files ../ipcores/pulsar2_sysclk/pulsar2_sysclk.xci
import_ip -files ../ipcores/gig_ethernet_pcs_pma_1/gig_ethernet_pcs_pma_1.xci
import_ip -files ../ipcores/ila_1/ila_1.xci
import_ip -files ../ipcores/tri_mode_ethernet_mac_0/tri_mode_ethernet_mac_0.xci
import_ip -files ../ipcores/vio_1/vio_1.xci
