------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

library work;
use work.data_formatter_constants.all;
library unisim;
use unisim.vcomponents.all;

entity df_input_data_operator is
  generic (
    USE_INPUT_EVENT_ALIGNMENT_LOGIC : std_logic := '0');
  port (
    MAIN_CLK : in  std_logic;
    
    -- <OUTPUT / FWFT FIFO running at MAIN_CLK>
    DATA_IN : in  DF_INPUT_DATA_ARRAY;
    CTRL_IN : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    DV_IN   : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    REN_OUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    
    -- <output event header / traier>
    FRAME_DATA_OUT : out std_logic_vector(31 downto 0);
    FRAME_WEN_OUT  : out std_logic;
    FRAME_CTRL_OUT : out std_logic;      
    FRAME_XOFF_IN  : in  std_logic;
    
    -- <output (1)>
    MODDATA_DATA_OUTPUTSW_OUT : out DF_DATA_POST_IDO_ARRAY;
    MODDATA_WEN_OUTPUTSW_OUT  : out std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0);
    MODDATA_RDY_OUTPUTSW_IN   : in  std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0);
    
    -- <output (2)>
    MODDATA_DATA_DATASHARINGSW_OUT : out DF_DATA_POST_IDO_ARRAY;
    MODDATA_WEN_DATASHARINGSW_OUT  : out std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0);
    MODDATA_RDY_DATASHARINGSW_IN   : in  std_logic_vector(NUMBER_OF_LANES_POST_IDO-1 downto 0);    
    
    INPUT_LUT_RESET             : in std_logic;
    INPUT_SINGLE_SWITCH_RESET   : in std_logic;
    ENABLE_FMC_LANES_MASK       : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    INPUT_LUT_FRAME_DOUT_LANEID : in  integer range 0 to NUMBER_OF_FMC_INPUT_LANES-1;
    INPUT_SINGLE_SWITCH_THIS_BOARD_MASK : in  std_logic_vector(31 downto 0);

    INTERNAL_EVENT_COUNTER : out DF_INPUT_DATA_ARRAY;
    INTERNAL_STATUS_MONITOR : out DF_INPUT_DATA_ARRAY;
    
    -- <module data monitoring before switch>
    MODDATA_WEN_SWITCH_IN_MONITOR  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    MODDATA_RDY_SWITCH_IN_MONITOR  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    MODDATA_DATA_SWITCH_IN_MONITOR : out DF_INPUT_DATA_ARRAY;
    
    -- <configuration / monitoring port>
    INPUT_LUT_MOD2IDX_ADDR_CONFIN   : in  DF_INPUT_MOD2IDX_ADDR_ARRAY;
    INPUT_LUT_MOD2IDX_DATA_CONFIN   : in  DF_INPUT_MOD2IDX_DATA_ARRAY;
    INPUT_LUT_MOD2IDX_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    INPUT_LUT_MOD2IDX_DATA_CONFOUT  : out DF_INPUT_MOD2IDX_DATA_ARRAY;
    
    -- <configuration / monitoring port>
    INPUT_LUT_IDX2MOD_ADDR_CONFIN   : in  DF_INPUT_IDX2MOD_ADDR_ARRAY;
    INPUT_LUT_IDX2MOD_DATA_CONFIN   : in  DF_INPUT_IDX2MOD_DATA_ARRAY;
    INPUT_LUT_IDX2MOD_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    INPUT_LUT_IDX2MOD_DATA_CONFOUT  : out DF_INPUT_IDX2MOD_DATA_ARRAY;
    
    -- <configuration / monitoring port>
    INPUT_LUT_PIXMOD2DST_ADDR_CONFIN   : in  DF_INPUT_PIXMOD2DST_ADDR_ARRAY;
    INPUT_LUT_PIXMOD2DST_DATA_CONFIN   : in  DF_INPUT_PIXMOD2DST_DATA_ARRAY;
    INPUT_LUT_PIXMOD2DST_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    INPUT_LUT_PIXMOD2DST_DATA_CONFOUT  : out DF_INPUT_PIXMOD2DST_DATA_ARRAY;
    
    INPUT_LUT_SCTMOD2DST_ADDR_CONFIN   : in  DF_INPUT_SCTMOD2DST_ADDR_ARRAY;
    INPUT_LUT_SCTMOD2DST_DATA_CONFIN   : in  DF_INPUT_SCTMOD2DST_DATA_ARRAY;
    INPUT_LUT_SCTMOD2DST_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    INPUT_LUT_SCTMOD2DST_DATA_CONFOUT  : out DF_INPUT_SCTMOD2DST_DATA_ARRAY;
    
    INPUT_LUT_EXPECTED_NUM_OF_MODULE      : in  DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY

    --IDO_STATE_MACHINE_STATE_MONITOR_SCT0 : out std_logic_vector(31 downto 0);
    --IDO_STATE_MACHINE_STATE_MONITOR_SCT1 : out std_logic_vector(31 downto 0);      
    --IDO_STATE_MACHINE_STATE_MONITOR_PIX0 : out std_logic_vector(31 downto 0);
    --IDO_STATE_MACHINE_STATE_MONITOR_PIX1 : out std_logic_vector(31 downto 0);      
    --IDO_STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)

    );
