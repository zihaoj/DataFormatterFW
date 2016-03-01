--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

use work.LscModDeclarations.all;
use work.LdcModDeclarations.all;

entity testbench is
  generic (
    SIMULATION       : integer :=    1; -- simulation mode
    ALTERA_XILINX    : integer :=    0; -- 1=Altera 0=Xilinx
    ACTIVITY_LENGTH  : integer :=   15; -- ACTLED duration
    LSC_FIFODEPTH    : integer :=  512; -- only powers of 2 (USE 512 !!)
    LSC_LOG2DEPTH    : integer :=    9; -- 2log of depth (USE 9 !!)
    LDC_FIFODEPTH    : integer :=  512; -- only powers of 2 (USE 512 !!)
    LDC_LOG2DEPTH    : integer :=    9; -- 2log of depth (USE 9 !!)    
    FULLMARGIN       : integer :=   16);  -- words left when LFF_N
end testbench;

architecture logic of testbench is
  -- LSC related signals
  signal lsc_reset_n_i : std_logic;
  signal lsc_ud_i            : std_logic_vector(31 downto 0);
  signal lsc_ureset_n_i      : std_logic;
  signal lsc_utest_n_i       : std_logic;
  signal lsc_uctrl_n_i       : std_logic;
  signal lsc_uwen_n_i        : std_logic;
  signal lsc_uclk_i          : std_logic;
  signal lsc_lff_n_i         : std_logic;
  signal lsc_lrl_i           : std_logic_vector( 3 downto 0);
  signal lsc_ldown_n_i       : std_logic;
  signal lsc_testled_n_i     : std_logic;
  signal lsc_lderrled_n_i    : std_logic;
  signal lsc_lupled_n_i      : std_logic;
  signal lsc_flowctlled_n_i  : std_logic;
  signal lsc_activityled_n_i : std_logic;
  signal lsc_gtx_rxusrclk2_i      : std_logic;
  signal lsc_gtx_rxdata_i         : std_logic_vector(31 downto 0);
  signal lsc_gtx_rxcharisk_i      : std_logic_vector(3 downto 0);
  signal lsc_gtx_rxencommaalign_i : std_logic;
  signal lsc_gtx_txusrclk2_i      : std_logic;
  signal lsc_gtx_txcharisk_i      : std_logic_vector(3 downto 0);
  signal lsc_gtx_txdata_i         : std_logic_vector(31 downto 0);
  
  -- LDC related signals
  signal ldc_reset_n_i          : std_logic;
  signal ldc_ld_i               : std_logic_vector(31 downto 0);
  signal ldc_uxoff_n_i          : std_logic;
  signal ldc_ureset_n_i         : std_logic;
  signal ldc_utdo_n_i           : std_logic;
  signal ldc_lctrl_n_i          : std_logic;
  signal ldc_lwen_n_i           : std_logic;
  signal ldc_lclk_i             : std_logic;
  signal ldc_lderr_n_i          : std_logic;
  signal ldc_url_i              : std_logic_vector( 3 downto 0);
  signal ldc_ldown_n_i          : std_logic;
  signal ldc_testled_n_i        : std_logic;                     -- red
  signal ldc_lderrled_n_i       : std_logic;                     -- red
  signal ldc_lupled_n_i         : std_logic;                     -- green
  signal ldc_flowctlled_n_i     : std_logic;                     -- red
  signal ldc_activityled_n_i    : std_logic;                     -- green
  signal ldc_xclk_i             : std_logic;                     -- 100 mhz clock
  signal ldc_gtx_rxusrclk2_i      : std_logic;
  signal ldc_gtx_rxdata_i         : std_logic_vector(31 downto 0);
  signal ldc_gtx_rxcharisk_i      : std_logic_vector(3 downto 0);
  signal ldc_gtx_rxencommaalign_i : std_logic;
  signal ldc_gtx_txusrclk2_i      : std_logic;
  signal ldc_gtx_txcharisk_i      : std_logic_vector(3 downto 0);
  signal ldc_gtx_txdata_i         : std_logic_vector(31 downto 0);
  signal ldc_lclk_in_i          : std_logic;                      -- this is the clock
  
  -- local signal needed for pattern generator and checker
  signal patgen_data_i    : std_logic_vector(31 downto 0);
  signal patgen_counter_i : std_logic_vector(7 downto 0);
  signal patgen_en_i      : std_logic;
  signal patgen_ctrl_i    : std_logic;
  signal ld_r        : std_logic_vector(31 downto 0) := (others => '0');
  signal ref_data_r  : std_logic_vector(31 downto 0) := (others => '0');
  signal lwen_r      : std_logic;
  signal lctrl_r     : std_logic;  
  
  -- clock generator signal
  signal clock156p25 : std_logic;
  signal pattern_generator_enable_i : std_logic;
  signal pattern_checker_enable_i : std_logic;
  signal check_error_counter_i : std_logic_vector(31 downto 0) := (others => '0');
  
  constant timing_idle_word : std_logic_vector(7 downto 0) := "01111111";
  constant timing_ctrl_word : std_logic_vector(7 downto 0) := "11111111";
  
