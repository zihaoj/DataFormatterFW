------------------------------------------------------------------------------
-- PulsarII
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;

use work.data_formatter_constants.all;

entity testbench is
end testbench;

architecture logic of testbench is

  component df_output_slink_packer
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
  end component;
  
  signal main_clk_i : std_logic;
  signal reset_in_i : std_logic;
  signal moddata_din_i : std_logic_vector(31 downto 0);
  signal moddata_den_i : std_logic;
  signal moddata_rdy_i : std_logic;
  signal frame_data_in_i  : std_logic_vector(31 downto 0);
  signal frame_wen_in_i   : std_logic;
  signal frame_ctrl_in_i  : std_logic;
  signal frame_xoff_out_i : std_logic;
  signal slink_ud_i       : std_logic_vector(31 downto 0);
  signal slink_uwen_n_i   : std_logic;
  signal slink_uctrl_n_i  : std_logic;
  signal number_of_discarded_modules_i : std_logic_vector(31 downto 0);
  signal pattern_generator_enable_i    : std_logic;
  signal df_internal_event_counter     : std_logic_vector(15 downto 0);
  signal module_counter : std_logic_vector(7 downto 0);
  signal wait_counter : std_logic_vector(7 downto 0) := (others => '0');
  signal event_sorting_fifo_full_i : std_logic;
  
  type state_machine_t is (SEND_INTERNAL_HEADER_TO_FRAME,
                           SEND_HEADER0_TO_FRAME,
                           SEND_HEADER1_TO_FRAME,
                           SEND_HEADER2_TO_FRAME,
                           SEND_HEADER3_TO_FRAME,
                           SEND_HEADER4_TO_FRAME,
                           SEND_HEADER5_TO_FRAME,
                           SEND_HEADER6_TO_FRAME,
                           SEND_INTERNAL_MODULE_HEADER,
                           SEND_DESTINATION_WORD,
                           SEND_MODULE_HEADER,
                           SEND_MODULE_DATA,
                           SEND_INTERNAL_MODULE_TRAILER,
                           SEND_EODA_WORD_TO_FRAME,
                           SEND_TRAILER1_TO_FRAME,
                           SEND_TRAILER2_TO_FRAME,
                           SEND_TRAILER3_TO_FRAME,
                           SEND_TRAILER4_TO_FRAME,
                           SEND_TRAILER5_TO_FRAME,
                           WAIT_UNTIL_NEXT_EVENT);
  signal current_state : state_machine_t;
  
