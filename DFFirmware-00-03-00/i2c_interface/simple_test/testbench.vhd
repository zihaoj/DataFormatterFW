------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

entity testbench is
  generic ( clk_per_master_sysclk : time :=6.667 ns;   -- 150 MHz
            clk_per_slave_sysclk  : time :=5 ns;       -- 200 MHz
            slave_address : std_logic_vector(6 downto 0) := b"0000000");
end testbench;


architecture logic of testbench is

  component i2c_slave
    generic(
      clock_frequency: integer := 2e8;
      address: std_logic_vector(6 downto 0) := slave_address);
    port(
      clock: in std_logic;
      reset: in std_logic;
      data_out: in std_logic_vector(7 downto 0);
      data_in: out std_logic_vector(7 downto 0);
      read_mode: out boolean;
      start_detected: out boolean;
      stop_detected: out boolean;
      transfer_started: out boolean;
      data_out_requested: out boolean;
      data_in_valid: out boolean;
      sda: inout std_logic;
      scl: in std_logic);
  end component;
  
  component i2c_master
    GENERIC(
      input_clk : INTEGER := 150e6); --input clock speed from user logic in Hz
    PORT(
      clk       : IN     STD_LOGIC;                    --system clock
      reset     : IN     STD_LOGIC;                    --active low reset
      ena       : IN     STD_LOGIC;                    --latch in command
      addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
      rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
      data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
      busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
      data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
      ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
      sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
      scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
  END component;
  
  signal clock_slave_i     : std_logic;
  signal reset_slave_i     : std_logic;
  signal data_out_slave_i  : std_logic_vector(7 downto 0) := X"FC";
  signal data_in_slave_i   : std_logic_vector(7 downto 0);
  signal read_mode_slave_i : boolean;
  signal start_detected_slave_i : boolean;
  signal stop_detected_slave_i  : boolean;
  signal transfer_started_slave_i : boolean;
  signal data_out_requested_slave_i : boolean;
  signal data_in_valid_slave_i : boolean;
  signal sda: std_logic;
  signal scl: std_logic;

  signal clk_master_i       : std_logic;
  signal reset_master_i     : std_logic;
  signal ena_master_i       : std_logic;
  signal addr_master_i      : std_logic_vector(6 DOWNTO 0);
  signal rw_master_i        : std_logic;
  signal data_wr_master_i   : std_logic_vector(7 DOWNTO 0);
  signal busy_master_i      : std_logic;
  signal data_rd_master_i   : std_logic_vector(7 DOWNTO 0);
  signal ack_error_master_i : std_logic;
  
begin

  scl <= 'H'; -- simulate pull up
  sda <= 'H'; -- simulate pull up
  
  process
  begin
    clock_slave_i <= '0';
    wait for clk_per_slave_sysclk/2;
    clock_slave_i <= '1';
    wait for clk_per_slave_sysclk/2;
  end process;

  process
  begin
    clk_master_i <= '0';
    wait for clk_per_master_sysclk/2;
    clk_master_i <= '1';
    wait for clk_per_master_sysclk/2;
  end process;  

  process (clock_slave_i)
  begin
    if (clock_slave_i'event and clock_slave_i='1') then
      if (data_in_valid_slave_i) then
        data_out_slave_i <= data_in_slave_i;
      end if;
    end if;
  end process;
  
  slave : i2c_slave
    port map(
      clock => clock_slave_i,
      reset => reset_slave_i,
      data_out => data_out_slave_i,
      data_in  => data_in_slave_i,
      read_mode => read_mode_slave_i,
      start_detected => start_detected_slave_i,
      stop_detected  => stop_detected_slave_i,
      transfer_started => transfer_started_slave_i,
      data_out_requested => data_out_requested_slave_i,
      data_in_valid => data_in_valid_slave_i,
      sda => sda,
      scl => scl);
  
  master : i2c_master
    port map(
      clk => clk_master_i,
      reset => reset_master_i,
      ena => ena_master_i,
      addr => addr_master_i,
      rw => rw_master_i,
      data_wr => data_wr_master_i,
      busy => busy_master_i,
      data_rd => data_rd_master_i,
      ack_error => ack_error_master_i,
      sda => sda,
      scl => scl);

  -- timeline
  process
  begin

    
    reset_slave_i <= '0';    
    reset_master_i <= '0';
    wait for 10 us;
    reset_slave_i <= '1';
    reset_master_i <= '1';
    wait for 10 us;
    reset_slave_i <= '0';    
    reset_master_i <= '0';
    
    ena_master_i <= '0';
    addr_master_i <= (others => '0');
    rw_master_i <= '1';
    data_wr_master_i <= (others => '0');

    wait for 10 us;
    ena_master_i <= '0';
    addr_master_i <= (others => '0');
    rw_master_i <= '1';
    data_wr_master_i <= (others => '0');

    wait for 10 us;
    ena_master_i <= '0';
    addr_master_i <= "0000000";
    rw_master_i <= '1';
    data_wr_master_i <= X"00";

    --=====================================
    wait for 10 us;
    ena_master_i <= '1';
    addr_master_i <= "0000000";
    rw_master_i <= '1';
    data_wr_master_i <= X"00";
    
    wait for 100 us;
    ena_master_i <= '0';
    addr_master_i <= "0000000";
    rw_master_i <= '1';
    data_wr_master_i <= X"00";

    wait for 100 us;
    ena_master_i <= '0';
    addr_master_i <= "0000000";
    rw_master_i <= '0';
    data_wr_master_i <= X"CC";

    --=====================================    
    wait for 10 us;
    ena_master_i <= '1';
    addr_master_i <= "0000000";
    rw_master_i <= '0';
    data_wr_master_i <= X"CC";

    wait for 10 us;
    ena_master_i <= '0';
    addr_master_i <= "0000000";
    rw_master_i <= '0';
    data_wr_master_i <= X"CC";

    wait for 100 us;
    ena_master_i <= '0';
    addr_master_i <= "0000000";
    rw_master_i <= '1';
    data_wr_master_i <= X"00";

    --=====================================
    wait for 10 us;
    ena_master_i <= '1';
    addr_master_i <= "0000000";
    rw_master_i <= '1';
    data_wr_master_i <= X"00";

    wait for 10 us;
    ena_master_i <= '0';
    addr_master_i <= "0000000";
    rw_master_i <= '1';
    data_wr_master_i <= X"00";        

    wait for 100 us;
    
    wait;
  end process;
  
end logic;
