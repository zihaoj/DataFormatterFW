-- version 3 is using the following structure
-- INPUT FIFO 1 -- IN1-OUT1 - OUT1 merger
--              -- IN1-OUT2 - OUT2 merger
-- INPUF FIFO 2 -- IN2-OUT1 - OUT1 merger
--              -- IN2-OUT2 - OUT2 merger
-- Dead time due to waiting the other side will be reduced by this structure

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use work.data_formatter_constants.all;

entity df_switch_element is
  generic (
    -- could be used only in intermediate switch (i.e. CENTRAL SWITCH)
    USE_RANDOM_COUNTER_IN_HEADER : boolean := false);
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
end df_switch_element;

architecture logic of df_switch_element  is
  
  component df_switch_element_1ch_in is
    generic (
      USE_RANDOM_COUNTER_IN_HEADER : boolean := USE_RANDOM_COUNTER_IN_HEADER;
      BUFFER_TYPE : integer := 0 );
    port (
      -- common clock
      CLK : in std_logic;
      RST : in std_logic;
      -- input port
      INPUT_PORT_DIN : in  std_logic_vector(31 downto 0);
      INPUT_PORT_DEN : in  std_logic;
      INPUT_PORT_RDY : out std_logic;
      -- output port
      OUTPUT_PORT1_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT1_DEN  : out std_logic;
      OUTPUT_PORT1_RDY  : in  std_logic;
      OUTPUT_PORT2_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT2_DEN  : out std_logic;
      OUTPUT_PORT2_RDY  : in  std_logic;
      -- for module start control
      OUTPUT_PORT1_NEW_MOD_RDY : in std_logic;
      OUTPUT_PORT2_NEW_MOD_RDY : in std_logic;            
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK : in std_logic_vector(31 downto 0);
      OUTPORT2_MASK : in std_logic_vector(31 downto 0);
      -- for monitoring
      INPUT_PORT_EMPTY_MON : out std_logic;
      INPUT_PORT_FULL_MON  : out std_logic;
      OUTPUT_PORT1_RDY_MON : out std_logic;
      OUTPUT_PORT2_RDY_MON : out std_logic;
      OUTPUT_LANES_MON     : out std_logic_vector(2 downto 1)
      );
  end component;
  
  component df_switch_2ch_merger is
    generic (
      input_port1_use_short_fifo : std_logic := '1';
      input_port2_use_short_fifo : std_logic := '1');
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
      -- for module start control
      INPUT_PORT1_NEW_MOD_RDY : out std_logic;
      INPUT_PORT2_NEW_MOD_RDY : out std_logic;      
      -- output port
      OUTPUT_PORT_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT_DEN  : out std_logic;
      OUTPUT_PORT_RDY  : in  std_logic;
      -- for monitoring
      INPUT_PORT1_EMPTY_MON : out std_logic;
      INPUT_PORT2_EMPTY_MON : out std_logic;
      INPUT_PORT1_FULL_MON : out std_logic;
      INPUT_PORT2_FULL_MON : out std_logic;
      OUTPUT_PORT_RDY_MON   : out std_logic;
      INPUT_PORT1_SELECTED_MON : out std_logic;
      INPUT_PORT2_SELECTED_MON : out std_logic      
      );
  end component;
  
  signal intermediate_1to1_data_i : std_logic_vector(31 downto 0);
  signal intermediate_1to1_den_i  : std_logic;
  signal intermediate_1to1_rdy_i  : std_logic;
  signal intermediate_1to2_data_i : std_logic_vector(31 downto 0);
  signal intermediate_1to2_den_i  : std_logic;
  signal intermediate_1to2_rdy_i  : std_logic;  
  
  signal intermediate_2to1_data_i : std_logic_vector(31 downto 0);
  signal intermediate_2to1_den_i  : std_logic;
  signal intermediate_2to1_rdy_i  : std_logic;
  signal intermediate_2to2_data_i : std_logic_vector(31 downto 0);
  signal intermediate_2to2_den_i  : std_logic;
  signal intermediate_2to2_rdy_i  : std_logic;    

  signal intermediate_1to1_new_mod_rdy_i : std_logic;
  signal intermediate_1to2_new_mod_rdy_i : std_logic;
  signal intermediate_2to1_new_mod_rdy_i : std_logic;
  signal intermediate_2to2_new_mod_rdy_i : std_logic;
  
  -- monitoring
  signal input1_input_empty_mon_i  : std_logic;
  signal input1_input_full_mon_i  : std_logic;
  signal input1_output1_rdy_mon_i  : std_logic;
  signal input1_output2_rdy_mon_i  : std_logic;
  signal input1_output_lanes_mon_i : std_logic_vector(2 downto 1);

  signal input2_input_empty_mon_i  : std_logic;
  signal input2_input_full_mon_i  : std_logic;
  signal input2_output1_rdy_mon_i  : std_logic;
  signal input2_output2_rdy_mon_i  : std_logic;
  signal input2_output_lanes_mon_i : std_logic_vector(2 downto 1);  
  
  signal output1_input1_empty_mon_i : std_logic;
  signal output1_input2_empty_mon_i : std_logic;
  signal output1_input1_full_mon_i : std_logic;
  signal output1_input2_full_mon_i : std_logic;  
  signal output1_output_rdy_mon_i   : std_logic;
  signal output1_input1_selected_mon_i : std_logic;
  signal output1_input2_selected_mon_i : std_logic;
  
  signal output2_input1_empty_mon_i : std_logic;
  signal output2_input2_empty_mon_i : std_logic;
  signal output2_input1_full_mon_i : std_logic;
  signal output2_input2_full_mon_i : std_logic;    
  signal output2_output_rdy_mon_i   : std_logic;
  signal output2_input1_selected_mon_i : std_logic;
  signal output2_input2_selected_mon_i : std_logic;  

  signal fifo_monitoring_i : std_logic_vector(31 downto 0) := (others => '0');
 
  signal global_count : std_logic_vector(31 downto 0) := (others => '0');
  --signal fifo_input1_input_full_count_i : std_logic_vector(31 downto 0) := (others => '0');
  --signal fifo_input2_input_full_count_i : std_logic_vector(31 downto 0) := (others => '0');
  --signal fifo_output1_input1_full_count_i : std_logic_vector(31 downto 0) := (others => '0');
  --signal fifo_output1_input2_full_count_i : std_logic_vector(31 downto 0) := (others => '0');
  --signal fifo_output2_input1_full_count_i : std_logic_vector(31 downto 0) := (others => '0');
  --signal fifo_output2_input2_full_count_i : std_logic_vector(31 downto 0) := (others => '0');

