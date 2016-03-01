----------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.std_logic_arith.all;
    
entity GrayAddressCounter is
    generic (
      COUNTER_WIDTH :integer := 4
    );
    port (                                  --'Gray' code count output.
      GrayCount_out   :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      -- "NEXT" Binary Counter Out
      BinaryCount_out :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      Enable_in       :in  std_logic;       -- Count enable.
      Clear_in        :in  std_logic;       -- Count reset.
      clk             :in  std_logic        -- Input clock
    );  
end GrayAddressCounter;

architecture rtl of GrayAddressCounter is
  signal BinaryCount :std_logic_vector (COUNTER_WIDTH-1 downto 0) := conv_std_logic_vector(0, COUNTER_WIDTH);
begin
  BinaryCount_out <= BinaryCount; 
  process (clk, Clear_in)
  begin
    if (Clear_in = '1') then
      --Gray count begins @ '1' with
      BinaryCount   <= conv_std_logic_vector(1, COUNTER_WIDTH);  
      GrayCount_out <= (others=>'0');
      
    elsif (clk'event and clk='1') then
      -- first 'Enable_in'.
      if (Enable_in = '1') then
        BinaryCount   <= BinaryCount + 1;
        GrayCount_out <= (BinaryCount(COUNTER_WIDTH-1) & 
                          (BinaryCount(COUNTER_WIDTH-2 downto 0) xor 
                           BinaryCount(COUNTER_WIDTH-1 downto 1)));
      end if;
    end if;
  end process;
  
end rtl;


----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity short_fwft_fifo is
  port (
    clk : in std_logic;
    rst : in std_logic;
    din : in std_logic_vector ( 35 downto 0 );
    wr_en : in std_logic;
    rd_en : in std_logic;
    dout : out std_logic_vector ( 35 downto 0 );
    empty : out std_logic;
    prog_full : out std_logic
    );
end short_fwft_fifo;

architecture logic of short_fwft_fifo is
  
  constant AddressWidth : integer := 4;
  constant NStage       : integer := 2**AddressWidth;
  
  type short_buffer_t is array (0 to NStage-1) of std_logic_vector (35 downto 0);
  signal buf        : short_buffer_t := (others => (others => '0'));
  signal raddr      : std_logic_vector (AddressWidth-1 downto 0);
  signal raddr_inc  : std_logic := '0';
  signal waddr      : std_logic_vector (AddressWidth-1 downto 0);
  signal raddr_bin  : std_logic_vector (AddressWidth-1 downto 0);
  signal waddr_bin  : std_logic_vector (AddressWidth-1 downto 0);  
  signal empty_buf  : std_logic := '1';
  
  component GrayAddressCounter
    generic (
      COUNTER_WIDTH :integer := AddressWidth
      );
    port (                                  --'Gray' code count output.
      GrayCount_out   :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      -- "NEXT" Binary Counter Out
      BinaryCount_out :out std_logic_vector (COUNTER_WIDTH-1 downto 0) := (others => '0');
      Enable_in       :in  std_logic;       -- Count enable.
      Clear_in        :in  std_logic;       -- Count reset.
      clk             :in  std_logic        -- Input clock
      );  
  end component;
  
begin
  
  WriteAddress : GrayAddressCounter
    port map (
      GrayCount_out=>waddr, BinaryCount_out=>waddr_bin, Enable_in =>wr_en, Clear_in =>rst, clk=>clk);
  
  ReadAddress : GrayAddressCounter
    port map (
      GrayCount_out=>raddr, BinaryCount_out=>raddr_bin, Enable_in =>raddr_inc, Clear_in =>rst, clk=>clk);  
  
  dout <= buf(CONV_INTEGER(raddr));
  
  FullHandler : process (clk, rst)
  begin
    if    (rst='1') then
      prog_full <= '1';
    elsif (clk'event and clk='1') then
      if ((CONV_INTEGER(waddr_bin)+NStage-CONV_INTEGER(raddr_bin)) mod NStage) > NStage-7 then
        prog_full <= '1';
      else
        prog_full <= '0';
      end if;
    end if;
  end process;
  
  empty     <= empty_buf;
  raddr_inc <= '1' when ((empty_buf='0') and (rd_en='1')) else '0';
  EmptyHandler : process (clk, rst)
  begin
    if    (rst='1') then
      empty_buf <= '1';
    elsif (clk'event and clk='1') then
      if (empty_buf = '1') then
        if (wr_en='1') then
          empty_buf <= '0';
        end if;
      else 
        if (wr_en='0' and raddr_bin+1=waddr_bin) then
          empty_buf <= '1';
        end if;
      end if;
    end if;
  end process;  

  WriteOperator : process (clk)
  begin
    if (clk'event and clk='1') then
      if (wr_en='1') then
        buf(CONV_INTEGER(waddr)) <= din;
      end if;
    end if;
  end process;

end logic;
