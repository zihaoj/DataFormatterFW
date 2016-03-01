--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.SpiConstants.all;
use work.SpiRegistersDeclarations.all;
use work.SpybufferConstants.all;
use work.FmcConstants.all;

entity spi_interface is
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
end spi_interface;

architecture logic of spi_interface is
  -----------------------------------
  -- preparation for SPI interface --
  -----------------------------------
  component  spi_slave_interface
    port (
      -- SPI
      SCLK      : in  std_logic;
      SPI_SEL   : in  std_logic;
      MOSI      : in  std_logic;
      MISO      : out std_logic;
      
      -- CLK
      SYS_CLK   : in  std_logic;
      REG_RESET : in  std_logic;
      
      -- interface for logic
      -- from logic    
      DIN       : in spi_reg_array; 
      DIN_VALID : in std_logic_vector(2**addr_width-1 downto 0);
      -- to logic
      DOUT      : out spi_reg_array
      ); 
  end component;
  signal reg_spi     : spi_reg_array := (others=>(others=>'0'));
  signal reg_logic   : spi_reg_array := (others=>(others=>'0'));
  signal valid_logic : std_logic_vector(2**addr_width-1 downto 0) := (others => '0');    
 
  -----------------------------------
  -- Address definition --
  ----------------------------------- 
  constant addr_fmc_reserved         : integer := CONV_INTEGER(x"00");
  constant addr_fmc_fifo_frame_reset : integer := CONV_INTEGER(x"01");
  -- RESET [0]=FIFO/FRAME_RESET, [1]=IDELAY RESET(not used usually), [7:2]=RESERVED
  
  constant addr_fmc_sync_reset : integer := CONV_INTEGER(x"02");
  -- RESET [7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1
  
  constant addr_fmc_fifo_full : integer := CONV_INTEGER(x"03");
  -- FIFO_FULL[7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1
  
  constant addr_fmc_fifo_empty : integer := CONV_INTEGER(x"04");
  -- FIFO_FULL[7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1
  --
  constant addr_fmc_sync_done : integer := CONV_INTEGER(x"05");
  -- SYNC_DONE[7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1
  
  constant addr_fmc_sync_error : integer := CONV_INTEGER(x"06");
  -- SYNC_DONE[7:0] for [0]FMC1_FPGA0 - [7]FMC4_FPGA1

  constant addr_fmc_config_clk_inv : integer := CONV_INTEGER(x"60");
  -- CLK_INV[0] for FMC0-FPGA0, CLK_INV[1] for FMC0-FPGA1
  -- CLK_INV[2] for FMC1-FPGA0, CLK_INV[3] for FMC1-FPGA1
  constant addr_fmc_config_clkdelay_ce  : integer := CONV_INTEGER(x"61");
  -- CLK_CE[0] for FMC0-FPGA0, CLK_CE[1] for FMC0-FPGA1
  -- CLK_CE[2] for FMC1-FPGA0, CLK_CE[3] for FMC1-FPGA1
  
  signal channeldelay_channel_selector_fpga_id : integer range 0 to 7; --(3bit)
  signal channeldelay_channel_selector_chan_id : integer range 0 to 31; --(5bit)
  constant addr_fmc_config_channeldelay_channel_selector : integer := CONV_INTEGER(x"62");
  -- [4:0] = channel number (from 0 to 17) @ maximum
  -- [7:5] = FPGA ID (from 0 to 7)
  constant addr_fmc_config_channeldelay_ce  : integer := CONV_INTEGER(x"63");
  constant addr_fmc_config_enable_clockphase_autoadjust  : integer := CONV_INTEGER(x"64");
  
  -- spy buffer related address :
  -- READOUT0[7:0] = DOUT[ 7: 0], READOUT1[7:0] = DOUT[15: 8],
  -- READOUT1[7:0] = DOUT[23:16], READOUT1[7:0] = DOUT[31:24]
  constant addr_fmc_spy_readout0     : integer := CONV_INTEGER(x"10");
  constant addr_fmc_spy_readout1     : integer := CONV_INTEGER(x"11");
  constant addr_fmc_spy_readout2     : integer := CONV_INTEGER(x"12");
  constant addr_fmc_spy_readout3     : integer := CONV_INTEGER(x"13");  
  constant addr_fmc_spy_readaddr0    : integer := CONV_INTEGER(x"14");
  constant addr_fmc_spy_readaddr1    : integer := CONV_INTEGER(x"15");
  constant addr_fmc_spy_laneselector : integer := CONV_INTEGER(x"16");
  -- spy buffer controller
  -- CONTROLLER[0] : RESET, CONTROLLER[1] : FREEZE (1=freeze, 0=store)
  constant addr_fmc_spy_controller   : integer := CONV_INTEGER(x"17");
  
  
  -- register buffers
  signal buf_fmc_fifo_frame_reset : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_sync_reset : std_logic_vector(data_width-1 downto 0) := (others => '0');
  
  signal buf_fmc_fifo_full  : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_fifo_empty : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_fifo_error : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_sync_done  : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_sync_error : std_logic_vector(data_width-1 downto 0) := (others => '0');
  
  signal buf_fmc_spy_readout0     : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_spy_readout1     : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_spy_readout2     : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_spy_readout3     : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_spy_readaddr0    : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_spy_readaddr1    : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_spy_laneselector : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_fmc_spy_controller   : std_logic_vector(data_width-1 downto 0) := (others => '0');

  signal buf_fmc_config_clk_inv : std_logic_vector(data_width-1 downto 0);
  signal buf_fmc_config_clkdelay_ce  : std_logic_vector(data_width-1 downto 0);
  signal buf_fmc_config_channeldelay_channel_selector : std_logic_vector(data_width-1 downto 0);
  signal buf_fmc_config_channeldelay_ce  : std_logic_vector(data_width-1 downto 0);
  signal buf_fmc_config_enable_clockphase_autoadjust : std_logic_vector(data_width-1 downto 0);
  
  constant spy_lane_size : integer := 2*num_fpga_for_each_mainfpga;
  signal spy_din   : spybuffer_array := (others=>(others=>'0'));
  signal spy_wen   : std_logic_vector(spi_spybuffer_lane_max-1 downto 0) := (others=>'0');  
  signal spy_dout  : std_logic_vector(spybuffer_data_width-1 downto 0);
  signal spy_lane_selector : std_logic_vector(spybuffer_ls_width-1 downto 0);
  signal spy_read_address  : std_logic_vector(spybuffer_addr_width_d4096-1 downto 0);
  
begin
  
  SPI_INTERFACE_MODULE : spi_slave_interface
    port map (
      SCLK => SCLK, SPI_SEL => SPI_SEL, MOSI => MOSI, MISO => MISO,
      SYS_CLK => SYSCLK, REG_RESET => '0',
      DIN => reg_logic, DIN_VALID => valid_logic, DOUT => reg_spi); 
  
  
  IO_ASIGNMENT : for iFpgaOnIM in FMC_CONFIG_DELAY_RESET'range generate
  begin
    FMC_CONFIG_CHANNELDELAY_DIR(iFpgaOnIM) <= (others =>'1'); -- constant
    FMC_CONFIG_DELAY_RESET(iFpgaOnIM)      <= buf_fmc_fifo_frame_reset(1);
    FMC_CONFIG_FIFO_RESET(iFpgaOnIM)       <= buf_fmc_fifo_frame_reset(0);
    FMC_CONFIG_FRAME_SCT_RESET(iFpgaOnIM)  <= buf_fmc_fifo_frame_reset(0);
    FMC_CONFIG_FRAME_PIX_RESET(iFpgaOnIM)  <= buf_fmc_fifo_frame_reset(0);
    FMC_CONFIG_CLOCK_SYNC_RESET(iFpgaOnIM) <= buf_fmc_sync_reset(iFpgaOnIM);
    
    buf_fmc_fifo_full(iFpgaOnIM)           <= FMC_CONFIG_FIFO_FULL(iFpgaOnIM);
    buf_fmc_fifo_error(iFpgaOnIM)          <= FMC_CONFIG_FIFO_ERROR(iFpgaOnIM);
    buf_fmc_sync_done(iFpgaOnIM)           <= FMC_CONFIG_SYNC_DONE(iFpgaOnIM);
    buf_fmc_sync_error(iFpgaOnIM)          <= FMC_CONFIG_SYNC_ERROR(iFpgaOnIM);
    
    -- FOR SPYBUFFER
    spy_din(iFpgaOnIM*2)        <= FMC_SCT_DATA(iFpgaOnIM);
    spy_wen(iFpgaOnIM*2)        <= FMC_SCT_DEN(iFpgaOnIM) and (not FMC_SCT_CTRL(iFpgaOnIM));
    
    spy_din(iFpgaOnIM*2 + 1)    <= FMC_PIX_DATA(iFpgaOnIM);
    spy_wen(iFpgaOnIM*2 + 1)    <= FMC_PIX_DEN(iFpgaOnIM) and (not FMC_PIX_CTRL(iFpgaOnIM));
    
    FMC_CONFIG_CLKDELAY_DIR(iFpgaOnIM) <= '1'; -- constant
    FMC_CONFIG_CLK_INV(iFpgaOnIM) <= buf_fmc_config_clk_inv(iFpgaOnIM);
    FMC_CONFIG_CLKDELAY_CE(iFpgaOnIM) <= buf_fmc_config_clkdelay_ce(iFpgaOnIM);
  end generate;
  
  -- 
  register_fmc_fifo_frame_reset : spi_writable_register port map
    (q=>buf_fmc_fifo_frame_reset, spi_din=>reg_spi(addr_fmc_fifo_frame_reset),
     spi_dout=>reg_logic(addr_fmc_fifo_frame_reset), spi_valid_out=>valid_logic(addr_fmc_fifo_frame_reset));
  
  -- 
  register_fmc_sync_reset : spi_writable_register port map
    (q=>buf_fmc_sync_reset, spi_din=>reg_spi(addr_fmc_sync_reset),
     spi_dout=>reg_logic(addr_fmc_sync_reset), spi_valid_out=>valid_logic(addr_fmc_sync_reset));
  
  --
  register_fmc_fifo_full : spi_readonly_register port map
    (d=>buf_fmc_fifo_full, spi_dout=>reg_logic(addr_fmc_fifo_full), spi_valid_out=>valid_logic(addr_fmc_fifo_full));
  
  --
  register_fmc_fifo_empty : spi_readonly_register port map
    (d=>buf_fmc_fifo_empty, spi_dout=>reg_logic(addr_fmc_fifo_empty), spi_valid_out=>valid_logic(addr_fmc_fifo_empty));
  
  --
  register_fmc_sync_done : spi_readonly_register port map
    (d=>buf_fmc_sync_done, spi_dout=>reg_logic(addr_fmc_sync_done), spi_valid_out=>valid_logic(addr_fmc_sync_done));
  
  --
  register_fmc_sync_error : spi_readonly_register port map
    (d=>buf_fmc_sync_error, spi_dout=>reg_logic(addr_fmc_sync_error), spi_valid_out=>valid_logic(addr_fmc_sync_error));
  
  -- =======================
  buf_fmc_spy_readout0 <= spy_dout( 7 downto  0);
  buf_fmc_spy_readout1 <= spy_dout(15 downto  8);
  buf_fmc_spy_readout2 <= spy_dout(23 downto 16);
  buf_fmc_spy_readout3 <= spy_dout(31 downto 24);

  spy_read_address  <= buf_fmc_spy_readaddr1(3 downto 0) & buf_fmc_spy_readaddr0(7 downto 0);
  spy_lane_selector <= buf_fmc_spy_laneselector;
  
  register_fmc_spy_readout0 : spi_readonly_register port map
    (d=>buf_fmc_spy_readout0, spi_dout=>reg_logic(addr_fmc_spy_readout0), spi_valid_out=>valid_logic(addr_fmc_spy_readout0));
  
  --
  register_fmc_spy_readout1 : spi_readonly_register port map
    (d=>buf_fmc_spy_readout1, spi_dout=>reg_logic(addr_fmc_spy_readout1), spi_valid_out=>valid_logic(addr_fmc_spy_readout1));
  
  --
  register_fmc_spy_readout2 : spi_readonly_register port map
    (d=>buf_fmc_spy_readout2, spi_dout=>reg_logic(addr_fmc_spy_readout2), spi_valid_out=>valid_logic(addr_fmc_spy_readout2));
  
  --
  register_fmc_spy_readout3 : spi_readonly_register port map
    (d=>buf_fmc_spy_readout3, spi_dout=>reg_logic(addr_fmc_spy_readout3), spi_valid_out=>valid_logic(addr_fmc_spy_readout3));  
  
  -- =======================
  register_fmc_spy_readaddr0 : spi_writable_register port map
    (q=>buf_fmc_spy_readaddr0, spi_din=>reg_spi(addr_fmc_spy_readaddr0),
     spi_dout=>reg_logic(addr_fmc_spy_readaddr0), spi_valid_out=>valid_logic(addr_fmc_spy_readaddr0));
  
  --
  register_fmc_spy_readaddr1 : spi_writable_register port map
    (q=>buf_fmc_spy_readaddr1, spi_din=>reg_spi(addr_fmc_spy_readaddr1),
     spi_dout=>reg_logic(addr_fmc_spy_readaddr1), spi_valid_out=>valid_logic(addr_fmc_spy_readaddr1));
  
  --
  register_fmc_spy_laneselector : spi_writable_register port map
    (q=>buf_fmc_spy_laneselector, spi_din=>reg_spi(addr_fmc_spy_laneselector),
     spi_dout=>reg_logic(addr_fmc_spy_laneselector), spi_valid_out=>valid_logic(addr_fmc_spy_laneselector));  
  
  -- =======================
  register_fmc_spy_controller : spi_writable_register port map
    (q=>buf_fmc_spy_controller, spi_din=>reg_spi(addr_fmc_spy_controller),
     spi_dout=>reg_logic(addr_fmc_spy_controller), spi_valid_out=>valid_logic(addr_fmc_spy_controller));
  
  --
  spy_buffer : spi_spy_buffer_multilanes_d4096
    generic map ( numberOfLanes => spy_lane_size)
    port map (
      Reset  => buf_fmc_spy_controller(0),
      Freeze => buf_fmc_spy_controller(1),
      Wen  => spy_wen,
      Clk  => SYSCLK,
      Din  => spy_din,
      Dout => spy_dout,
      LaneSelector => spy_lane_selector,
      ReadAddressBinary => spy_read_address
      );
  
  -- FMC DELAY
  register_fmc_config_clk_inv: spi_writable_register port map
    (q=>buf_fmc_config_clk_inv, spi_din=>reg_spi(addr_fmc_config_clk_inv),
     spi_dout=>reg_logic(addr_fmc_config_clk_inv), spi_valid_out=>valid_logic(addr_fmc_config_clk_inv));
  
  register_fmc_config_clkdelay_ce: spi_pulse_generator
    port map (
      refclk=>DELAY_REFCLK, q=>buf_fmc_config_clkdelay_ce, 
      spi_din=>reg_spi(addr_fmc_config_clkdelay_ce),
      spi_dout=>reg_logic(addr_fmc_config_clkdelay_ce),
      spi_valid_out=>valid_logic(addr_fmc_config_clkdelay_ce));
  
  channeldelay_channel_selector_fpga_id <= CONV_INTEGER(buf_fmc_config_channeldelay_channel_selector(7 downto 5));
  channeldelay_channel_selector_chan_id <= CONV_INTEGER(buf_fmc_config_channeldelay_channel_selector(4 downto 0));
  register_fmc_config_channeldelay_channel_selector: spi_writable_register port map
    (q=>buf_fmc_config_channeldelay_channel_selector, spi_din=>reg_spi(addr_fmc_config_channeldelay_channel_selector),
     spi_dout=>reg_logic(addr_fmc_config_channeldelay_channel_selector),
     spi_valid_out=>valid_logic(addr_fmc_config_channeldelay_channel_selector));
  
  register_fmc_config_channeldelay_ce: spi_pulse_generator
    port map (
      refclk=>DELAY_REFCLK, q=>buf_fmc_config_channeldelay_ce, 
      spi_din=>reg_spi(addr_fmc_config_channeldelay_ce),
      spi_dout=>reg_logic(addr_fmc_config_channeldelay_ce),
      spi_valid_out=>valid_logic(addr_fmc_config_channeldelay_ce));
  
  CHANNELDELAY_OUTPUT_FPGAS : for iFpgaOnIM in 0 to num_fpga_for_each_mainfpga-1 generate
  begin
    CHANNELDELAY_OUTPUT_CHANS : for iChan in lvds_pairs_for_rx_in_each_fpga-1 downto 0 generate
      process (DELAY_REFCLK)
      begin
        if (DELAY_REFCLK'event and DELAY_REFCLK='1') then
          if (iChan=channeldelay_channel_selector_chan_id and iFpgaOnIM=channeldelay_channel_selector_fpga_id) then
            FMC_CONFIG_CHANNELDELAY_CE(iFpgaOnIM)(iChan) <= buf_fmc_config_channeldelay_ce(0);
          else
            FMC_CONFIG_CHANNELDELAY_CE(iFpgaOnIM)(iChan) <= '0';
          end if;
        end if;
      end process;
    end generate;
  end generate;

  FMC_CONFIG_ENABLE_CLOCKPHASE_AUTOADJUST <= buf_fmc_config_enable_clockphase_autoadjust(0);
  register_fmc_config_enable_clockphase_autoadjust: spi_writable_register port map
    (q=>buf_fmc_config_enable_clockphase_autoadjust, spi_din=>reg_spi(addr_fmc_config_enable_clockphase_autoadjust),
     spi_dout=>reg_logic(addr_fmc_config_enable_clockphase_autoadjust),
     spi_valid_out=>valid_logic(addr_fmc_config_enable_clockphase_autoadjust));
  
end logic;
