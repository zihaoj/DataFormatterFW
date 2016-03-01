# Gathering TCL Args
set DESIGN [lindex $argv 0]
set DEVICE [lindex $argv 1]
set XDC_FILE [lindex $argv 2]

# to over write the default PART
create_project my_project -force dummy -part ${DEVICE}
set_property PART ${DEVICE} [current_project]


# raad source HDL files / import IP
source input_list.tcl

# Adding Constraints
read_xdc ${XDC_FILE}

# run flow and save the databse
synth_design -top ${DESIGN} -part ${DEVICE} -include_dirs ../../ipcore_vc7k325t/

# Running Logic Optimization
opt_design

# Saving Run
write_checkpoint -force ${DESIGN}_opt.dcp

# Creating opt reports
report_utilization -file ${DESIGN}_post_synth_util.rpt
report_timing_summary -file ${DESIGN}_post_synth_timing.rpt
#report_io -file ${DESIGN}_io_opt.rpt
#report_clock_interaction -file ${DESIGN}_clock_interaction_opt.rpt
exit
