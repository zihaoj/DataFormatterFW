------
-- detect the state transistion from 0 -> 1 and generate pulse signal
-- synchronized to the input reference clock
-- user will activate (to '1') a certain bit first and 
-- then will be required to disactivate (to '0') by hand
------

library ieee;
use ieee.std_logic_1164.all;

entity my_pulse_generator is
  port (
    refclk : in  std_logic;
    q      : out std_logic_vector(31 downto 0); -- to logic
    din    : in  std_logic_vector(31 downto 0);
    dout   : out std_logic_vector(31 downto 0));
end my_pulse_generator;

architecture logic of my_pulse_generator is
  type StateMachine_t is (ShootState,
                          DoneState,
                          WaitState);
  signal next_state : StateMachine_t := WaitState;
  constant disable_command : std_logic_vector(31 downto 0) := (others=>'0');
  
begin
  
  dout <= din;
  
  ----------------------------------------
  -- pulse generator controller
  ----------------------------------------
  process (refclk)
  begin 
    if (refclk'event and refclk='1') then
      if next_state = ShootState then
        q <= din;
      else
        q <= (others => '0');
      end if;
    end if;
  end process;
  
  ----------------------------------------
  -- state machine controller
  ----------------------------------------  
  process (refclk)
  begin 
    if (refclk'event and refclk='1') then
      case next_state is
        
        when WaitState => -- wait state
          if (din=disable_command) then
            next_state <= WaitState;
          else
            next_state <= ShootState;
          end if;
          
        when ShootState => -- shoot pulse in next clock cycle
          next_state <= DoneState;
          
        when DoneState =>
          if (din=disable_command) then
            next_state <= WaitState;
          else
            next_state <= DoneState;
          end if;
          
        when others =>
          next_state <= WaitState;
          
      end case;
    end if;
  end process;  
  
end logic;
