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

entity fmc_rx_data_checker is
  port
    (FMC_COMMON_CLK : in std_logic;
     INPUT_DATA_PIX     : in std_logic_vector(width_of_decoded_word-1 downto 0);
     INPUT_DATA_SCT     : in std_logic_vector(width_of_decoded_word-1 downto 0);
              
     INPUT_VALID_PIX    : in std_logic;
     INPUT_VALID_SCT    : in std_logic;  
     RESET          : in std_logic;
     COMPARE_OK     : out std_logic
     );
end fmc_rx_data_checker;

architecture logic of fmc_rx_data_checker is
  
  signal data_pix : std_logic_vector(width_of_decoded_word-1 downto 0);
  signal data_sct : std_logic_vector(width_of_decoded_word-1 downto 0);
  signal data_pix_v : std_logic;
  signal data_sct_v : std_logic;

  signal start : std_logic;
  signal global_count_buf : std_logic_vector(31 downto 0);
  signal error_count_buf : std_logic_vector(31 downto 0);
  signal correct_count_buf : std_logic_vector(31 downto 0);
  signal output_buf_i  : std_logic:='0';
  signal reset_i : std_logic;
   
  --attribute mark_debug : string; 
  --attribute mark_debug of correct_count_buf  : signal is "true";
  --attribute mark_debug of global_count_buf  : signal is "true";
  --attribute mark_debug of data_pix  : signal is "true";
  --attribute mark_debug of data_sct  : signal is "true";
  --attribute mark_debug of start : signal is "true";
  --attribute mark_debug of data_pix_v : signal is "true";
  --attribute mark_debug of data_sct_v : signal is "true";
  --attribute mark_debug of output_buf_i : signal is "true";

begin
    
    COMPARE_OK <= output_buf_i;
    reset_i <= RESET;
    data_pix_v <= INPUT_VALID_PIX;
    data_sct_v <= INPUT_VALID_SCT;
    
    process(FMC_COMMON_CLK, RESET)
    begin
        -- <reset>
        if RESET='1' then
            data_pix      <= (others => '0');
            data_sct      <= (others => '0');
            start     <= '0';
            global_count_buf      <= (others => '0');
        else
            -- <reg, global couneter & start>
            if rising_edge(FMC_COMMON_CLK) then
              --if (INPUT_VALID_PIX='1' and INPUT_VALID_SCT = '1') then
              global_count_buf    <= global_count_buf + 1;
              data_pix         <= INPUT_DATA_PIX;
              data_sct         <= INPUT_DATA_SCT;      
              if (global_count_buf(0)='1')then
                     start <= '1';
              end if;
              -- end if;
            end if; --rising
        end if; --reset
    end process;

    -- <error/correct counter>

    process(FMC_COMMON_CLK, RESET)
    begin
        if RESET='1' then
            correct_count_buf         <= (others => '0'); 
            error_count_buf           <= (others => '0');
            output_buf_i  <= '0';
         else
            if rising_edge(FMC_COMMON_CLK) then
                --if(start='1' and INPUT_VALID_PIX='1' AND INPUT_VALID_SCT ='1') then
                if(start='1') then
                    if (global_count_buf >= x"01312d00") then -- start counting after 0.1 s. 
                        if (data_pix=x"aaaaaaaa" AND data_sct = x"aaaaaaaa") then
                            correct_count_buf <= correct_count_buf + 1;
                        else
                            error_count_buf <= error_count_buf + 1;
                        end if;
                    end if;
                end if; --start
            end if; --rising
        end if; --reset
        
        if (correct_count_buf = x"17d78400") then
            if (error_count_buf = x"00000000" AND correct_count_buf >= x"10000000") then
                output_buf_i  <= '1';
            end if;
        end if;       
    end process;
  
end logic;
