------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

library work;
use work.data_formatter_constants.all;
library unisim;
use unisim.vcomponents.all;

entity df_internallink_input is
  port (
    MAIN_CLK : in std_logic;
    RST      : in std_logic;
    INTERNALLINK_RX_DATA    : in  DF_DATA_GT_FOR_INTERNALLINK_ARRAY;
    INTERNALLINK_RX_DVALID  : in  std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    INTERNALLINK_RX_BUSY    : out std_logic_vector(NUMBER_OF_GT_FOR_INTERNALLINK_LANES-1 downto 0);
    
    DATA_OUTPUTSW_OUT      : out DF_DATA_POST_ILI_ARRAY;
    WEN_OUTPUTSW_OUT       : out std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0);
    RDY_OUTPUTSW_IN        : in  std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0);
    
    DATA_DATASHARINGSW_OUT : out DF_DATA_POST_ILI_ARRAY;
    WEN_DATASHARINGSW_OUT  : out std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0);
    RDY_DATASHARINGSW_IN   : in  std_logic_vector(NUMBER_OF_LANES_POST_ILI-1 downto 0);    
    
    INPUT_SINGLE_SWITCH_THIS_BOARD_MASK : in  std_logic_vector(31 downto 0)
    );
end df_internallink_input;

architecture logic of df_internallink_input is
  
  component df_switch_element_1ch_in
    generic ( BUFFER_TYPE : integer := 1 );  -- 2 = (d512 + big mergin for
                                             -- full) : no longer needed!
                                             -- normal fifo is OK
                                             -- after ilink busy handling improvement
    port (
      -- common clock
      CLK : in std_logic;
      RST : in std_logic;
      -- input port
      INPUT_PORT_DIN : in  std_logic_vector(31 downto 0);
      INPUT_PORT_DEN : in  std_logic;
      INPUT_PORT_RDY : out std_logic;
      -- output port
      OUTPUT_PORT1_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT1_DEN  : out std_logic;
      OUTPUT_PORT1_RDY  : in  std_logic;
      OUTPUT_PORT2_DOUT : out std_logic_vector(31 downto 0);
      OUTPUT_PORT2_DEN  : out std_logic;
      OUTPUT_PORT2_RDY  : in  std_logic;
      -- OUTPUT MASK (CONFIGURABLE if needed)
      OUTPORT1_MASK : in std_logic_vector(31 downto 0);
      OUTPORT2_MASK : in std_logic_vector(31 downto 0)
      );
  end component;

  signal input_single_switch_other_board_mask : std_logic_vector(31 downto 0);
  
begin
  
  input_single_switch_other_board_mask <= (not INPUT_SINGLE_SWITCH_THIS_BOARD_MASK);
  
  INTERNAL_LINK_INPUT : for iLink in 0 to NUMBER_OF_LANES_POST_ILI-1 generate
    signal rx_rdy : std_logic;
    signal dvalid : std_logic;
  begin
    
    INTERNALLINK_RX_BUSY(iLink) <= not rx_rdy;
    
    dvalid <= INTERNALLINK_RX_DVALID(iLink);
    
    my_internal_link_input : df_switch_element_1ch_in
      port map (
        CLK => MAIN_CLK,
        RST => RST,
        -- input port
        INPUT_PORT_DIN => INTERNALLINK_RX_DATA(iLink),
        INPUT_PORT_DEN => dvalid,
        INPUT_PORT_RDY => rx_rdy,
        -- output port
        OUTPUT_PORT1_DOUT => DATA_OUTPUTSW_OUT(iLink),
        OUTPUT_PORT1_DEN  => WEN_OUTPUTSW_OUT(iLink),
        OUTPUT_PORT1_RDY  => RDY_OUTPUTSW_IN(iLink),
        OUTPUT_PORT2_DOUT => DATA_DATASHARINGSW_OUT(iLink),
        OUTPUT_PORT2_DEN  => WEN_DATASHARINGSW_OUT(iLink),
        OUTPUT_PORT2_RDY  => RDY_DATASHARINGSW_IN(iLink),
        -- OUTPUT MASK (CONFIGURABLE if needed)
        OUTPORT1_MASK => INPUT_SINGLE_SWITCH_THIS_BOARD_MASK,
        OUTPORT2_MASK => input_single_switch_other_board_mask
        );
  end generate;
  
end logic;