begin
  
  -----------------------------------
  my_lsc_interface : holalsc_gtx
    generic map(
      SIMULATION => SIMULATION,
      ALTERA_XILINX => ALTERA_XILINX,
      ACTIVITY_LENGTH => ACTIVITY_LENGTH,
      FIFODEPTH => LSC_FIFODEPTH,
      LOG2DEPTH => LSC_LOG2DEPTH,
      FULLMARGIN => FULLMARGIN
      )
    port map (
      RESET_N => lsc_reset_n_i, 
      
      UD => lsc_ud_i,
      URESET_N => lsc_ureset_n_i,
      UTEST_N => lsc_utest_n_i,
      UCTRL_N => lsc_uctrl_n_i,
      UWEN_N => lsc_uwen_n_i,
      UCLK => lsc_uclk_i,
      LFF_N => lsc_lff_n_i,
      LRL => lsc_lrl_i,
      LDOWN_N => lsc_ldown_n_i,
      
      TESTLED_N => lsc_testled_n_i,
      LDERRLED_N => lsc_lderrled_n_i,
      LUPLED_N => lsc_lupled_n_i,
      FLOWCTLLED_N => lsc_flowctlled_n_i,
      ACTIVITYLED_N => lsc_activityled_n_i,
      ENABLE => open,
      
      GTX_RXUSRCLK2 => lsc_gtx_rxusrclk2_i,
      GTX_RXDATA => lsc_gtx_rxdata_i,
      GTX_RXCHARISK => lsc_gtx_rxcharisk_i,
      GTX_RXENCOMMAALIGN => lsc_gtx_rxencommaalign_i,
      GTX_TXUSRCLK2 => lsc_gtx_txusrclk2_i,
      GTX_TXCHARISK => lsc_gtx_txcharisk_i,
      GTX_TXDATA => lsc_gtx_txdata_i,
      
      DLL_RESET => '0'
      );
  
  -----------------------------------
  my_ldc_interface : holaldc_gtx
    generic map (
      ALTERA_XILINX => ALTERA_XILINX,
      SIMULATION => SIMULATION,
      ACTIVITY_LENGTH => ACTIVITY_LENGTH,
      FIFODEPTH => LDC_FIFODEPTH,
      LOG2DEPTH => LDC_LOG2DEPTH,
      FULLMARGIN => FULLMARGIN
      )
    port map (
      RESET_N => ldc_reset_n_i,
      LD => ldc_ld_i,
      UXOFF_N => ldc_uxoff_n_i,
      URESET_N => ldc_ureset_n_i,
      UTDO_N => ldc_utdo_n_i,
      
      LCTRL_N => ldc_lctrl_n_i,
      LWEN_N => ldc_lwen_n_i,
      LCLK => ldc_lclk_i,
      LDERR_N => ldc_lderr_n_i,
      URL => ldc_url_i,
      LDOWN_N => ldc_ldown_n_i,
      
      TESTLED_N => ldc_testled_n_i,
      LDERRLED_N => ldc_lderrled_n_i,
      LUPLED_N => ldc_lupled_n_i,
      FLOWCTLLED_N => ldc_flowctlled_n_i,
      ACTIVITYLED_N => ldc_activityled_n_i,
      
      XCLK => ldc_xclk_i,
      
      ENABLE => open, -- not used
      
      GTX_RXUSRCLK2 => ldc_gtx_rxusrclk2_i,
      GTX_RXDATA => ldc_gtx_rxdata_i,
      GTX_RXCHARISK => ldc_gtx_rxcharisk_i,
      GTX_RXENCOMMAALIGN => ldc_gtx_rxencommaalign_i,
      GTX_TXUSRCLK2 => ldc_gtx_txusrclk2_i,
      GTX_TXCHARISK => ldc_gtx_txcharisk_i,
      GTX_TXDATA => ldc_gtx_txdata_i,
      
      LCLK_IN => ldc_lclk_in_i,
      DLL_RESET => '0'
      );  

  -- clock generator
  process
  begin
    clock156p25 <= '0';
    wait for 6.4 ns;
    clock156p25 <= '1';
    wait for 6.4 ns;
  end process;

  
  -- <LSC> controller at LSC part
  lsc_ureset_n_i <= '1'; -- constant for this simple test
  lsc_utest_n_i  <= '1'; -- constant for this simple test
  
  -- LSC clocking
  -- whatever clock source is OK as long as UD/UCTL etc are 
  -- syncrhonized with UCLK
  lsc_uclk_i <= lsc_gtx_rxusrclk2_i;

  -- <LDC> controller at LDC part
  ldc_uxoff_n_i  <= '1'; -- constant for this simple test
  ldc_ureset_n_i <= '1'; -- constant for this simple test
  ldc_utdo_n_i   <= '1'; -- constant for this simple test
  ldc_url_i    <= "0000"; -- constant for this simple test
  
  -- LDC clocking
  ldc_xclk_i    <= ldc_gtx_rxusrclk2_i;
  ldc_lclk_in_i <= ldc_gtx_rxusrclk2_i;
  
  -- gt module emulating part
  
  lsc_gtx_rxusrclk2_i <= clock156p25;
  lsc_gtx_txusrclk2_i  <= clock156p25;
  ldc_gtx_rxusrclk2_i <= clock156p25;
  ldc_gtx_txusrclk2_i  <= clock156p25;
  
  lsc_gtx_rxdata_i     <= ldc_gtx_txdata_i;
  lsc_gtx_rxcharisk_i  <= ldc_gtx_txcharisk_i;
  ldc_gtx_rxcharisk_i  <= lsc_gtx_txcharisk_i;
  ldc_gtx_rxdata_i     <= lsc_gtx_txdata_i;
  
  -- LSC pattern checker part
  -------------------------------------
  -- set to the transceiver input
  -------------------------------------
  process (lsc_gtx_txusrclk2_i)
  begin
    if (lsc_gtx_txusrclk2_i'event and lsc_gtx_txusrclk2_i='1') then
      lsc_uwen_n_i  <= not patgen_en_i;
      lsc_uctrl_n_i <= not patgen_ctrl_i;
      if    (patgen_en_i='0') then
        lsc_ud_i <= (others => '0'); -- dummy data
      elsif (patgen_ctrl_i='1') then
        lsc_ud_i <= X"B0F0E0F0";
      else
        lsc_ud_i <= patgen_data_i;
      end if;
    end if;
  end process;
  
  -------------------------------------
  -- pattern generator
  -------------------------------------
  process (lsc_gtx_txusrclk2_i, pattern_generator_enable_i)
  begin
    if    (pattern_generator_enable_i='0') then      
      patgen_counter_i <= (others => '0');
    elsif (lsc_gtx_txusrclk2_i'event and lsc_gtx_txusrclk2_i='1') then
      patgen_counter_i <= patgen_counter_i + 1;
    end if;
  end process;
  
  -------------------------------------
  -- pattern generator
  -------------------------------------
  process (lsc_gtx_txusrclk2_i, pattern_generator_enable_i)
  begin
    if    (pattern_generator_enable_i='0') then
      patgen_data_i <= X"CAFECAFE";
      patgen_en_i   <= '0';
      patgen_ctrl_i <= '0';
    elsif (lsc_gtx_txusrclk2_i'event and lsc_gtx_txusrclk2_i='1') then
      if    (lsc_lff_n_i='0') then
        patgen_data_i <= patgen_data_i;
        patgen_en_i   <= '0';
        patgen_ctrl_i <= '0';
      elsif (patgen_counter_i=timing_idle_word) then
        patgen_data_i <= patgen_data_i;
        patgen_en_i   <= '0';
        patgen_ctrl_i <= '0';
      elsif (patgen_counter_i=timing_ctrl_word) then
        patgen_data_i <= patgen_data_i;
        patgen_en_i   <= '1';
        patgen_ctrl_i <= '1';
      else 
        patgen_data_i <= patgen_data_i(0) & (not patgen_data_i(31 downto 1));
        patgen_en_i   <= '1';
        patgen_ctrl_i <= '0';
      end if;
    end if;
  end process;
  
  -- LDC pattern cheker part
  -------------------------------------
  -- pattern prediction
  -------------------------------------
  process (ldc_gtx_rxusrclk2_i)
  begin
    if (ldc_gtx_rxusrclk2_i'event and ldc_gtx_rxusrclk2_i='1') then
      if (ldc_lwen_n_i='0' and ldc_lctrl_n_i='1') then
        ld_r <= ldc_ld_i;
      end if;
      ref_data_r <= ld_r(0) & (not ld_r(31 downto 1));
      lwen_r  <= not ldc_lwen_n_i;
      lctrl_r <= not ldc_lctrl_n_i;
    end if;
  end process;
  
  -------------------------------------
  -- pattern checker
  -------------------------------------
  process (ldc_gtx_rxusrclk2_i, pattern_checker_enable_i)
  begin
    if    (pattern_checker_enable_i='0') then
      check_error_counter_i <= (others => '0');
    elsif (ldc_gtx_rxusrclk2_i'event and ldc_gtx_rxusrclk2_i='1') then
      if (lwen_r = '1' and lctrl_r='0') then
        if ((ref_data_r /= ld_r) and (and_reduce(check_error_counter_i)='0') ) then
          check_error_counter_i <= check_error_counter_i + 1;
        end if;
      end if;
    end if;
  end process;

  -------------------------------------
  -- <time line>
  -------------------------------------  
  -- time line
  process
  begin
    lsc_reset_n_i <= '1';
    ldc_reset_n_i <= '1';
    
    pattern_generator_enable_i <= '0';
    pattern_checker_enable_i   <= '0';
    wait for 10 us;
    lsc_reset_n_i <= '0'; -- enable reset
    ldc_reset_n_i <= '0'; -- enable reset
    wait for 10 us;
    lsc_reset_n_i <= '1';
    ldc_reset_n_i <= '1';
    wait for 50 us;
    pattern_generator_enable_i <= '1';
    wait for 10 us;
    pattern_checker_enable_i   <= '1';
    wait;
  end process;
  
end logic;
