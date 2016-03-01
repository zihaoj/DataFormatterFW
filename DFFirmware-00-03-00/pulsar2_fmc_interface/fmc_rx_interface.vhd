------------------------------------------------------------------------------
-- PulsarII
------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library work;
use work.FmcConstants.all;

entity fmc_rx_interface is
  generic
    ( FMC_ID     : integer ; --FB1/2/3/4
      FPGA_ID    : integer ; --FPGA0/1
      common_clk_frequency : real
      );
  port
    (
      -- READOUT CLOCK
      FMC_COMMON_CLK : in std_logic;
      
      -- SCT LINK DATA OUT (synchronized to FMC_COMMON_CLK)
      SCT_DATA_OUT  : out std_logic_vector(width_of_decoded_word-1 downto 0);
      SCT_CTRL_OUT  : out std_logic;
      SCT_DEN_OUT   : out std_logic;
      -- PIX LINK DATA OUT (synchronized to FMC_COMMON_CLK)
      PIX_DATA_OUT  : out std_logic_vector(width_of_decoded_word-1 downto 0);
      PIX_CTRL_OUT  : out std_logic;
      PIX_DEN_OUT   : out std_logic;      
      
      -- FMC IN
      FMCIN_LVDS_DATA_IN_P : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      FMCIN_LVDS_DATA_IN_N : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      FMCIN_CLK_P : in std_logic;
      FMCIN_CLK_N : in std_logic;
      
      -- intermediated data (for monitoring purpose)
      -- syncronized with FMC COMMON CLK
      MONITOR_FRONT_DATA_OUT : out std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      
      -- CONFIGURE
      CONFIG_CHANNELDELAY_DIR : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      CONFIG_CHANNELDELAY_CE  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      CONFIG_DELAY_RESET      : in  std_logic;
      --CONFIG_CLOCK_RESET      : in  std_logic;
      CONFIG_FIFO_RESET   : in  std_logic;
      CONFIG_FIFO_FULL    : out std_logic;
      CONFIG_FIFO_ERROR   : out std_logic;
      
      CONFIG_CLK_INV      : in std_logic;
      CONFIG_CLKDELAY_DIR : in std_logic;
      CONFIG_CLKDELAY_CE  : in std_logic;
      CONFIG_ENABLE_CLOCKPHASE_AUTOADJUST : in std_logic;
      
      -- FRAME RESET
      CONFIG_FRAME_SCT_RESET  : in  std_logic;
      CONFIG_FRAME_PIX_RESET  : in  std_logic;
      -- CONFIG CLOCK SLPI RESET
      CONFIG_CLOCK_SYNC_RESET : in  std_logic;
      -- MONITOR SYNC
      CONFIG_SYNC_DONE : out std_logic;
      CONFIG_SYNC_ERROR : out std_logic;
      CONFIG_PAT_COMPARE_OK : out std_logic     
      );
end fmc_rx_interface;

