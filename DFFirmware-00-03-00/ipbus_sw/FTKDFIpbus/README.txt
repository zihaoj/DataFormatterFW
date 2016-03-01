cd cmt
source setup.sh 
# note the following does not work : source cmt/setup.sh but need to change directory
# ${PATH} ${LD_LIBRARY_PATH} ${DF_IPUBUS_CONFIG} will be set.

# if compile is needed
make clean
make 

# standard configuration "mode 1"
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 1 -F ${DF_IPUBUS_CONFIG}/configuration.txt

# standard configuration "mode 1" with your modified configuration
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 1 -F your_configuration.txt

# standard configuration "mode 1" with your modified configuration, including your own transveicer setup
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 1 -F your_configuration.txt -X your_transceiver_configuration.txt

# counter monitoring "mode 2"
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 2 -R 0

# GT channel monitoring "mode 9"
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 9

# spybuffer dump (for example lane=0) "mode 5"
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 5 -L 0

# connection file example
cat config/connections.xml

# configuration files
# for connections (device definition)
${DF_IPUBUS_CONFIG}/connections.xml

# for nodes (register definition)
${DF_IPUBUS_CONFIG}/address_df.xml

# for configuration (configuration parameter example), which will be input argument for the test command (test_df.exe)
${DF_IPUBUS_CONFIG}/configuration.txt

# for SLINK pattern generator output 
# data traffic enable
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 100 -N reg.gt_link_controller.patgen_enable -w -V 0X1
# data traffic disable
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 100 -N reg.gt_link_controller.patgen_enable -w -V 0X0
# reset enable
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 100 -N reg.gt_link_controller.patgen_reset -w -V 0X1
# reset disble
test_df.exe -C ${DF_IPUBUS_CONFIG}/connections.xml -D DF4D -M 100 -N reg.gt_link_controller.patgen_reset -w -V 0X0
