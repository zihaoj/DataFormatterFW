read_vhdl {
    ../../generated_ip/xc7k325t-ffg900-2/fwft_ic_w36_d512/fwft_ic_w36_d512_my_wrapper.vhd    
    
    ../fmcLib.2A.vhd
    
    ../FMC_RX_CLOCK.BUFMR.2A.vhd
    ../variable_delay_fmc.vhd
    ../fmc_rx_front.2A.vhd
    ../fmc_rx_frame.vhd
    ../fmc_rx_mapper_fpga_to_detword.vhd
    ../fmc_rx_parity.vhd
    ../fmc_rx_interface.vhd
    ../fmc_rx_mapper_fmc_to_fpga.vhd
    
    ../../spi_register_interface_v2/spilib.vhd
    ../../spi_register_interface_v2/spi_slave_core.vhd
    ../../spi_register_interface_v2/spi_slave_interface.vhd
    
    ../../spi_register_interface_v2/spi_register_examples/spy_buffer_core/GrayCounter.vhd
    ../../spi_register_interface_v2/spi_register_examples/spy_buffer_core/spybufferlib.vhd
    ../../spi_register_interface_v2/spi_register_examples/spy_buffer_core/spy_buffer_core_d4096.vhd
    ../../spi_register_interface_v2/spi_register_examples/spi_spy_buffer_multilanes_d4096.vhd
    
    ../../spi_register_interface_v2/spi_register_examples/spi_readonly_register.vhd
    ../../spi_register_interface_v2/spi_register_examples/spi_writable_register.vhd
    ../../spi_register_interface_v2/spi_register_examples/spi_pulse_generator.vhd
    ../../spi_register_interface_v2/spi_register_examples/spi_registers_lib.vhd
    
    
    my_config_parameters.vhd
    spi_interface.vhd
    top.2A.vhd
}

import_ip -files ../../generated_ip/xc7k325t-ffg900-2/fwft_ic_w36_d512/fwft_ic_w36_d512.xci
import_ip -files ../../generated_ip/xc7k325t-ffg900-2/pulsar2_simple_dpram_w36_d4096/pulsar2_simple_dpram_w36_d4096.xci
import_ip -files ../../generated_ip/xc7k325t-ffg900-2/pulsar2_sysclk/pulsar2_sysclk.xci
