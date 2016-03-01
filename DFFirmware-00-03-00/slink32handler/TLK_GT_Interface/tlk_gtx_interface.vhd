-------------------------------------------------------------------------------
-- Title      : Interface between TLK2501 and Virtex-6 GTX
-- Project    : HOLA S-LINK
-------------------------------------------------------------------------------
-- File       : tlk_gtx_interface.vhd
-- Author     : Stefan Haas
-- Company    : CERN PH-ESE
-- Created    : 23-11-11
-- Last update: 2014-05-02
-- Platform   : Windows XP
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Based on code from B.Green written for VILAR
-------------------------------------------------------------------------------
-- Copyright (c) 2011 CERN PH-ATE
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 23-11-11    1.0      haass	Created
-- 08-14-12    1.1      yasu.O  Modified (Down state is added)
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--library lpm;
--use lpm.lpmdeclarations.all;

entity tlk_gtx_interface is
  port (SYS_RST            : in  std_logic;
        -- SWITCH the IDLE words
        TOSENDARREAV       : in  std_logic := '0';
        -- GTX receive ports        
        GTX_RXUSRCLK2      : in  std_logic;
        GTX_RXDATA         : in  std_logic_vector(31 downto 0);
        GTX_RXCHARISK      : in  std_logic_vector(3 downto 0);
        GTX_RXENCOMMAALIGN : out std_logic;
        -- GTX transmit ports
        GTX_TXUSRCLK2      : in  std_logic;
        GTX_TXCHARISK      : out std_logic_vector(3 downto 0);
        GTX_TXDATA         : out std_logic_vector(31 downto 0);
        -- TLK2501 ports
        TLK_TXD            : in  std_logic_vector(31 downto 0);
        TLK_TXEN           : in  std_logic;
        TLK_TXER           : in  std_logic;
        TLK_RXD            : out std_logic_vector(31 downto 0);
        TLK_RXDV           : out std_logic;
        TLK_RXER           : out std_logic);
  
end tlk_gtx_interface;

-------------------------------------------------------------------------------

