------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.FmcConstants.all;
use work.data_formatter_constants.all;
library unisim;
use unisim.vcomponents.all;

entity df_fmc_interface is
  generic ( common_clk_frequency : real := 200.00;
            SAMPLE_SPYOUT_AT_FMCCOMMONCLK : std_logic := '0');
  port (
    MAIN_CLK       : in std_logic;
    FMC_COMMON_CLK : in std_logic;
    
    -- <FMC IO ports>
    -- <FB1>
    FB1_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB1_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB1_CLK0_P : in std_logic;
    FB1_CLK0_N : in std_logic;
    FB1_CLK1_P : in std_logic;
    FB1_CLK1_N : in std_logic;
    FB1_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB1_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB1_TX_FWD_CLK_P : out std_logic;
    FB1_TX_FWD_CLK_N : out std_logic;
    
    -- <FB2>
    FB2_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB2_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB2_CLK0_P : in std_logic;
    FB2_CLK0_N : in std_logic;
    FB2_CLK1_P : in std_logic;
    FB2_CLK1_N : in std_logic;
    FB2_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB2_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB2_TX_FWD_CLK_P : out std_logic;
    FB2_TX_FWD_CLK_N : out std_logic;
    
    -- <FB3>
    FB3_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB3_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB3_CLK0_P : in std_logic;
    FB3_CLK0_N : in std_logic;
    FB3_CLK1_P : in std_logic;
    FB3_CLK1_N : in std_logic;
    FB3_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB3_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB3_TX_FWD_CLK_P : out std_logic;
    FB3_TX_FWD_CLK_N : out std_logic;
    
    -- <FB4>
    FB4_RX_LVDS_P : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB4_RX_LVDS_N : in std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
    FB4_CLK0_P : in std_logic;
    FB4_CLK0_N : in std_logic;
    FB4_CLK1_P : in std_logic;
    FB4_CLK1_N : in std_logic;
    FB4_TX_LVDS_P : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB4_TX_LVDS_N : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
    FB4_TX_FWD_CLK_P : out std_logic;
    FB4_TX_FWD_CLK_N : out std_logic;
    
    -- <OUTPUT / FWFT FIFO running at MAIN_CLK>
    BUFFER_DATA_OUT : out DF_INPUT_DATA_ARRAY;
    BUFFER_CTRL_OUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    BUFFER_DV_OUT   : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    BUFFER_REN_IN   : in  std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    
    -- <CONFIGURATTION PARAMTER>
    -- <FOR CONFIGURATION/MONITORING FMC - INPUT>
    FMCIN_CONFIG_CHANNELDELAY_DIR : in data_type_for_imfpga_input_lanes_t;
    FMCIN_CONFIG_CHANNELDELAY_CE  : in data_type_for_imfpga_input_lanes_t;
    FMCIN_CONFIG_DELAY_RESET      : in std_logic;
    FMCIN_CONFIG_FIFO_RESET   : in  std_logic;
    FMCIN_CONFIG_FIFO_FULL    : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
    FMCIN_CONFIG_FIFO_ERROR   : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
    FMCIN_CONFIG_XOFF         : out std_logic_vector(2*num_fpga_for_each_mainfpga-1 downto 0);
    FMCIN_CONFIG_FIFO_FULL_COUNT   : out DF_INPUT_DATA_ARRAY;
    FMCIN_CONFIG_FRAME_RESET  : in  std_logic;
    FMCIN_CONFIG_CLOCK_SYNC_RESET : in  std_logic;
    FMCIN_CONFIG_SYNC_DONE  : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
    FMCIN_CONFIG_SYNC_ERROR : out std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
    FMCIN_CONFIG_CLK_INV      : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
    FMCIN_CONFIG_CLKDELAY_DIR : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
    FMCIN_CONFIG_CLKDELAY_CE  : in std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);      
    
    FMCIN_CONFIG_PATCHECK     : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); -- sync to FMC_COMMON_CLK        
    FMCIN_BUFFER_CONFIG_RESET : in  std_logic;
    FMCIN_BUFFER_CONFIG_FULL  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
    FMCIN_BUSY_THRESHOLD      : in  std_logic_vector(31 downto 0);
    FMCIN_FIFO_WR_DATA : out DF_FMC_WR_DATA_ARRAY;
    
    FMCOUT_CONFIG_SPY_FREEZE_TO_IM : in std_logic;
    
    -- <FOR SPY BUFFER MONITORING>
    FMCIN_FRONT_DATA_SPYOUT : out data_type_for_fullwidth_data_from_imfpga_t; --@FMC_COMMON_CLK
    FMCIN_RX_DATA_SPYOUT : out DF_INPUT_DATA_ARRAY; --@FMC_COMMON_CLK
    FMCIN_RX_CTRL_SPYOUT : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
    FMCIN_RX_RDY_SPYOUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
    FMCIN_RX_DEN_SPYOUT  : out std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0); --@FMC_COMMON_CLK
                                                                                       --
    -- <FOR DATA CHECKER>
    SELECTED_FMC_FPGA    : in std_logic_vector(4 downto 0)
    );
