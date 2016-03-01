-- Top-level design for ipbus demo
--
-- You must edit this file to set the IP and MAC addresses
--
-- Dave Newbold, 16/7/12

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ipbus.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

entity top is port(
	gt_clkp, gt_clkn: in std_logic;
	gt_txp, gt_txn: out std_logic;
	gt_rxp, gt_rxn: in std_logic;
	leds: out STD_LOGIC_VECTOR(3 downto 0);
   -- KH
        sys_clk_n, sys_clk_p: in std_logic	
	);

end top;

architecture rtl of top is

	signal clk125_fr, clk125, clk100, ipb_clk, ipb_prog_clk, clk_locked, locked, eth_locked: std_logic;
	signal rst_125, rst_ipb, rst_eth, onehz: std_logic;
	signal mac_tx_data, mac_rx_data: std_logic_vector(7 downto 0);
	signal mac_tx_valid, mac_tx_last, mac_tx_error, mac_tx_ready, mac_rx_valid, mac_rx_last, mac_rx_error: std_logic;
	signal ipb_master_out : ipb_wbus;
	signal ipb_master_in : ipb_rbus;
	signal mac_addr: std_logic_vector(47 downto 0);
	signal ip_addr: std_logic_vector(31 downto 0);
	signal pkt_rx, pkt_tx, pkt_rx_led, pkt_tx_led, sys_rst: std_logic;	
   -- KH
	signal sys_clk, sys_clk_tmp, sys_clk_bufg, sysbuf_clk, clkwiz_clk, clkwiz_locked, clkwiz_rst,clkwiz_fb: std_logic;
        signal n_buf125_clk, buf125_clk, clean125_clk : std_logic;
	signal link_status: std_logic_vector(15 downto 0);
	signal autoneg_status, autoneg_restart: std_logic;
        signal vio_control                           : std_logic_vector(35 downto 0);
        signal ila_control                           : std_logic_vector(35 downto 0);        
        signal vio_in                         : std_logic_vector(7 downto 0);
        signal vio_out                          : std_logic_vector(7 downto 0);
        signal vio_out_async                          : std_logic_vector(7 downto 0); --
        --MT Mar 30
        signal mmcm_locked, phy_done, gt_pll_lock, gt_tx_reset, gt_rx_reset: std_logic;
        signal gt_tx_resetdone, gt_rx_resetdone, gt_tx_resetint, gt_rx_resetint : std_logic;
        signal gt_rx_resetcounter : std_logic_vector(7 downto 0);
        signal light_detect: std_logic;
--        signal my_gt_rxp, my_gt_rxn, my_gt_txp, my_gt_txn: std_logic;
        signal my_gt_txp, my_gt_txn, my_gt_rxp, my_gt_rxn: std_logic;                
        signal my_gt_tx, my_gt_rx : std_logic;
        signal my_gmii_rxd : std_logic_vector(7 downto 0);
        signal clko_200, clk200_bufg : std_logic;
        signal clk50_i : std_logic;

        signal kh_encommaalign, kh_rxchariscomma, kh_rxcharisk : std_logic;
        signal kh_rxclkcorcnt : std_logic_vector( 2 downto 0);
        signal kh_rxdata :  std_logic_vector( 7 downto 0);
        signal kh_rxrundisp, kh_rxbuferr, kh_txbuferr : std_logic;                      
        signal ipb_clk_tmp, clk_156_25, clkwiz_bufg : std_logic;
		  signal reg_1_q : std_logic_vector(31 downto 0);
        signal tmpvec : std_logic_vector(98 downto 0);  --MT
        signal vio_indummy : std_logic_vector(0 downto 0);  --MT
        signal vio_outdummy : std_logic_vector(0 downto 0);  --MT
        signal sigdetn : std_logic;
        signal probe0 : std_logic;
        signal probe3 : std_logic;
        signal probe4 : std_logic;
        signal probe5 : std_logic;
        signal probe13 : std_logic;
        signal probe14 : std_logic;

        component pulsar2_sysclk
          port
            (-- Clock in ports
              CLK_IN1_P         : in     std_logic;
              CLK_IN1_N         : in     std_logic;
              -- Clock out ports
              MAIN_LOGIC_CLK    : out    std_logic;
              FMC_COMMON_CLK    : out    std_logic;
              CLK50             : out    std_logic;
              -- Status and control signals
              RESET             : in     std_logic;
              LOCKED            : out    std_logic
              );
        end component;        
