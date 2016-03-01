--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity add_df_internalframe is
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
end add_df_internalframe;

architecture logic of add_df_internalframe is
  type state_machine is (WAIT_CHECK_HEADER0_AND_SEND_DF_HEADER_NOT_SAMPLE_DATA,
                         WAIT_SAMPLE_HEADER0_SEND_HEADER0, -- BOF
                         WAIT_SAMPLE_HEADER1_SEND_HEADER1,
                         WAIT_SAMPLE_HEADER2_SEND_HEADER2,
                         WAIT_SAMPLE_HEADER3_SEND_HEADER3,
                         WAIT_SAMPLE_HEADER4_SEND_HEADER4,
                         WAIT_SAMPLE_HEADER5_SEND_HEADER5,
                         WAIT_SAMPLE_HEADER6_SEND_HEADER6,
                         WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_MODULE_HEADER_AND_CHECK_EODA,
                         WAIT_SEND_EODA,
                         WAIT_SEND_DF_INTERNAL_HEADER,
                         WAIT_DESTINATION_LUT_READY1,
                         WAIT_SEND_DESTINATION_WORD,
                         WAIT_SEND_MODULE_HEADER,
                         MISSING_MODULE_SEARCH, -- (could be simplified binary search)
                         WAIT_ONE_CLOCK_CYCLE_BEFORE_SENDING_FAKE_HEADER,
                         WAIT_SEND_FAKE_DF_INTERNAL_HEADER,
                         WAIT_FAKE_DESTINATION_LUT_READY1,
                         WAIT_FAKE_DESTINATION_LUT_READY2,
                         WAIT_FAKE_DESTINATION_LUT_READY3,
                         WAIT_SEND_FAKE_DESTINATION_WORD,
                         WAIT_SEND_FAKE_MODULE_HEADER,
                         WAIT_SEND_FAKE_DF_INTERNAL_TRAILER,                         
                         WAIT_SAMPLE_TRAILER1_SEND_TRAILER1,
                         WAIT_SAMPLE_TRAILER2_SEND_TRAILER2,
                         WAIT_SAMPLE_TRAILER3_SEND_TRAILER3,
                         WAIT_SAMPLE_TRAILER4_SEND_TRAILER4,
                         WAIT_SAMPLE_TRAILER5_SEND_TRAILER5 -- EOF
                         );
  
  signal current_state : state_machine := WAIT_SAMPLE_HEADER0_SEND_HEADER0;
  signal output_ready  : std_logic;   -- FRAME_XOFF_IN or MODDATA_XOFF_IN, according to the "NEXT state"
  -- according to the state
  signal next_frame_out_buf : std_logic_vector(33 downto 0); -- according to the "CURRENT state"
  -- CTRL / EN / DATA [31:0]
  constant ctrl_frameword_bit : std_logic_vector(1 downto 0) := "11";
  constant data_frameword_bit : std_logic_vector(1 downto 0) := "01";
  constant frame_out_idle : std_logic_vector(33 downto 0) := (others => '0');
  signal next_moddata_out_buf : std_logic_vector(32 downto 0); -- according to the "CURRENT state"
  -- EN / DATA [31:0]
  constant moddata_out_idle : std_logic_vector(32 downto 0) := (others => '0');
  signal fifo_go_next_if_exist_out_buf : std_logic;
  signal allow_read_fifo_at_next_cycle : std_logic; -- according to the "NEXT state"
  signal df_internal_event_counter     : std_logic_vector(DFIF_EVID_LAST downto DFIF_EVID_FIRST) := (others => '0');
  signal df_internal_status_monitor    : std_logic_vector(DFIF_EVID_LAST downto DFIF_EVID_FIRST) := (others => '0');
  signal df_internal_ido_status        : std_logic_vector(4 downto 0) := (others => '0');
  
  -- for event synchronization (should be zero at ALL DF before data taking starts)

  --signal state_machine_error_monitor_buf : std_logic_vector(1 downto 0);
  
  signal number_of_module_in_the_event  : integer range 0 to MAX_NUM_MODULES_PER_INPUT_LANE-1;
  signal modules_completion_flag        : std_logic_vector(MAX_NUM_MODULES_PER_INPUT_LANE-1 downto 0);
  signal searching_index                : integer range 0 to MAX_NUM_MODULES_PER_INPUT_LANE-1;

  constant ERROR_BITPOS_WAIT_CHECK_HEADER0_AND_SEND_DF_HEADER_NOT_SAMPLE_DATA : std_logic_vector(7 downto 0) := x"00";
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER0_SEND_HEADER0                      : std_logic_vector(7 downto 0) := x"01";
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER1_SEND_HEADER1                      : std_logic_vector(7 downto 0) := x"02";
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER2_SEND_HEADER2                      : std_logic_vector(7 downto 0) := x"03";
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER3_SEND_HEADER3                      : std_logic_vector(7 downto 0) := x"04";
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER4_SEND_HEADER4                      : std_logic_vector(7 downto 0) := x"05";
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER5_SEND_HEADER5                      : std_logic_vector(7 downto 0) := x"06";
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER6_SEND_HEADER6                      : std_logic_vector(7 downto 0) := x"07";
  constant ERROR_BITPOS_WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_MODULE_HEADER_AND_CHECK_EODA: std_logic_vector(7 downto 0) := x"08";
  constant ERROR_BITPOS_WAIT_SEND_EODA                                        : std_logic_vector(7 downto 0) := x"09";
  constant ERROR_BITPOS_WAIT_SEND_DF_INTERNAL_HEADER                          : std_logic_vector(7 downto 0) := x"10";
  constant ERROR_BITPOS_WAIT_DESTINATION_LUT_READY1                           : std_logic_vector(7 downto 0) := x"11";
  constant ERROR_BITPOS_WAIT_SEND_DESTINATION_WORD                            : std_logic_vector(7 downto 0) := x"12";
  constant ERROR_BITPOS_WAIT_SEND_MODULE_HEADER                               : std_logic_vector(7 downto 0) := x"13";
  constant ERROR_BITPOS_MISSING_MODULE_SEARCH                                 : std_logic_vector(7 downto 0) := x"14";
  constant ERROR_BITPOS_WAIT_SEND_FAKE_DF_INTERNAL_HEADER                     : std_logic_vector(7 downto 0) := x"15";
  constant ERROR_BITPOS_WAIT_SEND_FAKE_MODULE_HEADER                          : std_logic_vector(7 downto 0) := x"16";
  constant ERROR_BITPOS_WAIT_FAKE_DESTINATION_LUT_READY1                      : std_logic_vector(7 downto 0) := x"17";
  constant ERROR_BITPOS_WAIT_FAKE_DESTINATION_LUT_READY2                      : std_logic_vector(7 downto 0) := x"18";
  constant ERROR_BITPOS_WAIT_FAKE_DESTINATION_LUT_READY3                      : std_logic_vector(7 downto 0) := x"19";
  constant ERROR_BITPOS_WAIT_SEND_FAKE_DESTINATION_WORD                       : std_logic_vector(7 downto 0) := x"20";
  constant ERROR_BITPOS_WAIT_SEND_FAKE_DF_INTERNAL_TRAILER                    : std_logic_vector(7 downto 0) := x"21";
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER1_SEND_HEADER1                     : std_logic_vector(7 downto 0) := x"22";
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER2_SEND_HEADER2                     : std_logic_vector(7 downto 0) := x"23";
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER3_SEND_HEADER3                     : std_logic_vector(7 downto 0) := x"24";
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER4_SEND_HEADER4                     : std_logic_vector(7 downto 0) := x"25";
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER5_SEND_HEADER5                     : std_logic_vector(7 downto 0) := x"26";
  
  -- Look Up Table Signals
  signal mod2idx_lut_addr_in  : std_logic_vector(13 downto 0);
  signal mod2idx_lut_data_out : std_logic_vector( 8 downto 0);
  signal idx2mod_lut_addr_in  : std_logic_vector( 8 downto 0);
  signal idx2mod_lut_data_out : std_logic_vector(13 downto 0);
  signal pixmod2dst_lut_addr_in  : std_logic_vector(10 downto 0);
  signal pixmod2dst_lut_data_out : std_logic_vector(35 downto 0);
  signal sctmod2dst_lut_addr_in  : std_logic_vector(12 downto 0);
  signal sctmod2dst_lut_data_out : std_logic_vector(35 downto 0);  
  
  component input_mod2idx_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 13 downto 0 );
      dina : in std_logic_vector ( 8 downto 0 );
      douta : out std_logic_vector ( 8 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 13 downto 0 );
      dinb : in std_logic_vector ( 8 downto 0 );
      doutb : out std_logic_vector ( 8 downto 0 ) );
  end component;
  
  component input_idx2mod_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 8 downto 0 );
      dina : in std_logic_vector ( 13 downto 0 );
      douta : out std_logic_vector ( 13 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 8 downto 0 );
      dinb : in std_logic_vector ( 13 downto 0 );
      doutb : out std_logic_vector ( 13 downto 0 ) );
  end component;

  component input_sctmod2dest_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 12 downto 0 );
      dina : in std_logic_vector ( 35 downto 0 );
      douta : out std_logic_vector ( 35 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 12 downto 0 );
      dinb : in std_logic_vector ( 35 downto 0 );
      doutb : out std_logic_vector ( 35 downto 0 )
      );
  end component;
  
  component input_pixmod2dest_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 10 downto 0 );
      dina : in std_logic_vector ( 35 downto 0 );
      douta : out std_logic_vector ( 35 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 10 downto 0 );
      dinb : in std_logic_vector ( 35 downto 0 );
      doutb : out std_logic_vector ( 35 downto 0 )
      );
  end component;
  
  
  signal idx2mod_wen_confin_buf : std_logic_vector(0 to 0);
  signal mod2idx_wen_confin_buf : std_logic_vector(0 to 0);
  signal pixmod2dst_wen_confin_buf : std_logic_vector(0 to 0);
  signal sctmod2dst_wen_confin_buf : std_logic_vector(0 to 0);
  signal module_header_buf : std_logic_vector(31 downto 0);
  
  signal in_reading_event_buf : std_logic;
  
  signal random_five_bit_counter : std_logic_vector(DFIF_HEADER_RANDOM_COUNTER_LENGTH-1 downto 0) := (others => '0');
  
  constant zero32 : std_logic_vector(31 downto 0) := (others => '0');
  
  signal moddata_xoff_i : std_logic := '1';
  signal frame_xoff_i   : std_logic := '1';
  signal moddata_out_selected : std_logic := '0';
  
