--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity df_output_duplicator is
  port
    ( MAIN_CLK : in  std_logic;
      RESET_IN : in  std_logic;
      
      -- <input>
      DATA_IN   : in  std_logic_vector(31 downto 0);
      DEN_IN    : in  std_logic;
      READY_OUT : out std_logic;
      
      -- <output>
      PORT0_DATA_OUT : out std_logic_vector(31 downto 0);
      PORT0_WEN_OUT  : out std_logic;
      PORT0_XOFF_IN  : in  std_logic;
      
      PORT1_DATA_OUT : out std_logic_vector(31 downto 0);
      PORT1_WEN_OUT  : out std_logic;
      PORT1_XOFF_IN  : in  std_logic;      
      
      -- configuration / monitoring port
      PIXMOD2DUPLICATION_ADDR_CONFIN  : in  std_logic_vector(10 downto 0);
      PIXMOD2DUPLICATION_DATA_CONFIN  : in  std_logic_vector(1 downto 0);
      PIXMOD2DUPLICATION_WEN_CONFIN   : in  std_logic;
      PIXMOD2DUPLICATION_DATA_CONFOUT : out std_logic_vector(1 downto 0);
      
      SCTMOD2DUPLICATION_ADDR_CONFIN  : in  std_logic_vector(12 downto 0);
      SCTMOD2DUPLICATION_DATA_CONFIN  : in  std_logic_vector(1 downto 0);
      SCTMOD2DUPLICATION_WEN_CONFIN   : in  std_logic;
      SCTMOD2DUPLICATION_DATA_CONFOUT : out std_logic_vector(1 downto 0);            
      
      STATE_MACHINE_ERROR_MONITOR : out std_logic_vector(31 downto 0)
      );
end df_output_duplicator;

architecture logic of df_output_duplicator is

  component output_pixmod2duplication_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 10 downto 0 );
      dina : in std_logic_vector ( 1 downto 0 );
      douta : out std_logic_vector ( 1 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 10 downto 0 );
      dinb : in std_logic_vector ( 1 downto 0 );
      doutb : out std_logic_vector ( 1 downto 0 )
      );
  end component;

  component output_sctmod2duplication_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 12 downto 0 );
      dina : in std_logic_vector ( 1 downto 0 );
      douta : out std_logic_vector ( 1 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 12 downto 0 );
      dinb : in std_logic_vector ( 1 downto 0 );
      doutb : out std_logic_vector ( 1 downto 0 )
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
  
  --component short_fwft_fifo
  --  port (
  --    clk : in std_logic;
  --    rst : in std_logic;
  --    din : in std_logic_vector ( 35 downto 0 );
  --    wr_en : in std_logic;
  --    rd_en : in std_logic;
  --    dout : out std_logic_vector ( 35 downto 0 );
  --    empty : out std_logic;
  --    prog_full : out std_logic
  --    );
  --end component;  
  
  type state_machine is (WAIT_SAMPLE_INTERNAL_HEADER,
                         WAIT_SAMPLE_DESTINATION_BIT,
                         WAIT_SAMPLE_MODULE_ID_AND_SET_TO_LUT,
                         WAIT_LUT_READY1,
                         WAIT_LUT_READY2,
                         WAIT_SEND_INTERNAL_HEADER,
                         WAIT_SEND_DESTINATION_WORD,
                         WAIT_SEND_MODULE_ID,
                         WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER);
  
  signal current_state_i : state_machine := WAIT_SAMPLE_INTERNAL_HEADER;
  signal allow_read_fifo_at_next_cycle : std_logic; -- according to the "NEXT state"
  signal output_ready_i      : std_logic;
  signal output_direction_i  : std_logic_vector(1 downto 0) := (others => '0');
  signal next_output_data : std_logic_vector(32 downto 0); -- according to the "CURRENT state"
  constant output_idle : std_logic_vector(32 downto 0) := (others => '0');
  signal internal_module_header_i : std_logic_vector(31 downto 0);
  signal destination_word_i : std_logic_vector(31 downto 0);
  signal module_header_i : std_logic_vector(31 downto 0);
  signal input_go_next_if_exist_i : std_logic;
  signal pix_lut_addr_i : std_logic_vector(10 downto 0);
  signal sct_lut_addr_i : std_logic_vector(12 downto 0);
  signal pixmod2duplication_lut_data_i : std_logic_vector(1 downto 0);
  signal sctmod2duplication_lut_data_i : std_logic_vector(1 downto 0);
  signal pixmod2duplication_wen_confin_buf : std_logic_vector(0 downto 0);
  signal sctmod2duplication_wen_confin_buf : std_logic_vector(0 downto 0);    
  signal state_machine_error_out_buf : std_logic_vector(31 downto 0) := (others => '0');

  signal input_den_in_i     : std_logic;
  signal input_data_in_i    : std_logic_vector(31 downto 0);
  signal input_fifo_empty_i : std_logic;
  signal input_fifo_full_i  : std_logic;
  signal data_in_i   : std_logic_vector(31 downto 0);
  signal den_in_i    : std_logic;
  signal float4bit_i : std_logic_vector(3 downto 0);
  
