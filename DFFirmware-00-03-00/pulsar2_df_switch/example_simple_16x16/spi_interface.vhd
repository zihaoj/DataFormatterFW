--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.SpiConstants.all;
use work.SpiRegistersDeclarations.all;
use work.SpybufferConstants.all;

use work.data_formatter_constants.all;

entity spi_interface is
  port (
    -- CLK50
    CLK50    : in std_logic;
    MAIN_CLK : in std_logic;
    
    -- SPI
    SCLK    : in  std_logic;
    SPI_SEL : in  std_logic;
    MOSI    : in  std_logic;
    MISO    : out std_logic;

    -- output port
    INPUT_DATA     : in  DATA32_32X32_SWITCH_MATRIX_PORTS;
    INPUT_DATA_EN  : in  FLAGS_32X32_SWITCH_MATRIX_PORTS;
    OUTPUT_DATA    : in  DATA32_32X32_SWITCH_MATRIX_PORTS;
    OUTPUT_DATA_EN : in  FLAGS_32X32_SWITCH_MATRIX_PORTS;

    RESET_MONITOR : in  std_logic;
    SWITCH_RESET  : out std_logic;
    ENABLE_PATGEN : out std_logic    
    );
end spi_interface;

architecture logic of spi_interface is

  -----------------------------------
  -- preparation for SPI interface --
  -----------------------------------
  component  spi_slave_interface
    port (
      -- SPI
      SCLK      : in  std_logic;
      SPI_SEL   : in  std_logic;
      MOSI      : in  std_logic;
      MISO      : out std_logic;
      
      -- CLK
      SYS_CLK   : in  std_logic;
      REG_RESET : in  std_logic;
      
      -- interface for logic
      -- from logic    
      DIN       : in spi_reg_array; 
      DIN_VALID : in std_logic_vector(2**addr_width-1 downto 0);
      -- to logic
      DOUT      : out spi_reg_array
      ); 
  end component;
  signal reg_spi     : spi_reg_array := (others=>(others=>'0'));
  signal reg_logic   : spi_reg_array := (others=>(others=>'0'));
  signal valid_logic : std_logic_vector(2**addr_width-1 downto 0) := (others => '0');
  
  -----------------------------------
  -- Address definition --
  -----------------------------------   
  constant addr_reserved : integer := CONV_INTEGER(x"00");
  constant addr_reset    : integer := CONV_INTEGER(x"01");
  -- reset[0]   = transceiver_reset
  -- reset[1]   = slink_reset
  -- reset[7:2] = reserved
  
  constant addr_enable   : integer := CONV_INTEGER(x"02");
  -- enable[0]   = pattern_generator_enable
  -- enable[1]   = pattern_checker_enable
  -- enable[7:2] = reserved

  constant addr_generic_monitor : integer := CONV_INTEGER(x"03");
  
  -- spy buffer related address :
  -- READOUT0[7:0] = DOUT[ 7: 0], READOUT1[7:0] = DOUT[15: 8],
  -- READOUT1[7:0] = DOUT[23:16], READOUT1[7:0] = DOUT[31:24]
  constant addr_spy_readout0     : integer := CONV_INTEGER(x"10");
  constant addr_spy_readout1     : integer := CONV_INTEGER(x"11");
  constant addr_spy_readout2     : integer := CONV_INTEGER(x"12");
  constant addr_spy_readout3     : integer := CONV_INTEGER(x"13");  
  constant addr_spy_readaddr0    : integer := CONV_INTEGER(x"14");
  constant addr_spy_readaddr1    : integer := CONV_INTEGER(x"15");
  constant addr_spy_laneselector : integer := CONV_INTEGER(x"16");
  -- spy buffer controller
  -- CONTROLLER[0] : RESET, CONTROLLER[1] : FREEZE (1=freeze, 0=store)
  constant addr_spy_controller   : integer := CONV_INTEGER(x"17");

  -- debugging purpose (counter for received data)
  constant addr_counter0 : integer := CONV_INTEGER(x"70"); -- Counter[7:0]
  constant addr_counter1 : integer := CONV_INTEGER(x"71"); -- Counter[15:8]
  constant addr_counter2 : integer := CONV_INTEGER(x"72"); -- Counter[23:16]
  constant addr_counter3 : integer := CONV_INTEGER(x"73"); -- Counter[31:24]
  constant addr_counter_lane_selector : integer := CONV_INTEGER(x"74");

  signal buf_reset           : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_enable          : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_generic_monitor : std_logic_vector(data_width-1 downto 0) := (others => '0');
  
  signal buf_spy_readout0     : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_spy_readout1     : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_spy_readout2     : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_spy_readout3     : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_spy_readaddr0    : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_spy_readaddr1    : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_spy_laneselector : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal buf_spy_controller   : std_logic_vector(data_width-1 downto 0) := (others => '0');
  
  constant spy_lane_size : integer := (NROW_32X32_SWITCH_MATRIX*2); -- (input and output)
  signal spy_din   : spybuffer_array := (others=>(others=>'0'));
  signal spy_write_clock : std_logic_vector(spi_spybuffer_lane_max-1 downto 0) := (others=>'0');   
  signal spy_wen   : std_logic_vector(spi_spybuffer_lane_max-1 downto 0) := (others=>'0');  
  signal spy_dout  : std_logic_vector(spybuffer_data_width-1 downto 0);
  signal spy_lane_selector : std_logic_vector(spybuffer_ls_width-1 downto 0);
  signal spy_read_address  : std_logic_vector(spybuffer_addr_width_d4096-1 downto 0);
  
  constant number_of_word_counter_lanes : integer := (NROW_32X32_SWITCH_MATRIX*2);
  type   word_counter_array is array(number_of_word_counter_lanes-1 downto 0)
    of std_logic_vector(31 downto 0);
  signal word_counters : word_counter_array := (others=>(others=>'0'));
  signal selected_counter_r1   : std_logic_vector(31 downto 0);
  signal buf_counter_lane_selector : std_logic_vector(data_width-1 downto 0) := (others => '0');
  signal selected_counter_lane_id_r1   : integer range 0 to spy_lane_size-1  := 0;
  
