------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity testbench is
end testbench;

library work;
use work.FmcConstants.all;

architecture logic of testbench is
  
  component fmc_input_buffer
    port
      ( -- PORT A
        FMC_CLK_IN : in std_logic; -- WRITE CLOCK
        FMC_DATA_IN    : in std_logic_vector(width_of_decoded_word-1 downto 0);
        FMC_CTRL_IN    : in std_logic;
        FMC_DEN_IN     : in std_logic;
        
        -- PORT B
        MAIN_CLK : in  std_logic; -- READ CLOCK
        DATA_OUT : out std_logic_vector(width_of_decoded_word-1 downto 0);
        CTRL_OUT : out std_logic;
        DEN_OUT  : out std_logic;
        FIFO_GO_NEXT_IF_EXIST_IN : in  std_logic;
        
        -- FLOW CONTROL
        RESET         : in  std_logic;
        FIFO_FULL_OUT : out std_logic;
        FIFO_BUSY_OUT : out std_logic);
  end component;
  
  -- PORT A
  signal fmc_clk_i : std_logic := '0';
  signal fmc_data_i    : std_logic_vector(width_of_decoded_word-1 downto 0);
  signal fmc_ctrl_i    : std_logic;
  signal fmc_den_i     : std_logic;
  
  -- PORT B
  signal main_clk_i : std_logic := '0'; -- READ CLOCK
  signal data_out_i : std_logic_vector(width_of_decoded_word-1 downto 0);
  signal ctrl_out_i : std_logic;
  signal den_out_i  : std_logic;
  signal go_next_if_exist_i : std_logic;
  
  -- FLOW CONTROL
  signal reset_i     : std_logic := '0';
  signal fifo_full_i : std_logic;
  signal fifo_busy_i : std_logic;

  type data_transmitter_statys_t is (IDLE, DATA, CTRL);
  signal curr_state : data_transmitter_statys_t := IDLE;
  signal counter    : std_logic_vector(width_of_decoded_word-1 downto 0) := (others => '1');
  
begin
  
  -- clock generator
  process
  begin
    fmc_clk_i <= '0';
    wait for 10 ns;
    fmc_clk_i <= '1';
    wait for 10 ns;
  end process;
  
  process
  begin
    main_clk_i <= '0';
    wait for 15 ns;
    main_clk_i <= '1';
    wait for 15 ns;
  end process;
  
  myFifo : fmc_input_buffer
    port map
      ( -- PORT A
        FMC_CLK_IN => fmc_clk_i,
        FMC_DATA_IN => fmc_data_i,
        FMC_CTRL_IN => fmc_ctrl_i,
        FMC_DEN_IN => fmc_den_i,
        
        -- PORT B
        MAIN_CLK => main_clk_i,
        DATA_OUT => data_out_i,
        CTRL_OUT => ctrl_out_i,
        DEN_OUT  => den_out_i,
        FIFO_GO_NEXT_IF_EXIST_IN => go_next_if_exist_i,
        
        -- FLOW CONTROL
        RESET => reset_i,
        FIFO_FULL_OUT => fifo_full_i,
        FIFO_BUSY_OUT => fifo_busy_i);
  
  -- input (fmc common clock)
  process (fmc_clk_i)
  begin
    if (fmc_clk_i'event and fmc_clk_i='1') then
      if (fifo_full_i='1') then -- idle
        fmc_data_i <= (others => '0');
        fmc_ctrl_i <= '0';
        fmc_den_i  <= '0';
      else 
        case curr_state is
          when IDLE =>
            fmc_data_i <= (others => '0');
            fmc_ctrl_i <= '0';
            fmc_den_i  <= '0';
          when  DATA =>
            
            fmc_data_i <= counter;
            fmc_ctrl_i <= '0';
            fmc_den_i  <= '1';
            counter <= counter-1;
          when  CTRL =>
            fmc_data_i <= X"EE1234EE";
            fmc_ctrl_i <= '1';
            fmc_den_i  <= '1';
        end case;
      end if;
    end if;
  end process;

  -- time line (WRITE)
  process
  begin
    curr_state <= IDLE;
    
    for ii in 0 to 99
    loop
      curr_state <= DATA;
      wait for 1 us;
      
      curr_state <= CTRL;
      wait until fmc_clk_i'event and fmc_clk_i='1';
      wait until fmc_clk_i'event and fmc_clk_i='0';
      
      curr_state <= IDLE;
      wait for 3 us;
    end loop;
  end process;
 
  -- time line (READ)
  process
  begin
    go_next_if_exist_i <= '0';
    wait for 75 us;
    go_next_if_exist_i <= '1';
    wait;
  end process; 
  
  
end logic;