begin
  
  --process (MAIN_CLK) is
  --begin
  --  if (MAIN_CLK'event and MAIN_CLK='1') then
  --    -- channel 0
  --    if output_direction_i(0)='1' then
  --      PORT0_WEN_OUT  <= next_output_data(32);
  --      PORT0_DATA_OUT <= next_output_data(31 downto 0);
  --    else
  --      PORT0_WEN_OUT  <= output_idle(32);
  --      PORT0_DATA_OUT <= output_idle(31 downto 0);
  --    end if;
      
  --    -- channel 1
  --    if output_direction_i(1)='1' then
  --      PORT1_WEN_OUT  <= next_output_data(32);
  --      PORT1_DATA_OUT <= next_output_data(31 downto 0);
  --    else
  --      PORT1_WEN_OUT  <= output_idle(32);
  --      PORT1_DATA_OUT <= output_idle(31 downto 0);
  --    end if;
  --  end if;       
  --end process;
  
  PORT0_WEN_OUT  <= next_output_data(32)          when output_direction_i(0)='1' else output_idle(32);
  PORT0_DATA_OUT <= next_output_data(31 downto 0) when output_direction_i(0)='1' else output_idle(31 downto 0);
  PORT1_WEN_OUT  <= next_output_data(32)          when output_direction_i(1)='1' else output_idle(32);
  PORT1_DATA_OUT <= next_output_data(31 downto 0) when output_direction_i(1)='1' else output_idle(31 downto 0);
  
  STATE_MACHINE_ERROR_MONITOR <= state_machine_error_out_buf;-- not really implmented yet
  output_ready_i <= (not PORT0_XOFF_IN) and (not PORT1_XOFF_IN);

  process (MAIN_CLK) is
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      input_den_in_i  <= DEN_IN;
      input_data_in_i <= DATA_IN;
      if (input_fifo_full_i='1' and input_fifo_empty_i='0') then
        READY_OUT <= '0';
      else
        READY_OUT <= '1';
      end if;
    end if;
  end process;
  
  INPUT_BUFFER: fwft_cc_w36_d512_my_wrapper 
  --INPUT_BUFFER: short_fwft_fifo
    port map (
      clk => MAIN_CLK,
      rst => RESET_IN,
      din(31 downto  0) => input_data_in_i,
      din(35 downto 32) => (others => '0'),
      wr_en => input_den_in_i,
      rd_en => input_go_next_if_exist_i,
      dout(31 downto  0) => data_in_i,
      dout(35 downto 32) => float4bit_i,
      empty => input_fifo_empty_i,
      prog_full => input_fifo_full_i
      );
  
  input_go_next_if_exist_i <= output_ready_i and allow_read_fifo_at_next_cycle;
  den_in_i <= (not input_fifo_empty_i);  
  
  -- =================================================================================
  process (MAIN_CLK, RESET_IN)
  begin
    if    (RESET_IN='1')  then
      current_state_i <= WAIT_SAMPLE_INTERNAL_HEADER;
      state_machine_error_out_buf <= (others => '0');
      allow_read_fifo_at_next_cycle <= '0';
      next_output_data <= (others => '0');
      output_direction_i(0) <= '0';
      output_direction_i(1) <= '0';
      
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      case current_state_i is
        
        when WAIT_SAMPLE_INTERNAL_HEADER =>
          
          -- ===================================================
          if ( ((data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_HEADER) or
                (data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_HEADER_FAKE)) and
               (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i               <= WAIT_SAMPLE_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            internal_module_header_i      <= data_in_i;
            next_output_data              <= output_idle;
          else
            current_state_i               <= WAIT_SAMPLE_INTERNAL_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data              <= output_idle;
          end if;
          
        when WAIT_SAMPLE_DESTINATION_BIT =>
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i               <= WAIT_SAMPLE_MODULE_ID_AND_SET_TO_LUT;
            allow_read_fifo_at_next_cycle <= '1';
            destination_word_i            <= data_in_i;
            next_output_data              <= output_idle;
          else
            current_state_i <= WAIT_SAMPLE_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SAMPLE_MODULE_ID_AND_SET_TO_LUT => 
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i <= WAIT_LUT_READY1;
            allow_read_fifo_at_next_cycle <= '0';
            module_header_i  <= data_in_i;
            next_output_data <= output_idle;
            if (data_in_i(IMDF_MODULE_HEADER_IS_SCT_POS)='0') then
              -- PIXEL
              pix_lut_addr_i(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START)
                <= data_in_i(IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST downto IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START);
            else
              -- SCT
              sct_lut_addr_i(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START)
                <= data_in_i(IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST downto IMDF_MODULE_HEADER_SCT_MODULE_ID_START);
            end if;
          else
            current_state_i <= WAIT_SAMPLE_MODULE_ID_AND_SET_TO_LUT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_LUT_READY1 =>
          -- ===================================================
          current_state_i <= WAIT_LUT_READY2;
          allow_read_fifo_at_next_cycle <= '0';
          next_output_data <= output_idle;
          
        when WAIT_LUT_READY2 =>
          -- ===================================================
          current_state_i <= WAIT_SEND_INTERNAL_HEADER;
          allow_read_fifo_at_next_cycle <= '0';
          next_output_data <= output_idle;
          
          --if (output_ready_i='1') then
          --  current_state_i <= WAIT_SEND_INTERNAL_HEADER;
          --  allow_read_fifo_at_next_cycle <= '0';
          --  next_output_data <= output_idle;
          --else
          --  current_state_i <= WAIT_LUT_READY2;
          --  allow_read_fifo_at_next_cycle <= '0';
          --  next_output_data <= output_idle;
          --end if;
          
        when WAIT_SEND_INTERNAL_HEADER =>
          -- ===================================================
          if (output_ready_i='1') then
            current_state_i <= WAIT_SEND_DESTINATION_WORD;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= '1'&internal_module_header_i;
            if (module_header_i(IMDF_MODULE_HEADER_IS_SCT_POS)='1') then
              output_direction_i(0) <= sctmod2duplication_lut_data_i(0);
              output_direction_i(1) <= sctmod2duplication_lut_data_i(1);
            else 
              output_direction_i(0) <= pixmod2duplication_lut_data_i(0);
              output_direction_i(1) <= pixmod2duplication_lut_data_i(1);
            end if;
          else
            current_state_i <= WAIT_SEND_INTERNAL_HEADER;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SEND_DESTINATION_WORD =>
          -- ===================================================
          if (output_ready_i='1') then
            current_state_i <= WAIT_SEND_MODULE_ID;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= '1'&destination_word_i;
          else
            current_state_i <= WAIT_SEND_DESTINATION_WORD;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SEND_MODULE_ID =>
          -- ===================================================
          if (output_ready_i='1') then
            current_state_i <= WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= '1'&module_header_i;
          else -- invalid input
            current_state_i <= WAIT_SEND_MODULE_ID;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER =>
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            
            if ( (data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_TRAILER) ) then
              current_state_i <= WAIT_SAMPLE_INTERNAL_HEADER;
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
  
  pixmod2duplication_wen_confin_buf(0) <= PIXMOD2DUPLICATION_WEN_CONFIN;  
  PIXMOD2DUPLICATION_LUT : output_pixmod2duplication_my_wrapper
    port map (
      clka  => MAIN_CLK,
      wea   => pixmod2duplication_wen_confin_buf,
      addra => PIXMOD2DUPLICATION_ADDR_CONFIN,
      dina  => PIXMOD2DUPLICATION_DATA_CONFIN,
      douta => PIXMOD2DUPLICATION_DATA_CONFOUT,
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => pix_lut_addr_i,
      dinb  => (others => '0'),
      doutb => pixmod2duplication_lut_data_i
      );

  sctmod2duplication_wen_confin_buf(0) <= SCTMOD2DUPLICATION_WEN_CONFIN;  
  SCTMOD2DUPLICATION_LUT : output_sctmod2duplication_my_wrapper
    port map (
      clka  => MAIN_CLK,
      wea   => sctmod2duplication_wen_confin_buf,
      addra => SCTMOD2DUPLICATION_ADDR_CONFIN,
      dina  => SCTMOD2DUPLICATION_DATA_CONFIN,
      douta => SCTMOD2DUPLICATION_DATA_CONFOUT,
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => sct_lut_addr_i,
      dinb  => (others => '0'),
      doutb => sctmod2duplication_lut_data_i
      );
  
end logic;
