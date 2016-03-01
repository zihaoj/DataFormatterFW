------------------------------------------------------------------------------
-- PulsarIIa simple mezzanine test
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity testbench_mezz is
  generic
    (num_pins   : integer);
  port
    (LVDS_DATA_OUT_P : out std_logic_vector(num_pins-1 downto 0);
     LVDS_DATA_OUT_N : out std_logic_vector(num_pins-1 downto 0);
     CLK0_P          : out std_logic; -- clock forwarding
     CLK0_N          : out std_logic; -- clock forwarding
     SYSCLK_P        : in std_logic; -- 200MHz
     SYSCLK_N        : in std_logic; -- 200MHz
     TEST_DATA_IN    : in std_logic_vector(num_pins*2-1 downto 0);
     LED1            : out std_logic
     );
end testbench_mezz;

architecture logic of testbench_mezz is
  
  signal clk_int : std_logic;
  signal clk_int_tmp : std_logic;
  signal clk_ddr_out : std_logic;
  signal clock_locked : std_logic;
  
  component testmezz_sysclk
    port
      (-- Clock in ports
        CLK_IN1_P         : in     std_logic;
        CLK_IN1_N         : in     std_logic;
        -- Clock out ports
        CLK_OUT_200          : out    std_logic;
        CLK_OUT_300          : out    std_logic;
        CLK_OUT_400          : out    std_logic;
        CLK_OUT_600          : out    std_logic;
        -- Status and control signals
        RESET             : in     std_logic;
        LOCKED            : out    std_logic
        );
  end component;
  
begin
  LED1 <= clock_locked;
  -- clock buffering
  --clk_int <= clk_int_tmp when clock_locked = '1' else '0';
  
  clkbuf : testmezz_sysclk
    port map
    (CLK_IN1_P => SYSCLK_P,
     CLK_IN1_N => SYSCLK_N,
     CLK_OUT_200 => clk_int, --clk_int_tmp,
     CLK_OUT_300 => open,
     CLK_OUT_400 => open,
     CLK_OUT_600 => open,
     -- Status and control signals
     RESET  => '0',
     LOCKED => clock_locked
     );
  
  -- for LVDS data output with differential signaling
  -- (output level is described in UCF file; LVDS 2.5V)
  outputpins : for pin_count in 0 to num_pins-1 generate
    signal outbuf1_a : std_logic;
    signal outbuf1_b : std_logic;
    signal outbuf2   : std_logic;
  begin
    -- outbuf
    process (clk_int)
    begin
      if (clk_int'event and clk_int='1') then
        outbuf1_a  <= TEST_DATA_IN(pin_count*2)  ;
        outbuf1_b  <= TEST_DATA_IN(pin_count*2+1);
      end if;
    end process;
    
    ODDR_inst : ODDR
    generic map(
      DDR_CLK_EDGE => "OPPOSITE_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
      INIT => '0', -- Initial value for Q port ('1' or '0')
      SRTYPE => "SYNC") -- Reset Type ("ASYNC" or "SYNC")
    port map (
      Q => outbuf2, -- 1-bit DDR output
      C => clk_int, -- 1-bit clock input
      CE => '1',
      D1 => outbuf1_a, -- 1-bit data input (positive edge)
      D2 => outbuf1_b, -- 1-bit data input (negative edge)
      R => '0',
      S => '0'
      );
    
    pinout : OBUFDS
      generic map
      (IOSTANDARD => "LVDS_25")      
      port map
      ( I  => outbuf2,
        O  => LVDS_DATA_OUT_P(pin_count),
        OB => LVDS_DATA_OUT_N(pin_count)
        );
  end generate;  
  
  ODDR_inst : ODDR
    generic map(
      DDR_CLK_EDGE => "OPPOSITE_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
      INIT => '0', -- Initial value for Q port ('1' or '0')
      SRTYPE => "SYNC") -- Reset Type ("ASYNC" or "SYNC")
    port map (
      Q => clk_ddr_out, -- 1-bit DDR output
      C => clk_int, -- 1-bit clock input
      CE => '1',
      D1 => '1',
      D2 => '0',
      R => '0',
      S => '0'
      );
  
  clk_fwd : OBUFDS
    generic map
    (IOSTANDARD => "LVDS_25")
    port map
    ( I  => clk_ddr_out,
      O  => CLK0_P,
      OB => CLK0_N
      );
  
end logic;
