----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Register File
-- Version: 3.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
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
end RegisterFile;

architecture Behavioral of RegisterFile is
type regArray is array ( 0 to 31) of std_logic_vector(31 downto 0);
signal RF : regArray :=(X"000F_0001",X"000E_0002",
                        X"000D_0003",X"000C_0004",
                        X"000B_0005",X"000A_0006",
                        X"0009_0007",X"0008_0008",
                        X"0007_0009",X"0006_000A",
                        X"0005_000B",X"0004_000C",
                        X"0003_000D",X"0002_000E",
                        X"0001_000F",X"0010_0010",
                        X"001F_0011",X"001E_0012",
                        X"001D_0013",X"001C_0014",
                        X"001B_0015",X"001A_0016",
                        X"0019_0017",X"0018_0018",
                        X"0017_0019",X"0016_001A",
                        X"0015_001B",X"0014_001C",
                        X"0013_001D",X"0012_001E",
                        X"0011_001F",X"0020_0020");
begin
REG_FILE: process (clk)
begin
    if enable = '1' then
        if clk = '1' and clk'event then
            if registerWrite1 = '1' then
                RF(conv_integer(writeAdr1)) <= writeData1;
            end if;
            if registerWrite2 = '1' then
                RF(conv_integer(writeAdr2)) <= writeData2;
            end if;
            if registerWrite3 = '1' then
                RF(conv_integer(writeAdr3)) <= writeData3;
            end if;
        end if;
    end if;
end process;
READ_DATA: process(clk, enable)
begin
    if enable = '1' then
        readData1 <= RF(conv_integer(readAdr1));
        readData2 <= RF(conv_integer(readAdr2));
        readData3 <= RF(conv_integer(readAdr3));
    end if;
end process;
end Behavioral;
