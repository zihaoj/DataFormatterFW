--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

use work.data_formatter_constants.all;

entity df_switch_element_1ch_in is
  -- BUFFER TYPE = 0 (short)
  -- BUFFER TYPE = 1 (d512)
  -- BUFFER TYPE = 2 (d512 + big mergin for full)
  generic (BUFFER_TYPE : integer := 0;
           USE_RANDOM_COUNTER_IN_HEADER : boolean := false);
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
    OUTPUT_PORT1_NEW_MOD_RDY : in std_logic := '1';
    OUTPUT_PORT2_NEW_MOD_RDY : in std_logic := '1';
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
end df_switch_element_1ch_in;

architecture logic of df_switch_element_1ch_in  is

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

  component short_fwft_fifo_d32_w32 is
    port (
      clk : in STD_LOGIC;
      rst : in STD_LOGIC;
      din : in STD_LOGIC_VECTOR ( 31 downto 0 );
      wr_en : in STD_LOGIC;
      rd_en : in STD_LOGIC;
      dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
      full : out STD_LOGIC;
      empty : out STD_LOGIC;
      prog_full : out STD_LOGIC
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
  
  component fwft_cc_w36_d512_for_ilrx_my_wrapper
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
  
  signal input_port_empty_i : std_logic;
  signal input_port_full_i : std_logic;
  signal input_port_dout_i : std_logic_vector(31 downto 0);
  
  signal input_go_next_if_exist_i : std_logic;
  
  -- 
  type state_machine_t is (WAIT_SAMPLE_HEADER,
                           WAIT_SAMPLE_DESTINATION_BIT_AND_SEND_HEADER,
                           WAIT_SEND_DESTINATION_BIT,
                           WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER);
  
  signal current_state_i : state_machine_t := WAIT_SAMPLE_HEADER;
  
  signal output_lanes_i : std_logic_vector(2 downto 1);
  
  signal din_i : std_logic_vector(31 downto 0);
  signal den_i : std_logic;
  signal allow_read_fifo_at_next_cycle : std_logic;
  signal header_buffer_i : std_logic_vector(31 downto 0) := (others => '0');
  signal dest_outport1_i : std_logic_vector(31 downto 0);
  signal dest_outport2_i : std_logic_vector(31 downto 0);

  signal float_port : std_logic_vector(3 downto 0);

  type outbuf_2lanes_t is array(2 downto 1) of std_logic_vector(32 downto 0);
  signal output_buf_i : outbuf_2lanes_t := (others => (others => '0'));
  constant idle_word : std_logic_vector(32 downto 0) := '0'&X"00000000";
  signal link_ready : std_logic;
  constant data_valid : std_logic := '1';
  constant MAX_MODULE_COUNT_IN_A_ROW : integer := 15;
  signal module_count_in_a_row : integer range 0 to MAX_MODULE_COUNT_IN_A_ROW;
  
  signal random_five_bit_counter_in_header : std_logic_vector(DFIF_HEADER_RANDOM_COUNTER_LENGTH-1 downto 0) := (others => '0');
  constant reference_zero : std_logic_vector(DFIF_HEADER_RANDOM_COUNTER_LENGTH-1 downto 0) := (others=>'0');
  
begin
  
  INPUT_PORT_EMPTY_MON <= input_port_empty_i;
  INPUT_PORT_FULL_MON  <= input_port_full_i;
  OUTPUT_PORT1_RDY_MON <= OUTPUT_PORT1_RDY;
  OUTPUT_PORT2_RDY_MON <= OUTPUT_PORT2_RDY;
  OUTPUT_LANES_MON     <= output_lanes_i;
  
  -- input port1
  INPUT_PORT_RDY <= '0' when input_port_empty_i='0' and input_port_full_i='1' else '1';
  SHORT_FIFO_INST : if BUFFER_TYPE=0 generate
    INPUT_PORT : short_fwft_fifo
      port map (
        clk => CLK,
        rst => RST,
        din(31 downto  0) => INPUT_PORT_DIN,
        din(35 downto 32) => (others => '0'),
        wr_en => INPUT_PORT_DEN,
        rd_en => input_go_next_if_exist_i,
        dout(31 downto  0) => input_port_dout_i,
        dout(35 downto 32) => float_port,
        empty => input_port_empty_i,
        prog_full => input_port_full_i
        );

    --INPUT_PORT : short_fwft_fifo_d32_w32
    --  port map (
    --    clk => CLK,
    --    rst => RST,
    --    din => INPUT_PORT_DIN,
    --    wr_en => INPUT_PORT_DEN,
    --    rd_en => input_go_next_if_exist_i,
    --    dout => input_port_dout_i,
    --    empty => input_port_empty_i,
    --    prog_full => input_port_full_i
    --    );    
  end generate;
  
  NORMAL_FIFO_INST : if BUFFER_TYPE=1 generate
    INPUT_PORT : fwft_cc_w36_d512_my_wrapper
      port map (
        clk => CLK,
        rst => RST,
        din(31 downto  0) => INPUT_PORT_DIN,
        din(35 downto 32) => (others => '0'),
        wr_en => INPUT_PORT_DEN,
        rd_en => input_go_next_if_exist_i,
        dout(31 downto  0) => input_port_dout_i,
        dout(35 downto 32) => float_port,
        empty => input_port_empty_i,
        prog_full => input_port_full_i
        );
  end generate;
  
  LINK_RX_FIFO_INST : if BUFFER_TYPE=2 generate
    INPUT_PORT : fwft_cc_w36_d512_for_ilrx_my_wrapper
      port map (
        clk => CLK,
        rst => RST,
        din(31 downto  0) => INPUT_PORT_DIN,
        din(35 downto 32) => (others => '0'),
        wr_en => INPUT_PORT_DEN,
        rd_en => input_go_next_if_exist_i,
        dout(31 downto  0) => input_port_dout_i,
        dout(35 downto 32) => float_port,
        empty => input_port_empty_i,
        prog_full => input_port_full_i
        );
  end generate;  
  
  input_go_next_if_exist_i <= link_ready and allow_read_fifo_at_next_cycle;
  den_i <= not input_port_empty_i;
  din_i <= input_port_dout_i;
  
  OUTPUT_PORT1_DOUT <= output_buf_i(1)(31 downto 0);
  OUTPUT_PORT2_DOUT <= output_buf_i(2)(31 downto 0);
  OUTPUT_PORT1_DEN  <= output_buf_i(1)(32);
  OUTPUT_PORT2_DEN  <= output_buf_i(2)(32);

  --process (CLK) -- <this latch was not correct for central switch input>
  --begin
  --  if (CLK'event and CLK='1') then
  --    if (output_lanes_i="11") then
  --      link_ready <= OUTPUT_PORT1_RDY and OUTPUT_PORT2_RDY;
  --    elsif (output_lanes_i(1)='1') then
  --      link_ready <= OUTPUT_PORT1_RDY;
  --    elsif (output_lanes_i(2)='1') then
  --      link_ready <= OUTPUT_PORT2_RDY;
  --    else
  --      link_ready <= OUTPUT_PORT1_RDY and OUTPUT_PORT2_RDY;
  --    end if;
             
  --  end if;
  --end process;
  
  link_ready <= OUTPUT_PORT1_RDY and OUTPUT_PORT2_RDY when (output_lanes_i="11") else
                OUTPUT_PORT1_RDY when (output_lanes_i(1)='1') else
                OUTPUT_PORT2_RDY when (output_lanes_i(2)='1') else
                OUTPUT_PORT1_RDY and OUTPUT_PORT2_RDY;
  
  -- State Machine
  process (CLK, RST)
  begin
    if    (RST='1') then
      -- signals category (1)
      -- to be updated according to the next state
      current_state_i <= WAIT_SAMPLE_HEADER;
      allow_read_fifo_at_next_cycle <= '0';
      -- NOTE THIS VARIABLE should be updated when
      -- current_state_i updated
      
      -- others 
      output_lanes_i <= "00";
      header_buffer_i <= (others => '0');
      dest_outport1_i <= (others => '0');
      dest_outport2_i <= (others => '0');
      
      -- signals category (2)
      output_buf_i(1) <= idle_word;
      output_buf_i(2) <= idle_word;

      module_count_in_a_row <= 0;
      
    elsif (CLK'event and CLK='1') then
      case current_state_i is 
        
        when WAIT_SAMPLE_HEADER =>
          -- READ is required to go to next step
          output_buf_i(1) <= idle_word;
          output_buf_i(2) <= idle_word;
          
          if (input_go_next_if_exist_i='1' and den_i='1') then
            current_state_i <= WAIT_SAMPLE_DESTINATION_BIT_AND_SEND_HEADER;
            random_five_bit_counter_in_header <=
              din_i(DFIF_HEADER_RANDOM_COUNTER_LAST downto DFIF_HEADER_RANDOM_COUNTER_FIRST);
            allow_read_fifo_at_next_cycle <= OUTPUT_PORT1_NEW_MOD_RDY and OUTPUT_PORT2_NEW_MOD_RDY;
            header_buffer_i <= din_i;
          else
            current_state_i <= WAIT_SAMPLE_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
          end if;
          
        when WAIT_SAMPLE_DESTINATION_BIT_AND_SEND_HEADER =>
          -- READ is required to go to next step
          -- detemine the destination lanes
          
          if (input_go_next_if_exist_i='1' and den_i='1') then
            current_state_i <= WAIT_SEND_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            
            if (USE_RANDOM_COUNTER_IN_HEADER or (random_five_bit_counter_in_header=reference_zero) ) then
              -----------------------------------------------------------------
              -- USER_RANDOM COUNTER
              -- DESTINATION BIT IS SHIFTED LEFT according to randome counter
              -- ( OUTPORT MASK IS SHIFTED RIGHT according to randome counter
              --   make the output bit information (original destination bit
              --   should be kept) )
              -----------------------------------------------------------------
              -- <for output lane 1>
              case conv_integer(random_five_bit_counter_in_header) is
                when 0 =>
                  if ( or_reduce(din_i and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= din_i and OUTPORT1_MASK;
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;
                  
                when 1 => 
                  if ( or_reduce( (din_i(30 downto 0) & din_i(31 downto 31) ) and OUTPORT1_MASK) = '1' ) then                 
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 0 downto 0) & OUTPORT1_MASK(31 downto 1)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 2 =>
                  if ( or_reduce( (din_i(29 downto 0) & din_i(31 downto 30) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 1 downto 0) & OUTPORT1_MASK(31 downto 2)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 3 =>
                  if ( or_reduce( (din_i(28 downto 0) & din_i(31 downto 29) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 2 downto 0) & OUTPORT1_MASK(31 downto 3)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 4 =>
                  if ( or_reduce( (din_i(27 downto 0) & din_i(31 downto 28) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 3 downto 0) & OUTPORT1_MASK(31 downto 4)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;
                  
                when 5 =>
                  if ( or_reduce( (din_i(26 downto 0) & din_i(31 downto 27) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 4 downto 0) & OUTPORT1_MASK(31 downto 5)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 6 =>
                  if ( or_reduce( (din_i(25 downto 0) & din_i(31 downto 26) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 5 downto 0) & OUTPORT1_MASK(31 downto 6)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 7 =>
                  if ( or_reduce( (din_i(24 downto 0) & din_i(31 downto 25) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 6 downto 0) & OUTPORT1_MASK(31 downto 7)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 8 =>
                  if ( or_reduce( (din_i(23 downto 0) & din_i(31 downto 24) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 7 downto 0) & OUTPORT1_MASK(31 downto 8)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 9 =>
                  if ( or_reduce( (din_i(22 downto 0) & din_i(31 downto 23) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 8 downto 0) & OUTPORT1_MASK(31 downto 9)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 10 =>
                  if ( or_reduce( (din_i(21 downto 0) & din_i(31 downto 22) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK( 9 downto 0) & OUTPORT1_MASK(31 downto 10)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 11 =>
                  if ( or_reduce( (din_i(20 downto 0) & din_i(31 downto 21) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(10 downto 0) & OUTPORT1_MASK(31 downto 11)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 12 =>
                  if ( or_reduce( (din_i(19 downto 0) & din_i(31 downto 20) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(11 downto 0) & OUTPORT1_MASK(31 downto 12)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 13 =>
                  if ( or_reduce( (din_i(18 downto 0) & din_i(31 downto 19) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(12 downto 0) & OUTPORT1_MASK(31 downto 13)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 14 =>
                  if ( or_reduce( (din_i(17 downto 0) & din_i(31 downto 18) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(13 downto 0) & OUTPORT1_MASK(31 downto 14)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 15 =>
                  if ( or_reduce( (din_i(16 downto 0) & din_i(31 downto 17) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(14 downto 0) & OUTPORT1_MASK(31 downto 15)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 16 =>
                  if ( or_reduce( (din_i(15 downto 0) & din_i(31 downto 16) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(15 downto 0) & OUTPORT1_MASK(31 downto 16)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 17 =>
                  if ( or_reduce( (din_i(14 downto 0) & din_i(31 downto 15) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(16 downto 0) & OUTPORT1_MASK(31 downto 17)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 18 =>
                  if ( or_reduce( (din_i(13 downto 0) & din_i(31 downto 14) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(17 downto 0) & OUTPORT1_MASK(31 downto 18)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 19 =>
                  if ( or_reduce( (din_i(12 downto 0) & din_i(31 downto 13) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(18 downto 0) & OUTPORT1_MASK(31 downto 19)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 20 =>
                  if ( or_reduce( (din_i(11 downto 0) & din_i(31 downto 12) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(19 downto 0) & OUTPORT1_MASK(31 downto 20)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 21 =>
                  if ( or_reduce( (din_i(10 downto 0) & din_i(31 downto 11) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(20 downto 0) & OUTPORT1_MASK(31 downto 21)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 22 =>
                  if ( or_reduce( (din_i( 9 downto 0) & din_i(31 downto 10) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(21 downto 0) & OUTPORT1_MASK(31 downto 22)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 23 =>
                  if ( or_reduce( (din_i( 8 downto 0) & din_i(31 downto  9) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(22 downto 0) & OUTPORT1_MASK(31 downto 23)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 24 =>
                  if ( or_reduce( (din_i( 7 downto 0) & din_i(31 downto  8) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(23 downto 0) & OUTPORT1_MASK(31 downto 24)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 25 =>
                  if ( or_reduce( (din_i( 6 downto 0) & din_i(31 downto  7) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(24 downto 0) & OUTPORT1_MASK(31 downto 25)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 26 =>
                  if ( or_reduce( (din_i( 5 downto 0) & din_i(31 downto  6) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(25 downto 0) & OUTPORT1_MASK(31 downto 26)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 27 =>
                  if ( or_reduce( (din_i( 4 downto 0) & din_i(31 downto  5) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(26 downto 0) & OUTPORT1_MASK(31 downto 27)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 28 =>
                  if ( or_reduce( (din_i( 3 downto 0) & din_i(31 downto  4) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(27 downto 0) & OUTPORT1_MASK(31 downto 28)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 29 =>
                  if ( or_reduce( (din_i( 2 downto 0) & din_i(31 downto  3) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(28 downto 0) & OUTPORT1_MASK(31 downto 29)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 30 =>
                  if ( or_reduce( (din_i( 1 downto 0) & din_i(31 downto  2) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(29 downto 0) & OUTPORT1_MASK(31 downto 30)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;

                when 31 =>
                  if ( or_reduce( (din_i( 0 downto 0) & din_i(31 downto  1) ) and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= ( din_i and (OUTPORT1_MASK(30 downto 0) & OUTPORT1_MASK(31 downto 31)));
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;
                  
                when others =>  -- ERROR (does not supposed to be in  this state)
                  if ( or_reduce(din_i and OUTPORT1_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport1_i   <= din_i and OUTPORT1_MASK;
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;                  
                
              end case;                 -- end for <lane 1>

              -- <output port 2>
              case conv_integer(random_five_bit_counter_in_header) is
                when 0 =>
                  if ( or_reduce(din_i and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= din_i and OUTPORT2_MASK;
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;
                  
                when 1 => 
                  if ( or_reduce( (din_i(30 downto 0) & din_i(31 downto 31) ) and OUTPORT2_MASK) = '1' ) then                 
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 0 downto 0) & OUTPORT2_MASK(31 downto 1)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 2 =>
                  if ( or_reduce( (din_i(29 downto 0) & din_i(31 downto 30) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 1 downto 0) & OUTPORT2_MASK(31 downto 2)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 3 =>
                  if ( or_reduce( (din_i(28 downto 0) & din_i(31 downto 29) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 2 downto 0) & OUTPORT2_MASK(31 downto 3)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 4 =>
                  if ( or_reduce( (din_i(27 downto 0) & din_i(31 downto 28) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 3 downto 0) & OUTPORT2_MASK(31 downto 4)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;
                  
                when 5 =>
                  if ( or_reduce( (din_i(26 downto 0) & din_i(31 downto 27) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 4 downto 0) & OUTPORT2_MASK(31 downto 5)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 6 =>
                  if ( or_reduce( (din_i(25 downto 0) & din_i(31 downto 26) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 5 downto 0) & OUTPORT2_MASK(31 downto 6)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 7 =>
                  if ( or_reduce( (din_i(24 downto 0) & din_i(31 downto 25) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 6 downto 0) & OUTPORT2_MASK(31 downto 7)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 8 =>
                  if ( or_reduce( (din_i(23 downto 0) & din_i(31 downto 24) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 7 downto 0) & OUTPORT2_MASK(31 downto 8)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 9 =>
                  if ( or_reduce( (din_i(22 downto 0) & din_i(31 downto 23) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 8 downto 0) & OUTPORT2_MASK(31 downto 9)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 10 =>
                  if ( or_reduce( (din_i(21 downto 0) & din_i(31 downto 22) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK( 9 downto 0) & OUTPORT2_MASK(31 downto 10)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 11 =>
                  if ( or_reduce( (din_i(20 downto 0) & din_i(31 downto 21) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(10 downto 0) & OUTPORT2_MASK(31 downto 11)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 12 =>
                  if ( or_reduce( (din_i(19 downto 0) & din_i(31 downto 20) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(11 downto 0) & OUTPORT2_MASK(31 downto 12)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 13 =>
                  if ( or_reduce( (din_i(18 downto 0) & din_i(31 downto 19) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(12 downto 0) & OUTPORT2_MASK(31 downto 13)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 14 =>
                  if ( or_reduce( (din_i(17 downto 0) & din_i(31 downto 18) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(13 downto 0) & OUTPORT2_MASK(31 downto 14)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 15 =>
                  if ( or_reduce( (din_i(16 downto 0) & din_i(31 downto 17) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(14 downto 0) & OUTPORT2_MASK(31 downto 15)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 16 =>
                  if ( or_reduce( (din_i(15 downto 0) & din_i(31 downto 16) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(15 downto 0) & OUTPORT2_MASK(31 downto 16)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 17 =>
                  if ( or_reduce( (din_i(14 downto 0) & din_i(31 downto 15) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(16 downto 0) & OUTPORT2_MASK(31 downto 17)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 18 =>
                  if ( or_reduce( (din_i(13 downto 0) & din_i(31 downto 14) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(17 downto 0) & OUTPORT2_MASK(31 downto 18)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 19 =>
                  if ( or_reduce( (din_i(12 downto 0) & din_i(31 downto 13) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(18 downto 0) & OUTPORT2_MASK(31 downto 19)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 20 =>
                  if ( or_reduce( (din_i(11 downto 0) & din_i(31 downto 12) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(19 downto 0) & OUTPORT2_MASK(31 downto 20)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 21 =>
                  if ( or_reduce( (din_i(10 downto 0) & din_i(31 downto 11) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(20 downto 0) & OUTPORT2_MASK(31 downto 21)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 22 =>
                  if ( or_reduce( (din_i( 9 downto 0) & din_i(31 downto 10) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(21 downto 0) & OUTPORT2_MASK(31 downto 22)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 23 =>
                  if ( or_reduce( (din_i( 8 downto 0) & din_i(31 downto  9) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(22 downto 0) & OUTPORT2_MASK(31 downto 23)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 24 =>
                  if ( or_reduce( (din_i( 7 downto 0) & din_i(31 downto  8) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(23 downto 0) & OUTPORT2_MASK(31 downto 24)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 25 =>
                  if ( or_reduce( (din_i( 6 downto 0) & din_i(31 downto  7) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(24 downto 0) & OUTPORT2_MASK(31 downto 25)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 26 =>
                  if ( or_reduce( (din_i( 5 downto 0) & din_i(31 downto  6) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(25 downto 0) & OUTPORT2_MASK(31 downto 26)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 27 =>
                  if ( or_reduce( (din_i( 4 downto 0) & din_i(31 downto  5) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(26 downto 0) & OUTPORT2_MASK(31 downto 27)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 28 =>
                  if ( or_reduce( (din_i( 3 downto 0) & din_i(31 downto  4) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(27 downto 0) & OUTPORT2_MASK(31 downto 28)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 29 =>
                  if ( or_reduce( (din_i( 2 downto 0) & din_i(31 downto  3) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(28 downto 0) & OUTPORT2_MASK(31 downto 29)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 30 =>
                  if ( or_reduce( (din_i( 1 downto 0) & din_i(31 downto  2) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(29 downto 0) & OUTPORT2_MASK(31 downto 30)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;

                when 31 =>
                  if ( or_reduce( (din_i( 0 downto 0) & din_i(31 downto  1) ) and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(2) <= '1';
                    output_buf_i(2)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= ( din_i and (OUTPORT2_MASK(30 downto 0) & OUTPORT2_MASK(31 downto 31)));
                  else
                    output_lanes_i(2) <= '0';
                    output_buf_i(2)   <= idle_word;
                  end if;
                  
                when others =>  -- ERROR (does not supposed to be in  this state)
                  if ( or_reduce(din_i and OUTPORT2_MASK) = '1' ) then
                    output_lanes_i(1) <= '1';
                    output_buf_i(1)   <= data_valid & header_buffer_i;
                    dest_outport2_i   <= din_i and OUTPORT2_MASK;
                  else
                    output_lanes_i(1) <= '0';
                    output_buf_i(1)   <= idle_word;
                  end if;                  
              end case;                 -- end for <lane 2>
            else
              -----------------------------------------------------------------
              -- NORMAL SWITCHING
              -----------------------------------------------------------------
              -- <for output lane 1>
              if ( or_reduce( din_i and OUTPORT1_MASK ) = '1' ) then
                output_lanes_i(1) <= '1';
                output_buf_i(1) <= data_valid & header_buffer_i;
                dest_outport1_i <= din_i and OUTPORT1_MASK;
              else
                output_lanes_i(1) <= '0';
                output_buf_i(1) <= idle_word;
              end if;
              
              -- <for output lane 2>
              if ( or_reduce(din_i and OUTPORT2_MASK) = '1' ) then
                output_lanes_i(2) <= '1';
                output_buf_i(2) <= data_valid & header_buffer_i;
                dest_outport2_i <= din_i and OUTPORT2_MASK;
              else
                output_lanes_i(2) <= '0';
                output_buf_i(2) <= idle_word;
              end if;              
              
            end if;
            
            
          else
            current_state_i <= WAIT_SAMPLE_DESTINATION_BIT_AND_SEND_HEADER;
            allow_read_fifo_at_next_cycle <= OUTPUT_PORT1_NEW_MOD_RDY and OUTPUT_PORT2_NEW_MOD_RDY;
            output_buf_i(1) <= idle_word;
            output_buf_i(2) <= idle_word;
          end if;
          
        when WAIT_SEND_DESTINATION_BIT =>
          -- Send is required (link to be established) to go to next step
          -- NO READ
          
          
          if (link_ready='1') then
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            
            if (output_lanes_i(1)='1') then output_buf_i(1)<=data_valid & dest_outport1_i;
            else output_buf_i(1) <= idle_word; end if;
            
            if (output_lanes_i(2)='1') then output_buf_i(2)<=data_valid & dest_outport2_i;
            else output_buf_i(2) <= idle_word; end if;
            
          else
            current_state_i <= WAIT_SEND_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            output_buf_i(1) <= idle_word;
            output_buf_i(2) <= idle_word;            
          end if;
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER =>
          -- READ is required to go to next step
          -- if the current sampling data is Trailer word
          -- the state will be shifted
          
          
          if (input_go_next_if_exist_i='1' and den_i='1') then
            
            if (output_lanes_i(1)='1') then output_buf_i(1)<=data_valid & din_i;
            else output_buf_i(1) <= idle_word; end if;
            
            if (output_lanes_i(2)='1') then output_buf_i(2)<=data_valid & din_i;
            else output_buf_i(2) <= idle_word; end if;
            
            if (din_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_TRAILER) then
              current_state_i <= WAIT_SAMPLE_HEADER;
              allow_read_fifo_at_next_cycle <= '1';
            end if;
            
          else
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            output_buf_i(1) <= idle_word;
            output_buf_i(2) <= idle_word;
          end if;
          
      end case;
      
    end if;
  end process;
end logic;
