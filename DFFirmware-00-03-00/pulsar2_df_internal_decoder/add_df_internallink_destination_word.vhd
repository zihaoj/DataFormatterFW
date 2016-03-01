--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity add_df_internallink_destination_word is
  generic ( LANE_ID : integer );
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
      --LOCAL_DESTINATION_WORD      : in  std_logic_vector(15 downto 0);
      INTERNALLINK_DESTINATION_WORDS : in DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY;
      
      STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
      );
end add_df_internallink_destination_word;

architecture logic of add_df_internallink_destination_word is

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
  
  type state_machine is (WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER,
                         WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_LOCAL_DESTINATION_BIT,
                         WAIT_SEND_GLOBAL_DESTINATION_BIT,
                         WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER);
  
  signal current_state_i : state_machine := WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
  signal allow_read_fifo_at_next_cycle : std_logic; -- according to the "NEXT state"
  signal output_ready  : std_logic;
  signal next_output_data : std_logic_vector(32 downto 0); -- according to the "CURRENT state"
  constant output_idle : std_logic_vector(32 downto 0) := (others => '0');
  signal global_destination_i : std_logic_vector(31 downto 0);
  signal input_go_next_if_exist_i : std_logic;
  signal state_machine_error_out_buf : std_logic_vector(31 downto 0) := (others => '0');
  
  constant ERROR_BITPOS_WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER                       : integer := 0;
  constant ERROR_BITPOS_WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_LOCAL_DESTINATION_BIT : integer := 1;
  constant ERROR_BITPOS_WAIT_SEND_GLOBAL_DESTINATION_BIT                                  : integer := 2;
  constant ERROR_BITPOS_WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER         : integer := 3;

  signal input_fifo_empty_i : std_logic;
  signal input_fifo_full_i  : std_logic;
  signal data_in_i   : std_logic_vector(31 downto 0);
  signal den_in_i    : std_logic;
  signal float4bit_i : std_logic_vector(3 downto 0);
  signal distribution_switch_i : std_logic := '0';
  
  signal reference_index_i : integer range 0 to 31 := 0;
  
begin
  
  READY_OUT <= '0' when (input_fifo_full_i='1' and input_fifo_empty_i='0') else '1';
  WEN_OUT  <= next_output_data(32);
  DATA_OUT <= next_output_data(31 downto 0);
  output_ready <= (not XOFF_IN);     
  STATE_MACHINE_ERROR_MONITOR <= state_machine_error_out_buf;-- not really implmented yet

  INPUT_BUFFER: fwft_cc_w36_d512_my_wrapper
    port map (
      clk => MAIN_CLK,
      rst => RESET_IN,
      din(31 downto  0) => DATA_IN,
      din(35 downto 32) => (others => '0'),
      wr_en => DEN_IN,
      rd_en => input_go_next_if_exist_i,
      dout(31 downto  0) => data_in_i,
      dout(35 downto 32) => float4bit_i,
      empty => input_fifo_empty_i,
      prog_full => input_fifo_full_i
      );  
  
  input_go_next_if_exist_i <= output_ready and allow_read_fifo_at_next_cycle;
  den_in_i <= (not input_fifo_empty_i);
  
  process (MAIN_CLK, RESET_IN)
  begin
    if    (RESET_IN='1')  then
      current_state_i <= WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
      state_machine_error_out_buf <= (others => '0');
      allow_read_fifo_at_next_cycle <= '0';
      next_output_data <= output_idle;
      distribution_switch_i <= '0';
      
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      case current_state_i is
        
        when WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER =>          
          
          -- ===================================================
          if ( ((data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_HEADER) or
                (data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_HEADER_FAKE) ) and
               (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i <= WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_LOCAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= den_in_i&data_in_i;
            reference_index_i <= (32 + LANE_ID - conv_integer(data_in_i(DFIF_HEADER_RANDOM_COUNTER_LAST downto DFIF_HEADER_RANDOM_COUNTER_FIRST)) ) mod 32;
          else
            current_state_i <= WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_LOCAL_DESTINATION_BIT =>
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i <= WAIT_SEND_GLOBAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            distribution_switch_i <= (not distribution_switch_i);
            if (distribution_switch_i='0') then
              next_output_data <= '1' & X"0000" & INTERNALLINK_DESTINATION_WORDS(reference_index_i);
              global_destination_i <= data_in_i;
            else
              next_output_data <= '1' & INTERNALLINK_DESTINATION_WORDS(reference_index_i) & X"0000";
              global_destination_i <= data_in_i;
            end if;
          else
            current_state_i <= WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_LOCAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SEND_GLOBAL_DESTINATION_BIT =>
          -- ===================================================
          if (output_ready='1') then
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= '1' & global_destination_i;
          else
            current_state_i <= WAIT_SEND_GLOBAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= output_idle;
          end if;          
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER =>
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            
            if ( (data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_TRAILER) ) then
              current_state_i <= WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
              allow_read_fifo_at_next_cycle <= '1';
              next_output_data <= den_in_i&data_in_i;
            else
              current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER;
              allow_read_fifo_at_next_cycle <= '1';
              next_output_data <= den_in_i&data_in_i;
            end if;
          else -- invalid input
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
      end case;
    end if;
  end process;
  
end logic;
