------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.FmcConstants.all;
use work.SpiConstants.all;
use work.my_config_parameters.all;

entity testbench is
  generic ( clk_per  : time    :=5 ns;
            common_clk_frequency : real :=200.00 );
end testbench;

architecture logic of testbench is
  
  -- ##########################################
  component testbench_mezz
    generic
      (num_pins   : integer := lvds_pairs_for_rx_in_each_fpga);    
    port
      (LVDS_DATA_OUT_P : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
       LVDS_DATA_OUT_N : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
       CLK0_P          : out std_logic; -- clock forwarding
       CLK0_N          : out std_logic; -- clock forwarding
       SYSCLK_P        : in std_logic; -- 200MHz
       SYSCLK_N        : in std_logic; -- 200MHz
       TEST_DATA_IN    : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga*2-1 downto 0);
       LED1            : out std_logic
       );
  end component;

  -- ##########################################
  component fmc_connector_emulator2
    generic ( FMC_ID   : integer);
    port (
      fpga0_p_din  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      fpga0_n_din  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      fpga1_p_din  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      fpga1_n_din  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      p_dout    : out std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      n_dout    : out std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      clk0_p_in : in  std_logic;
      clk0_n_in : in  std_logic;
      clk0_p_out: out std_logic;
      clk0_n_out: out std_logic;
      clk1_p_in : in  std_logic;
      clk1_n_in : in  std_logic;
      clk1_p_out: out std_logic;
      clk1_n_out: out std_logic);
  end component;
  
  -- ##########################################
  component fmc_rx_mapper_fmc_to_fpga
    port (
      din        : in  std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      dout_fpga0 : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      dout_fpga1 : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0)
      );  
  end component;
  
  -- ##########################################
  component top
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
        FB2_CLK1_N : in std_logic
        );
  end component;  

  signal test_data_sct_r1 : std_logic_vector(lvds_pairs_for_rx_in_each_fpga-2 downto 0) := (others => '0');
  -- "-2" measn one bit is assiend for parity
  signal test_data_pix_r1 : std_logic_vector(lvds_pairs_for_rx_in_each_fpga-2 downto 0) := (others => '0');
  -- "-2" measn one bit is assiend for parity
  signal test_data_r2 : std_logic_vector(lvds_pairs_for_rx_in_each_fpga*2-1 downto 0) := (others => '0');  
  
  signal mezzout_fpga_lvds_data_out_p : lvds_pairs_for_each_fpga_t;
  signal mezzout_fpga_lvds_data_out_n : lvds_pairs_for_each_fpga_t;
  
  signal mezzout_clk_forward_p : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal mezzout_clk_forward_n : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  
  -- Connector DF Side
  signal dfin_lvds_data_out_p : lvds_pairs_for_each_fmc_t;
  signal dfin_lvds_data_out_n : lvds_pairs_for_each_fmc_t;
  
  signal dfin_clk_forward_p : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal dfin_clk_forward_n : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  
  signal sys_clk_in_p : std_logic := '0';
  signal sys_clk_in_n : std_logic := '1';
  signal sys_clk      : std_logic := '1';
  
  -- ##########################################
  -- Mezzanine Simulation
  -- ##########################################
  signal RESET_SIGNAL     : std_logic := '0';
  signal SCT_DATA_FLOW_ENABLE : std_logic := '0';
  signal PIX_DATA_FLOW_ENABLE : std_logic := '0';
  signal SCT_DATA_FLOW_INTERRUPT : std_logic := '0';
  signal PIX_DATA_FLOW_INTERRUPT : std_logic := '0';
  
  signal sct_word_counter : integer range 0 to 3 := 0;
  signal pix_word_counter : integer range 0 to 3 := 0;
  signal sct_counter : std_logic_vector(data_width_in_each_clockcycle-1 downto 0) := (others => '0');
  signal pix_counter : std_logic_vector(data_width_in_each_clockcycle-1 downto 0) := (others => '0');
  
  
  -- ##########################################
  -- SPI Interface Simulation
  -- ##########################################  
  -- SPI
  signal SCLK    : std_logic;
  signal SPI_SEL : std_logic;
  signal MOSI    : std_logic;
  signal MISO    : std_logic;
  
  -- master
  signal txdata  : std_logic_vector(bus_width-1 downto 0);
  signal rxdata  : std_logic_vector(bus_width-1 downto 0);
  -- ##########################################  
  procedure spi_master(signal sclk    : out std_logic;
                       signal spi_sel : out std_logic;
                       signal mosi    : out std_logic;
                       signal miso    : in  std_logic;
                       signal txdata  : in  std_logic_vector(bus_width-1 downto 0);
                       signal rxdata  : out std_logic_vector(bus_width-1 downto 0)
                       ) is
  begin
    if cpha='1' then
      -- first select 
      spi_sel <= '0';
      wait for spi_clock_cycle;
      
      for iBit in 1 to bus_width loop
        if cpol='0' then sclk <= '1'; else sclk <= '0'; end if;
        mosi <= txdata(bus_width-iBit);
        wait for spi_clock_cycle;
        if cpol='0' then sclk <= '0'; else sclk <= '1'; end if;
        rxdata(bus_width-iBit) <= miso;
        wait for spi_clock_cycle;
      end loop;
      
      mosi    <= 'Z';
      spi_sel <= '1';
    end if;
    
    if cpha='0' then
      -- first select 
      spi_sel <= '0';
      
      for iBit in 1 to bus_width loop
        mosi <= txdata(bus_width-iBit);
        wait for spi_clock_cycle;
        if cpol='0' then sclk <= '1'; else sclk <= '0'; end if;
        rxdata(bus_width-iBit) <= miso;
        wait for spi_clock_cycle;
        if cpol='0' then sclk <= '0'; else sclk <= '1'; end if;
      end loop;
      
      wait for spi_clock_cycle;
      mosi    <= 'Z';
      spi_sel <= '1';      
    end if;
    
  end spi_master;  
  