begin
  
  FIFO_MONITORING_OUT <= fifo_monitoring_i;
  --FIFO_INPUT1_FULL_COUNT_OUT <= fifo_input1_input_full_count_i;
  --FIFO_INPUT2_FULL_COUNT_OUT <= fifo_input2_input_full_count_i;
  --FIFO_OUTPUT1_INPUT1_FULL_OUT <= fifo_output1_input1_full_count_i;
  --FIFO_OUTPUT1_INPUT2_FULL_OUT <= fifo_output1_input2_full_count_i;
  --FIFO_OUTPUT2_INPUT1_FULL_OUT <= fifo_output2_input1_full_count_i;
  --FIFO_OUTPUT2_INPUT2_FULL_OUT <= fifo_output2_input2_full_count_i;

  -- monitoring input 1ch swtich (1)
  fifo_monitoring_i(0) <= input1_input_empty_mon_i;
  fifo_monitoring_i(1) <= input1_input_full_mon_i;
  fifo_monitoring_i(2) <= input1_output1_rdy_mon_i;
  fifo_monitoring_i(3) <= input1_output2_rdy_mon_i;
  fifo_monitoring_i(4) <= input1_output_lanes_mon_i(1);
  fifo_monitoring_i(5) <= input1_output_lanes_mon_i(2);

  -- monitoring input 1ch swtich (2)
  fifo_monitoring_i(8)  <= input2_input_empty_mon_i;
  fifo_monitoring_i(9)  <= input2_input_full_mon_i;
  fifo_monitoring_i(10) <= input2_output1_rdy_mon_i;
  fifo_monitoring_i(11) <= input2_output2_rdy_mon_i;
  fifo_monitoring_i(12) <= input2_output_lanes_mon_i(1);
  fifo_monitoring_i(13) <= input2_output_lanes_mon_i(2);  

  -- monitoring output 2ch merger (1)
  fifo_monitoring_i(16) <= output1_input1_empty_mon_i;
  fifo_monitoring_i(17) <= output1_input2_empty_mon_i;
  fifo_monitoring_i(18) <= output1_input1_full_mon_i;
  fifo_monitoring_i(19) <= output1_input2_full_mon_i;  
  fifo_monitoring_i(20) <= output1_input1_selected_mon_i;
  fifo_monitoring_i(21) <= output1_input2_selected_mon_i;
  fifo_monitoring_i(22) <= output1_output_rdy_mon_i;

  -- monitoring output 2ch merger (1)
  fifo_monitoring_i(24) <= output2_input1_empty_mon_i;
  fifo_monitoring_i(25) <= output2_input2_empty_mon_i;
  fifo_monitoring_i(26) <= output2_input1_full_mon_i;
  fifo_monitoring_i(27) <= output2_input2_full_mon_i;  
  fifo_monitoring_i(28) <= output2_input1_selected_mon_i;
  fifo_monitoring_i(29) <= output2_input2_selected_mon_i;
  fifo_monitoring_i(30) <= output2_output_rdy_mon_i;  
  
  INPUT_POT1 : df_switch_element_1ch_in
    port map (
      CLK=>CLK,
      RST=>RST,
      -- input port
      INPUT_PORT_DIN=>INPUT_PORT1_DIN,
      INPUT_PORT_DEN=>INPUT_PORT1_DEN,
      INPUT_PORT_RDY=>INPUT_PORT1_RDY,
      -- output port
      OUTPUT_PORT1_DOUT =>intermediate_1to1_data_i,
      OUTPUT_PORT1_DEN  =>intermediate_1to1_den_i,
      OUTPUT_PORT1_RDY  =>intermediate_1to1_rdy_i,
      OUTPUT_PORT2_DOUT =>intermediate_1to2_data_i,
      OUTPUT_PORT2_DEN  =>intermediate_1to2_den_i,
      OUTPUT_PORT2_RDY  =>intermediate_1to2_rdy_i,
      -- for module start control
      OUTPUT_PORT1_NEW_MOD_RDY=>intermediate_1to1_new_mod_rdy_i,
      OUTPUT_PORT2_NEW_MOD_RDY=>intermediate_1to2_new_mod_rdy_i,
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK=>OUTPORT1_MASK,
      OUTPORT2_MASK=>OUTPORT2_MASK,
      -- for monitoring
      INPUT_PORT_EMPTY_MON => input1_input_empty_mon_i,
      INPUT_PORT_FULL_MON  => input1_input_full_mon_i,
      OUTPUT_PORT1_RDY_MON => input1_output1_rdy_mon_i,
      OUTPUT_PORT2_RDY_MON => input1_output2_rdy_mon_i,
      OUTPUT_LANES_MON     => input1_output_lanes_mon_i
      );

  INPUT_POT2 : df_switch_element_1ch_in
    port map (
      CLK=>CLK,
      RST=>RST,
      -- input port
      INPUT_PORT_DIN=>INPUT_PORT2_DIN,
      INPUT_PORT_DEN=>INPUT_PORT2_DEN,
      INPUT_PORT_RDY=>INPUT_PORT2_RDY,
      -- output port
      OUTPUT_PORT1_DOUT =>intermediate_2to1_data_i,
      OUTPUT_PORT1_DEN  =>intermediate_2to1_den_i,
      OUTPUT_PORT1_RDY  =>intermediate_2to1_rdy_i,
      OUTPUT_PORT2_DOUT =>intermediate_2to2_data_i,
      OUTPUT_PORT2_DEN  =>intermediate_2to2_den_i,
      OUTPUT_PORT2_RDY  =>intermediate_2to2_rdy_i,
      -- for module start control
      OUTPUT_PORT1_NEW_MOD_RDY=>intermediate_2to1_new_mod_rdy_i,
      OUTPUT_PORT2_NEW_MOD_RDY=>intermediate_2to2_new_mod_rdy_i,      
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK=>OUTPORT1_MASK,
      OUTPORT2_MASK=>OUTPORT2_MASK,
      -- for monitoring
      INPUT_PORT_EMPTY_MON => input2_input_empty_mon_i,
      INPUT_PORT_FULL_MON  => input2_input_full_mon_i,
      OUTPUT_PORT1_RDY_MON => input2_output1_rdy_mon_i,
      OUTPUT_PORT2_RDY_MON => input2_output2_rdy_mon_i,
      OUTPUT_LANES_MON     => input2_output_lanes_mon_i
      );  
  
  OUTPUT_PORT1 : df_switch_2ch_merger
    port map(
      -- common clock
      CLK=>CLK,
      RST=>RST,
      -- input port
      INPUT_PORT1_DIN=>intermediate_1to1_data_i,
      INPUT_PORT1_DEN=>intermediate_1to1_den_i,
      INPUT_PORT1_RDY=>intermediate_1to1_rdy_i,
      INPUT_PORT2_DIN=>intermediate_2to1_data_i,
      INPUT_PORT2_DEN=>intermediate_2to1_den_i,
      INPUT_PORT2_RDY=>intermediate_2to1_rdy_i,
      -- for module start control
      INPUT_PORT1_NEW_MOD_RDY=>intermediate_1to1_new_mod_rdy_i,
      INPUT_PORT2_NEW_MOD_RDY=>intermediate_2to1_new_mod_rdy_i,
      -- output port
      OUTPUT_PORT_DOUT=>OUTPUT_PORT1_DOUT,
      OUTPUT_PORT_DEN =>OUTPUT_PORT1_DEN,
      OUTPUT_PORT_RDY =>OUTPUT_PORT1_RDY,
      -- for monitoring
      INPUT_PORT1_EMPTY_MON => output1_input1_empty_mon_i,
      INPUT_PORT2_EMPTY_MON => output1_input2_empty_mon_i,
      INPUT_PORT1_FULL_MON => output1_input1_full_mon_i,
      INPUT_PORT2_FULL_MON => output1_input2_full_mon_i,
      OUTPUT_PORT_RDY_MON   => output1_output_rdy_mon_i,
      INPUT_PORT1_SELECTED_MON => output1_input1_selected_mon_i,
      INPUT_PORT2_SELECTED_MON => output1_input2_selected_mon_i
      );
  
  OUTPUT_PORT2 : df_switch_2ch_merger
    port map(
      -- common clock
      CLK=>CLK,
      RST=>RST,
      -- input port
      INPUT_PORT1_DIN=>intermediate_1to2_data_i,
      INPUT_PORT1_DEN=>intermediate_1to2_den_i,
      INPUT_PORT1_RDY=>intermediate_1to2_rdy_i,
      INPUT_PORT2_DIN=>intermediate_2to2_data_i,
      INPUT_PORT2_DEN=>intermediate_2to2_den_i,
      INPUT_PORT2_RDY=>intermediate_2to2_rdy_i,
      -- for module start control
      INPUT_PORT1_NEW_MOD_RDY=>intermediate_1to2_new_mod_rdy_i,
      INPUT_PORT2_NEW_MOD_RDY=>intermediate_2to2_new_mod_rdy_i,      
      -- output port
      OUTPUT_PORT_DOUT=>OUTPUT_PORT2_DOUT,
      OUTPUT_PORT_DEN =>OUTPUT_PORT2_DEN,
      OUTPUT_PORT_RDY =>OUTPUT_PORT2_RDY,
      -- for monitoring
      INPUT_PORT1_EMPTY_MON => output2_input1_empty_mon_i,
      INPUT_PORT2_EMPTY_MON => output2_input2_empty_mon_i,
      INPUT_PORT1_FULL_MON => output2_input1_full_mon_i,
      INPUT_PORT2_FULL_MON => output2_input2_full_mon_i,      
      OUTPUT_PORT_RDY_MON   => output2_output_rdy_mon_i,
      INPUT_PORT1_SELECTED_MON => output2_input1_selected_mon_i,
      INPUT_PORT2_SELECTED_MON => output2_input2_selected_mon_i
      );
  
