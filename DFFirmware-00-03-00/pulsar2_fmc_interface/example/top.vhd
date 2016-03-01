------------------------------------------------------------------------------
-- PulsarIIb
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.FmcConstants.all;
use work.my_config_parameters.all;

library unisim;
use unisim.vcomponents.all;

entity top is
  generic (
    common_clk_frequency : real := common_clk_frequency
    );
  port
    (
      -- SYSCLK
      SYSCLK_P : in std_logic;
      SYSCLK_N : in std_logic;
      
      -- SPI
      SCLK    : in  std_logic;
      SPI_SEL : in  std_logic;
      MOSI    : in  std_logic;
      MISO    : out std_logic;
      
      -- FMC
      FB1_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB1_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB1_CLK0_P : in std_logic;
      FB1_CLK0_N : in std_logic;
      FB1_CLK1_P : in std_logic;
      FB1_CLK1_N : in std_logic;
      
      FB2_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB2_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB2_CLK0_P : in std_logic;
      FB2_CLK0_N : in std_logic;
      FB2_CLK1_P : in std_logic;
      FB2_CLK1_N : in std_logic;
      
      FB3_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB3_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB3_CLK0_P : in std_logic;
      FB3_CLK0_N : in std_logic;
      FB3_CLK1_P : in std_logic;
      FB3_CLK1_N : in std_logic;
      
      FB4_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB4_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      FB4_CLK0_P : in std_logic;
      FB4_CLK0_N : in std_logic;
      FB4_CLK1_P : in std_logic;
      FB4_CLK1_N : in std_logic
      );
end top;

