------------------------------------------------------------------------------
-- PulsarIIb FWFT
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.conv_integer;

library work;
use work.FmcConstants.all;

entity fmc_input_buffer is
  generic
    (
      BUFFER_DEPTH : integer := 2048
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
      RESET         : in  std_logic;
      FIFO_FULL_OUT : out std_logic;
      FIFO_BUSY_OUT : out std_logic);
end fmc_input_buffer;
    
architecture logic of fmc_input_buffer is
  
  component pulsar2_fifo_w36_d2048_fwft
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
      wr_data_count : out STD_LOGIC_VECTOR ( 10 downto 0 ) 
      );
  end component;
  
  constant fifo_depth : integer := 2048;
  constant busy_threshold : integer := 128; -- originally 48
  
  signal   three_bit_float : std_logic_vector(2 downto 0);
  constant three_bit_zero  : std_logic_vector(2 downto 0) := (others => '0');
  
  signal wr_data_count_buf_i : std_logic_vector(10 downto 0);
  signal empty_buf_i : std_logic;
  signal din_sync_i  : std_logic_vector(35 downto 0) := (others => '0');
  signal den_sync_i : std_logic := '0';
    
begin
  
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
  
  D2048_FIFO : if BUFFER_DEPTH=2048 generate
    -- ===================================================
    -- FIFO
    myFifo : pulsar2_fifo_w36_d2048_fwft
      port map (
        rst    => RESET,
        wr_clk => FMC_CLK_IN,
        rd_clk => MAIN_CLK,
        wr_en  => den_sync_i,
        rd_en  => FIFO_GO_NEXT_IF_EXIST_IN,
        almost_full => open,
        full   => FIFO_FULL_OUT,
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
    elsif (FMC_CLK_IN'event and FMC_CLK_IN='1') then
      if (fifo_depth-conv_integer(wr_data_count_buf_i)<busy_threshold) then
        FIFO_BUSY_OUT  <= '1';
      else
        FIFO_BUSY_OUT  <= '0';
      end if;
    end if;
  end process;
  -- ===================================================
  
end logic;
      
