--------------------------------------------------------------------------------
--
--   FileName:         i2c_master.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 32-bit Version 11.1 Build 173 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 11/1/2012 Scott Larson
--     Initial Public Release
--   Version 2.0 13.Nov.2015 Tomoya Iizawa/Yoshimasa Kawaguchi
--     IM-DF Block Transfer
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY i2c_master IS
  GENERIC(
    input_clk : INTEGER := 125e6); --input clock speed from user logic in Hz
  PORT(
    clk       : IN     STD_LOGIC;                     --system clock
    reset     : IN     STD_LOGIC;                     --active low reset
    ena       : IN     STD_LOGIC;                     --latch in command
    addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0);  --address of target slave
    rw        : IN     STD_LOGIC;                     --'0' is write, '1' is read
    data_wr   : IN     STD_LOGIC_VECTOR(31 DOWNTO 0); --data to write to slave --Yoshi
    busy      : OUT    STD_LOGIC;                     --indicates transaction in progress
    data_rd   : OUT    STD_LOGIC_VECTOR(31 DOWNTO 0); --data read from slave --Yoshi
    ack_error : BUFFER STD_LOGIC;                     --flag if improper acknowledge from slave
    sda       : INOUT  STD_LOGIC;                     --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC;                     --serial clock output of i2c bus
    i2c_wen   : out    STD_LOGIC;                     --test for enable to write DF spy --Yoshi
    loop_words : in    STD_LOGIC_VECTOR(31 downto 0)  --# of loop words from SW --Yoshi
    );
END i2c_master;

ARCHITECTURE logic OF i2c_master IS
  constant bus_clk  : INTEGER := 4e5;   --speed the i2c bus (scl) will run at in Hz
  
  CONSTANT divider  :  INTEGER := (input_clk/bus_clk)/4; --number of clocks in 1/4 cycle of scl
  TYPE machine IS(ready, start, command, slv_ack1, wr, rd, slv_ack2, mstr_ack, stop, pre_ready); --needed states
  SIGNAL state     :  machine;                          --state machine
  SIGNAL data_clk  :  STD_LOGIC;                        --clock edges for sda
  SIGNAL scl_clk   :  STD_LOGIC;                        --constantly running internal scl
  SIGNAL scl_ena   :  STD_LOGIC := '0';                 --enables internal scl to output
  SIGNAL sda_int   :  STD_LOGIC := '1';                 --internal sda
  SIGNAL sda_ena_n :  STD_LOGIC;                        --enables internal sda to output
  SIGNAL addr_rw   :  STD_LOGIC_VECTOR(7 DOWNTO 0);     --latched in address and read/write
  SIGNAL data_tx   :  STD_LOGIC_VECTOR(7 DOWNTO 0);     --latched in data to write to slave
  SIGNAL data_rx   :  STD_LOGIC_VECTOR(7 DOWNTO 0);     --data received from slave
  SIGNAL bit_cnt   :  INTEGER RANGE 0 TO 7 := 7;        --tracks bit number in transaction
  SIGNAL stretch   :  STD_LOGIC := '0';                 --identifies if slave is stretching scl
  signal read_counter   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');  --Yoshi
  signal wait_counter   : STD_LOGIC_VECTOR( 1 downto 0) := "00";             --Yoshi
  signal word_counter   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');  --Yoshi
  signal write_counter  : STD_LOGIC_VECTOR( 3 downto 0) := (others => '0');  --Yoshi
  SIGNAL tmp_data_rd    : STD_LOGIC_VECTOR(31 DOWNTO 0);  -- data going to data_rd --tomoya
  
  signal sda_i : std_logic;
  signal scl_i : std_logic;
  
