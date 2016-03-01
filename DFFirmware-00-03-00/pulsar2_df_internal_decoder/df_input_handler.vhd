-- in order to do simple synchronization

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity df_input_lane_handler is
  generic (
    USE_INPUT_EVENT_ALIGNMENT_LOGIC : std_logic := '1');
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
      
      --STATE_MACHINE_ERROR_MONITOR : out DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY;
      --STATE_MACHINE_STATE_MONITOR_SCT0 : out std_logic_vector(31 downto 0);
      --STATE_MACHINE_STATE_MONITOR_SCT1 : out std_logic_vector(31 downto 0);      
      --STATE_MACHINE_STATE_MONITOR_PIX0 : out std_logic_vector(31 downto 0);
      --STATE_MACHINE_STATE_MONITOR_PIX1 : out std_logic_vector(31 downto 0);      
      --STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0);

      EXPECTED_NUM_OF_MODULE      : in  DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY

      
      );
end df_input_lane_handler;

architecture logic of df_input_lane_handler is
  
  component add_df_internalframe
    port
      ( MAIN_CLK : in  std_logic;
        RESET_IN : in  std_logic;
        
        -- <input>
        DATA_IN  : in  std_logic_vector(31 downto 0);
        CTRL_IN  : in  std_logic;
        DEN_IN   : in  std_logic;
        FIFO_GO_NEXT_IF_EXIST_OUT : out std_logic;
        
        -- <EXTERNAL INPUT WAIT BEFORE SWITCH>
        ALLOW_TO_SEE_NEXT_EVENT : in  std_logic;
        IN_READING_EVENT        : out std_logic;
        
        -- <output 1>
        MODDATA_DATA_OUT : out std_logic_vector(31 downto 0);
        MODDATA_WEN_OUT  : out std_logic;
        MODDATA_XOFF_IN  : in  std_logic;
        
        -- <output 2 event header / traier>
        FRAME_DATA_OUT : out std_logic_vector(31 downto 0);
        FRAME_WEN_OUT  : out std_logic;
        FRAME_CTRL_OUT : out std_logic;
        FRAME_XOFF_IN  : in  std_logic;
        
        INTERNAL_EVENT_COUNTER : out std_logic_vector(DFIF_EVID_LAST downto DFIF_EVID_FIRST);
        INTERNAL_STATUS_MONITOR : out std_logic_vector(DFIF_EVID_LAST downto DFIF_EVID_FIRST);
        
        -- <configuration / monitoring port>
        MOD2IDX_ADDR_CONFIN   : in  std_logic_vector(13 downto 0);
        MOD2IDX_DATA_CONFIN   : in  std_logic_vector( 8 downto 0);
        MOD2IDX_WEN_CONFIN    : in  std_logic;
        MOD2IDX_DATA_CONFOUT  : out std_logic_vector( 8 downto 0);
        
        -- <configuration / monitoring port>
        IDX2MOD_ADDR_CONFIN   : in  std_logic_vector( 8 downto 0);
        IDX2MOD_DATA_CONFIN   : in  std_logic_vector(13 downto 0);
        IDX2MOD_WEN_CONFIN    : in  std_logic;
        IDX2MOD_DATA_CONFOUT  : out std_logic_vector(13 downto 0);
        
        -- <configuration / monitoring port>
        PIXMOD2DST_ADDR_CONFIN   : in  std_logic_vector(10 downto 0);
        PIXMOD2DST_DATA_CONFIN   : in  std_logic_vector(35 downto 0);
        PIXMOD2DST_WEN_CONFIN    : in  std_logic;
        PIXMOD2DST_DATA_CONFOUT  : out std_logic_vector(35 downto 0);
        
        SCTMOD2DST_ADDR_CONFIN   : in  std_logic_vector(12 downto 0);
        SCTMOD2DST_DATA_CONFIN   : in  std_logic_vector(35 downto 0);
        SCTMOD2DST_WEN_CONFIN    : in  std_logic;
        SCTMOD2DST_DATA_CONFOUT  : out std_logic_vector(35 downto 0);

        --STATE_MACHINE_STATE_MONITOR : out std_logic_vector(7 downto 0);
        --STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(1 downto 0);

        EXPECTED_NUM_OF_MODULE      : in  integer
        );
  end component;
  
  signal frame_data_i          : DF_INPUT_DATA_ARRAY;
  signal frame_wen_i           : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal frame_ctrl_i          : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);  
  signal in_reading_event_i    : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal ready_for_permission_to_new_event_i : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal unused_lanes_i        : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  
  signal internal_event_counter_i  : DF_INPUT_DATA_ARRAY := (others=> (others => '0'));
  signal internal_status_monitor_i : DF_INPUT_DATA_ARRAY := (others=> (others => '0'));

  --signal state_machine_state_monitor_i : DF_INPUT_STATE_MACHINE_STATE_MONITOR_ARRAY;
  --signal state_machine_error_monitor_i : DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY;

