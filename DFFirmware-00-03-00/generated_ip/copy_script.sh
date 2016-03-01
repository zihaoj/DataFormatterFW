if [ $# -ne 3 ]; then
    echo "sh generated_ip_copy_script.sh <FPGA type> <IP name> \"<a short explanation>\""
    echo "FPGA type : xc7k325t-ffg900-2 or xc7vx690t-ffg1927-1"
    echo "IP name   : e.g. fwft_ic_w36_d512"
    exit 1
fi

FPGA_TYPE=$1
IP_NAME=$2
COMMENT=$3

rm -rf ${FPGA_TYPE}/${IP_NAME}
cp -r ../../ipcore/${FPGA_TYPE}/${IP_NAME} ${FPGA_TYPE}/${IP_NAME}/
rm -f ${FPGA_TYPE}/${IP_NAME}/*~

echo ${COMMENT} > ${FPGA_TYPE}/${IP_NAME}/README
