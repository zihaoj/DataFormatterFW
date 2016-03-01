--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity FMC_RX_CLOCK_BUFMR is
  generic (default_delay : integer;
           refclk_frequency : real);  
  port
    ( -- Clock in ports
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
end FMC_RX_CLOCK_BUFMR;

architecture xilinx of FMC_RX_CLOCK_BUFMR is
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of xilinx : architecture is "FMC_RX_CLOCK,clk_wiz_v3_6,{component_name=FMC_RX_CLOCK,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,feedback_source=FDBK_AUTO,primtype_sel=MMCM_ADV,num_out_clk=1,clkin1_period=5.000,clkin2_period=10.0,use_power_down=false,use_reset=true,use_locked=true,use_inclk_stopped=false,use_status=false,use_freeze=false,use_clk_valid=false,feedback_type=SINGLE,clock_mgr_type=MANUAL,manual_override=false}";
  -- Input clock buffering / unused connectors
  signal clkin1       : std_logic;
  signal clkin1_delay : std_logic;
  signal clkmr_buf    : std_logic;
begin
  
  -- Input buffering
  --------------------------------------
  clkin1_buf : IBUFGDS
    generic map (
      DIFF_TERM => TRUE,
      IOSTANDARD => "LVDS")
    port map
    (O  => clkin1,
     I  => CLK_IN1_P,
     IB => CLK_IN1_N);
  
  idelaye2_bus : IDELAYE2
    generic map (
      CINVCTRL_SEL           => "FALSE",            -- TRUE, FALSE
      DELAY_SRC              => "IDATAIN",        -- IDATAIN, DATAIN
      HIGH_PERFORMANCE_MODE  => "FALSE",             -- TRUE, FALSE
      IDELAY_TYPE            => "VARIABLE",          -- FIXED, VARIABLE, or VAR_LOADABLE
      IDELAY_VALUE           => default_delay,                -- 0 to 31
      REFCLK_FREQUENCY       => refclk_frequency,
      PIPE_SEL               => "FALSE",
      SIGNAL_PATTERN         => "CLOCK"           -- CLOCK, DATA
      )
    port map (
      DATAOUT                => clkin1_delay,
      DATAIN                 => '0', -- Data from FPGA logic
      C                      => REF_CLK,
      CE                     => CLKDELAY_CE, --increment enable
      INC                    => CLKDELAY_DIR, --'0' decrement or '1' increment
      IDATAIN                => clkin1, -- Driven by IOB
      LD                     => DELAY_RESET,
      REGRST                 => '0',
      LDPIPEEN               => '0',
      CNTVALUEIN             => "00000",
      CNTVALUEOUT            => open,
      CINVCTRL               => '0'
      );  
  
  BUFMRCE_inst : BUFMRCE
    generic map (
      CE_TYPE => "SYNC", -- "SYNC" or "ASYNC"
      INIT_OUT => 0 -- Initial output and stopped polarity,(1 or 0)
      )
    port map (
      O  => clkmr_buf, -- 1-bit output: Clock buffer output (connect to BUFIOs/BUFRs)
      CE => '1', -- 1-bit input: Active high buffer enable input
      I  => clkin1_delay -- 1-bit input: Clock buffer input (Connect to IBUFG)
      );

  --BUFIO Region-1
  --BUFIO_R1 : BUFIO
  --  port map (
  --    O => CLK_OUT_R1, -- 1-bit output: Clock output port (connect to I/O clock loads).
  --    I => clkmr_buf   -- 1-bit input: Clock input port (connect to an IBUFG or BUFMR).
  --  );
  
  BUFR_R1 : BUFR
    generic map (
      BUFR_DIVIDE => "BYPASS",
      SIM_DEVICE => "7SERIES")
    port map (
      O  => CLK_OUT_R1,
      CE => '1',
      CLR => '0',
      I => clkmr_buf
      );
  
  ---- BUFIO Region-2
  --BUFIO_R2 : BUFIO
  --  port map (
  --    O => CLK_OUT_R2, -- 1-bit output: Clock output port (connect to I/O clock loads).
  --    I => clkmr_buf   -- 1-bit input: Clock input port (connect to an IBUFG or BUFMR).
  --  ); 

  BUFR_R2 : BUFR
    generic map (
      BUFR_DIVIDE => "BYPASS",
      SIM_DEVICE => "7SERIES")
    port map (
      O  => CLK_OUT_R2,
      CE => '1',
      CLR => '0',
      I => clkmr_buf
      );
  
end xilinx;