begin

  process
  begin
    main_clk_i<='0';
    wait for 2.5 ns;
    main_clk_i<='1';
    wait for 2.5 ns;
  end process;  
  
  my_slink_packer : df_output_slink_packer
    port map (
      MAIN_CLK => main_clk_i,
      RESET_IN => reset_in_i,
      MODDATA_DIN => moddata_din_i, 
      MODDATA_DEN => moddata_den_i, 
      MODDATA_RDY => moddata_rdy_i, 
      -- input port
      FRAME_DATA_IN  => frame_data_in_i, 
      FRAME_WEN_IN   => frame_wen_in_i,
      FRAME_CTRL_IN  => frame_ctrl_in_i,
      FRAME_XOFF_OUT => frame_xoff_out_i,
      -- output port
      SLINK_UD       => slink_ud_i,
      SLINK_UWEN_N   => slink_uwen_n_i,
      SLINK_UCTRL_N  => slink_uctrl_n_i,
      SLINK_LFF_N    => '1',
      SLINK_LDOWN_N  => '1',
      
      -- <configure / monitor>
      EVENT_SORTING_FIFO_FULL     => event_sorting_fifo_full_i, 
      NUMBER_OF_EXPECTED_MODULES  => 10,
      STATE_MACHINE_ERROR_MONITOR => open,
      NUMBER_OF_DISCARDED_MODULES => number_of_discarded_modules_i
      );

  process (main_clk_i) is
  begin
    if (main_clk_i'event and main_clk_i='1') then
      if (pattern_generator_enable_i='0') then
        moddata_din_i   <= (others => '0');
        moddata_den_i   <= '0';
        frame_data_in_i <= (others => '0');
        frame_wen_in_i  <= '0';
        frame_ctrl_in_i <= '0';
        df_internal_event_counter <= (others => '0');
        module_counter <= (others=>'0');
        wait_counter   <= (others=>'0');
      else
        
        case current_state is
          when SEND_INTERNAL_HEADER_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= DFIF_FRAGMENTID_HEADER & DFIF_HEADER_RESERVED & "00000" & df_internal_event_counter;
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '1';
              current_state   <= SEND_HEADER0_TO_FRAME;
              module_counter  <= (others=>'0');
              wait_counter    <= (others=>'0');
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_INTERNAL_HEADER_TO_FRAME;
            end if;
            
          when SEND_HEADER0_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"B0F00000";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '1';
              current_state   <= SEND_HEADER1_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER0_TO_FRAME;
            end if;
            
          when SEND_HEADER1_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"FF1234FF";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER2_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER1_TO_FRAME;
            end if;
            
          when SEND_HEADER2_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"00000000";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER3_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER2_TO_FRAME;
            end if;
            
          when SEND_HEADER3_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"0000"&df_internal_event_counter;
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER4_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER3_TO_FRAME;
            end if;
            
          when SEND_HEADER4_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"000000FF";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER5_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER4_TO_FRAME;
            end if;
            
          when SEND_HEADER5_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"000000FF";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER6_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER5_TO_FRAME;
            end if;
            
          when SEND_HEADER6_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"00000000";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_INTERNAL_MODULE_HEADER;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_HEADER6_TO_FRAME;
            end if;
            
          when SEND_INTERNAL_MODULE_HEADER =>
            if moddata_rdy_i = '1' and event_sorting_fifo_full_i = '0' then
              
              if    (df_internal_event_counter=X"0050") then
                moddata_din_i   <= DFIF_FRAGMENTID_HEADER & DFIF_HEADER_RESERVED & "00000" & X"0051";
              elsif (df_internal_event_counter=X"0051") then
                moddata_din_i   <= DFIF_FRAGMENTID_HEADER & DFIF_HEADER_RESERVED & "00000" & X"0050";
              else
                moddata_din_i   <= DFIF_FRAGMENTID_HEADER & DFIF_HEADER_RESERVED & "00000" & df_internal_event_counter;
              end if;
              
              moddata_den_i   <= '1';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_DESTINATION_WORD;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_INTERNAL_MODULE_HEADER;
            end if;
            
          when SEND_DESTINATION_WORD =>
            if moddata_rdy_i = '1' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= X"00000001";
              moddata_den_i   <= '1';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_MODULE_HEADER;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_DESTINATION_WORD;
            end if;
            
          when SEND_MODULE_HEADER =>
            if moddata_rdy_i = '1' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= X"800000"&module_counter;
              moddata_den_i   <= '1';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_MODULE_DATA;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_MODULE_HEADER;
            end if;
            
          when SEND_MODULE_DATA =>
            if moddata_rdy_i = '1' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= X"CAFECAFE";
              moddata_den_i   <= '1';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_INTERNAL_MODULE_TRAILER;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_MODULE_DATA;
            end if;            
            
          when SEND_INTERNAL_MODULE_TRAILER =>
            if moddata_rdy_i = '1' and event_sorting_fifo_full_i = '0' then
              module_counter <= module_counter + 1;
              if module_counter /= X"09" then
                moddata_din_i   <= DFIF_FRAGMENTID_TRAILER&DFIF_TRAILER_REERVED;
                moddata_den_i   <= '1';
                frame_data_in_i <= (others => '0');
                frame_wen_in_i  <= '0';
                frame_ctrl_in_i <= '0';
                current_state   <= SEND_INTERNAL_MODULE_HEADER;
              else
                moddata_din_i   <= DFIF_FRAGMENTID_TRAILER&DFIF_TRAILER_REERVED;
                moddata_den_i   <= '1';
                frame_data_in_i <= (others => '0');
                frame_wen_in_i  <= '0';
                frame_ctrl_in_i <= '0';
                current_state   <= SEND_EODA_WORD_TO_FRAME;
              end if;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_INTERNAL_MODULE_TRAILER;
            end if;
            
          when SEND_EODA_WORD_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= x"0000"&DF_OUTPUT_EODA_WORD;
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '1';
              current_state   <= SEND_TRAILER1_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_EODA_WORD_TO_FRAME;
            end if;
            
          when SEND_TRAILER1_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"00000000";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_TRAILER2_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_TRAILER1_TO_FRAME;
            end if;
            
          when SEND_TRAILER2_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"00000000";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_TRAILER3_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_TRAILER2_TO_FRAME;
            end if;
            
          when SEND_TRAILER3_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"11111111";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_TRAILER4_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_TRAILER3_TO_FRAME;
            end if;
            
          when SEND_TRAILER4_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"00000000";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_TRAILER5_TO_FRAME;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= SEND_TRAILER4_TO_FRAME;
            end if;
            
          when SEND_TRAILER5_TO_FRAME =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= X"E0F00000";
              frame_wen_in_i  <= '1';
              frame_ctrl_in_i <= '1';
              df_internal_event_counter <= df_internal_event_counter+1;
              current_state   <= WAIT_UNTIL_NEXT_EVENT;
            else
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';   
              current_state   <= SEND_TRAILER5_TO_FRAME;
            end if;
          when WAIT_UNTIL_NEXT_EVENT =>
            if frame_xoff_out_i = '0' and event_sorting_fifo_full_i = '0' and wait_counter = X"40" then
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';              
              current_state   <= SEND_INTERNAL_HEADER_TO_FRAME;
            else
              if (wait_counter /= X"40") then
                wait_counter    <= wait_counter + 1;
              end if;
              moddata_din_i   <= (others => '0');
              moddata_den_i   <= '0';
              frame_data_in_i <= (others => '0');
              frame_wen_in_i  <= '0';
              frame_ctrl_in_i <= '0';
              current_state   <= WAIT_UNTIL_NEXT_EVENT;
            end if;
        end case;
      end if;
    end if;
  end process;
  
  process
  begin
    reset_in_i <= '1';
    pattern_generator_enable_i <= '0';
    wait for 100 ns;
    reset_in_i <= '0';
    
    wait for 1 us;
    pattern_generator_enable_i <= '1';
    
    wait;
    
  end process;
  
end logic;
