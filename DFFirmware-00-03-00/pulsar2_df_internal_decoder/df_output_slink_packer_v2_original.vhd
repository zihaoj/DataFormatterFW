-- newer version of event sorter

--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use work.data_formatter_constants.all;

entity df_output_slink_packer is
  generic (
    USE_SHORT_FRAME_FIFO_FOR_DEBUGGING : std_logic := '0';
    NO_EVENT_SORTING_MODE : integer := 0);
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
    
    -- <configure / monitor>
    EVENT_SORTING_FIFO_FULL     : out std_logic;
    NUMBER_OF_EXPECTED_MODULES  : in  integer;
    STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0);
    NUMBER_OF_DISCARDED_MODULES : out std_logic_vector(31 downto 0)
    );
end df_output_slink_packer;

architecture logic of df_output_slink_packer  is
  
  component df_eventid_comparator
    port (
      -- common clock
      MAIN_CLK : in std_logic;
      RESET_IN : in std_logic;
      -- input port
      CURRENT_EVENTID : in std_logic_vector(DFIF_EVID_LENGTH-1 downto 0);
      
      DIN      : in  std_logic_vector(31 downto 0);
      DIN_WEN  : in  std_logic;
      DIN_RDY  : out std_logic;
      
      PORT1_DOUT     : out std_logic_vector(31 downto 0);
      PORT1_DOUT_WEN : out std_logic;
      PORT1_DOUT_RDY : in  std_logic;
      
      PORT2_DOUT     : out std_logic_vector(31 downto 0);
      PORT2_DOUT_WEN : out std_logic;
      PORT2_DOUT_RDY : in  std_logic;
      
      NUMBER_OF_DISCARDED_MODULES : out std_logic_vector(31 downto 0)
      );
  end component;
  
  component df_switch_2ch_merger
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
      -- output port
      OUTPUT_PORT_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT_DEN  : out std_logic;
      OUTPUT_PORT_RDY  : in  std_logic
      );
  end component;

  component short_fwft_fifo
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

  component event_sorting_buffer_my_wrapper
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
  
  type state_machine_t is (WAIT_SAMPLE_INTERNAL_HEADER_IN_FRAME_AND_SKIP,
                           WAIT_SAMPLE_HEADER0_AND_SEND_HEADER0,
                           WAIT_SAMPLE_HEADER1_AND_SEND_HEADER1,
                           WAIT_SAMPLE_HEADER2_AND_SEND_HEADER2,
                           WAIT_SAMPLE_HEADER3_AND_SEND_HEADER3,
                           WAIT_SAMPLE_HEADER4_AND_SEND_HEADER4,
                           WAIT_SAMPLE_HEADER5_AND_SEND_HEADER5,
                           WAIT_SAMPLE_HEADER6_AND_SEND_HEADER6,
                           WAIT_SAMPLE_INTERNAL_HEADER_IN_MODDATA_AND_DECIDE,
                           WAIT_SAMPLE_LOCAL_DESTINATION_WORD_AND_SKIP_IT,
                           WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER,
                           WAIT_SAMPLE_DATA_AND_SKIP_AND_CHECK_TRAILER,
                           WAIT_SAMPLE_EODA_WORD_AND_SEND_EODA_WORD,                         
                           WAIT_SAMPLE_TRAILER1_SEND_TRAILER1,
                           WAIT_SAMPLE_TRAILER2_SEND_TRAILER2,
                           WAIT_SAMPLE_TRAILER3_SEND_TRAILER3,
                           WAIT_SAMPLE_TRAILER4_SEND_TRAILER4,
                           WAIT_SAMPLE_TRAILER5_SEND_TRAILER5);
  
  constant ERROR_BITPOS_WAIT_SAMPLE_INTERNAL_HEADER_IN_FRAME_AND_SKIP : integer := 0;
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER0_AND_SEND_HEADER0 : integer := 1;
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER1_AND_SEND_HEADER1 : integer := 2;
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER2_AND_SEND_HEADER2 : integer := 3;
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER3_AND_SEND_HEADER3 : integer := 4;
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER4_AND_SEND_HEADER4 : integer := 5;
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER5_AND_SEND_HEADER5 : integer := 6;
  constant ERROR_BITPOS_WAIT_SAMPLE_HEADER6_AND_SEND_HEADER6 : integer := 7;
  constant ERROR_BITPOS_WAIT_SAMPLE_INTERNAL_HEADER_IN_MODDATA_AND_DECIDE : integer := 8;
  constant ERROR_BITPOS_WAIT_SAMPLE_LOCAL_DESTINATION_WORD_AND_SKIP_IT   : integer := 10;
  constant ERROR_BITPOS_WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER : integer := 11;
  constant ERROR_BITPOS_WAIT_SAMPLE_DATA_AND_SKIP_AND_CHECK_TRAILER : integer := 12;
  constant ERROR_BITPOS_WAIT_SAMPLE_EODA_WORD_AND_SEND_EODA_WORD : integer := 13;
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER1_SEND_TRAILER1 : integer := 14;
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER2_SEND_TRAILER2 : integer := 15;
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER3_SEND_TRAILER3 : integer := 16;
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER4_SEND_TRAILER4 : integer := 17;
  constant ERROR_BITPOS_WAIT_SAMPLE_TRAILER5_SEND_TRAILER5 : integer := 18;
  
  signal current_state : state_machine_t := WAIT_SAMPLE_INTERNAL_HEADER_IN_FRAME_AND_SKIP;
  
  signal moddata_empty_i : std_logic;
  signal moddata_full_i  : std_logic;
  signal frame_empty_i   : std_logic;
  signal frame_full_i    : std_logic;
  
  signal link_ready  : std_logic;
  signal slink_ready : std_logic;
  
  signal slink_out_buf : std_logic_vector(33 downto 0);
  -- [33]=CTRL_N / [32]=WEN_N [31:0]=DATA
  constant slink_idle : std_logic_vector(33 downto 0) := "11"& X"00000000";
  constant slink_ctrl_fragment : std_logic_vector(1 downto 0) := "00";
  constant slink_data_fragment : std_logic_vector(1 downto 0) := "10";
  
  signal float_moddata : std_logic_vector(3 downto 0);
  signal float_frame   : std_logic_vector(2 downto 0);

  signal allow_read_fifo_at_next_cycle    : std_logic;
  signal moddata_input_go_next_if_exist_i : std_logic;
  signal frame_input_go_next_if_exist_i   : std_logic;
  signal frame_data_i : std_logic_vector(31 downto 0);
  signal frame_ctrl_i : std_logic;
  signal frame_den_i  : std_logic;  
  
  signal moddata_data_i : std_logic_vector(31 downto 0);  
  signal moddata_den_i  : std_logic;
  
  signal readmode            : std_logic_vector(1 downto 0);
  constant read_moddata_mode : std_logic_vector(1 downto 0) := "01";
  constant read_frame_mode   : std_logic_vector(1 downto 0) := "10";
  constant noread_mode       : std_logic_vector(1 downto 0) := "00";
  signal moddata_selected    : std_logic;
  signal frame_selected      : std_logic;
  
  signal df_internal_event_counter : std_logic_vector(DFIF_EVID_LENGTH-1 downto 0);
  
  signal number_of_checked_modules : integer range 0 to MAXIMUM_NUMBER_OF_MODULES_PER_OUTPUT_LANE-1 := 0;
  signal number_of_words           : std_logic_vector(31 downto 0);
  
  signal error_flags_buf : std_logic_vector(31 downto 0) := (others => '0');

  -- for DFF input
  signal input_moddata_din_i : std_logic_vector(31 downto 0);
  signal input_moddata_den_i : std_logic;

  signal input_frame_data_in_i : std_logic_vector(31 downto 0);  
  signal input_frame_wen_in_i  : std_logic;
  signal input_frame_ctrl_in_i  : std_logic;

  signal number_of_discarded_modules_i : std_logic_vector(31 downto 0);
  
  signal eventid_comparator_1_din_i        : std_logic_vector(31 downto 0);
  signal eventid_comparator_1_din_wen_i    : std_logic;
  signal eventid_comparator_1_din_rdy_i    : std_logic;
  signal eventid_comparator_1_port1_dout_i     : std_logic_vector(31 downto 0);
  signal eventid_comparator_1_port1_dout_wen_i : std_logic;
  signal eventid_comparator_1_port1_dout_rdy_i : std_logic;
  signal eventid_comparator_1_port2_dout_i     : std_logic_vector(31 downto 0);
  signal eventid_comparator_1_port2_dout_wen_i : std_logic;
  signal eventid_comparator_1_port2_dout_rdy_i : std_logic;  
  signal eventid_comparator_1_number_of_discarded_modules : std_logic_vector(31 downto 0);

  signal merger_1_input_port1_din_i  : std_logic_vector(31 downto 0);
  signal merger_1_input_port1_den_i  : std_logic;
  signal merger_1_input_port1_rdy_i  : std_logic;
  signal merger_1_input_port2_din_i  : std_logic_vector(31 downto 0);
  signal merger_1_input_port2_den_i  : std_logic;
  signal merger_1_input_port2_rdy_i  : std_logic;
  signal merger_1_output_port_dout_i : std_logic_vector(31 downto 0);
  signal merger_1_output_port_den_i  : std_logic;
  signal merger_1_output_port_rdy_i  : std_logic;

  signal eventid_comparator_2_din_i     : std_logic_vector(31 downto 0);
  signal eventid_comparator_2_din_wen_i : std_logic;
  signal eventid_comparator_2_din_rdy_i : std_logic;
  signal eventid_comparator_2_port1_dout_i     : std_logic_vector(31 downto 0);
  signal eventid_comparator_2_port1_dout_wen_i : std_logic;
  signal eventid_comparator_2_port1_dout_rdy_i : std_logic;
  signal eventid_comparator_2_port2_dout_i     : std_logic_vector(31 downto 0);
  signal eventid_comparator_2_port2_dout_wen_i : std_logic;
  signal eventid_comparator_2_port2_dout_rdy_i : std_logic;
  signal eventid_comparator_2_number_of_discarded_modules : std_logic_vector(31 downto 0);

  signal event_sorting_buffer_1_din_i   : std_logic_vector(31 downto 0);
  signal event_sorting_buffer_1_wr_en_i : std_logic;
  signal event_sorting_buffer_1_dout_i  : std_logic_vector(31 downto 0);
  signal event_sorting_buffer_1_rd_en_i : std_logic;
  signal event_sorting_buffer_1_dout_float4_i : std_logic_vector(35 downto 32);
  signal event_sorting_buffer_1_empty_i : std_logic;
  signal event_sorting_buffer_1_prog_full_i : std_logic;
  
  signal merger_2_input_port1_din_i  : std_logic_vector(31 downto  0);
  signal merger_2_input_port1_den_i  : std_logic;
  signal merger_2_input_port1_rdy_i  : std_logic;
  signal merger_2_input_port2_din_i  : std_logic_vector(31 downto  0);
  signal merger_2_input_port2_den_i  : std_logic;
  signal merger_2_input_port2_rdy_i  : std_logic;
  signal merger_2_output_port_dout_i : std_logic_vector(31 downto  0);
  signal merger_2_output_port_den_i  : std_logic;
  signal merger_2_output_port_rdy_i  : std_logic;
  
