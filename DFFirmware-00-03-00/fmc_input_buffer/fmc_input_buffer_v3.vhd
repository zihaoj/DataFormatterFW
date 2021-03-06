------------------------------------------------------------------------------
-- PulsarIIb FWFT
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;


library work;
use work.FmcConstants.all;

entity fmc_input_buffer is
  generic
    (
      BUFFER_DEPTH : integer := 8192
      );
  port
    ( -- PORT A
      FMC_CLK_IN : in std_logic; -- WRITE CLOCK
      FMC_DATA_IN    : in std_logic_vector(width_of_decoded_word-1 downto 0);
      FMC_CTRL_IN    : in std_logic;
      FMC_DEN_IN     : in std_logic;
      
      -- PORT B
      MAIN_CLK        : in  std_logic; -- READ CLOCK
      DATA_OUT        : out std_logic_vector(width_of_decoded_word-1 downto 0);
      CTRL_OUT        : out std_logic;
      DEN_OUT         : out std_logic;
      FIFO_GO_NEXT_IF_EXIST_IN : in  std_logic;
      
      -- FLOW CONTROL
      FIFO_BUSY_THRESHOLD : in std_logic_vector(31 downto 0);
      RESET         : in  std_logic;
      FIFO_FULL_OUT : out std_logic;
      FIFO_BUSY_OUT : out std_logic
      );
end fmc_input_buffer;
    
architecture logic of fmc_input_buffer is
  
  component pulsar2_fifo_w36_d8192_fwft
    port (
      rst : in STD_LOGIC := 'X'; 
      wr_clk : in STD_LOGIC := 'X'; 
      rd_clk : in STD_LOGIC := 'X'; 
      wr_en : in STD_LOGIC := 'X'; 
      rd_en : in STD_LOGIC := 'X'; 
      almost_full : out STD_LOGIC;
      full : out STD_LOGIC;
      empty : out STD_LOGIC;
      din : in STD_LOGIC_VECTOR ( 35 downto 0 ); 
      dout : out STD_LOGIC_VECTOR ( 35 downto 0 ); 
      wr_data_count : out STD_LOGIC_VECTOR ( 12 downto 0 ) 
      );
  end component;
  
  constant fifo_depth : integer := 8192;
  --signal busy_threshold : integer := 128; -- originally 48
  signal busy_threshold : std_logic_vector(31 downto 0) := (others => '0');
  signal   three_bit_float : std_logic_vector(2 downto 0);
  constant three_bit_zero  : std_logic_vector(2 downto 0) := (others => '0');
  
  signal wr_data_count_buf_i : std_logic_vector(12 downto 0);
  signal empty_buf_i : std_logic;
  signal din_sync_i  : std_logic_vector(35 downto 0) := (others => '0');
  signal den_sync_i : std_logic := '0';
  signal fifo_full_counter_i : std_logic_vector(31 downto 0);
  signal fifo_full_counter_out_i : std_logic_vector(31 downto 0);
  signal fifo_all_counter_i : std_logic_vector(31 downto 0);
  signal fifo_full_out_i : std_logic;

  attribute mark_debug : string; 
  attribute mark_debug of busy_threshold  : signal is "true";
    
begin
  FIFO_FULL_OUT <= fifo_full_out_i;
  -- ===================================================
  -- INPUT DFF
  process (FMC_CLK_IN)
  begin
    if (FMC_CLK_IN'event and FMC_CLK_IN='0')  then -- on purpose
      
      din_sync_i(31 downto 0)  <= FMC_DATA_IN;
      din_sync_i(32)           <= FMC_CTRL_IN;
      din_sync_i(35 downto 33) <= three_bit_zero;
      den_sync_i               <= FMC_DEN_IN;

    end if;
  end process;
  -- ===================================================
  
  D8192_FIFO : if BUFFER_DEPTH=8192 generate
    -- ===================================================
    -- FIFO
    myFifo : pulsar2_fifo_w36_d8192_fwft
      port map (
        rst    => RESET,
        wr_clk => FMC_CLK_IN,
        rd_clk => MAIN_CLK,
        wr_en  => den_sync_i,
        rd_en  => FIFO_GO_NEXT_IF_EXIST_IN,
        almost_full => open,
        full   => fifo_full_out_i,
        empty  => empty_buf_i,
        din    => din_sync_i,
        dout(31 downto  0) => DATA_OUT,
        dout(32)           => CTRL_OUT,
        dout(35 downto 33) => three_bit_float,
        wr_data_count => wr_data_count_buf_i
        );
  end generate;
  
  DEN_OUT <= not empty_buf_i;
  -- ===================================================
  
  -- ===================================================
  -- BUSY CONTROLLER
  process (FMC_CLK_IN, RESET)
  begin
    if (RESET='1') then
      FIFO_BUSY_OUT  <= '1';
      if (busy_threshold < x"00000080") then
        busy_threshold<= x"00000080";
      else
        busy_threshold <= FIFO_BUSY_THRESHOLD;
      end if;

    elsif (FMC_CLK_IN'event and FMC_CLK_IN='1') then
      if (fifo_depth-conv_integer(wr_data_count_buf_i)<=conv_integer(busy_threshold)) then
        FIFO_BUSY_OUT  <= '1';
      else
        FIFO_BUSY_OUT  <= '0';
      end if;
    end if;
  end process;
  
end logic;
      
