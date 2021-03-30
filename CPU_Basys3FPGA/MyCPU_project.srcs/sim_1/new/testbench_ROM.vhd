----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Read Only Memory TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_ROM is
end testbench_ROM;

architecture Behavioral of testbench_ROM is
component ROM is
    port ( address :  in std_logic_vector(31 downto 0);
           data    : out std_logic_vector(31 downto 0));
end component ROM;
signal in_addrs: std_logic_vector(31 downto 0);
signal out_data: std_logic_vector(31 downto 0);
begin
in_addrs <= X"0000_0000",
            X"0000_0001" after 1 ps,
            X"0000_0002" after 2 ps;
UUT: ROM port map ( address => in_addrs,
                    data    => out_data);
end Behavioral;
