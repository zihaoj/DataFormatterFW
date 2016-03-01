# Gathering TCL Arg
set DESIGN [lindex $argv 0]

read_checkpoint ${DESIGN}_route.dcp

set_property BITSTREAM.GENERAL.COMPRESS True [current_design]

# Create bitstream
write_bitstream -force ${DESIGN}.bit

exit
