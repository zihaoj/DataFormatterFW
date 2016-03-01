--
library ieee;
use ieee.std_logic_1164.all;

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
  
  type INTER_MEDIATE_DATA32_FOR_32X32_SWITCH_MATRIX_MATRIX is array(0 to NCOL_32X32_SWITCH_MATRIX) of DATA32_32X32_SWITCH_MATRIX_PORTS;
  type INTER_MEDIATE_FLAGS_FOR_32X32_SWITCH_MATRIX_MATRIX is array(0 to NCOL_32X32_SWITCH_MATRIX) of FLAGS_32X32_SWITCH_MATRIX_PORTS;
  
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
  
  -- DF Internal Data Format
  constant DFIF_EVID_LAST   : integer := 15;
  constant DFIF_EVID_FIRST  : integer := 0;
  constant DFIF_EVID_LENGHT : integer := DFIF_EVID_LAST - DFIF_EVID_FIRST + 1;

  constant DFIF_HEADER_RANDOM_COUNTER_LAST  : integer := 20;
  constant DFIF_HEADER_RANDOM_COUNTER_FIRST : integer := 16;
  constant DFIF_HEADER_RANDOM_COUNTER_LENGTH : integer := DFIF_HEADER_RANDOM_COUNTER_LAST - DFIF_HEADER_RANDOM_COUNTER_FAST + 1;
  
  constant MAX_EVT_ID : integer := (2**DFIF_EVID_LENGHT);
  
  constant DFIF_FRAGMENTID_LAST   : integer := 31;
  constant DFIF_FRAGMENTID_START  : integer := 28;
  constant DFIF_FRAGMENTID_LENGTH : integer := DFIF_FRAGMENTID_LAST-DFIF_FRAGMENTID_START;
  constant DFIF_FRAGMENTID_HEADER       : std_logic_vector(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) := "1100";
  constant DFIF_FRAGMENTID_HEADER_FAKE  : std_logic_vector(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) := "1101";
  constant DFIF_HEADER_RESERVED    : std_logic_vector(DFIF_FRAGMENTID_START-1 downto DFIF_HEADER_RANDOM_COUNTER_LAST+1)   := (others => '0');
  constant DFIF_FRAGMENTID_TRAILER : std_logic_vector(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) := "1110";
  constant DFIF_TRAILER_REERVED    : std_logic_vector(DFIF_FRAGMENTID_START-1 downto 0) := (others => '0');
  constant DFIF_FRAGMENTID_MODULE_HEADER  : std_logic_vector(DFIF_FRAGMENTID_LAST downto DFIF_FRAGMENTID_START) := "1000";
  
  -- Input Mezzanine Data Formatter
  constant IMDF_MODULE_HEADER_IS_SCT_POS : integer := 15;
  constant IMDF_MODULE_HEADER_PIXEL_MODULE_ID_START : integer :=  0;
  constant IMDF_MODULE_HEADER_PIXEL_MODULE_ID_LAST  : integer := 10;
  constant IMDF_MODULE_HEADER_SCT_MODULE_ID_START : integer :=  0;
  constant IMDF_MODULE_HEADER_SCT_MODULE_ID_LAST  : integer := 12;
  
  -- DF Output Data Format
  constant DF_OUTPUT_BOF_WORD  : std_logic_vector(31 downto 0) := X"B0F00000";
  constant DF_OUTPUT_EOF_WORD  : std_logic_vector(31 downto 0) := X"E0F00000";
  constant DF_OUTPUT_EODA_WORD : std_logic_vector(31 downto 0) := X"E0DA0000";    
  
  constant MAX_NUM_MODULES_PER_INPUT_LANE : integer :=128;
  -- should be "16 times integer e.g. 128=16x8"

  -- DF Internal Module Address Definition
  constant DF_INTERNAL_MODADDRESS_LENGTH      : integer := 14;
  constant DF_INTERNAL_MODADDRESS_ISSCT_POS   : integer := 13;
  
  constant MAXIMUM_NUMBER_OF_MODULES_PER_OUTPUT_LANE : integer := 512;
  
  -- DF INPUT PARAMETER
  constant MAXIMUM_NUMBER_OF_INPUT_LANES : integer := 8; -- 2A=8 / 2B=16
  type DF_INPUT_DATA_ARRAY         is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector(31 downto 0);
  type DF_INPUT_MOD2IDX_ADDR_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector(13 downto 0);
  type DF_INPUT_MOD2IDX_DATA_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector( 8 downto 0);
  type DF_INPUT_PIXMOD2DST_ADDR_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector(10 downto 0);
  type DF_INPUT_PIXMOD2DST_DATA_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector(35 downto 0);
  type DF_INPUT_SCTMOD2DST_ADDR_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector(12 downto 0);
  type DF_INPUT_SCTMOD2DST_DATA_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector(35 downto 0);
  type DF_INPUT_IDX2MOD_ADDR_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector( 8 downto 0);
  type DF_INPUT_IDX2MOD_DATA_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector(13 downto 0);
  type DF_INPUT_STATE_MACHINE_ERROR_MONITOR_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of std_logic_vector(31 downto 0);
  type DF_INPUT_EXPECTED_NUMBER_OF_MODULE_ARRAY is array(0 to MAXIMUM_NUMBER_OF_INPUT_LANES-1) of integer range 0 to MAXIMUM_NUMBER_OF_MODULES_PER_OUTPUT_LANE-1;
  
end package;