end df_fmc_interface;    

architecture logic of df_fmc_interface is
  component fmc_tx_mapper_fmc_to_fpga
    port (
      dout      : out std_logic_vector(lvds_pairs_for_tx_in_each_mezzanine-1 downto 0);
      din_fpga0 : in  std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0);
      din_fpga1 : in  std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0)
      );
  end component;
  
  component fmc_rx_mapper_fmc_to_fpga
    port (
      din        : in  std_logic_vector(lvds_pairs_for_rx_in_each_mezzanine-1 downto 0);
      dout_fpga0 : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0);
      dout_fpga1 : out std_logic_vector(lvds_pairs_for_rx_in_each_fpga-1 downto 0)
      );
  end component;  
  
  component fmc_rx_interface
    generic
      ( FMC_ID     : integer ; --FB1/2/3/4
        FPGA_ID    : integer ; --FPGA0/1
        common_clk_frequency : real := common_clk_frequency
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
        CONFIG_FRAME_PIX_RESET  : in  std_logic
        -- CONFIG CLOCK SLPI RESET
        -- CONFIG_CLOCK_SYNC_RESET : in  std_logic;
        -- MONITOR SYNC
        --CONFIG_PAT_COMPARE_OK : out std_logic;
        --CONFIG_SYNC_DONE : out std_logic;
        --CONFIG_SYNC_ERROR : out std_logic
        );
  end component;  

  component fmc_input_buffer
    port
      ( -- PORT A
        FMC_CLK_IN     : in std_logic; -- WRITE CLOCK
        FMC_DATA_IN    : in std_logic_vector(width_of_decoded_word-1 downto 0);
        FMC_CTRL_IN    : in std_logic;
        FMC_DEN_IN     : in std_logic;
        
        -- PORT B
        MAIN_CLK        : in  std_logic; -- READ CLOCK
        DATA_OUT        : out std_logic_vector(width_of_decoded_word-1 downto 0);
        CTRL_OUT        : out std_logic;
        DEN_OUT         : out std_logic;
        FIFO_GO_NEXT_IF_EXIST_IN : in  std_logic;
        
        -- FLOW CONTROL
        RESET         : in  std_logic;
        FIFO_BUSY_THRESHOLD : in std_logic_vector(31 downto 0);
        FIFO_FULL_OUT : out std_logic;
        FIFO_BUSY_OUT : out std_logic;
        FIFO_WR_DATA : out std_logic_vector(11 downto 0)
        
      );
  end component;
  
  component fmc_tx_interface
  generic
    ( FMC_ID  : integer;
      FPGA_ID : integer);
  port
    (
      -- READOUT CLOCK
      FMC_COMMON_CLK : in std_logic;
      
      -- USER Interface
      FMC_SPY_BUFFER_FREEZE_IN : in std_logic := '0';
      FMC_SCT_BUSY_IN          : in std_logic := '0';
      FMC_PIX_BUSY_IN          : in std_logic := '0';
      --
      FMCOUT_LVDS_DATA_OUT_P : out std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0);
      FMCOUT_LVDS_DATA_OUT_N : out std_logic_vector(lvds_pairs_for_tx_in_each_fpga-1 downto 0)      
      );
  end component;
  
  component fmc_tx_clockforward is
    generic
      ( FMC_ID  : integer);  
    port
      (
        -- READOUT CLOCK
        FMC_COMMON_CLK : in std_logic;
        --
        FMCOUT_LVDS_CLOCKFORWARD_OUT_P : out std_logic;
        FMCOUT_LVDS_CLOCKFORWARD_OUT_N : out std_logic);
  end component;

  -- test for unifying the checker
  component fmc_rx_data_checker
    port
      (
        FMC_COMMON_CLK : in std_logic;
        RESET : in std_logic;
        DIN   : in std_logic_vector(2*lvds_pairs_for_rx_in_each_fpga-1 downto 0);
        COMPARE_OK     : out std_logic
      );
  end component;

  -- <the recieved data bit grouped into IM FPGAs (IM0-FPGA0/IM0-FPGA1/IM1-FPGA0/IM1-FPGA1)>
  signal fmcin_lvds_data_in_p_i : data_type_for_imfpga_input_lanes_t;
  signal fmcin_lvds_data_in_n_i : data_type_for_imfpga_input_lanes_t;
  signal fmcin_clk_p_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  signal fmcin_clk_n_i : std_logic_vector(num_fpga_for_each_mainfpga-1 downto 0);
  
  -- <the recieved data bit grouped into FMC (IM0-FPGA0/IM0-FPGA1/IM1-FPGA0/IM1-FPGA1)>
  signal fmcout_lvds_data_out_p_i : data_type_for_imfpga_output_lanes_tx_t;
  signal fmcout_lvds_data_out_n_i : data_type_for_imfpga_output_lanes_tx_t;
  signal fmcout_lvds_clockforward_out_p_i : std_logic_vector(num_fmc_per_mainfpga-1 downto 0);
  signal fmcout_lvds_clockforward_out_n_i : std_logic_vector(num_fmc_per_mainfpga-1 downto 0);

  signal fmcin_monitor_front_data_out_i : data_type_for_fullwidth_data_from_imfpga_t;
  
  signal fmc_rx_ctrl_out_i : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal fmc_rx_den_out_i  : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '0');
  signal fmc_rx_data_out_i : DF_INPUT_DATA_ARRAY;
  signal fmc_rx_fifo_full_count_i : DF_INPUT_DATA_ARRAY;
  
  signal buffer_data_out_i : DF_INPUT_DATA_ARRAY;
  signal buffer_ctrl_out_i : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  signal buffer_dv_out_i   : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0);
  
  signal input_buffer_fifo_busy_i : std_logic_vector(NUMBER_OF_FMC_INPUT_LANES-1 downto 0) := (others => '0');
  signal input_buffer_wr_data_i : DF_FMC_WR_DATA_ARRAY := (others=> (others =>'0'));
  
  signal spybuffer_freeze_signal_to_im_i : std_logic;

  -- <for data checker>
  signal selected_fmc_fpga_i : std_logic_vector(4 downto 0);

  attribute mark_debug : string; 
  attribute mark_debug of selected_fmc_fpga_i  : signal is "true";