begin
  
  STATE_MACHINE_ERROR_MONITOR <= error_flags_buf;
  NUMBER_OF_DISCARDED_MODULES <= number_of_discarded_modules_i;
  
  
  EVENT_SORTING_LOGIC : if NO_EVENT_SORTING_MODE = 0 generate
  begin    
    -- EVENT ID COMPARATOR 1 INPUT
    eventid_comparator_1_din_i            <= MODDATA_DIN;
    eventid_comparator_1_din_wen_i        <= MODDATA_DEN;
    MODDATA_RDY                           <= eventid_comparator_1_din_rdy_i;    
    
    eventid_comparator_1 : df_eventid_comparator
      port map (
        MAIN_CLK => MAIN_CLK,
        RESET_IN => RESET_IN,
        CURRENT_EVENTID => df_internal_event_counter,
        
        DIN     => eventid_comparator_1_din_i,
        DIN_WEN => eventid_comparator_1_din_wen_i,
        DIN_RDY => eventid_comparator_1_din_rdy_i,
        
        PORT1_DOUT     => eventid_comparator_1_port1_dout_i,
        PORT1_DOUT_WEN => eventid_comparator_1_port1_dout_wen_i,
        PORT1_DOUT_RDY => eventid_comparator_1_port1_dout_rdy_i,
        
        PORT2_DOUT     => eventid_comparator_1_port2_dout_i,
        PORT2_DOUT_WEN => eventid_comparator_1_port2_dout_wen_i,
        PORT2_DOUT_RDY => eventid_comparator_1_port2_dout_rdy_i,
        
        NUMBER_OF_DISCARDED_MODULES => eventid_comparator_1_number_of_discarded_modules
        );
    
    -- EVENT ID COMPARATOR 1 PORT2 => MERGER 1 PORT1
    merger_1_input_port1_din_i            <= eventid_comparator_1_port2_dout_i;
    merger_1_input_port1_den_i            <= eventid_comparator_1_port2_dout_wen_i;
    eventid_comparator_1_port2_dout_rdy_i <= merger_1_input_port1_rdy_i;
    -- EVENT ID COMPARATOR 2 PORT2 => MERGER 1 PORT2
    merger_1_input_port2_din_i            <= eventid_comparator_2_port2_dout_i;
    merger_1_input_port2_den_i            <= eventid_comparator_2_port2_dout_wen_i;
    eventid_comparator_2_port2_dout_rdy_i <= merger_1_input_port2_rdy_i;
    
    merger_1 : df_switch_2ch_merger
      port map (
        CLK => MAIN_CLK,
        RST => RESET_IN,
        INPUT_PORT1_DIN => merger_1_input_port1_din_i,
        INPUT_PORT1_DEN => merger_1_input_port1_den_i,
        INPUT_PORT1_RDY => merger_1_input_port1_rdy_i,
        INPUT_PORT2_DIN => merger_1_input_port2_din_i,
        INPUT_PORT2_DEN => merger_1_input_port2_den_i,
        INPUT_PORT2_RDY => merger_1_input_port2_rdy_i,
        OUTPUT_PORT_DOUT => merger_1_output_port_dout_i,
        OUTPUT_PORT_DEN  => merger_1_output_port_den_i,
        OUTPUT_PORT_RDY  => merger_1_output_port_rdy_i
        );

    -- EVENT SORTER BUFFER => EVENT ID COMPARATOR 2 
    eventid_comparator_2_din_i     <= event_sorting_buffer_1_dout_i;
    event_sorting_buffer_1_rd_en_i         <= eventid_comparator_2_din_rdy_i;
    eventid_comparator_2_din_wen_i <= '1' when (event_sorting_buffer_1_rd_en_i='1' and
                                                event_sorting_buffer_1_empty_i='0')
                                      else '0';
    
    eventid_comparator_2 : df_eventid_comparator
      port map (
        MAIN_CLK => MAIN_CLK,
        RESET_IN => RESET_IN,
        CURRENT_EVENTID => df_internal_event_counter,
        
        DIN     => eventid_comparator_2_din_i,
        DIN_WEN => eventid_comparator_2_din_wen_i,
        DIN_RDY => eventid_comparator_2_din_rdy_i,
        
        PORT1_DOUT     => eventid_comparator_2_port1_dout_i,
        PORT1_DOUT_WEN => eventid_comparator_2_port1_dout_wen_i,
        PORT1_DOUT_RDY => eventid_comparator_2_port1_dout_rdy_i,
        
        PORT2_DOUT     => eventid_comparator_2_port2_dout_i,
        PORT2_DOUT_WEN => eventid_comparator_2_port2_dout_wen_i,
        PORT2_DOUT_RDY => eventid_comparator_2_port2_dout_rdy_i,
        
        NUMBER_OF_DISCARDED_MODULES => eventid_comparator_2_number_of_discarded_modules
        );
    
    -- DFF -- MERGER 1 OUTPUT => EVENT SORTER BUFFER
    process (MAIN_CLK) is
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        event_sorting_buffer_1_din_i           <= merger_1_output_port_dout_i;
        event_sorting_buffer_1_wr_en_i         <= merger_1_output_port_den_i;
        if (event_sorting_buffer_1_prog_full_i='1' and event_sorting_buffer_1_empty_i='0') then
          merger_1_output_port_rdy_i <= '0';
        else
          merger_1_output_port_rdy_i <= '1';
        end if;
        
        number_of_discarded_modules_i <= (eventid_comparator_1_number_of_discarded_modules +
                                          eventid_comparator_2_number_of_discarded_modules);
        
        if (event_sorting_buffer_1_empty_i='1') then
          EVENT_SORTING_FIFO_FULL <= '0';
        else 
          EVENT_SORTING_FIFO_FULL <= event_sorting_buffer_1_prog_full_i;
        end if;
      end if;
    end process;
    
    event_sorting_buffer_1 : event_sorting_buffer_my_wrapper
      port map (
        clk => MAIN_CLK,
        rst => RESET_IN,
        din(31 downto  0) => event_sorting_buffer_1_din_i,
        din(35 downto 32) => (others => '0'),
        wr_en => event_sorting_buffer_1_wr_en_i,
        rd_en => event_sorting_buffer_1_rd_en_i,
        dout(31 downto  0)  => event_sorting_buffer_1_dout_i,
        dout(35 downto 32)  => event_sorting_buffer_1_dout_float4_i,
        empty => event_sorting_buffer_1_empty_i,
        prog_full => event_sorting_buffer_1_prog_full_i
        );
    
    -- EVENT ID COMPARATOR 2 PORT1 => MERGER 2 PORT2
    merger_2_input_port2_din_i            <= eventid_comparator_2_port1_dout_i;
    merger_2_input_port2_den_i            <= eventid_comparator_2_port1_dout_wen_i;
    eventid_comparator_2_port1_dout_rdy_i <= merger_2_input_port2_rdy_i;
    -- EVENT ID COMPARATOR 1 PORT1 => MERGER 2 PORT1
    merger_2_input_port1_din_i            <= eventid_comparator_1_port1_dout_i;
    merger_2_input_port1_den_i            <= eventid_comparator_1_port1_dout_wen_i;
    eventid_comparator_1_port1_dout_rdy_i <= merger_2_input_port1_rdy_i;
    
    merger_2 : df_switch_2ch_merger
      port map (
        CLK => MAIN_CLK,
        RST => RESET_IN,
        INPUT_PORT1_DIN => merger_2_input_port1_din_i,
        INPUT_PORT1_DEN => merger_2_input_port1_den_i,
        INPUT_PORT1_RDY => merger_2_input_port1_rdy_i,
        INPUT_PORT2_DIN => merger_2_input_port2_din_i,
        INPUT_PORT2_DEN => merger_2_input_port2_den_i,
        INPUT_PORT2_RDY => merger_2_input_port2_rdy_i,
        OUTPUT_PORT_DOUT => merger_2_output_port_dout_i,
        OUTPUT_PORT_DEN  => merger_2_output_port_den_i,
        OUTPUT_PORT_RDY  => merger_2_output_port_rdy_i
        );
    
    -- input moddata / frame
    process (MAIN_CLK) is
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        input_moddata_din_i <= merger_2_output_port_dout_i;
        input_moddata_den_i <= merger_2_output_port_den_i;
        
        input_frame_data_in_i <= FRAME_DATA_IN;
        input_frame_wen_in_i  <= FRAME_WEN_IN;
        input_frame_ctrl_in_i <= FRAME_CTRL_IN;
        
        if (moddata_empty_i='0' and moddata_full_i='1') then
          merger_2_output_port_rdy_i <= '0';
        else
          merger_2_output_port_rdy_i <= '1';
        end if;
        
        if (frame_empty_i='0' and frame_full_i='1') then
          FRAME_XOFF_OUT <= '1';
        else
          FRAME_XOFF_OUT <= '0';
        end if;      
        
      end if;
    end process;
  end generate;
  
  NO_EVENT_SORTING_LOGIC : if NO_EVENT_SORTING_MODE = 1 generate
  begin
    EVENT_SORTING_FIFO_FULL <= '0';
    -- input moddata / frame
    process (MAIN_CLK) is
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        input_moddata_din_i <= MODDATA_DIN;
        input_moddata_den_i <= MODDATA_DEN;
        
        input_frame_data_in_i <= FRAME_DATA_IN;
        input_frame_wen_in_i  <= FRAME_WEN_IN;
        input_frame_ctrl_in_i <= FRAME_CTRL_IN;
        
        if (moddata_empty_i='0' and moddata_full_i='1') then
          MODDATA_RDY <= '0';
        else
          MODDATA_RDY <= '1';
        end if;
        
        if (frame_empty_i='0' and frame_full_i='1') then
          FRAME_XOFF_OUT <= '1';
        else
          FRAME_XOFF_OUT <= '0';
        end if;      
        
      end if;
    end process;
  end generate;
  
  -- moddata
  MODDATA_INPUT_FIFO : fwft_cc_w36_d512_my_wrapper 
    port map (
      clk => MAIN_CLK,
      rst => RESET_IN,
      din(31 downto  0) => input_moddata_din_i,
      din(35 downto 32) => (others => '0'),
      wr_en => input_moddata_den_i,
      rd_en => moddata_input_go_next_if_exist_i,
      dout(31 downto  0) => moddata_data_i,
      dout(35 downto 32) => float_moddata,
      empty => moddata_empty_i,
      prog_full => moddata_full_i
      );
  
  -- frame
  INST_LONG_FRAME_FIFO : if USE_SHORT_FRAME_FIFO_FOR_DEBUGGING = '0' generate
  begin
    FRAME_INPUT_FIFO : fwft_cc_w36_d512_my_wrapper 
      port map (
        clk => MAIN_CLK,
        rst => RESET_IN,
        din(31 downto  0) => input_frame_data_in_i,
        din(32)           => input_frame_ctrl_in_i,
        din(35 downto 33) => (others => '0'),
        wr_en => input_frame_wen_in_i,
        rd_en => frame_input_go_next_if_exist_i,
        dout(31 downto  0) => frame_data_i,
        dout(32)           => frame_ctrl_i,
        dout(35 downto 33) => float_frame, 
        empty => frame_empty_i,
        prog_full => frame_full_i
        );
  end generate;

  INST_SHORT_FRAME_FIFO : if USE_SHORT_FRAME_FIFO_FOR_DEBUGGING = '1' generate
  begin
    FRAME_INPUT_FIFO : short_fwft_fifo
      port map (
        clk => MAIN_CLK,
        rst => RESET_IN,
        din(31 downto  0) => input_frame_data_in_i,
        din(32)           => input_frame_ctrl_in_i,
        din(35 downto 33) => (others => '0'),
        wr_en => input_frame_wen_in_i,
        rd_en => frame_input_go_next_if_exist_i,
        dout(31 downto  0) => frame_data_i,
        dout(32)           => frame_ctrl_i,
        dout(35 downto 33) => float_frame, 
        empty => frame_empty_i,
        prog_full => frame_full_i
        );    
  end generate;
  
  moddata_selected <= readmode(0);
  frame_selected   <= readmode(1);
  
  moddata_input_go_next_if_exist_i <= link_ready and allow_read_fifo_at_next_cycle and moddata_selected;
  frame_input_go_next_if_exist_i   <= link_ready and allow_read_fifo_at_next_cycle and frame_selected;
  moddata_den_i <= (not moddata_empty_i);
  frame_den_i   <= (not frame_empty_i);

  -- SLINK IO
  slink_ready   <= (SLINK_LFF_N and SLINK_LDOWN_N);
  SLINK_UCTRL_N <= slink_out_buf(33);
  SLINK_UWEN_N  <= slink_out_buf(32);
  SLINK_UD      <= slink_out_buf(31 downto 0);
  
  process (MAIN_CLK, RESET_IN)
  begin
    
    if (RESET_IN='1') then
      current_state <= WAIT_SAMPLE_INTERNAL_HEADER_IN_FRAME_AND_SKIP;
      readmode      <= noread_mode;
      df_internal_event_counter <= (others => '0');
      link_ready       <= '0';
      slink_out_buf    <= slink_idle;
      number_of_checked_modules  <=  0;
      error_flags_buf <= (others => '0');
      number_of_words <= (others => '0');
      allow_read_fifo_at_next_cycle <= '0';
      
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      
      case current_state is
        when WAIT_SAMPLE_INTERNAL_HEADER_IN_FRAME_AND_SKIP =>
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_HEADER0_AND_SEND_HEADER0;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
            --df_internal_event_counter     <= frame_data_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST);
            number_of_checked_modules     <= 0;
            number_of_words <= (others => '0');
          else 
            current_state                 <= WAIT_SAMPLE_INTERNAL_HEADER_IN_FRAME_AND_SKIP;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER0_AND_SEND_HEADER0 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_HEADER1_AND_SEND_HEADER1;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_ctrl_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_HEADER0_AND_SEND_HEADER0;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER1_AND_SEND_HEADER1 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_HEADER2_AND_SEND_HEADER2;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_HEADER1_AND_SEND_HEADER1;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER2_AND_SEND_HEADER2 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_HEADER3_AND_SEND_HEADER3;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_HEADER2_AND_SEND_HEADER2;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER3_AND_SEND_HEADER3 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_HEADER4_AND_SEND_HEADER4;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_HEADER3_AND_SEND_HEADER3;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER4_AND_SEND_HEADER4 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_HEADER5_AND_SEND_HEADER5;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_HEADER4_AND_SEND_HEADER4;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER5_AND_SEND_HEADER5 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_HEADER6_AND_SEND_HEADER6;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_HEADER5_AND_SEND_HEADER5;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_HEADER6_AND_SEND_HEADER6 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            if (NUMBER_OF_EXPECTED_MODULES=number_of_checked_modules) then
              -- last module data
              current_state                 <= WAIT_SAMPLE_EODA_WORD_AND_SEND_EODA_WORD;
              allow_read_fifo_at_next_cycle <= '1';
              readmode                      <= read_frame_mode;
              link_ready                    <= slink_ready;
              slink_out_buf                 <= slink_data_fragment & frame_data_i;
              number_of_checked_modules     <=  0;
            else 
              current_state                 <= WAIT_SAMPLE_INTERNAL_HEADER_IN_MODDATA_AND_DECIDE;
              allow_read_fifo_at_next_cycle <= '1';
              readmode                      <= read_moddata_mode;
              link_ready                    <= slink_ready;
              slink_out_buf                 <= slink_data_fragment & frame_data_i;
            end if;
          else 
            current_state                 <= WAIT_SAMPLE_HEADER6_AND_SEND_HEADER6;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_INTERNAL_HEADER_IN_MODDATA_AND_DECIDE =>
          -- ==================================================================
          if (moddata_input_go_next_if_exist_i='1' and moddata_den_i='1') then
            
            number_of_checked_modules <= number_of_checked_modules+1;
            
            if (moddata_data_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) = DFIF_FRAGMENTID_HEADER) then
              current_state                 <= WAIT_SAMPLE_LOCAL_DESTINATION_WORD_AND_SKIP_IT;
              allow_read_fifo_at_next_cycle <= '1';
              readmode                      <= read_moddata_mode;
              link_ready                    <= slink_ready;
              slink_out_buf                 <= slink_idle;
            elsif (moddata_data_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) = DFIF_FRAGMENTID_HEADER_FAKE) then
              current_state                 <= WAIT_SAMPLE_DATA_AND_SKIP_AND_CHECK_TRAILER;
              allow_read_fifo_at_next_cycle <= '1';
              readmode                      <= read_moddata_mode;
              link_ready                    <= slink_ready;
              slink_out_buf                 <= slink_idle;
            else -- ERROR STATUS !!
              current_state                 <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
              allow_read_fifo_at_next_cycle <= '1';
              readmode                      <= read_moddata_mode;
              link_ready                    <= slink_ready;
              slink_out_buf                 <= slink_idle;
              error_flags_buf(ERROR_BITPOS_WAIT_SAMPLE_INTERNAL_HEADER_IN_MODDATA_AND_DECIDE) <= '1';
            end if;
            
          else 
            current_state                 <= WAIT_SAMPLE_INTERNAL_HEADER_IN_MODDATA_AND_DECIDE;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_moddata_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;

        when WAIT_SAMPLE_DATA_AND_SKIP_AND_CHECK_TRAILER =>
          -- ==================================================================
          if (moddata_input_go_next_if_exist_i='1' and moddata_den_i='1') then
            if (moddata_data_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) = DFIF_FRAGMENTID_TRAILER) then
              if (NUMBER_OF_EXPECTED_MODULES=number_of_checked_modules) then
                -- last module data
                df_internal_event_counter     <= df_internal_event_counter+1;--when_transition_to_E0DA_happen
                current_state                 <= WAIT_SAMPLE_EODA_WORD_AND_SEND_EODA_WORD;                
                allow_read_fifo_at_next_cycle <= '1';
                readmode                      <= read_frame_mode;
                link_ready                    <= slink_ready;
                slink_out_buf                 <= slink_idle;
                number_of_checked_modules     <=  0;
              else 
                current_state                 <= WAIT_SAMPLE_INTERNAL_HEADER_IN_MODDATA_AND_DECIDE;
                allow_read_fifo_at_next_cycle <= '1';
                readmode                      <= read_moddata_mode;
                link_ready                    <= slink_ready;
                slink_out_buf                 <= slink_idle;
              end if;
            else
              current_state                 <= WAIT_SAMPLE_DATA_AND_SKIP_AND_CHECK_TRAILER;
              allow_read_fifo_at_next_cycle <= '1';
              readmode                      <= read_moddata_mode;
              link_ready                    <= slink_ready;
              slink_out_buf                 <= slink_idle;
            end if;
          else
            current_state                 <= WAIT_SAMPLE_DATA_AND_SKIP_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_moddata_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_LOCAL_DESTINATION_WORD_AND_SKIP_IT =>
          -- ==================================================================
          if (moddata_input_go_next_if_exist_i='1' and moddata_den_i='1') then
            current_state                 <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_moddata_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          else
            current_state                 <= WAIT_SAMPLE_LOCAL_DESTINATION_WORD_AND_SKIP_IT;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_moddata_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;          
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER =>
          -- ==================================================================
          if (moddata_input_go_next_if_exist_i='1' and moddata_den_i='1') then
            if (moddata_data_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) = DFIF_FRAGMENTID_TRAILER) then
              if (NUMBER_OF_EXPECTED_MODULES=number_of_checked_modules) then
                -- last module data
                df_internal_event_counter     <= df_internal_event_counter+1;--when_transition_to_E0DA_happen
                current_state                 <= WAIT_SAMPLE_EODA_WORD_AND_SEND_EODA_WORD;
                allow_read_fifo_at_next_cycle <= '1';
                readmode                      <= read_frame_mode;
                link_ready                    <= slink_ready;
                slink_out_buf                 <= slink_idle;
                number_of_checked_modules     <=  0;
              else
                current_state                 <= WAIT_SAMPLE_INTERNAL_HEADER_IN_MODDATA_AND_DECIDE;
                allow_read_fifo_at_next_cycle <= '1';
                readmode                      <= read_moddata_mode;
                link_ready                    <= slink_ready;
                slink_out_buf                 <= slink_idle;
              end if;
            else
              current_state                 <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
              allow_read_fifo_at_next_cycle <= '1';
              readmode                      <= read_moddata_mode;
              link_ready                    <= slink_ready;
              slink_out_buf                 <= slink_data_fragment & moddata_data_i;
              number_of_words               <= number_of_words + 1;
            end if;
          else
            current_state                 <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_moddata_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_EODA_WORD_AND_SEND_EODA_WORD =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER1_SEND_TRAILER1;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_ctrl_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_EODA_WORD_AND_SEND_EODA_WORD;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_TRAILER1_SEND_TRAILER1 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER2_SEND_TRAILER2;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_TRAILER1_SEND_TRAILER1;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_TRAILER2_SEND_TRAILER2 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER3_SEND_TRAILER3;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_TRAILER2_SEND_TRAILER2;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_TRAILER3_SEND_TRAILER3 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER4_SEND_TRAILER4;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment &
                                             frame_data_i;-- Nina changed,
                                                          -- before
                                                          -- frame_data_i was
                                                          -- number_of_words
                                                        
                                                       
                                                       
          else 
            current_state                 <= WAIT_SAMPLE_TRAILER3_SEND_TRAILER3;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;          
          
        when WAIT_SAMPLE_TRAILER4_SEND_TRAILER4 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_TRAILER5_SEND_TRAILER5;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_data_fragment & number_of_words;
-- Nina chaned before number_of_words was frame_data_i
          else 
            current_state                 <= WAIT_SAMPLE_TRAILER4_SEND_TRAILER4;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
          
        when WAIT_SAMPLE_TRAILER5_SEND_TRAILER5 =>
          -- ==================================================================
          if (frame_input_go_next_if_exist_i='1' and frame_den_i='1') then
            current_state                 <= WAIT_SAMPLE_INTERNAL_HEADER_IN_FRAME_AND_SKIP;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_ctrl_fragment & frame_data_i;
          else 
            current_state                 <= WAIT_SAMPLE_TRAILER5_SEND_TRAILER5;
            allow_read_fifo_at_next_cycle <= '1';
            readmode                      <= read_frame_mode;
            link_ready                    <= slink_ready;
            slink_out_buf                 <= slink_idle;
          end if;
      end case;
    end if;
    
  end process;


  
end logic;
