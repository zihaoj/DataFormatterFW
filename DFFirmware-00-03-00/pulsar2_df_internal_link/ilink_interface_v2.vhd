-------------------------------------------------------------------------------
-- Internal Link Handler
-- clock domain : rxuserclk -> main_clk
--
-- BIT ERROR RATE TEST PROCEDURE
-- procedure to start
-- TX_ENABLE      => OFF
-- RX_ENABLE_BERT => ON
-- RX_BERT_COUNTER_RESET => ON
-- TX_ENABLE_BERT => ON
-- RX_ENABLE_BERT => ON
-- TX_ENABLE      => ON
------
-- TX_ENABLE      => OFF
-- TX_ENABLE_BERT => OFF
-- RX_ENABLE_BERT => OFF
-- TX_ENABLE      => ON
------        

-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity ilink_interface is
  -- define frequency of idle and pad words
  generic (TX_WORD_COUNTER_LENGTH   : integer := 7);
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
end entity;

architecture logic of ilink_interface is
  
  component fwft_ic_w36_d512_f256_my_wrapper
    port (
      rst : in std_logic;
      wr_clk : in std_logic;
      rd_clk : in std_logic;
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      empty : out std_logic;
      prog_full : out std_logic
      );
  end component;

  component fwft_ic_w36_d512_my_wrapper
    port (
      rst : in std_logic;
      wr_clk : in std_logic;
      rd_clk : in std_logic;
      din : in std_logic_vector ( 35 downto 0 );
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector ( 35 downto 0 );
      empty : out std_logic;
      prog_full : out std_logic
      );
  end component;

  component ilink_patgen is
    port ( CLK        : in  std_logic;
           TX_DATA    : out std_logic_vector(31 downto 0);
           TX_DVALID  : out std_logic;
           TX_RDY     : in  std_logic;
           ENABLE     : in  std_logic
           );
  end component;
  
  component ilink_patchk is
    port (CLK        : in  std_logic;
          RX_DATA    : in  std_logic_vector(31 downto 0);
          RX_DVALID  : in  std_logic;
          COUNTER_RESET : in  std_logic;
          TOTAL_COUNTER : out std_logic_vector(31 downto 0);
          ERROR_COUNTER : out std_logic_vector(31 downto 0);
          COMPARISON_VALID : out std_logic
          );
  end component;  

  signal gt_rxcharisk_r1     : std_logic_vector(3  downto 0);
  signal gt_rxdata_r1        : std_logic_vector(31 downto 0);
  
  signal rx_system_reset_c   : std_logic;
  signal rx_fifo_data_in_i   : std_logic_vector(31 downto 0) := (others => '0');
  signal rx_fifo_wen_in_i    : std_logic;
  signal rx_fifo_rd_en_i     : std_logic;
  signal rx_fifo_dout_i      : std_logic_vector(31 downto 0);
  signal rx_dummy_floating_four_bits : std_logic_vector(35 downto 32);
  signal rx_fifo_empty_i     : std_logic;
  signal rx_fifo_prog_full_i : std_logic;
  --signal rx_fifo_prog_full_r1 : std_logic;
  --signal rx_fifo_prog_full_r2 : std_logic;
  
  signal tx_system_reset_c   : std_logic;
  signal tx_fifo_data_in_i   : std_logic_vector(31 downto 0) := (others => '0');
  signal tx_fifo_wd_en_i     : std_logic := '0';
  signal tx_fifo_rd_en_i     : std_logic;
  signal tx_fifo_dout_i      : std_logic_vector(31 downto 0);
  signal tx_dummy_floating_four_bits : std_logic_vector(35 downto 32);
  signal tx_fifo_empty_i     : std_logic;
  signal tx_fifo_prog_full_i : std_logic;
  
  signal   tx_word_counter_i    : std_logic_vector(TX_WORD_COUNTER_LENGTH-1  downto  0) := (others => '0');
  constant tx_word_counter_idle : std_logic_vector(TX_WORD_COUNTER_LENGTH-1  downto  0) := (others => '1');
  constant tx_word_counter_pad  : std_logic_vector(TX_WORD_COUNTER_LENGTH-1  downto  0) := (others => '0');
  signal lrl_i               : std_logic_vector(3 downto 0);
  signal destination_busy_i  : std_logic;
  signal tx_idle_word_i      : std_logic_vector(31 downto 0) := (others => '0');
  
