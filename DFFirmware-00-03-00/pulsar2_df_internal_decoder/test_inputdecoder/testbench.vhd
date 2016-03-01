------------------------------------------------------------------------------
-- PulsarII
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;

use work.data_formatter_constants.all;

entity testbench is
end testbench;

architecture logic of testbench is
  
  component TestPatternTx
    port (
      -- output synchronized to LSCCLOCK
      DataOut             : out std_logic_vector(31 downto 0); 
      ControlWord         : out std_logic := '1';
      EnaOut              : out std_logic := '0';
      -- SLINK Control Input
      Slink_LFF_N         : in  std_logic; -- LFF_N is set low when only one half or fewer cells are
                                           -- still free to allow a response time in the write process
      -- clock
      L1ACLOCK            : in  std_logic;
      LSCCLOCK            : in  std_logic;
      -- L1 Trigger
      L1A                 : in  std_logic; -- pulse signal synchronized to L1ACLOCK
      -- RESET
      RESET               : in  std_logic
      );
  end component;
  
  component fmc_input_buffer
    port
      ( -- PORT A
        FMC_CLK_IN : in std_logic; -- WRITE CLOCK
        FMC_DATA_IN    : in std_logic_vector(31 downto 0);
        FMC_CTRL_IN    : in std_logic;
        FMC_DEN_IN     : in std_logic;
        
        -- PORT B
        MAIN_CLK        : in  std_logic; -- READ CLOCK
        DATA_OUT        : out std_logic_vector(31 downto 0);
        CTRL_OUT        : out std_logic;
        DEN_OUT         : out std_logic;
        FIFO_GO_NEXT_IF_EXIST_IN : in  std_logic;
        
        -- FLOW CONTROL
        RESET         : in  std_logic;
        FIFO_FULL_OUT : out std_logic;
        FIFO_BUSY_OUT : out std_logic);
  end component;
  
  component df_input_lane_handler
    port
      ( MAIN_CLK : in  std_logic;
        RESET_IN : in  std_logic;
        
        -- <input>
        DATA_IN  : in  DF_INPUT_DATA_ARRAY;
        CTRL_IN  : in  std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        DEN_IN   : in  std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        FIFO_GO_NEXT_IF_EXIST_OUT : out std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        
        -- <output 1>
        MODDATA_DATA_OUT : out DF_INPUT_DATA_ARRAY;
        MODDATA_WEN_OUT  : out std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        MODDATA_XOFF_IN  : in  std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        
        -- <output 2 event header / traier>
        FRAME_DATA_OUT : out std_logic_vector(31 downto 0);
        FRAME_WEN_OUT  : out std_logic;
        FRAME_CTRL_OUT : out std_logic;      
        FRAME_XOFF_IN  : in  std_logic;      
        
        INPUT_ENABLE_MASK     : in  std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        FRAME_DOUT_LANEID     : in  integer range 0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1;
        
        -- <configuration / monitoring port>
        MOD2IDX_ADDR_CONFIN   : in  DF_INPUT_MOD2IDX_ADDR_ARRAY;
        MOD2IDX_DATA_CONFIN   : in  DF_INPUT_MOD2IDX_DATA_ARRAY;
        MOD2IDX_WEN_CONFIN    : in  std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        MOD2IDX_DATA_CONFOUT  : out DF_INPUT_MOD2IDX_DATA_ARRAY;
        
        -- <configuration / monitoring port>
        IDX2MOD_ADDR_CONFIN   : in  DF_INPUT_IDX2MOD_ADDR_ARRAY;
        IDX2MOD_DATA_CONFIN   : in  DF_INPUT_IDX2MOD_DATA_ARRAY;
        IDX2MOD_WEN_CONFIN    : in  std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        IDX2MOD_DATA_CONFOUT  : out DF_INPUT_IDX2MOD_DATA_ARRAY;
        
        -- <configuration / monitoring port>
        PIXMOD2DST_ADDR_CONFIN   : in  DF_INPUT_PIXMOD2DST_ADDR_ARRAY;
        PIXMOD2DST_DATA_CONFIN   : in  DF_INPUT_PIXMOD2DST_DATA_ARRAY;
        PIXMOD2DST_WEN_CONFIN    : in  std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        PIXMOD2DST_DATA_CONFOUT  : out DF_INPUT_PIXMOD2DST_DATA_ARRAY;

        SCTMOD2DST_ADDR_CONFIN   : in  DF_INPUT_SCTMOD2DST_ADDR_ARRAY;
        SCTMOD2DST_DATA_CONFIN   : in  DF_INPUT_SCTMOD2DST_DATA_ARRAY;
        SCTMOD2DST_WEN_CONFIN    : in  std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
        SCTMOD2DST_DATA_CONFOUT  : out DF_INPUT_SCTMOD2DST_DATA_ARRAY;        
        
        STATE_MACHINE_ERROR_MONITOR : out DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY;
        EXPECTED_NUM_OF_MODULE      : in  DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY
        );
  end component;
  
  component df_internal_link_buffer_switch
    port (
      -- common clock
      WCLK : in std_logic;
      RCLK : in std_logic;
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
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK : std_logic_vector(31 downto 0);
      OUTPORT2_MASK : std_logic_vector(31 downto 0)
      );
  end component;
  
  component df_switch_2ch_merger
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
      OUTPUT_PORT_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT_DEN  : out std_logic;
      OUTPUT_PORT_RDY  : in  std_logic
      );
  end component;
  
  component add_df_ftkplane_word
    port
      ( MAIN_CLK : in  std_logic;
        RESET_IN : in  std_logic;
        
        -- <input>
        DATA_IN   : in  std_logic_vector(31 downto 0);
        DEN_IN    : in  std_logic;
        READY_OUT : out std_logic;
        
        -- <output>
        DATA_OUT : out std_logic_vector(31 downto 0);
        WEN_OUT  : out std_logic;
        XOFF_IN  : in  std_logic;
        
        -- configuration / monitoring port
        PIXMOD2FTKPLANE_ADDR_CONFIN  : in  std_logic_vector(10 downto 0);
        PIXMOD2FTKPLANE_DATA_CONFIN  : in  std_logic_vector(11 downto 0);
        PIXMOD2FTKPLANE_WEN_CONFIN   : in  std_logic;
        PIXMOD2FTKPLANE_DATA_CONFOUT : out std_logic_vector(11 downto 0);
        
        PIXMOD2TOWER_ADDR_CONFIN  : in  std_logic_vector(10 downto 0);
        PIXMOD2TOWER_DATA_CONFIN  : in  std_logic_vector(1 downto 0);
        PIXMOD2TOWER_WEN_CONFIN   : in  std_logic;
        PIXMOD2TOWER_DATA_CONFOUT : out std_logic_vector(1 downto 0);
        
        SCTMOD2FTKPLANE_ADDR_CONFIN  : in  std_logic_vector(12 downto 0);
        SCTMOD2FTKPLANE_DATA_CONFIN  : in  std_logic_vector(11 downto 0);
        SCTMOD2FTKPLANE_WEN_CONFIN   : in  std_logic;
        SCTMOD2FTKPLANE_DATA_CONFOUT : out std_logic_vector(11 downto 0);
        
        SCTMOD2TOWER_ADDR_CONFIN  : in  std_logic_vector(12 downto 0);
        SCTMOD2TOWER_DATA_CONFIN  : in  std_logic_vector(1 downto 0);
        SCTMOD2TOWER_WEN_CONFIN   : in  std_logic;
        SCTMOD2TOWER_DATA_CONFOUT : out std_logic_vector(1 downto 0);
        
        STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
        );
  end component;
  
  component fwft_cc_w36_d512_my_wrapper 
    port (
      clk : in std_logic;
      rst : in std_logic;
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      empty : out std_logic;
      prog_full : out std_logic
      );
  end component;
  
  component df_output_event_sorter
    port (
      -- common clock
      MAIN_CLK : in std_logic;
      RESET_IN : in std_logic;
      -- input port
      MODDATA_DIN : in  std_logic_vector(31 downto 0);
      MODDATA_DEN : in  std_logic;
      MODDATA_RDY : out std_logic;
      -- input port
      FRAME_DATA_IN  : in  std_logic_vector(31 downto 0);
      FRAME_WEN_IN   : in  std_logic;
      FRAME_CTRL_IN  : in  std_logic;      
      FRAME_XOFF_OUT : out std_logic;      
      -- output port
      SLINK_UD       : out std_logic_vector(31 downto 0);
      SLINK_UWEN_N   : out std_logic;
      SLINK_UCTRL_N  : out std_logic;
      SLINK_LFF_N    : in  std_logic;
      SLINK_LDOWN_N  : in  std_logic;
      -- send back to input of switch
      SEND_BACK_PORT_DOUT : out std_logic_vector(31 downto 0);
      SEND_BACK_PORT_DEN  : out std_logic;
      SEND_BACK_PORT_RDY  : in  std_logic;

      -- <configure / monitor>
      NUMBER_OF_EXPECTED_MODULES  : in  integer;
      STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
      );
  end component;
  
  signal reset_i : std_logic;
  
  signal sys_clk_i : std_logic;
  signal l1a_i : std_logic_vector(1 downto 0);

  type data2lanes is array(0 to 1) of std_logic_vector(31 downto 0);
  
  signal merger1_data_out_i : std_logic_vector(31 downto 0);
  signal merger1_wen_out_i  : std_logic;
  signal merger1_rdy_i      : std_logic;
  
  signal merger2_data_out_i : std_logic_vector(31 downto 0);
  signal merger2_wen_out_i  : std_logic;
  signal merger2_rdy_i      : std_logic;
  
  signal merger3_data_out_i : std_logic_vector(31 downto 0);
  signal merger3_wen_out_i  : std_logic;
  signal merger3_rdy_i      : std_logic;
  
  signal single_switch1_port1_dout_i : std_logic_vector(31 downto 0);
  signal single_switch1_port1_den_i  : std_logic;
  signal single_switch1_port1_rdy_i  : std_logic;
  signal single_switch1_port2_dout_i : std_logic_vector(31 downto 0);
  signal single_switch1_port2_den_i  : std_logic;
  signal single_switch1_port2_rdy_i  : std_logic;  
  
  signal input_lane0_rdy   : std_logic;
  signal input_lane1_rdy   : std_logic;

  signal local_destination_adder_data_in_i : std_logic_vector(31 downto 0);
  signal local_destination_adder_den_in_i  : std_logic;
  signal local_destination_adder_rdy_i : std_logic;
  signal buffer2_empty : std_logic;
  signal buffer2_full  : std_logic;

  signal destination_out_data_out_i : std_logic_vector(31 downto 0);
  signal destination_out_wen_out_i  : std_logic;
  signal destination_out_xoff_i     : std_logic;
  signal destination_out_rdy_i      : std_logic;
  
  signal sendback_port_dout_i : std_logic_vector(31 downto 0);
  signal sendback_port_den_i  : std_logic;
  signal sendback_port_rdy_i  : std_logic;  
  
  signal float4bit : std_logic_vector(3 downto 0);
  
  signal slink_ud_i : std_logic_vector(31 downto 0);
  signal slink_uwen_n_i : std_logic;
  signal slink_uctrl_n_i : std_logic;
  signal slink_lff_n_i : std_logic;

  -- <input>
  signal DECODER_DATA_IN  : DF_INPUT_DATA_ARRAY;
  signal DECODER_CTRL_IN  : std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
  signal DECODER_DEN_IN   : std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
  signal DECODER_FIFO_GO_NEXT_IF_EXIST_OUT : std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
  
  -- <output 1>
  signal DECODER_MODDATA_DATA_OUT : DF_INPUT_DATA_ARRAY;
  signal DECODER_MODDATA_WEN_OUT  : std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
  signal DECODER_MODDATA_XOFF_IN  : std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0);
  
  -- <output 2 event header / traier>
  signal DECODER_FRAME_DATA_OUT : std_logic_vector(31 downto 0);
  signal DECODER_FRAME_WEN_OUT  : std_logic;
  signal DECODER_FRAME_CTRL_OUT : std_logic;      
  signal DECODER_FRAME_XOFF_IN  : std_logic;      
  
  signal DECODER_INPUT_ENABLE_MASK : std_logic_vector(MAXIMUM_NUMBER_OF_INPUT_LANES-1 downto 0) := (others => '0');
  signal DECODER_FRAME_DOUT_LANEID : integer range 0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1;
  
  signal DECODER_STATE_MACHINE_ERROR_MONITOR : DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY;
  signal DECODER_EXPECTED_NUM_OF_MODULE      : DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY := (others => 0);
  
