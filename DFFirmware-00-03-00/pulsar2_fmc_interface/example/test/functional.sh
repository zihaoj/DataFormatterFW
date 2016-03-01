snapshot_name=run_gen

xelab -incremental -prj simulation_xsim.2A.prj -s ${snapshot_name} work.testbench --debug all
xsim -gui ${snapshot_name} -wdb simulation_xsim.wdb