end logic;

----------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.std_logic_arith.all;
    
entity GrayAddressCounter is
    generic (
      COUNTER_WIDTH :integer := 4
    );
    port (                                  --'Gray' code count output.
      GrayCount_out   :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      -- "NEXT" Binary Counter Out
      BinaryCount_out :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      Enable_in       :in  std_logic;       -- Count enable.
      Clear_in        :in  std_logic;       -- Count reset.
      clk             :in  std_logic        -- Input clock
    );  
end GrayAddressCounter;

architecture rtl of GrayAddressCounter is
  signal BinaryCount :std_logic_vector (COUNTER_WIDTH-1 downto 0) := conv_std_logic_vector(0, COUNTER_WIDTH);
begin
  

  BinaryCount_out <= BinaryCount; 
  process (clk, Clear_in)
  begin
    if (Clear_in = '1') then
      --Gray count begins @ '1' with
      BinaryCount   <= conv_std_logic_vector(1, COUNTER_WIDTH);  
      GrayCount_out <= (others=>'0');
      
    elsif (clk'event and clk='1') then
      -- first 'Enable_in'.
      if (Enable_in = '1') then
        BinaryCount   <= BinaryCount + 1;
        GrayCount_out <= (BinaryCount(COUNTER_WIDTH-1) & 
                          (BinaryCount(COUNTER_WIDTH-2 downto 0) xor 
                           BinaryCount(COUNTER_WIDTH-1 downto 1)));
      end if;
    end if;
  end process;
  
end rtl;


----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity short_fwft_fifo is
  generic (
    AddressWidth : integer := 5 );
  port (
    clk : in std_logic;
    rst : in std_logic;
    din : in std_logic_vector ( 35 downto 0 );
    wr_en : in std_logic;
    rd_en : in std_logic;
    dout : out std_logic_vector ( 35 downto 0 );
    empty : out std_logic;
    ready_for_new_module : out std_logic;
    prog_full : out std_logic
    );
end short_fwft_fifo;

architecture logic of short_fwft_fifo is
  
  constant NStage       : integer := 2**AddressWidth;
  
  type short_buffer_t is array (0 to NStage-1) of std_logic_vector (35 downto 0);
  signal buf        : short_buffer_t := (others => (others => '0'));
  signal raddr      : std_logic_vector (AddressWidth-1 downto 0);
  signal raddr_inc  : std_logic := '0';
  signal waddr      : std_logic_vector (AddressWidth-1 downto 0);
  signal raddr_bin  : std_logic_vector (AddressWidth-1 downto 0);
  signal waddr_bin  : std_logic_vector (AddressWidth-1 downto 0);  
  signal empty_buf  : std_logic := '1';
  signal ready_for_new_module_buf : std_logic;
  
  component GrayAddressCounter
    generic (
      COUNTER_WIDTH :integer := AddressWidth
      );
    port (                                  --'Gray' code count output.
      GrayCount_out   :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      -- "NEXT" Binary Counter Out
      BinaryCount_out :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      Enable_in       :in  std_logic;       -- Count enable.
      Clear_in        :in  std_logic;       -- Count reset.
      clk             :in  std_logic        -- Input clock
      );  
  end component;
  
begin
  
   
  WriteAddress : GrayAddressCounter
    port map (
      GrayCount_out=>waddr, BinaryCount_out=>waddr_bin, Enable_in =>wr_en, Clear_in =>rst, clk=>clk);
  
  ReadAddress : GrayAddressCounter
    port map (
      GrayCount_out=>raddr, BinaryCount_out=>raddr_bin, Enable_in =>raddr_inc, Clear_in =>rst, clk=>clk);  
  
  dout <= buf(CONV_INTEGER(raddr));
  
  FullHandler : process (clk, rst)
  
  --process (clk)
  --if (clk'event and clk='1') then
  --    if (global_count = x'FFFFFFFF') then
  --      global_count <=x'00000000';
  --      fifo_input1_input_full_count_i <= (others => '0');
  --      fifo_input2_input_full_count_i <= (others => '0');
  --      fifo_output1_input1_full_count_i <= (others => '0');
  --      fifo_output1_input2_full_count_i <= (others => '0');
  --      fifo_output2_input1_full_count_i <= (others => '0');
  --      fifo_output2_input2_full_count_i <= (others => '0');
  --    else
  --      if(input1_input_full_mon_i ='1') then
  --          fifo_input1_input_full_count_i <= fifo_input1_input_full_count_i + 1;
  --      if(input2_input_full_mon_i ='1') then
  --          fifo_input2_input_full_count_i <= fifo_input2_input_full_count_i + 1;
  --      if(output1_input1_full_mon_i = '1') then
  --          fifo_output1_input1_full_count_i <= fifo_output1_input1_full_count_i + 1;
  --      if(output1_input2_full_mon_i = '1') then
  --          fifo_output1_input2_full_count_i <= fifo_output1_input2_full_count_i + 1;
  --      if(output2_input1_full_mon_i = '1') then
  --          fifo_output2_input1_full_count_i <= fifo_output2_input1_full_count_i + 1;
  --      if(output2_input2_full_mon_i = '1') then
  --         fifo_output2_input2_full_count_i <= fifo_output2_input2_full_count_i + 1;
  --    end if;
  --  end if;
  --end process;

  
  
  begin
    if    (rst='1') then
      prog_full <= '1';
    elsif (clk'event and clk='1') then
      ready_for_new_module <= ready_for_new_module_buf;
      if ((CONV_INTEGER(waddr_bin)+NStage-CONV_INTEGER(raddr_bin)) mod NStage) < 10 then
        ready_for_new_module_buf <= '1';
      else
        ready_for_new_module_buf <= '0';
      end if;
        
      if ((CONV_INTEGER(waddr_bin)+NStage-CONV_INTEGER(raddr_bin)) mod NStage) > NStage-7 then
        prog_full <= '1';
      else
        prog_full <= '0';
      end if;
    end if;
  end process;
  
  empty     <= empty_buf;
  raddr_inc <= '1' when ((empty_buf='0') and (rd_en='1')) else '0';
  EmptyHandler : process (clk, rst)
  begin
    if    (rst='1') then
      empty_buf <= '1';
    elsif (clk'event and clk='1') then
      if (empty_buf = '1') then
        if (wr_en='1') then
          empty_buf <= '0';
        end if;
      else 
        if (rd_en='1' and wr_en='0' and raddr_bin+1=waddr_bin) then
        --if (wr_en='0' and raddr_bin+1=waddr_bin) then
          empty_buf <= '1';
        end if;
      end if;
    end if;
  end process;  
  
  WriteOperator : process (clk)
  begin
    if (clk'event and clk='1') then
      if (wr_en='1') then
        buf(CONV_INTEGER(waddr)) <= din;
      end if;
    end if;
  end process;

end logic;
