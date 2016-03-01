# Gathering TCL Args
set DESIGN [lindex $argv 0]
set DEVICE [lindex $argv 1]
set XDC_FILE [lindex $argv 2]
set GENIP_DIR1 [lindex $argv 3]
set GENIP_DIR2 [lindex $argv 4]
set GENIP_DIR3 [lindex $argv 5]
set GENIP_DIR4 [lindex $argv 6]



# to over write the default PART
create_project my_project -force dummy -part ${DEVICE}
set_property PART ${DEVICE} [current_project]
set_property target_language VHDL [current_project]

# raad source HDL files / import IP
source input_list.tcl

# Adding Constraints
read_xdc ${XDC_FILE}


generate_target {Synthesis} [get_files ./dummy/my_project.srcs/sources_1/ip/gig_ethernet_pcs_pma_1/gig_ethernet_pcs_pma_1.xci]
generate_target {Synthesis} [get_files ./dummy/my_project.srcs/sources_1/ip/ila_1/ila_1.xci]
generate_target {Synthesis} [get_files ./dummy/my_project.srcs/sources_1/ip/tri_mode_ethernet_mac_0/tri_mode_ethernet_mac_0.xci]
generate_target {Synthesis} [get_files ./dummy/my_project.srcs/sources_1/ip/vio_1/vio_1.xci]


# run flow and save the databse
synth_design -top ${DESIGN} -part ${DEVICE} -include_dirs {${GENIP_DIR1} ${GENIP_DIR2} ${GENIP_DIR3} ${GENIP_DIR4}}


#write_checkpoint -force ../../exampledesigntrimode/tri_mode_ethernet_mac_0_example/tri_mode_ethernet_mac_0_example.runs/impl_1/tri_mode_ethernet_mac_0_example_design_placed.dcp
#write_checkpoint -force ../../exampledesigntrimode/tri_mode_ethernet_mac_0_example/tri_mode_ethernet_mac_0_example.runs/impl_1/tri_mode_ethernet_mac_0_example_design_routed.dcp
#write_checkpoint -force ../../exampledesigntrimode/tri_mode_ethernet_mac_0_example/tri_mode_ethernet_mac_0_example.runs/impl_1/tri_mode_ethernet_mac_0_example_design_opt.dcp
#write_checkpoint -force ../../exampledesigntrimode/tri_mode_ethernet_mac_0_example/tri_mode_ethernet_mac_0_example.runs/synth_1/tri_mode_ethernet_mac_0_example_design.dcp

# Running Logic Optimization
opt_design 

# Saving Run
write_checkpoint -force ${DESIGN}_opt.dcp

# Creating opt reports
report_utilization -file ${DESIGN}_post_synth_util.rpt
report_timing_summary -file ${DESIGN}_post_synth_timing.rpt
#report_io -file ${DESIGN}_io_opt.rpt
#report_clock_interaction -file ${DESIGN}_clock_interaction_opt.rpt

# Placing Design
place_design
write_checkpoint -force ./${DESIGN}_place.dcp

# Routing Design
route_design

# Saving Run
write_checkpoint -force ./${DESIGN}_route.dcp

# Creating route reports
report_route_status -file ${DESIGN}_post_route_route_status.rpt
report_utilization -file ${DESIGN}_post_route_util.rpt
report_utilization -hierarchical -file ${DESIGN}_post_route_util_hierarchy.rpt
report_timing_summary -file ${DESIGN}_post_route_timing.rpt
report_drc -file ${DESIGN}_post_route_drc.rpt
report_power -file ${DESIGN}_post_route_power.rpt
report_clock_networks -file ${DESIGN}_post_route_clknets.rpt
 report_clocks -file ${DESIGN}_post_route_clks.rpt

report_route_status -file ${DESIGN}_report_route_status.rpt
report_route_status -of_objects [get_nets *gt*] -file ${DESIGN}_report_route_status_netsgt.rpt

# Create bitstream
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]
write_bitstream -force ${DESIGN}.bit
write_debug_probes Debug_Nets.ltx

exit
