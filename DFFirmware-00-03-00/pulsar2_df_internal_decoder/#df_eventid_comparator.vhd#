-- newer version of event sorter

--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use work.data_formatter_constants.all;

entity df_eventid_comparator is
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
end df_eventid_comparator;

architecture logic of df_eventid_comparator is
  
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
  
  type state_machine_t is (WAIT_SAMPLE_INTERNAL_HEADER_AND_DECIDE,
                           WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT1_AND_CHECK_TRAILER,
                           WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT2_AND_CHECK_TRAILER,
                           WAIT_SAMPLE_DATA_AND_DISCARD_DATA_AND_CHECK_TRAILER);
  
  signal current_state : state_machine_t := WAIT_SAMPLE_INTERNAL_HEADER_AND_DECIDE;
  signal current_eventid_i : std_logic_vector(DFIF_EVID_LENGTH-1 downto 0);
  
  signal input_port_din_i   : std_logic_vector(31 downto 0);
  signal input_port_den_i   : std_logic;
  signal input_port_empty_i : std_logic;
  signal input_port_full_i  : std_logic;
  signal allow_read_fifo_at_next_cycle_i : std_logic;

  constant data_valid : std_logic := '1';
  constant idle_word  : std_logic_vector(32 downto 0) := (not data_valid)&X"00000000";
  signal output_port1_data_buf_i : std_logic_vector(32 downto 0);
  signal output_port2_data_buf_i : std_logic_vector(32 downto 0);
  
  signal number_of_discarded_modules_i : std_logic_vector(31 downto 0);
  signal input_go_next_if_exist_i      : std_logic;
  
  signal din_i       : std_logic_vector(31 downto  0);
  signal float_din_i : std_logic_vector(35 downto 32);
  signal den_i       : std_logic;
  signal link_ready  : std_logic;

  attribute mark_debug : string;
  attribute mark_debug of current_state : signal is "true";
  attribute mark_debug of current_eventid_i : signal is "true";
  attribute mark_debug of allow_read_fifo_at_next_cycle_i : signal is "true";
  attribute mark_debug of link_ready : signal is "true";
  attribute mark_debug of input_go_next_if_exist_i : signal is "true";
  attribute mark_debug of din_i : signal is "true";
  attribute mark_debug of den_i : signal is "true";

