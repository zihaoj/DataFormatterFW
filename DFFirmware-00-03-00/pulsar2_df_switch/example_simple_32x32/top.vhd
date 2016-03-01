--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity top is
  port (
    -- SYSCLK
    SYSCLK_P : in std_logic;
    SYSCLK_N : in std_logic;
    
    -- SPI
    SCLK    : in  std_logic;
    SPI_SEL : in  std_logic;
    MOSI    : in  std_logic;
    MISO    : out std_logic
    );
end top;

architecture logic of top is
  
  component spi_interface
    port (
      -- CLK50
      CLK50    : in std_logic;
      MAIN_CLK : in std_logic;
      
      -- SPI
      SCLK    : in  std_logic;
      SPI_SEL : in  std_logic;
      MOSI    : in  std_logic;
      MISO    : out std_logic;

      -- output port
      INPUT_DATA     : in  DATA32_32x32_SWITCH_MATRIX_PORTS;
      INPUT_DATA_EN  : in  FLAGS_32x32_SWITCH_MATRIX_PORTS;
      OUTPUT_DATA    : in  DATA32_32x32_SWITCH_MATRIX_PORTS;
      OUTPUT_DATA_EN : in  FLAGS_32x32_SWITCH_MATRIX_PORTS;

      RESET_MONITOR : in  std_logic;
      SWITCH_RESET  : out std_logic;
      ENABLE_PATGEN : out std_logic
      );
  end component;
  
  component pulsar2_sysclk
    port
      (clk_in1_p : in std_logic;
       clk_in1_n : in std_logic;
       FMC_COMMON_CLK : out std_logic;
       MAIN_LOGIC_CLK : out std_logic;
       CLK50          : out std_logic;
       reset  : in  std_logic;
       locked : out std_logic
       );
  end component;

  component df_switch_matrix_32x32
    port (
      -- common clock
      CLK : in std_logic;
      RST : in std_logic;
      IN_RST : out std_logic;
      -- input port
      INPUT_DIN : in  DATA32_32x32_SWITCH_MATRIX_PORTS;
      INPUT_DEN : in  FLAGS_32x32_SWITCH_MATRIX_PORTS;
      INPUT_RDY : out FLAGS_32x32_SWITCH_MATRIX_PORTS;
      -- output port
      OUTPUT_DOUT : out DATA32_32x32_SWITCH_MATRIX_PORTS;
      OUTPUT_DEN  : out FLAGS_32x32_SWITCH_MATRIX_PORTS;
      OUTPUT_RDY  : in  FLAGS_32x32_SWITCH_MATRIX_PORTS
      );
  end component;

  component patgen
    generic (longer_period : std_logic := '0';
             const_pattern : std_logic_vector(7 downto 0) := (others => '0');
             first_word    : std_logic_vector(7 downto 0) := (others => '0'));
    port ( CLK        : in  std_logic;
           TX_DATA    : out std_logic_vector(31 downto 0);
           TX_DVALID  : out std_logic;
           TX_RDY     : in  std_logic;
           ENABLE     : in  std_logic
           );
  end component;
  
  signal main_logic_clk_i : std_logic;
  signal sys_clk_i : std_logic;
  
  signal input_din_i : DATA32_32x32_SWITCH_MATRIX_PORTS;
  signal input_den_i : FLAGS_32x32_SWITCH_MATRIX_PORTS;
  signal input_rdy_i : FLAGS_32x32_SWITCH_MATRIX_PORTS;
  
  signal output_dout_i : DATA32_32x32_SWITCH_MATRIX_PORTS;
  signal output_den_i  : FLAGS_32x32_SWITCH_MATRIX_PORTS;
  constant output_rdy_i  : FLAGS_32x32_SWITCH_MATRIX_PORTS := (others => '1');  
  
  signal enable_patgen_i : std_logic;
  signal switch_during_reset_i : std_logic;  
  signal switch_reset_i        : std_logic;  
  
  
begin

  my_spi_interface : spi_interface
    port map (
      CLK50 => sys_clk_i,
      MAIN_CLK => main_logic_clk_i,
      
      -- SPI
      SCLK    => SCLK,
      SPI_SEL => SPI_SEL,
      MOSI    => MOSI,
      MISO    => MISO,
      
      -- output port
      INPUT_DATA => input_din_i,
      INPUT_DATA_EN => input_den_i,
      OUTPUT_DATA => output_dout_i,
      OUTPUT_DATA_EN => output_den_i,

      RESET_MONITOR => switch_during_reset_i,
      SWITCH_RESET  => switch_reset_i,
      ENABLE_PATGEN => enable_patgen_i
      );
  
  clock_buffer : pulsar2_sysclk
    port map
    (clk_in1_p => SYSCLK_P,
     clk_in1_n => SYSCLK_N,
     FMC_COMMON_CLK => open,
     MAIN_LOGIC_CLK => main_logic_clk_i,
     CLK50  => sys_clk_i,
     reset  => '0',
     locked => open
     );

  my_switch_matrix : df_switch_matrix_32x32
    port map (
      CLK => main_logic_clk_i,
      RST => switch_reset_i,
      IN_RST => switch_during_reset_i,
      
      INPUT_DIN => input_din_i,
      INPUT_DEN => input_den_i,
      INPUT_RDY => input_rdy_i,
      
      OUTPUT_DOUT => output_dout_i,
      OUTPUT_DEN  => output_den_i,
      OUTPUT_RDY  => output_rdy_i
      );

  patgen_gen : for iChannel in 0 to NROW_32x32_SWITCH_MATRIX-1 generate
  begin
    my_pat_gen : patgen
      generic map (longer_period => '0',
                   const_pattern => std_logic_vector(to_unsigned(iChannel, 8)),
                   first_word    => std_logic_vector(to_unsigned(iChannel, 8)) )
      port map ( CLK => main_logic_clk_i,
                 TX_DATA => input_din_i(iChannel),
                 TX_DVALID => input_den_i(iChannel),
                 TX_RDY => input_rdy_i(iChannel),
                 ENABLE => enable_patgen_i
                 );
  end generate;
            
  
  
end logic;
