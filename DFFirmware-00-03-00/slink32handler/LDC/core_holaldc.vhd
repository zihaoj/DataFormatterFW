--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
--                                                                            --
-- File name   : core_holaldc.vhd                                             --
--                                                                            --
-- Description : Core function for an HOLA type S-LINK Link Destination       --
--               See also http://www.cern.ch/HSI/s-link/devices/hola          --
--                                                                            --
-- Authors     : Original design by Aurelio Ruiz Garcia                       --
--               Altera/Xilinx version by Jesper Moller Haee                  --
--               32bit xcvr modification by Karol Krizka                      --
--                                                                            --
-- Notes       : Do not modify this file, if you need any modifications to    --
--               the HOLALDC core, please contact the S-LINK team at CERN.    --
--                                                                            --
-- Contact     : Stefan Haas, CERN, EP-Division                               --
--               Stefan.Haas@cern.ch                                          --
--               CERN - European Organization for Nuclear Research            --
--               CH-1211 Geneva 23                                            --
--               Switzerland                                                  --
--                                                                            --
--------------------------------------------------------------------------------
--                                                                            --
--                                COPYRIGHT CERN, 2002                        --
--                                                                            --
--                     This product includes technical information            --
--                         created and made available by CERN                 --
--                                                                            --
--               Please read and respect the Copyright statement as described --
--               in the S-LINK specification, which can be found at           --
--                           http://www.cern.ch/hsi/s-link                    --
--                                                                            --
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
-- Version |    Date     |Author| Modifications                               --
--------------------------------------------------------------------------------
--    1.0  | 01-Nov-2002 |  SH  | First distribution                          --
--    1.1  | 16-Dec-2002 |  SH  | ALTERA/XILINX version                       --
--    1.2  | 18-Feb-2003 |  SH  | Update with the latest sources of HOLA LDC  --
--    1.3  | 02-May-2003 |  SH  | Incorporate changes to HOLA LDC sources,    --
--         |             |      | changes in entities PARLDC and CONTROL_LDC  --
--    1.4  | 21-May-03   |  SH  | Added power-up reset to HOLA LDC core.      --
--    1.5  | 26-May-03   |  SH  | Changed FRONT module to remove internally   --
--         |             |      | generated clock signal ICLK_2.              --
--    1.6  | 30-Jul-03   |  SH  | Changed full flag synchronization in        --
--         |             |      | FIFOLDC module. Removed unuded signal in    --
--         |             |      | FRONT module                                --
--   1.5   | 17-Feb-2014 |  KK  | Modified for 32-bit xcvr                    --
--------------------------------------------------------------------------------
--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
-- File name   : holaldc_ent.vhd                                              --
--                                                                            --
-- Author      : Aurelio Ruiz Garcia, CERN, EP-Division                       --
--                                                                            --
-- Description : Entity of an HOLA type S-LINK Link Destination Card          --
--                                                                            --
--               This design needs three global clock signals:                --
--                 LCLK, TX_CLK and RX_CLK                                    --
--                                                                            --
--                ------------------------------------------                  --
--                           TIMING REQUIREMENTS                              --
--               Clock                                                        --
--               ------------------------------------------                   --
--               LCLK           Typ. 40 MHz - external clock                  --
--               XCLK           external clock of same frequency as xcvr      --
--               TX_CLK         tx transceiver clock                          --            
--               RX_CLK         rx transceiver clock                          --
--                                                                            --
--               It is possible to work in a simulation mode by setting the   --
--               generic SIMULATION "ON", to increase speed when simulating   --
--               on a computer (more details on generics header).             --
--                                                                            --
--               HOLA LDC includes a FIFO used to separate RX_CLK and LCLK    --
--               clock domains. Parameters for the FIFO are set by the        --
--               generics FIFODEPTH,LOG2DEPTH and FULLMARGIN (see complete    --
--               description on generics header).                             --
--                                                                            --
--               This FIFO's functionality is in principle the same as the    --
--               ROMB buffer, if the generic parameters are correctly set.    --
--               The ROMB buffer is still needed to compensate the reaction   --
--               time of the LDC, but it is no longer needed to compensate    --
--               the latency of the full link.                                --
--                                                                            --
--               The user must be aware that this is exclusively an HOLA LDC  --
--               characteristic, and if any other S-Link implementation is to --
--               be used S-Link requirements must be fullfilled (recommended).--
--                                                                            --
--               DERRLED_N indicates, apart from data error signaling as      --
--               specified by the S-Link protocol, that FIFO is COMPLETELY    --
--               full, and that data might be lost.                           --
--                                                                            --
--               It is recommended to add a test connector on boards using    --
--               this core. This connector should carry the signals:          --
--               LCLK                   -- terminate near connector           --
--               LDOWN_N                                                      --
--               URESET_N                                                     --
--               UXOFF_N                                                      --
--               LWEN_N                                                       --
--               LCTRL_N                                                      --
--               LDERR_N                                                      --
--               LD0                                                          --
--               LD1                                                          --
--               LD31                                                         --
--                                                                            --
-- Synplify    : Warnings: Inputs udw unused.                                 --
--                                                                            --
-- Notes       : More information can be found in:                            --
--                                                                            --
--               http://hsi.web.cern.ch/HSI/s-link/devices/hola               --
--                                                                            --
-- Size        :                                                              --
--                                                                            --
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
--   Version   |     Date      |Author| Modifications                         --
--------------------------------------------------------------------------------
--     0.1     | 20-Feb-2002  |  ARG  | Original version                      --
--     0.2     |  7-Apr-2002  |  ARG  | Selectable simulation added           --
--             |              |       | Initialitation selection added        --
--     0.3     |  8-Apr-2002  |  ARG  | LCLK frequency selection added        --
--     0.4     |      -       |  JMH  | no change in this file - just to have --
--             |              |       | version match with Holaldc_arch.vhd   --
--     0.5     |  2-dec-2002  |  JMH  | support for both Xilinx and Altera    --
--             |              |       | the generic ALTERA_XILINX now selects --
--             |              |       | Wizard generated components, FIFO and --
--             |              |       | clock PLL's or DLL's                  --
--     0.6     |  4-Dec-2002  |  JMH  | input 'LCLK_PLL' changed to 'LCLK_IN' --
--             |              |       | Generic "LCLK_FREQ' changed to        --
--             |              |       | 'LCLK_SELECT' and aditional choice    --
--             |              |       | added so the internal LCLK generator  --
--             |              |       | can be deselected completely          --
--     0.7     |  9-dec-2002  |  JMH  | DLL_RESET input added                 --
--             |              |       | the signal affects only Xilinx DLL    --
--     0.8     | 13-may-2003  |  JMH  | added POWER_UP_RST_N                  --
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;

--==============================================================================
--==============================================================================
entity holaldc_core is
--==============================================================================
--==============================================================================
--------------------------------------------------------------------------------
-- GENERICS                                                                   --
--                                                                            --
-- SIMULATE : 1=ON/OFF=0. It sets if user wants to use the files for software --
--            simulation (ON) or if real HOLA LDC must be used (OFF)          --
--              Simulation ON : Initialitation time on each card aprox.  6 us --
--              simulation OFF: Initialitation time on each card aprox. 50 ms --
--                                                                            --
-- ACTIVITY_LENGTH : When a write operation was performed on the FIFO in the  --
--            last 2^ACTIVITY_LENGTH ICLK2 (internally generated 62.5 MHz     --
--            clock)clock cycles, the activity LED ACTIVITYLED_N will be      --
--            illuminated.                                                    --
--                                                                            --
--            Examples :                                                      --
--               ACTIVITY_LENGTH = 5 => Num. cycles = 2^5 = 32                --
--                   32 cycles x 16 ns/cycle = 512 ns.                        --
--               ACTIVITY_LENGTH = 6 => Num. cycles = 2^6 = 64                --
--                   64 cycles x 16 ns/cycle = 1.024 ms.                      --
--                                                                            --
-- FIFODEPTH: Depth of the FIFO. LFF_N will be active after                   --
--            FIFODEPTH-FULLMARGIN words are inside the FIFO.                 --
--            Maximum depth for an Altera EP20k30 device is 512 words.        --
--                                                                            --
-- LOG2DEPTH: Just your own calculation of the width of the counter that      --
--            counts how much is written. E.g. FIFODEPTH=32 => LOG2DEPTH=5;   --
--            FIFODEPTH=64 => LOG2DEPTH=6 etc.                                --
--                                                                            --
-- FULLMARGIN:Amount of words that must be guaranteed to be left before       --
--            sending the flow control signal.                                --
--                                                                            --
--            The depth of the FIFO margin is calculated with:                --
--                                                                            --
--                 RBS = (LDCrt + LSCrt + [L*UFD*2])/DTR                      --
--                                                                            --
--            with:                                                           --
--                                                                            --
--                 LDCrt = LSCrt = 120 ns                                     --
--                          UFD = 6 ns/m                                      --
--                          DTR = 16 ns/word                                  --
--            Examples:                                                       --
--                    For L  = 200 m -> 160 words                             --
--                    For L  = 300 m -> 240 words                             --
--                                                                            --
-- note : the above generics LOG2DEPTH and FIFODEPTH                          --
--        are only generics for the VHDL core itself - the                    --
--        Hardware specific wizzard generated files is not affected thes will --
--        need to be changed via the wizzard                                  --
--                                                                            --
-- ALTERA_XILINX :  generic selection specifying which hardware specific      --
--                  components to use. affected modules FIFO (memory) and     --
--                  PLL/DLL (clockgenerators)                                 --
--                  1 => Altera , 0 => Xilinx                                 --
--                                                                            --
--------------------------------------------------------------------------------

generic (
  ALTERA_XILINX    : integer :=    1;                   -- 1=Altera 0=Xilinx
  SIMULATION       : integer :=    0;                   -- simulation mode
  ACTIVITY_LENGTH  : integer :=   15;                   -- ACTLED duration
  FIFODEPTH        : integer :=  512;                   -- only powers of 2
  LOG2DEPTH        : integer :=    9;                   -- 2log of depth
  FULLMARGIN       : integer :=  256                    -- words left when
                                                        -- LFF_N set
);
port (
   POWER_UP_RST_N : in std_logic;
   -----------------------------------------------------------------------------
   -- All signals of the ICs are shown in the port description.               --
   -- The order of signals is according to the specifications of the          --
   -- S-LINK and TLK2501.                                                     --
   --                                                                         --
   -- Signals that should be driven directly on the board are shown as        --
   -- comment with the word 'direct'.                                         --
   --                                                                         --
   -----------------------------------------------------------------------------
   -- Total I/O signals(including clock pins, excl. test port)          (91)  --
   -----------------------------------------------------------------------------
   -- S-LINK signals                                                       (47)
   -----------------------------------------------------------------------------
   LD               : out  std_logic_vector(31 downto 0);
   UXOFF_N          : in   std_logic;
   URESET_N         : in   std_logic;
   UTDO_N           : in   std_logic;
--   UDW              : in   std_logic_vector( 1 downto 0); -- not used
   LCTRL_N          : out  std_logic;
   LWEN_N           : out  std_logic;
   LCLK             : out  std_logic;
   LDERR_N          : out  std_logic;
   URL              : in   std_logic_vector( 3 downto 0);
   LDOWN_N          : out  std_logic;
   -----------------------------------------------------------------------------
   -- S-LINK LEDs                                                          ( 5)
   -----------------------------------------------------------------------------
                                                          -- Vcc and Gnd with R
   TESTLED_N        : out  std_logic;                     -- Red
   LDERRLED_N       : out  std_logic;                     -- Red
   LUPLED_N         : out  std_logic;                     -- Green
   FLOWCTLLED_N     : out  std_logic;                     -- Red
   ACTIVITYLED_N    : out  std_logic;                     -- Green
   -----------------------------------------------------------------------------
   -- Special signals                                                      ( 1)
   -----------------------------------------------------------------------------
   XCLK             : in   std_logic;                     -- 100 MHz clock

   -----------------------------------------------------------------------------
   -- Serializer/Deserializer (TLK-2501) general terminals                 ( 1)
   -----------------------------------------------------------------------------
   ENABLE           : out std_logic;
   -----------------------------------------------------------------------------
   -- Transmitter side of TLK-2501 -- return lines and flow control        (18)
   -----------------------------------------------------------------------------

   TXD              : out std_logic_vector(31 downto 0);
   TX_CLK           : in  std_logic;                     -- Recovered clock.   

   -- Terminals to control the kind of data presented to the TLK-2501,
   -- and their validity

   TX_EN            : out  std_logic;
   TX_ER            : out  std_logic;
   -----------------------------------------------------------------------------
   -- Receiver side of TLK-2501 -- used for data reception                 (19)
   -----------------------------------------------------------------------------
   RXD              : in   std_logic_vector(31 downto 0); -- Received parallel
                                                          -- data
   RX_CLK           : in   std_logic;                     -- Recovered clock.

   -- Terminals to control the kind of data received from TLK-2501,
   -- and their validity
   RX_ER            : in   std_logic;
   RX_DV            : in   std_logic;
   -----------------------------------------------------------------------------
   -- Other                                                                ( 1)
   -----------------------------------------------------------------------------
   LCLK_IN          : in   std_logic;     -- this is the clock at which the data
    	                                     -- is read out of the link.
   DLL_RESET        : in std_logic        -- only affects Xilinx implementations
                                          -- and should always be low except if
                                          -- complete system is reset.
                                          -- for Altera map to GND

   );

end holaldc_core;

--==============================================================================
--==============================================================================
--------------------------------------------------------------------------------
-- END OF ENTITY
--------------------------------------------------------------------------------
--==============================================================================
--==============================================================================


--==============================================================================
--==============================================================================
--                           E N D   O F   F I L E                            --
--==============================================================================
--==============================================================================

--345678901234567890123456789012345678901234567890123456789012345678901234567890
--==============================================================================
--                                                                            --
-- File name  : front.vhd                                                     --
--                                                                            --
-- Authors    : Aurelio Ruiz                                                  --
--              Erik van der Bij. CERN, EP-Division                           --
--                                                                            --
-- Description: Input register for HOLA Link Destination Card                 --
--                                                                            --
--              Writes data received in the FIFO. All data written except:    --
--                    - IDLEs                                                 --
--                    - RRES,RLDN and TON internal commands.                  --
--                                                                            --
--              When RRES (remote reset) internal command is received, control--
--                   block is informed means output SEND_RRES                 --
--                                                                            --
--              When RLDN (Remote Link Down) internal command is received,    --
--                   control block informed means output LDOWN.               --
--                                                                            --
--              LDOWN signal also set when receiver is not properly working.  --
--              This is checked through the signals RX_DV and RX_ER.          --
--              RX_DV and RX_ER both high can have any of the following       --
--              meanings:                                                     --
--                                                                            --
--                   - Device out of normal operation mode. Both are pulled up--
--                       (high-impedance outputs).                            --
--                   - Receive error propagation. It can be due to either an  --
--                       error propagation code, or an invalid pattern. No    --
--                       difference is done between the causes.               --
--                                                                            --
--              Signal rx_down is filtered to avoid glitches that could reset --
--              the states machines dependant on that signal. Only when       --
--              keeps the value longer than 3 XCLK clock cycles, the reset    --
--              will be set.                                                  --
--                                                                            --
--              On powering up the device, or after recovering from TLK down, --
--                   the TLK device will be forced to be still 32 clock cycles--
--                   down and LDOWN signal will be set.                       --
--                                                                            --
--              Inputs : Synchr. to clock RX_CLK (125 MHz)- Recovered clock   --
--                                                          from TLK2501      --
--                       RESET                                                --
--                       RX_CLK   : 100 MHz received clk. Global signal       --
--                       RXD      : 16 bit data. Mapped to I/O registers      --
--                       RX_ER    : Receive error. Mapped to I/O register     --
--                       RX_DV    : Receive data valid. Mapped to I/O register--
--                                                                            --
--              Output : Synchr. to clock RX_CLK 100MHz                       --
--                       from recovered clock                                 --
--                       TEST_OUT : TON command received, signal sent to FIFO --
--                                  to reset it.                              --
--                       OUT_DATA : 33 bit data, with DATA(32) as command flag--
--                                  Synchr. to RX_CLK                         --
--                       WEN      : Write enable for FIFO                     --
--                                  Synchr. to RX_CLK                         --
--                       SEND_RRES: Remote reset command received             --
--                                  Synchr. to RX_CLK                         --
--                                  Guaranteed to keep the value at least for --
--                                  8 clock cycles                            --
--                       LDOWN    : Link down detected                        --
--                                  Synchr. to RX_CLK                         --
--                                  Guaranteed to keep the value at least for --
--                                  8 clock cycles                            --
--                       ACTIVITYLED_N : Activity LED                         --
--                                  A write operation was performed in the    --
--                                  2^ACTIVITY_LENTGH previous cycles.        --
--                                  A write operation includes both data and  --
--                                  internal commands.                        --
--                                                                            --
--              Command and valid data flag are set according to the          --
--                   combination of the inputs RX_ER and RX_DV shown below    --
--                                                                            --
--              Through this block, with "data" it is meant any word received --
--                   different from IDLE or internal command.                 --
--                                                                            --
--------------------------------------------------------------------------------
--   State | RX_ER | RX_DV | WEN | DATA(32) | LDOWN |       ACTION            --
--------------------------------------------------------------------------------
--  IDLE   |   0   |   0   |  0  |   -      |  0    |IDLE,do not write on FIFO--
--  COMMAND|   1   |   1   |  0  |   1      |  0    |I.command. RRES OR LDOWN --
--                            1                               - Other         --
--  DATA   |   0   |   1   |  1  |   0      |  0    |Data,control or test word--
--  WRITE  |   1   |   0   |  0  |   -      |  1    |Receive error propagation--
--  ERROR                                                                     --
--------------------------------------------------------------------------------
--                                                                            --
--              Main state machine is done to satisfy two requirements:       --
--                   - Data is read from the input always with a minimum      --
--                       set up time of one RX_CLK clock cycle (minus         --
--                       propagation delays).                                 --
--                   - Output data is always delivered to FIFO with set up    --
--                       and hold times of one RX_CLK clock cycle.            --
--              (See hardware specification for more details).                --
--                                                                            --
-- NOTES      : Not checked if FIFO is full. User will be informed            --
--                   by lighting the LDERRLED_N (see testcheck.vhd)           --
--                                                                            --
--              When synthesizing it must be checked that inputs RX_D, RX_ER  --
--                   and RX_DV are mapped to I/O registers                    --
--                                                                            --
--              Set up requirements for signals RX_DV and RX_ER must be set   --
--                   only for clock RX_CLK, and not for XCLK. It must be also --
--                   checked that the I/O registers for these pins are synchr.--
--                   to RX_CLK, and not to XCLK.                              --
--                                                                            --
--              syn_preserve attribute for signal init_state machine MUST be  --
--              kept. Otherwise, functionality mismatches are detected.       --
--                                                                            --
-- Size       : Estimated 132 LEs (11%)                                       --
--                                                                            --
--------------------------------------------------------------------------------
--    Version   |    Mod.Date   |   Author  |        Modifications            --
--------------------------------------------------------------------------------
--      1.0     |  25-Mar-2002  |   ARG/EB  |      Original Version           --
--      1.1     |  15-Apr-2002  |    ARG    |  Reset input removed, added down--
--              |               |           |  down_cnt                       --
--      1.2     |  23-Apr-2002  |    ARG    |  TEST_OUT added                 --
--      1.3     |   7-May-2002  |    ARG    |  Internal commands RRES and RLDN--
--              |               |           |  not written in FIFO            --
--      1.4     |  14-May-2002  |    ARG    |  syn_preserve attribute added   --
--      1.5     |  22-May-2002  |    ARG    |  rx_down signal filter added    --
--      1.6     |  27-Jun-2002  |    ARG    |  RRES_OFF not written to FIFO   --
--      1.7     |  25-sep-2002  |    JMH    |  reviewed, "when others" added  --
--              |               |           |  commented                      --
--      1.8     |  14-now-2002  |    JMH    |  register added on WEN and      --
--              |               |           |  OUT_DATA                       --
--      1.8a    |  17-dec-2002  |    JMH    |  removed unused signals         --
--      1.9     | 13-may-2003   |    JMH    | added POWER_UP_RST_N            --
--      2.0     | 16-may-2003   |    JMH    | decodes full internal commands  --
--              |               |           | sldown and srres only set when  --
--              |               |           | internal command recieved       --
--      2.1     | 21-may-2003   |    JMH    | FIFO in RX_CLK domain           --
--              |               |           | simplified fifo write st_machine--
--      2.1a    | 23-may-2003   |    JMH    | ICLK2 output removed            --
--      2.2     | 13-june-2003  |    JMH    | removed unused signal 'datalsb' --
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


