------------------------------------------------------------------------------
-- PulsarIIb
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.FmcConstants.all;

entity fmc_rx_parity is
  port
    ( 
      FMC_COMMON_CLK : in std_logic;
      RESET : in std_logic;
      DIN   : in std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      -- configuration
      CONFIG_CLK_INV        : out std_logic;
      CONFIG_CLKDELAY_DIR   : out std_logic;
      CONFIG_CLKDELAY_CE    : out std_logic;
      -- monitoring
      CONFIG_SYNC_DONE  : out std_logic;
      CONFIG_SYNC_ERROR : out std_logic
      );
end fmc_rx_parity;

architecture logic of fmc_rx_parity is
  signal before_sync_counter  : std_logic_vector(6 downto 0) := (others => '0');
  signal before_check_counter : std_logic_vector(6 downto 0) := (others => '0');
  
  type InitAndSync_t is (InitState,
                         SyncState,
                         SlipState,
                         WaitSyncState,
                         WaitCheckState);
  
  signal next_state        : InitAndSync_t := InitState;
  signal data_sync         : std_logic_vector(DIN'range);
  signal xor_results       : std_logic;
  signal sync_done         : std_logic;
  signal sync_error        : std_logic;
  signal number_of_slip    : std_logic_vector(6 downto 0) := (others => '0');
  
  -- ##########################################
  component fmc_rx_mapper_fpga_to_detword is
    port (
      FRONT_TO_MAPPER_DIN      : in  std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      MAPPER_TO_FRAME_SCT_DATA : out std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
      MAPPER_TO_FRAME_SCT_CTRL : out std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
      MAPPER_TO_FRAME_PIX_DATA : out std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
      MAPPER_TO_FRAME_PIX_CTRL : out std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0)
      );
  end component;
  
  signal pix_data_in : std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
  signal sct_data_in : std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
  signal pix_ctrl_in : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
  signal sct_ctrl_in : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);  
  signal find_correct_idle_words : std_logic;
  
begin
  
  --------------------------------------------
  -- CLOCK DELAY CONTROLLER
  --------------------------------------------
  CONFIG_CLK_INV      <= number_of_slip(6);
  CONFIG_CLKDELAY_DIR <= '1'; 
  process (FMC_COMMON_CLK)
  begin
    if (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      if (next_state = SlipState) then
        CONFIG_CLKDELAY_CE <= '1';
      else
        CONFIG_CLKDELAY_CE <= '0';
      end if;
    end if;
  end process;  
  
  --------------------------------------------
  -- Monitoring
  --------------------------------------------
  CONFIG_SYNC_ERROR <= sync_error;
  CONFIG_SYNC_DONE  <= sync_done;
  
  --------------------------------------------
  -- Data Checker (1)
  --------------------------------------------  
  process (FMC_COMMON_CLK)
  begin
    if (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      data_sync   <= DIN;
      xor_results <= xor_reduce(data_sync);
    end if;
  end process;

  --------------------------------------------
  -- Data Checker (2)
  --------------------------------------------    
  MAPPER : fmc_rx_mapper_fpga_to_detword
    port map (
      FRONT_TO_MAPPER_DIN      => DIN, 
      MAPPER_TO_FRAME_SCT_DATA => sct_data_in,
      MAPPER_TO_FRAME_SCT_CTRL => sct_ctrl_in,
      MAPPER_TO_FRAME_PIX_DATA => pix_data_in,
      MAPPER_TO_FRAME_PIX_CTRL => pix_ctrl_in
      );

  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET='1') then
      find_correct_idle_words <= '0';
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      if ( (sct_data_in=data_idleword) and
           (pix_data_in=data_idleword) and
           (sct_ctrl_in=ctrl_idleword) and
           (pix_ctrl_in=ctrl_idleword) ) then
        find_correct_idle_words <= '1';
      else
        find_correct_idle_words <= '0';
      end if;
    end if;
  end process;
  
  --------------------------------------------
  -- state machine
  --------------------------------------------
  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET = '1') then
      next_state <= InitState;
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      case next_state is
        
        
        when InitState => -- Initialization
          if (xor_results='0' and find_correct_idle_words='1') then
            next_state <= WaitSyncState;
          else
            next_state <= SlipState;
          end if;

          
        when SyncState => -- Syncronization Done
          next_state <= SyncState;

          
        when SlipState => -- clock delay shift once
          next_state <= WaitCheckState;
          
        when WaitSyncState => -- wait enough time before confirmation
          if (before_sync_counter(6)='0') then
            if (xor_results='0' and find_correct_idle_words='1') then
              next_state <= WaitSyncState;
            else
              next_state <= SlipState;
            end if;
          else
            next_state <= SyncState;
          end if;
          
        when WaitCheckState => -- wait enough time before next check
          if (before_check_counter(6)='0') then
            next_state <= WaitCheckState;
          else
            if (xor_results='0' and find_correct_idle_words='1') then
              next_state <= WaitSyncState;
            else
              next_state <= SlipState;
            end if;            
          end if;          
          
        when others => -- unknown state
          next_state <= InitState;
          
      end case;
    end if;
  end process;

  -------------------------------------------------------
  -- control before_sync_counter
  -------------------------------------------------------
  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET = '1') then
      before_sync_counter <= (others => '0');
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then  
      if    (next_state = InitState) then
        before_sync_counter <= (others => '0');
      elsif (next_state = SlipState) then
        before_sync_counter <= (others => '0');        
      elsif (next_state = WaitSyncState) then
        before_sync_counter <= before_sync_counter+1;
      else
        NULL;
      end if;
    end if;
  end process;
  
  -------------------------------------------------------
  -- control before_check_counter
  -------------------------------------------------------
  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET = '1') then
      before_check_counter <= (others => '0');
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then  
      if    (next_state = InitState) then
        before_check_counter <= (others => '0');
      elsif (next_state = SlipState) then
        before_check_counter <= (others => '0');        
      elsif (next_state = WaitCheckState) then
        before_check_counter <= before_check_counter+1;
      else
        NULL;
      end if;
    end if;
  end process;
  
  -------------------------------------------------------
  -- number_of_slip
  -------------------------------------------------------
  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET = '1') then
      number_of_slip <= (others => '0');
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then  
      if    (next_state = InitState) then
        number_of_slip <= (others => '0');
      elsif (next_state = SlipState) then
        number_of_slip <= number_of_slip + 1;
      else
        NULL;
      end if;
    end if;
  end process;

  -------------------------------------------------------
  -- sync_done
  -------------------------------------------------------
  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET = '1') then
      sync_done <= '0';
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then  
      if    (next_state = InitState) then
        sync_done <= '0';
      elsif (next_state = SyncState) then
        sync_done <= '1';
      else
        NULL;
      end if;
    end if;
  end process;
  
  -------------------------------------------------------
  -- sync_error
  -------------------------------------------------------
  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET = '1') then
      sync_error <= '0';
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then  
      if    (next_state = InitState) then
        sync_error <= '0';
      elsif (number_of_slip = X"1111111") then
        sync_error <= '1';
      elsif (next_state = SyncState) then
        if (xor_results='1') then
          sync_error <= '1';
        else
          NULL;
        end if;
      else
        NULL;
      end if;
    end if;
  end process;
  
end logic;

