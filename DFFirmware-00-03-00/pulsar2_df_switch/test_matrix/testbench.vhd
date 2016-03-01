--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity testbench is
end testbench;

architecture logic of testbench is
  
  component df_switch_matrix_32x32
    port (
      -- common clock
      CLK : in std_logic;
      RST : in std_logic;
      IN_RST : out std_logic;
      -- input port
      INPUT_DIN : in  DATA32_32X32_SWITCH_MATRIX_PORTS;
      INPUT_DEN : in  FLAGS_32X32_SWITCH_MATRIX_PORTS;
      INPUT_RDY : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      -- output port
      OUTPUT_DOUT : out DATA32_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_DEN  : out FLAGS_32X32_SWITCH_MATRIX_PORTS;
      OUTPUT_RDY  : in  FLAGS_32X32_SWITCH_MATRIX_PORTS;
      -- FIFO MONITORING
      FIFO_MONITORING : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX
      );
  end component;
  
  component patgen 
    generic (longer_period : std_logic := '1';
             const_pattern : std_logic_vector(7 downto 0) := (others => '0'));
    port ( CLK        : in  std_logic;
             TX_DATA    : out std_logic_vector(31 downto 0);
             TX_DVALID  : out std_logic;
             TX_RDY     : in  std_logic;
             ENABLE     : in  std_logic
             );
  end component;

  signal clk_i : std_logic;
  signal rst_i : std_logic;
  
  signal input_din_i : DATA32_32X32_SWITCH_MATRIX_PORTS;
  signal input_den_i : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal input_rdy_i : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal input_rdy_user_i : FLAGS_32X32_SWITCH_MATRIX_PORTS := X"00000000";
  
  signal output_dout_i : DATA32_32X32_SWITCH_MATRIX_PORTS;
  signal output_den_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal output_rdy_i  : FLAGS_32X32_SWITCH_MATRIX_PORTS;  
  
  signal enable_patgen_i : FLAGS_32X32_SWITCH_MATRIX_PORTS;
  signal in_rst        : std_logic;

  signal fifo_monitoring_i : FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX := (others => (others => (others => '0')));
  
begin

  process
  begin
    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;
  end process;  

  my_matrix : df_switch_matrix_32x32
    port map (
      -- common clock
      CLK => clk_i,
      RST => rst_i,
      IN_RST => in_rst,
      -- input port
      INPUT_DIN => input_din_i,
      INPUT_DEN => input_den_i,
      INPUT_RDY => input_rdy_i,
      -- output port
      OUTPUT_DOUT => output_dout_i,
      OUTPUT_DEN  => output_den_i,
      OUTPUT_RDY  => output_rdy_i,
      
      FIFO_MONITORING => fifo_monitoring_i
      );
  
  INPUT_PORTS : for iPort in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
    signal rdy_i : std_logic := '0';
  begin
    rdy_i <= input_rdy_i(iPort) and input_rdy_user_i(iPort);
    my_patgen_1 : patgen 
      generic map (longer_period => '1',
                   const_pattern => std_logic_vector(to_unsigned(iPort, 8))
                   )
      port map ( CLK => clk_i,
                 TX_DATA => input_din_i(iPort),
                 TX_DVALID => input_den_i(iPort),
                 TX_RDY => rdy_i,
                 ENABLE => enable_patgen_i(iPort)
                 );
  end generate;
  
  process
  begin
    input_rdy_user_i <= X"AAAAAAAA";
    enable_patgen_i <= (others => '0');
    output_rdy_i <= (others => '1');
    rst_i <= '1';
    wait for 5 us;
    rst_i <= '0';
    wait for 5 us;
    enable_patgen_i <= (others => '1');
    
    -- hold test
    wait for 5 us;
    output_rdy_i(0) <= '0';
    input_rdy_user_i <= X"FFFFFFFF";
    wait for 5 us;
    output_rdy_i(0) <= '1';
    wait for 5 us;
    output_rdy_i(0) <= '0';
    wait for 5 us;
    output_rdy_i(0) <= '1';
    
    
    
    wait;
  end process;
  
end logic;
