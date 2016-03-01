DESIGN = df_top
DEVICE = xc7vx690t-ffg1927-2
XDC_FILE = $(DESIGN).xdc
GENIP_DIR = ../../generated_ip/$(DEVICE)/
XDC_FILE_125 = $(DESIGN)_CLK125.xdc
XDC_FILE_150 = $(DESIGN)_CLK150.xdc

# Make all runs to place & route
# chose either of the following two according to your purpose
#all : place_n_route
all : bitstream

# bitstream : Creates device bitstream
bitstream : $(DESIGN).bit

# place_n_route: Stops after place and route 
# for analysis prior to bitstream generation
place_n_route : $(DESIGN)_route.dcp

# translate: Stops after full design elaboration and initial optimization 
# for analysis and floorplanning prior to place and route step
translate : $(DESIGN)_opt.dcp

# Following calls Tcl files for each desired portion of the Vivado run
# Design checkpoint files and bit file used for dependency management
#$(DESIGN).bit : $(DESIGN)_route.dcp
	vivado -mode batch -source run_vivado_bitstream.tcl -tclargs $(DESIGN)

$(DESIGN).bit : run_vivado.tcl input_list.tcl $(XDC_FILE) 
	vivado -mode batch -source run_vivado.tcl -tclargs $(DESIGN) $(DEVICE) $(XDC_FILE) $(GENIP_DIR)

125 :
	vivado -mode batch -source run_vivado_125.tcl -tclargs $(DESIGN) $(DEVICE) $(XDC_FILE_125) $(GENIP_DIR)

150 :
	vivado -mode batch -source run_vivado_150.tcl -tclargs $(DESIGN) $(DEVICE) $(XDC_FILE_150) $(GENIP_DIR)

# Clean up all the files from the Vivado run
clean : 
	rm -rf *.jou *.log *.rpt *.dcp *.bit *.xml *.html *~ .Xil dummy fsm_encoding.os *.mif


# Tar and compress all the files
tar : 
	tar -zcvf $(DESIGN).tar.gz *.jou *.log *.rpt *.dcp *.tcl Makefile

mcs :
	vivado -mode batch -source make_mcs_125.tcl -tclargs $(DESIGN) $(DEVICE) $(XDC_FILE_125) $(GENIP_DIR)