-- ##########################################
architecture logic of fmc_rx_interface is
  
  -- ##########################################
  component fmc_rx_front
    generic
      ( FMC_ID     : integer := FMC_ID; --FB1/2/3/4
        FPGA_ID    : integer := FPGA_ID; --FPGA0/1
        common_clk_frequency : real := common_clk_frequency);
    port
      ( -- FMC COMMON CLOCK
        FMC_COMMON_CLK : in std_logic;
        -- FMC IN
        FMCIN_LVDS_DATA_IN_P : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
        FMCIN_LVDS_DATA_IN_N : in std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
        FMCIN_CLK_P : in std_logic;
        FMCIN_CLK_N : in std_logic;
        -- CONFIGURE
        CONFIG_CLKDELAY_DIR : in std_logic;
        CONFIG_CLKDELAY_CE  : in std_logic;
        CONFIG_CLK_INV      : in std_logic;
        CONFIG_CHANNELDELAY_DIR : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
        CONFIG_CHANNELDELAY_CE  : in  std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
        CONFIG_DELAY_RESET      : in  std_logic;
        -- FIFO clock domain boundary between Regional Clock / FMC common clock
        CONFIG_FIFO_RESET  : in  std_logic;
        CONFIG_FIFO_FULL   : out std_logic;
        CONFIG_FIFO_ERROR  : out std_logic; 
        -- FRONT TO MAPPER - sync to FMC_COMMON_CLK
        FRONT_TO_MAPPER_DOUT : out std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0) := (others => '0')
        );
  end component;


  -- ##########################################  
  --component fmc_rx_parity
  --  port
  --    ( 
  --      FMC_COMMON_CLK : in std_logic;
  --      RESET : in std_logic;
  --      DIN   : in std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
        -- configuration
  --      CONFIG_CLK_INV        : out std_logic;
  --      CONFIG_CLKDELAY_DIR   : out std_logic;
  --      CONFIG_CLKDELAY_CE    : out std_logic;
        -- monitoring
  --     CONFIG_SYNC_DONE      : out std_logic;
  --     CONFIG_SYNC_ERROR     : out std_logic
  --    );
  --end component;

    -- ##########################################  

  -- deleted for P1 tests
  --component fmc_rx_data_checker
  --  port
  --    (
  --      FMC_COMMON_CLK : in std_logic;
  --      RESET : in std_logic;
  --     DIN   : in std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
  --      COMPARE_OK     : out std_logic;
  --      -- configuration
  --      CONFIG_CLK_INV        : out std_logic;
  --      CONFIG_CLKDELAY_DIR   : out std_logic;
  --      CONFIG_CLKDELAY_CE    : out std_logic;
  --      -- monitoring
  --      CONFIG_SYNC_DONE  : out std_logic;
  --      CONFIG_SYNC_ERROR : out std_logic
  --    );
  --end component;

  -- ##########################################
  component fmc_rx_mapper_fpga_to_detword is
    port (
      FRONT_TO_MAPPER_DIN      : in  std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      MAPPER_TO_FRAME_SCT_DATA : out std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
      MAPPER_TO_FRAME_SCT_CTRL : out std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
      MAPPER_TO_FRAME_PIX_DATA : out std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
      MAPPER_TO_FRAME_PIX_CTRL : out std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0)
      );
  end component;
  
  -- ##########################################
  component fmc_rx_frame
    port
      (-- COMMON CLOCK
        FMC_COMMON_CLK : in std_logic;
        -- DATA FROM FIFO
        MAPPER_TO_FRAME_DATA : in std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
        MAPPER_TO_FRAME_CTRL : in std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
        -- State Machine Reset
        RESET  : in std_logic;
        -- LINK DATA OUT
        DATA_OUT  : out std_logic_vector(width_of_decoded_word-1 downto 0);
        CTRL_OUT  : out std_logic;
        DEN_OUT   : out std_logic
        );
  end component;
  
  -- ##########################################
  signal front_to_mapper_data_i    : std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
  
  signal mapper_to_sct_frame_data_i : std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
  signal mapper_to_sct_frame_ctrl_i : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
  signal mapper_to_pix_frame_data_i : std_logic_vector(data_width_in_each_clockcycle-1 downto 0);
  signal mapper_to_pix_frame_ctrl_i : std_logic_vector(ctrl_width_in_each_clockcycle-1 downto 0);
  
  signal config_clk_inv_i : std_logic;
  signal config_clkdelay_dir_i : std_logic;
  signal config_clkdelay_ce_i  : std_logic;

  signal auto_config_clk_inv_i : std_logic;
  signal auto_config_clkdelay_dir_i : std_logic;
  signal auto_config_clkdelay_ce_i  : std_logic;  
  