begin
  
  moddata_xoff_i <= MODDATA_XOFF_IN when (moddata_out_selected='1') else '0';
  frame_xoff_i   <= FRAME_XOFF_IN   when (moddata_out_selected='0') else '0';
                    
  output_ready <= ((not moddata_xoff_i) and (not frame_xoff_i));
  fifo_go_next_if_exist_out_buf <= output_ready and allow_read_fifo_at_next_cycle;
  FIFO_GO_NEXT_IF_EXIST_OUT     <= fifo_go_next_if_exist_out_buf;

  df_internal_status_monitor(6)<=  output_ready;
  df_internal_status_monitor(5)<=  fifo_go_next_if_exist_out_buf;
  df_internal_status_monitor(4 downto 0)<=  df_internal_ido_status;
  
  FRAME_CTRL_OUT <= next_frame_out_buf(33);
  FRAME_WEN_OUT  <= next_frame_out_buf(32);
  FRAME_DATA_OUT <= next_frame_out_buf(31 downto 0);
  
  MODDATA_WEN_OUT  <= next_moddata_out_buf(32);
  MODDATA_DATA_OUT <= next_moddata_out_buf(31 downto 0);  
  
  
  -- for input sync
  IN_READING_EVENT   <= in_reading_event_buf;
  INTERNAL_EVENT_COUNTER <= df_internal_event_counter;
  INTERNAL_STATUS_MONITOR <= df_internal_status_monitor;

  ----for monitoring 
  --STATE_MACHINE_ERROR_MONITOR <= state_machine_error_monitor_buf;

  
  -- modules_completion_flag handling
  process (MAIN_CLK, RESET_IN)
  begin
    if (RESET_IN='1') then
      modules_completion_flag <= (others => '0');
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      if    (current_state=WAIT_CHECK_HEADER0_AND_SEND_DF_HEADER_NOT_SAMPLE_DATA) then
        modules_completion_flag <= (others => '0');
      elsif (conv_integer(mod2idx_lut_data_out)>=MAX_NUM_MODULES_PER_INPUT_LANE) then -- invalid number
        NULL;
      else
        modules_completion_flag(conv_integer(mod2idx_lut_data_out)) <= '1';
      end if;
    end if;
  end process;
    
  process (MAIN_CLK, RESET_IN)
  begin
    if (RESET_IN='1') then
      current_state <= WAIT_CHECK_HEADER0_AND_SEND_DF_HEADER_NOT_SAMPLE_DATA;
      moddata_out_selected <= '0';
      allow_read_fifo_at_next_cycle <= '0';
      next_frame_out_buf            <= frame_out_idle;
      next_moddata_out_buf          <= moddata_out_idle;
      df_internal_event_counter     <= (others => '0');
      df_internal_status_monitor(4 downto 0)    <= (others => '0');
      number_of_module_in_the_event <= 0;
      searching_index               <= 0;
      --state_machine_error_monitor_buf <= (others => '0');
      mod2idx_lut_addr_in           <= (others => '1');
      idx2mod_lut_addr_in           <= (others => '1');
      module_header_buf             <= (others => '0');
      random_five_bit_counter       <= (others => '0');
      
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      random_five_bit_counter       <= random_five_bit_counter + 1;
      
      case current_state is
        when WAIT_CHECK_HEADER0_AND_SEND_DF_HEADER_NOT_SAMPLE_DATA =>
          --STATE_MACHINE_STATE_MONITOR <= ERROR_BITPOS_WAIT_CHECK_HEADER0_AND_SEND_DF_HEADER_NOT_SAMPLE_DATA;
          df_internal_status_monitor(4 downto 0)    <= (others => '0');               
          number_of_module_in_the_event <= 0;
          mod2idx_lut_addr_in           <= (others => '1');
          idx2mod_lut_addr_in           <= (others => '1');          
          searching_index               <= 0;
          
          -- ==============================================================
          if ((FRAME_XOFF_IN='0') and (DEN_IN='1') and (CTRL_IN='1') and (DATA_IN(DF_FRAME_WORD_MSB_BITPOS downto DF_FRAME_WORD_LSB_BITPOS)=DF_OUTPUT_BOF_WORD) and (ALLOW_TO_SEE_NEXT_EVENT='1')) then
            current_state                 <= WAIT_SAMPLE_HEADER0_SEND_HEADER0;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            in_reading_event_buf          <= '1';
            -- maye data word will be better choice
            next_frame_out_buf            <= ctrl_frameword_bit & DFIF_FRAGMENTID_HEADER & DFIF_HEADER_RESERVED & random_five_bit_counter & df_internal_event_counter;
            next_moddata_out_buf          <= moddata_out_idle;
          else 
            current_state                 <= WAIT_CHECK_HEADER0_AND_SEND_DF_HEADER_NOT_SAMPLE_DATA;
            moddata_out_selected          <= '0';
            in_reading_event_buf          <= '0';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER0_SEND_HEADER0 =>
          --STATE_MACHINE_STATE_MONITOR <= ERROR_BITPOS_WAIT_SAMPLE_HEADER0_SEND_HEADER0;
          df_internal_status_monitor(4 downto 0) <= "00001";
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_HEADER1_SEND_HEADER1;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_HEADER0_SEND_HEADER0;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER1_SEND_HEADER1 =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_HEADER1_SEND_HEADER1);
          df_internal_status_monitor(4 downto 0) <= "00001";
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_HEADER2_SEND_HEADER2;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_HEADER1_SEND_HEADER1;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER2_SEND_HEADER2 =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_HEADER2_SEND_HEADER2);          
          df_internal_status_monitor(4 downto 0) <= "00011";
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_HEADER3_SEND_HEADER3;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_HEADER2_SEND_HEADER2;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER3_SEND_HEADER3 =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_HEADER3_SEND_HEADER3);          
          df_internal_status_monitor(4 downto 0) <= "00100";
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_HEADER4_SEND_HEADER4;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_HEADER3_SEND_HEADER3;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;

          
        when WAIT_SAMPLE_HEADER4_SEND_HEADER4 =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_HEADER4_SEND_HEADER4);          
          df_internal_status_monitor(4 downto 0) <= "00101";
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_HEADER5_SEND_HEADER5;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_HEADER4_SEND_HEADER4;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER5_SEND_HEADER5 =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_HEADER5_SEND_HEADER5);
          df_internal_status_monitor(4 downto 0) <= "00110";
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_HEADER6_SEND_HEADER6;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_HEADER5_SEND_HEADER5;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER6_SEND_HEADER6 =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_HEADER6_SEND_HEADER6);
          df_internal_status_monitor(4 downto 0) <= "00111";
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_MODULE_HEADER_AND_CHECK_EODA;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_HEADER6_SEND_HEADER6;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_MODULE_HEADER_AND_CHECK_EODA =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_MODULE_HEADER_AND_CHECK_EODA);                  
          df_internal_status_monitor(4 downto 0) <= "01000";
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            if (DATA_IN(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_MODULE_HEADER) then
              -- CASE when we find Module Header
              number_of_module_in_the_event <= number_of_module_in_the_event+1;
              module_header_buf             <= DATA_IN;
              if number_of_module_in_the_event/=0 then
                -- not first module in the event
                current_state                 <= WAIT_SEND_DF_INTERNAL_HEADER;
                moddata_out_selected          <= '1';
                allow_read_fifo_at_next_cycle <= '0';
                next_frame_out_buf            <= frame_out_idle;
                next_moddata_out_buf          <= '1' & DFIF_FRAGMENTID_TRAILER&DFIF_TRAILER_REERVED;                
              else
                -- first module in the event
                current_state                 <= WAIT_SEND_DF_INTERNAL_HEADER;
                moddata_out_selected          <= '1';
                allow_read_fifo_at_next_cycle <= '0';
                next_frame_out_buf            <= frame_out_idle;
                next_moddata_out_buf          <= moddata_out_idle;
              end if;

              if (DATA_IN(IMDF_MODULE_HEADER_IS_SCT_POS)='1') then
                -- SCT Module header
                mod2idx_lut_addr_in(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START) <=
                  DATA_IN(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START);
                mod2idx_lut_addr_in(mod2idx_lut_addr_in'length-1) <= '1'; -- "Is SCT Bit in address"
                --
                sctmod2dst_lut_addr_in(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START) <=
                  DATA_IN(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START);
              else
                -- Pixel Module header 
                mod2idx_lut_addr_in(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START) <=
                  DATA_IN(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START);
                mod2idx_lut_addr_in(mod2idx_lut_addr_in'length-2 downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST+1) <= (others=>'0');
                mod2idx_lut_addr_in(mod2idx_lut_addr_in'length-1) <= '0'; -- "Is SCT Bit in address"
                --
                pixmod2dst_lut_addr_in(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START) <=
                  DATA_IN(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START);
              end if;              
              
            elsif (CTRL_IN='1' and
                   DATA_IN(DF_FRAME_WORD_MSB_BITPOS downto DF_FRAME_WORD_LSB_BITPOS)=DF_OUTPUT_EODA_WORD) then
              if number_of_module_in_the_event/=0 then
                -- not first module in the event => close module data 
                current_state                 <= WAIT_SEND_EODA;
                moddata_out_selected          <= '0';
                allow_read_fifo_at_next_cycle <= '0';
                next_frame_out_buf            <= frame_out_idle;
                next_moddata_out_buf          <= '1' & DFIF_FRAGMENTID_TRAILER&DFIF_TRAILER_REERVED;
              else 
                -- no module data is sent yet => no need to close module data here
                current_state                 <= WAIT_SEND_EODA;
                moddata_out_selected          <= '0';
                allow_read_fifo_at_next_cycle <= '0';
                next_frame_out_buf            <= frame_out_idle;
                next_moddata_out_buf          <= moddata_out_idle;
              end if;
                
            else
              -- == normal data
              current_state                 <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_MODULE_HEADER_AND_CHECK_EODA;
              moddata_out_selected          <= '1';
              allow_read_fifo_at_next_cycle <= '1';
              next_frame_out_buf            <= frame_out_idle;
              next_moddata_out_buf          <= DEN_IN & DATA_IN;
            end if;
          else 
            current_state                 <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_MODULE_HEADER_AND_CHECK_EODA;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SEND_DF_INTERNAL_HEADER =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SEND_DF_INTERNAL_HEADER);
          df_internal_status_monitor(4 downto 0) <= "01001";
          -- ==============================================================
          if (MODDATA_XOFF_IN='0') then
            current_state                 <= WAIT_DESTINATION_LUT_READY1;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= '1' & DFIF_FRAGMENTID_HEADER & DFIF_HEADER_RESERVED & random_five_bit_counter & df_internal_event_counter;
          else
            current_state                 <= WAIT_SEND_DF_INTERNAL_HEADER;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_DESTINATION_LUT_READY1 =>
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_DESTINATION_LUT_READY1);
          df_internal_status_monitor(4 downto 0) <= "01010";
          -- ==============================================================
          current_state                 <= WAIT_SEND_DESTINATION_WORD;
          moddata_out_selected          <= '1';
          allow_read_fifo_at_next_cycle <= '0';
          next_frame_out_buf            <= frame_out_idle;
          next_moddata_out_buf          <= moddata_out_idle;
          
        when WAIT_SEND_DESTINATION_WORD =>
          df_internal_status_monitor(4 downto 0) <= "01011";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SEND_DESTINATION_WORD);
          -- ==============================================================
          if (MODDATA_XOFF_IN='0') then
            current_state                 <= WAIT_SEND_MODULE_HEADER;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            if ( module_header_buf(IMDF_MODULE_HEADER_IS_SCT_POS)='1' ) then
              next_moddata_out_buf <= '1' & sctmod2dst_lut_data_out(31 downto 0);
              if (sctmod2dst_lut_data_out(31 downto 0)=zero32) then -- ERROR STATE
                --state_machine_error_monitor_buf <= "01";
              end if;
            else
              next_moddata_out_buf <= '1' & pixmod2dst_lut_data_out(31 downto 0);
              if (pixmod2dst_lut_data_out(31 downto 0)=zero32) then -- ERROR STATE
                --state_machine_error_monitor_buf <= "01";                
              end if;              
            end if;
            
          else
            current_state                 <= WAIT_SEND_DESTINATION_WORD;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;            
          
        when WAIT_SEND_EODA =>
        
          df_internal_status_monitor(4 downto 0) <= "01100";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SEND_EODA);     
          -- ==============================================================
          if (number_of_module_in_the_event=EXPECTED_NUM_OF_MODULE) then
            if (FRAME_XOFF_IN='0') then
              current_state                 <= WAIT_SAMPLE_TRAILER1_SEND_TRAILER1;
              moddata_out_selected          <= '0';
              allow_read_fifo_at_next_cycle <= '1';
              next_frame_out_buf            <= ctrl_frameword_bit & DF_OUTPUT_EODA_WORD & X"0000";
              next_moddata_out_buf          <= moddata_out_idle;
            else
              current_state                 <= WAIT_SEND_EODA;
              moddata_out_selected          <= '0';
              allow_read_fifo_at_next_cycle <= '0';
              next_frame_out_buf            <= frame_out_idle;
              next_moddata_out_buf          <= moddata_out_idle;
            end if;
            
          elsif (number_of_module_in_the_event<EXPECTED_NUM_OF_MODULE) then
            current_state                 <= MISSING_MODULE_SEARCH;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;                
            
          else -- ERROR STATE !!
            --state_machine_error_monitor_buf <= "10";
            if (FRAME_XOFF_IN='0') then
              current_state                 <= WAIT_SAMPLE_TRAILER1_SEND_TRAILER1;
              moddata_out_selected          <= '0';
              allow_read_fifo_at_next_cycle <= '1';
              next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
              next_moddata_out_buf          <= moddata_out_idle;
            else
              current_state                 <= WAIT_SEND_EODA;
              moddata_out_selected          <= '0';
              allow_read_fifo_at_next_cycle <= '0';
              next_frame_out_buf            <= frame_out_idle;
              next_moddata_out_buf          <= moddata_out_idle;
            end if;
          end if;          
          
        when WAIT_SEND_MODULE_HEADER =>
          df_internal_status_monitor(4 downto 0) <= "01101";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SEND_MODULE_HEADER);               

          -- ==============================================================
          if (MODDATA_XOFF_IN='0') then
            current_state                 <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_MODULE_HEADER_AND_CHECK_EODA;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= '1' & module_header_buf;
          else
            current_state                 <= WAIT_SEND_MODULE_HEADER;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;

        when MISSING_MODULE_SEARCH =>
          df_internal_status_monitor(4 downto 0) <= "01110";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_MISSING_MODULE_SEARCH);               
          -- ==============================================================
          -- speed up is possible IF NEEDED
          if (number_of_module_in_the_event/=EXPECTED_NUM_OF_MODULE) then
            if (modules_completion_flag(searching_index)='1') then
              searching_index               <= searching_index + 1;
              current_state                 <= MISSING_MODULE_SEARCH;
              moddata_out_selected          <= '1';
              allow_read_fifo_at_next_cycle <= '0';
              next_frame_out_buf            <= frame_out_idle;
              next_moddata_out_buf          <= moddata_out_idle;
            else
              number_of_module_in_the_event <= number_of_module_in_the_event+1;
              searching_index               <= searching_index + 1;
              current_state                 <= WAIT_ONE_CLOCK_CYCLE_BEFORE_SENDING_FAKE_HEADER;
              moddata_out_selected          <= '1';
              allow_read_fifo_at_next_cycle <= '0';
              next_frame_out_buf            <= frame_out_idle;
              next_moddata_out_buf          <= moddata_out_idle;
              idx2mod_lut_addr_in           <= conv_std_logic_vector(searching_index, idx2mod_lut_addr_in'length);
            end if;
          else -- ERROR STATE
            --state_machine_error_monitor_buf <= "11";
            current_state                 <= WAIT_SEND_EODA;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= '1' & DFIF_FRAGMENTID_TRAILER&DFIF_TRAILER_REERVED;
          end if;
          
        when WAIT_ONE_CLOCK_CYCLE_BEFORE_SENDING_FAKE_HEADER =>
          df_internal_status_monitor(4 downto 0) <= "01111";
          -- ==============================================================
          current_state                 <= WAIT_SEND_FAKE_DF_INTERNAL_HEADER;
          moddata_out_selected          <= '1';
          allow_read_fifo_at_next_cycle <= '0';
          next_frame_out_buf            <= frame_out_idle;
          next_moddata_out_buf          <= moddata_out_idle;
          
        when WAIT_SEND_FAKE_DF_INTERNAL_HEADER =>

          df_internal_status_monitor(4 downto 0) <= "10000";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SEND_FAKE_DF_INTERNAL_TRAILER);
          -- ==============================================================
          if (MODDATA_XOFF_IN='0') then
            current_state                 <= WAIT_FAKE_DESTINATION_LUT_READY1;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= '1' & DFIF_FRAGMENTID_HEADER_FAKE & DFIF_HEADER_RESERVED & random_five_bit_counter & df_internal_event_counter;
          else
            current_state                 <= WAIT_SEND_FAKE_DF_INTERNAL_HEADER;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;

        when WAIT_FAKE_DESTINATION_LUT_READY1 =>
          df_internal_status_monitor(4 downto 0) <= "10001";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_FAKE_DESTINATION_LUT_READY1);
          -- ==============================================================
          current_state                 <= WAIT_FAKE_DESTINATION_LUT_READY2;
          moddata_out_selected          <= '1';
          allow_read_fifo_at_next_cycle <= '0';
          next_frame_out_buf            <= frame_out_idle;
          next_moddata_out_buf          <= moddata_out_idle;
          if ( idx2mod_lut_data_out(DF_INTERNAL_MODADDRESS_ISSCT_POS)='1' ) then --SCT
            sctmod2dst_lut_addr_in      <= idx2mod_lut_data_out(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START);
          else
            pixmod2dst_lut_addr_in      <= idx2mod_lut_data_out(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START);
          end if;

        when WAIT_FAKE_DESTINATION_LUT_READY2 =>
          df_internal_status_monitor(4 downto 0) <= "10011";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_FAKE_DESTINATION_LUT_READY2);
          -- ==============================================================
          current_state                 <= WAIT_FAKE_DESTINATION_LUT_READY3;
          moddata_out_selected          <= '1';
          allow_read_fifo_at_next_cycle <= '0';
          next_frame_out_buf            <= frame_out_idle;
          next_moddata_out_buf          <= moddata_out_idle;

        when WAIT_FAKE_DESTINATION_LUT_READY3 =>
          df_internal_status_monitor(4 downto 0) <= "10100";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_FAKE_DESTINATION_LUT_READY3);
          -- ==============================================================
          current_state                 <= WAIT_SEND_FAKE_DESTINATION_WORD;
          moddata_out_selected          <= '1';
          allow_read_fifo_at_next_cycle <= '0';
          next_frame_out_buf            <= frame_out_idle;
          next_moddata_out_buf          <= moddata_out_idle;          
          
        when WAIT_SEND_FAKE_DESTINATION_WORD =>
          df_internal_status_monitor(4 downto 0) <= "10101";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SEND_FAKE_DESTINATION_WORD);
          -- ==============================================================
          if (MODDATA_XOFF_IN='0') then
            current_state                 <= WAIT_SEND_FAKE_MODULE_HEADER;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            if ( idx2mod_lut_data_out(DF_INTERNAL_MODADDRESS_ISSCT_POS)='1' ) then --SCT
              next_moddata_out_buf          <= '1' & sctmod2dst_lut_data_out(31 downto 0);
            else
              next_moddata_out_buf          <= '1' & pixmod2dst_lut_data_out(31 downto 0);
            end if;
          else
            current_state                 <= WAIT_SEND_FAKE_DESTINATION_WORD;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SEND_FAKE_MODULE_HEADER =>
          df_internal_status_monitor(4 downto 0) <= "10110";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SEND_FAKE_MODULE_HEADER);
          -- ==============================================================
          if (MODDATA_XOFF_IN='0') then
            current_state                 <= WAIT_SEND_FAKE_DF_INTERNAL_TRAILER;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            mod2idx_lut_addr_in           <= idx2mod_lut_data_out;
            
            if (idx2mod_lut_data_out(DF_INTERNAL_MODADDRESS_ISSCT_POS)='0') then
              -- decode for pixel module header
              next_moddata_out_buf(IMDF_MODULE_HEADER_IS_SCT_POS) <= '0';
              next_moddata_out_buf(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START)
                <= idx2mod_lut_data_out(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START);
              next_moddata_out_buf(IMDF_MODULE_HEADER_IS_SCT_POS-1 downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST+1)
                <= (others => '0'); -- reserved bit
              next_moddata_out_buf(DFIF_FRAGMENTID_START-1 downto IMDF_MODULE_HEADER_IS_SCT_POS+1) <= (others => '0'); -- reserved
              next_moddata_out_buf(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) <= DFIF_FRAGMENTID_MODULE_HEADER;
            else
              -- decode for SCT module header
              next_moddata_out_buf(IMDF_MODULE_HEADER_IS_SCT_POS) <= '1';
              next_moddata_out_buf(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START)
                <= idx2mod_lut_data_out(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START);
              next_moddata_out_buf(IMDF_MODULE_HEADER_IS_SCT_POS-1 downto IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST+1)
                <= (others => '0'); -- reserved bit
              next_moddata_out_buf(DFIF_FRAGMENTID_START-1 downto IMDF_MODULE_HEADER_IS_SCT_POS+1) <= (others => '0'); -- reserved
              next_moddata_out_buf(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) <= DFIF_FRAGMENTID_MODULE_HEADER;              
            end if;
            
          else
            current_state                 <= WAIT_SEND_FAKE_MODULE_HEADER;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SEND_FAKE_DF_INTERNAL_TRAILER =>
          df_internal_status_monitor(4 downto 0) <= "10111";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SEND_FAKE_DF_INTERNAL_TRAILER);
          -- ==============================================================      
          if (MODDATA_XOFF_IN='0') then
            if (number_of_module_in_the_event=EXPECTED_NUM_OF_MODULE) then
              current_state                 <= WAIT_SEND_EODA;
              moddata_out_selected          <= '0';
              allow_read_fifo_at_next_cycle <= '0';
              next_frame_out_buf            <= frame_out_idle;
              next_moddata_out_buf          <= '1' & DFIF_FRAGMENTID_TRAILER&DFIF_TRAILER_REERVED;
            else
              current_state                 <= MISSING_MODULE_SEARCH;
              moddata_out_selected          <= '1';
              allow_read_fifo_at_next_cycle <= '0';
              next_frame_out_buf            <= frame_out_idle;
              next_moddata_out_buf          <= '1' & DFIF_FRAGMENTID_TRAILER&DFIF_TRAILER_REERVED;              
            end if;
          else
            current_state                 <= WAIT_SEND_FAKE_DF_INTERNAL_TRAILER;
            moddata_out_selected          <= '1';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;
          
        when WAIT_SAMPLE_TRAILER1_SEND_TRAILER1 =>
          df_internal_status_monitor(4 downto 0) <= "11000";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_TRAILER1_SEND_HEADER1);
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER2_SEND_TRAILER2;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_TRAILER1_SEND_TRAILER1;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;            
          end if;
          
        when WAIT_SAMPLE_TRAILER2_SEND_TRAILER2 =>
          df_internal_status_monitor(4 downto 0) <= "11001";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_TRAILER2_SEND_HEADER2);
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER3_SEND_TRAILER3;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_TRAILER2_SEND_TRAILER2;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;            
          end if;
          
        when WAIT_SAMPLE_TRAILER3_SEND_TRAILER3 =>
          df_internal_status_monitor(4 downto 0) <= "11010";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_TRAILER3_SEND_HEADER3);
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER4_SEND_TRAILER4;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_TRAILER3_SEND_TRAILER3;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;            
          end if;
          
        when WAIT_SAMPLE_TRAILER4_SEND_TRAILER4 =>
          df_internal_status_monitor(4 downto 0) <= "11011";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_TRAILER4_SEND_HEADER4);          
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER5_SEND_TRAILER5;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
          else
            current_state                 <= WAIT_SAMPLE_TRAILER4_SEND_TRAILER4;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;            
          end if;
          
        when WAIT_SAMPLE_TRAILER5_SEND_TRAILER5 =>
          df_internal_status_monitor(4 downto 0) <= "11100";
          --STATE_MACHINE_STATE_MONITOR <= (ERROR_BITPOS_WAIT_SAMPLE_TRAILER5_SEND_HEADER5);
          -- ==============================================================
          if (fifo_go_next_if_exist_out_buf='1' and DEN_IN='1') then
            current_state                 <= WAIT_CHECK_HEADER0_AND_SEND_DF_HEADER_NOT_SAMPLE_DATA;
            moddata_out_selected          <= '0';
            in_reading_event_buf          <= '0';
            allow_read_fifo_at_next_cycle <= '0';
            next_frame_out_buf            <= CTRL_IN & DEN_IN & DATA_IN;
            next_moddata_out_buf          <= moddata_out_idle;
            df_internal_event_counter     <= df_internal_event_counter + 1; 
            --update event counter
          else
            current_state                 <= WAIT_SAMPLE_TRAILER5_SEND_TRAILER5;
            moddata_out_selected          <= '0';
            allow_read_fifo_at_next_cycle <= '1';
            next_frame_out_buf            <= frame_out_idle;
            next_moddata_out_buf          <= moddata_out_idle;
          end if;          
          
      end case;
    end if;
  end process;
  
  mod2idx_wen_confin_buf(0) <= MOD2IDX_WEN_CONFIN;
  MOD2IDX_LUT : input_mod2idx_my_wrapper
    port map (
      -- configuration / monitoring port      
      clka  => MAIN_CLK,
      wea   => mod2idx_wen_confin_buf,
      addra => MOD2IDX_ADDR_CONFIN,
      dina  => MOD2IDX_DATA_CONFIN,
      douta => MOD2IDX_DATA_CONFOUT,
      -- main access of LUT      
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => mod2idx_lut_addr_in,
      dinb  => (others => '0'),
      doutb => mod2idx_lut_data_out);

  idx2mod_wen_confin_buf(0) <= IDX2MOD_WEN_CONFIN;
  IDX2MOD_LUT : input_idx2mod_my_wrapper
    port map (
      -- configuration / monitoring port      
      clka  => MAIN_CLK,
      wea   => idx2mod_wen_confin_buf, 
      addra => IDX2MOD_ADDR_CONFIN,
      dina  => IDX2MOD_DATA_CONFIN,
      douta => IDX2MOD_DATA_CONFOUT,
      -- main access of LUT      
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => idx2mod_lut_addr_in,
      dinb  => (others => '0'),
      doutb => idx2mod_lut_data_out);
  
  pixmod2dst_wen_confin_buf(0) <= PIXMOD2DST_WEN_CONFIN;
  PIXMOD2DST_LUT : input_pixmod2dest_my_wrapper
    port map (
      -- configuration / monitoring port
      clka  => MAIN_CLK,
      wea   => pixmod2dst_wen_confin_buf,
      addra => PIXMOD2DST_ADDR_CONFIN,
      dina  => PIXMOD2DST_DATA_CONFIN,
      douta => PIXMOD2DST_DATA_CONFOUT,
      -- main access of LUT
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => pixmod2dst_lut_addr_in,
      dinb  => (others => '0'),
      doutb => pixmod2dst_lut_data_out
      );
  
  sctmod2dst_wen_confin_buf(0) <= SCTMOD2DST_WEN_CONFIN;
  SCTMOD2DST_LUT : input_sctmod2dest_my_wrapper
    port map (
      -- configuration / monitoring port
      clka  => MAIN_CLK,
      wea   => sctmod2dst_wen_confin_buf,
      addra => SCTMOD2DST_ADDR_CONFIN,
      dina  => SCTMOD2DST_DATA_CONFIN,
      douta => SCTMOD2DST_DATA_CONFOUT,
      -- main access of LUT
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => sctmod2dst_lut_addr_in,
      dinb  => (others => '0'),
      doutb => sctmod2dst_lut_data_out
      );  
  
end logic;
