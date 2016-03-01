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

entity fmc_rx_frame is
  port
    (-- COMMON CLOCK
      FMC_COMMON_CLK : in std_logic;
      -- DATA FROM MAPPER
      MAPPER_TO_FRAME_DATA : in std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
      MAPPER_TO_FRAME_CTRL : in std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
      -- State Machine Reset
      RESET  : in std_logic;
      -- LINK DATA OUT
      DATA_OUT  : out std_logic_vector(width_of_decoded_word-1 downto 0);
      CTRL_OUT  : out std_logic;
      DEN_OUT   : out std_logic
      );
end fmc_rx_frame;

architecture logic of fmc_rx_frame is

  -- one clock cycle after input
  signal input_valid_r1 : std_logic := '0';
  signal data_r1        : std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
  signal ctrl_r1        : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
  
  -- two clock cycle after input
  signal byte_count_r2  : integer range 0 to width_of_decoded_word/data_width_in_each_clockcycle-1  := 0;
  signal input_valid_r2 : std_logic := '0';
  signal data_r2        : std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
  signal ctrl_r2        : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
  
  -- three clock cycle after input
  -- output

  attribute mark_debug : string; 
  attribute mark_debug of input_valid_r2  : signal is "true";
  
begin
  
  ------------------------------------------
  -- DFF
  ------------------------------------------
  process (FMC_COMMON_CLK)
  begin
    if (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      -- data
      data_r1 <= MAPPER_TO_FRAME_DATA;
      data_r2 <= data_r1;
      
      -- ctrl
      ctrl_r1 <= MAPPER_TO_FRAME_CTRL;
      ctrl_r2 <= ctrl_r1;

      -- input valid
      if MAPPER_TO_FRAME_CTRL=ctrl_invalid_word then
        input_valid_r1 <= '0';      
      elsif MAPPER_TO_FRAME_CTRL=ctrl_idleword  then
        input_valid_r1 <= '0';
      elsif MAPPER_TO_FRAME_CTRL=ctrl_idleword_04  then
        input_valid_r1 <= '0';
      else
        input_valid_r1 <= '1';
      end if;
      
      input_valid_r2 <= input_valid_r1;
    end if;
  end process;
  
  ------------------------------------------
  -- byte counter controller
  ------------------------------------------
  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET='1') then
      byte_count_r2 <= 0;
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      -- if input data is valid
      --if (input_valid_r2='1' and input_valid_r1='1') then
      if (input_valid_r2='1') then
        if (byte_count_r2/=3) then
          byte_count_r2 <= byte_count_r2 + 1;
        else 
          byte_count_r2 <= 0;
        end if;
      else
        -- do nothing
        NULL;
      end if;
    end if;
  end process;
  
  ------------------------------------------
  -- output data controller
  ------------------------------------------
  process (FMC_COMMON_CLK, RESET)
  begin
    if (RESET='1') then
      DATA_OUT  <= (others => '0');
      CTRL_OUT  <= '0';
      DEN_OUT    <= '0';
    elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      -- if input data is valid
      if (input_valid_r2='1') then
        -- DATA_OUT control
        DATA_OUT( (byte_count_r2+1)*data_width_in_each_clockcycle-1 downto byte_count_r2*data_width_in_each_clockcycle) <= data_r2;
        
        -- CTRL_OUT control
        if (ctrl_r2 = ctrl_first_byte_of_data or ctrl_r2 = ctrl_another_byte_of_data) then
          CTRL_OUT <= '0';
        else
          CTRL_OUT <= '1';
        end if;
        
        -- DEN_OUT control
        if (byte_count_r2/=3) then
          DEN_OUT  <= '0';
        else
          DEN_OUT  <= '1';
        end if;
      else
        CTRL_OUT  <= '0';        
        DEN_OUT    <= '0';
      end if;
    end if;
  end process;
  
end logic;