begin
  
  --process (MAIN_CLK, RESET_IN)
  --begin
  --  if (RESET_IN='1') then
  --    FRAME_DATA_OUT <= (others => '0');
  --    FRAME_WEN_OUT  <= '0';
  --    FRAME_CTRL_OUT <= '0';
  --  elsif (MAIN_CLK'event and MAIN_CLK='1') then
  --    FRAME_DATA_OUT <= frame_data_i(FRAME_DOUT_LANEID);
  --    FRAME_WEN_OUT  <= frame_wen_i(FRAME_DOUT_LANEID);
  --    FRAME_CTRL_OUT <= frame_ctrl_i(FRAME_DOUT_LANEID);
  --  end if;
  --end process;

  FRAME_DATA_OUT <= frame_data_i(FRAME_DOUT_LANEID);
  FRAME_WEN_OUT  <= frame_wen_i(FRAME_DOUT_LANEID);
  FRAME_CTRL_OUT <= frame_ctrl_i(FRAME_DOUT_LANEID);

  INTERNAL_EVENT_COUNTER <= internal_event_counter_i;
  INTERNAL_STATUS_MONITOR <= internal_status_monitor_i;

  --STATE_MACHINE_ERROR_MONITOR <= state_machine_error_monitor_i(15)&state_machine_error_monitor_i(14)&state_machine_error_monitor_i(13)&state_machine_error_monitor_i(12)&
  --                               state_machine_error_monitor_i(11)&state_machine_error_monitor_i(10)&state_machine_error_monitor_i(9)&state_machine_error_monitor_i(8)&
  --                               state_machine_error_monitor_i(7)&state_machine_error_monitor_i(6)&state_machine_error_monitor_i(5)&state_machine_error_monitor_i(4)&
  --                               state_machine_error_monitor_i(3)&state_machine_error_monitor_i(2)&state_machine_error_monitor_i(1)&state_machine_error_monitor_i(0);

  --STATE_MACHINE_STATE_MONITOR_SCT0 <= state_machine_state_monitor_i(7)&state_machine_state_monitor_i(5)&state_machine_state_monitor_i(3)&state_machine_state_monitor_i(1);
  --STATE_MACHINE_STATE_MONITOR_SCT1 <= state_machine_state_monitor_i(15)&state_machine_state_monitor_i(13)&state_machine_state_monitor_i(11)&state_machine_state_monitor_i(9);
  --STATE_MACHINE_STATE_MONITOR_PIX0 <= state_machine_state_monitor_i(6)&state_machine_state_monitor_i(4)&state_machine_state_monitor_i(2)&state_machine_state_monitor_i(0);
  --STATE_MACHINE_STATE_MONITOR_PIX1 <= state_machine_state_monitor_i(14)&state_machine_state_monitor_i(12)&state_machine_state_monitor_i(10)&state_machine_state_monitor_i(8);

  
  INPUT_LANES : for iLane in 0 to NUMBER_OF_FMC_INPUT_LANES-1 generate
    signal allow_to_see_next_event_i : std_logic;
    signal moddata_data_out_i : std_logic_vector(31 downto 0);
    signal moddata_wen_out_i  : std_logic;
    signal moddata_xoff_i     : std_logic;
    signal frame_xoff_i       : std_logic;
  begin
    unused_lanes_i(iLane) <= (not INPUT_ENABLE_MASK(iLane));
    
    INST_EVENT_ALIGNMENT_LOGIC : if USE_INPUT_EVENT_ALIGNMENT_LOGIC = '1' generate
    begin
      -- handle "allow_to_see_next_event_i"
      process (MAIN_CLK, RESET_IN)
      begin
        if (RESET_IN='1') then
          allow_to_see_next_event_i <= '1';
          ready_for_permission_to_new_event_i(iLane) <= '0';
          
        elsif (MAIN_CLK'event and MAIN_CLK='1') then
          
          -- handle "allow_to_see_next_event_i" for the event synchronization
          -- this logic is to be checked carefully still
          if ( (and_reduce(ready_for_permission_to_new_event_i or unused_lanes_i)='1' ) and
               (in_reading_event_i(iLane)='0') and
               (allow_to_see_next_event_i='0') ) then
            allow_to_see_next_event_i <= '1';
            ready_for_permission_to_new_event_i(iLane) <= '0';
          else 
            if (allow_to_see_next_event_i='1' and in_reading_event_i(iLane)='0') then
              ready_for_permission_to_new_event_i(iLane)<='0';
            elsif (in_reading_event_i(iLane)='0') then
              ready_for_permission_to_new_event_i(iLane)<='1';
            end if;
            
            if (in_reading_event_i(iLane)='1') then
              allow_to_see_next_event_i<='0';
            end if;
          end if;
        end if;
      end process;
    end generate;
    
    INST_NO_EVENT_ALIGNMENT_LOGIC : if USE_INPUT_EVENT_ALIGNMENT_LOGIC = '0' generate
    begin
      allow_to_see_next_event_i<='1';
    end generate;
    
    ---- output assignment
    ---- <this DFF does not work for full bit handling, instead directly assign>
    --process (MAIN_CLK, RESET_IN)
    --begin
    --  if (RESET_IN='1') then
    --    MODDATA_DATA_OUT(iLane) <= (others => '0');
    --    MODDATA_WEN_OUT(iLane)  <= '0';
    --    moddata_xoff_i          <= '1';        
    --  elsif (MAIN_CLK'event and MAIN_CLK='1') then
    --    if (INPUT_ENABLE_MASK(iLane)='1') then
    --      MODDATA_DATA_OUT(iLane) <= moddata_data_out_i;
    --      MODDATA_WEN_OUT(iLane)  <= moddata_wen_out_i;
    --      moddata_xoff_i          <= MODDATA_XOFF_IN(iLane);
    --    else
    --      MODDATA_DATA_OUT(iLane) <= (others => '0');
    --      MODDATA_WEN_OUT(iLane)  <= '0';
    --      moddata_xoff_i          <= '1';
    --    end if;
    --  end if;    
    --end process;
    
    MODDATA_DATA_OUT(iLane) <= moddata_data_out_i when (INPUT_ENABLE_MASK(iLane)='1') else (others => '0');
    MODDATA_WEN_OUT(iLane)  <= moddata_wen_out_i when (INPUT_ENABLE_MASK(iLane)='1') else '0';
    moddata_xoff_i          <= MODDATA_XOFF_IN(iLane) when (INPUT_ENABLE_MASK(iLane)='1') else '1';
    frame_xoff_i            <= FRAME_XOFF_IN when FRAME_DOUT_LANEID=iLane else '0';
    
    INTERNAL_FRAME_ADDER : add_df_internalframe
      port map
      ( MAIN_CLK => MAIN_CLK,
        RESET_IN => RESET_IN,
        
        -- <input>
        DATA_IN  => DATA_IN(iLane),
        CTRL_IN  => CTRL_IN(iLane),
        DEN_IN   => DEN_IN(iLane),
        FIFO_GO_NEXT_IF_EXIST_OUT => FIFO_GO_NEXT_IF_EXIST_OUT(iLane),
        
        -- <EXTERNAL INPUT WAIT BEFORE SWITCH>
        ALLOW_TO_SEE_NEXT_EVENT => allow_to_see_next_event_i,
        IN_READING_EVENT        => in_reading_event_i(iLane),
        
        -- <output 1>
        MODDATA_DATA_OUT => moddata_data_out_i,
        MODDATA_WEN_OUT  => moddata_wen_out_i,
        MODDATA_XOFF_IN  => moddata_xoff_i,
        
        -- <output 2 event header / traier>
        FRAME_DATA_OUT => frame_data_i(iLane),
        FRAME_WEN_OUT  => frame_wen_i(iLane),
        FRAME_CTRL_OUT => frame_ctrl_i(iLane),
        FRAME_XOFF_IN  => frame_xoff_i,
        
        INTERNAL_EVENT_COUNTER => internal_event_counter_i(iLane)(DFIF_EVID_LAST downto DFIF_EVID_FIRST),
        INTERNAL_STATUS_MONITOR => internal_status_monitor_i(iLane)(DFIF_EVID_LAST downto DFIF_EVID_FIRST),
        
        -- <configuration / monitoring port>
        MOD2IDX_ADDR_CONFIN  => MOD2IDX_ADDR_CONFIN(iLane),
        MOD2IDX_DATA_CONFIN  => MOD2IDX_DATA_CONFIN(iLane),
        MOD2IDX_WEN_CONFIN   => MOD2IDX_WEN_CONFIN(iLane),
        MOD2IDX_DATA_CONFOUT => MOD2IDX_DATA_CONFOUT(iLane),
        
        -- <configuration / monitoring port>
        IDX2MOD_ADDR_CONFIN  => IDX2MOD_ADDR_CONFIN(iLane),
        IDX2MOD_DATA_CONFIN  => IDX2MOD_DATA_CONFIN(iLane),
        IDX2MOD_WEN_CONFIN   => IDX2MOD_WEN_CONFIN(iLane),
        IDX2MOD_DATA_CONFOUT => IDX2MOD_DATA_CONFOUT(iLane),
        
        -- <configuration / monitoring port>
        PIXMOD2DST_ADDR_CONFIN  => PIXMOD2DST_ADDR_CONFIN(iLane),
        PIXMOD2DST_DATA_CONFIN  => PIXMOD2DST_DATA_CONFIN(iLane),
        PIXMOD2DST_WEN_CONFIN   => PIXMOD2DST_WEN_CONFIN(iLane),
        PIXMOD2DST_DATA_CONFOUT => PIXMOD2DST_DATA_CONFOUT(iLane),
        
        SCTMOD2DST_ADDR_CONFIN  => SCTMOD2DST_ADDR_CONFIN(iLane),
        SCTMOD2DST_DATA_CONFIN  => SCTMOD2DST_DATA_CONFIN(iLane),
        SCTMOD2DST_WEN_CONFIN   => SCTMOD2DST_WEN_CONFIN(iLane),
        SCTMOD2DST_DATA_CONFOUT => SCTMOD2DST_DATA_CONFOUT(iLane),
        
        --STATE_MACHINE_ERROR_MONITOR => STATE_MACHINE_ERROR_MONITOR(iLane),
        EXPECTED_NUM_OF_MODULE      => EXPECTED_NUM_OF_MODULE(iLane)

        --STATE_MACHINE_STATE_MONITOR => state_machine_state_monitor_i(iLane),
        --STATE_MACHINE_ERROR_MONITOR => state_machine_error_monitor_i(iLane)

        );
  end generate; 
  
end logic;