--==============================================================================
entity FRONT is
--==============================================================================
--------------------------------------------------------------------------------
-- ACTIVITY_LENGTH : When a write operation was performed on the FIFO in the  --
--            last 2^ACTIVITY_LENGTH RX_CLK 125 MHz                           --
--            clock)clock cycles, the activity LED ACTIVITYLED_N will be      --
--            illuminated.                                                    --
--                                                                            --
--            Examples :                                                      --
--               ACTIVITY_LENGTH = 5 => Num. cycles = 2^5 = 32                --
--                   32 cycles x 16 ns/cycle = 512 ns.                        --
--               ACTIVITY_LENGTH = 6 => Num. cycles = 2^6 = 64                --
--                   64 cycles x 16 ns/cycle = 1.024 ms.                      --
--                                                                            --
--            ACTIVITY_LENGTH generic value can be set in the top level       --
--                   entity (holaldc).                                        --
--------------------------------------------------------------------------------

  generic(
    FRONT_INIT_LENGTH : integer;
    ACTIVITY_LENGTH   : integer
    );
  port (
    POWER_UP_RST_N : in std_logic;
    XCLK           : in std_logic;               -- Link check clock
    RX_CLK         : in std_logic;               -- recovered rx clk
    RX_DV          : in std_logic;               -- Control bits from
    RX_ER          : in std_logic;               -- receiver
    RXD            : in std_logic_vector(31 downto 0);  -- Received data

    TEST_OUT      : out std_logic;
    WEN           : out std_logic;      -- Write enable to FIFO
    OUT_DATA      : out std_logic_vector(32 downto 0);  -- Data for FIFO
    SEND_RRES     : out std_logic;      -- Remote reset command
                                        -- received
    RESET_SIGNAL  : out std_logic;      -- ass SEND_RRES only
                                        -- longer for sync. to
                                        -- slower clk in FIFOLDC
    LDOWN         : out std_logic;      -- Link down detected
    TLK_DOWN      : out std_logic;      -- TLK2501 not functional
    ACTIVITYLED_N : out std_logic       -- Activity LED

    );

end FRONT;

--==============================================================================
--==============================================================================
--------------------------------------------------------------------------------
-- END OF ENTITY
--------------------------------------------------------------------------------
--==============================================================================
--==============================================================================


--==============================================================================
architecture behavioural of FRONT is
--==============================================================================

-- Main state machine type declaration
  type machine_states is (NO_DATA, COMMAND, DATA);

-- Internal commands.
  constant RRES_OFF : std_logic_vector(15 downto 0) := "0000000000000000";  -- remote rst off
  constant RRES     : std_logic_vector(15 downto 0) := "0000000000000001";  -- Remote reset
  constant RLDN     : std_logic_vector(15 downto 0) := "0000000000000110";  -- Rem. link down
  constant TON      : std_logic_vector(15 downto 0) := "0000000000000101";  -- test mode begin

--CONSTANT NO_CMD    : std_logic_vector( 2 downto 0)  := "101"; -- Inexistent cmd

-- TLK states, set in signal code.
  constant RX_IDLE    : std_logic_vector( 1 downto 0) := "00";  -- IDLE received
  constant RX_DATA    : std_logic_vector( 1 downto 0) := "10";  -- Data received
  constant RX_CARRIER : std_logic_vector( 1 downto 0) := "01";  -- Carrier extend

-- Initialisation st. machine states
  constant DOWN    : std_logic_vector( 1 downto 0) := "00";
  constant WAIT1   : std_logic_vector( 1 downto 0) := "10";
  constant WAIT2   : std_logic_vector( 1 downto 0) := "11";
  constant WORK_st : std_logic_vector( 1 downto 0) := "01";

-- States for TLK down process
  constant STEP1  : std_logic := '0';
  constant DEV_UP : std_logic := '1';

-- states for sending of RESET_SIGNAL in SEND,SEND1-4 RESET_SIGNAL is 1
-- the 5 states ensures that the signal is 40 ns long and can thereby be
-- synchronized to the LCLK domain, this is done in the FIFOLDC module
  constant no_SEND   : std_logic_vector( 2 downto 0) := "000";
  constant SEND      : std_logic_vector( 2 downto 0) := "100";
  constant SEND1     : std_logic_vector( 2 downto 0) := "101";
  constant SEND2     : std_logic_vector( 2 downto 0) := "111";
  constant SEND3     : std_logic_vector( 2 downto 0) := "110";
  constant SEND4     : std_logic_vector( 2 downto 0) := "010";
  constant wait_SEND : std_logic_vector( 2 downto 0) := "011";

  signal lscreset_state, lscres_next_state : std_logic_vector(2 downto 0);
  attribute syn_preserve                   : boolean;
  attribute syn_preserve of lscreset_state : signal is true;

  signal tlk_curr_state                    : std_logic;
  signal tlk_next_state                    : std_logic;
--attribute syn_preserve  : boolean;
  attribute syn_preserve of tlk_curr_state : signal is true;

  signal curr_state : machine_states;

  signal init_state                    : std_logic_vector( 1 downto 0);
  signal next_init_state               : std_logic_vector( 1 downto 0);
--attribute syn_preserve  : boolean;
  attribute syn_preserve of init_state : signal is true;

  signal code_reg :  std_logic_vector(1 downto 0);
  signal rxd_reg  : std_logic_vector(31 downto 0);  -- input data reg

  signal sldown                         : std_logic;
  signal rx_down                        : std_logic;  -- TLK down
  signal rx_down_reg_rx                 : std_logic;  -- registered to achieve tsu for
                                                      -- large up_cnt
  signal up_cnt_high_x, up_cnt_high_x_1 : std_logic;
  signal rx_down_d2_x                   : std_logic;

  signal init_down    : std_logic;      -- Forced init.
                                        -- down
  signal swen         : std_logic;
  signal swen_act_cnt : std_logic;
                                        -- Activity LED
  signal cnt          : std_logic_vector((ACTIVITY_LENGTH-1) downto 0);  -- counter
  signal code         : std_logic_vector(1 downto 0);

  signal ssend_rres  : std_logic;
  signal stest_out   : std_logic;
  signal stest_out_d : std_logic;

  signal down_cnt_clr : std_logic;
  signal down_cnt     : std_logic_vector(6 downto 0);

  signal no_clock : std_logic;

  signal down_cnt_xclk : std_logic_vector(3 downto 0);
  signal up_cnt        : std_logic_vector(FRONT_INIT_LENGTH-1 downto 0);

  signal test_cnt      : std_logic_vector(3 downto 0);

  signal sout_data     : std_logic_vector(32 downto 0);
  signal sout_data_reg : std_logic_vector(32 downto 0);
  signal swen_reg      : std_logic;

begin

  rx_down  <= RX_ER and RX_DV;          -- Receiver down.
  no_clock <= init_down;

  rx_down_reg_rx <= code_reg(0) and code_reg(1);  -- registered version of RX_ER and RX_DV
  code(1) <= RX_DV;
  code(0) <= RX_ER;

--------------------------------------------------------------------------------
-- TLK down check                                                             --
-- TLK device can be down if RX_DV and RX_ER are high. In that case, RX_CLK   --
-- will be not running, so it's neccessary to check it using a different clock--
-- this checking is performed using the external clock.                       --
--------------------------------------------------------------------------------