end df_input_data_operator;

architecture logic of df_input_data_operator is
  
  component df_input_lane_handler
    generic (
      USE_INPUT_EVENT_ALIGNMENT_LOGIC : std_logic := USE_INPUT_EVENT_ALIGNMENT_LOGIC);
    port
      ( MAIN_CLK : in  std_logic;
        RESET_IN : in  std_logic;
        
        -- <input>
        DATA_IN  : in  DF_INPUT_DATA_ARRAY;
        CTRL_IN  : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        DEN_IN   : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        FIFO_GO_NEXT_IF_EXIST_OUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        
        -- <output 1>
        MODDATA_DATA_OUT : out DF_INPUT_DATA_ARRAY;
        MODDATA_WEN_OUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        MODDATA_XOFF_IN  : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        
        -- <output 2 event header / traier>
        FRAME_DATA_OUT : out std_logic_vector(31 downto 0);
        FRAME_WEN_OUT  : out std_logic;
        FRAME_CTRL_OUT : out std_logic;      
        FRAME_XOFF_IN  : in  std_logic;      
        
        INPUT_ENABLE_MASK     : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        FRAME_DOUT_LANEID     : in  integer range 0 to NUMBER_OF_FMC_INPUT_LANES-1;
        
        INTERNAL_EVENT_COUNTER : out DF_INPUT_DATA_ARRAY;
        INTERNAL_STATUS_MONITOR : out DF_INPUT_DATA_ARRAY;
        
        -- <configuration / monitoring port>
        MOD2IDX_ADDR_CONFIN   : in  DF_INPUT_MOD2IDX_ADDR_ARRAY;
        MOD2IDX_DATA_CONFIN   : in  DF_INPUT_MOD2IDX_DATA_ARRAY;
        MOD2IDX_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        MOD2IDX_DATA_CONFOUT  : out DF_INPUT_MOD2IDX_DATA_ARRAY;
        
        -- <configuration / monitoring port>
        IDX2MOD_ADDR_CONFIN   : in  DF_INPUT_IDX2MOD_ADDR_ARRAY;
        IDX2MOD_DATA_CONFIN   : in  DF_INPUT_IDX2MOD_DATA_ARRAY;
        IDX2MOD_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        IDX2MOD_DATA_CONFOUT  : out DF_INPUT_IDX2MOD_DATA_ARRAY;
        
        -- <configuration / monitoring port>
        PIXMOD2DST_ADDR_CONFIN   : in  DF_INPUT_PIXMOD2DST_ADDR_ARRAY;
        PIXMOD2DST_DATA_CONFIN   : in  DF_INPUT_PIXMOD2DST_DATA_ARRAY;
        PIXMOD2DST_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        PIXMOD2DST_DATA_CONFOUT  : out DF_INPUT_PIXMOD2DST_DATA_ARRAY;
        
        SCTMOD2DST_ADDR_CONFIN   : in  DF_INPUT_SCTMOD2DST_ADDR_ARRAY;
        SCTMOD2DST_DATA_CONFIN   : in  DF_INPUT_SCTMOD2DST_DATA_ARRAY;
        SCTMOD2DST_WEN_CONFIN    : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
        SCTMOD2DST_DATA_CONFOUT  : out DF_INPUT_SCTMOD2DST_DATA_ARRAY;
        
        EXPECTED_NUM_OF_MODULE      : in  DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY

        --STATE_MACHINE_STATE_MONITOR_SCT0 : out std_logic_vector(31 downto 0);
        --STATE_MACHINE_STATE_MONITOR_SCT1 : out std_logic_vector(31 downto 0);      
        --STATE_MACHINE_STATE_MONITOR_PIX0 : out std_logic_vector(31 downto 0);
        --STATE_MACHINE_STATE_MONITOR_PIX1 : out std_logic_vector(31 downto 0);      
        --STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
        
        );
  end component;
  
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
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK : in std_logic_vector(31 downto 0);
      OUTPORT2_MASK : in std_logic_vector(31 downto 0)
      );
  end component;
  
  -- <input decoder>
  signal input_single_switch_other_board_mask : std_logic_vector(31 downto 0);  
  signal moddata_xoff_idoout_i : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '1');
  signal moddata_wen_idoout_i  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '1');
  signal moddata_rdy_idoout_i  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '1');
  signal moddata_data_idoout_i : DF_INPUT_DATA_ARRAY;
  
