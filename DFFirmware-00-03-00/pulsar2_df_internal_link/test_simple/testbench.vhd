--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;

entity testbench is
end testbench;

architecture logic of testbench is
  
  component ilink_interface
    port (BUFFER_CLR  : in  std_logic;
          MAIN_CLK    : in  std_logic;
          RX_DATA     : out std_logic_vector(31 downto 0);
          RX_DVALID   : out std_logic;
          RX_BUSY     : in  std_logic;
          RX_ENABLE   : in  std_logic;
          
          TX_DATA       : in  std_logic_vector(31 downto 0);
          TX_DVALID     : in  std_logic;
          TX_RDY        : out std_logic;
          TX_ENABLE     : in  std_logic;
          
          -------------------------
          -- Bit Error Rate Test --
          -------------------------
          RX_ENABLE_BERT           : in  std_logic; -- stop data transfer to the main_logic
          TX_ENABLE_BERT           : in  std_logic; -- start sending pseudo-random-data
          RX_BERT_COUNTER_RESET    : in  std_logic; -- counter reset for BERT
          RX_BERT_TOTAL_COUNT      : out std_logic_vector(31 downto 0); --  total/1M
          RX_BERT_ERROR_COUNT      : out std_logic_vector(31 downto 0);
          RX_BERT_COMPARISON_VALID : out std_logic;
          
          --------------------
          -- Return Channel --
          --------------------
          URL         : in  std_logic_vector(3 downto 0);
          LRL         : out std_logic_vector(3 downto 0);        
          
          -------------------
          -- GT RX signals --
          -------------------
          GT_RX_SYNC     : in  std_logic;
          GT_RX_SYNC_MON : out std_logic;
          GT_RXUSERCLK   : in  std_logic;
          GT_RXDATA      : in  std_logic_vector(31 downto 0);
          GT_RXCHARISK   : in  std_logic_vector(3  downto 0);
          GT_RXRESETDONE : in  std_logic;
          
          -------------------
          -- GT TX signals --
          -------------------
          GT_TXUSERCLK   : in  std_logic;
          GT_TXDATA      : out std_logic_vector(31 downto 0);
          GT_TXCHARISK   : out std_logic_vector(3  downto 0);
          GT_TXRESETDONE : in  std_logic;
          
          -----------------
          -- FRAME CHECK --
          -----------------
          GT_RXENCOMMAALIGN        : out std_logic);
  end component;
  
  signal main_clk_i   : std_logic;
  
  signal link0_buffer_clr_i : std_logic;
  signal link0_rx_sync_i : std_logic;

  signal link1_buffer_clr_i : std_logic;
  signal link1_rx_sync_i : std_logic;
  
  signal link0_rx_data_i    : std_logic_vector(31 downto 0);
  signal link0_rx_dvalid_i  : std_logic;
  signal link0_rx_busy_i    : std_logic;
  signal link0_rx_enable_i  : std_logic;
  
  signal link0_tx_data_i       : std_logic_vector(31 downto 0) := (others => '0');
  signal link0_tx_dvalid_i     : std_logic;
  signal link0_tx_rdy_i        : std_logic := '0';
  signal link0_tx_enable_i     : std_logic;
  
  signal link0_lrl_i         : std_logic_vector(3 downto 0);        
  
  signal link0_gt_rx_sync_mon_i : std_logic;
  signal link0_gt_rxusrclk_i    : std_logic;
  signal link0_gt_rxdata_i      : std_logic_vector(31 downto 0);
  signal link0_gt_rxcharisk_i   : std_logic_vector(3  downto 0);
  signal link0_gt_rxresetdone_i : std_logic := '0';
          
  signal link0_gt_txusrclk_i    : std_logic;
  signal link0_gt_txdata_i      : std_logic_vector(31 downto 0);
  signal link0_gt_txcharisk_i   : std_logic_vector(3  downto 0);
  signal link0_gt_txresetdone_i : std_logic := '0';

  signal link0_rxencommaalign_i : std_logic;
  
  signal link0_inc_in_i                   : std_logic; 
  signal link0_inc_out_i                  : std_logic; 
          
  signal link0_track_data_out_i           : std_logic;
  signal link0_track_data_raw_out_i       : std_logic;
  signal link0_init_sync_done_out_i       : std_logic;
  
  -----
  signal link1_rx_data_i    : std_logic_vector(31 downto 0);
  signal link1_rx_dvalid_i  : std_logic;
  signal link1_rx_busy_i    : std_logic;
  signal link1_rx_enable_i  : std_logic;
  
  signal link1_tx_data_i       : std_logic_vector(31 downto 0) := (others => '0');
  signal link1_tx_dvalid_i     : std_logic;
  signal link1_tx_rdy_i        : std_logic := '0';
  signal link1_tx_enable_i     : std_logic;
  
  signal link1_lrl_i         : std_logic_vector(3 downto 0);        
  
  signal link1_gt_rx_sync_mon_i : std_logic;
  signal link1_gt_rxusrclk_i    : std_logic;
  signal link1_gt_rxdata_i      : std_logic_vector(31 downto 0);
  signal link1_gt_rxcharisk_i   : std_logic_vector(3  downto 0);
  signal link1_gt_rxresetdone_i : std_logic := '0';
  
  signal link1_gt_txusrclk_i    : std_logic;
  signal link1_gt_txdata_i      : std_logic_vector(31 downto 0);
  signal link1_gt_txcharisk_i   : std_logic_vector(3  downto 0);
  signal link1_gt_txresetdone_i : std_logic := '0';
  
  signal link1_rxencommaalign_i : std_logic;
  
  signal link1_inc_in_i                   : std_logic; 
  signal link1_inc_out_i                  : std_logic; 
          
  signal link1_track_data_out_i           : std_logic;
  signal link1_track_data_raw_out_i       : std_logic;
  signal link1_init_sync_done_out_i       : std_logic; 
  
  signal link0_rx_enable_bert_i           : std_logic;
  signal link0_tx_enable_bert_i           : std_logic;
  signal link0_rx_bert_counter_reset_i    : std_logic;
  signal link0_rx_bert_total_count_i      : std_logic_vector(31 downto 0);
  signal link0_rx_bert_error_count_i      : std_logic_vector(31 downto 0);
  signal link0_rx_bert_comparison_valid_i : std_logic;
  
  signal link1_rx_enable_bert_i           : std_logic;
  signal link1_tx_enable_bert_i           : std_logic;
  signal link1_rx_bert_counter_reset_i    : std_logic;
  signal link1_rx_bert_total_count_i      : std_logic_vector(31 downto 0);
  signal link1_rx_bert_error_count_i      : std_logic_vector(31 downto 0);
  signal link1_rx_bert_comparison_valid_i : std_logic;  
  