-- purpose: state change
-- type   : sequential
-- inputs : xclk, POWER_UP_RST_N,tlk_next_state
-- outputs: tlk_curr_state
  tlk_down_check : process (xclk, POWER_UP_RST_N)
  begin  -- process tlk_down_check
    if POWER_UP_RST_N = '0' then          -- asynchronous reset (active low)
      tlk_curr_state <= STEP1;
    elsif xclk'event and xclk = '1' then  -- rising clock edge
      tlk_curr_state <= tlk_next_state;
    end if;
  end process tlk_down_check;

  tlk_down_machine : process(tlk_curr_state, up_cnt_high_x, DOWN_CNT_XCLK)

  begin
    case tlk_curr_state is
      when STEP1 =>

        rx_down_d2_x <= '1';
        -- in order to leave this state
        --the rx_down must be low for at least 2 in INIT_LENGHT  RX_CLK's
        if ( up_cnt_high_x = '1') then
          tlk_next_state <= DEV_UP;
        else
          tlk_next_state <= STEP1;
        end if;


      when DEV_UP =>

        rx_down_d2_x <= '0';
        -- in order to leave this state
        --the rx_down must be high for at least 8 XCLK
        if (down_cnt_xclk(down_cnt_xclk'high) = '1') then
          tlk_next_state <= STEP1;
        else
          tlk_next_state <= DEV_UP;
        end if;


      when others =>
        rx_down_d2_x   <= 'X';
        tlk_next_state <= STEP1;

    end case;
  end process;

--------------------------------------------------------------------------------
-- Link down counter                                                          --
-- To consider that the link is down, at least 8 consecutive down words       --
-- (RX_ER and RX_DV = 1) must be received.                                    --
--------------------------------------------------------------------------------
  down_count : process(rx_down, XCLK, POWER_UP_RST_N)
  begin
    if (rx_down = '0' or POWER_UP_RST_N = '0') then
      down_cnt_xclk <= (others => '0');  -- async reset
    elsif (XCLK'event and XCLK = '1') then
      if (down_cnt_xclk(down_cnt_xclk'high) = '0') then
        down_cnt_xclk <= down_cnt_xclk + 1;
      end if;
    end if;
  end process;

--------------------------------------------------------------------------------
-- Link up counter                                                            --
-- To consider that the link is up, at least 8 consecutive words different    --
-- from down words (RX_ER and RX_DV = 1) must be received.                    --
--------------------------------------------------------------------------------
  up_count : process(rx_down_reg_rx, down_cnt_xclk(down_cnt_xclk'high), RX_CLK, POWER_UP_RST_N)
  begin
    if( down_cnt_xclk(down_cnt_xclk'high) = '1' or POWER_UP_RST_N = '0') then
      up_cnt <= (others => '0');        --async reset
    elsif (RX_CLK'event and RX_CLK = '1') then
      if( rx_down_reg_rx = '1')then
        up_cnt <= (others => '0');      --sync reset
      elsif (up_cnt(up_cnt'high) = '0') then
        up_cnt <= up_cnt + 1;
      end if;
    end if;
  end process;

  xclk_sync_of_upcnt_high : process (XCLK, up_cnt(up_cnt'high), POWER_UP_RST_N)
  begin  -- process xclk_sync_of_upcnt_high
    if POWER_UP_RST_N = '0' then          -- asynchronous reset (active low)
      up_cnt_high_x   <= '0';
      up_cnt_high_x_1 <= '0';
    elsif XCLK'event and XCLK = '1' then  -- rising clock edge
      up_cnt_high_x_1 <= up_cnt(up_cnt'high);
      up_cnt_high_x   <= up_cnt_high_x_1;
    end if;
  end process xclk_sync_of_upcnt_high;

--------------------------------------------------------------------------------
-- Synchronisation input                                                      --
--------------------------------------------------------------------------------
  synchr_input : process(rx_clk)
  begin
    if (RX_CLK'event and RX_CLK = '1') then
      code_reg(1) <= RX_DV;
      code_reg(0) <= RX_ER;
      rxd_reg <= RXD;
    end if;
  end process;


--------------------------------------------------------------------------------
-- Initialisation process                                                     --
-- When the TLK device is down, RX_CLK is held low.                           --
-- On powering up the card, TLK device will be considered down although it is --
--    actually working.                                                       --
-- First state reached after powering up will be DOWN ("00"). Afterwards it   --
--    will follow the sequence:                                               --
--       DOWN -> WAIT1 -> WAIT2 -> WORK                                       --
--------------------------------------------------------------------------------

  init : process(rx_down_d2_x, rx_clk)
  begin
    if (rx_down_d2_x = '1') then        -- TLK down
      init_state <= DOWN;               -- RX_CLK held low

    elsif (RX_CLK'event and RX_CLK = '1') then  -- TLK up
      init_state <= next_init_state;
    end if;
  end process;


  init_mach : process(init_state, down_cnt)
  begin
    case init_state is

      when DOWN =>
        down_cnt_clr <= '1';
        init_down    <= '1';

        next_init_state <= WAIT1;       -- DOWN state 2 cycles


      when WAIT1 =>                     -- and WAIT2)
        down_cnt_clr <= '1';
        init_down    <= '1';

        next_init_state <= WAIT2;

      when WAIT2 =>                     -- and WAIT2)
        down_cnt_clr <= '0';
        init_down    <= '1';

        if (down_cnt(down_cnt'high) = '1') then
          next_init_state <= WORK_st;
        else
          next_init_state <= WAIT2;
        end if;

      when WORK_st =>                   -- only when out of
        down_cnt_clr <= '0';
        init_down    <= '0';            -- init. cycle

        next_init_state <= WORK_st;

      when others =>                    -- if this happens
        down_cnt_clr    <= 'X';         -- something is
        init_down       <= 'X';         -- wrong and link
        next_init_state <= DOWN;        -- must be down

    end case;
  end process;


--------------------------------------------------------------------------------
-- Input state machine                                                        --
-- This machine will be running on the recovered clock provided that the      --
-- TLK device is working on normal operation mode (RX_ER and RX_ER different  --
-- to 1). Otherwise, it will stay in the error state. This is neccessary as   --
-- the recovered clock is held low in that case.                              --
--------------------------------------------------------------------------------
  state_sel : process(no_clock, rx_clk)
  begin
    if (no_clock = '1') then            -- Link is down
                                        -- clock might not
      curr_state <= NO_DATA;            -- be running

    elsif (RX_CLK'event and RX_CLK = '1') then

      case curr_state is

        when COMMAND =>                 -- Next word is
          case code is

            when RX_DATA =>
              curr_state <= DATA;       -- data

            when others =>
              curr_state <= NO_DATA;    -- non valid event
          end case;

        when DATA =>                    -- New word?
          case code is

            when RX_CARRIER =>          -- Internal cmd.
              curr_state <= COMMAND;

            when RX_DATA =>             -- data
              curr_state <= DATA;

            when others =>              -- IDLE received
              curr_state <= NO_DATA;    -- go on waiting

          end case;

        when NO_DATA =>                 -- New word?
          case code is

            when RX_CARRIER =>          -- Internal cmd.
              curr_state <= COMMAND;

            when RX_DATA =>             -- Data received
              curr_state <= DATA;

            when others =>              -- IDLE received
              curr_state <= NO_DATA;    -- go on waiting
          end case;

        when others =>
          curr_state <= NO_DATA;
      end case;

    end if;
  end process;

  st_machine : process(RX_CLK, POWER_UP_RST_N, no_clock, code)
    variable write_cmd : std_logic;
  begin
    if POWER_UP_RST_N = '0' or no_clock = '1' then
      sSEND_RRES  <= '0';
      sldown      <= '1';
      sTEST_OUT   <= '0';
      write_cmd   := '0';
      stest_out_d <= '0';
      sWEN        <= '0';
      sout_data   <= (others => '0');

    elsif RX_CLK'event and RX_CLK = '1'then
      stest_out_d <= stest_out;

      case curr_state is

        when COMMAND =>
          case rxd_reg(15 downto 0) is                      -- now decodes all 16 bits
            -- bit 31-16 is always 0
            -- but not don't care
            -- of word
            when RRES =>                       -- Remote reset
              sSEND_RRES <= '1';               -- received
              sldown     <= '0';
              sTEST_OUT  <= '0';
              write_cmd  := '0';               --don't send to FIFO

            when RLDN =>              -- Rem.link down
              sSEND_RRES <= '0';      -- received
              sldown     <= '1';
              sTEST_OUT  <= '0';
              write_cmd  := '0';      --don't send to FIFO

            when TON =>               -- Rem.link down
              sSEND_RRES <= '0';      -- received
              sldown     <= '0';
              sTEST_OUT  <= '1';
              write_cmd  := '0';      --don't send to FIFO

            when RRES_OFF =>          -- Other cmds
              sSEND_RRES <= '0';      -- clear signals
              sldown     <= '0';
              sTEST_OUT  <= '0';
              write_cmd  := '0';      --don't send to FIFO
            when others =>            -- Other cmds
              sSEND_RRES <= '0';      -- clear signals
              sldown     <= '0';
              sTEST_OUT  <= '0';
              write_cmd  := '1';      -- send to FIFO
          end case;
          sout_data(32)           <= '1';        -- Output data
          sout_data(31 downto 16) <= (others => '1');    -- otherwise
          sout_data(15 downto 0)  <= rxd_reg(15 downto 0);    -- with cmd flag
          sWEN                    <= write_cmd;  -- write if cmd not

        when DATA =>
          sTEST_OUT <= '0';
          sout_data(32)           <= '0';      -- Output data
          sout_data(31 downto 0)  <= rxd_reg;  -- without flag
          sWEN                    <= '1';

        when NO_DATA =>
          sout_data   <= (others => '0');
          sTEST_OUT <= '0';
          sWEN <= '0';

        when others =>
          sout_data   <= (others => 'X');
          sTEST_OUT <= 'X';

      end case;
    end if;
  end process;



--------------------------------------------------------------------------------
-- Down_cnt proccess                                                          --
-- Counter used to make initial down state longer to give the PLLs time to    --
-- have valid outputs.                                                        --
--------------------------------------------------------------------------------

  down_cnt_proc : process(RX_CLK, down_cnt_clr, POWER_UP_RST_N )
  begin
    if (down_cnt_clr = '1' or POWER_UP_RST_N = '0') then
      down_cnt <= (others => '0');
    elsif (RX_CLK'event and RX_CLK = '1') then
      down_cnt <= down_cnt + '1';
    end if;
  end process;


--------------------------------------------------------------------------------
-- ACTIVITY LED                                                               --
-- Active LED will be kept low unless no write operation was performed in the --
-- 2^ACTIVITY_LENGTH previous cycles.                                         --
-- Activity_led will take the value of the MSB of counter. This bit is held   --
-- high when:                                                                 --
--     - Init. process                                                        --
--     - Maximum count after the last write operation already reached.        --
--------------------------------------------------------------------------------

  cntactledproc : process(no_clock, RX_CLK)
  begin

    if (no_clock = '1') then            -- When device down
      cnt <= (others => '1');           -- counter all 1s
                                        -- LED off
    elsif RX_CLK'event and RX_CLK = '1' then
      if (swen_act_cnt = '1') then

        cnt <= (others => '0');         -- Clear counter
                                        -- after write op
                                        -- LED on
      elsif (cnt(cnt'high) = '0') then  -- count if max.
        cnt <= cnt + '1';               -- not reached

      end if;
    end if;
  end process;

--------------------------------------------------------------------------------
-- LSC reset signal machine                                                   --
--------------------------------------------------------------------------------

  lsc_reset_proc : process(rx_down_d2_x, rx_clk)
  begin
    if (RX_DOWN_D2_X = '1') then
      lscreset_state <= no_send;
    elsif RX_CLK'event and RX_CLK = '1' then
      lscreset_state <= lscres_next_state;
    end if;

  end process;

  lsc_reset_mach : process(lscreset_state, ssend_rres)
  begin
    case lscreset_state is
      when no_send =>
        reset_signal <= '0';
        if (ssend_rres = '1') then
          lscres_next_state <= send;
        else
          lscres_next_state <= no_send;
        end if;

      when send =>
        reset_signal      <= '1';
        lscres_next_state <= send1;

      when send1 =>
        reset_signal      <= '1';
        lscres_next_state <= send2;
      when send2 =>
        reset_signal      <= '1';
        lscres_next_state <= send3;

      when send3 =>
        reset_signal      <= '1';
        lscres_next_state <= send4;

      when send4 =>
        reset_signal      <= '1';
        lscres_next_state <= WAIT_SEND;

      when wait_SEND =>
        reset_signal <= '0';

        if (ssend_rres = '1') then
          lscres_next_state <= wait_SEND;
        else
          lscres_next_state <= no_send;
        end if;

      when others =>
        reset_signal      <= 'X';
        lscres_next_state <= no_send;

    end case;
  end process;

  testproc : process(no_clock, rx_clk)
  begin

    if (no_clock = '1') then                      -- When device down
      test_cnt <= (others => '1');                -- counter all 1s
                                                  -- LED off
    elsif rx_clk'event and rx_clk = '1' then
      if ( stest_out_d = '1') then
        test_cnt <= (others => '0');              -- Clear counter
                                                  -- after write op
                                                  -- LED on
      elsif (test_cnt(test_cnt'high) = '0') then  -- count if max.
        test_cnt <= test_cnt + '1';               -- not reached

      end if;
    end if;
  end process;
--------------------------------------------------------------------------------
-- Output registers
--------------------------------------------------------------------------------
  out_proc : process
  begin
    wait until RX_CLK'event and RX_CLK = '1';
    SEND_RRES <= ssend_rres;
    LDOWN     <= sldown or init_down;
    TLK_DOWN  <= init_down;
  end process;

  ACTIVITYLED_N <= cnt(cnt'high);

  test_out <= not (test_cnt(test_cnt'high));


  output_reg : process
  begin
    wait until RX_CLK'event and RX_CLK = '1';
    swen_reg      <= swen;
    swen_act_cnt  <= swen;
    sout_data_reg <= sout_data;
  end process;

  OUT_DATA <= sout_data_reg;
  WEN      <= swen_reg;

end behavioural;
--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------
--345678901234567890123456789012345678901234567890123456789012345678901234567890
--==============================================================================
--                                                                            --
-- File name  : fifoldc.vhd                                                   --
--                                                                            --
-- Author     : Aurelio Ruiz, EP-Division, CERN                               --
--                                                                            --
-- Description: Dual clock, synchronous FIFO for the LDC.                     --
--                                                                            --
--              Is of the "show-ahead" type, which means                      --
--              that the data is shown before a read is done. Effectively,    --
--              the "not empty" flag is more like a "data available" flag.    --
--                                                                            --
--              For the rest it is a normal FIFO with an LFF_N output that    --
--              shows that only a few extra words may be written (set by      --
--              generic FULLMARGIN).                                          --
--                                                                            --
--              The depth of the FIFO margin is calculated with:              --
--                                                                            --
--                RBS = (LDCrt + LSCrt + [L*UFD*2])/DTR                       --
--                                                                            --
--              with:                                                         --
--                                                                            --
--                LDCrt = LSCrt = 120 ns                                      --
--                          UFD = 6 ns/m                                      --
--                          DTR = 16 ns/word                                  --
--                                                                            --
--                    For L  = 200 m -> 160 words                             --
--                    For L  = 300 m -> 240 words                             --
--                                                                            --
--              LFF_N flag is sent to block control, so that an XOFF          --
--              signal is sent to te LSC. This signal (port LFF_N) is sent    --
--              when there are less than FULLMARGIN words left in the FIFO.   --
--                                                                            --
--              With output FULL it is signaled that FIFO is completely full. --
--              This situation should never happen if FULLMARGIN has been     --
--              correctly set. Should it occur, FULL will be set so that the  --
--              data error led DERRLED_N is illuminated.                      --
--                                                                            --
--              Maximum FIFODEPTH for an Altera EP20k30 is 512 words.         --
--                                                                            --
--              On starting a test cycle the FIFO is reset.                   --
--                                                                            --
-- Notes      : Based on fifolsc.vhd (ODIN implementation)                    --
--              by Erik van der Bij, EP-division CERN                         --
--                                                                            --
--              Only works correctly with Altera FPGAs with dual ported       --
--              memory. APEX II, APEX 20K, Mercury and 10KE all do have this, --
--              10KA devices don't.                                           --
--                                                                            --
--------------------------------------------------------------------------------
--                            Revision History                                --
--------------------------------------------------------------------------------
-- Version |   Mod.Date  |Author| Modifications                               --
--------------------------------------------------------------------------------
--  1.0    |  5-Feb-2002 | ARG  | First version                               --
--  1.1    |  9-Apr-2002 | ARG  | Write empty removed                         --
--  1.2    | 22-Apr-2002 | ARG  | FIFO reset before test                      --
--  1.3    |  3-Jun-2002 | ARG  | Removed reset when test and rres            --
--  1.4    | 10-Jun-2002 | ARG  | Full flag sent when half fifo full          --
--  1.5    | 18-sep-2002 | JMH  | reviewed, Link Full Flag send when less than--
--         |             |      | FULLMARGIN is left in the FIFO              --
--         |             |      | version 1.4 never worked like described by  --
--         |             |      | ARG on 10-Jun-2002.                         --
--  1.6    | 28-Oct-2002 | JMH  | Altera LPM moved to file: FIFO_LPM_LDC.VHD  --
--         |             |      | this is to ease vendor change               --
--         |             |      | makes no funktional change                  --
--  1.7    | 2-dec-2002  | JMH  | support for both Altera and Xilinx          --
--         |             |      | the FIFO must now be named AFIFOLDC or      --
--         |             |      | XFIFOLDC - selected by the generic          --
--         |             |      | ALTERA_XILINX  1 is Altera and 0 is Xilinx  --
--  1.8    | 12-dec-2002 | JMH  | Altera FIFO changed to have a full flag sync--
--         |             |      | to writeclk like the Xilinx version         --
--         |             |      | also the DERRLED will now stay on until rst --
--         |             |      | after full event                            --
--  1.8a   | 17-dec-2002 | JMH  | full flag now reset asynchronous -like FIFO --
--  1.8b   | 10-feb-2003 | JMH  | the registered fulle flag is now edge trig. --
--  1.9    | 13-may-2003 | JMH  | added POWER_UP_RST_N                        --
--  2.0    | 23-may-2003 | JMH  | ICLK2 replaced by RX_CLK                    --
--  2.1    | 13-june-2003| JMH  | changed the FULL_sync process to use RX_CLK --
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;        -- needed to compare
                                        -- of vector and int

--==============================================================================
entity FIFOLDC is
--==============================================================================
--------------------------------------------------------------------------------
-- GENERICS                                                                   --
-- FIFODEPTH: Depth of the FIFO. LFF_N will be active after                   --
--            FIFODEPTH-FULLMARGIN words have been written to the FIFO.       --
--            Maximum depth for an Altera EP20k30 device is 512 words.        --
-- LOG2DEPTH: Just your own calculation of the width of the counter that      --
--            counts how much is written. E.g. FIFODEPTH=32 => LOG2DEPTH=5;   --
--            FIFODEPTH=64 => LOG2DEPTH=6 etc.                                --
-- FULLMARGIN:Amount of words that must be guaranteed to be left before       --
--            sending the flow control signal.                                --
-- ALTERAvsXILINX: selects the device specific wizard component to enstantiate--
--------------------------------------------------------------------------------

  generic(
    ALTERA_XILINX : integer;            -- 1=Altera 0=Xilinx
    FIFODEPTH     : integer;            -- only powers of 2
    LOG2DEPTH     : integer;            -- 2log of depth
    FULLMARGIN    : integer             -- words left when LFF_N
    );                                  -- set

  port (
    POWER_UP_RST_N : in  std_logic;
    RESET          : in  std_logic;     -- async clear
    TEST_IN        : in  std_logic;
    TEST_OUT       : out std_logic;
    RRES_IN        : in  std_logic;
    RRES_OUT       : out std_logic;
    RX_CLK         : in  std_logic;     -- write clock
    UD             : in  std_logic_vector(32 downto 0);  -- ctl bit and input
                                                         -- data from LSC
    WEN            : in  std_logic;
    REN            : in  std_logic;     -- read enable
    DATA           : out std_logic_vector(32 downto 0);  -- output data
    EMPTY          : out std_logic;     -- empty flag, synchr.
    FULL           : out std_logic;     -- Full Flag for testing
                                        -- synchr.to write clock
    LFF_N          : out std_logic;     -- Full Flag and XOFF
    LCLK           : in  std_logic      -- read clock,
    );

end FIFOLDC;


--==============================================================================
architecture behavioural of FIFOLDC is
--==============================================================================

  component XFIFOLDC_my_wrapper             -- wizard generated FIFO for Xilinx Devices
    port (
      din      : in  std_logic_vector(32 downto 0);
      wr_en    : in  std_logic;
      wr_clk   : in  std_logic;
      rd_en    : in  std_logic;
      rd_clk   : in  std_logic;
      rst      : in  std_logic;
      dout     : out std_logic_vector(32 downto 0);
      empty    : out std_logic;         -- sync. to rd_clk
      full     : out std_logic;         -- sync. to wr_clk
      rd_data_count : out std_logic_vector((LOG2DEPTH - 1) downto 0));  -- check names
  end component;

  component AFIFOLDC  -- wizard generated FIFO for Altera Devices
    port (
      data    : in std_logic_vector (32 downto 0);
      wrreq   : in std_logic;
      rdreq   : in std_logic;
      rdclk   : in std_logic;
      wrclk   : in std_logic;
      aclr    : in std_logic;

      q       : out std_logic_vector (32 downto 0);
      rdempty : out std_logic;
      wrfull  : out std_logic;
      rdusedw : out std_logic_vector (LOG2DEPTH-1 downto 0)
      );
  end component;


  signal rdusedw : std_logic_vector((LOG2DEPTH - 1) downto 0);


  signal sub_rdfull    : std_logic;
  signal sub_rdfull_1  : std_logic;
  signal sub_rdfull_wr : std_logic;

  signal slff_n     : std_logic;
  signal slff_n2    : std_logic;
  signal in_reset   : std_logic;
  signal testin_reg : std_logic;

  signal rres_reg  : std_logic;
  signal empty_buf : std_logic;
  
--==============================================================================
begin
--==============================================================================
  EMPTY <= empty_buf;

  AFIFO : if ALTERA_XILINX = 1 generate
    AFIFOLDC1 : AFIFOLDC                -- Altera FIFO FIFODEPTH *33
      port map (                        -- the FIFO must be made to
        data    => UD,                  -- match the generics
        wrreq   => WEN,                 -- FIFODEPTH and LOG2DEPTH
        rdreq   => REN,
        rdclk   => LCLK,
        wrclk   => RX_CLK,
        aclr    => in_reset,
        q       => DATA,
        rdempty => empty_buf,           -- empty synchr.to LCLK
        wrfull  => sub_rdfull_wr,       -- full synchr. to RX_CLK
        rdusedw => rdusedw);
  end generate;

  XFIFO : if ALTERA_XILINX = 0 generate
    XFIFOLDC1 : XFIFOLDC_my_wrapper     -- Xilinx FIFO FIFODEPTH * 33
      port map (                        -- the FIFO must be made to
        din      => UD,                 -- match the generics
        wr_en    => WEN,                -- FIFODEPTH and LOG2DEPTH
        rd_en    => REN,
        rd_clk   => LCLK,
        wr_clk   => RX_CLK,
        rst      => in_reset,
        dout     => DATA,
        empty    => empty_buf,          -- empty synchr.to LCLK
        full     => sub_rdfull_wr,      -- full synchr. to RX_CLK
        rd_data_count => rdusedw);
  end generate;

  FULL_sync : process(in_reset, RX_CLK )
  begin
    if ( in_reset = '1' )then           -- asynch reset
      sub_rdfull <= '0';
    elsif Rising_Edge(RX_CLK) then
      if sub_rdfull_wr = '1' and empty_buf='0' then
        sub_rdfull <= '1';
      end if;
    end if;
  end process;

  LCLK_sync : process
  begin
    wait until LCLK'event and LCLK = '1';
    sub_rdfull_1 <= sub_rdfull;
    FULL         <= sub_rdfull_1;       -- full synchr. to LCLK
  end process;

  in_reset <= RESET or TEST_IN or RRES_IN or (not POWER_UP_RST_N);

--------------------------------------------------------------------------------
-- LFF PROCESS : LFF_N is set low when only FULLMARGIN or fewer cells are     --
--               still free to allow a response time in the write process     --
--               as described in header.                                      --
--------------------------------------------------------------------------------

  lffprocess : process
    variable v : integer range FIFODEPTH-1 downto 0;
  begin
    wait until LCLK'event and LCLK = '1';
    v := conv_integer(rdusedw);         -- use tmp variable
    if (v >= (FIFODEPTH - FULLMARGIN)) then
      slff_n <= '0';
    else
      slff_n <= '1';
    end if;
  end process;

  reg_proc : process
  begin
    wait until LCLK'event and LCLK = '1';
    slff_n2    <= slff_n;
    LFF_N      <= slff_n2;
    rres_reg   <= RRES_IN;
    RRES_OUT   <= rres_reg;
    testin_reg <= TEST_IN;
    TEST_OUT   <= testin_reg;
  end process;
  
end behavioural;

--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------
--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
--                                                                            --
-- File name   : frameldc.vhd                                                 --
--                                                                            --
-- Author      : Aurelio Ruiz                                                 --
--                                                                            --
-- Description : Read operation on FIFO and decodification of internal        --
--               commands, and detection of test and control words.           --
--                                                                            --
--               Inputs : CLK       -> Input clock LCLK.                      --
--                        LD        -> 33-bit input data from FIFO            --
--                                     LD(32)    : Internal command flag      --
--                                     LD(31..0) : Data                       --
--                        UXOFF     -> Flow control                           --
--                        EMPTY     -> FIFO empty.                            --
--                        FULL      -> FIFO full                              --
--                        RESET_IN  -> Reset signal                           --
--                                                                            --
--               Outputs: LD_O      -> 32-bit output data                     --
--                        REN       -> read enable for FIFO                   --
--                        CTRL_FLAG -> Marks data LD_O as control word.       --
--                        DATA_FLAG -> Marks data LD_O as normal data or test --
--                                     word (when TEST_FLAG = 1)              --
--                        TEST_FLAG -> Card in test mode.                     --
--                        CRC_FLAG  -> Next word CRC Checksum.                --
--                        FULL_OUT  -> FIFO full signal (propagate until      --
--                                     testcheck block).                      --
--                                                                            --
--              FIFO is of the "show-ahead" type. That means, data can be     --
--              accessed before being actually read from it.                  --
--                                                                            --
--              LD(32) is the internal command flag. Data with that bit set   --
--              will have the 3 LSB with a special meaning. Possible actions  --
--              are listed below:                                             --
--                                                                            --
--              -----------------------------------------------------------   --
--              |   LD(2..0)  |    Meaning   |        Action              |   --
--              ------------- | ------------ | ----------------------------   --
--              |    010      |      CRCC    |   Next word CRC Checksum   |   --
--              |    011      |       NCW    |   Next word control word   |   --
--              |    100      |      TOFF    |   Test ends                |   --
--              |   Other     |      ----    |   Ignore                   |   --
--              -----------------------------------------------------------   --
--                                                                            --
--              Internal commands TON, RRES and RLDN were already checked in  --
--              FRONT block and are therefore ignored here.                   --
--              Wrong commands received are also ignored.                     --
--                                                                            --
--              A reset clears test mode.                                     --
--                                                                            --
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
-- Version |    Date      |   Author   |    Modifications                     --
--------------------------------------------------------------------------------
--   0.1   | 17-Feb-2002  |    ARG     |    Original version                  --
--   0.2   |  9-Apr-2002  |    ARG     | Output registers removed, comments   --
--         |              |            | added                                --
--   0.3   | 24-sep-2002  |    JMH     | reviewed, found unneeded latency when--
--         |              |            | control words received also the state--
--         |              |            | machine complexity was decreased     --
--         |              |            | significantly                        --
--         |              |            | after the change the CRCFLAG is no   --
--         |              |            | longer sent one clock cycle before   --
--         |              |            | the CRCCHECKSUM but together with it --
--         |              |            | therefore a small changes was needed --
--         |              |            | in CRCLDC module as well             --
--   0.4   | 07-Nov-2002  |    JMH     | State machine rewritten to support   --
--         |              |            | non-show-ahead FIFO's - show-ahead   --
--         |              |            | FIFO's are not supported in Xilinx   --
--         |              |            | and new altera devices like Stratix  --
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;


--------------------------------------------------------------------------------
-- Entity declaration
--------------------------------------------------------------------------------

entity FRAMELDC is

  port (
    CLK                      : in  std_logic;                     -- Input clock
    TEST_IN                  : in  std_logic;                     -- test input
                                                                  -- sync. ICLK2
    LD                       : in  std_logic_vector (32 downto 0);-- Data input
    UXOFF_N                  : in  std_logic;                     -- Flow ctrl.
    EMPTY                    : in  std_logic;                     -- FIFO empty
    FULL                     : in  std_logic;                     -- FIFO full
    RRES_IN                  : in  std_logic;
    RRES_OUT                 : out std_logic;

    REN                      : out std_logic;                     -- Read enable
    LD_O                     : out std_logic_vector (31 downto 0);-- Data output
    CTRL_FLAG                : out std_logic;                     -- CTRL. flag
    DATA_FLAG                : out std_logic;                     -- Data flag
    TEST_FLAG                : out std_logic;                     -- Test mode
    CRC_FLAG                 : out std_logic;                     -- CRC Checks.
    FULL_OUT                 : out std_logic;                     -- FIFO full
    RESET_IN                 : in  std_logic                      -- Reset from
                                                                  -- control
  );

end FRAMELDC;

architecture behaviour of FRAMELDC is

-- Internal commands. MSB set to zero, and ignored in following blocks
-- TON, RRES and RLDN commands are ignored in this block

CONSTANT CRCC                : std_logic_vector(2 downto 0):="010";
CONSTANT NCW                 : std_logic_vector(2 downto 0):="011";
CONSTANT TOFF                : std_logic_vector(2 downto 0):="100";

-- for non show-ahead fifo

--FIFO read State machine constants
-- state machine states are dicrectly mapped to outputs
-- bit1 = REN
-- bit0 = tells the output statemachine that data is valid
CONSTANT NO_READ_NO_OUTPUT   : std_logic_vector(1 downto 0):= "00";
CONSTANT NO_READ_OUTPUT      : std_logic_vector(1 downto 0):= "01";
CONSTANT READ_NO_OUTPUT      : std_logic_vector(1 downto 0):= "10";
CONSTANT READ_OUTPUT         : std_logic_vector(1 downto 0):= "11";

--Output state machine constants
-- state machine states are dicrectly mapped to outputs
-- bit2 = CTRL_FLAG
-- bit1 = CRC_FLAG
-- bit0 = DATA_FLAG
CONSTANT DATA                : std_logic_vector(2 downto 0):= "001";
CONSTANT CRC_CHECKSUM        : std_logic_vector(2 downto 0):= "010";
CONSTANT CTRL_WORD           : std_logic_vector(2 downto 0):= "100";
CONSTANT INTERNAL_CMD_OR_IDLE: std_logic_vector(2 downto 0):= "000";

--------------------------------------------------------------------------------
-- Signal declarations
--------------------------------------------------------------------------------

signal int_test_flag         : std_logic;           -- testmodeflag latch
signal clr_test              : std_logic;           -- clear testmode latch

signal reg_test_in           : std_logic;           -- test in register


-- for non show-ahead fifo
--state variables for read state machine
signal FIFO_READ_STATE  : std_logic_vector(1 downto 0);  -- Current State

--state variables for output state machine
signal CURR_OUTPUT_STATE     : std_logic_vector(2 downto 0);  -- Current State
signal NEXT_OUTPUT_STATE     : std_logic_vector(2 downto 0);  -- Next State


--------------------------------------------------------------------------------
-- Entity
--------------------------------------------------------------------------------
begin

FULL_OUT                 <= FULL;                     -- FIFO full just wired
RRES_OUT                 <= RRES_IN;                  -- RRES in wired to out

--------------------------------------------------------------------------------
-- Entity processes
--------------------------------------------------------------------------------

-- for non show-ahead fifo
--------------------------------------------------------------------------------
-- FIFO read State machine                                                    --
-- The block will be reading data if the FIFO is not empty and flow control   --
-- was not set by the user.                                                   --
--------------------------------------------------------------------------------

FIFO_read_state_machine: process (clk)
begin
   if(clk'event and clk = '1')then
      if (reset_in = '1' or RRES_IN = '1' or test_in ='1') then
         FIFO_READ_STATE <= NO_READ_NO_OUTPUT;
      else
         case FIFO_READ_STATE is
            -- Dont read from FIFO - output is not valid
            when NO_READ_NO_OUTPUT =>
               if (UXOFF_N = '1' and EMPTY = '0')then     -- after this cycle
                  FIFO_READ_STATE <= READ_NO_OUTPUT;      -- fifo is read but
               end if;                                    -- data is invalid

            -- Dont read from FIFO - Output is valid
            when NO_READ_OUTPUT    =>
               if (UXOFF_N = '0' or EMPTY = '1')then      -- after this cycle
                  FIFO_READ_STATE <= NO_READ_NO_OUTPUT;   -- fifo is not read
               else                                       -- data is invalid
                  FIFO_READ_STATE <= READ_NO_OUTPUT;      -- after this cycle
               end if;                       -- fifo is read but data is invalid

            -- Read from FIFO - Output is not valid
            when READ_NO_OUTPUT    =>
               FIFO_READ_STATE <= READ_OUTPUT;            -- next words is valid

            -- Read from FIFO - Output is valid
            when READ_OUTPUT       =>
               if (EMPTY = '1')then                       -- after this cycle
                  FIFO_READ_STATE <= NO_READ_NO_OUTPUT;   -- fifo FIFO is empty
               elsif(UXOFF_N = '0')then                   -- after this cycle
                  FIFO_READ_STATE <= NO_READ_OUTPUT;      -- FIFO is not read
               end if;                                    -- next words is valid

            when others            =>
               FIFO_READ_STATE    <= NO_READ_NO_OUTPUT;
         end case;
      end if;
   end if;
end process;

REN                  <= FIFO_READ_STATE(1);

--------------------------------------------------------------------------------
-- Output state machine                                                       --
-- if the data read from the FIFO is valid then this machine will proceed     --
-- If the data is a command word, meaning will be decoded and the suitable    --
-- action performed:                                                          --
--                                                                            --
--    - NCW -> Next word control word. Send next word with CTRL_FLAG set      --
--    - CRCC-> Next word CRC Checksum. To satisfy CRC checker requirements,   --
--             CRC_FLAG will only be sent once the CRC Checksum was read from --
--             the FIFO (to guarantee that there is no gap between them)      --
--    - TOFF-> Test mode ends, TEST_FLAG cleared.                             --
--    - TON, RRES, RLDN -> Remote reset and link down were already checked in --
--             inblock, here ignored.                                         --
--                                                                            --
-- If an incorrect internal command was received, it will be ignored as well  --
--------------------------------------------------------------------------------
Output_state_change: process(clk)
begin
   if(clk'event and clk = '1')then
      if (reset_in = '1' or RRES_IN = '1' or test_in ='1') then
         if(test_in ='1')then
            clr_test              <= '0'; --remove Tmode out signal
         else
            clr_test              <= '1';
         end if;
         CURR_OUTPUT_STATE <= INTERNAL_CMD_OR_IDLE;
         NEXT_OUTPUT_STATE <= DATA;
      elsif(FIFO_READ_STATE(0) = '0') then          -- data in register
         CURR_OUTPUT_STATE <= INTERNAL_CMD_OR_IDLE; -- is invalid, state change
         clr_test         <= '0';                   -- nutralized
      elsif(LD(32)='1')then                         -- internal command
         CURR_OUTPUT_STATE <= INTERNAL_CMD_OR_IDLE; -- FIFO set up next word
         case LD(2 downto 0) is
            when CRCC     =>                        -- next word CRC
               NEXT_OUTPUT_STATE <= CRC_CHECKSUM;
               clr_test   <= '0';
            when NCW      =>                        -- next word control
               NEXT_OUTPUT_STATE <= CTRL_WORD;
               clr_test   <= '0';
            when TOFF     =>                        -- test mode off
               NEXT_OUTPUT_STATE <= DATA;
               clr_test   <= '1';                   -- remove Tmode out signal
            when others   =>
               NEXT_OUTPUT_STATE <= DATA;
               clr_test   <= '0';
         end case;
      else
         CURR_OUTPUT_STATE <= NEXT_OUTPUT_STATE;
         NEXT_OUTPUT_STATE <= DATA;
         clr_test   <= '0';
      end if;
   end if;
end process;
     CRC_FLAG             <= CURR_OUTPUT_STATE(1);
     CTRL_FLAG            <= CURR_OUTPUT_STATE(2);
     DATA_FLAG            <= CURR_OUTPUT_STATE(0);



--------------------------------------------------------------------------------
-- Test mode flag set when a TON command was received, and removed either by  --
-- a TOFF command or a reset. In other case, the value is kept (card is in    --
-- test mode).                                                                --
-- Test words are marked by TEST_FLAG = '1' and DATA_FLAG = '1'               --
--------------------------------------------------------------------------------
testflag_proc:process
begin
   wait until CLK'event and CLK = '1';
   if(clr_test = '1') then
      int_test_flag   <= '0';
   elsif(reg_test_in = '1')then
      int_test_flag   <= '1';
   end if;
end process;

--------------------------------------------------------------------------------
-- Input synchronisation                                                      --
--------------------------------------------------------------------------------
insync_proc: process
begin
  wait until clk'event and clk = '1';
  reg_test_in             <= TEST_IN;
end process;

--------------------------------------------------------------------------------
-- Output process                                                             --
--------------------------------------------------------------------------------
out_proc: process
begin
  wait until clk'event and clk = '1';
    TEST_FLAG               <= int_test_flag;
    LD_O                    <= LD(31 downto 0);
end process;

end behaviour;

--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------

--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
--                                                                            --
-- File name   : crcgen_ldc.vhd                                                   --
--                                                                            --
-- Author      : Erik Brandin, CERN, EP-Division                              --
--                                                                            --
-- Description : A 16 bit CRC with 16 bit look-ahead. Uses the CRC-CCITT      --
--               polynomial x^16+x^12+x^5+1                                   --
--               To increase speed the CRC calculation is split into two clock--
--               cycles. The first cycle only the part that includes the data --
--               is XORed into signal q1, and at the next cycle this result is--
--               XORed with the previous state of the CRC, q0.                --
--               With this wcheme the maximum frequency is greatly increased  --
--               since the numbers of XOR gates on one signal is reduces from --
--               15 to 8.                                                     --
--                                                                            --
--               For an HOLA link:                                            --
--               The transmitter should use the entity CRCLSC which has an    --
--               output multiplexer to insert the CRCC.                       --
--                                                                            --
--               The receiver should use the entity CRCLDC which has a ERROR  --
--               output that is active high with a latency of two clockcycles --
--                                                                            --
--               Both these entities uses CRCGEN_LDC generate CRC or calculate    --
--               ERROR state.                                                 --
--                                                                            --
-- Notes       :                                                              --
--                                                                            --
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
-- Version |    Date     |Author| Modifications                               --
--------------------------------------------------------------------------------
--   1.0   | 22-Jul-99   | EB   | Original version                            --
--   1.1   |  9-Apr-02   | ARG  | Comments added                              --
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;

--------------------------------------------------------------------------------
entity CRCGEN_LDC is
--------------------------------------------------------------------------------
  port (
    CLK   : in  std_logic;                         -- Input clock
    CLRCRC: in  std_logic;                         -- Synchronous clear active
                                                   -- high. A Clear signal has
                                                   -- to be asserted before or
                                                   -- the same cycle the first
                                                   -- data word is written 
    CALC  : in  std_logic;                         -- Calculate CRC on DIN
    D     : in  std_logic_vector (15 downto 0);    -- Data Input
    Q     : out std_logic_vector (15 downto 0)     -- CRC quotient. One clock
                                                   -- cycle latancy from last
                                                   -- word in to CRC out.

	);
end CRCGEN_LDC;

--------------------------------------------------------------------------------
architecture behaviour of CRCGEN_LDC is
--------------------------------------------------------------------------------

signal q0     : std_logic_vector (15 downto 0); -- Internal quotient signal
signal q1     : std_logic_vector (15 downto 0); -- Partial CRC quotient
signal nxt    : std_logic;                      -- If high, q1 contains
                                                -- partial CRC
signal nxt_clr: std_logic_vector (1 downto 0);  -- signal used to append nxt and
                                                -- clr for case statement

--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------

  Q          <= q0;
  nxt_clr(1) <= nxt;
  nxt_clr(0) <= CLRCRC;
  
--------------------------------------------------------------------------------
-- CRC1 calculates the part of the CRC only containing the data, and store the
-- intermediate result in q1. This calculation is down even when no data is
-- avilable. If CALC = '0' q1 will not be used.

crc1: process(CLK)
begin
  if (CLK'event and CLK = '1') then

    q1(15) <= D(12) xor D(11) xor D(8)  xor D(4)  xor D(0);
    q1(14) <= D(13) xor D(12) xor D(9)  xor D(5)  xor D(1);
    q1(13) <= D(14) xor D(13) xor D(10) xor D(6)  xor D(2);
    q1(12) <= D(15) xor D(14) xor D(11) xor D(7)  xor D(3);
    q1(11) <= D(15) xor D(12) xor D(8)  xor D(4);
    q1(10) <= D(13) xor D(12) xor D(11) xor D(9)  xor D(8) xor D(5) xor
                        D(4)  xor D(0);
    q1(9)  <= D(14) xor D(13) xor D(12) xor D(10) xor D(9) xor D(6)  xor
                        D(5)  xor D(1);
    q1(8)  <= D(15) xor D(14) xor D(13) xor D(11) xor D(10) xor D(7)  xor
                        D(6)  xor D(2);
    q1(7)  <= D(15) xor D(14) xor D(12) xor D(11) xor D(8) xor D(7)  xor
                        D(3);
    q1(6)  <= D(15) xor D(13) xor D(12) xor D(9)  xor D(8) xor D(4);
    q1(5)  <= D(14) xor D(13) xor D(10) xor D(9)  xor D(5);
    q1(4)  <= D(15) xor D(14) xor D(11) xor D(10) xor D(6);
    q1(3)  <= D(15) xor D(8)  xor D(7)  xor D(4)  xor D(0);
    q1(2)  <= D(9)  xor D(8)  xor D(5)  xor D(1);
    q1(1)  <= D(10) xor D(9)  xor D(6)  xor D(2);
    q1(0)  <= D(11) xor D(10) xor D(7)  xor D(3); 

    nxt <= CALC;

  end if;
end process crc1;

--------------------------------------------------------------------------------
-- CRC0 calculates the part of the CRC that uses the previous value of the CRC.
--
-- the following cases are possible
-- 
-- nxt | CLRCRC |Meaning                    |Action
-------+--------+---------------------------+-----------------------------------
--  1  |        |data written previos cycle |Calculate CRC (q0) using previous
--     |  0     |no reset signal            |value of q0 and q1
-------+--------+---------------------------+-----------------------------------
--  1  |        |Data written               |Calculate CRC using previous q1 and
--     |  1     |Reset signal active        |a reduced calculation being equal
--     |        |                           |to q0 being all 1.
-------+--------+---------------------------+-----------------------------------
--  0  |        |No data written            |q0 is unchanged
--     |  0     |No resetr signal           |
-------+--------+---------------------------+-----------------------------------
--  0  |        |No data written            |Reset CRC calculator by presetting
--     |  1     |Reset signal active        |q0 to all 1.
-------+--------+---------------------------+-----------------------------------
-- 
-- The second of the above cases is the most complicated: 
-- To clear previous result without having to preset q to all 1, one can
-- do this by performing q <= q1 xor #F0B8, which is equal to presetting
-- q to all 1 in the previous cycle.
-- This is needed in the following case in the receiver:
--
-- Clock cycle | Input | q0     | q1
---------------+-------+--------+--------
--      1      | Data  | -      | -  
--      2      | Data  | -      | q1_1
--      3      | -     | q0_1   | q1_2
--      4      | CRC   | q0_2   | -
--      5      | Data  | q0_2   | q1_crc
--      6      | Data  | q0_crc | q1_5
--      7      | Data  | q0_5   | q1_6
-- 
-- where qx_y indicates the value of the qx register containing CRC data from
-- beginning of CRC block to clock cycle y. The problem arises when a new CRC
-- block starts on the clock cycle after a CRC is sent. There is no time to
-- preset q0 register to all 1, so this is emulated bu calulating what the
-- effect would be. The operations below is merely the same operations as the
-- one above with q0 registers set to all 1.

crc0:process(CLK)
begin
  if (CLK'event and CLK ='1') then

    case nxt_clr is

      when "10" =>
        q0(15) <= q1(15) xor q0(15) xor q0(11) xor q0(7)  xor q0(4) xor q0(3);
        q0(14) <= q1(14) xor q0(14) xor q0(10) xor q0(6)  xor q0(3) xor q0(2);
        q0(13) <= q1(13) xor q0(13) xor q0(9)  xor q0(5)  xor q0(2) xor q0(1);
        q0(12) <= q1(12) xor q0(12) xor q0(8)  xor q0(4)  xor q0(1) xor q0(0);
        q0(11) <= q1(11) xor q0(11) xor q0(7)  xor q0(3)  xor q0(0);
        q0(10) <= q1(10) xor q0(15) xor q0(11) xor q0(10) xor q0(7) xor q0(6)
                         xor q0(4)  xor q0(3)  xor q0(2);
        q0(9)  <= q1(9)  xor q0(14) xor q0(10) xor q0(9)  xor q0(6) xor q0(5)
                         xor q0(3)  xor q0(2)  xor q0(1);
        q0(8)  <= q1(8)  xor q0(13) xor q0(9)  xor q0(8)  xor q0(5) xor q0(4)
                         xor q0(2)  xor q0(1)  xor q0(0);
        q0(7)  <= q1(7)  xor q0(12) xor q0(8)  xor q0(7)  xor q0(4) xor q0(3)
                         xor q0(1)  xor q0(0);
        q0(6)  <= q1(6)  xor q0(11) xor q0(7)  xor q0(6)  xor q0(3) xor q0(2)
                         xor q0(0);
        q0(5)  <= q1(5)  xor q0(10) xor q0(6)  xor q0(5)  xor q0(2) xor q0(1);
        q0(4)  <= q1(4)  xor q0(9)  xor q0(5)  xor q0(4)  xor q0(1) xor q0(0);
        q0(3)  <= q1(3)  xor q0(15) xor q0(11) xor q0(8)  xor q0(7) xor q0(0);
        q0(2)  <= q1(2)  xor q0(14) xor q0(10) xor q0(7)  xor q0(6);
        q0(1)  <= q1(1)  xor q0(13) xor q0(9)  xor q0(6)  xor q0(5);
        q0(0)  <= q1(0)  xor q0(12) xor q0(8)  xor q0(5)  xor q0(4);

      when "11" =>
        q0(15) <= not q1(15);
        q0(14) <= not q1(14);
        q0(13) <= not q1(13);
        q0(12) <= not q1(12);
        q0(11) <= q1(11);
        q0(10) <= q1(10);
        q0(9)  <= q1(9);
        q0(8)  <= q1(8);
        q0(7)  <= not q1(7);
        q0(6)  <= q1(6);
        q0(5)  <= not q1(5);
        q0(4)  <= not q1(4);
        q0(3)  <= not q1(3);
        q0(2)  <= q1(2);
        q0(1)  <= q1(1);
        q0(0)  <= q1(0);

      when "00" =>
--        q0 <= q0;
        null;

      when others =>
        q0 <= (others => '1');
    end case;

  end if;

end process crc0;

--------------------------------------------------------------------------------
end behaviour;
--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------

--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
--                                                                            --
-- File name   : crcldc.vhd                                                   --
--                                                                            --
-- Author      : Aurelio Ruiz,     CERN, EP-Division                          --
--                                                                            --
-- Description : CRC Checksum generator for 32-bit words, using two           --
--               independent 16 bit CRC 16 bit look-ahead calculators which   --
--               use the polynomial implemented in the entity CRCGEN_LDC.         --
--                                                                            --
--               Inputs : RXD     -> 32-bit input data                        --
--                        RX_DATA -> Flag for data received (normal data, CRC --
--                                   Checksum, test word)                     --
--                        RX_CNTL -> Flag for control words                   --
--                        RX_CRC  -> Marks CRC Checksum                       --
--                        RX_TEST -> Test mode flag. (card is on test mode, it--
--                                   does NOT mark words as test words)       --
--                        RESET   -> Reset signal from control block.         --
--                                                                            --
--               Outputs: RX_D_O    -> 32-bit output data                     --
--                        RX_DATA_O -> Flag for data sent (normal data or test--
--                                     words). CRC Checksum is no longer sent --
--                        RX_CNTL_O -> Flag for control words                 --
--                        CRC_ERROR -> Error in previous data block detected. --
--                        RX_TEST_O -> Test mode flag output.                 --
--                                                                            --
--               The result from CRCGEN_LDC has a two cycles latency. There       --
--               is a built-in pipeline to delay the data so that the CRCC    --
--               itself is available the same cycle as the result from the    --
--               CRCGEN_LDC.                                                      --
--                                                                            --
--               CRC Checksum MUST be received in the same cycle as           --
--               the CRC flag . Otherwise, the CRC calculator will            --
--               be reset.                                                    --
--                                                                            --
-- CHANGES FROM ODIN : RX_FLAG not used                                       --
--                     RX_ERROR not used                                      --
--                     HW_UP not used                                         --
--                     RX_TEST added                                          --
--                                                                            --
-- Notes       : If, for some reason, another CRC polynomial is to be used,   --
--               only the entity CRCGEN_LDC has to be modified.                   --
-- Used files  : crcgen_ldc.vhd                                                   --
--                                                                            --
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
-- Version |    Date     |   Author   |    Modifications                      --
--------------------------------------------------------------------------------
--   0.1   |  7-Feb-2002 |    ARG     |    Original version                   --
--   0.2   | 11-Apr-2002 |    ARG     |  Calculation of CRC on test words     --
--         |             |            |  removed                              --
--   0.3   |  6-May-2002 |    ARG     |  CRC keeps reset during test          --
--   0.4   | 17-sep-2002 |    JMH     |  reviewed, two alike signals are now  --
--         |             |            |  only one  c_reg1,2,3 = crc_reg0,1,2  --
--         |             |            |  c_reg1,2,3 removed                   --
--   0.5   | 19-sep-2002 |    JMH     |  after changes in FRAMELDC the RX_CRC --
--         |             |            |  is no longer one clk ahead of the    --
--         |             |            |  checksum => crc_reg2 no longer needed--
--         |             |            |  and since the checksum is nolonger   --
--         |             |            |  marked with dataflag crcstream is    --
--         |             |            |  now high when data or crc flag is    --
--         |             |            |  present                              --
--   0.5a  | 17-dec-2002 |    JMH     |  removed unused signals               --
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;

--------------------------------------------------------------------------------
entity CRCLDC is
--------------------------------------------------------------------------------

  port (

    CLK           : in  std_logic;                  -- Input clock
    RRES_IN       : in  std_logic;
    RRES_OUT      : out std_logic;
                                                    -- Input  data
    RX_D          : in  std_logic_vector (31 downto 0);
                                                    -- Output data
    RX_D_O        : out std_logic_vector (31 downto 0);
    RX_DATA       : in  std_logic;                  -- Data flag
    RX_DATA_O     : out std_logic;                  -- Output data flag
    RX_CNTL       : in  std_logic;                  -- Control flag
    RX_CNTL_O     : out std_logic;                  -- Output control flag
    RX_CRC        : in  std_logic;                  -- CRC flag
    CRC_ERROR     : out std_logic;                  -- Error in CRC
                                                    -- detected
    RX_TEST       : in  std_logic;                  -- Test mode
    RX_TEST_O     : out std_logic;                  -- Test mode output
    FULL          : in  std_logic;                  -- Full flag from FIFO
    FULL_OUT      : out std_logic;
    RESET         : in  std_logic

	);

end CRCLDC;

--------------------------------------------------------------------------------
architecture behaviour of CRCLDC is
--------------------------------------------------------------------------------

component CRCGEN_LDC
  port (
    CLK           : in  std_logic;
    CLRCRC        : in  std_logic;
    CALC          : in  std_logic;
    D             : in  std_logic_vector (15 downto 0);
    Q             : out std_logic_vector (15 downto 0)
    );
end component;

signal rst        : std_logic;                      -- Reset signal to crcgen_ldc
signal rec_rst    : std_logic;
signal crc_q      : std_logic_vector(31 downto 0);  -- CRC quotient

signal d_reg1     : std_logic_vector(31 downto 0);
signal d_reg2     : std_logic_vector(31 downto 0);  -- Output registers to
	                                            -- delay so that
                                                    -- error signal appears
                                                    -- the cycle after the
                                                    -- last word written

signal data_reg1  : std_logic;
signal data_reg2  : std_logic;
signal crc_reg0   : std_logic;
signal crc_reg1   : std_logic;
signal ctrl_reg1  : std_logic;
signal ctrl_reg2  : std_logic;
signal test_reg1  : std_logic;
signal test_reg2  : std_logic;
signal s_full     : std_logic;
signal crc_stream : std_logic;
signal s_rres_in  : std_logic;


--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------

-- CRC Checksum calculation for the LSB
crc_msb : crcgen_ldc port map (CLK, rst, crc_stream, RX_D(31 downto 16),
                           crc_q(31 downto 16));

-- CRC Checksum calculation for the MSB
crc_lsb : crcgen_ldc port map (CLK, rst, crc_stream, RX_D(15 downto  0),
                           crc_q(15 downto  0));

s_full       <= FULL;                               -- Full signal just
FULL_OUT     <= s_full;                             -- wired to next block

s_rres_in    <= RRES_IN;
RRES_OUT     <= s_rres_in;

crc_stream   <= (RX_DATA or RX_CRC) and (not RX_TEST);
--------------------------------------------------------------------------------
-- Pipeline to make CRCC available on the same cycle as the result from the   --
-- CRCGEN_LDC.                                                                    --
--------------------------------------------------------------------------------

pipe_line:process
begin
wait until CLK'event and CLK = '1';

  d_reg1     <= RX_D;                               -- Input registers 1,2 to
  data_reg1  <= RX_DATA;                            -- delay output because of
  test_reg1  <= RX_TEST;
  ctrl_reg1  <= RX_CNTL;

  d_reg2     <= d_reg1;
  data_reg2  <= data_reg1;
  test_reg2  <= test_reg1;
  ctrl_reg2  <= ctrl_reg1;


end process pipe_line;


--------------------------------------------------------------------------------
-- Output registers
--------------------------------------------------------------------------------

outreg:process
variable error_var : std_logic;
begin
wait until CLK'event and CLK ='1';

  RX_D_O     <= d_reg2;
  RX_DATA_O  <= data_reg2;
  RX_TEST_O  <= test_reg2;
  RX_CNTL_O  <= ctrl_reg2;

   if (crc_reg1 = '1') then                          -- Result from CRCGEN_LDC after
    error_var:= '0';                                -- a valid crc stream is
                                                    -- all zeros

    for i in crc_q'high downto crc_q'low loop
        error_var := error_var or crc_q(i);
    end loop;

    CRC_ERROR<= error_var;

  else
    CRC_ERROR<= '0';                                -- no error

  end if;

end process outreg;


--------------------------------------------------------------------------------
-- Register on the CRCC signal because of the CRC generator latency.
--------------------------------------------------------------------------------

crcreg:process
begin
wait until CLK'event and CLK = '1';

  crc_reg0   <= RX_CRC;

  crc_reg1   <= crc_reg0;                           -- Two cycle latency before
                                                    -- available
rec_rst    <= RESET or RRES_IN;
  rst        <= crc_reg0 or                         -- Reset on: CRCC received
                rx_test or                         --           Test mode
                rec_rst;                            --           Reset received

end process crcreg;


end behaviour;

--------------------------------------------------------------------------------
-- END OF FILE                                                                --
--------------------------------------------------------------------------------
--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
--                                                                            --
-- File name   : parldc.vhd                                                   --
--                                                                            --
-- Author      : Aurelio Ruiz                                                 --
--                                                                            --
-- Description : Parity checking in control words. It sets the correct values --
--               in bits LD(3..0) of control words for block basis error      --
--               reporting                                                    --
--                                                                            --
--               Inputs : LD          -> 32-bit input data                    --
--                        CTRL_FLAG   -> It marks the input as control word   --
--                        DATA_FLAG   -> It marks the input as data word      --
--                                       (NORMAL data, test words)            --
--                        TEST_FLAG   -> Test mode flag (to see if test word, --
--                                       see also the DATA_FLAG)              --
--                        RX_ERROR    -> CRC checking block detected a tx.    --
--                                       error in the previous block          --
--                        RESET       -> Reset input from control block. It   --
--                                       clears the error latch               --
--                        FULL        -> FIFO full flag, propagate to         --
--                                       testcheck block                      --
--                                                                            --
--               Outputs: LD_O        -> 32-bit output data                   --
--                        CTRL_FLAG_O -> It marks the output as control word  --
--                        DATA_FLAG_O -> It marks the output as data word     --
--                                       (normal data, test words)            --
--                        TEST_FLAG_O -> Test mode flag (to see if test word, --
--                                       see also the DATA_FLAG)              --
--                        LDERR       -> Error flag (both for data and control--
--                                       words)                               --
--                        FULL_OUT    -> FIFO full flag, propagate to         --
--                                       testcheck block                      --
--                                                                            --
--               When CTRL_FLAG is high LD(31 downto 4) contain control word, --
--               and even parity is generated as the following:               --
--               LD(31 downto 25), parity bit LD(3)                           --
--               LD(24 downto 18), parity bit LD(2)                           --
--               LD(17 downto 11), parity bit LD(1)                           --
--               LD(10 downto  4), parity bit LD(0)                            --
--                                                                            --
--               The output of LD(3..0) on control words is that specified    --
--               in the S-Link specification, in short                        --
--               LD(3) - 0                                                    --
--               LD(2) - 0                                                    --
--               LD(1) - transmission error in control word, active high      --
--               LD(0) - transmission error in data block, active high        --
--                                                                            --
--               HOLA uses block basis error reporting. That means that error --
--               in data words are only reported in the first control word.   --
--               The error flag must be then latched until a control word is  --
--               received.                                                    --
--                                                                            --
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
-- Version |    Date      |   Author   |    Modifications                     --
--------------------------------------------------------------------------------
--   0.1   |  8-Feb-2002  |    ARG     |    Original version                  --
--   0.2   |  5-Apr-2002  |    ARG     | One register stage removed  (36 reg. --
--                                       saved)                               --
--   0.2   | 16-sep-2002  |    JMH     | reviewed, no changes made            --
--   0.3   | 21-feb-2003  |    JMH     | error latch now reset on remote reset--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;

--------------------------------------------------------------------------------
-- Entity declaration
--------------------------------------------------------------------------------

entity PARLDC is
  port (
    CLK                 : in  std_logic;                         -- Input clock
    RRES_IN             : in  std_logic;
    RRES_OUT            : out std_logic;
    LD                  : in  std_logic_vector (31 downto 0);    -- Data input
    LD_O                : out std_logic_vector (31 downto 0);    -- Data output
    DATA_FLAG           : in  std_logic;                         -- data flag
    DATA_FLAG_O         : out std_logic;
    CTRL_FLAG           : in  std_logic;                         -- control flag
    CTRL_FLAG_O         : out std_logic;
    TEST_FLAG           : in  std_logic;                         -- test mode
    TEST_FLAG_O         : out std_logic;
    RX_ERROR            : in  std_logic;                         -- error in
                                                                 -- previous
								 -- block
    LDERR               : out std_logic;                         -- data error
    FULL                : in  std_logic;                         -- FIFO full
    FULL_OUT            : out std_logic;
    RESET               : in  std_logic
  );

end PARLDC;

architecture behaviour of PARLDC is
--------------------------------------------------------------------------------
-- Signal declarations
--------------------------------------------------------------------------------

signal serror           : std_logic;                          -- Error latch
signal ctrl_pipe        : std_logic;
signal data_pipe        : std_logic;
signal err_pipe         : std_logic;
signal test_inreg       : std_logic;
signal test_pipe        : std_logic;
signal res_inreg        : std_logic;
signal res_pipe         : std_logic;
signal s_full           : std_logic;
signal s_rres_in        : std_logic;

signal ld_pipe          : std_logic_vector(31 downto 0);

--------------------------------------------------------------------------------
-- Entity
--------------------------------------------------------------------------------
begin

s_full                 <= FULL;                               -- FIFO full
FULL_OUT               <= s_full;                             -- just wired

s_rres_in              <= RRES_IN;                            -- Remote reset
RRES_OUT               <= S_RRES_IN;                          -- just wired

--------------------------------------------------------------------------------
-- Entity processes
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Parity check process                                                       --
-- Parity is checked for control words (CTRL_FLAG was 1). Result is sent      --
-- in the 4 LSB of the control word (high if an error found).                 --
--------------------------------------------------------------------------------

parity: process
variable ld_var : std_logic_vector(3 downto 0);
begin
wait until CLK'event and CLK = '1';

  ld_pipe(31 downto 4) <= LD(31 downto 4);

  err_pipe             <= RX_ERROR;
  ctrl_pipe            <= CTRL_FLAG;
  ld_var               := LD( 3 downto 0);
  for i in 6 downto 0 loop
     ld_var(0)         := ld_var(0) xor LD( 4 + i);    -- Parity check
     ld_var(1)         := ld_var(1) xor LD(11 + i);
     ld_var(2)         := ld_var(2) xor LD(18 + i);
     ld_var(3)         := ld_var(3) xor LD(25 + i);
  end loop;
  if (CTRL_FLAG = '1') then
     ld_pipe(3 downto 0)<= ld_var;                           -- received
                                                             -- result will be
                                                             -- sent in LD(3..0)
 else
     ld_pipe(3 downto 0)<= LD(3 downto 0);              -- otherwise don't
                                                             -- change 4 LSB
 end if;

end process parity;

--------------------------------------------------------------------------------
-- Error latch process                                                        --
-- HOLA uses block basis error reporting. That means that error in data words --
-- are only reported in the first control word. Error flag must be then       --
-- latched until a control word is received.                                  --
-- Error can be also cleared by a reset.                                      --
--------------------------------------------------------------------------------

error_latch:process
begin
wait until CLK'event and CLK = '1';
                                                             -- Clear on S-LINK
  if (((ctrl_pipe) or res_pipe) = '1') then                  -- control word or
    serror             <= '0';                               -- RESET

  else
    serror             <= serror or err_pipe;                -- Otherwise latch

  end if;
end process error_latch;

--------------------------------------------------------------------------------
-- Output registers                                                           --
-- In control words 4 LSB set as follows:                                     --
--     LD(3) - 0                                                              --
--     LD(2) - 0                                                              --
--     LD(1) - transmission error in control word, active high                --
--     LD(0) - transmission error in data block, active high                  --
-- otherwise just the value received at the input.                            --
--------------------------------------------------------------------------------

outreg:process
variable oreg_var : std_logic;
begin
wait until CLK'event and CLK = '1';
  CTRL_FLAG_O          <= ctrl_pipe;
  oreg_var             := '0';
  for i in 3 downto 0 loop
  oreg_var             := oreg_var or ld_pipe(i);
  end loop;

  if (ctrl_pipe = '1') then
    LDERR              <= oreg_var or serror;                 -- error in ctrl.
                                                              -- word or data
    LD_O(0)            <= serror;                             -- Data error
    LD_O(1)            <= oreg_var;                           -- Ctrl error
    LD_O(2)            <= '0';
    LD_O(3)            <= '0';
    LD_O(31 downto 4)  <= ld_pipe(31 downto 4);

  else
    LDERR              <= err_pipe;
    LD_O               <= ld_pipe;

  end if;

end process outreg;


pipeline:process

begin

wait until CLK'event and CLK='1';

  test_inreg           <= TEST_FLAG;
  test_pipe            <= test_inreg;
  TEST_FLAG_O          <= test_pipe;

  data_pipe            <= DATA_FLAG;
  DATA_FLAG_O          <= data_pipe;

  res_inreg            <= RESET or RRES_IN
                          ;
  res_pipe             <= res_inreg;

end process pipeline;

end behaviour;

--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------

--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
--                                                                            --
-- File name   : testcheck.vhd                                                --
--                                                                            --
-- Author      : Aurelio Ruiz                                                 --
--                                                                            --
-- Description : Checks if test frames were correctly received                --
--               It also provides the output of the card to the user          --
--                                                                            --
--               Inputs: CLK      -> Clock from PLL                           --
--                       LD       -> 32-bit data input                        --
--                       DATA_FLAG-> Data flag. It shows that present data is --
--                                   either data word or test word.           --
--                       LCTRL    -> Control flag. It shows that present data --
--                                   is a control word.                       --
--                       LDERR    -> Data error flag. An error either in      --
--                                   control word (detected by parldc block)  --
--                                   or in data word (detected by crcldc      --
--                                   block) was found.                        --
--                       TEST_MODE-> Card in test mode (for a test word also  --
--                                   DATA_FLAG) must be set.                  --
--                       FULL     -> FIFO Full Flag. When high DERRLED_N must --
--                                   be iluminated.                           --
--                       RESET    -> Reset signal                             --
--                       UTDO_N   -> User Test Data Out Sampled. When low,    --
--                                   transfer test words during test mode.    --
--                                   Remember: only updated after reset       --
--                                   (see control_ldc block).                 --
--                                                                            --
--               Output: LD_O     -> 32-bit data output for user.             --
--                                   It must be mapped to I/O registers.      --
--                       LWEN_N_O -> Link Write Enable line for user.         --
--                                   It must be mapped to I/O register.       --
--                       LCTRL_N_O-> Link Control line for user.              --
--                                   It must be mapped to I/O register.       --
--                       LDERR_N_O-> Link Data Error for user.                --
--                                   Block basis reporting.                   --
--                                   It must be mapped to I/O registers.      --
--                       DERRLED_N-> Data error LED output. Also iluminated   --
--                                   when FIFO completely full.               --
--                       TESTLED_N-> Test mode LED.                           --
--                                                                            --
-- Notes       : Based on selftestrx.vhd from ODIN implementation by          --
--               Erik Brandin,     CERN, EP-Division                          --
--               Erik van der Bij, CERN, EP-Division                          --
--                                                                            --
--               Switch for DERRLED not provided. To clear it reset is needed --
--               (also cleared at entering test mode).                        --
--               See if input registers can be removed (to save apr. 40       --
--               registers)                                                   --
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
-- Version |    Date       |Author| Modifications                             --
--------------------------------------------------------------------------------
--   0.1   |  14-Feb-2002  | ARG  |  Original version                         --
--   0.2   |  26-sep-2002  | JMH  |  Reviewed, input register removed         --
--         |               |      |  ass already surgested by ARG these where --
--         |               |      |  not needed                               --
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
--------------------------------------------------------------------------------
entity TESTCHECK is
--------------------------------------------------------------------------------

  port (

    CLK                : in  std_logic;                       -- Input clock
    INT_LDOWN          : in  std_logic;                       -- internal ldown
    RRES_IN            : in  std_logic;                       -- remote reset
    LD                 : in  std_logic_vector (31 downto 0);  -- Data input
    LD_O               : out std_logic_vector (31 downto 0);  -- Data output
    DATA_FLAG          : in  std_logic;                       -- Write enable
    LWEN_N_O           : out std_logic;                       -- Write enable
    LCTRL              : in  std_logic;                       -- Control word
    LCTRL_N_O          : out std_logic;                       -- Control word
    LDERR              : in  std_logic;                       -- Error input
    LDERR_N_O          : out std_logic;                       -- Error output
    TEST_MODE          : in  std_logic;                       -- Card in test
                                                              -- mode
    FULL               : in  std_logic;                       -- FIFO full
    RESET              : in  std_logic;                       -- reset
    UTDO_N             : in  std_logic;                       -- Sampled UTDO_N
    DERRLED_N          : out std_logic;                       -- Data error/FIFO
                                                              -- full LED
    TESTLED_N          : out std_logic

  );

end TESTCHECK;

--------------------------------------------------------------------------------
architecture behaviour of testcheck is
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Signal declarations
--------------------------------------------------------------------------------
type   test_state_type is (DOK, DERR, TOK, TERR);

signal curr_test_state : test_state_type;
signal next_test_state : test_state_type;

signal test_error      : std_logic;
signal lwen_in         : std_logic;
signal lctrl_in_n      : std_logic;
signal test_word       : std_logic_vector(32 downto 0);    -- Register for test
                                                           -- words
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------


  lwen_in                <= (DATA_FLAG nor LCTRL);

  lctrl_in_n             <= not LCTRL;


--------------------------------------------------------------------------------
-- State machine                                                              --
-- The machine will be in DATA OK state unless test words or data with error  --
-- received.                                                                  --
-- States:                                                                    --
-- DOK       -> Data OK. Also in this state when no data received, and during --
--              reset                                                         --
-- DERR      -> Error in data was detected in previous blocks. DERRLED on     --
-- TOK       -> Test mode OK. Data are delivered to the user if UTDO_N = 0    --
-- TERROR    -> Error in test word detected.                                  --
--                                                                            --
-- DERRLED is cleared either with a reset or by going in/out of test mode     --
--------------------------------------------------------------------------------

check_state_machine:process(RESET,RRES_IN,CLK)
begin

    if ((RESET or RRES_IN)= '1') then
      curr_test_state      <= DOK;
    elsif CLK'event and CLK='1' then
      curr_test_state      <= next_test_state;
    end if;

end process;


test_state_machine : process(curr_test_state, TEST_MODE, LDERR,test_error)
begin

case curr_test_state is
  when DOK =>                                          -- Data mode OK
    if (TEST_MODE = '1') then                          -- Card in test mode
      next_test_state      <= TOK;                     -- Check test words
    elsif (LDERR = '1')  then                          -- data error detected
      next_test_state      <= DERR;                    -- in previous blocks
    else
      next_test_state      <= DOK;
    end if;

  when DERR =>                                         -- Data Mode Error
    if (TEST_MODE = '1') then                          -- Test mode clears
      next_test_state      <= TOK;                     -- error latches
    else
      next_test_state      <= DERR;
    end if;

  when TOK =>                                          -- Test mode OK
    if (TEST_MODE = '0') then                          -- Test finished
      next_test_state      <= DOK;
    elsif (test_error = '1') then                      -- Error in test word
      next_test_state      <= TERR;                    -- detected
    else
      next_test_state      <= TOK;
    end if;

  when TERR =>                                         -- Test mode Error
    if (TEST_MODE = '0') then                          -- Test finished
      next_test_state      <= DOK;                     -- Latches cleared
    else
      next_test_state      <= TERR;
    end if;
  end case;

end process;

--------------------------------------------------------------------------------
-- DERRLED_N                                                                  --
-- It is iluminated when an error has been detected in any word, or if FIFO   --
-- is completely full.                                                        --
-- It is cleared at going in/out of test mode.                                --
--------------------------------------------------------------------------------

error_led_proc:process(curr_test_state,FULL)
begin

  case curr_test_state is

    when DOK              =>                            -- On if FIFO full
      DERRLED_N           <= not FULL;

    when TOK              =>                            -- On if FIFO full
      DERRLED_N           <= not FULL;

    when DERR             =>                            -- error was detected
      DERRLED_N           <= '0';                       -- LED on

    when TERR             =>                            -- error was detected
      DERRLED_N           <= '0';                       -- LED on

    when others           =>                            -- error was detected
      DERRLED_N           <= '0';                       -- LED on

  end case;

end process;

--------------------------------------------------------------------------------
-- Test_word contains the shift register used to check test words             --
-- Test_word register reset when out of test mode, shift when, during test    --
--      mode, data words are received                                         --
-- Test word is received when card in test mode (TEST_MODE = '1') and data    --
--      word received (DATA_FLAG = '1').                                      --
--------------------------------------------------------------------------------

shift_test:process
begin
wait until CLK'event and CLK = '1';

 if (TEST_MODE = '1') then                             -- Test word received
     if (DATA_FLAG = '1') then                         -- circular shift
        test_word         <= test_word(31 downto 0) & test_word(32);
    end if;

 else                                                  -- test mode finished
                                                       -- reset register
      test_word           <= (32 downto 1 => '0', others => '1');

 end if;

end process;

--------------------------------------------------------------------------------
-- Output register                                                            --
-- LWEN_N  = 0 when data or control words received, and during test if UTDO_N --
--             low                                                            --
-- LCTRL_N = 0 when control words transferred. LD(3..0) have then special     --
--             meaning                                                        --
-- LDERR_N = 0 when error in data words detected in previous blocks, or error --
--             in test words.                                                 --
-- Outputs are registered to map them to I/O registers.                       --
--------------------------------------------------------------------------------

outreg:process
begin
wait until CLK'event and CLK = '1';

  LD_O                    <= LD;

  if (TEST_MODE = '1') then                             -- In test mode transfer
    LWEN_N_O              <= lwen_in or UTDO_N;      -- when UTDO_N low.
    LCTRL_N_O             <= not (test_word(0) and  DATA_FLAG);

  else
    LWEN_N_O              <= lwen_in or INT_LDOWN or RRES_IN;
    LCTRL_N_O             <= lctrl_in_n;

  end if;

  LDERR_N_O               <= not ((TEST_MODE and test_error) -- test word error
                               or (LDERR));   -- data or control word
                                                        -- error.
end process outreg;


--------------------------------------------------------------------------------
-- In this process test words are checked. This action is performed always,   --
-- even if data on input are not test words. Value in test_error is only      --
-- taken into account if test mode flag was also set (process above)          --
--------------------------------------------------------------------------------

testcheck_proc: process
begin
wait until CLK'event and CLK = '1';

  if (ld = test_word(32 downto 1)) then           -- Input word right
    test_error           <= '0';
  else
    test_error           <= data_flag;
  end if;
end process;

TESTLED_N                <= not test_mode;

end behaviour;

--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------

--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
--                                                                            --
-- File name   : control_ldc.vhd                                              --
--                                                                            --
-- Author      : Aurelio Ruiz                                                 --
--                                                                            --
-- Description : Return channel and LDC control logic.                        --
--                                                                            --
--               Reset and initialisation protocol is implemented using a     --
--               3-state state machine, Down, up and reset, where reset state --
--               is split into 4 (res1-4) to assure link being down for 4     --
--               cycles in reset.                                             --
--                                                                            --
--               POWER/DOWN Link powers up in this state.                     --
--                          waits for TLK2501                                 --
--                          Link sends Down command to LSC                    --
--                          Link sends Link Down to ROMB                      --
--                                                                            --
--               UP         Link is up and running                            --
--                                                                            --
--               RES1       Link is down, cleared by URESET# or Remote reset  --
--                                                                            --
--               RES2-4     Sends Reset command to LSC                        --
--                                                                            --
--                                                                            --
--               Test in the return channel is performed while the card is in --
--               test mode. That means that there is no control over the last --
--               test cycle, and this will be probably not complete.          --
--                                                                            --
--               Flow control information is dependant on the state of the    --
--               FIFO. That is, although receiver asked for flow control, LSC --
--               will be informed when the FIFO has reached the minimum       --
--               available space to guarantee no data is lost due to delays in--
--               transmission.                                                --
--                                                                            --
--               INPUTS: XCLK : External 100 MHz clock, used to give data to  --
--                              TLK device.                                   --
--                       LCLK : LCLK clock received from input pin LCLK_PLL.  --
--                              It is assigned externally from PLL output     --
--                              to guarantee hold times in the putput signals --
--                       URESET_N: User reset signal.                         --
--                              Not mapped in I/O register since it is        --
--                              connected to a Fast Input                     --
--                       RRES : Remote reset command recognised by front block--
--                       LDOWN: Link down signal received from front block.   --
--                       TEST_MODE: Card is in test mode.                     --
--                       UXOFF_N: Flow control request from user.             --
--                              It must be mapped to an I/O register.         --
--                       URL  : User link return lines.                       --
--                              They must be mapped to I/O registers.         --
--                       UTDO_N:User Test Data Output signal.                 --
--                              from control_ldc block.                       --
--                              It must be mapped to an I/O register.         --
--                       LFF_N: Link full flag signal received from FIFO. A   --
--                              flow control signal must be sent to LSC.      --
--               OUTPUTS:LDOWN_N: Link Down output to user.                   --
--                              It must be mapped to an I/O register.         --
--                       LUPLED_N: Link Up LED output.                        --
--                       SEND_XOFF:Flow control signal to frame block so that --
--                              stops sending data.                           --
--                       SEND_RST: Reset signal to reset other blocks.        --
--                       UTDO_N_OUT: Sampled UTDO_N signal for testcheck block--
--                       TX_ER :Transmit error coding TLK signal.             --
--                              It must be mapped to an I/O register.         --
--                       TX_EN :Trasmit enable TLK signal.                    --
--                              It must be mapped to an I/O register.         --
--                       TXD   :16-bit tx. data.                              --
--                              When data is transmitted, meaning as listed   --
--                              below.                                        --
--                              ------------------------------------------------
--                              |     Bits    |             Meaning           --
--                               -----------------------------------------------
--                              |  ( 0.. 7)   |  Return lines                 --
--                              |  ( 8.. 9)   |  XOFF - Flow control          --
--                              |  (10..11)   |  LDC down                     --
--                              |  (12..13)   |  LDC reset                    --
--                              |  (14..15)   |  Reserved,ignore on reception --
--                              ------------------------------------------------
--                              They must be mapped to I/O registers.         --
--                       FLOWCTLLED_N : Flow control LED output.              --
-- Notes       :                                                              --
--               syn_encoding attribute added since simulation mismatches     --
--               were detected after synthesis with synplify.                 --
--                                                                            --
-- Based on    : controller.vhd from ODIN implementation by                   --
--               Erik Brandin,     CERN, EP-Division                          --
--               Erik van der Bij, CERN, EP-Division                          --
--
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
-- Version |    Date     |Author| Modifications                               --
--------------------------------------------------------------------------------
--  1.0    |  3-Apr-2002 | ARG  | First version                               --
--  1.1    |  8-Apr-2002 | ARG  | Generic INIT_LENGTH added.                  --
--  1.2    | 14-May-2002 | ARG  | Safe encoding added, syn_rldn_x added       --
--  1.3    | 27-sep-2002 | JMH  | reveiwed, library IEEE.STD_LOGIC.ARITH.all  --
--         |             |      | removed, double assignment of send_ldown_l  --
--         |             |      | signal in RES1 state removed                --
--         |             |      | cnt8(counted 32 LCLK)replaced by cnt32_xclk,--
--         |             |      | since the reason for counting is to ensure  --
--         |             |      | that reset is sent to the LSC - this is done--
--         |             |      | after 21 XCLK cycles.                       --
--  1.4    | 06-02-2003  | JMH  | added UP_WAIT state to init_statemachine    --
--         |             |      | to fix LDOWN# bug when reset                --
--  1.5    | 10-04-2003  | JMH  | "return_st_state" machine changed to have   --
--         |             |      | default IDLE state and not DATA             --
--         |             |      | and also the idle counter is changes to 4bit--
--         |             |      | this makes it send 7 IDLES between data     --
--  1.6    | 13-may-2003 | JMH  | added POWER_UP_RST_N                        --
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;

--------------------------------------------------------------------------------
entity CONTROL_LDC is
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- GENERIC: INIT_LENGTH -> Length of counter filt_cnt used as filter during   --
--          initialisation. If user wants to simulate LDC on a PC, it is      --
--          adviced to set SIMULATION=1 generic on top level entity holaldc,to--
--          decrease simulation duration.                                     --
--          In simulation mode INIT_LENGTH takes the value 3.                 --
--          In normal operation INIT_LENGTH takes the value 15.               --
--------------------------------------------------------------------------------

  generic (
    INIT_LENGTH : integer
    );
  port (                                                 -- Sync to:
    POWER_UP_RST_N : in  std_logic;
    XCLK           : in  std_logic;
    LCLK           : in  std_logic;
    URESET_N       : in  std_logic;                      -- Asyn.
    RRES           : in  std_logic;                      -- RX_CLK
    LDOWN          : in  std_logic;                      -- RX_CLK
    TEST_MODE      : in  std_logic;                      -- LCLK
    UXOFF_N        : in  std_logic;                      -- Asyn.
    URL            : in  std_logic_vector(3 downto 0);   -- Asyn.
    UTDO_N         : in  std_logic;                      -- Asyn.
    LFF_N          : in  std_logic;                      -- LCLK
    TLK_DOWN       : in  std_logic;                      -- RX_CLK
    LDOWN_N        : out std_logic;                      -- Asyn.
    INT_LDOWN      : out std_logic;
    LUPLED_N       : out std_logic;                      -- LCLK
    SEND_XOFF      : out std_logic;                      -- LCLK
    SEND_RST       : out std_logic;
    UTDO_N_OUT     : out std_logic;                      -- LCLK
    TX_ER          : out std_logic;                      -- XCLK
    TX_EN          : out std_logic;                      -- XCLK
    TXD            : out std_logic_vector(31 downto 0);  -- XCLK
    FLOWCTLLED_N   : out std_logic                       -- XCLK

    );

end CONTROL_LDC;

--------------------------------------------------------------------------------
architecture behaviour of CONTROL_LDC is
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Init. sate machine states
  constant POWDWN   : std_logic_vector(2 downto 0) := "000";
  constant UP       : std_logic_vector(2 downto 0) := "001";
  constant UP_WAIT  : std_logic_vector(2 downto 0) := "010";
  constant RES1     : std_logic_vector(2 downto 0) := "011";
  constant RES2     : std_logic_vector(2 downto 0) := "111";
  constant RES3     : std_logic_vector(2 downto 0) := "110";
  constant RES4     : std_logic_vector(2 downto 0) := "100";

  constant DATA_SENT : std_logic_vector(1 downto 0) := "00";
  constant KEEP_DATA : std_logic_vector(1 downto 0) := "01";
  constant REM_DATA  : std_logic_vector(1 downto 0) := "10";

-- States for return channel state machine
  type ret_type is (DATA, IDLE, CARRIER, TEST);

  signal curr_ret_state : ret_type;
  signal next_ret_state : ret_type;

-- command to synplify that ensures onehot encoding of statemachine.
  attribute syn_encoding                   : string;
  attribute syn_encoding of curr_ret_state : signal is "safe,onehot";
--------------------------------------------------------------------------------
-- Syn header in signal names means input synchronised to:                    --
--    - LCLK -> Signal name ending with _l.                                   --
--    - XCLK -> signal name ending with _x.                                   --
--------------------------------------------------------------------------------

  signal syn_rres_l    : std_logic;     -- Signals used
  signal syn_rres1_l   : std_logic;
  signal syn_rldn_l    : std_logic;     -- to synchr. the
  signal syn_rldn1_l   : std_logic;
  signal syn_ureset_l  : std_logic;     -- asynchronous
  signal syn_ureset1_l : std_logic;     -- asynchronous
  signal syn_test_l    : std_logic;     -- input signals
  signal syn_uxoffn1_l : std_logic;
  signal syn_uxoffn_l  : std_logic;
  signal syn_test_x    : std_logic;
  signal syn_lffn_x    : std_logic;
  signal syn_lffn1_x   : std_logic;

  signal syn_lffn_l  : std_logic;
  signal syn_lffn1_l : std_logic;

  signal syn_test1_x : std_logic;

  signal syn_url_x  : std_logic_vector( 3 downto 0);
  signal syn_url1_x : std_logic_vector( 3 downto 0);

  signal stxd : std_logic_vector(27 downto 0);

  signal stx_er,
    stx_en : std_logic;

  signal ssend_xoff_l : std_logic;

  signal scount : std_logic;
  signal sdata  : std_logic;
  signal stest  : std_logic;
  signal hw_ok  : std_logic;
  signal hw_ok1 : std_logic;

  signal send_data_flag : std_logic_vector(1 downto 0);

  signal send_down_l       : std_logic;
  signal send_rst_signal_l : std_logic;

  signal test_word   : std_logic_vector(27 downto 0);  -- test word generator
  signal shiftreg    : std_logic_vector( 2 downto 0);  -- 3 test words counter
  signal pre_at_zero : std_logic;
                                                       -- Filter after
                                                       -- receiver ready
  signal filt_cnt    : std_logic_vector(INIT_LENGTH-1 downto 0);
  signal prescale    : std_logic_vector( 5 downto 0);



-- reset cycle counter to assure 32 XCLK reset signal no matter what LCLK is
  signal cnt32_xclk_en           : std_logic;
  signal cnt32_xclk              : std_logic_vector(5 downto 0);
-- since the state machine that needs this counter is in the LCLK domain
-- synchronization is done to prvent metastability
  signal syn_cnt32_xclk_high_l   : std_logic;
  signal syn_cnt32_xclk_high_l_1 : std_logic;

  signal idle_cnt : std_logic_vector( 3 downto 0);  -- REMEMBER THIS 

  signal curr_init                    : std_logic_vector( 2 downto 0);
  signal next_init                    : std_logic_vector( 2 downto 0);
  attribute syn_preserve              : boolean;
  attribute syn_preserve of curr_init : signal is true;


  signal sutdon_out_l : std_logic;

  signal syn_send_down1_x : std_logic;
  signal syn_send_down_x  : std_logic;

  signal syn_sendrst1_x : std_logic;
  signal syn_sendrst_x  : std_logic;

  signal syn_tlk_down_l1 : std_logic;
  signal syn_tlk_down_l  : std_logic;

  signal no_write : std_logic;



begin

--------------------------------------------------------------------------------
-- Synchronisation of the outputs coming from front, synchr. to ICLK2         --
-- (these signals will be always at least 8 ICLK2 clock cycle long) or from   --
-- user to clock LCLK                                                         --
-- Flow control (UXOFF input) from user is ignored during test if no data     --
-- output (UTDO_N ='0') was set.                                              --
--------------------------------------------------------------------------------
  sync_lclk : process
  begin
    wait until LCLK'event and LCLK = '1';

    syn_rldn1_l <= LDOWN;
    syn_rldn_l  <= syn_rldn1_l;

    syn_rres1_l <= RRES;
    syn_rres_l  <= syn_rres1_l;

    syn_test_l <= TEST_MODE;

    syn_ureset1_l <= URESET_N;
    syn_ureset_l  <= syn_ureset1_l;

    syn_uxoffn1_l <= UXOFF_N;
    syn_uxoffn_l  <= syn_uxoffn1_l;

    syn_lffn1_l <= lff_n;
    syn_lffn_l  <= syn_lffn1_l;

    syn_tlk_down_l1 <= TLK_DOWN;
    syn_tlk_down_l  <= syn_tlk_down_l1;

-- No flow control performed if test mode and no request from user (UTDON = '1')

    if ((sutdon_out_l and syn_test_l) = '1') then
      ssend_xoff_l <= '1';
    else
      ssend_xoff_l <= syn_uxoffn_l;
    end if;

    hw_ok <= hw_ok1;
  end process;


--------------------------------------------------------------------------------
-- Synchronisation of inputs to clock XCLK (TLK clock)                        --
--------------------------------------------------------------------------------
  sync_xclk : process
  begin
    wait until XCLK'event and XCLK = '1';
    syn_url1_x <= URL;
    syn_url_x  <= syn_url1_x;

    syn_test1_x <= TEST_MODE;
    syn_test_x  <= syn_test1_x;

    syn_lffn1_x <= LFF_N;
    syn_lffn_x  <= syn_lffn1_x;

    syn_send_down1_x <= send_down_l;
    syn_send_down_x  <= syn_send_down1_x;

    syn_sendrst1_x <= send_rst_signal_l;
    syn_sendrst_x  <= syn_sendrst1_x;

  end process;


--------------------------------------------------------------------------------
-- Return channel                                                             --
-- For error detection in the return channel every signal is sent twice.      --
-- Return channel bits:                                                       --
--                                                                            --
--          Bits         Meaning                                              --
--------------------------------------------------------------------------------
--       ( 0.. 7)      Return lines                                           --
--       ( 8.. 9)      XOFF - Flow control                                    --
--       (10..11)      LDC down                                               --
--       (12..13)      LDC reset                                              --
--       (14..15)      Reserved, ignore on reception                          --
--------------------------------------------------------------------------------
--                                                                            --
-- The sequence will be 7 IDLEs + Data                                        --
-- In test mode, 3 test words will be inserted, each preceeded by the Carrier --
--    Extend delimiter                                                        --
--                                                                            --
-- Test mode sequence :                                                       --
--   7 IDLEs + Data + 7 IDLEs + 3 (Carrier Ext. + Test word)                  --
--                                                                            --
-- Signals used in this process;                                              --
--                                                                            --
--   scount  -> Active idle counter                                           --
--              Set in IDLE                                                   --
--              Cleared in all other states                                   --
--   sdata   -> Data was sent. In test mode, next cycle test sequence must be --
--              sent.                                                         --
--              Set in DATA                                                   --
--              Cleared in CARRIER and TEST                                   --
--              Value kept in IDLE                                            --
--   stest   -> Test word sent. Shift one bit in test register                --
--              Set in test                                                   --
--              cleared in all other states                                   --
--                                                                            --
--------------------------------------------------------------------------------
  return_st_state : process(xclk, POWER_UP_RST_N)
  begin
    if POWER_UP_RST_N = '0' then
      curr_ret_state <= IDLE;
    elsif XCLK'event and XCLK = '1' then
      curr_ret_state <= next_ret_state;
    end if;

  end process;

  return_st : process(curr_ret_state, idle_cnt, syn_test_x, sdata,
                     shiftreg)
  begin
    case curr_ret_state is

      when IDLE =>                                 -- Send IDLEs
        stest          <= '0';                     -- clear test flag
        scount         <= '1';
        send_data_flag <= KEEP_DATA;
        if ((idle_cnt(idle_cnt'high)) = '1') then  -- if 7 IDLEs sent
          if ((syn_test_x and sdata) = '1') then   -- if test mode and data
            next_ret_state <= CARRIER;             -- sent last cycle
          else                                     -- send test word, else
            next_ret_state <= DATA;                -- send data
          end if;
        else                                       -- Go on sending IDLEs
          next_ret_state <= IDLE;
        end if;

      when DATA =>                      -- Send data
        scount         <= '0';          -- Don't count idles
        send_data_flag <= DATA_SENT;
        stest          <= '0';          -- clear test flag
        next_ret_state <= IDLE;         -- Send IDLEs

      when CARRIER =>                   -- Send Carrier Extend
        scount         <= '0';          -- before test word
        send_data_flag <= REM_DATA;
        stest          <= '0';
        next_ret_state <= TEST;

      when TEST =>                      -- Send test word
        scount         <= '0';
        send_data_flag <= KEEP_DATA;
        stest          <= '1';          -- Set test flag
        if (shiftreg(shiftreg'high) = '1' or syn_test_x = '0') then
                                        -- 3 test words already
          next_ret_state <= IDLE;       -- sent, send IDLEs
        else
          next_ret_state <= CARRIER;    -- go on sending test
        end if;  -- words

      when others =>
        scount         <= 'X';
        send_data_flag <= (others => 'X');
        stest          <= 'X';
        next_ret_state <= DATA;
    end case;
  end process;


  return_machine : process
  begin
    wait until XCLK'event and XCLK = '1';

    case curr_ret_state is

      when IDLE =>
        sTX_ER <= '0';                  -- Send IDLEs
        sTX_EN <= '0';

      when DATA =>                      -- Send data words
        sTX_ER <= '0';
        sTX_EN <= '1';

        sTXD( 0) <= syn_url_x(0);       -- Update Return Channel
        sTXD( 1) <= syn_url_x(0);       -- Return lines
        sTXD( 2) <= syn_url_x(0);       -- Update Return Channel
        sTXD( 3) <= syn_url_x(0);       -- Return lines
        sTXD( 4) <= syn_url_x(1);
        sTXD( 5) <= syn_url_x(1);
        sTXD( 6) <= syn_url_x(1);
        sTXD( 7) <= syn_url_x(1);        
        sTXD( 8) <= syn_url_x(2);
        sTXD( 9) <= syn_url_x(2);
        sTXD(10) <= syn_url_x(2);
        sTXD(11) <= syn_url_x(2);        
        sTXD(12) <= syn_url_x(3);
        sTXD(13) <= syn_url_x(3);
        sTXD(14) <= syn_url_x(3);
        sTXD(15) <= syn_url_x(3);
        

        sTXD(16) <= not syn_lffn_x;     -- link full flag
        sTXD(17) <= not syn_lffn_x;
        sTXD(18) <= not syn_lffn_x;
        sTXD(19) <= not syn_lffn_x;        

        sTXD(20) <= not syn_send_down_x;  -- Link down signal
        sTXD(21) <= not syn_send_down_x;
        sTXD(22) <= not syn_send_down_x;
        sTXD(23) <= not syn_send_down_x;                

        sTXD(24) <= syn_sendrst_x;      -- User reset
        sTXD(25) <= syn_sendrst_x;
        sTXD(26) <= syn_sendrst_x;
        sTXD(27) <= syn_sendrst_x;                

      when CARRIER =>
        sTX_ER <= '1';
        sTX_EN <= '0';

      when TEST =>
        sTX_ER <= '0';
        sTX_EN <= '1';

        sTXD(27 downto 0) <= test_word;

      when others =>
        sTX_ER <= 'X';
        sTX_EN <= 'X';

        sTXD(27 downto 0) <= (others => 'X');

    end case;
  end process;

  sdata_proc : process
  begin
    wait until XCLK'event and XCLK = '1';

    case send_data_flag is

      when DATA_SENT =>
        sdata <= '1';

      when REM_DATA =>
        sdata <= '0';
      when others =>
        null;
    end case;

  end process;

--------------------------------------------------------------------------------
-- Shift register used as 3 test words counter                                --
--------------------------------------------------------------------------------

  test_shiftreg_pr : process
  begin

    wait until XCLK'event and XCLK = '1';

    if (syn_test_x = '0') then
      shiftreg <= (0 => '1', others => '0');  -- reset

    elsif (stx_er = '1') then
      shiftreg <= shiftreg(1 downto 0) & shiftreg(2);
    end if;

  end process;


--------------------------------------------------------------------------------
--  7 IDLEs counter                                                           --
--------------------------------------------------------------------------------

  idle_shiftreg_pr : process
  begin
    wait until XCLK'event and XCLK = '1';

    if (scount = '0' or POWER_UP_RST_N = '0') then
      idle_cnt <= "0010";--(others => '0');    -- 7IDLES 
    else
      idle_cnt <= idle_cnt + 1;
    end if;
  end process;


--------------------------------------------------------------------------------
-- Test pattern shift register                                                --
--------------------------------------------------------------------------------

  testword_pr : process
  begin
    wait until XCLK'event and XCLK = '1';

    if (syn_test_x = '0') then
      test_word <= (27 downto 1 => '0', others => '1');
    elsif(stest = '1') then
      test_word <= test_word(26 downto 0) & test_word(27);
    end if;
  end process;

--------------------------------------------------------------------------------
-- Reset cycles counter                                                       --
-- in order to be sure that the reset signals is sent to the LSC the reset    --
-- signal must be there longer than 21 XCLK cycles                            --
--------------------------------------------------------------------------------
  cnt32_xclk_proc : process(cnt32_xclk_en, XCLK)
  begin
    if(cnt32_xclk_en = '0')then
      cnt32_xclk <= (others => '0');
    elsif(XCLK'event and XCLK = '1')then
      if(cnt32_xclk(cnt32_xclk'high) = '0' )then
        cnt32_xclk <= cnt32_xclk + 1;
      end if;
    end if;
  end process;

  cnt32_xclk_high_to_lclk : process
  begin
    wait until LCLK'event and LCLK = '1';
    syn_cnt32_xclk_high_l_1 <= cnt32_xclk(cnt32_xclk'high);
    syn_cnt32_xclk_high_l   <= syn_cnt32_xclk_high_l_1;
  end process;
--------------------------------------------------------------------------------
-- the TLK2501 signals might have glitches on ms before locking to input clock--
-- or serial data, mainly because of fiber vibrations when connecting         --
-- hw_ok goes high when all signals have been high for a number of            --
-- cycles specified by length of filtcnt and the prescaler.                   --
-- Code based on the one from controller.vhd from LDC.                        --
--------------------------------------------------------------------------------

  prescale_proc : process(LCLK, POWER_UP_RST_N)
    variable tmp : std_logic;
  begin
    if POWER_UP_RST_N = '0' then
      prescale    <= (others => '0');
      pre_at_zero <= '0';
      
    elsif LCLK'event and LCLK = '1' then
      prescale <= prescale + '1';       -- don't care if are a
      tmp      := '0';                  -- few ticks off
                                        -- tmp gets one if any
                                        -- of the bits is one
                                        -- tmp stays only zero
                                        -- if all bits are zero
      for i in prescale'high downto prescale'low loop
        tmp := tmp or prescale(i);
      end loop;
      -- pre_at_zero gives a pulse everytime when prescale = 0
      pre_at_zero <= not tmp;
    end if;
  end process prescale_proc;


  filter_p : process
  begin
    wait until LCLK'event and LCLK = '1';
    -- synchronize as all inputs are asynchronous
    -- also makes counter implementation simpler
    -- reset immediately (in fact one cycle later) if problem
    if (syn_tlk_down_l = '1') then
      filt_cnt <= (others => '0');
      -- count only when received a pulse and not at maximum
      -- otherwise stay at the same value
    elsif (pre_at_zero = '1' and filt_cnt(filt_cnt'high) = '0') then
      filt_cnt <= filt_cnt + '1';
    end if;
  end process filter_p;

  hw_ok1 <= filt_cnt(filt_cnt'high);    -- used in state machine


--------------------------------------------------------------------------------
-- Init and Reset state machine                                               --
-- 6 state state machine designed to work with HOLA-LSC                       --
-- Autonomous init cycle powers up in POWDWN state                            --
-- to comply with the S-LINK spec. reset is divided in to 4 states hereby     --
-- assuring that LDOWN# is low for at least 4 LCLK                            --
-- to assure that reset is send to the LSC send_rst_signal_l must be high     --
-- for at least 21 XCLK cycles to assure it being sent                        --
-- a counter implements this by counting to 32 which is more than 21          --
--------------------------------------------------------------------------------

  init_st_machine : process(LCLK, POWER_UP_RST_N)
  begin
    if POWER_UP_RST_N = '0' then
      curr_init <= RES1;                -- to reset on power up
    elsif LCLK'event and LCLK = '1' then
      curr_init <= next_init;
    end if;
  end process;


  init_machine : process(syn_ureset_l, syn_rres_l, hw_ok, syn_rldn_l,
                        syn_cnt32_xclk_high_l, curr_init)
  begin
    case curr_init is

      when POWDWN =>
        if (syn_ureset_l = '0') then
          next_init <= RES1;            -- Local reset
        elsif (hw_ok = '1' and syn_rres_l = '1') then  -- TLK device OK
          next_init <= UP;              -- and Remote reset received
        else
          next_init <= POWDWN;
        end if;

      when UP_WAIT =>                   -- up but URESET not disasserted yet
        if (hw_ok = '0' or              -- LDC down
            syn_rldn_l = '1') then      -- LSC down
          next_init <= POWDWN;
        elsif (syn_ureset_l = '0') then
          next_init <= UP_WAIT;         -- will not proceed to the 
        else                            -- real UP state until URESET# = 1 
          next_init <= UP;
        end if;
        
      when UP =>
        if (syn_ureset_l = '0') then    -- Local reset
          next_init <= RES2;
        elsif (hw_ok = '0' or           -- LDC down
               syn_rldn_l = '1' ) then  -- LSC down
          next_init <= POWDWN;
        else
          next_init <= UP;
        end if;

      when RES1 =>
        if (hw_ok = '1') then           -- Wait for hw_ok
          next_init <= RES2;            -- TLK device ready
        else
          next_init <= RES1;
        end if;

      when RES2 =>
        if (hw_ok = '0') then           -- Fiber disconnected, TLK device
          next_init <= RES1;            -- down
        else
          next_init <= RES3;
        end if;

      when RES3 =>
        if (hw_ok = '0') then           -- Fiber disconnected, TLK device
          next_init <= RES1;            -- down
        elsif(syn_cnt32_xclk_high_l = '1')then  -- if more than 32XCLK have past in
          next_init <= RES4;            -- this reset cycle the machine
        else                            -- moves on.
          next_init <= RES3;
        end if;

      when RES4 =>
        if (hw_ok = '0') then           -- Fiber disconnected, TLK device
          next_init <= RES1;
        elsif (syn_rres_l = '1') then   -- Go up when reset command
          next_init <= UP_WAIT;         -- bounces at LSC
        else
          next_init <= RES4;
        end if;

      when others =>
        next_init <= POWDWN;
    end case;

  end process init_machine;


--------------------------------------------------------------------------------
-- Output registers driven by the IR state machine                            --
--                                                                            --
-- LDOWN_N is high (up) only in UP state when not in test mode                --
-- Link down command over return channel sent only in POWDWN state and RES1   --
-- Reset is sent in POWER and RES2-4 states                                   --
-- Similar state machine in LSC.                                              --
--------------------------------------------------------------------------------

  sm_output : process
  begin

    wait until LCLK'event and LCLK = '1';
    case curr_init is

      when POWDWN =>                    -- Send link down, no reset
        cnt32_xclk_en     <= '0';
        ldown_n           <= '0';       -- Wait for reset command from LSC
        LUPLED_N          <= '1';
        send_down_l       <= '0';
        send_rst_signal_l <= '0';
        sutdon_out_l      <= UTDO_N;    -- or sample UTDO_N during local reset
        no_write          <= '0';       -- to disable WEN output

      when UP_WAIT =>
        cnt32_xclk_en     <= '0';
        ldown_n           <= not syn_test_l;  -- link down set in test mode
        LUPLED_N          <= syn_test_l;  -- lupled off if test, on otherwise
        send_down_l       <= '1';
        send_rst_signal_l <= '0';
        no_write          <= '1';       -- to disable WEN output
        if (syn_ureset_l = '0') then    -- sample UTDO_N when
          sutdon_out_l <= UTDO_N;       -- reset given
        end if;
      when UP =>                        -- Everything OK
        cnt32_xclk_en     <= '0';
        ldown_n           <= not syn_test_l;  -- link down set in test mode
        LUPLED_N          <= syn_test_l;  -- lupled off if test, on otherwise
        send_down_l       <= '1';
        send_rst_signal_l <= '0';
        no_write          <= '1';       -- to disable WEN output
        if (syn_ureset_l = '0') then    -- sample UTDO_N when
          sutdon_out_l <= UTDO_N;       -- reset given
        end if;

      when RES1 =>                      -- Same state as POWDWN but reset
        cnt32_xclk_en     <= '0';
                                        -- cycle initiated
        ldown_n           <= '0';       -- Wait for hw_ok (TLK wprking
        LUPLED_N          <= '1';       -- To make sure that LDC comes up
        send_down_l       <= '0';
        send_rst_signal_l <= '1';
        sutdon_out_l      <= UTDO_N;
        no_write          <= '0';       -- to disable WEN output

      when RES2 | RES3 | RES4 =>        -- RES2, RES3 and RES4
        cnt32_xclk_en     <= '1';
        ldown_n           <= '0';       -- Send resets and link up
        LUPLED_N          <= '1';       -- changes state RES2->RES3 and
        send_down_l       <= '1';       -- RES3->RES4 when
        send_rst_signal_l <= '1';       -- cnt8="000", ie command sent on
        sutdon_out_l      <= UTDO_N;    -- return line.
        no_write          <= '0';       -- to disable WEN output

      when others =>                    -- RES2, RES3 and RES4
        ldown_n           <= 'X';       -- Send resets and link up
        LUPLED_N          <= 'X';       -- changes state RES2->RES3 and
        send_down_l       <= 'X';       -- RES3->RES4 when
        send_rst_signal_l <= 'X';       -- cnt8="000", ie command sent on
        sutdon_out_l      <= 'X';       -- return line.
        no_write          <= 'X';       -- to disable WEN output

    end case;

  end process sm_output;

--------------------------------------------------------------------------------
-- Reset signal sent to all other blocks in the card.                         --
--------------------------------------------------------------------------------

  reset_output : process
  begin
    wait until LCLK'event and LCLK = '1';
    SEND_RST <= send_rst_signal_l;      -- Send Reset signal
  end process;  -- if in reset state
                                        -- or when RRES rx.
--------------------------------------------------------------------------------
-- Output registers                                                           --
--------------------------------------------------------------------------------

  out_reg_x : process
  begin
    wait until XCLK'event and XCLK = '1';
    TXD   <= X"0"&stxd;
    TX_ER <= stx_er;
    TX_EN <= stx_en;
  end process;

  out_reg_l : process
  begin
    wait until LCLK'event and LCLK = '1';
    UTDO_N_OUT <= sutdon_out_l;
    SEND_XOFF  <= ssend_xoff_l;


    FLOWCTLLED_N <= syn_lffn_l;
  end process;

--------------------------------------------------------------------------------
-- Output assignements                                                        --
--------------------------------------------------------------------------------

  INT_LDOWN <= not (filt_cnt(filt_cnt'high) and no_write);

end behaviour;

--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------
--345678901234567890123456789012345678901234567890123456789012345678901234567890
--------------------------------------------------------------------------------
-- File name   : holaldc_arch.vhd                                             --
--                                                                            --
-- Author      : Aurelio Ruiz Garcia, CERN, EP-Division                       --
--                                                                            --
-- Description : Architecture of an HOLA type S-LINK Link Destination Card    --
--                                                                            --
--               This design needs three global clock signals:                --
--                 LCLK, XCLK and RX_CLK                                      --
--                                                                            --
--               ------------------------------------------                   --
--                           TIMING REQUIREMENTS                              --
--               Clock                                                        --
--               ------------------------------------------                   --
--               LCLK           Typ. 40 MHz - PLL internal generated clock    --
--               XCLK               100 MHz - external clock                  --
--               RX_CLK             100 MHz - from TLK-2501                   --
--                                                                            --
--                                                                            --
--               LCLK clock is generated internally using the internal        --
--               PLL of the Altera APEX20K30E device. LCLK frequency can be   --
--               chosen between 40 MHz and 62.5 MHz means the generic         --
--               LCLK_FREQ .                                                  --
--               PLL output is directly delivered to the user.                --
--               This clock is routed externally to pin LCLK_IN to be used    --
--               as the internal LCLK clock (LCLK_IN). Outputs are then       --
--               correctly aligned and guarantee S-Link hold times.           --
--                                                                            --
--               It is possible to work in a simulation mode by setting       --
--               generic SIMULATION "ON", to increase speed when simulating   --
--               on a computer (more details on generics header).             --
--                                                                            --
--               HOLA LDC includes a FIFO used to separate RX_CLK and LCLK    --
--               clock domains. Parameters for the FIFO are set by the        --
--               generics FIFODEPTH,LOG2DEPTH and FULLMARGIN (see complete    --
--               description on generics header).                             --
--               This FIFO's functionality is in principle the same as the    --
--               ROMB buffer, if the generic parameters are correctly set.    --
--               The ROMB buffer is still needed to compensate the reaction   --
--               time of the LDC, but it is no longer needed to compensate    --
--               the latency of the full link.                                --
--                                                                            --
--               The user must be aware that this is exclusively an HOLA LDC  --
--               characteristic, and if any other S-Link implementation is to --
--               be used S-Link requirements must be fullfilled (recommended).--
--                                                                            --
--               DERRLED_N indicates, apart from data error signaling as      --
--               specified by the S-Link protocol, that FIFO is COMPLETELY    --
--               full, and that data might be lost.                           --
--                                                                            --
--               It is recommended to add a test connector on boards using    --
--               this core. This connector should carry the signals:          --
--               LCLK                   -- terminate near connector           --
--               LDOWN_N                                                      --
--               URESET_N                                                     --
--               UXOFF_N                                                      --
--               LWEN_N                                                       --
--               LCTRL_N                                                      --
--               LDERR_N                                                      --
--               LD0                                                          --
--               LD1                                                          --
--               LD31                                                         --
--                                                                            --
-- Synplify    : Warnings: Inputs udw unused.                                 --
--                                                                            --
-- Notes       : Core for LDC to be made (separate entity and architecture)   --
--                                                                            --
-- Size        :                                                              --
--                                                                            --
--------------------------------------------------------------------------------
--                           Revision History                                 --
--------------------------------------------------------------------------------
--   Version   |     Date      |Author| Modifications                         --
--------------------------------------------------------------------------------
--     0.1     |  20-Feb-2002  |  ARG | Original version                      --
--     0.2     |   7-Apr-2002  |  ARG | Selectable simulation added           --
--             |               |      | Initialitation selection added        --
--     0.3     |   8-Apr-2002  |  ARG | LCLK frequency selection added        --
--     0.4     |  28-Oct-2002  |  JMH | atributtes for PLL's removed          --
--             |               |      | it made no change, but it is now      --
--             |               |      | more easily used in other tools than  --
--             |               |      | synplify                              --
--     0.5     |  2-dec-2002   | JMH  | support for both Xilinx and Altera    --
--             |               |      | the generic ALTERA_XILINX now selects--
--             |               |      | Wizard generated components, FIFO and --
--             |               |      | clock PLL's or DLL's                  --
--     0.6     |  4-Dec-2002   | JMH  | input 'LCLK_PLL' changed to 'LCLK_IN' --
--             |               |      | Generic "LCLK_FREQ' changed to        --
--             |               |      | 'LCLK_SELECT' and aditional choice    --
--             |               |      | added so the internal LCLK generator  --
--             |               |      | can be deselected completely          --
--     0.6a    |  5-Feb-2003   | JMH  | XLCLK instancies changed              --
--     0.6b    | 11-Feb-2003   | JMH  | XLCLK instancies changed  and         --
--             |               |      | added XCLK_int                        --
--     0.7     | 13-may-2003   | JMH  | added POWER_UP_RST_N                  --
--     0.8     | 23-may-2003   | JMH  | ICLK_2 replaced by RX_CLK             --
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;

--==============================================================================
--==============================================================================
architecture structure of holaldc_core is
--==============================================================================
--==============================================================================

--==============================================================================
--==============================================================================
-- COMPONENT DECLARATIONS
--==============================================================================
--==============================================================================

  component XLCLK40
    port (
      RST_IN    : in  std_logic;        --
      CLKIN_IN  : in  std_logic;        -- 125 MHz input
      CLKFX_OUT : out std_logic;        -- 40 MHz output
      CLK0_OUT  : out std_logic
      );
  end component;


  component XLCLK625
    port (
      RST_IN    : in  std_logic;        --
      CLKIN_IN  : in  std_logic;        -- 125 MHz input
      CLKFX_OUT : out std_logic;        -- 40 MHz output
      CLK0_OUT  : out std_logic
      );
  end component;

  component ALCLK40
    port(
      inclock : in  std_logic;
      clock1  : out std_logic
      );
  end component;

  component ALCLK625
    port(
      inclock : in  std_logic;
      clock1  : out std_logic
      );
  end component;

  component ACLK40_FROM_100
    port (
      refclk   : in  std_logic := '0'; --  refclk.clk
      rst      : in  std_logic := '0'; --  reset.reset
      outclk_0 : out std_logic;        --  outclk0.clk
   		 locked   : out std_logic         --  locked.export
    );
  end component;

  component ACLK50_FROM_100
    port (
      refclk   : in  std_logic := '0'; --  refclk.clk
      rst      : in  std_logic := '0'; --  reset.reset
      outclk_0 : out std_logic;        --  outclk0.clk
   		 locked   : out std_logic         --  locked.export
    );
  end component;

  
--==============================================================================
  component FRONT
--==============================================================================
    generic(
      FRONT_INIT_LENGTH : integer;
      ACTIVITY_LENGTH   : integer
      );
    port (
      POWER_UP_RST_N : in  std_logic;
      XCLK           : in  std_logic;
      RX_CLK         : in  std_logic;   -- 125 MHz clock
                                        -- TLK2501
      RX_DV          : in  std_logic;   -- Control bits from
      RX_ER          : in  std_logic;   -- receiver
      RXD            : in  std_logic_vector(31 downto 0);  -- Received data
      TEST_OUT       : out std_logic;
      WEN            : out std_logic;   -- Write enable FIFO
      OUT_DATA       : out std_logic_vector(32 downto 0);  -- Data for FIFO
      SEND_RRES      : out std_logic;   -- Remote reset
                                        -- command received
                                        -- from control
      RESET_SIGNAL   : out std_logic;
      LDOWN          : out std_logic;   -- Link down detected
      TLK_DOWN       : out std_logic;
                                        -- for control
      ACTIVITYLED_N  : out std_logic
      );

  end component;

--==============================================================================
  component FIFOLDC
--==============================================================================
    generic(
      ALTERA_XILINX : integer;
      FIFODEPTH     : integer;          -- only powers of 2
      LOG2DEPTH     : integer;          -- 2log of depth
      FULLMARGIN    : integer           -- words left when
                                        -- LFF_N set
      );

    port (
      POWER_UP_RST_N : in  std_logic;
      RESET          : in  std_logic;   -- async clear
      TEST_IN        : in  std_logic;
      TEST_OUT       : out std_logic;
      RRES_IN        : in  std_logic;
      RRES_OUT       : out std_logic;

      RX_CLK : in  std_logic;                      -- write clock
      UD     : in  std_logic_vector(32 downto 0);  -- cmd bit and input
                                                   -- data from LSC
      WEN    : in  std_logic;
      REN    : in  std_logic;                      -- read enable
      DATA   : out std_logic_vector(32 downto 0);  -- output data
      EMPTY  : out std_logic;                      -- empty flag,
      FULL   : out std_logic;                      -- Full Flag for
                                                   -- synchr. to write
                                                   -- clock
      LFF_N  : out std_logic;                      -- Full Flag
      LCLK   : in  std_logic                       -- read clock
      );

  end component;


--==============================================================================
  component FRAMELDC
--==============================================================================
    port (
      CLK      : in  std_logic;                      -- Input clock
      TEST_IN  : in  std_logic;
      LD       : in  std_logic_vector(32 downto 0);  -- Data input
      UXOFF_N  : in  std_logic;
      EMPTY    : in  std_logic;
      FULL     : in  std_logic;
      RRES_IN  : in  std_logic;
      RRES_OUT : out std_logic;

      REN       : out std_logic;
      LD_O      : out std_logic_vector(31 downto 0);  -- Data output
      CTRL_FLAG : out std_logic;
      DATA_FLAG : out std_logic;
      TEST_FLAG : out std_logic;
      CRC_FLAG  : out std_logic;
      FULL_OUT  : out std_logic;
      RESET_IN  : in  std_logic                       -- Reset signal from
                                                      -- control block
      );

  end component;
--==============================================================================
  component CRCLDC
--==============================================================================
    port (
      CLK      : in  std_logic;         -- Input clock
      RRES_IN  : in  std_logic;
      RRES_OUT : out std_logic;

      RX_D      : in  std_logic_vector(31 downto 0);  -- Input  data
      RX_D_O    : out std_logic_vector(31 downto 0);  -- Output data
      RX_DATA   : in  std_logic;                      -- Data flag
      RX_DATA_O : out std_logic;
      RX_CNTL   : in  std_logic;                      -- Control flag
      RX_CNTL_O : out std_logic;
      RX_CRC    : in  std_logic;                      -- CRC flag
      CRC_ERROR : out std_logic;
      RX_TEST   : in  std_logic;                      -- Test mode
      RX_TEST_O : out std_logic;
      FULL      : in  std_logic;                      -- FIFO full
      FULL_OUT  : out std_logic;
      RESET     : in  std_logic
      );

  end component;

--==============================================================================
  component PARLDC
--==============================================================================
    port (
      CLK         : in  std_logic;                      -- Input clock
      RRES_IN     : in  std_logic;
      RRES_OUT    : out std_logic;
      LD          : in  std_logic_vector(31 downto 0);  -- Data input
      LD_O        : out std_logic_vector(31 downto 0);  -- Data output
      DATA_FLAG   : in  std_logic;                      -- Data flag
      DATA_FLAG_O : out std_logic;
      CTRL_FLAG   : in  std_logic;                      -- Control flag
      CTRL_FLAG_O : out std_logic;
      TEST_FLAG   : in  std_logic;                      -- Test mode
      TEST_FLAG_O : out std_logic;
      FULL        : in  std_logic;                      -- FIFO full
      FULL_OUT    : out std_logic;
      RX_ERROR    : in  std_logic;                      -- CRC error detected
      LDERR       : out std_logic;                      -- CRC or par. error
      RESET       : in  std_logic
      );

  end component;

--==============================================================================
  component TESTCHECK
--==============================================================================
    port (
      CLK       : in  std_logic;                      -- Input clock
      INT_LDOWN : in  std_logic;
      RRES_IN   : in  std_logic;
      LD        : in  std_logic_vector(31 downto 0);  -- Data input
      LD_O      : out std_logic_vector(31 downto 0);  -- Data output
      DATA_FLAG : in  std_logic;                      -- Write enable
      LWEN_N_O  : out std_logic;                      -- Write enable
      LCTRL     : in  std_logic;                      -- Control word
      LCTRL_N_O : out std_logic;                      -- Control word
      LDERR     : in  std_logic;                      -- Error input
      LDERR_N_O : out std_logic;                      -- Error output
      TEST_MODE : in  std_logic;                      -- Card in test mode
      FULL      : in  std_logic;                      -- FIFO full
      RESET     : in  std_logic;
      UTDO_N    : in  std_logic;                      -- Sampled UTDO_N
      DERRLED_N : out std_logic;                      -- Data error/FIFO
                                                      -- full LED
      TESTLED_N : out std_logic
      );
  end component;

--==============================================================================
  component CONTROL_LDC
--==============================================================================
    generic (
      INIT_LENGTH : integer             -- determines the
                                        -- duration of the
                                        -- initialitation
                                        -- (set by SIMULATION
                                        -- generic)
      );

    port (
      POWER_UP_RST_N : in  std_logic;
      XCLK           : in  std_logic;
      LCLK           : in  std_logic;
      URESET_N       : in  std_logic;                      -- Asyn.
      RRES           : in  std_logic;                      -- RX_CLK
      LDOWN          : in  std_logic;                      -- RX_CLK
      TEST_MODE      : in  std_logic;                      -- LCLK
      UXOFF_N        : in  std_logic;                      -- Asyn.
      URL            : in  std_logic_vector(3 downto 0);   -- Asyn.
      UTDO_N         : in  std_logic;                      -- Asyn.
      LFF_N          : in  std_logic;                      -- LCLK
      TLK_DOWN       : in  std_logic;
      LDOWN_N        : out std_logic;                      -- Asyn.
      INT_LDOWN      : out std_logic;
      LUPLED_N       : out std_logic;                      -- LCLK
      SEND_XOFF      : out std_logic;                      -- LCLK
      SEND_RST       : out std_logic;
      UTDO_N_OUT     : out std_logic;
      TX_ER          : out std_logic;                      -- XCLK
      TX_EN          : out std_logic;                      -- XCLK
      TXD            : out std_logic_vector(31 downto 0);  -- XCLK
      FLOWCTLLED_N   : out std_logic                       -- XCLK
      );

  end component;


--------------------------------------------------------------------------------
-- End of component declarations
--------------------------------------------------------------------------------

--==============================================================================
-- Internal signals
--==============================================================================

--------------------------------------------------------------------------------
-- signal names have where possible prefix of module where it is output from
-- signal names have where possible suffix of clock they are synchronised to
-- L  : Synchronous to LCLK
-- X  : Synchronous to XCLK
-- I  : Synchronous to ICLK_2 - i clk removed is now RX_CLK
-- RX : Synchronous to RX_CLK
--------------------------------------------------------------------------------

  signal XCLK_int : std_logic;

  signal IN_WEN_I  : std_logic;
  signal IN_DATA_I : std_logic_vector(32 downto 0);

  signal IN_SENDRRES_RX : std_logic;
  signal IN_LDOWN_RX    : std_logic;
  signal IN_TESTOUT_I   : std_logic;
  signal IN_RESETSIG_RX : std_logic;
  signal IN_TLK_DOWN_RX : std_logic;

  signal FIFO_DATA_L      : std_logic_vector(32 downto 0);
  signal FIFO_EMPTY_L     : std_logic;
  signal FIFO_FULL_L      : std_logic;
  signal FIFO_LFFN_L      : std_logic;
  signal FIFO_TESTOUT_L   : std_logic;
  signal FIFO_RRES_L      : std_logic;
  signal FRAME_REN_L      : std_logic;
  signal FRAME_DATA_L     : std_logic_vector(31 downto 0);
  signal FRAME_CTRLFLAG_L : std_logic;
  signal FRAME_DATAFLAG_L : std_logic;
  signal FRAME_TESTFLAG_L : std_logic;
  signal FRAME_CRCFLAG_L  : std_logic;
  signal FRAME_FULL_L     : std_logic;
  signal FRAME_RRES_L     : std_logic;

  signal CRC_DATA_L     : std_logic_vector(31 downto 0);
  signal CRC_DATAFLAG_L : std_logic;
  signal CRC_CTRLFLAG_L : std_logic;
  signal CRC_CRCERROR_L : std_logic;
  signal CRC_TESTFLAG_L : std_logic;
  signal CRC_FULL_L     : std_logic;
  signal CRC_RRES_L     : std_logic;

  signal PAR_DATA_L     : std_logic_vector(31 downto 0);
  signal PAR_DATAFLAG_L : std_logic;
  signal PAR_CTRLFLAG_L : std_logic;
  signal PAR_TESTFLAG_L : std_logic;
  signal PAR_LDERR_L    : std_logic;
  signal PAR_FULL_L     : std_logic;
  signal PAR_RRES_L     : std_logic;
  signal CTRL_RESET_L   : std_logic;
  signal CTRL_UXOFF_L   : std_logic;
  signal CTRL_UTDO_N_L  : std_logic;
  signal CTRL_LDOWN_L   : std_logic;

  signal srxer : std_logic;
  signal srxdv : std_logic;
  signal srxd  : std_logic_vector(31 downto 0);

--signal dll_reset         : std_logic;

--==============================================================================
begin
--==============================================================================

--------------------------------------------------------------------------------
-- CONSTANT SETTINGS                                                          --
--------------------------------------------------------------------------------

  ENABLE <= '1';

--------------------------------------------------------------------------------
-- PORT MAPPINGS                                                              --
--------------------------------------------------------------------------------

  LCLK <= LCLK_IN;      -- user defined clock
  XCLK_int <= XCLK;     -- transceiver monitoring clock

--------------------------------------------------------------------------------
  F_SIM0 : if SIMULATION = 1 generate
    front_sim : FRONT
--------------------------------------------------------------------------------
      generic map(
        FRONT_INIT_LENGTH => 7,
        ACTIVITY_LENGTH   => ACTIVITY_LENGTH
        )
      port map (
        POWER_UP_RST_N => POWER_UP_RST_N,
        XCLK           => XCLK_int,
        RX_CLK         => RX_CLK,
        RX_DV          => sRXDV,
        RX_ER          => sRXER,
        RXD            => sRXD,
        TEST_OUT       => IN_TESTOUT_I,
        WEN            => IN_WEN_I,
        OUT_DATA       => IN_DATA_I,
        SEND_RRES      => IN_SENDRRES_RX,
        RESET_SIGNAL   => IN_RESETSIG_RX,
        LDOWN          => IN_LDOWN_RX,
        TLK_DOWN       => IN_TLK_DOWN_RX,
        ACTIVITYLED_N  => ACTIVITYLED_N
        );

  end generate;

--------------------------------------------------------------------------------
  F_SIM1 : if SIMULATION = 0 generate
    front1 : FRONT
--------------------------------------------------------------------------------
      generic map(
        FRONT_INIT_LENGTH => 17,--25,
        ACTIVITY_LENGTH   => ACTIVITY_LENGTH
        )
      port map (
        POWER_UP_RST_N => POWER_UP_RST_N,
        XCLK           => XCLK_int,
        RX_CLK         => RX_CLK,
        RX_DV          => sRXDV,
        RX_ER          => sRXER,
        RXD            => sRXD,
        TEST_OUT       => IN_TESTOUT_I,
        WEN            => IN_WEN_I,
        OUT_DATA       => IN_DATA_I,
        SEND_RRES      => IN_SENDRRES_RX,
        RESET_SIGNAL   => IN_RESETSIG_RX,
        LDOWN          => IN_LDOWN_RX,
        TLK_DOWN       => IN_TLK_DOWN_RX,
        ACTIVITYLED_N  => ACTIVITYLED_N
        );

  end generate;



--------------------------------------------------------------------------------
  fifoldc1 : fifoldc
--------------------------------------------------------------------------------

    generic map(
      ALTERA_XILINX => ALTERA_XILINX,
      FIFODEPTH     => FIFODEPTH,
      LOG2DEPTH     => LOG2DEPTH,
      FULLMARGIN    => FULLMARGIN
      )
    port map(
      POWER_UP_RST_N => POWER_UP_RST_N,
      RESET          => CTRL_RESET_L,
      TEST_IN        => IN_TESTOUT_I,
      TEST_OUT       => FIFO_TESTOUT_L,
      RRES_IN        => IN_RESETSIG_RX,
      RRES_OUT       => FIFO_RRES_L,
      RX_CLK         => RX_CLK,
      UD             => IN_DATA_I,
      WEN            => IN_WEN_I,
      REN            => FRAME_REN_L,
      DATA           => FIFO_DATA_L,
      EMPTY          => FIFO_EMPTY_L,
      FULL           => FIFO_FULL_L,
      LFF_N          => FIFO_LFFN_L,
      LCLK           => LCLK_IN
      );


--------------------------------------------------------------------------------
  frameldc1 : FRAMELDC
--------------------------------------------------------------------------------

    port map(
      CLK       => LCLK_IN,
      TEST_IN   => FIFO_TESTOUT_L,
      LD        => FIFO_DATA_L,
      UXOFF_N   => CTRL_UXOFF_L,
      EMPTY     => FIFO_EMPTY_L,
      REN       => FRAME_REN_L,
      FULL      => FIFO_FULL_L,
      RRES_IN   => FIFO_RRES_L,
      RRES_OUT  => FRAME_RRES_L,
      LD_O      => FRAME_DATA_L,
      CTRL_FLAG => FRAME_CTRLFLAG_L,
      DATA_FLAG => FRAME_DATAFLAG_L,
      TEST_FLAG => FRAME_TESTFLAG_L,
      CRC_FLAG  => FRAME_CRCFLAG_L,
      FULL_OUT  => FRAME_FULL_L,
      RESET_IN  => CTRL_RESET_L
      );


--------------------------------------------------------------------------------
  crcldc1 : CRCLDC
--------------------------------------------------------------------------------

    port map(
      CLK       => LCLK_IN,
      RRES_IN   => FRAME_RRES_L,
      RRES_OUT  => CRC_RRES_L,
      RX_D      => FRAME_DATA_L,
      RX_D_O    => CRC_DATA_L,
      RX_DATA   => FRAME_DATAFLAG_L,
      RX_DATA_O => CRC_DATAFLAG_L,
      RX_CNTL   => FRAME_CTRLFLAG_L,
      RX_CNTL_O => CRC_CTRLFLAG_L,
      RX_CRC    => FRAME_CRCFLAG_L,
      CRC_ERROR => CRC_CRCERROR_L,
      RX_TEST   => FRAME_TESTFLAG_L,
      RX_TEST_O => CRC_TESTFLAG_L,
      FULL      => FRAME_FULL_L,
      FULL_OUT  => CRC_FULL_L,
      RESET     => CTRL_RESET_L
      );


--------------------------------------------------------------------------------
  parldc1 : PARLDC
--------------------------------------------------------------------------------

    port map(
      CLK         => LCLK_IN,
      RRES_IN     => CRC_RRES_L,
      RRES_OUT    => PAR_RRES_L,
      LD          => CRC_DATA_L,
      LD_O        => PAR_DATA_L,
      DATA_FLAG   => CRC_DATAFLAG_L,
      DATA_FLAG_O => PAR_DATAFLAG_L,
      CTRL_FLAG   => CRC_CTRLFLAG_L,
      CTRL_FLAG_O => PAR_CTRLFLAG_L,
      TEST_FLAG   => CRC_TESTFLAG_L,
      TEST_FLAG_O => PAR_TESTFLAG_L,
      FULL        => CRC_FULL_L,
      FULL_OUT    => PAR_FULL_L,
      RX_ERROR    => CRC_CRCERROR_L,
      LDERR       => PAR_LDERR_L,
      RESET       => CTRL_RESET_L
      );


--------------------------------------------------------------------------------
  testcheck1 : TESTCHECK
--------------------------------------------------------------------------------

    port map(
      CLK       => LCLK_IN,
      INT_LDOWN => CTRL_LDOWN_L,
      RRES_IN   => PAR_RRES_L,
      LD        => PAR_DATA_L,
      LD_O      => LD,
      DATA_FLAG => PAR_DATAFLAG_L,
      LWEN_N_O  => LWEN_N,
      LCTRL     => PAR_CTRLFLAG_L,
      LCTRL_N_O => LCTRL_N,
      LDERR     => PAR_LDERR_L,
      LDERR_N_O => LDERR_N,
      TEST_MODE => PAR_TESTFLAG_L,
      FULL      => PAR_FULL_L,
      RESET     => CTRL_RESET_L,
      UTDO_N    => CTRL_UTDO_N_L,
      DERRLED_N => LDERRLED_N,
      TESTLED_N => TESTLED_N
      );


--------------------------------------------------------------------------------
  SIM1 : if SIMULATION = 1 generate
    control_ldc_sim : CONTROL_LDC
--------------------------------------------------------------------------------

      generic map (
        INIT_LENGTH => 2
        )
      port map(
        POWER_UP_RST_N => POWER_UP_RST_N,
        XCLK           => XCLK_int,
        LCLK           => LCLK_IN,
        URESET_N       => URESET_N,
        RRES           => IN_SENDRRES_RX,
        LDOWN          => IN_LDOWN_RX,
        TEST_MODE      => PAR_TESTFLAG_L,
        UXOFF_N        => UXOFF_N,
        URL            => URL,
        UTDO_N         => UTDO_N,
        LFF_N          => FIFO_LFFN_L,
        TLK_DOWN       => IN_TLK_DOWN_RX,
        LDOWN_N        => LDOWN_N,
        INT_LDOWN      => CTRL_LDOWN_L,
        LUPLED_N       => LUPLED_N,
        SEND_XOFF      => CTRL_UXOFF_L,
        SEND_RST       => CTRL_RESET_L,
        UTDO_N_OUT     => CTRL_UTDO_N_L,
        TX_ER          => TX_ER,
        TX_EN          => TX_EN,
        TXD            => TXD,
        FLOWCTLLED_N   => FLOWCTLLED_N
        );

  end generate;


--------------------------------------------------------------------------------
  SIM2 : if SIMULATION = 0 generate
    control_ldc1 : CONTROL_LDC
--------------------------------------------------------------------------------

      generic map (
        INIT_LENGTH => 15
        )

      port map(
        POWER_UP_RST_N => POWER_UP_RST_N,
        XCLK           => XCLK_int,
        LCLK           => LCLK_IN,
        URESET_N       => URESET_N,
        RRES           => IN_SENDRRES_RX,
        LDOWN          => IN_LDOWN_RX,
        TEST_MODE      => PAR_TESTFLAG_L,
        UXOFF_N        => UXOFF_N,
        URL            => URL,
        UTDO_N         => UTDO_N,
        LFF_N          => FIFO_LFFN_L,
        TLK_DOWN       => IN_TLK_DOWN_RX,
        LDOWN_N        => LDOWN_N,
        INT_LDOWN      => CTRL_LDOWN_L,
        LUPLED_N       => LUPLED_N,
        SEND_XOFF      => CTRL_UXOFF_L,
        SEND_RST       => CTRL_RESET_L,
        UTDO_N_OUT     => CTRL_UTDO_N_L,
        TX_ER          => TX_ER,
        TX_EN          => TX_EN,
        TXD            => TXD,
        FLOWCTLLED_N   => FLOWCTLLED_N
        );

  end generate;

  sRXD  <= RXD;
  srxer <= RX_ER;
  srxdv <= RX_DV;

end structure;

--==============================================================================
-- END OF ARCHITECTURE
--==============================================================================


--==============================================================================
--==============================================================================
--                           E N D   O F   F I L E                            --
--==============================================================================
--==============================================================================