begin

  selected_fmc_fpga_i <= SELECTED_FMC_FPGA;

  -- should be "or"ed 
  spybuffer_freeze_signal_to_im_i <= FMCOUT_CONFIG_SPY_FREEZE_TO_IM;

  ---------------------------------------------------------------------------------------------------------
  --- idelay control
  ---------------------------------------------------------------------------------------------------------
  idelaycontrol : IDELAYCTRL
    port map (RDY => open, REFCLK => FMC_COMMON_CLK, RST => '0');

  ---------------------------------------------------------------------------------------------------------
  -- LVDS RX input assignment
  ---------------------------------------------------------------------------------------------------------
  -- input assignment (FB1)
  input_mapper_fb1_p : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB1_RX_LVDS_P, dout_fpga0=>fmcin_lvds_data_in_p_i(0), dout_fpga1=>fmcin_lvds_data_in_p_i(1));
  input_mapper_fb1_n : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB1_RX_LVDS_N, dout_fpga0=>fmcin_lvds_data_in_n_i(0), dout_fpga1=>fmcin_lvds_data_in_n_i(1));

  -- input assignment (FB2)  
  input_mapper_fb2_p : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB2_RX_LVDS_P, dout_fpga0=>fmcin_lvds_data_in_p_i(2), dout_fpga1=>fmcin_lvds_data_in_p_i(3));
  input_mapper_fb2_n : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB2_RX_LVDS_N, dout_fpga0=>fmcin_lvds_data_in_n_i(2), dout_fpga1=>fmcin_lvds_data_in_n_i(3));

  -- input assignment (FB3)
  input_mapper_fb3_p : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB3_RX_LVDS_P, dout_fpga0=>fmcin_lvds_data_in_p_i(4), dout_fpga1=>fmcin_lvds_data_in_p_i(5));
  input_mapper_fb3_n : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB3_RX_LVDS_N, dout_fpga0=>fmcin_lvds_data_in_n_i(4), dout_fpga1=>fmcin_lvds_data_in_n_i(5));

  -- input assignment (FB4)
  input_mapper_fb4_p : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB4_RX_LVDS_P, dout_fpga0=>fmcin_lvds_data_in_p_i(6), dout_fpga1=>fmcin_lvds_data_in_p_i(7));
  input_mapper_fb4_n : fmc_rx_mapper_fmc_to_fpga
    port map (din=>FB4_RX_LVDS_N, dout_fpga0=>fmcin_lvds_data_in_n_i(6), dout_fpga1=>fmcin_lvds_data_in_n_i(7));  

  ---------------------------------------------------------------------------------------------------------
  -- FORWARDED CLOCK input assignment FROM IM to DF
  --------------------------------------------------------------------------------------------------------- 
  fmcin_clk_p_i(0)<=FB1_CLK0_P; fmcin_clk_n_i(0)<=FB1_CLK0_N;
  fmcin_clk_p_i(1)<=FB1_CLK1_P; fmcin_clk_n_i(1)<=FB1_CLK1_N;
  fmcin_clk_p_i(2)<=FB2_CLK0_P; fmcin_clk_n_i(2)<=FB2_CLK0_N;
  fmcin_clk_p_i(3)<=FB2_CLK1_P; fmcin_clk_n_i(3)<=FB2_CLK1_N;
  fmcin_clk_p_i(4)<=FB3_CLK0_P; fmcin_clk_n_i(4)<=FB3_CLK0_N;
  fmcin_clk_p_i(5)<=FB3_CLK1_P; fmcin_clk_n_i(5)<=FB3_CLK1_N;
  fmcin_clk_p_i(6)<=FB4_CLK0_P; fmcin_clk_n_i(6)<=FB4_CLK0_N;
  fmcin_clk_p_i(7)<=FB4_CLK1_P; fmcin_clk_n_i(7)<=FB4_CLK1_N;

  ---------------------------------------------------------------------------------------------------------
  -- LVDS TX output assignment
  ---------------------------------------------------------------------------------------------------------
  -- input assignment (FB1)
  fmc_output_mapper_fb1_p : fmc_tx_mapper_fmc_to_fpga
    port map (dout=>FB1_TX_LVDS_P, din_fpga0=>fmcout_lvds_data_out_p_i(0), din_fpga1=>fmcout_lvds_data_out_p_i(1));
  fmc_output_mapper_fb1_n : fmc_tx_mapper_fmc_to_fpga
    port map (dout=>FB1_TX_LVDS_N, din_fpga0=>fmcout_lvds_data_out_n_i(0), din_fpga1=>fmcout_lvds_data_out_n_i(1));

  -- input assignment (FB2)  
  fmc_output_mapper_fb2_p : fmc_tx_mapper_fmc_to_fpga
    port map (dout=>FB2_TX_LVDS_P, din_fpga0=>fmcout_lvds_data_out_p_i(2), din_fpga1=>fmcout_lvds_data_out_p_i(3));
  fmc_output_mapper_fb2_n : fmc_tx_mapper_fmc_to_fpga
    port map (dout=>FB2_TX_LVDS_N, din_fpga0=>fmcout_lvds_data_out_n_i(2), din_fpga1=>fmcout_lvds_data_out_n_i(3));

  -- input assignment (FB3)  
  fmc_output_mapper_fb3_p : fmc_tx_mapper_fmc_to_fpga
    port map (dout=>FB3_TX_LVDS_P, din_fpga0=>fmcout_lvds_data_out_p_i(4), din_fpga1=>fmcout_lvds_data_out_p_i(5));
  fmc_output_mapper_fb3_n : fmc_tx_mapper_fmc_to_fpga
    port map (dout=>FB3_TX_LVDS_N, din_fpga0=>fmcout_lvds_data_out_n_i(4), din_fpga1=>fmcout_lvds_data_out_n_i(5));
  
  -- input assignment (FB4)  
  fmc_output_mapper_fb4_p : fmc_tx_mapper_fmc_to_fpga
    port map (dout=>FB4_TX_LVDS_P, din_fpga0=>fmcout_lvds_data_out_p_i(6), din_fpga1=>fmcout_lvds_data_out_p_i(7));
  fmc_output_mapper_fb4_n : fmc_tx_mapper_fmc_to_fpga
    port map (dout=>FB4_TX_LVDS_N, din_fpga0=>fmcout_lvds_data_out_n_i(6), din_fpga1=>fmcout_lvds_data_out_n_i(7));      
  ---------------------------------------------------------------------------------------------------------  
  
  
  CLOCK_FORWARDING_MODULES : for iFMC in 0 to num_fmc_per_mainfpga-1 generate
    constant FMC_ID : integer := iFMC+1;
  begin
    ClockForwardingModule : fmc_tx_clockforward
      generic map ( FMC_ID =>FMC_ID )
      port map
      ( FMC_COMMON_CLK => FMC_COMMON_CLK,
        FMCOUT_LVDS_CLOCKFORWARD_OUT_P=>fmcout_lvds_clockforward_out_p_i(iFMC),
        FMCOUT_LVDS_CLOCKFORWARD_OUT_N=>fmcout_lvds_clockforward_out_n_i(iFMC));
  end generate;

  ---------------------------------------------------------------------------------------------------------
  -- FORWARDED CLOCK input assignment FROM DF to IM
  ---------------------------------------------------------------------------------------------------------   
  FB1_TX_FWD_CLK_P<=fmcout_lvds_clockforward_out_p_i(0);
  FB1_TX_FWD_CLK_N<=fmcout_lvds_clockforward_out_n_i(0);
  
  FB2_TX_FWD_CLK_P<=fmcout_lvds_clockforward_out_p_i(1);
  FB2_TX_FWD_CLK_N<=fmcout_lvds_clockforward_out_n_i(1);

  FB3_TX_FWD_CLK_P<=fmcout_lvds_clockforward_out_p_i(2);
  FB3_TX_FWD_CLK_N<=fmcout_lvds_clockforward_out_n_i(2);
  
  FB4_TX_FWD_CLK_P<=fmcout_lvds_clockforward_out_p_i(3);
  FB4_TX_FWD_CLK_N<=fmcout_lvds_clockforward_out_n_i(3);
  
  ---------------------------------------------------------------------------------------------------------
  -- FOR INPUT/OUTPUT LANES FROM INPUT MEZZANINE
  ---------------------------------------------------------------------------------------------------------  
  FMC_LANES : for iFpga in 0 to num_fpga_for_each_mainfpga-1 generate
    constant iFpga_inBoard : integer := iFpga;
    constant FMC_ID  : integer := (iFpga_inBoard - (iFpga_inBoard mod 2))/2+1;
    constant FPGA_ID : integer := iFpga_inBoard mod 2;
    constant CHANNEL0_LANE_ID : integer := iFpga*2;     -- originally SCT
    constant CHANNEL1_LANE_ID : integer := iFpga*2 + 1; -- originally PIX
    
  begin
    
    FMCIN : fmc_rx_interface
      generic map (FMC_ID=>FMC_ID, FPGA_ID=>FPGA_ID)
      port map (FMC_COMMON_CLK => FMC_COMMON_CLK,
                -- <channel 0 (originally SCT) output>
                SCT_DATA_OUT => fmc_rx_data_out_i(CHANNEL0_LANE_ID),
                SCT_CTRL_OUT => fmc_rx_ctrl_out_i(CHANNEL0_LANE_ID),
                SCT_DEN_OUT  => fmc_rx_den_out_i(CHANNEL0_LANE_ID),
                -- <channel 1 (originally PIX) output>
                PIX_DATA_OUT => fmc_rx_data_out_i(CHANNEL1_LANE_ID),
                PIX_CTRL_OUT => fmc_rx_ctrl_out_i(CHANNEL1_LANE_ID),
                PIX_DEN_OUT  => fmc_rx_den_out_i(CHANNEL1_LANE_ID),
                -- <input from IO ports>
                FMCIN_LVDS_DATA_IN_P => fmcin_lvds_data_in_p_i(iFpga),
                FMCIN_LVDS_DATA_IN_N => fmcin_lvds_data_in_n_i(iFpga),
                FMCIN_CLK_P => fmcin_clk_p_i(iFpga),
                FMCIN_CLK_N => fmcin_clk_n_i(iFpga),
                
                MONITOR_FRONT_DATA_OUT => fmcin_monitor_front_data_out_i(iFpga),
                
                CONFIG_CHANNELDELAY_DIR => FMCIN_CONFIG_CHANNELDELAY_DIR(iFpga),
                CONFIG_CHANNELDELAY_CE => FMCIN_CONFIG_CHANNELDELAY_CE(iFpga),
                CONFIG_DELAY_RESET => FMCIN_CONFIG_DELAY_RESET,
                CONFIG_FIFO_RESET => FMCIN_CONFIG_FIFO_RESET,
                CONFIG_FIFO_FULL => FMCIN_CONFIG_FIFO_FULL(iFpga),
                CONFIG_FIFO_ERROR => FMCIN_CONFIG_FIFO_ERROR(iFpga),
                CONFIG_FRAME_SCT_RESET => FMCIN_CONFIG_FRAME_RESET,
                CONFIG_FRAME_PIX_RESET => FMCIN_CONFIG_FRAME_RESET,
                --CONFIG_CLOCK_SYNC_RESET => FMCIN_CONFIG_CLOCK_SYNC_RESET,
                --CONFIG_PAT_COMPARE_OK     => FMCIN_CONFIG_SYNC_DONE(iFpga),

                --CONFIG_SYNC_DONE => FMCIN_CONFIG_SYNC_DONE(iFpga),
                --CONFIG_SYNC_ERROR => FMCIN_CONFIG_SYNC_ERROR(iFpga),
                
                CONFIG_CLK_INV => FMCIN_CONFIG_CLK_INV(iFpga),
                CONFIG_CLKDELAY_DIR => FMCIN_CONFIG_CLKDELAY_DIR(iFpga),
                CONFIG_CLKDELAY_CE => FMCIN_CONFIG_CLKDELAY_CE(iFpga),
                CONFIG_ENABLE_CLOCKPHASE_AUTOADJUST => '0' -- NEVER USED
                );

    process (FMC_COMMON_CLK) -- DFF for SPYing purpose
    begin
      if (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
        FMCIN_FRONT_DATA_SPYOUT(iFpga) <= fmcin_monitor_front_data_out_i(iFpga);
      end if;
    end process;

    -- DFF for SPYing purpose    
    CASE_SPYSAMPLING_WITH_FMC_CLOCK : if SAMPLE_SPYOUT_AT_FMCCOMMONCLK = '1' generate
      process (FMC_COMMON_CLK, FMCIN_CONFIG_FRAME_RESET)
      begin
        if (FMCIN_CONFIG_FRAME_RESET='1') then
          FMCIN_RX_DATA_SPYOUT(CHANNEL0_LANE_ID) <= (others => '0');
          FMCIN_RX_CTRL_SPYOUT(CHANNEL0_LANE_ID) <= '0';
          FMCIN_RX_RDY_SPYOUT(CHANNEL0_LANE_ID)  <= '0';
          FMCIN_RX_DEN_SPYOUT(CHANNEL0_LANE_ID)  <= '0';
          FMCIN_RX_DATA_SPYOUT(CHANNEL1_LANE_ID) <= (others => '0');
          FMCIN_RX_CTRL_SPYOUT(CHANNEL1_LANE_ID) <= '0';
          FMCIN_RX_RDY_SPYOUT(CHANNEL1_LANE_ID)  <= '0';
          FMCIN_RX_DEN_SPYOUT(CHANNEL1_LANE_ID)  <= '0';                
        elsif (FMC_COMMON_CLK'event and FMC_COMMON_CLK='1') then
          FMCIN_RX_DATA_SPYOUT(CHANNEL0_LANE_ID) <= fmc_rx_data_out_i(CHANNEL0_LANE_ID);
          FMCIN_RX_CTRL_SPYOUT(CHANNEL0_LANE_ID) <= fmc_rx_ctrl_out_i(CHANNEL0_LANE_ID);
          FMCIN_RX_RDY_SPYOUT(CHANNEL0_LANE_ID)  <= not input_buffer_fifo_busy_i(CHANNEL0_LANE_ID);
          FMCIN_RX_DEN_SPYOUT(CHANNEL0_LANE_ID)  <= fmc_rx_den_out_i(CHANNEL0_LANE_ID);
          FMCIN_RX_DATA_SPYOUT(CHANNEL1_LANE_ID) <= fmc_rx_data_out_i(CHANNEL1_LANE_ID);
          FMCIN_RX_CTRL_SPYOUT(CHANNEL1_LANE_ID) <= fmc_rx_ctrl_out_i(CHANNEL1_LANE_ID);
          FMCIN_RX_RDY_SPYOUT(CHANNEL1_LANE_ID)  <= not input_buffer_fifo_busy_i(CHANNEL1_LANE_ID);
          FMCIN_RX_DEN_SPYOUT(CHANNEL1_LANE_ID)  <= fmc_rx_den_out_i(CHANNEL1_LANE_ID);
        end if;
      end process;
    end generate;
    
    CASE_SPYSAMPLING_WITH_MAIN_CLOCK : if SAMPLE_SPYOUT_AT_FMCCOMMONCLK = '0' generate
      process (MAIN_CLK, FMCIN_CONFIG_FRAME_RESET)
      begin
        if (FMCIN_CONFIG_FRAME_RESET='1') then
          FMCIN_RX_DATA_SPYOUT(CHANNEL0_LANE_ID) <= (others => '0');
          FMCIN_RX_CTRL_SPYOUT(CHANNEL0_LANE_ID) <= '0';
          FMCIN_RX_DEN_SPYOUT(CHANNEL0_LANE_ID)  <= '0';
          FMCIN_RX_DATA_SPYOUT(CHANNEL1_LANE_ID) <= (others => '0');
          FMCIN_RX_CTRL_SPYOUT(CHANNEL1_LANE_ID) <= '0';
          FMCIN_RX_DEN_SPYOUT(CHANNEL1_LANE_ID)  <= '0';                
        elsif (MAIN_CLK'event and MAIN_CLK='1') then
          FMCIN_RX_DATA_SPYOUT(CHANNEL0_LANE_ID) <= buffer_data_out_i(CHANNEL0_LANE_ID);
          FMCIN_RX_CTRL_SPYOUT(CHANNEL0_LANE_ID) <= buffer_ctrl_out_i(CHANNEL0_LANE_ID);
          FMCIN_RX_RDY_SPYOUT(CHANNEL0_LANE_ID)  <= BUFFER_REN_IN(CHANNEL0_LANE_ID);
          FMCIN_RX_DEN_SPYOUT(CHANNEL0_LANE_ID)  <= buffer_dv_out_i(CHANNEL0_LANE_ID) and BUFFER_REN_IN(CHANNEL0_LANE_ID);
          FMCIN_RX_DATA_SPYOUT(CHANNEL1_LANE_ID) <= buffer_data_out_i(CHANNEL1_LANE_ID);
          FMCIN_RX_CTRL_SPYOUT(CHANNEL1_LANE_ID) <= buffer_ctrl_out_i(CHANNEL1_LANE_ID);
          FMCIN_RX_RDY_SPYOUT(CHANNEL1_LANE_ID)  <= BUFFER_REN_IN(CHANNEL1_LANE_ID);
          FMCIN_RX_DEN_SPYOUT(CHANNEL1_LANE_ID)  <= buffer_dv_out_i(CHANNEL1_LANE_ID) and BUFFER_REN_IN(CHANNEL1_LANE_ID);
        end if;
      end process;
    end generate;
    
   
    BUFFER_DATA_OUT <=buffer_data_out_i;
    BUFFER_CTRL_OUT <=buffer_ctrl_out_i;
    BUFFER_DV_OUT   <=buffer_dv_out_i;

    CHANNEL0_FMCIN_BUFFER : fmc_input_buffer
      port map
      ( -- PORT A
        FMC_CLK_IN  => FMC_COMMON_CLK,
        FMC_DATA_IN => fmc_rx_data_out_i(CHANNEL0_LANE_ID),
        FMC_CTRL_IN => fmc_rx_ctrl_out_i(CHANNEL0_LANE_ID),
        FMC_DEN_IN  => fmc_rx_den_out_i(CHANNEL0_LANE_ID),
        
        -- PORT B
        MAIN_CLK => MAIN_CLK,
        DATA_OUT => buffer_data_out_i(CHANNEL0_LANE_ID),
        CTRL_OUT => buffer_ctrl_out_i(CHANNEL0_LANE_ID),
        DEN_OUT  => buffer_dv_out_i(CHANNEL0_LANE_ID),
        FIFO_GO_NEXT_IF_EXIST_IN => BUFFER_REN_IN(CHANNEL0_LANE_ID),
        
        -- FLOW CONTROL
        RESET => FMCIN_BUFFER_CONFIG_RESET,
        FIFO_BUSY_THRESHOLD  => FMCIN_BUSY_THRESHOLD,
        FIFO_FULL_OUT => FMCIN_BUFFER_CONFIG_FULL(CHANNEL0_LANE_ID),
        FIFO_BUSY_OUT => input_buffer_fifo_busy_i(CHANNEL0_LANE_ID),
        FIFO_WR_DATA =>  input_buffer_wr_data_i(CHANNEL0_LANE_ID)
        );


    
    CHANNEL1_FMCIN_BUFFER : fmc_input_buffer
      port map
      ( -- PORT A
        FMC_CLK_IN  => FMC_COMMON_CLK,
        FMC_DATA_IN => fmc_rx_data_out_i(CHANNEL1_LANE_ID),
        FMC_CTRL_IN => fmc_rx_ctrl_out_i(CHANNEL1_LANE_ID),
        FMC_DEN_IN  => fmc_rx_den_out_i(CHANNEL1_LANE_ID),
        
        -- PORT B
        MAIN_CLK => MAIN_CLK,
        DATA_OUT => buffer_data_out_i(CHANNEL1_LANE_ID),
        CTRL_OUT => buffer_ctrl_out_i(CHANNEL1_LANE_ID),
        DEN_OUT  => buffer_dv_out_i(CHANNEL1_LANE_ID),
        FIFO_GO_NEXT_IF_EXIST_IN => BUFFER_REN_IN(CHANNEL1_LANE_ID),
        
        -- FLOW CONTROL
        RESET => FMCIN_BUFFER_CONFIG_RESET,
        FIFO_BUSY_THRESHOLD  => FMCIN_BUSY_THRESHOLD,           
        FIFO_FULL_OUT => FMCIN_BUFFER_CONFIG_FULL(CHANNEL1_LANE_ID),
        FIFO_BUSY_OUT => input_buffer_fifo_busy_i(CHANNEL1_LANE_ID),
        FIFO_WR_DATA =>  input_buffer_wr_data_i(CHANNEL1_LANE_ID)
        );

    FMCIN_CONFIG_FIFO_FULL_COUNT(CHANNEL0_LANE_ID) <= fmc_rx_fifo_full_count_i(CHANNEL0_LANE_ID);
    FMCIN_CONFIG_FIFO_FULL_COUNT(CHANNEL1_LANE_ID) <= fmc_rx_fifo_full_count_i(CHANNEL1_LANE_ID);
    FMCIN_CONFIG_XOFF(CHANNEL0_LANE_ID) <= input_buffer_fifo_busy_i(CHANNEL0_LANE_ID);
    FMCIN_CONFIG_XOFF(CHANNEL1_LANE_ID) <= input_buffer_fifo_busy_i(CHANNEL1_LANE_ID);
    FMCIN_FIFO_WR_DATA(CHANNEL0_LANE_ID) <= input_buffer_wr_data_i(CHANNEL0_LANE_ID);
    FMCIN_FIFO_WR_DATA(CHANNEL1_LANE_ID) <= input_buffer_wr_data_i(CHANNEL1_LANE_ID);    

    
    FMCOUT : fmc_tx_interface
      generic map ( FMC_ID=>FMC_ID, FPGA_ID=>FPGA_ID)
      port map (
        FMC_COMMON_CLK => FMC_COMMON_CLK,
        
        -- USER Interface
        FMC_SCT_BUSY_IN => input_buffer_fifo_busy_i(CHANNEL0_LANE_ID),
        FMC_PIX_BUSY_IN => input_buffer_fifo_busy_i(CHANNEL1_LANE_ID),
        FMC_SPY_BUFFER_FREEZE_IN => spybuffer_freeze_signal_to_im_i,
        --
        FMCOUT_LVDS_DATA_OUT_P => fmcout_lvds_data_out_p_i(iFpga),
        FMCOUT_LVDS_DATA_OUT_N => fmcout_lvds_data_out_n_i(iFpga));    
  end generate;

  ---------------------------------------------------------------------------------------------------------
  -- data checker 
  ---------------------------------------------------------------------------------------------------------  
  FMC_DATA_CHECKER: fmc_rx_data_checker
    port map(
      FMC_COMMON_CLK => FMC_COMMON_CLK,
      RESET          => FMCIN_CONFIG_CLOCK_SYNC_RESET,
      DIN            => fmcin_monitor_front_data_out_i( to_integer(signed(SELECTED_FMC_FPGA)) ),
      COMPARE_OK     => FMCIN_CONFIG_SYNC_DONE(to_integer(signed(SELECTED_FMC_FPGA)) )
      );

end logic;
  