-----------------------------------------------------------------------------
-- 8B10B characters
-----------------------------------------------------------------------------
  constant K28_5 : std_logic_vector(7 downto 0) := "10111100";  -- BC
  constant D5_6  : std_logic_vector(7 downto 0) := "11000101";  -- C5
                                                                -- in 10bit
                                                                -- 0110100101
  constant D16_2 : std_logic_vector(7 downto 0) := "01010000";  -- 50
                                                                -- in 10bit
                                                                -- 0011111010
  constant K23_7 : std_logic_vector(7 downto 0) := "11110111";  -- F7
  constant K30_7 : std_logic_vector(7 downto 0) := "11111110";  -- FE
  
  constant IDLE_isK        : std_logic_vector(3  downto 0)  := "0001";
  --constant PAD_isK         : std_logic_vector(3  downto 0)  := "1111";      
  --constant PAD_DATA        : std_logic_vector(31  downto 0) := K23_7 & K23_7 & K23_7 & K23_7;
  constant DATA_isK        : std_logic_vector(3  downto 0)  := "0000";
  constant PAD_isK         : std_logic_vector(3  downto 0)  := "0001";
  constant PAD_Data : std_logic_vector(31 downto 0) := D5_6 & D5_6 & D5_6 & K28_5;
  constant PAD_Data1 : std_logic_vector(31 downto 0) := D16_2 & D16_2 & D16_2 & K28_5;

  
  constant tied_to_ground_i : std_logic := '0';
  
  type TXStatus_t is (NORMAL_DATA, -- normal operation
                      FORCE_IDLE,
                      FORCE_PAD);
  signal TXStatus : TXStatus_t := FORCE_IDLE;
  
-----------------------------------------------------------------------------
-- FOR BERT Functionality
-----------------------------------------------------------------------------  
  signal rx_patgen_dvalid_in_i : std_logic;
  signal patgen_tx_data_i   : std_logic_vector(31 downto 0) := (others => '0');
  signal patgen_tx_dvalid_i : std_logic;  
  signal tx_rdy_i           : std_logic := '0';
  
begin

