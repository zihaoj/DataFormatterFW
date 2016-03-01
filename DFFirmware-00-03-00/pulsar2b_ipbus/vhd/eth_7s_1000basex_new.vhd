-- Contains the instantiation of the Xilinx MAC & 1000baseX pcs/pma & GTP transceiver cores
--
-- Do not change signal names in here without correspondig alteration to the timing contraints file
--
-- Dave Newbold, April 2011
--
-- $Id$

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.VComponents.all;
use work.emac_hostbus_decl.all;

entity eth_7s_1000basex is
	port(
		gt_clkp, gt_clkn: in std_logic;
		gt_txp, gt_txn: out std_logic;
		gt_rxp, gt_rxn: in std_logic;
		sig_detn: in std_logic := '1';
		clk125_out: out std_logic;
-- KH
		clk31_25_out: out std_logic;                
-- KH
		clk125_fr: out std_logic;
		rsti: in std_logic;
		locked: out std_logic;
		tx_data: in std_logic_vector(7 downto 0);
		tx_valid: in std_logic;
		tx_last: in std_logic;
		tx_error: in std_logic;
		tx_ready: out std_logic;
		rx_data: out std_logic_vector(7 downto 0);
		rx_valid: out std_logic;
		rx_last: out std_logic;
		rx_error: out std_logic;
		hostbus_in: in emac_hostbus_in := ('0', "00", "0000000000", X"00000000", '0', '0', '0');
		hostbus_out: out emac_hostbus_out;
		  --KH, tried AN, didn't work
                autoneg_status : out std_logic;
                autoneg_restart: in std_logic;
		link_status: out std_logic_vector(15 downto 0);
                -- KH
                eth_mmcm_locked: out std_logic;
                eth_phy_done: out std_logic;
                gt_pll_lock: out std_logic;
                gt_tx_reset: out std_logic;
                gt_rx_reset: out std_logic;
                gt_tx_resetdone: out std_logic;
                gt_rx_resetdone: out std_logic;
                gt_tx_resetint: out std_logic; 
                gt_rx_resetint: out std_logic;
                gt_rx_resetcounter: out std_logic_vector(7 downto 0);
                my_txp: out std_logic;
                my_txn: out std_logic;
                my_rxp: out std_logic;
                my_rxn: out std_logic;
                my_gmii_rxd: out std_logic_vector(7 downto 0);
                clk200: in std_logic;
                drpclk: in std_logic;
                kh_encommaalign      : out std_logic;
                kh_rxchariscomma     : out std_logic;
                kh_rxcharisk         : out std_logic;
                kh_rxclkcorcnt       : out std_logic_vector( 2 downto 0);
                kh_rxdata            : out std_logic_vector( 7 downto 0);
                kh_rxrundisp         : out std_logic;
                kh_rxbuferr          : out std_logic;
                kh_txbuferr          : out std_logic                      
	);

end eth_7s_1000basex;

