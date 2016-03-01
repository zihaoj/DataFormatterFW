-- NOTE : difference from df_output_parameter.vhd is 
-- assignment of the destination bit word. (this is the final version)
-- [ 0: 7] for AUX, [15] for SSB
-- [16:23] for AUX, [31] for SSB

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity df_output_preparation is
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
end df_output_preparation;

architecture logic of df_output_preparation is
  
  component output_pixmod2ftkplane_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 10 downto 0 );
      dina : in std_logic_vector ( 11 downto 0 );
      douta : out std_logic_vector ( 11 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 10 downto 0 );
      dinb : in std_logic_vector ( 11 downto 0 );
      doutb : out std_logic_vector ( 11 downto 0 )
      );
  end component;
  
  component output_pixmod2tower_my_wrapper
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
  
  component output_sctmod2ftkplane_my_wrapper
    port (
      clka : in std_logic;
      wea : in std_logic_vector ( 0 to 0 );
      addra : in std_logic_vector ( 12 downto 0 );
      dina : in std_logic_vector ( 11 downto 0 );
      douta : out std_logic_vector ( 11 downto 0 );
      clkb : in std_logic;
      web : in std_logic_vector ( 0 to 0 );
      addrb : in std_logic_vector ( 12 downto 0 );
      dinb : in std_logic_vector ( 11 downto 0 );
      doutb : out std_logic_vector ( 11 downto 0 )
      );
  end component;
  
  component output_sctmod2tower_my_wrapper
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
  
  type state_machine is (WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER,
                         WAIT_SAMPLE_GLOBAL_DESTINATION_BIT,
                         WAIT_SAMPLE_MODULE_ID_AND_SET_TO_LUT,
                         WAIT_LUT_READY1,
                         WAIT_LUT_READY2,
                         WAIT_SEND_LOCAL_DESTINATION_BIT,
                         WAIT_SEND_MODULE_ID,
                         WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER);
  
  signal current_state_i : state_machine := WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
  signal allow_read_fifo_at_next_cycle : std_logic; -- according to the "NEXT state"
  signal output_ready  : std_logic;
  signal next_output_data : std_logic_vector(32 downto 0); -- according to the "CURRENT state"
  constant output_idle : std_logic_vector(32 downto 0) := (others => '0');
  signal module_header_i : std_logic_vector(31 downto 0);
  signal input_go_next_if_exist_i : std_logic;
  signal pix_lut_addr_i : std_logic_vector(10 downto 0);
  signal sct_lut_addr_i : std_logic_vector(12 downto 0);
  signal pixmod2ftkplane_lut_data_i : std_logic_vector(11 downto 0);
  signal sctmod2ftkplane_lut_data_i : std_logic_vector(11 downto 0);
  signal pixmod2tower_lut_data_i : std_logic_vector(1 downto 0);
  signal sctmod2tower_lut_data_i : std_logic_vector(1 downto 0);
  signal state_machine_error_out_buf : std_logic_vector(31 downto 0) := (others => '0');

  signal pixmod2ftkplane_wen_confin_buf : std_logic_vector(0 downto 0);
  signal pixmod2tower_wen_confin_buf : std_logic_vector(0 downto 0);
  signal sctmod2ftkplane_wen_confin_buf : std_logic_vector(0 downto 0);
  signal sctmod2tower_wen_confin_buf : std_logic_vector(0 downto 0);  

  constant ERROR_BITPOS_WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER : integer := 0;
  constant ERROR_BITSOS_WAIT_WAIT_SAMPLE_GLOBAL_DESTINATION_BIT     : integer := 1;
  constant ERROR_BITPOS_WAIT_SAMPLE_MODULE_ID_AND_SET_TO_LUT        : integer := 2;
  constant ERROR_BITPOS_WAIT_LUT_READY1                             : integer := 3;
  constant ERROR_BITPOS_WAIT_LUT_READY2                             : integer := 4;
  constant ERROR_BITPOS_WAIT_SEND_LOCAL_DESTINATION_BIT             : integer := 5;
  constant ERROR_BITPOS_WAIT_SEND_MODULE_ID                         : integer := 6;
  constant ERROR_BITPOS_WAIT_SAMPLE_DATA_AND_SEND_DATA_AND_CHECK_INTERNAL_TRAILER : integer := 7;

  signal input_fifo_empty_i : std_logic;
  signal input_fifo_full_i  : std_logic;
  signal data_in_i   : std_logic_vector(31 downto 0);
  signal den_in_i    : std_logic;
  signal float4bit_i : std_logic_vector(3 downto 0);

  signal input_data_in_i   : std_logic_vector(31 downto 0);
  signal input_den_in_i    : std_logic;  
  