begin
  
  input_single_switch_other_board_mask <= (not INPUT_SINGLE_SWITCH_THIS_BOARD_MASK);
  
  INPUT_LUT : df_input_lane_handler
    generic map (
      USE_INPUT_EVENT_ALIGNMENT_LOGIC => USE_INPUT_EVENT_ALIGNMENT_LOGIC)
    port map (
      MAIN_CLK => MAIN_CLK, RESET_IN => INPUT_LUT_RESET,
      
      -- <input>
      DATA_IN => DATA_IN, CTRL_IN => CTRL_IN, DEN_IN  => DV_IN, FIFO_GO_NEXT_IF_EXIST_OUT => REN_OUT,
      
      -- <output 1>
      MODDATA_DATA_OUT => moddata_data_idoout_i,
      MODDATA_WEN_OUT  => moddata_wen_idoout_i,
      MODDATA_XOFF_IN  => moddata_xoff_idoout_i,
      
      -- <output 2 event header / traier>
      FRAME_DATA_OUT => FRAME_DATA_OUT,
      FRAME_WEN_OUT  => FRAME_WEN_OUT,
      FRAME_CTRL_OUT => FRAME_CTRL_OUT,
      FRAME_XOFF_IN  => FRAME_XOFF_IN,
      
      INPUT_ENABLE_MASK => ENABLE_FMC_LANES_MASK,
      FRAME_DOUT_LANEID => INPUT_LUT_FRAME_DOUT_LANEID,
      
      INTERNAL_EVENT_COUNTER => INTERNAL_EVENT_COUNTER,
      INTERNAL_STATUS_MONITOR => INTERNAL_STATUS_MONITOR,   
      
      -- <configuration / monitoring port>
      MOD2IDX_ADDR_CONFIN  => INPUT_LUT_MOD2IDX_ADDR_CONFIN,
      MOD2IDX_DATA_CONFIN  => INPUT_LUT_MOD2IDX_DATA_CONFIN,
      MOD2IDX_WEN_CONFIN   => INPUT_LUT_MOD2IDX_WEN_CONFIN,
      MOD2IDX_DATA_CONFOUT => INPUT_LUT_MOD2IDX_DATA_CONFOUT,
      
      -- <configuration / monitoring port>
      IDX2MOD_ADDR_CONFIN  => INPUT_LUT_IDX2MOD_ADDR_CONFIN,
      IDX2MOD_DATA_CONFIN  => INPUT_LUT_IDX2MOD_DATA_CONFIN,
      IDX2MOD_WEN_CONFIN   => INPUT_LUT_IDX2MOD_WEN_CONFIN,
      IDX2MOD_DATA_CONFOUT => INPUT_LUT_IDX2MOD_DATA_CONFOUT,
      
      -- <configuration / monitoring port>
      PIXMOD2DST_ADDR_CONFIN  => INPUT_LUT_PIXMOD2DST_ADDR_CONFIN,
      PIXMOD2DST_DATA_CONFIN  => INPUT_LUT_PIXMOD2DST_DATA_CONFIN,
      PIXMOD2DST_WEN_CONFIN   => INPUT_LUT_PIXMOD2DST_WEN_CONFIN,
      PIXMOD2DST_DATA_CONFOUT => INPUT_LUT_PIXMOD2DST_DATA_CONFOUT,
      
      SCTMOD2DST_ADDR_CONFIN  => INPUT_LUT_SCTMOD2DST_ADDR_CONFIN,
      SCTMOD2DST_DATA_CONFIN  => INPUT_LUT_SCTMOD2DST_DATA_CONFIN,
      SCTMOD2DST_WEN_CONFIN   => INPUT_LUT_SCTMOD2DST_WEN_CONFIN,
      SCTMOD2DST_DATA_CONFOUT => INPUT_LUT_SCTMOD2DST_DATA_CONFOUT,      

      --STATE_MACHINE_ERROR_MONITOR => IDO_STATE_MACHINE_ERROR_MONITOR,
      --STATE_MACHINE_STATE_MONITOR_SCT0 => IDO_STATE_MACHINE_STATE_MONITOR_SCT0,
      --STATE_MACHINE_STATE_MONITOR_SCT1 => IDO_STATE_MACHINE_STATE_MONITOR_SCT1,
      --STATE_MACHINE_STATE_MONITOR_PIX0 => IDO_STATE_MACHINE_STATE_MONITOR_PIX0, 
      --STATE_MACHINE_STATE_MONITOR_PIX1 => IDO_STATE_MACHINE_STATE_MONITOR_PIX1,

      EXPECTED_NUM_OF_MODULE      => INPUT_LUT_EXPECTED_NUM_OF_MODULE
      );
  
  process (MAIN_CLK) is
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      MODDATA_WEN_SWITCH_IN_MONITOR  <= moddata_wen_idoout_i;
      MODDATA_RDY_SWITCH_IN_MONITOR  <= moddata_rdy_idoout_i;
      MODDATA_DATA_SWITCH_IN_MONITOR <= moddata_data_idoout_i;
    end if;
  end process;
  
  assign_to_output : for iLane in 0 to NUMBER_OF_LANES_POST_IDO-1 generate
    constant iLane1 : integer := 2*iLane;
    constant iLane2 : integer := 2*iLane + 1;
  begin
    moddata_xoff_idoout_i(iLane1) <= not moddata_rdy_idoout_i(iLane1);
    moddata_xoff_idoout_i(iLane2) <= not moddata_rdy_idoout_i(iLane2);
    
    SWTICH : df_switch_element
    port map (
      CLK => MAIN_CLK,
      RST => INPUT_SINGLE_SWITCH_RESET,
      -- input port
      INPUT_PORT1_DIN => moddata_data_idoout_i(iLane1),
      INPUT_PORT1_DEN => moddata_wen_idoout_i(iLane1),
      INPUT_PORT1_RDY => moddata_rdy_idoout_i(iLane1),
      INPUT_PORT2_DIN => moddata_data_idoout_i(iLane2),
      INPUT_PORT2_DEN => moddata_wen_idoout_i(iLane2),
      INPUT_PORT2_RDY => moddata_rdy_idoout_i(iLane2),
      -- output port
      OUTPUT_PORT1_DOUT => MODDATA_DATA_OUTPUTSW_OUT(iLane), 
      OUTPUT_PORT1_DEN  => MODDATA_WEN_OUTPUTSW_OUT(iLane), 
      OUTPUT_PORT1_RDY  => MODDATA_RDY_OUTPUTSW_IN(iLane), 
      OUTPUT_PORT2_DOUT => MODDATA_DATA_DATASHARINGSW_OUT(iLane), 
      OUTPUT_PORT2_DEN  => MODDATA_WEN_DATASHARINGSW_OUT(iLane), 
      OUTPUT_PORT2_RDY  => MODDATA_RDY_DATASHARINGSW_IN(iLane), 
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK => INPUT_SINGLE_SWITCH_THIS_BOARD_MASK,
      OUTPORT2_MASK => input_single_switch_other_board_mask
      );
    
  end generate;
  
end logic;
