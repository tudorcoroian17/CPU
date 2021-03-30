----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Current Program State Register
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPSR is
    Port ( clk      :  in std_logic;
           write_en :  in std_logic;
           data_in  :  in std_logic_vector( 3 downto 0);
           data_out : out std_logic_vector( 3 downto 0));
end CPSR;

architecture Behavioral of CPSR is
signal Z, V, C, N : std_logic;
begin
SET_FLAGS: process (clk)
begin
    if clk = '1' and clk'event and write_en = '1' then
        Z <= data_in(3);
        V <= data_in(2);
        C <= data_in(1);
        N <= data_in(0);
    end if;
end process;
GET_FLAGS: data_out <= Z & V & C & N;
end Behavioral;