begin

  probe0 <= '0';
  probe3 <= '0';
  probe4 <= '0';
  probe5 <= '0';
  probe13 <= '0';
  probe14 <= '0';

  locked <= clk_locked and eth_locked;
  leds <= (reg_1_q(3), reg_1_q(2),reg_1_q(1), reg_1_q(0));
  vio_in  <= (rst_eth,rst_125,locked, eth_locked, clk_locked, clk125, sys_clk,onehz);-- Ethernet MAC core and PHY interface
  vio_out <= "10110111";
  vio_out_async <= "10110111";                    --MT Mar 30 (attach here the signal to
                                        --ipbus)
  sigdetn <= '0';  -- KH hardcode     

-- KH: no equivalent with vivado?
 -- icon: entity work.chipscope_icon
--		port map(
--			CONTROL0 => vio_control,
 --                       CONTROL1 => ila_control        
--			);
	vio_indummy <= (others => '0');		
	vio: entity work.vio_1
		port map(
            clk => sys_clk_bufg,
            probe_in0 => vio_indummy,
            probe_out0 => vio_outdummy
--			CONTROL => vio_control,
--                        SYNC_OUT => vio_out,
                        --MT Mar 30
                        --ASYNC_OUT => open,
--                        ASYNC_OUT => vio_out_async,                        
--                        ASYNC_IN => vio_in,
--                        SYNC_IN => vio_in 
                        );

  
--        	ila: entity work.chipscope_ila
                ila: entity work.ila_1                 
		port map(
			CLK => sys_clk_bufg,
                        probe0(0) => probe0,
                        probe0(1) => clk125,
                        probe0(2) => clk125_fr,
                        probe0(3) => probe3, --clkwiz_locked,
                        probe0(4) => probe4,
                        probe0(5) => probe5, --clkwiz_rst, 
                        probe0(6) => phy_done,
                        probe0(7) => rst_eth,
                        probe0(8) => mmcm_locked,
                        probe0(9) => eth_locked,
                        probe0(10) => clk_locked,
                        probe0(11) => sys_rst,
                        probe0(12) => rst_125,
                        probe0(13) => probe13,
                        probe0(14) => probe14,                        
                        --probe0(15) => gt_tx_reset,
                        --probe0(16) => gt_rx_reset,
                        --probe0(17) => gt_tx_resetdone,
                        --probe0(18) => gt_rx_resetdone,
                        --probe0(19) => gt_tx_resetint,
                        --probe0(20) => gt_rx_resetint,
                        --probe0(28 downto 21) => gt_rx_resetcounter,
                        probe0(30 downto 15) => link_status,
--                        probe0(52 downto 45) => my_gmii_rxd,
                        --probe0(52 downto 45) => kh_rxdata,
                        probe0(31) => autoneg_status,
                        probe0(32) => kh_encommaalign,
                        probe0(33) => kh_rxchariscomma,
                        probe0(34) => kh_rxcharisk,
                        --probe0(59 downto 57) => kh_rxclkcorcnt,
                        --probe0(60) => kh_rxrundisp,                                                                                                
                        --probe0(61) => kh_rxbuferr,
                        --probe0(62) => kh_txbuferr,                        
                        --probe0(63) => gt_pll_lock,
                        probe0(66 downto 35) => ipb_master_in.ipb_rdata,
                        probe0(98 downto 67) => ipb_master_out.ipb_wdata,
                        probe0(99) => ipb_clk,
			probe0(100)  => rst_ipb,
			probe0(108 downto 101) => mac_rx_data,
			probe0(109) => mac_rx_valid,
			probe0(110)  => mac_rx_last,
			probe0(111) => mac_rx_error,
			probe0(119 downto 112) => mac_tx_data,
			probe0(120) => mac_tx_valid,
			probe0(121) => mac_tx_last,
			probe0(122) => mac_tx_error,
			probe0(123) => mac_tx_ready,
			probe0(124) => pkt_rx,
			probe0(125) => pkt_tx,
			probe0(126) => pkt_rx_led,
			probe0(127) => pkt_tx_led
                        );
 
