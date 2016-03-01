base = ..

src = $(base)/src
inc = $(base)/FTKDFIpbus
test= $(base)/test
lib = $(base)/lib
bin = $(base)/bin

CACTUS_BASE = /opt/cactus
CACTUS_FLAG = -I$(CACTUS_BASE)/include -I$(base)
CACTUS_LIB  = -L$(CACTUS_BASE)/lib -L$(lib)

targets=$(bin)/test_df.exe $(lib)/libdfipbusaccess.so

all:$(targets)

$(bin)/test_df.exe:$(test)/test_df.cc $(lib)/libdfipbusaccess.so
	g++ -o $@ $(test)/test_df.cc -lcactus_uhal_uhal -ldfipbusaccess $(CACTUS_FLAG) $(CACTUS_LIB)

$(lib)/libdfipbusaccess.so:$(src)/df_ipbus_access_ok.cc $(inc)/df_ipbus_access_ok.hh
	g++ -o $@ --shared -fPIC $(src)/df_ipbus_access_ok.cc $(CACTUS_FLAG)

clean:
	rm -rf ../*/*~ $(targets)

