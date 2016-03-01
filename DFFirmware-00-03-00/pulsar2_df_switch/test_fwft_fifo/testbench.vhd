--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

use work.data_formatter_constants.all;

entity testbench is
end testbench;

architecture logic of testbench is
  
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
  
  component patgen
    generic (longer_period : std_logic := '0';
             const_pattern : std_logic_vector(7 downto 0) := (others => '0'));
    port ( CLK        : in  std_logic;
           TX_DATA    : out std_logic_vector(31 downto 0);
           TX_DVALID  : out std_logic;
           TX_RDY     : in  std_logic;
           ENABLE     : in  std_logic
           );
  end component;
  
  signal clk_i : std_logic := '0';
  signal tx_data_i   : std_logic_vector(31 downto 0);
  signal tx_dvalid_i : std_logic;
  signal tx_rdy_i    : std_logic := '0';
  signal enable_i    : std_logic := '0';

  signal reset_i      : std_logic;
  signal rd_en_i      : std_logic;
  signal fifo_dout_i  : std_logic_vector ( 35 downto 0 );
  signal fifo_empty_i : std_logic;
  signal fifo_full_i  : std_logic;
  
begin

  process
  begin
    clk_i <= not clk_i;
    wait for 5 ns;
  end process;
  
  pat_gen : patgen
    port map ( CLK=>clk_i, 
               TX_DATA=>tx_data_i,
               TX_DVALID=>tx_dvalid_i,
               TX_RDY=>tx_rdy_i,
               ENABLE=>enable_i
               );

  tx_rdy_i <= (not fifo_full_i) and (not reset_i);
  
  fifo : short_fwft_fifo
    port map (
      clk=>clk_i,
      rst=>reset_i,      
      din(31 downto  0)=>tx_data_i,
      din(35 downto 32)=>(others => '0'),      
      wr_en=>tx_dvalid_i,
      rd_en=>rd_en_i,
      dout=>fifo_dout_i,
      empty=>fifo_empty_i,
      prog_full=>fifo_full_i
      );

  process
  begin
    reset_i  <= '1';
    enable_i <= '0';
    rd_en_i  <= '0';
    
    wait for 1 us;
    
    reset_i  <= '0';
    wait for 1 us;
    enable_i <= '1';
    
    wait for 5 us;
    rd_en_i  <= '1';
    wait for 5 us;    
    rd_en_i  <= '0';
    
    wait for 1 us;
    
    rd_en_i  <= '1';
    
    wait for 1 us;
    enable_i <= '0';
    
    wait for 1 us;
    enable_i <= '1';

    wait for 1 us;
    rd_en_i  <= '0';
    enable_i <= '0';

    wait for 1 us;
    rd_en_i  <= '1';
    enable_i <= '1';        
    
    wait;
  end process;
  
end logic;