architecture behaviour of tlk_gtx_interface is
  
  -----------------------------------------------------------------------------
  -- 8B10B characters
  -----------------------------------------------------------------------------
  constant K28_5 : std_logic_vector(7 downto 0) := "10111100";  -- BC
  constant D5_6  : std_logic_vector(7 downto 0) := "11000101";  -- C5
  constant D16_2 : std_logic_vector(7 downto 0) := "01010000";  -- 50
  constant K23_7 : std_logic_vector(7 downto 0) := "11110111";  -- F7
  constant K30_7 : std_logic_vector(7 downto 0) := "11111110";  -- FE
  constant zero8 : std_logic_vector(7 downto 0) := "00000000";  -- 00
  
  constant IDLE_Data1 : std_logic_vector(31 downto 0) := D5_6 & D5_6 & D5_6 & K28_5;
  --constant IDLE_Data2 : std_logic_vector(31 downto 0) := D16_2 & D16_2 & D16_2 & K28_5;
  constant IDLE_Data2 : std_logic_vector(31 downto 0) := K23_7 & K23_7 & K23_7 & K23_7;
  constant IDLE_isK   : std_logic_vector(3 downto 0)  := "0001";
  
  constant IDLE_Data_ArreaV : std_logic_vector(31 downto 0) := zero8 & zero8 & K28_5 & D5_6;
  constant IDLE_isK_ArreaV  : std_logic_vector(3 downto 0)  := "0010";
  
  constant CarrierExtend_Data : std_logic_vector(15 downto 0) := K23_7 & K23_7;
  constant CarrierExtend_isK  : std_logic_vector(3 downto 0)  := "1100";
  constant NormalData_isK     : std_logic_vector(3 downto 0)  := "0000";
  constant Error_Data         : std_logic_vector(31 downto 0) := K30_7 & K30_7 & K30_7 & K30_7;
  constant Error_isK          : std_logic_vector(3 downto 0)  := "1111";
  
  -----------------------------------------------------------------------------
  -- FSM states
  -----------------------------------------------------------------------------
  type InitAndSync_t is (ACQ,
                         ACQ1,
                         ACQ2,
                         Sync,
                         Check,
                         CheckInvalid1,
                         CheckInvalid2,
                         CheckValid1,
                         CheckValid2,
                         CheckValid3);
  
  constant ACQ_c           : std_logic_vector(9 downto 0) := b"0000000001";
  constant ACQ1_c          : std_logic_vector(9 downto 0) := b"0000000010";
  constant ACQ2_c          : std_logic_vector(9 downto 0) := b"0000000100";
  constant Sync_c          : std_logic_vector(9 downto 0) := b"0000001000";
  constant Check_c         : std_logic_vector(9 downto 0) := b"0000010000";
  constant CheckInvalid1_c : std_logic_vector(9 downto 0) := b"0000100000";
  constant CheckInvalid2_c : std_logic_vector(9 downto 0) := b"0001000000";
  constant CheckValid1_c   : std_logic_vector(9 downto 0) := b"0010000000";
  constant CheckValid2_c   : std_logic_vector(9 downto 0) := b"0100000000";
  constant CheckValid3_c   : std_logic_vector(9 downto 0) := b"1000000000";
  
  -----------------------------------------------------------------------------
  -- Internal signals
  -----------------------------------------------------------------------------
  type RXStatus_t is (IDLE, CarrierExtend, NormalData, ReceiveError, OtherData, Down);
  type TXControl_t is (IDLE, CarrierExtend, NormalData, TransmitError, Down);
  
  signal TxControl               : TXControl_t;
  signal RxStatus                : RXStatus_t;
  signal RxValid                 : std_logic;  -- Valid character received
  signal RxComma                 : std_logic;  -- Comma received
  signal InitAndSyncMachine      : InitAndSync_t;
  signal next_InitAndSyncMachine : InitAndSync_t;
  signal GTX_RXDATA_REG          : std_logic_vector(GTX_RXDATA'range);
  signal TLK_TXD_REG             : std_logic_vector(TLK_TXD'range);
  
  signal GTX_RXDATA_sync         : std_logic_vector(31 downto 0);
  signal GTX_RXCHARISK_sync      : std_logic_vector(3 downto 0);
  signal GTX_TXDATA_buf          : std_logic_vector(31 downto 0);
  signal GTX_TXCHARISK_buf       : std_logic_vector(3 downto 0);
  
  --attribute KEEP_HIERARCHY : string;
  --attribute KEEP_HIERARCHY of GTX_TXDATA_DFF : label is "true";
  --attribute KEEP_HIERARCHY of GTX_TXCHARISK_DFF : label is "true";
begin
  
  -----
  -- Input latch RX
  -----
  process (GTX_RXUSRCLK2)
  begin
    if (GTX_RXUSRCLK2'event and GTX_RXUSRCLK2='1') then
      GTX_RXDATA_sync    <= GTX_RXDATA;
      GTX_RXCHARISK_sync <= GTX_RXCHARISK;
    end if;
  end process;
  --GTX_RXDATA_DFF : lpm_ff
  --  generic map (LPM_WIDTH => 16)
  --  port map (data  => GTX_RXDATA,
  --            clock => GTX_RXUSRCLK2,
  --            q     => GTX_RXDATA_sync
  --            );
  
  --GTX_RXCHARISK_DFF : lpm_ff
  --  generic map (LPM_WIDTH => 2)
  --  port map (data  => GTX_RXCHARISK,
  --            clock => GTX_RXUSRCLK2,
  --            q     => GTX_RXCHARISK_sync
  --            );

  -----
  -- Output latch TX
  -----  
  process (GTX_TXUSRCLK2)
  begin
    if (GTX_TXUSRCLK2'event and GTX_TXUSRCLK2='1') then
      GTX_TXDATA    <= GTX_TXDATA_buf;
      GTX_TXCHARISK <= GTX_TXCHARISK_buf;
    end if;
  end process;  
  --GTX_TXDATA_DFF : lpm_ff
  --  generic map (LPM_WIDTH => 16)
  --  port map (data  => GTX_TXDATA_buf,
  --            clock => GTX_TXUSRCLK2,
  --            q     => GTX_TXDATA
  --            );
  
  --GTX_TXCHARISK_DFF : lpm_ff
  --  generic map (LPM_WIDTH => 2)
  --  port map (data  => GTX_TXCHARISK_buf,
  --            clock => GTX_TXUSRCLK2,
  --            q     => GTX_TXCHARISK
  --            );
  
  -----------------------------------------------------------------------------
  -- TLK receiver synchronization state machine
  -----------------------------------------------------------------------------
  RXInitAndSyncClocking : process (GTX_RXUSRCLK2, SYS_RST) is
  begin
    if SYS_RST = '1' then
      InitAndSyncMachine <= ACQ;
    elsif GTX_RXUSRCLK2'event and GTX_RXUSRCLK2='1' then
      InitAndSyncMachine <= next_InitAndSyncMachine;
    end if;
  end process RXInitAndSyncClocking;
  
  RxValid <= '1' when ((RXStatus = NormalData) or
                       (RXStatus = ReceiveError) or
                       (RXStatus = IDLE) or
                       (RXStatus = CarrierExtend)) else '0';
  
  RxComma <= '1' when ((RXStatus = IDLE) or
                       (RXStatus = CarrierExtend)) else '0';
  
  RXInitAndSync : process (InitAndSyncMachine, RxComma, RxValid) is
  begin
    case InitAndSyncMachine is

      when ACQ =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxComma = '1') then
          next_InitAndSyncMachine <= ACQ1;
--        elsif (RxValid = '1') then 
--          next_InitAndSyncMachine <= Sync;
        else
          next_InitAndSyncMachine <= ACQ;
        end if;

      when ACQ1 =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxComma = '1') then
          next_InitAndSyncMachine <= ACQ2;
--        elsif (RxValid = '1') then
--          next_InitAndSyncMachine <= Sync;
        else
          next_InitAndSyncMachine <= ACQ;
        end if;
        
      when ACQ2 =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxComma = '1') then
          next_InitAndSyncMachine <= Sync;
--        elsif (RxValid = '1') then
--          next_InitAndSyncMachine <= Sync;
        else
          next_InitAndSyncMachine <= ACQ;
        end if;
        
      when Sync =>
        GTX_RXENCOMMAALIGN <= '0';
        if (RxValid = '1') then
          next_InitAndSyncMachine <= Sync;
        else
          next_InitAndSyncMachine <= check;
        end if;
        
      when check =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxValid = '1') then
          next_InitAndSyncMachine <= CheckValid1;
        else
          next_InitAndSyncMachine <= CheckInvalid1;
        end if;
        
      when CheckValid1 =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxValid = '1') then
          next_InitAndSyncMachine <= CheckValid2;
        else
          next_InitAndSyncMachine <= CheckInvalid1;
        end if;

      when CheckValid2 =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxValid = '1') then
          next_InitAndSyncMachine <= CheckValid3;
        else
          next_InitAndSyncMachine <= CheckInvalid1;
        end if;

      when CheckValid3 =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxValid = '1') then
          next_InitAndSyncMachine <= Sync;
        else
          next_InitAndSyncMachine <= CheckInvalid1;
        end if;

      when CheckInvalid1 =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxValid = '1') then
          next_InitAndSyncMachine <= CheckValid1;
        else
          next_InitAndSyncMachine <= CheckInvalid2;
        end if;

      when CheckInvalid2 =>
        GTX_RXENCOMMAALIGN <= '1';
        if (RxValid = '1') then
          next_InitAndSyncMachine <= CheckValid1;
        else
          next_InitAndSyncMachine <= ACQ;
        end if;

      when others =>
        GTX_RXENCOMMAALIGN      <= '1';
        next_InitAndSyncMachine <= ACQ;

    end case;

  end process RXInitAndSync;