begin
  
  SPI_INTERFACE_MODULE : spi_slave_interface
    port map (
      SCLK => SCLK, SPI_SEL => SPI_SEL, MOSI => MOSI, MISO => MISO,
      SYS_CLK => CLK50, REG_RESET => '0',
      DIN => reg_logic, DIN_VALID => valid_logic, DOUT => reg_spi); 

  -- =======================
  CHANNEL_GENERATION : for iChannel in 0 to NROW_32X32_SWITCH_MATRIX-1 generate
    signal output_din_r1  : std_logic_vector(31 downto 0);
    signal output_wen_r1  : std_logic;
    signal input_din_r1  : std_logic_vector(31 downto 0);
    signal input_wen_r1  : std_logic;    
    signal output_counter : std_logic_vector(31 downto 0);
    signal input_counter : std_logic_vector(31 downto 0);

    constant input_lane  : integer := iChannel;
    constant output_lane : integer := iChannel + NROW_32X32_SWITCH_MATRIX;
    
  begin
    
    spy_write_clock(input_lane) <= MAIN_CLK;
    spy_write_clock(output_lane) <= MAIN_CLK;
    
    process (MAIN_CLK)
    begin
      if (MAIN_CLK'event and MAIN_CLK='1') then
        output_din_r1 <= OUTPUT_DATA(iChannel);
        output_wen_r1 <= OUTPUT_DATA_EN(iChannel);
        input_din_r1  <= INPUT_DATA(iChannel);
        input_wen_r1  <= INPUT_DATA_EN(iChannel);
        spy_din(output_lane) <= output_din_r1;
        spy_wen(output_lane) <= output_wen_r1;
        spy_din(input_lane) <= input_din_r1;
        spy_wen(input_lane) <= input_wen_r1;        
      end if;
    end process;

    process (MAIN_CLK, buf_reset(0))
    begin
      if (buf_reset(0)='1') then
        input_counter  <= (others => '0');
        output_counter <= (others => '0');
      elsif (MAIN_CLK'event and MAIN_CLK='1') then
        word_counters(input_lane) <= input_counter;
        word_counters(output_lane) <= output_counter;
        
        if (input_wen_r1='1') then
          input_counter <= input_counter+1;
        end if;
        
        if (output_wen_r1='1') then
          output_counter <= output_counter+1;
        end if;        
      end if;
    end process;
    
  end generate;

  -- =======================
  register_reset : spi_writable_register port map
    (q=>buf_reset, spi_din=>reg_spi(addr_reset),
     spi_dout=>reg_logic(addr_reset), spi_valid_out=>valid_logic(addr_reset));
  SWITCH_RESET <= buf_reset(0);
  
  -- =======================
  register_enable : spi_writable_register port map
    (q=>buf_enable, spi_din=>reg_spi(addr_enable),
     spi_dout=>reg_logic(addr_enable), spi_valid_out=>valid_logic(addr_enable));
  ENABLE_PATGEN <= buf_enable(0);
  
  -- =======================  
  register_generic_monitor : spi_readonly_register port map
    (d=>buf_generic_monitor, spi_dout=>reg_logic(addr_generic_monitor), spi_valid_out=>valid_logic(addr_generic_monitor));  
  
  -- =======================
  buf_spy_readout0<=spy_dout( 7 downto  0);
  buf_spy_readout1<=spy_dout(15 downto  8);
  buf_spy_readout2<=spy_dout(23 downto 16);
  buf_spy_readout3<=spy_dout(31 downto 24);

  spy_read_address <=buf_spy_readaddr1(3 downto 0) & buf_spy_readaddr0(7 downto 0);
  spy_lane_selector<=buf_spy_laneselector;
  
  register_spy_readout0 : spi_readonly_register port map
    (d=>buf_spy_readout0, spi_dout=>reg_logic(addr_spy_readout0), spi_valid_out=>valid_logic(addr_spy_readout0));
  
  --
  register_spy_readout1 : spi_readonly_register port map
    (d=>buf_spy_readout1, spi_dout=>reg_logic(addr_spy_readout1), spi_valid_out=>valid_logic(addr_spy_readout1));
  
  --
  register_spy_readout2 : spi_readonly_register port map
    (d=>buf_spy_readout2, spi_dout=>reg_logic(addr_spy_readout2), spi_valid_out=>valid_logic(addr_spy_readout2));
  
  --
  register_spy_readout3 : spi_readonly_register port map
    (d=>buf_spy_readout3, spi_dout=>reg_logic(addr_spy_readout3), spi_valid_out=>valid_logic(addr_spy_readout3));  
  
  -- =======================
  register_spy_readaddr0 : spi_writable_register port map
    (q=>buf_spy_readaddr0, spi_din=>reg_spi(addr_spy_readaddr0),
     spi_dout=>reg_logic(addr_spy_readaddr0), spi_valid_out=>valid_logic(addr_spy_readaddr0));
  
  --
  register_spy_readaddr1 : spi_writable_register port map
    (q=>buf_spy_readaddr1, spi_din=>reg_spi(addr_spy_readaddr1),
     spi_dout=>reg_logic(addr_spy_readaddr1), spi_valid_out=>valid_logic(addr_spy_readaddr1));
  
  --
  register_spy_laneselector : spi_writable_register port map
    (q=>buf_spy_laneselector, spi_din=>reg_spi(addr_spy_laneselector),
     spi_dout=>reg_logic(addr_spy_laneselector), spi_valid_out=>valid_logic(addr_spy_laneselector));  
  
  -- =======================
  register_spy_controller : spi_writable_register port map
    (q=>buf_spy_controller, spi_din=>reg_spi(addr_spy_controller),
     spi_dout=>reg_logic(addr_spy_controller), spi_valid_out=>valid_logic(addr_spy_controller));
  
  --
  spy_buffer : spi_spy_buffer_multilanes_d4096_multi_clock_domain
    generic map ( numberOfLanes => spy_lane_size)
    port map (
      Reset  => buf_spy_controller(0),
      Freeze => buf_spy_controller(1),
      Wen  => spy_wen,
      Clk  => spy_write_clock,
      Din  => spy_din,
      Dout => spy_dout,
      LaneSelector => spy_lane_selector,
      ReadAddressBinary => spy_read_address
      );
  
  -- =======================
  register_counter_lane_selector : spi_writable_register port map
    (q=>buf_counter_lane_selector, spi_din=>reg_spi(addr_counter_lane_selector),
     spi_dout=>reg_logic(addr_counter_lane_selector), spi_valid_out=>valid_logic(addr_counter_lane_selector));

  register_counter0 : spi_readonly_register port map
    (d=>selected_counter_r1(7 downto 0), spi_dout=>reg_logic(addr_counter0), spi_valid_out=>valid_logic(addr_counter0));

  register_counter1 : spi_readonly_register port map
    (d=>selected_counter_r1(15 downto 8), spi_dout=>reg_logic(addr_counter1), spi_valid_out=>valid_logic(addr_counter1));
  
  register_counter2 : spi_readonly_register port map
    (d=>selected_counter_r1(23 downto 16), spi_dout=>reg_logic(addr_counter2), spi_valid_out=>valid_logic(addr_counter2));
  
  register_counter3 : spi_readonly_register port map
    (d=>selected_counter_r1(31 downto 24), spi_dout=>reg_logic(addr_counter3), spi_valid_out=>valid_logic(addr_counter3));     
  
  -- word counter output
  process (CLK50, buf_spy_controller(0))
  begin
    if buf_spy_controller(0)='1' then
      selected_counter_lane_id_r1 <= 0;
    elsif (CLK50'event and CLK50='1') then
      selected_counter_lane_id_r1 <= CONV_INTEGER(buf_counter_lane_selector(4 downto 0));
      selected_counter_r1 <= word_counters(selected_counter_lane_id_r1);
    end if;
  end process;
  
end logic;

