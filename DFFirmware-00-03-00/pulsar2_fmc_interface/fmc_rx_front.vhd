------------------------------------------------------------------------------
-- PulsarIIb
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.FmcConstants.all;

entity fmc_rx_front is
  generic
    ( FMC_ID     : integer ; --FB1/2/3/4
      FPGA_ID    : integer ; --FPGA0/1
      common_clk_frequency : real);
  port
    (
      -- <FMC COMMON CLOCK>
      -- must be exactly same frequency clock with the forwarded one
      -- used as reference clock for variable delay, too
      FMC_COMMON_CLK : in std_logic;
      
      -- <FMC IN>
      FMCIN_LVDS_DATA_IN_P : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      FMCIN_LVDS_DATA_IN_N : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      FMCIN_CLK_P : in std_logic;
      FMCIN_CLK_N : in std_logic;
      
      -- <CONFIGURE>
      CONFIG_CLKDELAY_DIR : in std_logic;
      CONFIG_CLKDELAY_CE  : in std_logic;
      CONFIG_CLK_INV      : in std_logic;
      CONFIG_CHANNELDELAY_DIR : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      CONFIG_CHANNELDELAY_CE  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      CONFIG_DELAY_RESET      : in  std_logic;
      
      -- <FIFO clock domain boundary between Regional Clock / FMC common clock>
      CONFIG_FIFO_RESET  : in  std_logic;
      CONFIG_FIFO_FULL   : out std_logic;
      CONFIG_FIFO_ERROR  : out std_logic; 
      
      -- <FRONT TO MAPPER - sync to FMC_COMMON_CLK>
      FRONT_TO_MAPPER_DOUT : out std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0) := (others => '0')
      );
end fmc_rx_front;

architecture logic of fmc_rx_front is 
  constant fmc_fpga_id : integer := (FMC_ID-1)*2 + FPGA_ID;
  
  signal din_buf     : std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0) := (others => '0');
  signal din_buf2    : std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0) := (others => '0');
  signal din_delayed : std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0) := (others => '0');
  
  signal clk_buf_tmp : std_logic_vector(1 downto 0);
  signal clk_buf     : std_logic_vector(1 downto 0);
  
  constant fifo_din_dummy_zero : std_logic_vector(35-2*lvds_pairs_for_rx_in_each_fpga downto 0) := (others => '0');
  
  signal fifo_dout_float_buf_r0 : std_logic_vector(35-2*lvds_pairs_for_rx_in_each_fpga downto 0);
  signal fifo_dout_float_buf_r1 : std_logic_vector(35-2*lvds_pairs_for_rx_in_each_fpga downto 0);

  constant word_fifo_din_dummy_zero : std_logic_vector(35 downto 2*lvds_pairs_for_rx_in_each_fpga) := (others => '0');
  
  type channel_vector_for_two_region is
    array (number_of_banks_for_each_fpga-1 downto 0)  of std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
  signal fifo_din  : channel_vector_for_two_region := (others => (others => '0'));
  signal fifo_dout : channel_vector_for_two_region := (others => (others => '0'));

  -- FIFO control for word in region0
  signal fifo_empty_r0 : std_logic;
  signal fifo_full_r0  : std_logic;
  -- FIFO control for word in region1
  signal fifo_empty_r1 : std_logic;
  signal fifo_full_r1  : std_logic;

 
  constant rx_swap_mask_channel_in_the_fpga :
    std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0) := rx_swap_mask_channel_in_fpga(fmc_fpga_id);
  
  constant bank_position_in_the_fpga :
    bank_position_map_from_fpga_t := bank_position_in_fpga(fmc_fpga_id);
  
  component variable_delay_fmc
    generic (
      num_pins : integer;
      refclk_frequency : real);
    port (
      refclk : in  std_logic;
      reset  : in  std_logic;
      din    : in  std_logic;
      dout   : out std_logic;
      ce     : in  std_logic;
      dir    : in  std_logic
      );
  end component;
  
  component FMC_RX_CLOCK_BUFMR
    generic (default_delay : integer;
             refclk_frequency : real);
    port (-- Clock in ports
      CLK_IN1_P         : in     std_logic;
      CLK_IN1_N         : in     std_logic;
      -- Clock out ports
      CLK_OUT_R1        : out    std_logic;
      CLK_OUT_R2        : out    std_logic;
      -- Clock delay
      DELAY_RESET       : in std_logic;      
      REF_CLK           : in std_logic;
      CLKDELAY_DIR      : in std_logic;
      CLKDELAY_CE       : in std_logic      
      );
  end component;  

  component fwft_ic_w36_d512_my_wrapper
    port (
      rst : in std_logic;
      wr_clk : in std_logic;
      rd_clk : in std_logic;
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      empty : out std_logic;
      prog_full : out std_logic
      );
  end component;
  
