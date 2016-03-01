--
library ieee;
use ieee.std_logic_1164.all;

use work.FmcConstants.all;

package data_formatter_constants is
  -- swtich configuration (32x32)
  -----------------------------------------------------------------------------------------
  constant NCOL_32X32_SWITCH_MATRIX : integer := 5;
  constant NROW_32X32_SWITCH_MATRIX : integer := 32;
  constant NSWITCH_PER_COL_32X32_SWITCH_MATRIX : integer := NROW_32X32_SWITCH_MATRIX/2;
  
  type mask_def_array_32x32_t is array(0 to NCOL_32X32_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  constant OUTPORT2_MASKS_32X32 : mask_def_array_32x32_t := (X"FFFF0000",
                                                             X"FF00FF00",
                                                             X"F0F0F0F0",
                                                             X"CCCCCCCC",
                                                             X"AAAAAAAA");
  constant OUTPORT1_MASKS_32X32 : mask_def_array_32x32_t := (X"0000FFFF",
                                                             X"00FF00FF",
                                                             X"0F0F0F0F",
                                                             X"33333333",
                                                             X"55555555");
  
  type DATA32_32X32_SWITCH_MATRIX_PORTS is array(0 to NROW_32X32_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  type FLAGS_32X32_SWITCH_MATRIX_PORTS is array(NROW_32X32_SWITCH_MATRIX-1 downto 0) of std_logic;
  type FIFO_MONITORING_32X32_SWITCH_MATRIX_PORTS is array(0 to NSWITCH_PER_COL_32X32_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  
  type INTER_MEDIATE_DATA32_FOR_32X32_SWITCH_MATRIX_MATRIX is array(0 to NCOL_32X32_SWITCH_MATRIX) of DATA32_32X32_SWITCH_MATRIX_PORTS;
  type INTER_MEDIATE_FLAGS_FOR_32X32_SWITCH_MATRIX_MATRIX is array(0 to NCOL_32X32_SWITCH_MATRIX) of FLAGS_32X32_SWITCH_MATRIX_PORTS;
  
  type FIFO_MONITORING_FOR_32X32_SWITCH_MATRIX_MATRIX is array(0 to NCOL_32X32_SWITCH_MATRIX-1) of FIFO_MONITORING_32X32_SWITCH_MATRIX_PORTS;  
  
  
  -- swtich configuration (16x16)
  -----------------------------------------------------------------------------------------  
  constant NCOL_16X16_SWITCH_MATRIX : integer := 4;
  constant NROW_16X16_SWITCH_MATRIX : integer := 16;
  constant NSWITCH_PER_COL_16X16_SWITCH_MATRIX : integer := NROW_16X16_SWITCH_MATRIX/2;
  
  type mask_def_array_16x16_t is array(0 to NCOL_16X16_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  constant OUTPORT2_MASKS_16X16 : mask_def_array_16x16_t := (X"FF00FF00",
                                                             X"F0F0F0F0",
                                                             X"CCCCCCCC",
                                                             X"AAAAAAAA");
  constant OUTPORT1_MASKS_16X16 : mask_def_array_16x16_t := (X"00FF00FF",
                                                             X"0F0F0F0F",
                                                             X"33333333",
                                                             X"55555555");
  
  type DATA32_16X16_SWITCH_MATRIX_PORTS is array(0 to NROW_16X16_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  type FLAGS_16X16_SWITCH_MATRIX_PORTS is array(NROW_16X16_SWITCH_MATRIX-1 downto 0) of std_logic;
  
  type INTER_MEDIATE_DATA32_FOR_16X16_SWITCH_MATRIX_MATRIX is array(0 to NCOL_16X16_SWITCH_MATRIX) of DATA32_16X16_SWITCH_MATRIX_PORTS;
  type INTER_MEDIATE_FLAGS_FOR_16X16_SWITCH_MATRIX_MATRIX is array(0 to NCOL_16X16_SWITCH_MATRIX) of FLAGS_16X16_SWITCH_MATRIX_PORTS;
  
  -- swtich configuration (8x8)
  -----------------------------------------------------------------------------------------  
  constant NCOL_8X8_SWITCH_MATRIX : integer := 3;
  constant NROW_8X8_SWITCH_MATRIX : integer := 8;
  constant NSWITCH_PER_COL_8X8_SWITCH_MATRIX : integer := NROW_8X8_SWITCH_MATRIX/2;
  
  type mask_def_array_8X8_t is array(0 to NCOL_8X8_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  constant OUTPORT2_MASKS_8X8 : mask_def_array_8X8_t := (X"F0F0F0F0",
                                                         X"CCCCCCCC",
                                                         X"AAAAAAAA");
  constant OUTPORT1_MASKS_8X8 : mask_def_array_8X8_t := (X"0F0F0F0F",
                                                         X"33333333",
                                                         X"55555555");
  
  type DATA32_8X8_SWITCH_MATRIX_PORTS is array(0 to NROW_8X8_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  type FLAGS_8X8_SWITCH_MATRIX_PORTS is array(NROW_8X8_SWITCH_MATRIX-1 downto 0) of std_logic;
  
  type INTER_MEDIATE_DATA32_FOR_8X8_SWITCH_MATRIX_MATRIX is array(0 to NCOL_8X8_SWITCH_MATRIX) of DATA32_8X8_SWITCH_MATRIX_PORTS;
  type INTER_MEDIATE_FLAGS_FOR_8X8_SWITCH_MATRIX_MATRIX is array(0 to NCOL_8X8_SWITCH_MATRIX) of FLAGS_8X8_SWITCH_MATRIX_PORTS;
  
  -- swtich configuration (4x4)
  -----------------------------------------------------------------------------------------
  constant NCOL_4X4_SWITCH_MATRIX : integer := 2;
  constant NROW_4X4_SWITCH_MATRIX : integer := 4;
  constant NSWITCH_PER_COL_4X4_SWITCH_MATRIX : integer := NROW_4X4_SWITCH_MATRIX/2;
  
  type mask_def_array_4X4_t is array(0 to NCOL_4X4_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  constant OUTPORT2_MASKS_4X4 : mask_def_array_4X4_t := (X"CCCCCCCC",
                                                         X"AAAAAAAA");
  constant OUTPORT1_MASKS_4X4 : mask_def_array_4X4_t := (X"33333333",
                                                         X"55555555");
  
  type DATA32_4X4_SWITCH_MATRIX_PORTS is array(0 to NROW_4X4_SWITCH_MATRIX-1) of std_logic_vector(31 downto 0);
  type FLAGS_4X4_SWITCH_MATRIX_PORTS is array(NROW_4X4_SWITCH_MATRIX-1 downto 0) of std_logic;
  
  type INTER_MEDIATE_DATA32_FOR_4X4_SWITCH_MATRIX_MATRIX is array(0 to NCOL_4X4_SWITCH_MATRIX) of DATA32_4X4_SWITCH_MATRIX_PORTS;
  type INTER_MEDIATE_FLAGS_FOR_4X4_SWITCH_MATRIX_MATRIX is array(0 to NCOL_4X4_SWITCH_MATRIX) of FLAGS_4X4_SWITCH_MATRIX_PORTS;  

  -----------------------------------------------------------------------------------------
  -- DF Internal Data Format
  -----------------------------------------------------------------------------------------
  constant DFIF_EVID_LAST   : integer := 15;
  constant DFIF_EVID_FIRST  : integer := 0;
  constant DFIF_EVID_LENGTH : integer := DFIF_EVID_LAST - DFIF_EVID_FIRST + 1;

  constant MAX_EVT_ID : integer := (2**DFIF_EVID_LENGTH);
  
  constant DFIF_EVID_LAST_FOR_COMPARE_IN_SWITCH   : integer := 2;
  constant DFIF_EVID_FIRST_FOR_COMPARE_IN_SWITCH  : integer := 0;
  constant DFIF_EVID_LENGTH_FOR_COMPARE_IN_SWITCH : integer := DFIF_EVID_LAST_FOR_COMPARE_IN_SWITCH - DFIF_EVID_FIRST_FOR_COMPARE_IN_SWITCH + 1;
  constant MAX_EVT_ID_FOR_COMPARE_IN_SWITCH : integer := (2**DFIF_EVID_LENGTH_FOR_COMPARE_IN_SWITCH);
  
  constant DFIF_HEADER_RANDOM_COUNTER_LAST  : integer := 20;
  constant DFIF_HEADER_RANDOM_COUNTER_FIRST : integer := 16;
  constant DFIF_HEADER_RANDOM_COUNTER_LENGTH : integer := DFIF_HEADER_RANDOM_COUNTER_LAST - DFIF_HEADER_RANDOM_COUNTER_FIRST + 1;
  
  constant DFIF_FRAGMENTID_LAST   : integer := 31;
  constant DFIF_FRAGMENTID_START  : integer := 28;
  constant DFIF_FRAGMENTID_LENGTH : integer := DFIF_FRAGMENTID_LAST-DFIF_FRAGMENTID_START;
  constant DFIF_FRAGMENTID_HEADER       : std_logic_vector(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) := "1100";
  constant DFIF_FRAGMENTID_HEADER_FAKE  : std_logic_vector(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) := "1101";
  constant DFIF_HEADER_RESERVED    : std_logic_vector(DFIF_FRAGMENTID_START-1 downto DFIF_HEADER_RANDOM_COUNTER_LAST+1)   := (others => '0');
  constant DFIF_FRAGMENTID_TRAILER : std_logic_vector(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) := "1110";
  constant DFIF_TRAILER_REERVED    : std_logic_vector(DFIF_FRAGMENTID_START-1 downto 0) := (others => '0');
  constant DFIF_FRAGMENTID_MODULE_HEADER  : std_logic_vector(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) := "1000";

  -----------------------------------------------------------------------------------------
  -- Input Mezzanine Data Formatter
  -----------------------------------------------------------------------------------------
  constant IMDF_MODULE_HEADER_IS_SCT_POS : integer := 15;
  constant IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START : integer :=  0;
  constant IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST  : integer := 10;
  constant IMDF_MODULE_HEADER_SCT_MODULE_ID_START : integer :=  0;
  constant IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST  : integer := 12;
  
  -----------------------------------------------------------------------------------------
  -- DF Output Data Format
  -----------------------------------------------------------------------------------------
  constant DF_FRAME_WORD_LSB_BITPOS : integer := 16;
  constant DF_FRAME_WORD_MSB_BITPOS : integer := 31;
  constant DF_OUTPUT_BOF_WORD  : std_logic_vector(DF_FRAME_WORD_MSB_BITPOS downto DF_FRAME_WORD_LSB_BITPOS) := X"B0F0";
  constant DF_OUTPUT_EOF_WORD  : std_logic_vector(DF_FRAME_WORD_MSB_BITPOS downto DF_FRAME_WORD_LSB_BITPOS) := X"E0F0";
  constant DF_OUTPUT_EODA_WORD : std_logic_vector(DF_FRAME_WORD_MSB_BITPOS downto DF_FRAME_WORD_LSB_BITPOS) := X"E0DA";
  
  constant MAX_NUM_MODULES_PER_INPUT_LANE : integer :=128;
  -- should be "16 times integer e.g. 128=16x8"
  
  -----------------------------------------------------------------------------------------
  -- DF Internal Module Address Definition
  -----------------------------------------------------------------------------------------
  constant DF_INTERNAL_MODADDRESS_LENGTH    : integer := 14;
  constant DF_INTERNAL_MODADDRESS_ISSCT_POS : integer := 13;
  constant MAXIMUM_NUMBER_OF_MODULES_PER_OUTPUT_LANE : integer := 512;
  
  -----------------------------------------------------------------------------------------
  -- DF NUMBER OF LANS PARAMETERS in sharing
  -----------------------------------------------------------------------------------------
  constant NUMBER_OF_FMC_INPUT_LANES            : integer := num_fpga_for_each_mainfpga*2; -- 2A=8 / 2B=16
  constant NUMBER_OF_ODO_IN_LANES               : integer := 32;
  constant NUMBER_OF_LANES_POST_IDO             : integer := num_fpga_for_each_mainfpga;   -- 2A=4 / 2B=8
  constant NUMBER_OF_FTKPLANES                  : integer := 12; 
  --constant NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES  : integer := 34; -- (1)
  constant NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES  : integer := 36; -- (1)
  constant NUMBER_OF_GT_FOR_INTERNALLINK_LANES  : integer := 24; -- 20(fabric)+4(inter-crate)--(2)
  --constant NUMBER_OF_GTCHANNELS                 : integer := 58; -- should be (1)+(2)
  constant NUMBER_OF_GTCHANNELS                 : integer := 60; -- should be (1)+(2)
  constant NUMBER_OF_GT_REFCLKS                 : integer := 6;
  constant NUM_GT_LANES_RTM_L                   : integer := 34; -- (1)
  constant NUM_GT_LANES_RTM_R                   : integer := 6;  -- (2)
  constant NUM_GT_LANES_RTM                     : integer := 40; -- should be (1)+(2)
  constant NUM_GT_LANES_FABRIC                  : integer := 20; -- should be (1)+(2)
  
  constant NUMBER_OF_LANES_POST_ILI             : integer := NUMBER_OF_GT_FOR_INTERNALLINK_LANES;
  constant NUMBER_OF_ILO_IN_LANES               : integer := 32;
  constant NUMBER_OF_CENTRALSWITCH_OUTPUT_LANES : integer := 32;
  constant NUMBER_OF_INTERNALLINKOUTPUTSW_LANES : integer := 32;
  
  ----------------------------------------------------
  --- For FMC input
  ----------------------------------------------------
  type DF_INPUT_DATA_ARRAY         is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(31 downto 0);
  type DF_FMC_FULL_COUNTER_ARRAY   is array(0 to num_fpga_for_each_mainfpga-1) of std_logic_vector(31 downto 0);  
  type DF_INPUT_MOD2IDX_ADDR_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(13 downto 0);
  type DF_INPUT_MOD2IDX_DATA_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector( 8 downto 0);
  type DF_INPUT_PIXMOD2DST_ADDR_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(10 downto 0);
  type DF_INPUT_PIXMOD2DST_DATA_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(35 downto 0);
  type DF_INPUT_SCTMOD2DST_ADDR_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(12 downto 0);
  type DF_INPUT_SCTMOD2DST_DATA_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(35 downto 0);  
  type DF_INPUT_IDX2MOD_ADDR_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector( 8 downto 0);
  type DF_INPUT_IDX2MOD_DATA_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(13 downto 0);
  type DF_INPUT_STATE_MACHINE_STATE_MONITOR_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(7 downto 0);
  type DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(1 downto 0);
  type DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of integer range 0 to MAXIMUM_NUMBER_OF_MODULES_PER_OUTPUT_LANE-1;
  type DF_FMC_WR_DATA_ARRAY         is array(0 to NUMBER_OF_FMC_INPUT_LANES-1) of std_logic_vector(11 downto 0);

  ----------------------------------------------------
  --- For output GT for SLINK Output links (LSC)
  ----------------------------------------------------
  type DF_DATA_GT_FOR_SLINK_OUTPUT_ARRAY is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of std_logic_vector(31 downto 0);
  type DF_ERROR_MONITOR_GT_FOR_SLINK_OUTPUT_LANE_ARRAY
    is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of std_logic_vector(31 downto 0);
  type DF_GT_FOR_SLINK_OUTPUT_LANES_INTEGER_ARRAY is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of integer;
  type DF_RETURN_LINE_SLINK_OUTPUT_ARRAY is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of std_logic_vector( 3 downto 0);
  type DF_SLINK_LSC_GT_DEEMPH_ARRAY is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of std_logic_vector( 4 downto 0);
  
  -- GTDATA / GTCHARISK
  type DF_GTDATA_FOR_SLINK_OUTPUT_ARRAY is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of std_logic_vector(31 downto 0);
  type DF_GTCHARISK_FOR_SLINK_OUTPUT_ARRAY is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of std_logic_vector(3 downto 0);
  
  ----------------------------------------------------
  --- For output GT for Internal Links
  ----------------------------------------------------
  type DF_DATA_GT_FOR_INTERNALLINK_ARRAY is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1) of std_logic_vector(31 downto 0);
  type DF_ERROR_MONITOR_GT_FOR_INTERNALLINK_LANE_ARRAY
    is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1) of std_logic_vector(31 downto 0);
  type DF_GT_FOR_INTERNALLINK_LANES_INTEGER_ARRAY is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1) of integer;
  type DF_RETURN_LINE_INTERNALLINK_ARRAY is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1) of std_logic_vector( 3 downto 0);
  -- GTDATA / GTCHARISK
  type DF_GTDATA_FOR_INTERNALLINK_ARRAY is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1) of std_logic_vector(31 downto 0);
  type DF_GTCHARISK_FOR_INTERNALLINK_ARRAY is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1) of std_logic_vector(3 downto 0);
  
  ----------------------------------------------------
  --- For Input Data Operator 
  ----------------------------------------------------
  type DF_DATA_POST_IDO_ARRAY is array(0 to NUMBER_OF_LANES_POST_IDO-1) of std_logic_vector(31 downto 0);

  ----------------------------------------------------
  --- For Internal Link Input 
  ----------------------------------------------------
  type DF_DATA_POST_ILI_ARRAY is array(0 to NUMBER_OF_LANES_POST_ILI-1) of std_logic_vector(31 downto 0);
  
  ----------------------------------------------------
  --- For Internal Link Output 
  ----------------------------------------------------
  type DF_DESTINATION_WORD_POST_CENTRAL_SWITCH_ARRAY is array(0 to NUMBER_OF_CENTRALSWITCH_OUTPUT_LANES-1)
    of std_logic_vector(15 downto 0);
  
  ----------------------------------------------------
  --- MAPPING between <POST_IDO - ODO/ILO>
  ----------------------------------------------------
  type MAP_POSTIDO2ODO is array(0 to NUMBER_OF_LANES_POST_IDO-1)
    of integer range 0 to NUMBER_OF_ODO_IN_LANES-1;
  constant MAPPING_CONF_IDO2ODO : MAP_POSTIDO2ODO := (0, 4, 8, 12, 16, 20, 24, 28);
  
  type MAP_POSTIDO2ILO is array(0 to NUMBER_OF_LANES_POST_IDO-1)
    of integer range 0 to NUMBER_OF_ILO_IN_LANES-1;
  constant MAPPING_CONF_IDO2ILO : MAP_POSTIDO2ILO := (0, 4, 8, 12, 16, 20, 24, 28);
  
  ----------------------------------------------------
  --- MAPPING between <POST_ILI - ODO/ILO>
  ----------------------------------------------------
  type MAP_POSTILI2ODO is array(0 to NUMBER_OF_LANES_POST_ILI-1)
    of integer range 0 to NUMBER_OF_ODO_IN_LANES-1;
  constant MAPPING_CONF_ILI2ODO : MAP_POSTILI2ODO := ( 1,  2,  3,
                                                       5,  6,  7,
                                                       9, 10, 11,
                                                      13, 14, 15,
                                                      17, 18, 19,
                                                      21, 22, 23,
                                                      25, 26, 27,
                                                      29, 30, 31);
  
  type MAP_POSTILI2ILO is array(0 to NUMBER_OF_LANES_POST_ILI-1)
    of integer range 0 to NUMBER_OF_ILO_IN_LANES-1;
  constant MAPPING_CONF_ILI2ILO : MAP_POSTILI2ILO := ( 1,  2,  3,
                                                       5,  6,  7,
                                                       9, 10, 11,
                                                      13, 14, 15,
                                                      17, 18, 19,
                                                      21, 22, 23,
                                                      25, 26, 27,
                                                      29, 30, 31);
  
  type MAP_CENTRALSW2INTERNALLINKOUTPUTSW is array(0 to NUMBER_OF_CENTRALSWITCH_OUTPUT_LANES-1)
    of integer range 0 to NUMBER_OF_INTERNALLINKOUTPUTSW_LANES-1;
  constant MAPPING_CONF_CENTRALSW2INTERNALLINKOUTPUTSW : MAP_CENTRALSW2INTERNALLINKOUTPUTSW
    -- we have to have cable assignment to minimize the busy time
    -- (i.e. distribute the input as much as possible)
    := ( 0,  1,   2,  3, 
         4,  5,   6,  7, 
         8,  9,  10, 11, 
         12, 13, 14, 15, 
         16, 17, 18, 19, 
         20, 21, 22, 23, 
         24, 25, 26, 27, 
         28, 29, 30, 31  
         );
  
  type MAP_INTERNALLINKCH2INTERNALLINKOUTPUTSW is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1)
    of integer range 0 to NUMBER_OF_INTERNALLINKOUTPUTSW_LANES-1;
  constant MAPPING_CONF_INTERNALLINKCH2INTERNALLINKOUTPUTSW : MAP_INTERNALLINKCH2INTERNALLINKOUTPUTSW
    -- we have to have cable assignment to minimize the busy time
    -- (i.e. distribute the output as much as possible)    
    := ( 0,  8,       -- FAB-CH3P0  FAB-CH4P0
         4, 12,       -- FAB-CH5P0  FAB-CH6P0
         2, 10,       -- FAB-CH7P0  FAB-CH8P0
         6,           -- FAB-CH9P0
         1,  3,  5,   -- FAB-CH10P0 FAB-CH11P0 FAB-CH12P0
         14, 15,      -- OPT-CH00P0 OPT-CH01P0
         
         16, 24,      -- FAB-CH3P1  FAB-CH4P1
         20, 28,      -- FAB-CH5P1  FAB-CH6P1
         18, 26,      -- FAB-CH7P1  FAB-CH8P1
         22,          -- FAB-CH9P1
         17, 19, 21,  -- FAB-CH10P1 FAB-CH11P1 FAB-CH12P1
         30, 31);     -- OPT-CH00P1 OPT-CH01P1
  
  ----------------------------------------------------
  --- MAPPING between <GT CHANNEL - OUTPUT_SWITCH>
  ----------------------------------------------------
  --type MAP_SLINKCH2OUTPUTSW is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1)
  --  of integer range 0 to 31;
  -- <this set of parametesr should be propagated to LOCAL_DESTINATION_BIT assignment>
  -- at df_output_preparation_v2.vhd
  --constant MAPPING_CONF_SLINKCH2OUTPUTSW : MAP_SLINKCH2OUTPUTSW := (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
  constant NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION : integer := 16;
  constant NUMBER_OF_SSB_OUTPUT_BEFORE_DUPLICATION : integer := 2;
  
  type MAP_AUXCH2OUTPUTSW is array(0 to NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1) of integer range 0 to 31;
  --constant MAPPING_CONF_AUXCH2OUTPUTSW : MAP_AUXCH2OUTPUTSW := (0,  1,  2,  3,  4,  5,  6,  7, 16, 17, 18, 19, 20, 21, 22, 23);
  constant MAPPING_CONF_AUXCH2OUTPUTSW : MAP_AUXCH2OUTPUTSW := (0,  4,  8,  2,  6, 10, 12, 13, 16, 20, 24, 18, 22, 26, 28, 29);
  type MAP_AUXCH2SLINKOUTCH is array(0 to NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1) of integer range 0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1;
  constant MAPPING_CONF_AUXCH2PORT0SLINKOUTCH : MAP_AUXCH2SLINKOUTCH := (0,  1,  2,  3,  4,  5,  6,  7, 18, 19, 20, 21, 22, 23, 24, 25); --AUX_TOP0_BOT0
  constant MAPPING_CONF_AUXCH2PORT1SLINKOUTCH : MAP_AUXCH2SLINKOUTCH := (8,  9, 10, 11, 12, 13, 14, 15, 26, 27, 28, 29, 30, 31, 32, 33); --AUX_TOP1_BOT1
  
  type MAP_SSBCH2OUTPUTSW is array(0 to NUMBER_OF_SSB_OUTPUT_BEFORE_DUPLICATION-1) of integer range 0 to 31;
  constant MAPPING_CONF_SSBCH2OUTPUTSW   : MAP_SSBCH2OUTPUTSW := (15, 31);
  type MAP_SSBCH2SLINKOUTCH is array(0 to NUMBER_OF_SSB_OUTPUT_BEFORE_DUPLICATION-1) of integer range 0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1;
  constant MAPPING_CONF_SSBCH2PORT0SLINKOUTCH : MAP_SSBCH2SLINKOUTCH := (16, 34);
  constant MAPPING_CONF_SSBCH2PORT1SLINKOUTCH : MAP_SSBCH2SLINKOUTCH := (17, 35);
  
  constant GTLOC_RTM_L  : integer := 0;
  constant GTLOC_RTM_R  : integer := 1;
  constant GTLOC_FABRIC : integer := 2;
  
  ------------------------------------------------------------------------------------
  type MAP_SLINKOUTCH2GTLOC is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of integer range 0 to 2;
  constant MAPPING_CONF_SLINKOUT2GTLOC : MAP_SLINKOUTCH2GTLOC
    --  AUX TOP0  P0            P1            P2            P3            P4            P5            P6            P7
    :=           (GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,
    --  AUX TOP1  P0            P1            P2            P3            P4            P5            P6            P7
                  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,
    --  SSB TOP
                  GTLOC_RTM_L,  GTLOC_RTM_L,
    --  AUX BOT0  P0            P1            P2            P3            P4            P5            P6            P7
                  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,
    --  AUX BOT1  P0            P1            P2            P3            P4            P5            P6            P7
                  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_L,  GTLOC_RTM_R,  GTLOC_RTM_R,
    --  SSB BOT
                  GTLOC_RTM_L,  GTLOC_RTM_L);
  
  type map_slinkout2gtchannel is array(0 to NUMBER_OF_GT_FOR_SLINK_OUTPUT_LANES-1) of integer;
  constant MAPPING_CONF_SLINKOUT2GTCHANNEL  : map_slinkout2gtchannel
    --  AUX TOP0   P0   P1   P2   P3   P4   P5   P6   P7 ; P stands for ftk-plane
    :=           ( 33,  32,  31,  30,  29,  28,  27,  26,
    --  AUX TOP1   P0   P1   P2   P3   P4   P5   P6   P7 ; P stands for ftk-plane
                   25,  24,  23,  22,  21,  20,  19,  18,
    --  SSB TOP
                   17,  16,
    --  AUX BOT0   P0   P1   P2   P3   P4   P5   P6   P7 ; P stands for ftk-plane
                   13,  12,  11,  10,  9,   8,   7,   6,
    --  AUX BOT1   P0   P1   P2   P3   P4   P5   P6   P7 ; P stands for ftk-plane
                   5,   4,   3,   2,   1,   0,   0,   1,
    --  SSB BOT
                   15,  14);
  
  ------------------------------------------------------------------------------------
  type MAP_INTERNALLINKCH2GTLOC is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1) of integer range 0 to 2;
  constant MAPPING_CONF_INTERNALLINK2GTLOC : MAP_INTERNALLINKCH2GTLOC
    --  FABRIC    CH3P0         CH4P0         CH5P0         CH6P0         CH7P0         CH8P0         CH9P0         CH10P0        CH11P0        CH12P0        
    :=           (GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC,
    --  IC-FIBER  CH0P0         CH1P0
                  GTLOC_RTM_R,  GTLOC_RTM_R, 
    --  FABRIC    CH3P1         CH4P1         CH5P1         CH6P1         CH7P1         CH8P1         CH9P1         CH10P1        CH11P1        CH12P1        
                  GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC, GTLOC_FABRIC,
    --  IC-FIBER  CH0P1         CH1P1      
                  GTLOC_RTM_R,  GTLOC_RTM_R);
  
  type map_internallink2gtchannel is array(0 to NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1) of integer;
  constant MAPPING_CONF_INTERNALLINK2GTCHANNEL  : map_internallink2gtchannel
    --  FABRIC    CH3P0  CH4P0  CH5P0  CH6P0  CH7P0  CH8P0  CH9P0 CH10P0 CH11P0 CH12P0
    :=           (19,    17,    15,    13,    11,     9,     7,    5,     3,     1,
    --  IC-FIBER  CH0P0  CH1P0
                  2,     4,
    --  FABRIC    CH3P1  CH4P1  CH5P1  CH6P1  CH7P1  CH8P1  CH9P1 CH10P1 CH11P1 CH12P1
                  18,    16,    14,    12,    10,     8,     6,    4,     2,     0,
    --  IC-FIBER  CH0P1  CH1P1
                  3,     5);
  
  ----------------------------------------------------
  --- Each GT Group
  ----------------------------------------------------     
  type DF_GTDATA_LANES_RTM_L_ARRAY is array(0 to NUM_GT_LANES_RTM_L-1) of std_logic_vector(31 downto 0);
  type DF_GTCHARISK_LANES_RTM_L_ARRAY is array(0 to NUM_GT_LANES_RTM_L-1) of std_logic_vector( 3 downto 0);
  
  type DF_GTDATA_LANES_RTM_R_ARRAY is array(0 to NUM_GT_LANES_RTM_R-1) of std_logic_vector(31 downto 0);
  type DF_GTCHARISK_LANES_RTM_R_ARRAY is array(0 to NUM_GT_LANES_RTM_R-1) of std_logic_vector( 3 downto 0);  
  
  type DF_GTDATA_LANES_FABRIC_ARRAY is array(0 to NUM_GT_LANES_FABRIC-1) of std_logic_vector(31 downto 0);
  type DF_GTCHARISK_LANES_FABRIC_ARRAY is array(0 to NUM_GT_LANES_FABRIC-1) of std_logic_vector( 3 downto 0);
  
  ----------------------------------------------------
  --- For OUTPUT SWITCH
  ----------------------------------------------------
  type DF_ODO_IN_DATA_ARRAY  is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(31 downto 0);
  type DF_ILO_IN_DATA_ARRAY  is array(0 to NUMBER_OF_ILO_IN_LANES-1) of std_logic_vector(31 downto 0);  
  type DF_PIXMOD2FTKPLANE_ADDR_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(10 downto 0);
  type DF_PIXMOD2FTKPLANE_DATA_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(11 downto 0);
  type DF_PIXMOD2TOWER_ADDR_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(10 downto 0);
  type DF_PIXMOD2TOWER_DATA_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(1 downto 0);
  type DF_PIXMOD2DUPLICATION_ADDR_ARRAY is array(0 to NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1) of std_logic_vector(10 downto 0);
  type DF_PIXMOD2DUPLICATION_DATA_ARRAY is array(0 to NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1) of std_logic_vector(1 downto 0);  
  type DF_SCTMOD2FTKPLANE_ADDR_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(12 downto 0);
  type DF_SCTMOD2FTKPLANE_DATA_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(11 downto 0);
  type DF_SCTMOD2TOWER_ADDR_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(12 downto 0);
  type DF_SCTMOD2TOWER_DATA_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(1 downto 0);
  type DF_SCTMOD2DUPLICATION_ADDR_ARRAY is array(0 to NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1) of std_logic_vector(12 downto 0);
  type DF_SCTMOD2DUPLICATION_DATA_ARRAY is array(0 to NUMBER_OF_AUX_OUTPUT_BEFORE_DUPLICATION-1) of std_logic_vector(1 downto 0);  
  type DF_ODO_IN_STATE_MACHINE_ERROR_MONITOR_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of std_logic_vector(31 downto 0);  
  type DF_OUTPUT_SWITCH_LANES_INTEGER_ARRAY is array(0 to NUMBER_OF_ODO_IN_LANES-1) of integer;
  
  constant VIVADO_2014_2_OR_LATER : boolean := TRUE;
  
end package;
