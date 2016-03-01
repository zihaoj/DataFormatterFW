--
--


library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity variable_delay_fmc is
  generic (
    num_pins : integer;
    refclk_frequency : real
    );
  port (
    refclk : in  std_logic;
    reset  : in  std_logic;
    din    : in  std_logic;
    dout   : out std_logic;
    ce     : in  std_logic;
    dir    : in  std_logic
    );
  
end variable_delay_fmc;

architecture logic of variable_delay_fmc is
begin
  
  idelaye2_bus : IDELAYE2
    generic map (
      CINVCTRL_SEL           => "FALSE",            -- TRUE, FALSE
      DELAY_SRC              => "IDATAIN",        -- IDATAIN, DATAIN
      HIGH_PERFORMANCE_MODE  => "FALSE",             -- TRUE, FALSE
      IDELAY_TYPE            => "VARIABLE",          -- FIXED, VARIABLE, or VAR_LOADABLE
      IDELAY_VALUE           => 0,
      REFCLK_FREQUENCY       => refclk_frequency,
      PIPE_SEL               => "FALSE",
      SIGNAL_PATTERN         => "DATA"           -- CLOCK, DATA
      )
    port map (
      DATAOUT                => dout,
      DATAIN                 => '0', -- Data from FPGA logic
      C                      => refclk,
      CE                     => ce, --increment enable
      INC                    => dir, --'0' decrement or '1' increment
      IDATAIN                => din, -- Driven by IOB
      LD                     => reset,
      REGRST                 => '0',
      LDPIPEEN               => '0',
      CNTVALUEIN             => "00000",
      CNTVALUEOUT            => open,
      CINVCTRL               => '0'
      );
  
end;