architecture logic of top is
  
  component fmc_rx_interface
    generic
      ( FMC_ID     : integer ; --FB1/2/3/4
        FPGA_ID    : integer ; --FPGA0/1
        common_clk_frequency : real := common_clk_frequency
        );
    port
      (FMC_COMMON_CLK : in std_logic;
       
       SCT_DATA_OUT  : out std_logic_vector(width_of_decoded_word-1 downto 0);
       SCT_CTRL_OUT  : out std_logic;
       SCT_DEN_OUT   : out std_logic;
       
       PIX_DATA_OUT  : out std_logic_vector(width_of_decoded_word-1 downto 0);
       PIX_CTRL_OUT  : out std_logic;
       PIX_DEN_OUT   : out std_logic;
       
       FMCIN_LVDS_DATA_IN_P : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
       FMCIN_LVDS_DATA_IN_N : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
       FMCIN_CLK_P : in std_logic;
       FMCIN_CLK_N : in std_logic;
       
       CONFIG_CHANNELDELAY_DIR : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
       CONFIG_CHANNELDELAY_CE  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
       CONFIG_DELAY_RESET      : in  std_logic;
       CONFIG_FIFO_RESET   : in  std_logic;
       CONFIG_FIFO_FULL    : out std_logic;
       CONFIG_FIFO_ERROR   : out std_logic;
       
       CONFIG_CLK_INV      : in std_logic;
       CONFIG_CLKDELAY_DIR : in std_logic;
       CONFIG_CLKDELAY_CE  : in std_logic;
       CONFIG_ENABLE_CLOCKPHASE_AUTOADJUST : in std_logic;       
       
       CONFIG_FRAME_SCT_RESET  : in  std_logic;
       CONFIG_FRAME_PIX_RESET  : in  std_logic;
       CONFIG_CLOCK_SYNC_RESET : in  std_logic;
       CONFIG_SYNC_DONE : out std_logic;
       CONFIG_SYNC_ERROR : out std_logic
       );
  end component;
  
  component fmc_rx_mapper_fmc_to_fpga
    port (
      din        : in  std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      dout_fpga0 : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      dout_fpga1 : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0)
      );
  end component;  
  
  component spi_interface
    port ( 
      -- SYSCLK
      SYSCLK  : in std_logic;
      DELAY_REFCLK : in std_logic;
      
      -- SPI
      SCLK    : in  std_logic;
      SPI_SEL : in  std_logic;
      MOSI    : in  std_logic;
      MISO    : out std_logic;

      FMC_CONFIG_CHANNELDELAY_DIR : out data_type_for_imfpga_input_lanes_t;
      FMC_CONFIG_CHANNELDELAY_CE  : out data_type_for_imfpga_input_lanes_t;
      FMC_CONFIG_DELAY_RESET      : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_FIFO_RESET   : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_FIFO_FULL    : in  std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_FIFO_ERROR   : in  std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_FRAME_SCT_RESET  : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_FRAME_PIX_RESET  : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_CLOCK_SYNC_RESET : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_SYNC_DONE  : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_SYNC_ERROR : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);

    
      FMC_CONFIG_CLK_INV      : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_CLKDELAY_DIR : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_CONFIG_CLKDELAY_CE  : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);      
      FMC_CONFIG_ENABLE_CLOCKPHASE_AUTOADJUST : out std_logic;

      
      -- FOR SPYBUFFER
      FMC_SCT_DATA  : in data_type_for_imfpga_output_lanes_t;
      FMC_SCT_CTRL  : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_SCT_DEN   : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      
      FMC_PIX_DATA  : in data_type_for_imfpga_output_lanes_t;
      FMC_PIX_CTRL  : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
      FMC_PIX_DEN   : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0)
      );
  end component;
  
  component pulsar2_sysclk
    port
      (-- Clock in ports
        CLK_IN1_P         : in     std_logic;
        CLK_IN1_N         : in     std_logic;
        -- Clock out ports
        MAIN_LOGIC_CLK          : out    std_logic;
        FMC_COMMON_CLK          : out    std_logic;
        CLK50                   : out    std_logic;
        -- Status and control signals
        RESET             : in     std_logic;
        LOCKED            : out    std_logic
        );
  end component;
  
  signal fmc_common_clk_i   : std_logic;
  signal fmc_sct_data_out_i : data_type_for_imfpga_output_lanes_t;
  signal fmc_sct_ctrl_out_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_sct_den_out_i  : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_pix_data_out_i : data_type_for_imfpga_output_lanes_t;
  signal fmc_pix_ctrl_out_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_pix_den_out_i  : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);  
  
  signal fmcin_lvds_data_in_p_i : data_type_for_imfpga_input_lanes_t;
  signal fmcin_lvds_data_in_n_i : data_type_for_imfpga_input_lanes_t;
  signal fmcin_clk_p_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_clk_n_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  
  signal fmc_config_channeldelay_dir_i : data_type_for_imfpga_input_lanes_t;
  signal fmc_config_channeldelay_ce_i  : data_type_for_imfpga_input_lanes_t;
  signal fmc_config_delay_reset_i      : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_config_fifo_reset_i       : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_config_fifo_full_i        : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_config_fifo_error_i       : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  
  signal fmc_config_clk_inv_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_config_clkdelay_dir_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_config_clkdelay_ce_i  : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_config_enable_clockphase_autoadjust_i : std_logic;  
  
  signal fmc_config_frame_sct_reset_i  : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_config_frame_pix_reset_i  : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  
  signal fmc_config_clock_sync_reset   : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_sync_done                 : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmc_sync_error                : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  