architecture rtl of eth_7s_1000basex is
    
    --COMPONENT tri_mode_eth_mac_v5_5
	--COMPONENT tri_mode_ethernet_mac_v8_2 --MT
	COMPONENT tri_mode_ethernet_mac_0 --KH
		PORT (
			glbl_rstn : IN STD_LOGIC;
			rx_axi_rstn : IN STD_LOGIC;
			tx_axi_rstn : IN STD_LOGIC;
			
			--KH
			--rx_axi_clk : IN STD_LOGIC; 
			--rx_reset_out : OUT STD_LOGIC;
			--tx_axi_clk : IN STD_LOGIC;
            --tx_reset_out : OUT STD_LOGIC;
			--speed_is_100 : OUT STD_LOGIC;
            --speed_is_10_100 : OUT STD_LOGIC;
			gtx_clk : IN STD_LOGIC;
			rx_reset : OUT STD_LOGIC;
            tx_reset : OUT STD_LOGIC;
			speedis100 : OUT STD_LOGIC;
            speedis10100 : OUT STD_LOGIC;			
			rx_configuration_vector : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
            tx_configuration_vector : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
			-- end KH
			
			
			rx_axis_mac_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			rx_axis_mac_tvalid : OUT STD_LOGIC;
			rx_axis_mac_tlast : OUT STD_LOGIC;
			rx_axis_mac_tuser : OUT STD_LOGIC;
			rx_statistics_vector : OUT STD_LOGIC_VECTOR(27 DOWNTO 0);
			rx_statistics_valid : OUT STD_LOGIC;

			tx_axis_mac_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			tx_axis_mac_tvalid : IN STD_LOGIC;
			tx_axis_mac_tlast : IN STD_LOGIC;
			tx_axis_mac_tuser : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			tx_axis_mac_tready : OUT STD_LOGIC;
			tx_ifg_delay : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			tx_statistics_vector : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			tx_statistics_valid : OUT STD_LOGIC;
			pause_req : IN STD_LOGIC;
			pause_val : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

			gmii_txd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			gmii_tx_en : OUT STD_LOGIC;
			gmii_tx_er : OUT STD_LOGIC;
			gmii_rxd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			gmii_rx_dv : IN STD_LOGIC;
			gmii_rx_er : IN STD_LOGIC

		);
	END COMPONENT;

	signal gmii_txd, gmii_rxd: std_logic_vector(7 downto 0);
	signal gmii_tx_en, gmii_tx_er, gmii_rx_dv, gmii_rx_er: std_logic;
	signal gmii_rx_clk: std_logic;
	signal clkin, clk125, txoutclk_ub, txoutclk, clk125_ub, clk_fr: std_logic;
	signal clk62_5_ub, clk62_5, clkfb: std_logic;
	signal rstn, phy_done, mmcm_locked, locked_int, sig_det: std_logic;
	signal status: std_logic_vector(15 downto 0);
-- KH
        signal my_gt_pll_lock, my_tx_reset_out, my_rx_reset_out : std_logic;
        signal my_tx_resetdone, my_rx_resetdone, my_tx_resetint, my_rx_resetint : std_logic;
        signal my_rx_resetcounter : std_logic_vector(7 downto 0);
	signal clk31_25_ub, clk31_25: std_logic;
	signal confvect : std_logic_vector(4 downto 0); --MT
	signal sigdet : std_logic;
	signal anadvconfigvec : std_logic_vector(15 downto 0);
	signal linktimervalue : std_logic_vector(8 downto 0);
	signal gt0txpmaresetin : STD_LOGIC;
    signal gt0txpcsresetin : STD_LOGIC;
    signal gt0rxpmaresetin : STD_LOGIC;
    signal gt0rxpcsresetin : STD_LOGIC;
    signal gt0rxbufresetin : STD_LOGIC;
    signal gt0drpaddrin : STD_LOGIC_VECTOR ( 8 downto 0 );
    signal gt0drpdiin : STD_LOGIC_VECTOR ( 15 downto 0 );
    signal gt0drpdoout : STD_LOGIC_VECTOR ( 15 downto 0 );
    signal gt0drpenin : STD_LOGIC;
    signal gt0drprdyout : STD_LOGIC;
    signal gt0drpwein : STD_LOGIC;
    signal gt0txpolarityin : STD_LOGIC;
    signal gt0rxpolarityin : STD_LOGIC;
    --MT for debugginh
    signal gt0txdiffctrlin : std_logic_vector(3 downto 0); 
    signal gt0txpostcursorin       : std_logic_vector(4 downto 0);
    signal gt0txprecursorin        : std_logic_vector(4 downto 0);
    signal gt0txinhibitin         :std_logic;
    
    signal gt0rxdfelpmresetin      : std_logic;
    signal gt0rxdfeagcovrdenin     : std_logic;
    signal gt0rxlpmenin            : std_logic;
    signal gt0txprbsselin          : std_logic_vector(2 downto 0);
    signal gt0txprbsforceerrin     : std_logic;
    signal gt0rxprbscntresetin     : std_logic;
    signal gt0rxprbserrout         : std_logic;
    signal gt0rxprbsselin          : std_logic_vector(2 downto 0);
    signal gt0loopbackin           : std_logic_vector(2 downto 0);
    
    signal gt0eyescanresetin       : std_logic;
    signal gt0eyescantriggerin     : std_logic;
    signal gt0rxcdrholdin          : std_logic;
    signal gt0rxmonitorselin       : std_logic_vector(1 downto 0);
    signal gt0qplloutclkin      :   std_logic;
    signal gt0qplloutrefclkin   :   std_logic;
    signal gt0rxchariscommaout1   :   std_logic;
    signal gt0rxchariskout1   :   std_logic;
      
