read_vhdl {
    ../../pulsar2_fmc_interface/fmcLib.vhd
    
    ../../spi_register_interface_v2/spilib.vhd
    ../../spi_register_interface_v2/spi_slave_core.vhd
    ../../spi_register_interface_v2/spi_slave_interface.vhd
    
    ../../spi_register_interface_v2/spi_register_examples/spi_readonly_register.vhd
    ../../spi_register_interface_v2/spi_register_examples/spi_writable_register.vhd
    ../../spi_register_interface_v2/spi_register_examples/spi_pulse_generator.vhd
        
    ../../spi_register_interface_v2/spi_register_examples/spy_buffer_core/GrayCounter.vhd
    ../../spi_register_interface_v2/spi_register_examples/spy_buffer_core/spybufferlib.vhd
    ../../spi_register_interface_v2/spi_register_examples/spy_buffer_core/spy_buffer_core_d4096.vhd
    ../../spi_register_interface_v2/spi_register_examples/spi_spy_buffer_multilanes_d4096_multi_clock_domain.vhd
    ../../generated_ip/xc7vx690t-ffg1927-2/pulsar2_simple_dpram_w36_d4096/pulsar2_simple_dpram_w36_d4096_my_wrapper.vhd
    
    ../../spi_register_interface_v2/spi_register_examples/spi_registers_lib.vhd
    
    ../../pulsar2b_integration_test_2014summer/data_formatter_constants.vhd
    ../short_fwft_fifo.vhd
    ../df_switch_element.vhd
    ../df_switch_matrix_8x8.vhd
    pattern_gen.vhd    
    
    spi_interface.vhd
    top.vhd
}

# import_ip
import_ip -files ../../generated_ip/xc7vx690t-ffg1927-2/pulsar2_simple_dpram_w36_d4096/pulsar2_simple_dpram_w36_d4096.xci
#import_ip -files ../../generated_ip/xc7vx690t-ffg1927-2/fwft_cc_w36_d512/fwft_cc_w36_d512.xci
#../../generated_ip/xc7vx690t-ffg1927-2/fwft_cc_w36_d512/fwft_cc_w36_d512_my_wrapper.vhd
import_ip -files ../../generated_ip/xc7vx690t-ffg1927-2/pulsar2_sysclk/pulsar2_sysclk.xci
