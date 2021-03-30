----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Register File TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_RF is
end testbench_RF;

architecture Behavioral of testbench_RF is
component RegisterFile is
    port ( clk           :  in std_logic;
           enable        :  in std_logic;
           registerWrite1:  in std_logic; 
           registerWrite2:  in std_logic; 
           registerWrite3:  in std_logic; 
           readAdr1      :  in std_logic_vector ( 4 downto 0);
           readAdr2      :  in std_logic_vector ( 4 downto 0);
           readAdr3      :  in std_logic_vector ( 4 downto 0);
           writeAdr1     :  in std_logic_vector ( 4 downto 0);
           writeAdr2     :  in std_logic_vector ( 4 downto 0);
           writeAdr3     :  in std_logic_vector ( 4 downto 0);
           writeData1    :  in std_logic_vector (31 downto 0);
           writeData2    :  in std_logic_vector (31 downto 0);
           writeData3    :  in std_logic_vector (31 downto 0);
           readData1     : out std_logic_vector (31 downto 0);
           readData2     : out std_logic_vector (31 downto 0);
           readData3     : out std_logic_vector (31 downto 0));
end component RegisterFile;
signal in_clk        : std_logic := '0';
signal in_regWr1     : std_logic := '0';
signal in_regWr2     : std_logic := '0';
signal in_regWr3     : std_logic := '0';
signal in_readAdr1   : std_logic_vector( 4 downto 0);
signal in_readAdr2   : std_logic_vector( 4 downto 0);
signal in_readAdr3   : std_logic_vector( 4 downto 0);
signal in_writeAdr1  : std_logic_vector( 4 downto 0);
signal in_writeAdr2  : std_logic_vector( 4 downto 0);
signal in_writeAdr3  : std_logic_vector( 4 downto 0);
signal in_writeData1 : std_logic_vector(31 downto 0);
signal in_writeData2 : std_logic_vector(31 downto 0);
signal in_writeData3 : std_logic_vector(31 downto 0);
signal out_readData1 : std_logic_vector(31 downto 0);
signal out_readData2 : std_logic_vector(31 downto 0);
signal out_readData3 : std_logic_vector(31 downto 0);
begin
GENERATE_CLOCK: in_clk <= not in_clk after 1 ps;
in_readAdr1   <= "00001",
                 "10000" after  5 ps,
                 "00001" after 11 ps;
in_readAdr2   <= "00010",
                 "10001" after  5 ps,
                 "00010" after 11 ps;
in_readAdr3   <= "00011",
                 "10010" after  5 ps,
                 "00011" after 11 ps;
in_writeAdr1  <= "00001";
in_writeAdr2  <= "00010";
in_writeAdr3  <= "00011";
in_writeData1 <= X"0000_0000",
                 X"FFFF_FFFE" after  7 ps,
                 X"0000_0000" after 11 ps;
in_writeData2 <= X"0000_0000",
                 X"FFFF_FFFD" after  9 ps,
                 X"0000_0000" after 11 ps;
in_writeData3 <= X"0000_0000",
                 X"FFFF_FFFC" after  9 ps,
                 X"0000_0000" after 11 ps;
in_regWr1 <= '1' after  7 ps,
             '0' after  9 ps;
in_regWr2 <= '1' after  9 ps,
             '0' after 11 ps;
in_regWr3 <= '1' after  9 ps,
             '0' after 11 ps;
UUT: RegisterFile port map ( clk => in_clk,
                             enable => '1',
                             registerWrite1 => in_regWr1,
                             registerWrite2 => in_regWr2,
                             registerWrite3 => in_regWr3,
                             readAdr1 => in_readAdr1,
                             readAdr2 => in_readAdr2,
                             readAdr3 => in_readAdr3,
                             writeAdr1 => in_writeAdr1,
                             writeAdr2 => in_writeAdr2,
                             writeAdr3 => in_writeAdr3,
                             writeData1 => in_writeData1,
                             writeData2 => in_writeData2,
                             writeData3 => in_writeData3,
                             readData1 => out_readData1,
                             readData2 => out_readData2,
                             readData3 => out_readData3);
end Behavioral;
