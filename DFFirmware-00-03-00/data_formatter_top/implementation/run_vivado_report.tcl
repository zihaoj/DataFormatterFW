# Gathering TCL Arg
set DESIGN [lindex $argv 0]

read_checkpoint ./${DESIGN}_opt.dcp

# Creating route reports
report_route_status -file tmp_${DESIGN}_current_route_status.rpt
report_utilization -file tmp_${DESIGN}_current_util.rpt
report_utilization -hierarchical -file tmp_${DESIGN}_current_util_hierarchy.rpt
report_timing_summary -file tmp_${DESIGN}_current_timing.rpt
report_drc -file tmp_${DESIGN}_current_drc.rpt
report_power -file tmp_${DESIGN}_current_power.rpt
report_clock_networks -file tmp_${DESIGN}_current_clknets.rpt
report_clocks -file tmp_${DESIGN}_current_clks.rpt

exit