begin
  
  PORT1_DOUT_WEN <= output_port1_data_buf_i(32);
  PORT1_DOUT     <= output_port1_data_buf_i(31 downto 0);
  
  PORT2_DOUT_WEN <= output_port2_data_buf_i(32);
  PORT2_DOUT     <= output_port2_data_buf_i(31 downto 0);      
  
  process (MAIN_CLK) is
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      current_eventid_i           <= CURRENT_EVENTID;
      NUMBER_OF_DISCARDED_MODULES <= number_of_discarded_modules_i;
      input_port_din_i <= DIN;
      input_port_den_i <= DIN_WEN;

      if input_port_empty_i='0' and input_port_full_i='1' then
        DIN_RDY <= '0';
      else
        DIN_RDY <= '1';
      end if;            
    end if;
  end process;
  
  input_fifo : fwft_cc_w36_d512_my_wrapper
    port map (
      clk   => MAIN_CLK,
      rst   => RESET_IN,
      din(31 downto  0)  => input_port_din_i,
      din(35 downto 32)  => (others=>'0'),
      wr_en => input_port_den_i,
      rd_en => input_go_next_if_exist_i,
      dout(31 downto  0)  => din_i,
      dout(35 downto 32)  => float_din_i,
      empty => input_port_empty_i,
      prog_full => input_port_full_i
      );
  
  den_i <= (not input_port_empty_i);
  input_go_next_if_exist_i <= link_ready and allow_read_fifo_at_next_cycle_i;
  
  process (MAIN_CLK, RESET_IN) is
  begin
    if (RESET_IN='1') then
      current_state <= WAIT_SAMPLE_INTERNAL_HEADER_AND_DECIDE;
      number_of_discarded_modules_i <= (others => '0');
      link_ready <= '0';
      allow_read_fifo_at_next_cycle_i <= '0';
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      
      case current_state is
        when WAIT_SAMPLE_INTERNAL_HEADER_AND_DECIDE =>
          if (input_go_next_if_exist_i='1' and den_i='1') then
            -- first word should be header, although more strict check is
            -- available here <TO BE IMPLEMENTED>
            if    (current_eventid_i  = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) then
              allow_read_fifo_at_next_cycle_i <= '1';
              output_port1_data_buf_i <= data_valid&din_i;
              output_port2_data_buf_i <= idle_word;
              link_ready              <= PORT1_DOUT_RDY;
              current_state           <= WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT1_AND_CHECK_TRAILER;
              
            else
            --elsif ( (current_eventid_i+1 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) or
            --        (current_eventid_i+2 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) or
            --        (current_eventid_i+3 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) or
            --        (current_eventid_i+4 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) or
            --        (current_eventid_i+5 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) or
            --        (current_eventid_i+6 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) or
            --        (current_eventid_i+7 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) or
            --        (current_eventid_i+8 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)) or
            --        (current_eventid_i+9 = din_i(DFIF_EVID_LAST downto DFIF_EVID_FIRST)))
            --then -- keep up to 9 more event (80us) -- should be enough
              allow_read_fifo_at_next_cycle_i <= '1';
              output_port1_data_buf_i <= idle_word;
              output_port2_data_buf_i <= data_valid&din_i;              
              link_ready              <= PORT2_DOUT_RDY;
              current_state           <= WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT2_AND_CHECK_TRAILER;
            --else
            --  allow_read_fifo_at_next_cycle_i <= '1';
            --  number_of_discarded_modules_i   <= number_of_discarded_modules_i+1;
            --  output_port1_data_buf_i <= idle_word;
            --  output_port2_data_buf_i <= idle_word;
            --  link_ready              <= '1';
            --  current_state           <= WAIT_SAMPLE_DATA_AND_DISCARD_DATA_AND_CHECK_TRAILER;
            end if;
          else
            allow_read_fifo_at_next_cycle_i <= '1';
            output_port1_data_buf_i <= idle_word;
            output_port2_data_buf_i <= idle_word;
            link_ready              <= PORT2_DOUT_RDY and PORT1_DOUT_RDY;
            current_state           <= WAIT_SAMPLE_INTERNAL_HEADER_AND_DECIDE;
          end if;
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT1_AND_CHECK_TRAILER =>
          if (input_go_next_if_exist_i='1' and den_i='1') then
            if (din_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) = DFIF_FRAGMENTID_TRAILER) then
              allow_read_fifo_at_next_cycle_i <= '1';              
              output_port1_data_buf_i <= data_valid&din_i;
              output_port2_data_buf_i <= idle_word;
              link_ready              <= PORT2_DOUT_RDY and PORT1_DOUT_RDY;
              current_state           <= WAIT_SAMPLE_INTERNAL_HEADER_AND_DECIDE;
            else
              allow_read_fifo_at_next_cycle_i <= '1';              
              output_port1_data_buf_i <= data_valid&din_i;
              output_port2_data_buf_i <= idle_word;
              link_ready              <= PORT1_DOUT_RDY;
              current_state           <= WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT1_AND_CHECK_TRAILER;
            end if;
          else 
            allow_read_fifo_at_next_cycle_i <= '1';
            output_port1_data_buf_i <= idle_word;
            output_port2_data_buf_i <= idle_word;
            link_ready              <= PORT1_DOUT_RDY;
            current_state           <= WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT1_AND_CHECK_TRAILER;
          end if;
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT2_AND_CHECK_TRAILER =>
          if (input_go_next_if_exist_i='1' and den_i='1') then
            if (din_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) = DFIF_FRAGMENTID_TRAILER) then
              allow_read_fifo_at_next_cycle_i <= '1';
              output_port1_data_buf_i <= idle_word;
              output_port2_data_buf_i <= data_valid&din_i;
              link_ready              <= PORT1_DOUT_RDY and PORT2_DOUT_RDY;
              current_state           <= WAIT_SAMPLE_INTERNAL_HEADER_AND_DECIDE;
            else
              allow_read_fifo_at_next_cycle_i <= '1';
              output_port1_data_buf_i <= idle_word;
              output_port2_data_buf_i <= data_valid&din_i;
              link_ready              <= PORT2_DOUT_RDY;
              current_state           <= WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT2_AND_CHECK_TRAILER;
            end if;
          else 
            allow_read_fifo_at_next_cycle_i <= '1';
            output_port1_data_buf_i <= idle_word;
            output_port2_data_buf_i <= idle_word;
            link_ready              <= PORT2_DOUT_RDY;
            current_state           <= WAIT_SAMPLE_DATA_AND_SEND_DATA_TO_PORT2_AND_CHECK_TRAILER;
          end if;
          
        when WAIT_SAMPLE_DATA_AND_DISCARD_DATA_AND_CHECK_TRAILER =>
          if (input_go_next_if_exist_i='1' and den_i='1') then
            if (din_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) = DFIF_FRAGMENTID_TRAILER) then
              allow_read_fifo_at_next_cycle_i <= '1';
              output_port1_data_buf_i <= idle_word;
              output_port2_data_buf_i <= idle_word;
              link_ready              <= '1';
              current_state           <= WAIT_SAMPLE_INTERNAL_HEADER_AND_DECIDE;
            else
              allow_read_fifo_at_next_cycle_i <= '1';
              output_port1_data_buf_i <= idle_word;
              output_port2_data_buf_i <= idle_word;
              link_ready              <= '1';
              current_state           <= WAIT_SAMPLE_DATA_AND_DISCARD_DATA_AND_CHECK_TRAILER;
            end if;
          else 
            allow_read_fifo_at_next_cycle_i <= '1';
            output_port1_data_buf_i <= idle_word;
            output_port2_data_buf_i <= idle_word;
            link_ready              <= '1';
            current_state           <= WAIT_SAMPLE_DATA_AND_DISCARD_DATA_AND_CHECK_TRAILER;
          end if;
      end case;
    end if;
  end process;
  
end logic;
