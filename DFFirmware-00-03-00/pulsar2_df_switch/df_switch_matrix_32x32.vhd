--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use work.data_formatter_constants.all;

entity df_switch_matrix_32x32 is
  generic (
    -- could be used only in intermediate switch (i.e. CENTRAL SWITCH)
    USE_RANDOM_COUNTER_IN_HEADER : boolean := false);
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
    --FIFO_INPUT1_FULL_COUNT_OUT   : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
    --FIFO_INPUT2_FULL_COUNT_OUT   : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
    --FIFO_OUTPUT1_INPUT1_FULL_OUT   : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
    --FIFO_OUTPUT1_INPUT2_FULL_OUT   : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
    --FIFO_OUTPUT2_INPUT1_FULL_OUT   : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX;
    --FIFO_OUTPUT2_INPUT2_FULL_OUT   : out FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX
    );
end df_switch_matrix_32x32;

architecture logic of df_switch_matrix_32x32 is
  
  component df_switch_element
    generic (
      -- could be used only in intermediate switch (i.e. CENTRAL SWITCH)
      USE_RANDOM_COUNTER_IN_HEADER : boolean := USE_RANDOM_COUNTER_IN_HEADER);
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
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK : in std_logic_vector(31 downto 0);
      OUTPORT2_MASK : in std_logic_vector(31 downto 0);
      -- FIFO MONITORING
      FIFO_MONITORING_OUT : out std_logic_vector(31 downto 0)
      --FIFO_INPUT1_FULL_COUNT_OUT   : out std_logic_vector(31 downto 0);
      --FIFO_INPUT2_FULL_COUNT_OUT   : out std_logic_vector(31 downto 0);
      --FIFO_OUTPUT1_INPUT1_FULL_OUT   : out std_logic_vector(31 downto 0);
      --FIFO_OUTPUT1_INPUT2_FULL_OUT   : out std_logic_vector(31 downto 0);
      --FIFO_OUTPUT2_INPUT1_FULL_OUT   : out std_logic_vector(31 downto 0);
      --FIFO_OUTPUT2_INPUT2_FULL_OUT   : out std_logic_vector(31 downto 0)
      
      );
  end component;
  
  signal data_i : INTER_MEDIATE_DATA32_FOR_32X32_SWITCH_MATRIX_MATRIX   := (others => (others => (others => '0')));
  signal den_i  : INTER_MEDIATE_FLAGS_FOR_32X32_SWITCH_MATRIX_MATRIX    := (others => (others => '0'));
  signal rdy_i  : INTER_MEDIATE_FLAGS_FOR_32X32_SWITCH_MATRIX_MATRIX    := (others => (others => '0'));
  signal rst_i  : std_logic_vector(NCOL_32X32_SWITCH_MATRIX-1 downto 0) := (others => '0');
  signal rst_control_counter : std_logic_vector(6 downto 0) := (others => '0');
  signal fifo_monitoring_i : FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX := (others => (others => (others => '0')));
  --signal fifo_input1_input_full_count_i :FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX := (others => (others => (others => '0')));
 -- signal fifo_input2_input_full_count_i : FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX := (others => (others => (others => '0')));
  --signal fifo_output1_input1_full_count_i :FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX := (others => (others => (others => '0')));
  --signal fifo_output1_input2_full_count_i :FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX := (others => (others => (others => '0')));
  --signal fifo_output2_input1_full_count_i :FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX := (others => (others => (others => '0')));
  --signal fifo_output2_input2_full_count_i :FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX := (others => (others => (others => '0')));
 