begin
  
  process
  begin
    main_clk_i <= '1';
    --wait for 2.5 ns;
    wait for 5 ns;
    main_clk_i <= '0';
    --wait for 2.5 ns;
    wait for 5 ns;
  end process;

  process
  begin
    link0_gt_txusrclk_i  <= '1';
    link1_gt_txusrclk_i  <= '1';
    wait for 3.125 ns;
    link0_gt_txusrclk_i  <= '0';
    link1_gt_txusrclk_i  <= '0';
    wait for 3.125 ns;
  end process;  
  link0_gt_rxusrclk_i  <= link0_gt_txusrclk_i;
  link1_gt_rxusrclk_i  <= link1_gt_txusrclk_i;


  LINK0 : ilink_interface
    port map (
      BUFFER_CLR  => link0_buffer_clr_i,
      MAIN_CLK    => main_clk_i,
      RX_DATA     => link0_rx_data_i,
      RX_DVALID   => link0_rx_dvalid_i,
      RX_BUSY     => link0_rx_busy_i,
      RX_ENABLE   => link0_rx_enable_i,
      
      TX_DATA     => link0_tx_data_i,
      TX_DVALID   => link0_tx_dvalid_i,
      TX_RDY      => link0_tx_rdy_i,
      TX_ENABLE   => link0_tx_enable_i,
      
      -------------------------
      -- Bit Error Rate Test --
      -------------------------
      RX_ENABLE_BERT           => link0_rx_enable_bert_i,
      TX_ENABLE_BERT           => link0_tx_enable_bert_i,
      RX_BERT_COUNTER_RESET    => link0_rx_bert_counter_reset_i,
      RX_BERT_TOTAL_COUNT      => link0_rx_bert_total_count_i,
      RX_BERT_ERROR_COUNT      => link0_rx_bert_error_count_i,
      RX_BERT_COMPARISON_VALID => link0_rx_bert_comparison_valid_i,
      
      --------------------
      -- Return Channel --
      --------------------
      URL  => "0010",
      LRL  => link0_lrl_i,
      
      -------------------
      -- GT RX signals --
      -------------------
      GT_RX_SYNC     => link0_rx_sync_i,
      GT_RX_SYNC_MON => link0_gt_rx_sync_mon_i,
      GT_RXUSERCLK   => link0_gt_rxusrclk_i,
      GT_RXDATA      => link0_gt_rxdata_i,
      GT_RXCHARISK   => link0_gt_rxcharisk_i,
      GT_RXRESETDONE => link0_gt_rxresetdone_i,
      
      -------------------
      -- GT TX signals --
      -------------------
      GT_TXUSERCLK   => link0_gt_txusrclk_i,
      GT_TXDATA      => link0_gt_txdata_i,
      GT_TXCHARISK   => link0_gt_txcharisk_i,
      GT_TXRESETDONE => link0_gt_txresetdone_i,
      
      -----------------
      -- FRAME CHECK --
      -----------------
      GT_RXENCOMMAALIGN => link0_rxencommaalign_i);
  
  LINK1 : ilink_interface
    port map (
      BUFFER_CLR  => link1_buffer_clr_i,
      MAIN_CLK    => main_clk_i,
      RX_DATA     => link1_rx_data_i,
      RX_DVALID   => link1_rx_dvalid_i,
      RX_BUSY     => link1_rx_busy_i,
      RX_ENABLE   => link1_rx_enable_i,
      
      TX_DATA     => link1_tx_data_i,
      TX_DVALID   => link1_tx_dvalid_i,
      TX_RDY      => link1_tx_rdy_i,
      TX_ENABLE   => link1_tx_enable_i,
      
      -------------------------
      -- Bit Error Rate Test --
      -------------------------
      RX_ENABLE_BERT           => link1_rx_enable_bert_i,
      TX_ENABLE_BERT           => link1_tx_enable_bert_i,
      RX_BERT_COUNTER_RESET    => link1_rx_bert_counter_reset_i,
      RX_BERT_TOTAL_COUNT      => link1_rx_bert_total_count_i,
      RX_BERT_ERROR_COUNT      => link1_rx_bert_error_count_i,
      RX_BERT_COMPARISON_VALID => link1_rx_bert_comparison_valid_i,
      
      --------------------
      -- Return Channel --
      --------------------
      URL  => "0010",
      LRL  => link1_lrl_i,
      
      -------------------
      -- GT RX signals --
      -------------------
      GT_RX_SYNC     => link1_rx_sync_i,
      GT_RX_SYNC_MON => link1_gt_rx_sync_mon_i,
      GT_RXUSERCLK   => link1_gt_rxusrclk_i,
      GT_RXDATA      => link1_gt_rxdata_i,
      GT_RXCHARISK   => link1_gt_rxcharisk_i,
      GT_RXRESETDONE => link1_gt_rxresetdone_i,
      
      -------------------
      -- GT TX signals --
      -------------------
      GT_TXUSERCLK   => link1_gt_txusrclk_i,
      GT_TXDATA      => link1_gt_txdata_i,
      GT_TXCHARISK   => link1_gt_txcharisk_i,
      GT_TXRESETDONE => link1_gt_txresetdone_i,
      
      -----------------
      -- FRAME CHECK --
      -----------------
      GT_RXENCOMMAALIGN => link1_rxencommaalign_i);
  
  link1_gt_rxdata_i    <= link0_gt_txdata_i;
  link1_gt_rxcharisk_i <= link0_gt_txcharisk_i;
  
  link0_gt_rxdata_i    <= link1_gt_txdata_i;
  link0_gt_rxcharisk_i <= link1_gt_txcharisk_i;  
  
  link1_inc_in_i       <= link0_inc_out_i;
  
  process (main_clk_i) is
  begin
    if (main_clk_i'event and main_clk_i='1') then
      if link0_tx_rdy_i = '1' then 
        link0_tx_data_i   <= link0_tx_data_i + 1;
        link0_tx_dvalid_i <= '1';
      else
        link0_tx_data_i   <= link0_tx_data_i;
        link0_tx_dvalid_i <= '0';
      end if;
    end if;
  end process;

  
  process (main_clk_i) is
  begin
    if (main_clk_i'event and main_clk_i='1') then
      if link1_tx_rdy_i = '1' then 
        link1_tx_data_i   <= link1_tx_data_i + 1;
        link1_tx_dvalid_i <= '1';
      else
        link1_tx_data_i   <= link1_tx_data_i;
        link1_tx_dvalid_i <= '0';
      end if;
    end if;
  end process;

  
  -- time line (link0)
  process
  begin
    link0_rx_bert_counter_reset_i <= '1';
    link0_rx_enable_bert_i <= '0';
    link0_tx_enable_bert_i <= '0';
    
    link0_buffer_clr_i <= '1';
    link0_rx_sync_i    <= '1';
    link0_tx_enable_i  <= '0';
    link0_rx_enable_i  <= '0';
    
    link0_gt_rxresetdone_i <= '0';
    link0_gt_txresetdone_i <= '0';
    link0_rx_busy_i        <= '0';
    
    wait for 5 us;

    link0_buffer_clr_i     <= '0';
    link0_gt_rxresetdone_i <= '1';
    link0_gt_txresetdone_i <= '1';

    wait for 5 us;
    link0_rx_sync_i    <= '0';

    wait for 5 us;    
    link0_tx_enable_i  <= '1';
    link0_rx_enable_i  <= '1';    
    
    wait for 50 us;
    wait for 5  us;
    wait for 100 us;
    link0_rx_bert_counter_reset_i <= '1';
    link0_rx_enable_bert_i <= '1';

    wait for 5  us;
    link0_tx_enable_bert_i <= '1';

    wait for 5  us;
    link0_rx_bert_counter_reset_i <= '0';

    wait for 50  us;
    link0_rx_enable_bert_i <= '0';
    
    wait;
  end process;
  
  -- time line (link1)
  process
  begin
    link1_rx_bert_counter_reset_i <= '1';
    link1_rx_enable_bert_i <= '0';
    link1_tx_enable_bert_i <= '0';
    
    link1_buffer_clr_i <= '1';
    link1_rx_sync_i    <= '1';
    link1_tx_enable_i  <= '0';
    link1_rx_enable_i  <= '0';
    
    link1_gt_rxresetdone_i <= '0';
    link1_gt_txresetdone_i <= '0';
    link1_rx_busy_i        <= '0';
    
    wait for 5 us;
    
    link1_buffer_clr_i     <= '0';
    link1_gt_rxresetdone_i <= '1';
    link1_gt_txresetdone_i <= '1';
    
    wait for 5 us;
    link1_rx_sync_i    <= '0';

    wait for 5 us;    
    link1_tx_enable_i  <= '1';
    link1_rx_enable_i  <= '1';    

    wait for 50 us;
    link1_rx_busy_i        <= '1';

    wait for 5  us;    
    link1_rx_busy_i        <= '0';

    wait for 100 us;
    link1_rx_bert_counter_reset_i <= '1';
    link1_rx_enable_bert_i <= '1';

    wait for 5  us;
    link1_tx_enable_bert_i <= '1';

    wait for 5  us;
    link1_rx_bert_counter_reset_i <= '0';

    wait for 50  us;
    link1_rx_enable_bert_i <= '0';
    
    wait;
  end process;
  
  
end logic;