------------------------------------------------------------------
-- RX PART
------------------------------------------------------------------
  --frame_check_reset_i <= matchn_i;
  rx_system_reset_c   <= (not GT_RXRESETDONE) or GT_RX_SYNC;
  GT_RX_SYNC_MON      <= rx_system_reset_c;
  GT_RXENCOMMAALIGN   <= '1';
  
  LRL <= lrl_i;
  process (GT_RXUSERCLK)
  begin
    if (GT_RXUSERCLK'event and GT_RXUSERCLK='1') then
      gt_rxcharisk_r1 <= GT_RXCHARISK;
      gt_rxdata_r1    <= GT_RXDATA;
      
      if    (rx_system_reset_c='1') then
        rx_fifo_data_in_i  <= rx_fifo_data_in_i; 
        rx_fifo_wen_in_i   <= '0';
        rx_patgen_dvalid_in_i <= '0';
        destination_busy_i <= '0';
        lrl_i              <= (others => '0');
        
      elsif (RX_ENABLE='0') then
        rx_fifo_data_in_i  <= rx_fifo_data_in_i; 
        rx_fifo_wen_in_i   <= '0';
        rx_patgen_dvalid_in_i <= '0';
        destination_busy_i <= destination_busy_i;
        lrl_i              <= lrl_i;
        
      elsif (gt_rxcharisk_r1=IDLE_isK) then
        rx_fifo_data_in_i  <= rx_fifo_data_in_i; 
        rx_fifo_wen_in_i   <= '0';
        rx_patgen_dvalid_in_i <= '0';
        lrl_i              <= gt_rxdata_r1(11 downto 8);
        destination_busy_i <= gt_rxdata_r1(12);

      elsif (gt_rxcharisk_r1=PAD_isK) then
        rx_fifo_data_in_i  <= rx_fifo_data_in_i; 
        rx_fifo_wen_in_i   <= '0';
        rx_patgen_dvalid_in_i <= '0';
        lrl_i              <= lrl_i;
        destination_busy_i <= destination_busy_i;
        
      else
        rx_fifo_data_in_i <= gt_rxdata_r1;
        lrl_i              <= lrl_i; 
        destination_busy_i <= destination_busy_i;          
        
        if RX_ENABLE_BERT = '1' then
          rx_fifo_wen_in_i  <= '0';
          rx_patgen_dvalid_in_i <= '1';
        else
          rx_fifo_wen_in_i  <= '1';
          rx_patgen_dvalid_in_i <= '0';
        end if;
      end if;
    end if;
  end process;
  
  -- <RX Buffer>
  Rx_Fifo : fwft_ic_w36_d512_f256_my_wrapper
    port map (
      rst => BUFFER_CLR,
      wr_clk => GT_RXUSERCLK,
      rd_clk => MAIN_CLK,
      din(31 downto  0) => rx_fifo_data_in_i,
      din(35 downto 32) => (others => '0'),
      wr_en => rx_fifo_wen_in_i,
      rd_en => rx_fifo_rd_en_i,
      dout(31 downto  0) => rx_fifo_dout_i,
      dout(35 downto 32) => rx_dummy_floating_four_bits,
      empty => rx_fifo_empty_i,
      prog_full => rx_fifo_prog_full_i
      );
  rx_fifo_rd_en_i <= (not RX_BUSY);
  
  bert_pat_chk : ilink_patchk
    port map (CLK => GT_RXUSERCLK,
              RX_DATA => rx_fifo_data_in_i,
              RX_DVALID => rx_patgen_dvalid_in_i,
              COUNTER_RESET => RX_BERT_COUNTER_RESET,
              TOTAL_COUNTER => RX_BERT_TOTAL_COUNT,
              ERROR_COUNTER => RX_BERT_ERROR_COUNT,
              COMPARISON_VALID => RX_BERT_COMPARISON_VALID
              );  
  
  -- <OUTPUT>
  process (MAIN_CLK)
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      RX_DVALID <= rx_fifo_rd_en_i and (not rx_fifo_empty_i) ;
      RX_DATA   <= rx_fifo_dout_i;
    end if;
  end process;
  
------------------------------------------------------------------
-- TX PART
------------------------------------------------------------------
  tx_system_reset_c <= (not GT_TXRESETDONE);
  tx_rdy_i <= '0' when (tx_fifo_prog_full_i='1') else '1';
  TX_RDY   <= tx_rdy_i when (TX_ENABLE_BERT='0') else '0';

  bert_pat_gen : ilink_patgen
    port map ( CLK        => MAIN_CLK,
               TX_DATA    => patgen_tx_data_i,
               TX_DVALID  => patgen_tx_dvalid_i,
               TX_RDY     => tx_rdy_i,
               ENABLE     => TX_ENABLE_BERT
               );
  
  process (MAIN_CLK) is
  begin
    if (MAIN_CLK'event and MAIN_CLK='1') then
      if TX_ENABLE_BERT = '0' then
        tx_fifo_data_in_i <= TX_DATA;
        tx_fifo_wd_en_i   <= TX_DVALID;
      else
        tx_fifo_data_in_i <= patgen_tx_data_i;
        tx_fifo_wd_en_i   <= patgen_tx_dvalid_i;
      end if;
    end if;
  end process;

  
  -- <TX Buffer>
  Tx_Fifo : fwft_ic_w36_d512_my_wrapper
    port map (
      rst => BUFFER_CLR,
      wr_clk => MAIN_CLK,
      rd_clk => GT_TXUSERCLK,
      din(31 downto  0) => tx_fifo_data_in_i,
      din(35 downto 32) => (others => '0'),
      wr_en => tx_fifo_wd_en_i,
      rd_en => tx_fifo_rd_en_i,
      dout(31 downto  0) => tx_fifo_dout_i,
      dout(35 downto 32) => tx_dummy_floating_four_bits,
      empty => tx_fifo_empty_i,
      prog_full => tx_fifo_prog_full_i
      );
  
  process (GT_TXUSERCLK)
  begin
    if (GT_TXUSERCLK'event and GT_TXUSERCLK='1') then
      tx_idle_word_i(7  downto  0) <= K28_5;
      tx_idle_word_i(11 downto  8) <= URL;
      tx_idle_word_i(12)           <= rx_fifo_prog_full_i; -- to propagate busy
      tx_idle_word_i(15 downto 13) <= (others => '0');
      tx_idle_word_i(31 downto 16) <= D5_6 & D5_6;
      --rx_fifo_prog_full_r1 <= rx_fifo_prog_full_i;
      --rx_fifo_prog_full_r2 <= rx_fifo_prog_full_r1;
      
      tx_word_counter_i <= tx_word_counter_i + 1;
      
      if (tx_system_reset_c = '1') then
        GT_TXDATA    <= tx_idle_word_i;
        GT_TXCHARISK <= IDLE_isK;        
        TXStatus        <= FORCE_IDLE;
        tx_fifo_rd_en_i <= '0';
        
      elsif TXStatus = FORCE_IDLE then    -- FORCE IDEL (at least every 16 words)
        GT_TXDATA    <= tx_idle_word_i;
        GT_TXCHARISK <= IDLE_isK;
        
        if (TX_ENABLE='0') then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
        elsif (tx_word_counter_i=tx_word_counter_pad) then
          TXStatus        <= FORCE_PAD;
          tx_fifo_rd_en_i <= '0';
        elsif (tx_word_counter_i=tx_word_counter_idle) then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
        --elsif (rx_fifo_prog_full_r2='0' and rx_fifo_prog_full_r2='1') then --rising edge
        --  TXStatus        <= FORCE_IDLE;
        --  tx_fifo_rd_en_i <= '0';
        elsif (destination_busy_i='1') then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
        else
          TXStatus        <= NORMAL_DATA;
          tx_fifo_rd_en_i <= '1';
        end if;
        
      elsif TXStatus = NORMAL_DATA then    -- NORMAL DATA
        
        if tx_fifo_empty_i='0' and tx_fifo_rd_en_i='1' then
          GT_TXDATA    <= tx_fifo_dout_i;
          GT_TXCHARISK <= DATA_isK;
          
        else
          GT_TXDATA    <= tx_idle_word_i;
          GT_TXCHARISK <= IDLE_isK;
        end if;
        
        if (TX_ENABLE='0') then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
        elsif (tx_word_counter_i=tx_word_counter_pad) then
          TXStatus        <= FORCE_PAD;
          tx_fifo_rd_en_i <= '0';
        elsif (tx_word_counter_i=tx_word_counter_idle) then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
        --elsif (rx_fifo_prog_full_r2='0' and rx_fifo_prog_full_r2='1') then --rising edge
        --  TXStatus        <= FORCE_IDLE;
        --  tx_fifo_rd_en_i <= '0';
        elsif (destination_busy_i='1') then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
      else
          TXStatus        <= NORMAL_DATA;
          tx_fifo_rd_en_i <= '1';
        end if;
        
      elsif TXStatus = FORCE_PAD then    
        GT_TXDATA    <= PAD_DATA;
        GT_TXCHARISK <= PAD_isK;
        
        if (TX_ENABLE='0') then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
        elsif (tx_word_counter_i=tx_word_counter_pad) then
          TXStatus        <= FORCE_PAD;
          tx_fifo_rd_en_i <= '0';
        elsif (tx_word_counter_i=tx_word_counter_idle) then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
        --elsif (rx_fifo_prog_full_r2='0' and rx_fifo_prog_full_r2='1') then --rising edge
        --  TXStatus        <= FORCE_IDLE;
        --  tx_fifo_rd_en_i <= '0';
        elsif (destination_busy_i='1') then
          TXStatus        <= FORCE_IDLE;
          tx_fifo_rd_en_i <= '0';
        else
          TXStatus        <= NORMAL_DATA;
          tx_fifo_rd_en_i <= '1';
        end if;
        
      end if;
    end if;
  end process;  
  
end logic;