begin
  
  IM_FPGA_SIMULATORS : for iFMC in 0 to num_fmc_per_mainfpga-1 generate
    constant FPGA0_ID : integer := iFMC*2;
    constant FPGA1_ID : integer := iFMC*2+1;
  begin
    -- ##########################################
    MEZZANINE_FPGA0 : testbench_mezz
      port map (
        LVDS_DATA_OUT_P => mezzout_fpga_lvds_data_out_p(FPGA0_ID),
        LVDS_DATA_OUT_N => mezzout_fpga_lvds_data_out_n(FPGA0_ID),
        CLK0_P => mezzout_clk_forward_p(FPGA0_ID),
        CLK0_N => mezzout_clk_forward_n(FPGA0_ID),
        SYSCLK_P => sys_clk_in_p,
        SYSCLK_N => sys_clk_in_n,
        TEST_DATA_IN => test_data_r2,
        LED1 => open
        );
    
    -- ##########################################
    MEZZANINE_FPGA1 : testbench_mezz
      port map (
        LVDS_DATA_OUT_P => mezzout_fpga_lvds_data_out_p(FPGA1_ID),
        LVDS_DATA_OUT_N => mezzout_fpga_lvds_data_out_n(FPGA1_ID),
        CLK0_P => mezzout_clk_forward_p(FPGA1_ID),
        CLK0_N => mezzout_clk_forward_n(FPGA1_ID),
        SYSCLK_P => sys_clk_in_p,
        SYSCLK_N => sys_clk_in_n,
        TEST_DATA_IN => test_data_r2,
        LED1 => open
        );
    
    -- ##########################################
    FMC_CONNECTOR : fmc_connector_emulator2
      generic map ( FMC_ID => iFMC+1)
      port map (
        fpga0_p_din => mezzout_fpga_lvds_data_out_p(FPGA0_ID),
        fpga0_n_din => mezzout_fpga_lvds_data_out_n(FPGA0_ID),
        fpga1_p_din => mezzout_fpga_lvds_data_out_p(FPGA1_ID),
        fpga1_n_din => mezzout_fpga_lvds_data_out_n(FPGA1_ID),
        p_dout      => dfin_lvds_data_out_p(iFMC),
        n_dout      => dfin_lvds_data_out_n(iFMC),
        clk0_p_in   => mezzout_clk_forward_p(FPGA0_ID),
        clk0_n_in   => mezzout_clk_forward_n(FPGA0_ID),
        clk0_p_out  => dfin_clk_forward_p(FPGA0_ID),
        clk0_n_out  => dfin_clk_forward_n(FPGA0_ID),
        clk1_p_in   => mezzout_clk_forward_p(FPGA1_ID),
        clk1_n_in   => mezzout_clk_forward_n(FPGA1_ID),
        clk1_p_out  => dfin_clk_forward_p(FPGA1_ID),
        clk1_n_out  => dfin_clk_forward_n(FPGA1_ID));
  end generate;
  
  -- ##########################################
  -- ##########################################
  TopModule : top
    port map (
      SYSCLK_P => sys_clk_in_p, SYSCLK_N => sys_clk_in_n,
      
      SCLK => SCLK, SPI_SEL => SPI_SEL, MOSI => MOSI, MISO => MISO,
      
      FB1_RX_LVDS_P => dfin_lvds_data_out_p(0), FB1_RX_LVDS_N => dfin_lvds_data_out_n(0),
      FB1_CLK0_P => dfin_clk_forward_p(0), FB1_CLK0_N => dfin_clk_forward_n(0),
      FB1_CLK1_P => dfin_clk_forward_p(1), FB1_CLK1_N => dfin_clk_forward_n(1),
      
      FB2_RX_LVDS_P => dfin_lvds_data_out_p(1), FB2_RX_LVDS_N => dfin_lvds_data_out_n(1),
      FB2_CLK0_P => dfin_clk_forward_p(2), FB2_CLK0_N => dfin_clk_forward_n(2),
      FB2_CLK1_P => dfin_clk_forward_p(3), FB2_CLK1_N => dfin_clk_forward_n(3)
      );
  
  -- clock generator
  process
  begin
    wait for clk_per/2;
    sys_clk_in_p <= not sys_clk_in_p;
  end process;
  sys_clk_in_n <= not sys_clk_in_p;
  sys_clk      <= sys_clk_in_p;
  
  -- sct test pattern generator
  process (sys_clk, RESET_SIGNAL)
  begin
    if (RESET_SIGNAL='1') then
      test_data_sct_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle)  <= ctrl_idleword;
      test_data_sct_r1(data_width_in_each_clockcycle-1 downto 0) <= data_idleword;
      sct_word_counter <= 0;
      sct_counter <= (others => '0');
        
    elsif (sys_clk'event and sys_clk='1') then
      if (SCT_DATA_FLOW_INTERRUPT='1') then
        test_data_sct_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle)  <= ctrl_idleword;
        test_data_sct_r1(data_width_in_each_clockcycle-1 downto 0)   <= data_idleword;
        sct_word_counter <= sct_word_counter;
      elsif ((SCT_DATA_FLOW_ENABLE='0') and (sct_word_counter=0)) then
        test_data_sct_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle)  <= ctrl_idleword;
        test_data_sct_r1(data_width_in_each_clockcycle-1 downto 0) <= data_idleword;
        sct_word_counter <= 0;
      elsif sct_word_counter/=0 then
        test_data_sct_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle)  <= ctrl_another_byte_of_data;
        test_data_sct_r1(data_width_in_each_clockcycle-1 downto 0) <= sct_counter; --"11101111";
        sct_counter <= sct_counter + 1;
        if sct_word_counter/=3 then
          sct_word_counter <= sct_word_counter+1;
        else
          sct_word_counter <= 0;
        end if;
      else
        test_data_sct_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle)  <= ctrl_first_byte_of_data;
        test_data_sct_r1(data_width_in_each_clockcycle-1 downto 0) <= sct_counter; --"01110111";
        sct_word_counter <= sct_word_counter+1;
        sct_counter <= sct_counter + 1;
      end if;
    end if;
  end process;
  
  --pixel test pattern generator
  process (sys_clk, RESET_SIGNAL)
  begin
    if (RESET_SIGNAL='1') then
      test_data_pix_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle) <= ctrl_idleword;
      test_data_pix_r1(data_width_in_each_clockcycle-1 downto 0) <= data_idleword;
      pix_word_counter <= 0;
      pix_counter <= (others => '0');
      
    elsif (sys_clk'event and sys_clk='1') then
      if (PIX_DATA_FLOW_INTERRUPT='1') then
        test_data_pix_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle) <= ctrl_idleword;
        test_data_pix_r1(data_width_in_each_clockcycle-1 downto 0) <= data_idleword;
        pix_word_counter <= pix_word_counter;
      elsif ((PIX_DATA_FLOW_ENABLE='0') and (pix_word_counter=0)) then
        test_data_pix_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle) <= ctrl_idleword;
        test_data_pix_r1(data_width_in_each_clockcycle-1 downto 0) <= data_idleword;
        pix_word_counter <= 0;
      elsif pix_word_counter/=0 then
        test_data_pix_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle) <= ctrl_another_byte_of_data;
        test_data_pix_r1(data_width_in_each_clockcycle-1 downto 0) <= pix_counter;
        pix_counter <= pix_counter + 1;
        if pix_word_counter/=3 then
          pix_word_counter <= pix_word_counter+1;
        else
          pix_word_counter <= 0;
        end if;
      else
        test_data_pix_r1(word_width_in_each_clockcycle-1 downto data_width_in_each_clockcycle) <= ctrl_first_byte_of_data;
        test_data_pix_r1(data_width_in_each_clockcycle-1 downto 0) <= pix_counter;
        pix_counter <= pix_counter + 1;
        pix_word_counter <= pix_word_counter+1;
      end if;
    end if;
  end process;
  
  process (sys_clk, RESET_SIGNAL)
  begin
    if (RESET_SIGNAL='1') then
      test_data_r2(fpga_to_parity_sct_bit_mapping) <= '0';
      test_data_r2(fpga_to_parity_pix_bit_mapping) <= '0';      
    elsif (sys_clk'event and sys_clk='1') then
      test_data_r2(fpga_to_parity_sct_bit_mapping) <= xor_reduce(test_data_sct_r1);
      test_data_r2(fpga_to_parity_pix_bit_mapping) <= xor_reduce(test_data_pix_r1);
    end if;
  end process;
  
  process (sys_clk, RESET_SIGNAL)
  begin
    if (RESET_SIGNAL='1') then
      test_data_r2(fpga_to_pixword_bit_mapping(word_width_in_each_clockcycle-1) downto fpga_to_pixword_bit_mapping(0))
        <= test_data_pix_r1;
      test_data_r2(fpga_to_sctword_bit_mapping(word_width_in_each_clockcycle-1) downto fpga_to_sctword_bit_mapping(0))
        <= test_data_sct_r1;      
    elsif (sys_clk'event and sys_clk='1') then
      test_data_r2(fpga_to_pixword_bit_mapping(word_width_in_each_clockcycle-1) downto fpga_to_pixword_bit_mapping(0))
        <= test_data_pix_r1;
      test_data_r2(fpga_to_sctword_bit_mapping(word_width_in_each_clockcycle-1) downto fpga_to_sctword_bit_mapping(0))
        <= test_data_sct_r1;      
    end if;
  end process;  
  
  -- Mezzanine Time Line
  process
  begin
    RESET_SIGNAL     <= '1';
    
    SCT_DATA_FLOW_INTERRUPT <= '0';
    PIX_DATA_FLOW_INTERRUPT <= '0';
    
    SCT_DATA_FLOW_ENABLE <= '0';
    PIX_DATA_FLOW_ENABLE <= '0';
    
    wait for 5 us;
    
    RESET_SIGNAL     <= '0';
    wait for 20 us;
    
    for ii in 0 to 300 loop
      SCT_DATA_FLOW_INTERRUPT <= '0';
      PIX_DATA_FLOW_INTERRUPT <= '0';

      SCT_DATA_FLOW_ENABLE <= '1';
      PIX_DATA_FLOW_ENABLE <= '1';      
      
      wait for 90 ns;
      PIX_DATA_FLOW_INTERRUPT <= '1';
      wait for 25 ns;
      
      SCT_DATA_FLOW_INTERRUPT <= '0';
      PIX_DATA_FLOW_INTERRUPT <= '0';      
      
      wait for 100 ns;
      
      SCT_DATA_FLOW_ENABLE <= '0';
      PIX_DATA_FLOW_ENABLE <= '0';
      wait for 3 us;
      
      SCT_DATA_FLOW_ENABLE <= '1';
      PIX_DATA_FLOW_ENABLE <= '0';
      wait for 100 ns;

      SCT_DATA_FLOW_ENABLE <= '0';
      PIX_DATA_FLOW_ENABLE <= '1';
      wait for 100 ns;
      
      SCT_DATA_FLOW_ENABLE <= '0';
      PIX_DATA_FLOW_ENABLE <= '0';      
      wait for 1 us;
    end loop;
    wait;
  end process;

  -- Mezzanine Time Line
  -----------------------------------------------------
  -- timeline
  -----------------------------------------------------
  process
  begin
    
    SCLK    <= '0';
    SPI_SEL <= '1';
    MOSI    <= '0';
    
    if cpol='0' then sclk <= '0'; else sclk <= '1'; end if;
    SPI_SEL <= '1';
    
    --===================================================
    -- RESET FIFO / FRAME
    --===================================================
    txdata<=X"8101";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"8100";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);        
    
    --===================================================
    -- RESET SYNC FUNCTIONS
    --===================================================
    txdata<=X"8201";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"8200";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    --===================================================
    -- RESET SPYBUFFER
    --===================================================
    txdata<=X"9701";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
    
    txdata<=X"9700";
    wait for waiting_time;
    spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);    
    
    for iLoop in 0 to 10
    loop
      --===================================================
      -- Monitor Sync Done -- 85FF is expected
      --===================================================
      txdata<=X"0500";
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      --===================================================
      -- Monitor FIFO FULL -- 8300 is expected (it is never supposed to be full)
      --===================================================
      txdata<=X"0300";
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

      --===================================================
      -- STOP SPYBUFFER
      --===================================================
      txdata<=X"9702"; -- USER FREEZE COMMAND
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      ------------------------------------------------------------------------------------------------
      --- One cycle of read spy buffer
      ------------------------------------------------------------------------------------------------
      txdata<=X"9600"; -- SET LANE SELECTOR (LANE-0)
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

      txdata<=X"9401"; -- SET READ ADDRESS [ 7: 0]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"9500"; -- SET READ ADDRESS [11: 8] : 
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1000"; -- READ DOUT [ 7: 0]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1100"; -- READ DOUT [15: 8]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

      txdata<=X"1200"; -- READ DOUT [23:16]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1300"; -- READ DOUT [31:24]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      ------------------------------------------------------------------------------------------------
      
      ------------------------------------------------------------------------------------------------
      --- One cycle of read spy buffer <second cycle>
      ------------------------------------------------------------------------------------------------
      txdata<=X"9600"; -- SET LANE SELECTOR (LANE-0)
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"9402"; -- SET READ ADDRESS [ 7: 0]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"9500"; -- SET READ ADDRESS [11: 8] : 
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1000"; -- READ DOUT [ 7: 0]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1100"; -- READ DOUT [15: 8]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

      txdata<=X"1200"; -- READ DOUT [23:16]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1300"; -- READ DOUT [31:24]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      ------------------------------------------------------------------------------------------------

      ------------------------------------------------------------------------------------------------
      --- One cycle of read spy buffer <third cycle>
      ------------------------------------------------------------------------------------------------
      txdata<=X"9600"; -- SET LANE SELECTOR (LANE-0)
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"9402"; -- SET READ ADDRESS [ 7: 0]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"9500"; -- SET READ ADDRESS [11: 8] : 
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1000"; -- READ DOUT [ 7: 0]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1100"; -- READ DOUT [15: 8]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

      txdata<=X"1200"; -- READ DOUT [23:16]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1300"; -- READ DOUT [31:24]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      ------------------------------------------------------------------------------------------------
      
      ------------------------------------------------------------------------------------------------
      --- One cycle of read spy buffer <forth cycle>
      ------------------------------------------------------------------------------------------------
      txdata<=X"9601"; -- SET LANE SELECTOR (LANE-1)
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"9400"; -- SET READ ADDRESS [ 7: 0]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"9500"; -- SET READ ADDRESS [11: 8] : 
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1000"; -- READ DOUT [ 7: 0]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1100"; -- READ DOUT [15: 8]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);

      txdata<=X"1200"; -- READ DOUT [23:16]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      txdata<=X"1300"; -- READ DOUT [31:24]
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      ------------------------------------------------------------------------------------------------       
      
      --===================================================
      -- RESUME SPYBUFFER
      --===================================================
      txdata<=X"9700"; -- USER FREEZE COMMAND
      wait for waiting_time;
      spi_master(sclk=>SCLK, spi_sel=>SPI_SEL, mosi=>MOSI, miso=>MISO, txdata=>txdata, rxdata=>rxdata);
      
      wait for 1 us;
    end loop;
  
    
  end process;
  
  
end logic;