-----------------------------------------------------------------------------
-- GTX receive decoder
-----------------------------------------------------------------------------
-- These sections are combinatorial, hopefully most of the logic is simplified
-- This decodes the MGT RX signals
-- Here we assume K characters are marked as commas but we need to ensure characters
-- not marked as Ks are not commas
  process (GTX_RXUSRCLK2, SYS_RST) is
  begin
    if SYS_RST = '1' then
      RXStatus <= DOWN; 
    elsif (GTX_RXUSRCLK2'event and GTX_RXUSRCLK2='1') then
      if ((GTX_RXCHARISK_sync = CarrierExtend_isK) and (GTX_RXDATA_sync(31 downto 16) = CarrierExtend_Data)) then
        RXStatus <= CarrierExtend;
      elsif ((GTX_RXCHARISK_sync = IDLE_isK) and ((GTX_RXDATA_sync = IDLE_Data1) or (GTX_RXDATA_sync = IDLE_Data2))) then
        RXStatus <= IDLE;
      elsif ((GTX_RXCHARISK_sync = Error_isK) and (GTX_RXDATA_sync = Error_Data))then
        RXStatus <= ReceiveError;
      elsif (GTX_RXCHARISK_sync = NormalData_isK) then
        RXStatus <= NormalData;
      else
        RXStatus <= OtherData;
      end if;
    end if;
  end process RXDecoder;

  -----------------------------------------------------------------------------
  -- TLK RXDV & RXER encoder
  -----------------------------------------------------------------------------
  process (GTX_RXUSRCLK2) is
  begin
    if (GTX_RXUSRCLK2'event and GTX_RXUSRCLK2='1') then
      --TLK_RXDV <= '1';                  -- set default
      --TLK_RXER <= '1';                  -- set default
      TLK_RXDV <= '0';
      TLK_RXER <= '0';
      if InitAndSyncMachine = sync then
        case RXStatus is
          when DOWN =>
            TLK_RXDV <= '1';
            TLK_RXER <= '1';
          when IDLE =>
            TLK_RXDV <= '0';
            TLK_RXER <= '0';
          when CarrierExtend =>
            TLK_RXDV <= '0';
            TLK_RXER <= '1';
          when ReceiveError =>
            TLK_RXDV <= '1';
            TLK_RXER <= '1';
          when NormalData =>
            TLK_RXDV <= '1';
            TLK_RXER <= '0';
          when others => null;
        end case;
      end if;
      -- Data is simply passed on unmodified
      GTX_RXDATA_REG <= GTX_RXDATA_sync;
      TLK_RXD        <= GTX_RXDATA_REG;
    end if;
  end process RXEncoder;
  
  -----------------------------------------------------------------------------
  -- TLK transmit interface decoder
  -----------------------------------------------------------------------------
  process (GTX_TXUSRCLK2, SYS_RST) is
  begin
    if SYS_RST = '1' then
      TXControl <= DOWN; 
    elsif (GTX_TXUSRCLK2'event and GTX_TXUSRCLK2='1') then
      if TLK_TXEN = '0' then
        if TLK_TXER = '0' then
          TXControl <= IDLE;
        else
          TXControl <= CarrierExtend;
        end if;
      else
        if TLK_TXER = '0' then
          TXControl <= NormalData;
        else
          TXControl <= TransmitError;
        end if;
      end if;
    end if;
  end process TXDecoder;
  
  -----------------------------------------------------------------------------
  -- GTX transmit interface encoder
  -----------------------------------------------------------------------------
  process (GTX_TXUSRCLK2) is
  begin
    if (GTX_TXUSRCLK2'event and GTX_TXUSRCLK2='1') then
      TLK_TXD_REG <= TLK_TXD;
      case TXControl is
        when DOWN =>
          GTX_TXCHARISK_buf <= NormalData_isK;
          GTX_TXDATA_buf    <= (others => '0');
        when IDLE =>
          if (TOSENDARREAV='1') then
            GTX_TXCHARISK_buf <= IDLE_isK_ArreaV;
            GTX_TXDATA_buf    <= IDLE_Data_ArreaV;
          else
            GTX_TXCHARISK_buf <= IDLE_isK;
            GTX_TXDATA_buf    <= IDLE_Data1;
          end if;
        when CarrierExtend =>
          GTX_TXCHARISK_buf <= CarrierExtend_isK;
          GTX_TXDATA_buf    <= CarrierExtend_Data & TLK_TXD_REG(15 downto 0);
        when NormalData =>
          GTX_TXCHARISK_buf <= NormalData_isK;
          GTX_TXDATA_buf    <= TLK_TXD_REG;
        when TransmitError =>
          GTX_TXCHARISK_buf <= Error_isK;
          GTX_TXDATA_buf    <= Error_Data;
      end case;
    end if;
  end process TXMux;
  
end behaviour;

