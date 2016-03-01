------------------------------------------------------------------------------
-- Test bench
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity testbench is
  generic (
    DATA_WIDTH        : positive := 32
    );
end testbench;

architecture logic of testbench is
  
  signal main_clk_i : std_logic := '0';
  signal rdreq_i : std_logic := '0';
  signal dout_i  : std_logic_vector(DATA_WIDTH-1 downto 0);
  signal reset_i : std_logic := '0';
  signal data_valid_i : std_logic := '0';
  
  component pattern_generator is
  generic (
    INPUT_ROM_FILE_NALE : string  := "test.dat";
    DATA_WIDTH        : positive := DATA_WIDTH;
    RAM_ADDRESS_WIDTH : positive := 5
    );
  port (
    SYS_CLK : in  std_logic;    
    
    -- FIFO Output Port
    RDREQ   : in  std_logic;
    Q       : out std_logic_vector(DATA_WIDTH-1 downto 0);
    DV      : out std_logic; -- data valid    
    
    -- CLEAR signal
    ACLR    : in  std_logic
    );
  end component;
  
begin

  MyROM : pattern_generator
    generic map (
      INPUT_ROM_FILE_NALE => "test.dat"
    )
    port map (
      SYS_CLK => main_clk_i,
      RDREQ   => rdreq_i,
      Q       => dout_i,
      DV      => data_valid_i,
      ACLR    => reset_i
    );
  
  
  process
  begin
    main_clk_i<='0';
    wait for 2.5 ns;
    main_clk_i<='1';
    wait for 2.5 ns;
  end process;


  -- timeline
  process
  begin
    rdreq_i <= '0';
    reset_i <= '1';
    
    wait for 10 us;
    rdreq_i <= '0';
    reset_i <= '0';

    wait for 10 us;
    rdreq_i <= '1';
    reset_i <= '0';

    wait for 10 us;
    rdreq_i <= '0';
    reset_i <= '0';

    wait for 10 us;
    rdreq_i <= '1';
    reset_i <= '0';

    wait;
    
  end process;  

end logic;  
