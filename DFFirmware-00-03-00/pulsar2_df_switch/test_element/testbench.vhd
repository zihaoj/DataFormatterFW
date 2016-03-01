--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

entity testbench is
end testbench;

use work.data_formatter_constants.all;

architecture logic of testbench is
  
  component df_switch_element
    port (
      -- common clock
      CLK : in std_logic;
      RST : in std_logic;
      -- input port
      INPUT_PORT1_DIN : in  std_logic_vector(31 downto 0);
      INPUT_PORT1_DEN : in  std_logic;
      INPUT_PORT1_RDY : out std_logic;
      INPUT_PORT2_DIN : in  std_logic_vector(31 downto 0);
      INPUT_PORT2_DEN : in  std_logic;
      INPUT_PORT2_RDY : out std_logic;
      -- output port
      OUTPUT_PORT1_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT1_DEN  : out std_logic;
      OUTPUT_PORT1_RDY  : in  std_logic;
      OUTPUT_PORT2_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT2_DEN  : out std_logic;
      OUTPUT_PORT2_RDY  : in  std_logic;
      
      OUTPORT1_MASK : std_logic_vector(31 downto 0);
      OUTPORT2_MASK : std_logic_vector(31 downto 0)
      );
  end component;
  
  component patgen 
    generic (longer_period : std_logic := '0';
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
  signal input_port1_din_i : std_logic_vector(31 downto 0);
  signal input_port1_den_i : std_logic;
  signal input_port1_rdy_i : std_logic;
  signal input_port2_din_i : std_logic_vector(31 downto 0);
  signal input_port2_den_i : std_logic;
  signal input_port2_rdy_i : std_logic;
  signal output_port1_dout_i : std_logic_vector(31 downto 0);
  signal output_port1_den_i : std_logic;
  signal output_port1_rdy_i : std_logic;
  signal output_port2_dout_i : std_logic_vector(31 downto 0);
  signal output_port2_den_i : std_logic;
  signal output_port2_rdy_i : std_logic;
  
  signal enable_port1_i : std_logic;
  signal enable_port2_i : std_logic;
  
begin

  process
  begin
    clk_i <= '0';
    wait for 5 ns;
    clk_i <= '1';
    wait for 5 ns;
  end process;
  
  my_element : df_switch_element
    port map ( CLK => clk_i,
               RST => rst_i,
               INPUT_PORT1_DIN => input_port1_din_i, 
               INPUT_PORT1_DEN => input_port1_den_i, 
               INPUT_PORT1_RDY => input_port1_rdy_i,
               INPUT_PORT2_DIN => input_port2_din_i,
               INPUT_PORT2_DEN => input_port2_den_i,
               INPUT_PORT2_RDY => input_port2_rdy_i,
               OUTPUT_PORT1_DOUT => output_port1_dout_i,
               OUTPUT_PORT1_DEN  => output_port1_den_i,
               OUTPUT_PORT1_RDY  => output_port1_rdy_i,
               OUTPUT_PORT2_DOUT => output_port2_dout_i,
               OUTPUT_PORT2_DEN  => output_port2_den_i,
               OUTPUT_PORT2_RDY  => output_port2_rdy_i,
               OUTPORT1_MASK => OUTPORT1_MASKS_32X32(0),
               OUTPORT2_MASK => OUTPORT2_MASKS_32X32(0)
               
               );

  patgen_1 : patgen 
    generic map (longer_period => '0',
                 const_pattern => X"CC"
                 )
    port map ( CLK => clk_i,
               TX_DATA => input_port1_din_i,
               TX_DVALID => input_port1_den_i,
               TX_RDY => input_port1_rdy_i,
               ENABLE => enable_port1_i
               );

  patgen_2 : patgen 
    generic map (longer_period => '1',
                 const_pattern => X"DD"
                 )
    port map ( CLK => clk_i,
               TX_DATA => input_port2_din_i,
               TX_DVALID => input_port2_den_i,
               TX_RDY => input_port2_rdy_i,
               ENABLE => enable_port2_i
               );

  process
  begin
    enable_port1_i <= '0';
    enable_port2_i <= '0';
    output_port1_rdy_i <= '1';
    output_port2_rdy_i <= '1';
    rst_i <= '1';
    wait for 5 us;
    rst_i <= '0';
    wait for 5 us;
    enable_port1_i <= '1';
    
    wait for 10 us;    
    enable_port2_i <= '1';

    -- hold test
    wait for 5 us;
    output_port1_rdy_i <= '0';
    wait for 5 us;
    output_port1_rdy_i <= '1';
    wait for 5 us;
    output_port1_rdy_i <= '0';
    wait for 5 us;
    output_port1_rdy_i <= '1';
    wait;
  end process;
  
  
end logic;
