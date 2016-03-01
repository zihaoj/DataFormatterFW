# Gathering TCL Args
set DESIGN [lindex $argv 0]
set DEVICE [lindex $argv 1]
set XDC_FILE [lindex $argv 2]
set GENIP_DIR [lindex $argv 3]

# to over write the default PART
create_project my_project -force dummy -part ${DEVICE}
set_property PART ${DEVICE} [current_project]
set_property target_language VHDL [current_project]

set_param general.maxThreads 8
set_msg_config -id {Synth 8-3295}   -limit 100000
set_msg_config -id {Synth 8-3332}   -limit 100000
set_msg_config -id {Synth 8-3295}   -limit 100000
set_msg_config -id {Opt 31-80}      -limit 100000
set_msg_config -id {Synth 8-3333}   -limit 100000
set_msg_config -id {Place 30-568}   -limit 100000

# raad source HDL files / import IP
source input_list_125.tcl

# Adding Constraints
read_xdc ${XDC_FILE}
read_xdc bit_msc.xdc

set_property used_in_synthesis false [get_files  bit_msc.xdc]

generate_target {all} [get_files ./dummy/my_project.srcs/sources_1/ip/tri_mode_ethernet_mac_0/tri_mode_ethernet_mac_0.xci]

# run flow and save the databse
synth_design -top ${DESIGN} -part ${DEVICE} -include_dirs ${GENIP_DIR}
###
##write_debug_probes -force debug.ltx
#
write_checkpoint -force ${DESIGN}_synth.dcp
#
#### Running Logic Optimization
opt_design
#
### Saving Run
write_checkpoint -force ${DESIGN}_opt.dcp
#
#### Creating opt reports
report_utilization -file ${DESIGN}_post_synth_util.rpt
report_timing_summary -file ${DESIGN}_post_synth_timing.rpt
report_utilization -hierarchical -file ${DESIGN}_post_synth_util_hierarchy.rpt

report_io -file ${DESIGN}_io_opt.rpt
report_clock_interaction -file ${DESIGN}_clock_interaction_opt.rpt

### Placing Design
place_design
write_checkpoint -force ./${DESIGN}_place.dcp

### Routing Design
route_design

### Saving Run
write_checkpoint -force ./${DESIGN}_route.dcp

#### Creating route reports
report_route_status -file ${DESIGN}_post_route_route_status.rpt
report_utilization -file ${DESIGN}_post_route_util.rpt
report_utilization -hierarchical -file ${DESIGN}_post_route_util_hierarchy.rpt
report_timing_summary -file ${DESIGN}_post_route_timing.rpt
report_drc -file ${DESIGN}_post_route_drc.rpt
report_power -file ${DESIGN}_post_route_power.rpt
report_clock_networks -file ${DESIGN}_post_route_clknets.rpt
report_clocks -file ${DESIGN}_post_route_clks.rpt

### Create bitstream
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]
write_bitstream -force ${DESIGN}.bit
write_cfgmem -format mcs -interface SPIx4 -size 128 -loadbit "up 0x0 df_top.bit" -file df_top.mcs -force
exit
