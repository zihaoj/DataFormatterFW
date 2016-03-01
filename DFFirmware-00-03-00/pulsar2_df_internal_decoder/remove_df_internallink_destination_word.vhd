--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity remove_df_internallink_destination_word is
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
      STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
      );
end remove_df_internallink_destination_word;

architecture logic of remove_df_internallink_destination_word is
  
  component fwft_cc_w36_d512_my_wrapper
    port (
      rst : in std_logic;
      clk : in std_logic;
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      empty : out std_logic;
      prog_full : out std_logic
      );
  end component;
  
  type state_machine is (WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER,
                         WAIT_SAMPLE_LOCAL_DESTINATION_BIT_AND_SKIP_LOCAL_DESTINATION_BIT,
                         WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_GLOBAL_DESTINATION_BIT,
                         WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER);
  
  signal current_state_i : state_machine := WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
  signal allow_read_fifo_at_next_cycle : std_logic; -- according to the "NEXT state"
  signal output_ready  : std_logic;
  signal next_output_data : std_logic_vector(32 downto 0); -- according to the "CURRENT state"
  constant output_idle : std_logic_vector(32 downto 0) := (others => '0');
  signal input_go_next_if_exist_i : std_logic;
  signal state_machine_error_out_buf : std_logic_vector(31 downto 0) := (others => '0');
  
  constant ERROR_BITPOS_WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER                   : integer := 0;
  constant ERROR_BITPOS_WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_SEND_LOCAL_DESTINATION_BIT : integer := 1;
  constant ERROR_BITPOS_WAIT_SEND_GLOBAL_DESTINATION_BIT                              : integer := 2;
  constant ERROR_BITPOS_WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER     : integer := 3;
  
  signal input_fifo_empty_i : std_logic;
  signal input_fifo_full_i  : std_logic;
  signal data_in_i   : std_logic_vector(31 downto 0);
  signal den_in_i    : std_logic;
  signal float4bit_i : std_logic_vector(3 downto 0);
  
  signal input_buffer_data_i      : std_logic_vector(31 downto 0);
  signal input_buffer_den_i       : std_logic;
  signal input_buffer_ready_out_i : std_logic;
  
begin

  input_buffer_ready_out_i <= '0' when (input_fifo_full_i='1' and input_fifo_empty_i='0') else '1';
  WEN_OUT  <= next_output_data(32);
  DATA_OUT <= next_output_data(31 downto 0);
  output_ready <= (not XOFF_IN);     
  STATE_MACHINE_ERROR_MONITOR <= state_machine_error_out_buf;-- not really implmented yet

  process (MAIN_CLK)
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      input_buffer_data_i <= DATA_IN;
      input_buffer_den_i  <= DEN_IN;
      READY_OUT           <= input_buffer_ready_out_i;
    end if;
  end process;
  
  INPUT_BUFFER: fwft_cc_w36_d512_my_wrapper
    port map (
      clk => MAIN_CLK,
      rst => RESET_IN,
      din(31 downto  0) => input_buffer_data_i,
      din(35 downto 32) => (others => '0'),
      wr_en => input_buffer_den_i,
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
      
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      case current_state_i is
        
        when WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER =>          
          
          -- ===================================================
          if ( ((data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_HEADER) or
                (data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_HEADER_FAKE)) and
               (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i <= WAIT_SAMPLE_LOCAL_DESTINATION_BIT_AND_SKIP_LOCAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= den_in_i&data_in_i;
          else
            current_state_i <= WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SAMPLE_LOCAL_DESTINATION_BIT_AND_SKIP_LOCAL_DESTINATION_BIT =>
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i <= WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_GLOBAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          else
            current_state_i <= WAIT_SAMPLE_LOCAL_DESTINATION_BIT_AND_SKIP_LOCAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_GLOBAL_DESTINATION_BIT =>
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= den_in_i&data_in_i;
          else
            current_state_i <= WAIT_SAMPLE_GLOBAL_DESTINATION_BIT_AND_SEND_GLOBAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
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