begin

  -- ===================
  -- CONFIGURATION
  -- ===================
  DECODER_INPUT_ENABLE_MASK(0) <= '1';
  DECODER_INPUT_ENABLE_MASK(1) <= '1';
  DECODER_FRAME_DOUT_LANEID    <= 0;
  
  DECODER_EXPECTED_NUM_OF_MODULE(0) <= 8;
  DECODER_EXPECTED_NUM_OF_MODULE(1) <= 8;
  
  process
  begin
    sys_clk_i<='0';
    wait for 2.5 ns;
    sys_clk_i<='1';
    wait for 2.5 ns;
  end process;

  channels : for iCh in 0 to 1 generate
    signal tpg_data_i  : std_logic_vector(31 downto 0);
    signal tpg_ctrl_i  : std_logic;
    signal tpg_den_i   : std_logic;
    signal lff_i   : std_logic;
    signal fifo_busy_i : std_logic;
    
  begin
    testpatgen : TestPatternTx
      port map (
        DataOut=>tpg_data_i,
        ControlWord=>tpg_ctrl_i,
        EnaOut=>tpg_den_i,
        Slink_LFF_N=>lff_i, 
        L1ACLOCK=>sys_clk_i,
        LSCCLOCK=>sys_clk_i,
        L1A=>l1a_i(iCh),
        RESET=>reset_i
        );
    
    lff_i <= not fifo_busy_i;
    input_buffer : fmc_input_buffer
      port map (
        FMC_CLK_IN=>sys_clk_i,
        FMC_DATA_IN=>tpg_data_i,
        FMC_CTRL_IN=>tpg_ctrl_i,
        FMC_DEN_IN=>tpg_den_i,
        
        -- PORT B
        MAIN_CLK=>sys_clk_i,
        DATA_OUT=>DECODER_DATA_IN(iCh),
        CTRL_OUT=>DECODER_CTRL_IN(iCh),
        DEN_OUT=>DECODER_DEN_IN(iCh),
        FIFO_GO_NEXT_IF_EXIST_IN=>DECODER_FIFO_GO_NEXT_IF_EXIST_OUT(iCh),
        
        -- FLOW CONTROL
        RESET=>reset_i,
        FIFO_FULL_OUT=>open,
        FIFO_BUSY_OUT=>fifo_busy_i);
    
  end generate;
  
  DECODER : df_input_lane_handler
    port map (
      MAIN_CLK => sys_clk_i,
      RESET_IN => reset_i,
      
      -- <input>
      DATA_IN => DECODER_DATA_IN,
      CTRL_IN => DECODER_CTRL_IN,
      DEN_IN  => DECODER_DEN_IN,
      FIFO_GO_NEXT_IF_EXIST_OUT => DECODER_FIFO_GO_NEXT_IF_EXIST_OUT,
      
      -- <output 1>
      MODDATA_DATA_OUT => DECODER_MODDATA_DATA_OUT,
      MODDATA_WEN_OUT  => DECODER_MODDATA_WEN_OUT,
      MODDATA_XOFF_IN  => DECODER_MODDATA_XOFF_IN,
      
      -- <output 2 event header / traier>
      FRAME_DATA_OUT => DECODER_FRAME_DATA_OUT,
      FRAME_WEN_OUT  => DECODER_FRAME_WEN_OUT,
      FRAME_CTRL_OUT => DECODER_FRAME_CTRL_OUT,
      FRAME_XOFF_IN  => DECODER_FRAME_XOFF_IN,
      
      INPUT_ENABLE_MASK => DECODER_INPUT_ENABLE_MASK,
      FRAME_DOUT_LANEID => DECODER_FRAME_DOUT_LANEID,
      
      -- <configuration / monitoring port>
      MOD2IDX_ADDR_CONFIN  => (others => (others=>'0')),
      MOD2IDX_DATA_CONFIN  => (others => (others=>'0')),
      MOD2IDX_WEN_CONFIN   => (others=>'0'),
      MOD2IDX_DATA_CONFOUT => open,
      
      -- <configuration / monitoring port>
      IDX2MOD_ADDR_CONFIN  => (others => (others=>'0')),
      IDX2MOD_DATA_CONFIN  => (others => (others=>'0')),
      IDX2MOD_WEN_CONFIN   => (others=>'0'),
      IDX2MOD_DATA_CONFOUT => open,
      
      -- <configuration / monitoring port>
      PIXMOD2DST_ADDR_CONFIN  => (others => (others=>'0')),
      PIXMOD2DST_DATA_CONFIN  => (others => (others=>'0')),
      PIXMOD2DST_WEN_CONFIN   => (others=>'0'),
      PIXMOD2DST_DATA_CONFOUT => open,
      
      SCTMOD2DST_ADDR_CONFIN  => (others => (others=>'0')),
      SCTMOD2DST_DATA_CONFIN  => (others => (others=>'0')),
      SCTMOD2DST_WEN_CONFIN   => (others=>'0'),
      SCTMOD2DST_DATA_CONFOUT => open,      
      
      STATE_MACHINE_ERROR_MONITOR => open,
      EXPECTED_NUM_OF_MODULE      => DECODER_EXPECTED_NUM_OF_MODULE
      );
  
  DECODER_MODDATA_XOFF_IN(0) <= (not input_lane0_rdy);
  DECODER_MODDATA_XOFF_IN(1) <= (not input_lane1_rdy);
  MERGER1 : df_switch_2ch_merger
    port map (
      -- common clock
      CLK => sys_clk_i,
      RST => reset_i,
      -- input port
      INPUT_PORT1_DIN => DECODER_MODDATA_DATA_OUT(0),
      INPUT_PORT1_DEN => DECODER_MODDATA_WEN_OUT(0),
      INPUT_PORT1_RDY => input_lane0_rdy,
      INPUT_PORT2_DIN => DECODER_MODDATA_DATA_OUT(1),
      INPUT_PORT2_DEN => DECODER_MODDATA_WEN_OUT(1),
      INPUT_PORT2_RDY => input_lane1_rdy,
      -- output port
      OUTPUT_PORT_DOUT => merger1_data_out_i,
      OUTPUT_PORT_DEN  => merger1_wen_out_i,
      OUTPUT_PORT_RDY  => merger1_rdy_i
      );

  SINGLE_SWITCH1 : df_internal_link_buffer_switch
    port map (
      -- common clock
      WCLK => sys_clk_i,
      RCLK => sys_clk_i,
      RST  => reset_i,
      -- input port
      INPUT_PORT_DIN => merger1_data_out_i,
      INPUT_PORT_DEN => merger1_wen_out_i,
      INPUT_PORT_RDY => merger1_rdy_i,
      -- output port
      OUTPUT_PORT1_DOUT => single_switch1_port1_dout_i,
      OUTPUT_PORT1_DEN  => single_switch1_port1_den_i,
      OUTPUT_PORT1_RDY  => single_switch1_port1_rdy_i,
      OUTPUT_PORT2_DOUT => single_switch1_port2_dout_i,
      OUTPUT_PORT2_DEN  => single_switch1_port2_den_i,
      OUTPUT_PORT2_RDY  => single_switch1_port2_rdy_i,
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK => X"00000001",
      OUTPORT2_MASK => X"FFFFFFFe"
      );

  MERGER2 : df_switch_2ch_merger
    port map (
      -- common clock
      CLK => sys_clk_i,
      RST => reset_i,
      -- input port
      INPUT_PORT1_DIN => single_switch1_port1_dout_i,
      INPUT_PORT1_DEN => single_switch1_port1_den_i,
      INPUT_PORT1_RDY => single_switch1_port1_rdy_i,
      INPUT_PORT2_DIN => single_switch1_port2_dout_i,
      INPUT_PORT2_DEN => single_switch1_port2_den_i,
      INPUT_PORT2_RDY => single_switch1_port2_rdy_i,
      -- output port
      OUTPUT_PORT_DOUT => merger2_data_out_i,
      OUTPUT_PORT_DEN  => merger2_wen_out_i,
      OUTPUT_PORT_RDY  => merger2_rdy_i
      );
  
  merger2_rdy_i <= not buffer2_full;
  BUFFER2 : fwft_cc_w36_d512_my_wrapper 
    port map (
      clk => sys_clk_i,
      rst => reset_i,
      din(31 downto 0)  => merger2_data_out_i,
      din(35 downto 32) => (others => '0'),
      wr_en => merger2_wen_out_i,
      rd_en => local_destination_adder_rdy_i,
      dout(31 downto 0)  => local_destination_adder_data_in_i,
      dout(35 downto 32) => float4bit,
      empty => buffer2_empty,
      prog_full => buffer2_full
      );
  
  local_destination_adder_den_in_i <= (not buffer2_empty);
  LOCAL_DESTINATION_ADDER : add_df_ftkplane_word
    port map (
      MAIN_CLK => sys_clk_i,
      RESET_IN => reset_i,
      
      DATA_IN   => local_destination_adder_data_in_i,
      DEN_IN    => local_destination_adder_den_in_i,
      READY_OUT => local_destination_adder_rdy_i,
      
      -- <output>
      DATA_OUT => destination_out_data_out_i,
      WEN_OUT  => destination_out_wen_out_i,
      XOFF_IN  => destination_out_xoff_i,
      
      -- configuration / monitoring port
      PIXMOD2FTKPLANE_ADDR_CONFIN  => (others => '0'),
      PIXMOD2FTKPLANE_DATA_CONFIN  => (others => '0'),
      PIXMOD2FTKPLANE_WEN_CONFIN   => '0',
      PIXMOD2FTKPLANE_DATA_CONFOUT => open,
      
      PIXMOD2TOWER_ADDR_CONFIN => (others => '0'),
      PIXMOD2TOWER_DATA_CONFIN => (others => '0'),
      PIXMOD2TOWER_WEN_CONFIN  => '0',
      PIXMOD2TOWER_DATA_CONFOUT => open,
      
      SCTMOD2FTKPLANE_ADDR_CONFIN  => (others => '0'),
      SCTMOD2FTKPLANE_DATA_CONFIN  => (others => '0'),
      SCTMOD2FTKPLANE_WEN_CONFIN   => '0',
      SCTMOD2FTKPLANE_DATA_CONFOUT => open,
      
      SCTMOD2TOWER_ADDR_CONFIN => (others => '0'),
      SCTMOD2TOWER_DATA_CONFIN => (others => '0'),
      SCTMOD2TOWER_WEN_CONFIN  => '0',
      SCTMOD2TOWER_DATA_CONFOUT => open,      
      
      STATE_MACHINE_ERROR_MONITOR => open
      );

  destination_out_xoff_i <= (not destination_out_rdy_i);
  MERGER3 : df_switch_2ch_merger
    port map (
      -- common clock
      CLK => sys_clk_i,
      RST => reset_i,
      -- input port
      INPUT_PORT1_DIN => destination_out_data_out_i,
      INPUT_PORT1_DEN => destination_out_wen_out_i,
      INPUT_PORT1_RDY => destination_out_rdy_i,
      INPUT_PORT2_DIN => sendback_port_dout_i,
      INPUT_PORT2_DEN => sendback_port_den_i,
      INPUT_PORT2_RDY => sendback_port_rdy_i,
      -- output port
      OUTPUT_PORT_DOUT => merger3_data_out_i,
      OUTPUT_PORT_DEN  => merger3_wen_out_i,
      OUTPUT_PORT_RDY  => merger3_rdy_i
      );  
  
  
  EVENT_SORTER : df_output_event_sorter
    port map (
      -- common clock
      MAIN_CLK => sys_clk_i,
      RESET_IN => reset_i,
      -- input port
      MODDATA_DIN => merger3_data_out_i,
      MODDATA_DEN => merger3_wen_out_i,
      MODDATA_RDY => merger3_rdy_i,
      -- input port
      FRAME_DATA_IN  => DECODER_FRAME_DATA_OUT,
      FRAME_WEN_IN   => DECODER_FRAME_WEN_OUT,
      FRAME_CTRL_IN  => DECODER_FRAME_CTRL_OUT,
      FRAME_XOFF_OUT => DECODER_FRAME_XOFF_IN,
      -- output port
      SLINK_UD      => slink_ud_i,
      SLINK_UWEN_N  => slink_uwen_n_i,
      SLINK_UCTRL_N => slink_uctrl_n_i,
      SLINK_LFF_N   => slink_lff_n_i,
      SLINK_LDOWN_N => '1',
      -- send back to input of switch
      SEND_BACK_PORT_DOUT => sendback_port_dout_i,
      SEND_BACK_PORT_DEN  => sendback_port_den_i,
      SEND_BACK_PORT_RDY  => sendback_port_rdy_i,
      
      -- <configure / monitor>
      NUMBER_OF_EXPECTED_MODULES  => 32,
      STATE_MACHINE_ERROR_MONITOR => open
      );
  
  -- time line
  process
  begin
    l1a_i(0)   <= '0';
    reset_i <= '0';
    slink_lff_n_i <= '1';
    wait for 1 us;
    
    reset_i <= '1';
    wait for 1 us;
    reset_i <= '0';
    
    wait for 5 us;
    
    -- mezzanine (0)
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(0) <='0';    
    
    wait for 5 us;
    --slink_lff_n_i <= '0';
    wait for 2 us;
    --slink_lff_n_i <= '1';
    
    -- mezzanine (1)
    l1a_i(1) <='0';    
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';    
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';    
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';    
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='0';
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i(1) <='1';
    wait until sys_clk_i'event and sys_clk_i='0';    
    l1a_i(1) <='0';

    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="11";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="00";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="11";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="00";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="11";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="00";    
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="11";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="00";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="11";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="00";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="11";
    wait until sys_clk_i'event and sys_clk_i='0';    
    l1a_i <="00";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="11";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="00";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="11";
    wait until sys_clk_i'event and sys_clk_i='0';
    l1a_i <="00";    
    wait;
      
  end process;
  
end logic;

