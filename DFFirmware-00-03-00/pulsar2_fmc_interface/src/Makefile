target=iia.exe iib.exe tm.exe iia_scan.exe tm_scan.exe

all: $(target)

iia.exe:PulsarIIa_FMC_Reader.cc
	g++ PulsarIIa_FMC_Reader.cc -o $@

iia_scan.exe:PulsarIIa_FMC_Reader_Scan.cc
	g++ PulsarIIa_FMC_Reader_Scan.cc -o $@

iib.exe:PulsarIIb_FMC_Reader.cc
	g++ PulsarIIb_FMC_Reader.cc -o $@

tm.exe:TestMezzanine_FMC_Reader.cc
	g++ TestMezzanine_FMC_Reader.cc -o $@

tm_scan.exe:TestMezzanine_FMC_Reader_Scan.cc
	g++ TestMezzanine_FMC_Reader_Scan.cc -o $@

clean:
	rm -f $(target) *~
	chmod 644 *.*