begin

  -- input buffer IDDR deserializer
  inputpins : for pin_count in 0 to lvds_pairs_for_rx_in_each_fpga-1 generate
    signal din_buf1_a : std_logic := '0';
    signal din_buf1_b : std_logic := '0';
    signal din_buf2_a : std_logic := '0';
    signal din_buf2_b : std_logic := '0';
    signal din_buf2_a_inv : std_logic := '0';
    signal din_buf2_b_inv : std_logic := '0';
    
    signal regional_clk : std_logic;
    constant bank_pos : integer := bank_position_in_the_fpga(pin_count);
    signal counter_value_i: std_logic_vector(4 downto 0);

    --attribute mark_debug : string; 
    --attribute mark_debug of counter_value_i  : signal is "true";
    
  begin
    
    regional_clk <= clk_buf(bank_pos);
    
    pinout : IBUFDS
      generic map (
        DIFF_TERM => TRUE,
        IOSTANDARD => "LVDS")
      port map
      ( I  => FMCIN_LVDS_DATA_IN_P(pin_count),
        IB => FMCIN_LVDS_DATA_IN_N(pin_count),
        O  => din_buf(pin_count)
        );
    
    --IDELAYE2_bus : IDELAYE2
    --  generic map (
    --   CINVCTRL_SEL           => "FALSE",        -- TRUE, FALSE
    --  DELAY_SRC              => "IDATAIN",      -- IDATAIN, DATAIN
    --   HIGH_PERFORMANCE_MODE  => "FALSE",        -- TRUE, FALSE
    --   IDELAY_TYPE            => "VARIABLE",     -- FIXED, VARIABLE, or VAR_LOADABLE
    --   IDELAY_VALUE           => 0,
    --   REFCLK_FREQUENCY       => 200.00,
    --   PIPE_SEL               => "FALSE",
    --   SIGNAL_PATTERN         => "DATA"          -- CLOCK, DATA
    --   )
    --  port map (
    --   DATAOUT                => din_delayed(pin_count),
    --   DATAIN                 => '0',    -- Data from FPGA logic
    --   C                      => FMC_COMMON_CLK,
    --  CE                     => CONFIG_CHANNELDELAY_CE(pin_count),     --increment enable
    --   INC                    => CONFIG_CHANNELDELAY_DIR(pin_count),    --'0' decrement or '1' increment
    --   IDATAIN                => din_buf(pin_count),-- Driven by IOB
    --   LD                     => CONFIG_DELAY_RESET,
    --   REGRST                 => '0',
    --   LDPIPEEN               => '0',
    --   CNTVALUEIN             => "00000",
       --CNTVALUEOUT            => open,
    --   CNTVALUEOUT            => counter_value_i,
    --   CINVCTRL               => '0'
    --  );

    --delay
    channel_delay : variable_delay_fmc
      generic map (num_pins => lvds_pairs_for_rx_in_each_fpga, refclk_frequency=> common_clk_frequency)
      port map (
        refclk => FMC_COMMON_CLK,
        reset  => CONFIG_DELAY_RESET,
        din    => din_buf(pin_count),
        dout   => din_delayed(pin_count),
        ce     => CONFIG_CHANNELDELAY_CE(pin_count),
        dir    => CONFIG_CHANNELDELAY_DIR(pin_count)
      );
    
    IDDR_inst : IDDR
      generic map (
        DDR_CLK_EDGE => "OPPOSITE_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
        -- or "SAME_EDGE_PIPELINED"
        INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
        INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
        SRTYPE => "SYNC") -- Set/Reset type: "SYNC" or "ASYNC"
      port map (
        Q1 => din_buf1_a, -- 1-bit output for positive edge of clock
        Q2 => din_buf1_b, -- 1-bit output for negative edge of clock
        C  => regional_clk, -- 1-bit clock input
        CE => '1', -- 1-bit clock enable input
        D  => din_delayed(pin_count), -- 1-bit DDR data input
        R  => '0', -- 1-bit reset
        S  => '0' -- 1-bit set
        );
    
    process (regional_clk)
    begin
      if (regional_clk'event and regional_clk='1') then
        if (CONFIG_CLK_INV='0') then
          din_buf2(2*pin_count)   <= din_buf2_a;
          din_buf2(2*pin_count+1) <= din_buf2_b;
        else
          din_buf2(2*pin_count+1) <= din_buf2_a_inv;
          din_buf2(2*pin_count)   <= din_buf2_b_inv;
        end if;
      end if;
    end process;
    
    process (regional_clk)
    begin -- nominal capture timing is falling edge
      if (regional_clk'event and regional_clk='0') then 
        din_buf2_a <= din_buf1_a xor rx_swap_mask_channel_in_the_fpga(pin_count);
        din_buf2_b <= din_buf1_b xor rx_swap_mask_channel_in_the_fpga(pin_count);
      end if;
    end process;
    
    process (regional_clk)       
    begin -- to invert clock phase (effectively) capture timing is rising edge
      if (regional_clk'event and regional_clk='1') then
        din_buf2_a_inv <= din_buf1_a xor rx_swap_mask_channel_in_the_fpga(pin_count);
        din_buf2_b_inv <= din_buf1_b xor rx_swap_mask_channel_in_the_fpga(pin_count);
      end if;
    end process;

    -- final latch to solve timing constraint
    process (regional_clk)
    begin
      if (regional_clk'event and regional_clk='1') then
        fifo_din(bank_pos)(2*pin_count)   <= din_buf2(2*pin_count);
        fifo_din(bank_pos)(2*pin_count+1) <= din_buf2(2*pin_count+1);
      end if;
    end process;    
  end generate;
  
  --buf200 : FMC_RX_CLOCK -- regional clock buffer
  buf200 : FMC_RX_CLOCK_BUFMR
    generic map (
      default_delay => 0,
      refclk_frequency => common_clk_frequency)
    port map (
      -- Clock in ports
      CLK_IN1_P => FMCIN_CLK_P,
      CLK_IN1_N => FMCIN_CLK_N,
      -- Clock out ports
      CLK_OUT_R1 => clk_buf_tmp(0),
      CLK_OUT_R2 => clk_buf_tmp(1),
      -- Clock delay
      DELAY_RESET  => CONFIG_DELAY_RESET,
      REF_CLK      => FMC_COMMON_CLK,
      CLKDELAY_DIR => CONFIG_CLKDELAY_DIR,
      CLKDELAY_CE  => CONFIG_CLKDELAY_CE
      );
    
  clk_buf(0) <= clk_buf_tmp(0) xor swap_mask_clk(fmc_fpga_id);
  clk_buf(1) <= clk_buf_tmp(1) xor swap_mask_clk(fmc_fpga_id);
  
  ------------------------------------------------------------------
  FIFO_Region0 : fwft_ic_w36_d512_my_wrapper -- !! not elastic !! --
    port map (rst=>CONFIG_FIFO_RESET, wr_clk=>clk_buf(0), rd_clk=>FMC_COMMON_CLK,
              din(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0)=>fifo_din(0),
              din(35 downto 2*lvds_pairs_for_rx_in_each_fpga)=>word_fifo_din_dummy_zero,
              wr_en=>'1', rd_en=>'1',
              dout(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0)=>fifo_dout(0),
              dout(35 downto 2*lvds_pairs_for_rx_in_each_fpga)=>fifo_dout_float_buf_r0,
              prog_full=>fifo_full_r0, empty=>fifo_empty_r0);
  
  ------------------------------------------------------------------
  FIFO_Region1 : fwft_ic_w36_d512_my_wrapper -- !! not elastic !! --
    port map (rst=>CONFIG_FIFO_RESET, wr_clk=>clk_buf(1), rd_clk=>FMC_COMMON_CLK,
              din(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0)=>fifo_din(1),
              din(35 downto 2*lvds_pairs_for_rx_in_each_fpga)=>word_fifo_din_dummy_zero,
              wr_en=>'1', rd_en=>'1',
              dout(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0)=>fifo_dout(1),
              dout(35 downto 2*lvds_pairs_for_rx_in_each_fpga)=>fifo_dout_float_buf_r1,
              prog_full=>fifo_full_r1, empty=>fifo_empty_r1);    
  
  -- input buffer 
  FormOutput : for pin_count in 0 to lvds_pairs_for_rx_in_each_fpga-1 generate
    constant bank_pos : integer := bank_position_in_the_fpga(pin_count);
  begin
    process (FMC_COMMON_CLK)
    begin
      if (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
        FRONT_TO_MAPPER_DOUT(2*pin_count)   <= fifo_dout(bank_pos)(2*pin_count);
        FRONT_TO_MAPPER_DOUT(2*pin_count+1) <= fifo_dout(bank_pos)(2*pin_count+1);
      end if;
    end process;    
  end generate;
  
  ------------------------------------------------------------------
  -- consistency checker
  ------------------------------------------------------------------
  CONFIG_FIFO_FULL <= fifo_full_r0;
  process (FMC_COMMON_CLK, CONFIG_FIFO_RESET)
  begin
    if (CONFIG_FIFO_RESET='1') then
      CONFIG_FIFO_ERROR <= '0';
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      if ((fifo_empty_r1 /= fifo_empty_r0) or
          (fifo_full_r1  /= fifo_full_r0)
          ) then
        CONFIG_FIFO_ERROR <= '1';
      end if;
    end if;
  end process;
  
end logic;