begin
    
  WEN_OUT  <= next_output_data(32);
  DATA_OUT <= next_output_data(31 downto 0);
  STATE_MACHINE_ERROR_MONITOR <= state_machine_error_out_buf;-- not really implmented yet
  output_ready <= (not XOFF_IN);
  
  process (MAIN_CLK) is
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      input_data_in_i <= DATA_IN;
      input_den_in_i  <= DEN_IN;
      if (input_fifo_full_i='1' and input_fifo_empty_i='0') then
        READY_OUT <= '0';
      else 
        READY_OUT <= '1';
      end if;
    end if;
  end process;
  
  INPUT_BUFFER: fwft_cc_w36_d512_my_wrapper
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
  
  input_go_next_if_exist_i <= output_ready and allow_read_fifo_at_next_cycle;
  den_in_i <= (not input_fifo_empty_i);
  
  process (MAIN_CLK, RESET_IN)
  begin
    if    (RESET_IN='1')  then
      current_state_i <= WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
      state_machine_error_out_buf <= (others => '0');
      allow_read_fifo_at_next_cycle <= '0';
      next_output_data <= (others => '0');
      
    elsif (MAIN_CLK'event and MAIN_CLK='1') then
      case current_state_i is
        
        when WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER =>          
          
          -- ===================================================
          if ( ((data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_HEADER) or
                (data_in_i(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START)=DFIF_FRAGMENTID_HEADER_FAKE)) and
               (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i <= WAIT_SAMPLE_GLOBAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= den_in_i&data_in_i;
          else
            current_state_i <= WAIT_SAMPLE_INTERNAL_HEADER_AND_SEND_HEADER;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SAMPLE_GLOBAL_DESTINATION_BIT =>
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then
            current_state_i <= WAIT_SAMPLE_MODULE_ID_AND_SET_TO_LUT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          else
            current_state_i <= WAIT_SAMPLE_GLOBAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '1';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SAMPLE_MODULE_ID_AND_SET_TO_LUT => 
          -- ===================================================
          if ( (den_in_i='1') and
               (input_go_next_if_exist_i='1') ) then          
            current_state_i <= WAIT_LUT_READY1;
            allow_read_fifo_at_next_cycle <= '0';
            module_header_i <= data_in_i;
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
          if (output_ready='1') then
            current_state_i <= WAIT_SEND_LOCAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= output_idle;
          else
            current_state_i <= WAIT_LUT_READY2;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SEND_LOCAL_DESTINATION_BIT =>
          -- ===================================================
          --
          -- <original>
          --if (output_ready='1') then
          --  current_state_i <= WAIT_SEND_MODULE_ID;
          --  allow_read_fifo_at_next_cycle <= '0';
          --  next_output_data(32) <= '1'; -- valid data
          --  next_output_data(14 downto  8) <= (others => '0');
          --  next_output_data(30 downto 24) <= (others => '0');
            
          --  if (module_header_i(IMDF_MODULE_HEADER_IS_SCT_POS)='1') then
          --    if (sctmod2tower_lut_data_i(0) = '1') then
          --      next_output_data(7  downto 0) <= sctmod2ftkplane_lut_data_i(7 downto 0);
          --      next_output_data(15)          <= or_reduce(sctmod2ftkplane_lut_data_i(11 downto 8));
          --    else
          --      next_output_data(7  downto 0) <= (others => '0');
          --      next_output_data(15)          <= '0';
          --    end if;
              
          --    if (sctmod2tower_lut_data_i(1) = '1') then
          --      next_output_data(23 downto 16) <= sctmod2ftkplane_lut_data_i(7 downto 0);
          --      next_output_data(31)           <= or_reduce(sctmod2ftkplane_lut_data_i(11 downto 8));
          --    else
          --      next_output_data(23 downto 16) <= (others => '0');
          --      next_output_data(31)           <= '0';
          --    end if;
          --  else 
          --    if (pixmod2tower_lut_data_i(0) = '1') then
          --      next_output_data(7  downto 0) <= pixmod2ftkplane_lut_data_i(7 downto 0);
          --      next_output_data(15)          <= or_reduce(pixmod2ftkplane_lut_data_i(11 downto 8));
          --    else
          --      next_output_data(7  downto 0) <= (others => '0');
          --      next_output_data(15)          <= '0';
          --    end if;
              
          --    if (pixmod2tower_lut_data_i(1) = '1') then
          --      next_output_data(23 downto 16) <= pixmod2ftkplane_lut_data_i(7 downto 0);
          --      next_output_data(31)           <= or_reduce(pixmod2ftkplane_lut_data_i(11 downto 8));
          --    else
          --      next_output_data(23 downto 16) <= (others => '0');
          --      next_output_data(31)           <= '0';
          --    end if;
          --  end if;

          -- ===================================================
          --
          -- <optimized version>
          if (output_ready='1') then
            current_state_i <= WAIT_SEND_MODULE_ID;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data(32) <= '1'; -- valid data
            -- non used bit (see data_formatter_constants)
            next_output_data(1)  <= '0';
            next_output_data(3)  <= '0';
            next_output_data(5)  <= '0';
            next_output_data(7)  <= '0';
            next_output_data(9)  <= '0';
            next_output_data(11) <= '0';
            next_output_data(14) <= '0';
            next_output_data(17) <= '0';
            next_output_data(19) <= '0';
            next_output_data(21) <= '0';
            next_output_data(23) <= '0';
            next_output_data(25) <= '0';
            next_output_data(27) <= '0';
            next_output_data(30) <= '0';
            
            
            if (module_header_i(IMDF_MODULE_HEADER_IS_SCT_POS)='1') then
              if (sctmod2tower_lut_data_i(0) = '1') then
                next_output_data(0)  <= sctmod2ftkplane_lut_data_i(0);
                next_output_data(4)  <= sctmod2ftkplane_lut_data_i(1);
                next_output_data(8)  <= sctmod2ftkplane_lut_data_i(2);
                next_output_data(2)  <= sctmod2ftkplane_lut_data_i(3);
                next_output_data(6)  <= sctmod2ftkplane_lut_data_i(4);
                next_output_data(10) <= sctmod2ftkplane_lut_data_i(5);
                next_output_data(12) <= sctmod2ftkplane_lut_data_i(6);
                next_output_data(13) <= sctmod2ftkplane_lut_data_i(7);
                next_output_data(15) <= or_reduce(sctmod2ftkplane_lut_data_i(11 downto 8));
              else
                next_output_data(0)  <= '0';
                next_output_data(4)  <= '0';
                next_output_data(8)  <= '0';
                next_output_data(2)  <= '0';
                next_output_data(6)  <= '0';
                next_output_data(10) <= '0';
                next_output_data(12) <= '0';
                next_output_data(13) <= '0';
                next_output_data(15) <= '0';
              end if;
              
              if (sctmod2tower_lut_data_i(1) = '1') then
                next_output_data(16) <= sctmod2ftkplane_lut_data_i(0);
                next_output_data(20) <= sctmod2ftkplane_lut_data_i(1);
                next_output_data(24) <= sctmod2ftkplane_lut_data_i(2);
                next_output_data(18) <= sctmod2ftkplane_lut_data_i(3);
                next_output_data(22) <= sctmod2ftkplane_lut_data_i(4);
                next_output_data(26) <= sctmod2ftkplane_lut_data_i(5);
                next_output_data(28) <= sctmod2ftkplane_lut_data_i(6);
                next_output_data(29) <= sctmod2ftkplane_lut_data_i(7);
                next_output_data(31) <= or_reduce(sctmod2ftkplane_lut_data_i(11 downto 8));
              else
                next_output_data(16) <= '0';
                next_output_data(20) <= '0';
                next_output_data(24) <= '0';
                next_output_data(18) <= '0';
                next_output_data(22) <= '0';
                next_output_data(26) <= '0';
                next_output_data(28) <= '0';
                next_output_data(29) <= '0';
                next_output_data(31) <= '0';
              end if;
            else 
              if (pixmod2tower_lut_data_i(0) = '1') then
                next_output_data(0)  <= pixmod2ftkplane_lut_data_i(0);
                next_output_data(4)  <= pixmod2ftkplane_lut_data_i(1);
                next_output_data(8)  <= pixmod2ftkplane_lut_data_i(2);
                next_output_data(2)  <= pixmod2ftkplane_lut_data_i(3);
                next_output_data(6)  <= pixmod2ftkplane_lut_data_i(4);
                next_output_data(10) <= pixmod2ftkplane_lut_data_i(5);
                next_output_data(12) <= pixmod2ftkplane_lut_data_i(6);
                next_output_data(13) <= pixmod2ftkplane_lut_data_i(7);
                next_output_data(15) <= or_reduce(pixmod2ftkplane_lut_data_i(11 downto 8));                
              else
                next_output_data(0)  <= '0';
                next_output_data(4)  <= '0';
                next_output_data(8)  <= '0';
                next_output_data(2)  <= '0';
                next_output_data(6)  <= '0';
                next_output_data(10) <= '0';
                next_output_data(12) <= '0';
                next_output_data(13) <= '0';
                next_output_data(15) <= '0';                
              end if;
              
              if (pixmod2tower_lut_data_i(1) = '1') then
                next_output_data(16) <= pixmod2ftkplane_lut_data_i(0);
                next_output_data(20) <= pixmod2ftkplane_lut_data_i(1);
                next_output_data(24) <= pixmod2ftkplane_lut_data_i(2);
                next_output_data(18) <= pixmod2ftkplane_lut_data_i(3);
                next_output_data(22) <= pixmod2ftkplane_lut_data_i(4);
                next_output_data(26) <= pixmod2ftkplane_lut_data_i(5);
                next_output_data(28) <= pixmod2ftkplane_lut_data_i(6);
                next_output_data(29) <= pixmod2ftkplane_lut_data_i(7);
                next_output_data(31) <= or_reduce(pixmod2ftkplane_lut_data_i(11 downto 8));                
              else
                next_output_data(16) <= '0';
                next_output_data(20) <= '0';
                next_output_data(24) <= '0';
                next_output_data(18) <= '0';
                next_output_data(22) <= '0';
                next_output_data(26) <= '0';
                next_output_data(28) <= '0';
                next_output_data(29) <= '0';
                next_output_data(31) <= '0';                
              end if;
            end if;          
          else
            current_state_i <= WAIT_SEND_LOCAL_DESTINATION_BIT;
            allow_read_fifo_at_next_cycle <= '0';
            next_output_data <= output_idle;
          end if;
          
        when WAIT_SEND_MODULE_ID =>
          -- ===================================================
          if (output_ready='1') then
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
  
  pixmod2ftkplane_wen_confin_buf(0) <= PIXMOD2FTKPLANE_WEN_CONFIN;
  PIXMOD2FTKPLANE_LUT : output_pixmod2ftkplane_my_wrapper
    port map (
      clka  => MAIN_CLK,
      wea   => pixmod2ftkplane_wen_confin_buf,
      addra => PIXMOD2FTKPLANE_ADDR_CONFIN,
      dina  => PIXMOD2FTKPLANE_DATA_CONFIN,
      douta => PIXMOD2FTKPLANE_DATA_CONFOUT,
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => pix_lut_addr_i,
      dinb  => (others => '0'),
      doutb => pixmod2ftkplane_lut_data_i
      );
  
  pixmod2tower_wen_confin_buf(0) <= PIXMOD2TOWER_WEN_CONFIN;  
  PIXMOD2TOWER_LUT : output_pixmod2tower_my_wrapper
    port map (
      clka  => MAIN_CLK,
      wea   => pixmod2tower_wen_confin_buf,
      addra => PIXMOD2TOWER_ADDR_CONFIN,
      dina  => PIXMOD2TOWER_DATA_CONFIN,
      douta => PIXMOD2TOWER_DATA_CONFOUT,
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => pix_lut_addr_i,
      dinb  => (others => '0'),
      doutb => pixmod2tower_lut_data_i
      );

  sctmod2ftkplane_wen_confin_buf(0) <= SCTMOD2FTKPLANE_WEN_CONFIN;
  SCTMOD2FTKPLANE_LUT : output_sctmod2ftkplane_my_wrapper
    port map (
      clka  => MAIN_CLK,
      wea   => sctmod2ftkplane_wen_confin_buf,
      addra => SCTMOD2FTKPLANE_ADDR_CONFIN,
      dina  => SCTMOD2FTKPLANE_DATA_CONFIN,
      douta => SCTMOD2FTKPLANE_DATA_CONFOUT,
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => sct_lut_addr_i,
      dinb  => (others => '0'),
      doutb => sctmod2ftkplane_lut_data_i
      );
  
  sctmod2tower_wen_confin_buf(0) <= SCTMOD2TOWER_WEN_CONFIN;  
  SCTMOD2TOWER_LUT : output_sctmod2tower_my_wrapper
    port map (
      clka  => MAIN_CLK,
      wea   => sctmod2tower_wen_confin_buf,
      addra => SCTMOD2TOWER_ADDR_CONFIN,
      dina  => SCTMOD2TOWER_DATA_CONFIN,
      douta => SCTMOD2TOWER_DATA_CONFOUT,
      clkb  => MAIN_CLK,
      web   => "0",
      addrb => sct_lut_addr_i,
      dinb  => (others => '0'),
      doutb => sctmod2tower_lut_data_i
      );  
  
  
end logic;
