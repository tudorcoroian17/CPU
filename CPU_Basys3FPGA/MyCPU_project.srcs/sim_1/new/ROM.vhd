----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Read Only Memory
-- Version: 2.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    port ( address :  in std_logic_vector(31 downto 0);
           data    : out std_logic_vector(31 downto 0));
end ROM;

architecture Behavioral of ROM is
type ROM_t is array(0 to 65535) of std_logic_vector(31 downto 0);
signal ROM1 : ROM_t := (B"0000_00010_00011_00100_00000_0000_0000",
                        B"0000_00011_00100_00101_00000_0000_0000", 
                        B"0000_00010_00011_00000_00000_0100_0000",
                        B"1111_00001_00010_00011_00000_0100_0000",
                        B"0000_00000_00111_00000000000000_0011",
                        B"0000_00000_01000_00000000000000_0010",
                        B"1011_01011_01100_01101_00000_0000_0000",
                        B"0000_1_00000000000000000000000_0100",
                        others => X"0000_0000");
signal ROM2 : ROM_t := (others => X"0000_0000");
begin
GET_DATA: process ( address )
begin
    if conv_integer(address(31 downto 16)) = 0 then
        data <= ROM1(conv_integer(address(15 downto 0)));
    else
        data <= ROM2(conv_integer(address(15 downto 0)));
    end if;
end process;
end Behavioral;