begin

	confvect <= "10000"; --MT	
	sigdet <= '1';
	anadvconfigvec <= "0000110000100000";
	linktimervalue <= "111001100";
	gt0txpmaresetin <= '0';
	gt0txpcsresetin <= '0';
	gt0rxpmaresetin <= '0';
	gt0rxpcsresetin <= '0';
	gt0rxbufresetin <= '0';
	gt0drpaddrin <= "000000000";
	gt0drpdiin <= "0000000000000000";
	gt0drpdoout <= "0000000000000000";
	gt0drpenin <= '0';
	gt0drprdyout <= '0';
	gt0drpwein <= '0';
	gt0txpolarityin <= '0';
        gt0rxpolarityin <= '0';
        --gt0txdiffctrlin <= "0000"; --MT correct?
        gt0txdiffctrlin <= "0011"; --V_PPD=0.407
	gt0txpostcursorin <= "00000"; --MT correct? 
	gt0txprecursorin <= "00000"; --MT correct?
	gt0rxdfelpmresetin <= '0';
        gt0txinhibitin <= '0';
    gt0rxdfeagcovrdenin <= '0';
    gt0rxlpmenin <= '0';
    gt0txprbsselin <= "000";
    gt0txprbsforceerrin <= '0';
    gt0rxprbscntresetin <= '0';
    gt0rxprbserrout <= '0';
    gt0rxprbsselin <= "000";
    gt0loopbackin <= "000";
    gt0eyescanresetin <= '0';
    gt0eyescantriggerin <= '0';
    gt0rxcdrholdin <= '0';
    gt0rxmonitorselin <= "00";
    gt0qplloutclkin <= '0';
    gt0qplloutrefclkin <= '0';
    gt0rxchariscommaout1 <= '1'; --MT I don't think the value matters
    gt0rxchariskout1 <= '1'; --MT I don't think the value matters
	
	
	ibuf0: IBUFDS_GTE2 port map(
		i => gt_clkp,
		ib => gt_clkn,
		o => clkin,
		ceb => '0'
	);
	
	bufg_fr: BUFG port map(
		i => clkin,
		o => clk_fr
	);
	
	clk125_fr <= clk_fr;

	bufg_tx: BUFG port map(
		i => txoutclk_ub,
		o => txoutclk
	);

	mcmm: MMCME2_BASE
		generic map(
			CLKIN1_PERIOD => 16.0,
			CLKFBOUT_MULT_F => 16.0,
			CLKOUT1_DIVIDE => 16,
			CLKOUT2_DIVIDE => 8,
                        CLKOUT3_DIVIDE => 32)
		port map(
			clkin1 => txoutclk,
			clkout1 => clk62_5_ub,
			clkout2 => clk125_ub,
			clkout3 => clk31_25_ub,                        
			clkfbout => clkfb,
			clkfbin => clkfb,
			rst => rsti,
			pwrdwn => '0',
			locked => mmcm_locked);

        
	bufg_125: BUFG port map(
		i => clk125_ub,
		o => clk125);

	clk125_out <= clk125;

	bufg_62_5: BUFG port map(
		i => clk62_5_ub,
		o => clk62_5);

	bufg_31_25: BUFG port map(
		i => clk31_25_ub,
		o => clk31_25);        

      clk31_25_out <= clk31_25;
        
	process(clk_fr)
	begin
		if rising_edge(clk_fr) then
			locked_int <= mmcm_locked and phy_done;
		end if;
	end process;

	locked <= locked_int;
	rstn <= not (not locked_int or rsti);

	--mac: tri_mode_ethernet_mac_v5_5 --MT
	--mac: tri_mode_ethernet_mac_v8_2 --KH, trying _0
		mac: tri_mode_ethernet_mac_0
		port map(
			glbl_rstn => rstn,
			rx_axi_rstn => '1', --MT was '1'
			tx_axi_rstn => '1', --MT was '1'
--KH 
			--rx_axi_clk => clk125,
			--rx_reset_out => open,
			--tx_axi_clk => clk125,
            --tx_reset_out => open,
			--speed_is_100 => open,
            --speed_is_10_100 => open,			
			gtx_clk => clk125,
            rx_reset => open,
            tx_reset => open,
           	speedis100 => open,
            speedis10100 => open,
			rx_configuration_vector => std_logic_vector' (X"0000_0000_0000_0000_0812"), --MT X"0000_0000_0000_0000_0812"
            tx_configuration_vector => std_logic_vector' (X"0000_0000_0000_0000_0012"), --MT X"0000_0000_0000_0000_0012"            
-- end KH

			rx_axis_mac_tdata => rx_data,
			rx_axis_mac_tvalid => rx_valid,
			rx_axis_mac_tlast => rx_last,
			rx_axis_mac_tuser => rx_error,
			rx_statistics_vector => open,
			rx_statistics_valid => open,
			tx_axis_mac_tdata => tx_data,
			tx_axis_mac_tvalid => tx_valid,
			tx_axis_mac_tlast => tx_last,
			tx_axis_mac_tuser(0) => tx_error,
			tx_axis_mac_tready => tx_ready,
			tx_ifg_delay => std_logic_vector' (X"00"), --MT X"00"
			tx_statistics_vector => open,
			tx_statistics_valid => open,
			pause_req => '0', --MT '0'
			pause_val => std_logic_vector' (X"0000"), --MT X"0000"
			gmii_txd => gmii_txd,
			gmii_tx_en => gmii_tx_en,
			gmii_tx_er => gmii_tx_er,
			gmii_rxd => gmii_rxd,
			gmii_rx_dv => gmii_rx_dv,
			gmii_rx_er => gmii_rx_er
		);

	hostbus_out.hostrddata <= (others => '0');
	hostbus_out.hostmiimrdy <= '0';

	sig_det <= not sig_detn;
