cp ../../ipcore/coefiles/*coe coefiles/

sh copy_script.sh xc7k160t-fbg484-1 pulsar2_fifo_w36_d1024_fwft "w36 / d1024"
sh copy_script.sh xc7k160t-fbg484-1 pulsar2_fifo_w37_d512_standard "w37 / d512 starndard FIFO"
sh copy_script.sh xc7k160t-fbg484-1 tp_w37_d4096_true_dp_cc "slink test pulse transmitter w37 / d4096 dual port true type DPRAM with default value"


for device in xc7vx690t-ffg1927-2; do
#for device in xc7k325t-ffg900-2 xc7vx690t-ffg1927-2; do
    sh copy_script.sh ${device} gig_ethernet_pcs_pma_1 "gig_ethernet_pcs_pma_1 for IPBUS"
    sh copy_script.sh ${device} tri_mode_ethernet_mac_0 "tri_mode_ethernet_mac_0 for IPBUS"
    
    sh copy_script.sh ${device} fwft_cc_w36_dram64 "common clock fwft fifo distributed RAM (maybe useful for swicth!!)"
    sh copy_script.sh ${device} fwft_cc_w36_d512 "common clock fwft fifo"
    sh copy_script.sh ${device} fwft_ic_w36_d512 "Independent Clock FWFT type fifo (used for internal elastic buffer)"
    sh copy_script.sh ${device} input_idx2mod "True Dual Port RAM common clock configuration a9/d14"
    sh copy_script.sh ${device} input_mod2idx "True Dual Port RAM common clock configuration a14/d9"
    #sh copy_script.sh ${device} mod_des_lut "with default values of the tower map"
    sh copy_script.sh ${device} pulsar2_fifo_w32_d512_standard "w32 d512 starndard fifo independent clock, data counter for wclk and rclk"
    sh copy_script.sh ${device} pulsar2_fifo_w36_d1024_fwft "FWFT / ALMOST FULL bit / WORD COUNTER (not fully accurated) has been implemented with d1024/w36"
    sh copy_script.sh ${device} pulsar2_fifo_w36_d8192_fwft "w36 / d8192 / FWFT"
    sh copy_script.sh ${device} pulsar2_fifo_w37_d512_standard "w37 d512 standard fifo common clock"
    sh copy_script.sh ${device} pulsar2_simple_dpram_w36_d4096 "for SPY buffer Always enabled option should be chosen (4K) USE_4K_SPY_BUFFER='1'"
    sh copy_script.sh ${device} pulsar2_simple_dpram_w36_d1024 "for SPY buffer Always enabled option should be chosen (1K) USE_4K_SPY_BUFFER='0'"
    sh copy_script.sh ${device} pulsar2_sysclk "sysclk generator SYSCLK_P will be the target for the constraint"
    sh copy_script.sh ${device} pulsar2_sysclk_100 "sysclk generator SYSCLK_P will be the target for the constraint with main_logic_clk=100MHz"
    sh copy_script.sh ${device} pulsar2_sysclk_125 "sysclk generator SYSCLK_P will be the target for the constraint with main_logic_clk=125MHz"
    sh copy_script.sh ${device} tp_w37_d4096_true_dp_cc "pattern_after_add_df_internal_header_trailer.exe"
    sh copy_script.sh ${device} XFIFOLDC "For LDC 33bit width 512 depth, rd_clk word count should be implemented with 9 bits"
    sh copy_script.sh ${device} XFIFOLSC "For LSC 34bit width 512 depth, wr_clk word count should be implemented with 9 bits"
    #sh copy_script.sh ${device} output_mod2ftkplane "True Dual Port RAM common clock configuratoin a14/d9"
    #sh copy_script.sh ${device} output_mod2tower "True Dual Port RAM common clock configuratoin a14/d2"
    
    sh copy_script.sh ${device} input_pixmod2dest "with default values of the tower map"
    sh copy_script.sh ${device} input_sctmod2dest "with default values of the tower map"
    sh copy_script.sh ${device} output_pixmod2ftkplane "True Dual Port RAM common clock configuratoin a14/d9"
    sh copy_script.sh ${device} output_sctmod2ftkplane "True Dual Port RAM common clock configuratoin a14/d9"
    sh copy_script.sh ${device} output_pixmod2tower "True Dual Port RAM common clock configuratoin a14/d2"
    sh copy_script.sh ${device} output_sctmod2tower "True Dual Port RAM common clock configuratoin a14/d2"
    sh copy_script.sh ${device} output_pixmod2duplication "True Dual Port RAM common clock configuratoin a14/d2 / by default \"11\" is filed in all cells"
    sh copy_script.sh ${device} output_sctmod2duplication "True Dual Port RAM common clock configuratoin a14/d2 / by default \"11\" is filed in all cells"
    
    sh copy_script.sh ${device} INTERNAL_LINK_INPUT_BUFFER "d2048 (prog full = 2048-256=1792)"
    sh copy_script.sh ${device} event_sorting_buffer "event sorting buffer (long enough data flow study may be needed to decide the proper size of buffer)"
    sh copy_script.sh ${device} fwft_cc_w36_d512_for_ilrx "common clock fwft fifo ( condition for the full gets changed!! 255 out of the 512 is the threshold for full flag to propagate it into TX side)"
done