begin
    
  ---------------------------------------------------------------------------------------------------------
  -- SYSCLOCK BUFFER
  ---------------------------------------------------------------------------------------------------------
  SYSCLK_BUFFER : pulsar2_sysclk
    port map
    (CLK_IN1_P => SYSCLK_P,
     CLK_IN1_N => SYSCLK_N,
     MAIN_LOGIC_CLK => open,
     FMC_COMMON_CLK => fmc_common_clk_i,
     CLK50 => open,
     RESET => '0',
     LOCKED => open
     );

  ---------------------------------------------------------------------------------------------------------
  --- idelay control
  ---------------------------------------------------------------------------------------------------------
  idelaycontrol : IDELAYCTRL
    port map (RDY => open, REFCLK => fmc_common_clk_i, RST => '0');
  
  ---------------------------------------------------------------------------------------------------------
  -- LVDS RX input assignment
  ---------------------------------------------------------------------------------------------------------
  -- input assignment (FB1)
  input_mapper_fb1_p : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB1_RX_LVDS_P, dout_fpga0=>fmcin_lvds_data_in_p_i(0), dout_fpga1=>fmcin_lvds_data_in_p_i(1));
  
  input_mapper_fb1_n : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB1_RX_LVDS_N, dout_fpga0=>fmcin_lvds_data_in_n_i(0), dout_fpga1=>fmcin_lvds_data_in_n_i(1));

  -- input assignment (FB2)  
  input_mapper_fb2_p : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB2_RX_LVDS_P, dout_fpga0=>fmcin_lvds_data_in_p_i(2), dout_fpga1=>fmcin_lvds_data_in_p_i(3));
  
  input_mapper_fb2_n : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB2_RX_LVDS_N, dout_fpga0=>fmcin_lvds_data_in_n_i(2), dout_fpga1=>fmcin_lvds_data_in_n_i(3));
  
  -- input assignment (FB3)
  input_mapper_fb3_p : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB3_RX_LVDS_P, dout_fpga0=>fmcin_lvds_data_in_p_i(4), dout_fpga1=>fmcin_lvds_data_in_p_i(5));
  
  input_mapper_fb3_n : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB3_RX_LVDS_N, dout_fpga0=>fmcin_lvds_data_in_n_i(4), dout_fpga1=>fmcin_lvds_data_in_n_i(5));
  
  -- input assignment (FB4)
  input_mapper_fb4_p : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB4_RX_LVDS_P, dout_fpga0=>fmcin_lvds_data_in_p_i(6), dout_fpga1=>fmcin_lvds_data_in_p_i(7));
  
  input_mapper_fb4_n : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB4_RX_LVDS_N, dout_fpga0=>fmcin_lvds_data_in_n_i(6), dout_fpga1=>fmcin_lvds_data_in_n_i(7));    
  ---------------------------------------------------------------------------------------------------------
  
  ---------------------------------------------------------------------------------------------------------
  -- FORWARDED CLOCK input assignment
  --------------------------------------------------------------------------------------------------------- 
  fmcin_clk_p_i(0)<=FB1_CLK0_P; fmcin_clk_n_i(0)<=FB1_CLK0_N;
  fmcin_clk_p_i(1)<=FB1_CLK1_P; fmcin_clk_n_i(1)<=FB1_CLK1_N;
  fmcin_clk_p_i(2)<=FB2_CLK0_P; fmcin_clk_n_i(2)<=FB2_CLK0_N;
  fmcin_clk_p_i(3)<=FB2_CLK1_P; fmcin_clk_n_i(3)<=FB2_CLK1_N;
  fmcin_clk_p_i(4)<=FB3_CLK0_P; fmcin_clk_n_i(4)<=FB3_CLK0_N;
  fmcin_clk_p_i(5)<=FB3_CLK1_P; fmcin_clk_n_i(5)<=FB3_CLK1_N;
  fmcin_clk_p_i(6)<=FB4_CLK0_P; fmcin_clk_n_i(6)<=FB4_CLK0_N;
  fmcin_clk_p_i(7)<=FB4_CLK1_P; fmcin_clk_n_i(7)<=FB4_CLK1_N;  
  ---------------------------------------------------------------------------------------------------------
  
  ---------------------------------------------------------------------------------------------------------
  -- RX FROM IM FPGA (run 0 to 7)
  ---------------------------------------------------------------------------------------------------------   
  RX_FROM_IM_FPGAS : for iFpga in 0 to num_fpga_for_each_mainfpga-1 generate 
    constant FMC_ID  : integer := (iFpga - (iFpga mod 2))/2+1;
    constant FPGA_ID : integer := iFpga mod 2;
  begin
    FMC_INTERFACE : fmc_rx_interface
      generic map (FMC_ID=>FMC_ID, FPGA_ID=>FPGA_ID)
      port map (FMC_COMMON_CLK => fmc_common_clk_i,
                
                SCT_DATA_OUT => fmc_sct_data_out_i(iFpga),
                SCT_CTRL_OUT => fmc_sct_ctrl_out_i(iFpga),
                SCT_DEN_OUT  => fmc_sct_den_out_i(iFpga),
                
                PIX_DATA_OUT => fmc_pix_data_out_i(iFpga),
                PIX_CTRL_OUT => fmc_pix_ctrl_out_i(iFpga),
                PIX_DEN_OUT  => fmc_pix_den_out_i(iFpga),
                
                FMCIN_LVDS_DATA_IN_P => fmcin_lvds_data_in_p_i(iFpga),
                FMCIN_LVDS_DATA_IN_N => fmcin_lvds_data_in_n_i(iFpga),
                FMCIN_CLK_P => fmcin_clk_p_i(iFpga),
                FMCIN_CLK_N => fmcin_clk_n_i(iFpga),
                
                CONFIG_CHANNELDELAY_DIR => fmc_config_channeldelay_dir_i(iFpga),
                CONFIG_CHANNELDELAY_CE => fmc_config_channeldelay_ce_i(iFpga),
                CONFIG_DELAY_RESET => fmc_config_delay_reset_i(iFpga),
                CONFIG_FIFO_RESET => fmc_config_fifo_reset_i(iFpga),
                CONFIG_FIFO_FULL => fmc_config_fifo_full_i(iFpga),
                CONFIG_FIFO_ERROR => fmc_config_fifo_error_i(iFpga),
                CONFIG_FRAME_SCT_RESET => fmc_config_frame_sct_reset_i(iFpga),
                CONFIG_FRAME_PIX_RESET => fmc_config_frame_pix_reset_i(iFpga),
                CONFIG_CLOCK_SYNC_RESET => fmc_config_clock_sync_reset(iFpga),
                CONFIG_SYNC_DONE => fmc_sync_done(iFpga),
                CONFIG_SYNC_ERROR => fmc_sync_error(iFpga),
                
                CONFIG_CLK_INV => fmc_config_clk_inv_i(iFpga),
                CONFIG_CLKDELAY_DIR => fmc_config_clkdelay_dir_i(iFpga),
                CONFIG_CLKDELAY_CE => fmc_config_clkdelay_ce_i(iFpga),
                CONFIG_ENABLE_CLOCKPHASE_AUTOADJUST => fmc_config_enable_clockphase_autoadjust_i                
                );
  end generate;
  ---------------------------------------------------------------------------------------------------------
  
  ---------------------------------------------------------------------------------------------------------
  -- SPI Interface
  ---------------------------------------------------------------------------------------------------------     
  My_SPI_Interface : spi_interface
    port map (
      SYSCLK => fmc_common_clk_i,
      DELAY_REFCLK => fmc_common_clk_i,
      
      SCLK => SCLK,
      SPI_SEL => SPI_SEL,
      MOSI => MOSI,
      MISO => MISO,
      
      FMC_CONFIG_CHANNELDELAY_DIR => fmc_config_channeldelay_dir_i,
      FMC_CONFIG_CHANNELDELAY_CE => fmc_config_channeldelay_ce_i,
      FMC_CONFIG_DELAY_RESET => fmc_config_delay_reset_i,
      FMC_CONFIG_FIFO_RESET => fmc_config_fifo_reset_i,
      FMC_CONFIG_FIFO_FULL => fmc_config_fifo_full_i,
      FMC_CONFIG_FIFO_ERROR => fmc_config_fifo_error_i,
      FMC_CONFIG_FRAME_SCT_RESET => fmc_config_frame_sct_reset_i,
      FMC_CONFIG_FRAME_PIX_RESET => fmc_config_frame_pix_reset_i,
      FMC_CONFIG_CLOCK_SYNC_RESET => fmc_config_clock_sync_reset,
      FMC_CONFIG_SYNC_DONE => fmc_sync_done,
      FMC_CONFIG_SYNC_ERROR => fmc_sync_error,
      
      FMC_CONFIG_CLK_INV => fmc_config_clk_inv_i,
      FMC_CONFIG_CLKDELAY_DIR => fmc_config_clkdelay_dir_i,
      FMC_CONFIG_CLKDELAY_CE => fmc_config_clkdelay_ce_i,
      FMC_CONFIG_ENABLE_CLOCKPHASE_AUTOADJUST => fmc_config_enable_clockphase_autoadjust_i,
      
      FMC_SCT_DATA => fmc_sct_data_out_i,
      FMC_SCT_CTRL => fmc_sct_ctrl_out_i,
      FMC_SCT_DEN => fmc_sct_den_out_i,
      
      FMC_PIX_DATA => fmc_pix_data_out_i,
      FMC_PIX_CTRL => fmc_pix_ctrl_out_i,
      FMC_PIX_DEN => fmc_pix_den_out_i
      );
  ---------------------------------------------------------------------------------------------------------
  
  
end logic;