begin
  
  FIFO_MONITORING <= fifo_monitoring_i;
  --FIFO_INPUT1_FULL_COUNT_OUT   <= fifo_input1_input_full_count_i;
  --FIFO_INPUT2_FULL_COUNT_OUT   <= fifo_input2_input_full_count_i;
  --FIFO_OUTPUT1_INPUT1_FULL_OUT   <= fifo_output1_input1_full_count_i;
  --FIFO_OUTPUT1_INPUT2_FULL_OUT   <= fifo_output1_input2_full_count_i;
  --FIFO_OUTPUT2_INPUT1_FULL_OUT   <= fifo_output2_input1_full_count_i;
  --FIFO_OUTPUT2_INPUT2_FULL_OUT   <= fifo_output2_input2_full_count_i;

  
  INPUT_CONNECTION : for iInputPort in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
  begin
    data_i(0)(iInputPort) <= INPUT_DIN(iInputPort);
    den_i(0)(iInputPort)  <= INPUT_DEN(iInputPort);
    INPUT_RDY(iInputPort) <= rdy_i(0)(iInputPort);
  end generate;

  OUTPUT_CONNECTION : for iOutputPort in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
  begin
    OUTPUT_DOUT(iOutputPort)       <= data_i(NCOL_32X32_SWITCH_MATRIX)(iOutputPort);
    OUTPUT_DEN(iOutputPort)        <= den_i(NCOL_32X32_SWITCH_MATRIX)(iOutputPort);
    rdy_i(NCOL_32X32_SWITCH_MATRIX)(iOutputPort) <= OUTPUT_RDY(iOutputPort);
  end generate;  
  
  STEP_GENERATE : for i_step in 0 to NCOL_32X32_SWITCH_MATRIX-1 generate
    constant n_swtiches_in_a_block : integer := (2 ** i_step);
    begin
    SWITCH_GENERATE : for i_switch in 0 to NSWITCH_PER_COL_32X32_SWITCH_MATRIX-1 generate
      constant i_block               : integer :=  i_switch/n_swtiches_in_a_block;
      constant i_switch_in_the_block : integer := (i_switch mod n_swtiches_in_a_block);
      
      constant offset_port_in_the_block : integer := i_block*n_swtiches_in_a_block*2;
      constant offset_in_the_switch     : integer := i_switch_in_the_block;
      constant offset_port2_in_the_switch : integer := n_swtiches_in_a_block;
      
      constant input_port1 : integer := offset_port_in_the_block + offset_in_the_switch;
      constant input_port2 : integer := offset_port_in_the_block + offset_in_the_switch + offset_port2_in_the_switch;
      constant output_port1 : integer := 2*i_switch;
      constant output_port2 : integer := 2*i_switch + 1;
      
    begin
      
      SWITCH_ELEMENT : df_switch_element
        port map (
          CLK => CLK,
          RST => rst_i(i_step),
          -- input port
          INPUT_PORT1_DIN => data_i(i_step)(input_port1),
          INPUT_PORT1_DEN => den_i(i_step)(input_port1),
          INPUT_PORT1_RDY => rdy_i(i_step)(input_port1),
          INPUT_PORT2_DIN => data_i(i_step)(input_port2),
          INPUT_PORT2_DEN => den_i(i_step)(input_port2),
          INPUT_PORT2_RDY => rdy_i(i_step)(input_port2),
          -- output port
          OUTPUT_PORT1_DOUT => data_i(i_step+1)(output_port1),
          OUTPUT_PORT1_DEN  => den_i(i_step+1)(output_port1),
          OUTPUT_PORT1_RDY  => rdy_i(i_step+1)(output_port1),
          OUTPUT_PORT2_DOUT => data_i(i_step+1)(output_port2),
          OUTPUT_PORT2_DEN  => den_i(i_step+1)(output_port2),
          OUTPUT_PORT2_RDY  => rdy_i(i_step+1)(output_port2),
          -- OUTPUT MASK (CONFIGURABLE if needed)
          OUTPORT1_MASK => OUTPORT1_MASKS_32X32(i_step),
          OUTPORT2_MASK => OUTPORT2_MASKS_32X32(i_step),
          -- OUTPUT MASK (CONFIGURABLE if needed)
          FIFO_MONITORING_OUT => fifo_monitoring_i(i_step)(i_switch)
          --FIFO_INPUT1_FULL_COUNT_OUT =>  fifo_input1_input_full_count_i,
          --FIFO_INPUT2_FULL_COUNT_OUT =>  fifo_input2_input_full_count_i,
          --FIFO_OUTPUT1_INPUT1_FULL_OUT  =>  fifo_output1_input1_full_count_i,
          --FIFO_OUTPUT1_INPUT2_FULL_OUT  =>  fifo_output1_input2_full_count_i,
          --FIFO_OUTPUT2_INPUT1_FULL_OUT  =>  fifo_output2_input1_full_count_i,
          --FIFO_OUTPUT2_INPUT2_FULL_OUT  =>  fifo_output2_input2_full_count_i
          );
      
    end generate;
  end generate;
  
  process (CLK, RST)
  begin
    if (RST='1') then
      IN_RST <= '1';
      rst_i  <= (others => '1');
      rst_control_counter <= (others => '0');
    elsif (CLK'event and CLK='1') then
      if (rst_control_counter="001"&"0000") then
        rst_i(0) <= '0';
        rst_control_counter <= rst_control_counter+1;
      elsif (rst_control_counter="010"&"0000") then
        rst_i(1) <= '0';
        rst_control_counter <= rst_control_counter+1;
      elsif (rst_control_counter="011"&"0000") then
        rst_i(2) <= '0';
        rst_control_counter <= rst_control_counter+1;
      elsif (rst_control_counter="100"&"0000") then
        rst_i(3) <= '0';
        rst_control_counter <= rst_control_counter+1;
      elsif (rst_control_counter="101"&"0000") then
        rst_i(4) <= '0';
        IN_RST   <= '0';
        rst_control_counter <= rst_control_counter;
      else
        rst_control_counter <= rst_control_counter+1;
      end if;
      
    end if;
  end process;
    
end logic;
