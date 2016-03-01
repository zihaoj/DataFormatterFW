------------------------------------------------------------------------------/
--   ____  ____ 
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version : 3.6
--  \   \         Application : 7 Series FPGAs Transceivers Wizard
--  /   /         Filename : gig_ethernet_pcs_pma_1_gtwizard_rxpmarst_seq.vhd
-- /___/   /\     
-- \   \  /  \ 
--  \___\/\___\
--
--
-- Module gig_ethernet_pcs_pma_1_GTWIZARD_rxpmarst_seq
-- Generated by Xilinx 7 Series FPGAs Transceivers Wizard
-- 
-- 
-- (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES. 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


ENTITY gig_ethernet_pcs_pma_1_gtwizard_rxpmarst_seq IS
  port ( 
    RST                : IN  std_logic;--Please add a synchroniser if it is not generated in DRPCLK domain.
    RXPMARESET_IN      : IN  std_logic;    
    RXPMARESETDONE     : IN  std_logic;
    RXPMARESET_OUT     : OUT std_logic;

    DRPCLK             : IN  std_logic;
    DRPADDR            : OUT std_logic_vector(8 downto 0);
    DRPDO              : IN  std_logic_vector(15 downto 0);
    DRPDI              : OUT std_logic_vector(15 downto 0);
    DRPRDY             : IN  std_logic;
    DRPEN              : OUT std_logic;
    DRPWE              : OUT std_logic;
    DRP_BUSY_IN        : IN  std_logic;
    DRP_PMA_BUSY_OUT   : OUT std_logic
);
END gig_ethernet_pcs_pma_1_gtwizard_rxpmarst_seq;

ARCHITECTURE Behavioral of gig_ethernet_pcs_pma_1_gtwizard_rxpmarst_seq is


  component gig_ethernet_pcs_pma_1_sync_block
   generic (
     INITIALISE : bit_vector(1 downto 0) := "00"
   );
   port  (
             clk           : in  std_logic;
             data_in       : in  std_logic;
             data_out      : out std_logic
          );
   end component;

   component gig_ethernet_pcs_pma_1_reset_sync
   generic (
     INITIALISE : bit_vector(1 downto 0) := "11"
   );
   port  (
             clk           : in  std_logic;
             reset_in      : in  std_logic;
             reset_out     : out std_logic
          );
   end component;

  constant DLY                : time := 1 ns;
  type state_type is (idle,
                      drp_rd,
                      wait_rd_data,
                      wr_16,
                      wait_wr_done1,
                      wait_pmareset,
                      wr_20,
                      wait_wr_done2,
                      wait_rxpmarst_low);

  signal  state               : state_type := idle;
  signal  next_state          : state_type := idle;
  signal  rst_sync            : std_logic;
  signal  rxpmareset_in_sync  : std_logic;
  signal  rxpmareset_s        : std_logic;
  signal  rxpmareset_ss       : std_logic;
  signal  rxpmaresetdone_ss   : std_logic;
  signal  rd_data             : std_logic_vector(15 downto 0);
  signal  next_rd_data        : std_logic_vector(15 downto 0);
  signal  original_rd_data        : std_logic_vector(15 downto 0);
  signal  rxpmareset_i        :std_logic;
  signal  flag        :std_logic := '0';
  signal  rxpmareset_o        :std_logic;
  signal  drpen_o             :std_logic;
  signal  drpwe_o             :std_logic;
  signal  drpaddr_o           :std_logic_vector(8 downto 0);
  signal  drpdi_o             :std_logic_vector(15 downto 0);
  signal  drp_pma_busy_i      :std_logic;

BEGIN

 sync_RXPMARESETDONE : gig_ethernet_pcs_pma_1_sync_block
  port map
         (
            clk             =>  DRPCLK,
            data_in         =>  RXPMARESETDONE,
            data_out        =>  rxpmaresetdone_ss
         );


--output assignment	
  RXPMARESET_OUT      <= rxpmareset_o;
  DRPEN               <= drpen_o;
  DRPWE               <= drpwe_o;
  DRPADDR             <= drpaddr_o;
  DRPDI               <= drpdi_o;
  DRP_PMA_BUSY_OUT    <= drp_pma_busy_i;

  sync_rxpmareset_in : gig_ethernet_pcs_pma_1_reset_sync
  generic map
         (
           INITIALISE       => "00"	 
	 )
  port map
         (
            clk             =>  DRPCLK,
            reset_in        =>  RXPMARESET_IN,
            reset_out       =>  rxpmareset_in_sync
         );

  sync_rst_sync : gig_ethernet_pcs_pma_1_reset_sync
  generic map
         (
           INITIALISE       => "00"	 
	 )
  port map
         (
            clk             =>  DRPCLK,
            reset_in        =>  RST,
            reset_out       =>  rst_sync
         );
  PROCESS (DRPCLK,rst_sync)
  BEGIN
    IF (rst_sync = '1') THEN
      state               <= idle              after DLY;
      rxpmareset_s        <= '0'               after DLY;
      rxpmareset_ss       <= '0'               after DLY;
      rd_data             <=  x"0000"          after DLY;
      rxpmareset_o        <= '0'               after DLY;
    ELSIF (DRPCLK'event and DRPCLK='1') THEN
      state               <= next_state        after DLY;
      rxpmareset_s        <= rxpmareset_in_sync after DLY;
      rxpmareset_ss       <= rxpmareset_s      after DLY;
      rd_data             <= next_rd_data      after DLY;
      rxpmareset_o        <= rxpmareset_i      after DLY;
    END IF;
  END PROCESS;


  PROCESS (rxpmareset_ss,DRPRDY,state,rxpmaresetdone_ss)
  BEGIN
    CASE state IS

      WHEN idle         =>
        IF (rxpmareset_ss='1') THEN
          next_state <= drp_rd;
        ELSE
          next_state <= idle;
	END IF;

      WHEN drp_rd       =>
	next_state<= wait_rd_data;

      WHEN wait_rd_data =>
        IF (DRPRDY='1')THEN
          next_state <= wr_16;
        ELSE
          next_state <= wait_rd_data;
        END IF;

      WHEN wr_16 => 
	next_state <= wait_wr_done1;

      WHEN wait_wr_done1 => 
	IF (DRPRDY='1') THEN
	  next_state <= wait_pmareset;
        ELSE
	  next_state <= wait_wr_done1;
        END IF;

      WHEN wait_pmareset =>
	IF (rxpmaresetdone_ss = '0') THEN
          next_state <= wr_20;
        ELSE
          next_state <= wait_pmareset;
        END IF;

      WHEN wr_20         =>
        next_state <= wait_wr_done2;

      WHEN wait_wr_done2 =>
	IF (DRPRDY='1') THEN
          next_state <= wait_rxpmarst_low;
        ELSE
          next_state <= wait_wr_done2;
	END IF;

      WHEN wait_rxpmarst_low =>
        IF (rxpmareset_ss = '0') THEN
          next_state <= idle;
        ELSE
          next_state <= wait_rxpmarst_low;
	END IF;

      WHEN others=>
          next_state <= idle;

    END CASE;
  END PROCESS;

-- drives DRP interface and RXPMARESET_OUT
  PROCESS(DRPRDY,state,rd_data,DRPDO,rxpmareset_ss,DRP_BUSY_IN,flag,original_rd_data)
  BEGIN
-- RX_DATA_WIDTH is located at addr x"0011", [13 downto 11]
-- encoding is this : /16 = x "2", /20 = x"3", /32 = x"4", /40 = x"5"
    rxpmareset_i  <= '0';
    drpaddr_o    <= '0'& x"11"; -- 000010001
    drpen_o      <= '0';
    drpwe_o      <= '0';
    drpdi_o      <= x"0000";
    next_rd_data <= rd_data;

    CASE state IS 

     --do nothing to DRP or reset
      WHEN idle   => 
         drp_pma_busy_i <= '0';

      --assert reset and issue rd
      WHEN drp_rd => 
        if(DRP_BUSY_IN = '0') then
         drp_pma_busy_i <= '1';
       	 drpen_o        <= '1';
	 drpwe_o        <= '0';
        else
         drp_pma_busy_i <= '0';
       	 drpen_o        <= '0';
	 drpwe_o        <= '0';
        end if;

      -- wait to load rd data
      WHEN wait_rd_data =>  
         drp_pma_busy_i <= '1';
         IF (DRPRDY='1' and flag = '0') THEN
            next_rd_data <= DRPDO;
          ELSIF (DRPRDY='1' and flag = '1') THEN
            next_rd_data <= original_rd_data;
          ELSE
            next_rd_data <= rd_data;
          END IF;

      -- write to 16-bit mode
      WHEN wr_16=>
        drp_pma_busy_i <= '1';
 	drpen_o    <= '1';
	drpwe_o    <= '1';
        -- Addr "00001001" [11] = '0' puts width mode in /16 or /32
       drpdi_o <= rd_data(15 downto 12) & '0' & rd_data(10 downto 0);
       
      --wait for write to 16-bit mode is complete
      WHEN wait_wr_done1=> 
        drp_pma_busy_i <= '1';

      --assert rxpmareset and wait for rxpmaresetdone to go low
      WHEN wait_pmareset => null;
        drp_pma_busy_i <= '1';
        rxpmareset_i   <= '1';

      --write to 20-bit mode
      WHEN wr_20 =>  
        drp_pma_busy_i <= '1';
        drpen_o <='1';
        drpwe_o <= '1';
        drpdi_o <= rd_data(15 downto 0); --restore user setting per prev read

      --wait to complete write to 20-bit mode
      WHEN wait_wr_done2 =>  
		   	  rxpmareset_i    <= '1';
                          drp_pma_busy_i  <= '1';

      -- wait for rxpmareset to be deasserted
      WHEN wait_rxpmarst_low =>
                           drp_pma_busy_i  <= '0';
                           if(rxpmareset_ss = '1') then
		   	      rxpmareset_i <= '1';
                           else
		   	      rxpmareset_i <= '0';
                           end if;

      WHEN others        =>

    rxpmareset_i  <= '0';
    drpaddr_o    <= '0'& x"11"; -- 000010001
    drpen_o      <= '0';
    drpwe_o      <= '0';
    drpdi_o      <= x"0000";
    next_rd_data <= rd_data;
    drp_pma_busy_i<= '0';

     END CASE;
  END PROCESS;

  process (DRPCLK)
  begin
    if (DRPCLK'event and DRPCLK='1') then

if( state = wr_16 or state = wait_pmareset or state = wr_20 or state = wait_wr_done1) then

flag <= '1';

elsif(state = wait_wr_done2) then

flag <= '0';
end if; 
end if;

end process;

  process (DRPCLK)
  begin
    if (DRPCLK'event and DRPCLK='1') then

if( state = wait_rd_data and DRPRDY ='1' and flag = '0') then

original_rd_data <= DRPDO;

end if; 
end if; 
end process;
END Behavioral;


