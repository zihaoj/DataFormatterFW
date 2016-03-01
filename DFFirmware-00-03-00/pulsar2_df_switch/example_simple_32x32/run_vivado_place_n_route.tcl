# Gathering TCL Arg
set DESIGN [lindex $argv 0]

read_checkpoint ./${DESIGN}_opt.dcp

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
report_timing_summary -file ${DESIGN}_post_route_timing.rpt
report_drc -file ${DESIGN}_post_route_drc.rpt
report_power -file ${DESIGN}_post_route_power.rpt
report_clock_networks -file ${DESIGN}_post_route_clknets.rpt
report_clocks -file ${DESIGN}_post_route_clks.rpt

exit