BEGIN
  
  sda_i <= '0' when sda = '0' else '1';
  scl_i <= '0' when scl = '0' else '1';
  
  --generate the timing for the bus clock (scl_clk) and the data clock (data_clk)
  PROCESS(clk, reset)
    VARIABLE count : INTEGER RANGE 0 TO divider*4; --timing for clock generation
  BEGIN
    IF(reset = '1') THEN                 --reset asserted
      stretch <= '0';
      count := 0;
    ELSIF(clk'EVENT AND clk = '1') THEN
      IF(count = divider*4-1) THEN       --end of timing cycle
        count := 0;                      --reset timer
      ELSIF(stretch = '0') THEN          --clock stretching from slave not detected
        count := count + 1;              --continue clock generation timing
      END IF;
      
      if (0 <= count) and (count < divider) then --first 1/4 cycle of clocking
        scl_clk <= '0';
        data_clk <= '0';
      elsif ( divider <= count) and (count < divider*2) then --second 1/4 cycle of clocking
        scl_clk <= '0';
        data_clk <= '1';
      elsif ( divider*2 <= count) and (count < divider*3-1) then --third 1/4 cycle of clocking
        scl_clk <= '1';                  --release scl
        if(scl_i = '0') THEN             --detect if slave is stretching clock
          stretch <= '1';
        ELSE
          stretch <= '0';
        END IF;
        data_clk <= '1';
      else --last 1/4 cycle of clocking
        scl_clk <= '1';
        data_clk <= '0';
      end if;
    END IF;
  END PROCESS;
  
  --state machine and writing to sda during scl low (data_clk rising edge)
  PROCESS(data_clk, reset)
  BEGIN
    IF(reset = '1') then                    --reset asserted
      state <= ready;                       --return to initial state
      busy <= '1';                          --indicate not available
      scl_ena <= '0';                       --sets scl high impedance
      sda_int <= '1';                       --sets sda high impedance
      bit_cnt <= 7;                         --restarts data bit counter
      data_rd <= (others => '0');           --clear data read port
      read_counter <= (others => '0');      --Yoshi
      wait_counter <= "00";                 --Yoshi
      i2c_wen <= '0';                       --Yoshi
      word_counter <= (others => '0');      --Yoshi
      -- tmp_data_rd <= (others => '0');    --tomoya
      -- write_counter <= (others => '0');  --Yoshi
    ELSIF(data_clk'EVENT AND data_clk = '1') THEN
      CASE state IS
        WHEN ready =>                       --idle state
          IF(ena = '1') THEN                --transaction requested
            busy <= '1';                    --flag busy
            addr_rw <= addr & rw;           --collect requested slave address and command
            data_tx <= data_wr(7 downto 0); --collect requested data to write --Yoshi
            state <= start;                 --go to start bit
            i2c_wen <= '0';                 --Yoshi
            --Yoshi changed below--
          ELSIF(x"0000" < word_counter and word_counter < loop_words)then --count for "loop_words" times
            busy <= '1';                    --flag busy
            addr_rw <= addr & rw;           --collect requested slave address and command
            state <= start;                 --go to start bit
            i2c_wen <= '0';                 --Yoshi
          ELSIF(word_counter = loop_words)then
            word_counter <= (others => '0');
            state <= ready;                 --remain idle
            --Yoshi changed above--
          ELSE                              --remain idle
            busy <= '0';                    --unflag busy
            state <= ready;                 --remain idle
          END IF;
        WHEN start =>                       --start bit of transaction
          busy <= '1';                      --resume busy if continuous mode
          scl_ena <= '1';                   --enable scl output
          sda_int <= addr_rw(bit_cnt);      --set first address bit to bus
          state <= command;                 --go to command
        WHEN command =>                     --address and command byte of transaction
          IF(bit_cnt = 0) THEN              --command transmit finished
            sda_int <= '1';                 --release sda for slave acknowledge
            bit_cnt <= 7;                   --reset bit counter for "byte" states
            state <= slv_ack1;              --go to slave acknowledge (command)
          ELSE                              --next clock cycle of command state
            bit_cnt <= bit_cnt - 1;         --keep track of transaction bits
            sda_int <= addr_rw(bit_cnt-1);  --write address/command bit to bus
            state <= command;               --continue with command
          END IF;
        WHEN slv_ack1 =>                    --slave acknowledge bit (command)
          IF(addr_rw(0) = '0') THEN         --write command
            sda_int <= data_tx(bit_cnt);    --write first bit of data
            state <= wr;                    --go to write byte
          ELSE                              --read command
            sda_int <= '1';                 --release sda from incoming data
            state <= rd;                    --go to read byte
            write_counter <= x"0";          --Yoshi
          END IF;
        WHEN wr =>                          --write byte of transaction
          busy <= '1';                      --resume busy if continuous mode
          IF(bit_cnt = 0) THEN              --write byte transmit finished
            sda_int <= '1';                 --release sda for slave acknowledge
            bit_cnt <= 7;                   --reset bit counter for "byte" states
            --Yoshi changed below--
            if(write_counter = x"4")then        --Int addr: 4th 8bits
              write_counter <= x"0";
              state <= slv_ack2;
            elsif(write_counter = x"0")then     --Global addr: 8bits
              write_counter <= x"1";
              state <= slv_ack2;
            else
              state <= slv_ack1;
              write_counter <= write_counter + 1;
              if(write_counter = x"1")then      --Int addr: 1st 8bits
                data_tx <= data_wr(15 downto 8);
              elsif(write_counter = x"2")then   --Int addr: 2nd 8bits
                data_tx <= data_wr(23 downto 16);
              elsif(write_counter = x"3")then   --Int addr: 3rd 8bits
                data_tx <= data_wr(31 downto 24);
              end if;
            end if;
            --Yoshi changed above--
          ELSE                              --next clock cycle of write state
            bit_cnt <= bit_cnt - 1;         --keep track of transaction bits
            sda_int <= data_tx(bit_cnt-1);  --write next bit to bus
            state <= wr;                    --continue writing
          END IF;

          --Yoshi changed below--
        WHEN rd =>                          --read byte of transaction
          busy <= '1';                      --resume busy if continuous mode
          IF(bit_cnt = 0) THEN              --read byte receive finished
            bit_cnt <= 7;                   --reset bit counter for "byte" states
            if(read_counter = x"3")then     --go to mstr_ack state
              read_counter <= (others => '0');
              state   <= mstr_ack;                    --go to master acknowledge
              sda_int <= '1';                         --end transaction (not acknowledge is required)
              tmp_data_rd(31 downto 24) <= data_rx;   --output received data --tomoya
            else
              if(read_counter = x"0")then
                tmp_data_rd(7 downto 0) <= data_rx;   --output received data --tomoya
              elsif(read_counter = x"1")then
                tmp_data_rd(15 downto 8) <= data_rx;  --output received data --tomoya
              elsif(read_counter = x"2")then
                tmp_data_rd(23 downto 16) <= data_rx; --output received data --tomoya
              end if;
              state <= rd;
              sda_int <= '0';
              read_counter <= read_counter + 1;
              wait_counter <= "01";
            end if;  
          ELSE                              --next clock cycle of read state
            sda_int <= '1';                 --release sda from incoming data
            if(wait_counter = "01")then     --wait ack to IM
              wait_counter <= "00";
            else
              bit_cnt <= bit_cnt - 1;       --keep track of transaction bits
              state <= rd;                  --continue reading
            end if;
          END IF;
          --Yoshi changed above--
        WHEN slv_ack2 =>                        --slave acknowledge bit (write)
          scl_ena <= '0';                       --disable scl
          state <= stop;                        --go to stop bit
        WHEN mstr_ack =>                        --master acknowledge bit after a read
          --==========================================================
          -- go to stop state immediately 
          -- (modification to force the continuous transaction disabled)
          --==========================================================
          data_rd <= tmp_data_rd;               --output received data --tomoya
          scl_ena <= '0';                       --disable scl
          state <= stop;                        --go to stop bit
          i2c_wen <= '1';                       --enable to write data to buffer --Yoshi
          word_counter <= word_counter + 1;     --count # of word --Yoshi
        WHEN stop =>                            --stop bit of transaction          
          state <= pre_ready;                   --go to ready state
          i2c_wen <= '0';                       --stop writing to buffer --Yoshi
        when pre_ready =>
          --==========================================================
          -- go back to ready state only if ena gets disabled
          -- (modification to force the continuous transaction disabled)
          --==========================================================
          sda_int <= '1';                       --sets sda high impedance
          if (ena = '0') then
            busy <= '0';                        --unflag busy
            state <= ready;                     --go to ready state
          end if;          
      END CASE;    
    END IF;
    
    --reading from sda during scl high (falling edge of data_clk)
    IF(reset = '1') THEN                 --reset asserted
      ack_error <= '0';
    ELSIF(data_clk'EVENT AND data_clk = '0') THEN
      CASE state IS
        WHEN start =>                           --starting new transaction
          ack_error <= '0';                     --reset acknowledge error flag
        WHEN slv_ack1 =>                        --receiving slave acknowledge (command)
          ack_error <= sda_i OR ack_error;      --set error output if no-acknowledge
        WHEN rd =>                              --receiving slave data
          if(wait_counter = "00")then           --after waiting ack to IM --Yoshi
            data_rx(bit_cnt) <= sda_i;          --receive current slave data bit
          end if;
        WHEN slv_ack2 =>                        --receiving slave acknowledge (write)
          ack_error <= sda_i OR ack_error;      --set error output if no-acknowledge
        WHEN OTHERS =>
          NULL;
      END CASE;
    END IF;
    
  END PROCESS;  
  
  --set sda output
  WITH state SELECT
    sda_ena_n <=  data_clk WHEN start,  --generate start condition
    not data_clk WHEN stop,             --generate start condition
    sda_int WHEN OTHERS;                --set to internal sda signal    
  
  --set scl and sda outputs
  scl <=  'Z' WHEN (scl_ena = '1' and scl_clk = '1') ELSE
          '0' WHEN (scl_ena = '1' and scl_clk = '0') ELSE
          'Z';
  sda <= '0' WHEN sda_ena_n = '0' ELSE 'Z';
  
END logic;