--	DCM clock generation for internal bus, ethernet

	clocks: entity work.clocks_7s_serdes
		port map(
			clki_fr => clk125_fr,
			clki_125 => clk125,
-- KH
--			clko_ipb => ipb_clk,
			clko_ipb => ipb_clk_tmp,
--
			eth_locked => eth_locked,
			locked => clk_locked,
			nuke => sys_rst,
			rsto_125 => rst_125,
			rsto_ipb => rst_ipb,
			rsto_eth => rst_eth,
			onehz => onehz,
-- KH
                        clko_200 => clko_200
		);
	





  eth: entity work.eth_7s_1000basex
		port map(
			gt_clkp => gt_clkp,
			gt_clkn => gt_clkn,
			gt_txp => gt_txp,
			gt_txn => gt_txn,
			gt_rxp => gt_rxp,
			gt_rxn => gt_rxn,
			sig_detn => sigdetn,
			clk125_out => clk125,
-- KH
                        clk31_25_out => ipb_clk,
--
			clk125_fr => clk125_fr,
-- KH
			clk200 => sys_clk_bufg,
                        drpclk => clk50_i,
-- 
			rsti => rst_eth,
			locked => eth_locked,
			tx_data => mac_tx_data,
			tx_valid => mac_tx_valid,
			tx_last => mac_tx_last,
			tx_error => mac_tx_error,
			tx_ready => mac_tx_ready,
			rx_data => mac_rx_data,
			rx_valid => mac_rx_valid,
			rx_last => mac_rx_last,
			rx_error => mac_rx_error,
			-- KH
			autoneg_status => autoneg_status,
			autoneg_restart => autoneg_restart,
			link_status => link_status,
                        eth_mmcm_locked => mmcm_locked,
                        eth_phy_done => phy_done,

                        --MT
                        gt_pll_lock => gt_pll_lock,
                        gt_tx_reset => gt_tx_reset,
                        gt_rx_reset => gt_rx_reset,
                        gt_tx_resetdone => gt_tx_resetdone,
                        gt_rx_resetdone => gt_rx_resetdone,
                        gt_tx_resetint => gt_tx_resetint,
                        gt_rx_resetint => gt_rx_resetint,
                        gt_rx_resetcounter => gt_rx_resetcounter,
                        my_txp => my_gt_txp,
                        my_txn => my_gt_txn,
                        my_rxp => my_gt_rxp,
                        my_rxn => my_gt_rxn,
                        my_gmii_rxd => my_gmii_rxd,
                        
                        kh_encommaalign => kh_encommaalign,
                        kh_rxchariscomma     => kh_rxchariscomma,
                        kh_rxcharisk         => kh_rxcharisk        ,
                        kh_rxclkcorcnt       => kh_rxclkcorcnt      ,
                        kh_rxdata            => kh_rxdata           ,
                        kh_rxrundisp         => kh_rxrundisp        ,
                        kh_rxbuferr           => kh_rxbuferr          ,
                        kh_txbuferr => kh_txbuferr
                        
                        );
	
	
-- tmp

	
-- ipbus control logic

	ipbus: entity work.ipbus_ctrl
		port map(
			mac_clk => clk125,
			rst_macclk => rst_125,
			ipb_clk => ipb_clk,
			rst_ipb => rst_ipb,
			mac_rx_data => mac_rx_data,
			mac_rx_valid => mac_rx_valid,
			mac_rx_last => mac_rx_last,
			mac_rx_error => mac_rx_error,
			mac_tx_data => mac_tx_data,
			mac_tx_valid => mac_tx_valid,
			mac_tx_last => mac_tx_last,
			mac_tx_error => mac_tx_error,
			mac_tx_ready => mac_tx_ready,
			ipb_out => ipb_master_out,
			ipb_in => ipb_master_in,
			mac_addr => mac_addr,
			ip_addr => ip_addr,
			pkt_rx => pkt_rx,
			pkt_tx => pkt_tx,
			pkt_rx_led => pkt_rx_led,
			pkt_tx_led => pkt_tx_led

		);
		
	mac_addr <= X"000a3502b47d"; -- Careful here, arbitrary addresses do not always work
	ip_addr <= X"c0a80b83"; -- 192.168.11.131

-- ipbus slaves live in the entity below, and can expose top-level ports
-- The ipbus fabric is instantiated within.

	slaves: entity work.slaves port map(
		ipb_clk => ipb_clk,
                ipb_rst => rst_ipb,
		ipb_in => ipb_master_out,
		ipb_out => ipb_master_in,
		rst_out => sys_rst,
		pkt_rx => pkt_rx,
		pkt_tx => pkt_tx,
		reg_1_q => reg_1_q
	);

  clkbuffer : pulsar2_sysclk
    port map
    (
      CLK_IN1_P=>sys_clk_p,
      CLK_IN1_N=>sys_clk_n,
      -- Clock out ports
      MAIN_LOGIC_CLK=>open,
      FMC_COMMON_CLK=>sys_clk_bufg,
      CLK50=>clk50_i,
      -- Status and control signals
      RESET=>'0',
      LOCKED=>open
      );  

  --IBUFGDS_sys : IBUFGDS
  --  port map (
  --    I  => sys_clk_p,
  --    IB => sys_clk_n,
  --    O  => sys_clk_tmp);  

  --BUFG_syspre : BUFG
  --  port map (
  --    I => sys_clk_tmp,
  --    O => sys_clk_bufg);
  
end rtl;