-- KH
        my_gmii_rxd <= gmii_rxd;
        
	--phy: entity work.gig_eth_pcs_pma_v11_5_block --MT
	phy: entity work.gig_ethernet_pcs_pma_1
		port map(
			--drpaddr_in => (others => '0'),
			--drpclk_in => clk125,
			--drpdi_in => (others => '0'),
			--drpdo_out => open,
			--drpen_in => '0',
			--drprdy_out => open,
			--drpwe_in => '0',
			gtrefclk => clkin,
			gtrefclk_bufg => clkin,
			txp => gt_txp,
			txn => gt_txn,
			rxp => gt_rxp,
			rxn => gt_rxn,
			txoutclk => txoutclk_ub,
			resetdone => phy_done,
			mmcm_locked => mmcm_locked,
			userclk => clk62_5,
			userclk2 => clk125,
-- KH
--			independent_clock_bufg => clk_fr,
			independent_clock_bufg => clk200,
			rxuserclk => clk200,
            rxuserclk2 => clk200,
			pma_reset => rsti,
			gmii_txd => gmii_txd,
			gmii_tx_en => gmii_tx_en,
			gmii_tx_er => gmii_tx_er,
			gmii_rxd => gmii_rxd,
			gmii_rx_dv => gmii_rx_dv,
			gmii_rx_er => gmii_rx_er,
			gmii_isolate => open,
--			configuration_vector => "00000", --dist
-- KH core loopback, tried, works
--			configuration_vector => "00010",
-- KH , AN enable			
			--configuration_vector => "10000",  --MT
            configuration_vector =>	confvect, 		
			status_vector => status,
			reset => rsti,
--			signal_detect => sig_det,
			--signal_detect => '1', --MT
			signal_detect => sigdet,
			-- KH
			--                       5432109876543210                                     
			--an_adv_config_vector => "0000110000100000", --MT
			an_adv_config_vector => anadvconfigvec,
--			link_timer_value => "100111101",
			--link_timer_value => "111001100", -- 460 dec -> ~15ms --MT
			--link_timer_value => linktimervalue, --MT
			an_interrupt => autoneg_status,
			an_restart_config => autoneg_restart,
-- MT
            gt0_txpmareset_in => gt0txpmaresetin,
            gt0_txpcsreset_in => gt0txpcsresetin,
            gt0_rxpmareset_in => gt0rxpmaresetin,
            gt0_rxpcsreset_in => gt0rxpcsresetin,
            gt0_rxbufreset_in => gt0rxbufresetin,
            
                        --pll_lock => my_gt_pll_lock, --MT
             --           tx_reset_out => my_tx_reset_out,
              --          rx_reset_out => my_rx_reset_out,        
              --          tx_resetdone => my_tx_resetdone,
--                        rx_resetdone => my_rx_resetdone,
--                        tx_resetint => my_tx_resetint,
--                        rx_resetint => my_rx_resetint,
--                        rx_resetcounter => my_rx_resetcounter,
--                        my_txp => my_txp,
--                        my_txn => my_txn,
--                        my_rxp => my_rxp,
--                        my_rxn => my_rxn,
                        gt0_rxbyteisaligned_out => kh_encommaalign,
                        gt0_rxchariscomma_out(0) => kh_rxchariscomma,
                        gt0_rxchariscomma_out(1) => gt0rxchariscommaout1,
                        gt0_rxcharisk_out(0) => kh_rxcharisk,
                        gt0_rxcharisk_out(1) => gt0rxchariskout1,
--                        kh_rxclkcorcnt       => kh_rxclkcorcnt      ,
--                        kh_rxdata            => kh_rxdata           ,
--                        kh_rxrundisp         => kh_rxrundisp        ,
--                        kh_rxbuferr           => kh_rxbuferr          ,
--                        kh_txbuferr => kh_txbuferr        
 gt0_drpaddr_in => gt0drpaddrin,
   gt0_drpclk_in => drpclk,
   gt0_drpdi_in => gt0drpdiin,
   --gt0_drpdo_out => gt0drpdoout,
   gt0_drpen_in => gt0drpenin,
   --gt0_drprdy_out => gt0drprdyout,
   gt0_drpwe_in  => gt0drpwein ,
   gt0_txpolarity_in => gt0txpolarityin,
   gt0_rxpolarity_in => gt0rxpolarityin,
   gt0_txdiffctrl_in =>  gt0txdiffctrlin,
   gt0_txpostcursor_in =>  gt0txpostcursorin,
   gt0_txprecursor_in  => gt0txprecursorin,
   gt0_txinhibit_in => gt0txinhibitin,
   
   
   gt0_rxdfelpmreset_in => gt0rxdfelpmresetin,
       
        gt0_rxdfeagcovrden_in  => gt0rxdfeagcovrdenin,    
        gt0_rxlpmen_in  =>  gt0rxlpmenin,         
        gt0_txprbssel_in   => gt0txprbsselin,       
        gt0_txprbsforceerr_in   => gt0txprbsforceerrin,  
        gt0_rxprbscntreset_in   =>  gt0rxprbscntresetin, 
        --gt0_rxprbserr_out     => gt0_rxprbserr_out,   
        gt0_rxprbssel_in     => gt0rxprbsselin,     
   gt0_loopback_in         =>  gt0loopbackin,
   
   gt0_eyescanreset_in    =>   gt0eyescanresetin,
         gt0_eyescantrigger_in =>  gt0eyescantriggerin,  
         gt0_rxcdrhold_in        => gt0rxcdrholdin,
         gt0_rxmonitorsel_in     => gt0rxmonitorselin,
   
   
         gt0_qplloutclk_in => gt0qplloutclkin,
         gt0_qplloutrefclk_in => gt0qplloutrefclkin
   
   
                        );
 -- KH 
        link_status <= status;
        eth_mmcm_locked <= mmcm_locked;
        eth_phy_done <= phy_done;
        --MT
        gt_pll_lock <= my_gt_pll_lock;
        gt_tx_reset <= my_tx_reset_out;
        gt_rx_reset <= my_rx_reset_out;
        gt_tx_resetdone <= my_tx_resetdone;
        gt_rx_resetdone <= my_rx_resetdone;
        gt_tx_resetint <= my_tx_resetint;
        gt_rx_resetint <= my_rx_resetint;
        gt_rx_resetcounter <= my_rx_resetcounter;
        

end rtl;