begin

  process (FMC_COMMON_CLK)
  begin
    if (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
      if (CONFIG_ENABLE_CLOCKPHASE_AUTOADJUST='0') then
        config_clk_inv_i      <= CONFIG_CLK_INV;
        config_clkdelay_dir_i <= CONFIG_CLKDELAY_DIR;
        config_clkdelay_ce_i  <= CONFIG_CLKDELAY_CE;
      else
        config_clk_inv_i      <= auto_config_clk_inv_i;
        config_clkdelay_dir_i <= auto_config_clkdelay_dir_i;
        config_clkdelay_ce_i  <= auto_config_clkdelay_ce_i;
      end if;
    end if;
  end process;
  
  -- ##########################################################################################################
  FRONT: fmc_rx_front
    port map (
      FMC_COMMON_CLK => FMC_COMMON_CLK, 
      -- FMC IN
      FMCIN_LVDS_DATA_IN_P => FMCIN_LVDS_DATA_IN_P,
      FMCIN_LVDS_DATA_IN_N => FMCIN_LVDS_DATA_IN_N,
      FMCIN_CLK_P => FMCIN_CLK_P,
      FMCIN_CLK_N => FMCIN_CLK_N,
      -- CONFIGURE
      CONFIG_CLKDELAY_DIR => config_clkdelay_dir_i,
      CONFIG_CLKDELAY_CE => config_clkdelay_ce_i,
      CONFIG_CLK_INV => config_clk_inv_i,
      CONFIG_CHANNELDELAY_DIR => CONFIG_CHANNELDELAY_DIR,
      CONFIG_CHANNELDELAY_CE => CONFIG_CHANNELDELAY_CE,
      CONFIG_DELAY_RESET => CONFIG_DELAY_RESET,
      CONFIG_FIFO_RESET => CONFIG_FIFO_RESET,
      CONFIG_FIFO_FULL => CONFIG_FIFO_FULL,
      CONFIG_FIFO_ERROR => CONFIG_FIFO_ERROR,
      -- FRONT TO MAPPER - sync to FMC_COMMON_CLK
      FRONT_TO_MAPPER_DOUT => front_to_mapper_data_i
      );    
  MONITOR_FRONT_DATA_OUT <= front_to_mapper_data_i;

    
    -- ##########################################################################################################  
  --PAT_CHECKER : fmc_rx_data_checker
  --  port map ( 
  --    FMC_COMMON_CLK => FMC_COMMON_CLK,
  --    RESET => CONFIG_CLOCK_SYNC_RESET,
  --    DIN => front_to_mapper_data_i,
      
      -- configuration
  --    CONFIG_CLK_INV => auto_config_clk_inv_i,
  --    CONFIG_CLKDELAY_DIR => auto_config_clkdelay_dir_i,
  --    CONFIG_CLKDELAY_CE => auto_config_clkdelay_ce_i,

      -- monitoring
  --    CONFIG_SYNC_DONE => CONFIG_SYNC_DONE,
  --    CONFIG_SYNC_ERROR => CONFIG_SYNC_ERROR,
  --    COMPARE_OK=>CONFIG_PAT_COMPARE_OK
  --        );

  -- ##########################################################################################################  
--  PARITY : fmc_rx_parity
--    port map ( 
--      FMC_COMMON_CLK => FMC_COMMON_CLK,
--      RESET => CONFIG_CLOCK_SYNC_RESET,
--      DIN => front_to_mapper_data_i,
--      -- configuration
--      CONFIG_CLK_INV => auto_config_clk_inv_i,
--      CONFIG_CLKDELAY_DIR => auto_config_clkdelay_dir_i,
--      CONFIG_CLKDELAY_CE => auto_config_clkdelay_ce_i,
--      -- monitoring
--      CONFIG_SYNC_DONE => CONFIG_SYNC_DONE,
--      CONFIG_SYNC_ERROR => CONFIG_SYNC_ERROR
--      );
  
  -- ##########################################################################################################
  MAPPER : fmc_rx_mapper_fpga_to_detword
    port map (
      FRONT_TO_MAPPER_DIN => front_to_mapper_data_i,
      MAPPER_TO_FRAME_SCT_DATA => mapper_to_sct_frame_data_i,
      MAPPER_TO_FRAME_SCT_CTRL => mapper_to_sct_frame_ctrl_i,
      MAPPER_TO_FRAME_PIX_DATA => mapper_to_pix_frame_data_i,
      MAPPER_TO_FRAME_PIX_CTRL => mapper_to_pix_frame_ctrl_i
      );
  
  -- ##########################################################################################################  
  SCT_FRAME : fmc_rx_frame
    port map (
      FMC_COMMON_CLK => FMC_COMMON_CLK,
      -- DATA FROM MAPPER
      MAPPER_TO_FRAME_DATA => mapper_to_sct_frame_data_i,
      MAPPER_TO_FRAME_CTRL => mapper_to_sct_frame_ctrl_i,
      -- State Machine Reset
      RESET => CONFIG_FRAME_SCT_RESET,
      -- LINK DATA OUT
      DATA_OUT => SCT_DATA_OUT, 
      CTRL_OUT => SCT_CTRL_OUT,
      DEN_OUT  => SCT_DEN_OUT
      );
  
  -- ##########################################################################################################  
  PIX_FRAME : fmc_rx_frame
    port map (
      FMC_COMMON_CLK => FMC_COMMON_CLK,
      -- DATA FROM MAPPER
      MAPPER_TO_FRAME_DATA => mapper_to_pix_frame_data_i,
      MAPPER_TO_FRAME_CTRL => mapper_to_pix_frame_ctrl_i,
      -- State Machine Reset
      RESET => CONFIG_FRAME_PIX_RESET,
      -- LINK DATA OUT
      DATA_OUT  => PIX_DATA_OUT, 
      CTRL_OUT  => PIX_CTRL_OUT,
      DEN_OUT   => PIX_DEN_OUT
      );    
  
end logic;
