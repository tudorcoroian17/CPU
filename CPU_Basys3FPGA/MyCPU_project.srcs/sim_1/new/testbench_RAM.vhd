----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Random Access Memory TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_RAM is
end testbench_RAM;

architecture Behavioral of testbench_RAM is
component RAM is
    port ( clk         :  in std_logic;
           enable      :  in std_logic;
           writeEnable :  in std_logic;
           readEnable  :  in std_logic;
           address     :  in std_logic_vector(31 downto 0);
           dataIn      :  in std_logic_vector(31 downto 0);
           dataOut     : out std_logic_vector(31 downto 0));
end component RAM;
signal  in_clk         : std_logic := '0';
signal  in_writeEnable : std_logic := '0';
signal  in_readEnable  : std_logic := '0';
signal  in_address     : std_logic_vector(31 downto 0);
signal  in_dataIn      : std_logic_vector(31 downto 0);
signal out_dataOut     : std_logic_vector(31 downto 0);
begin
GENERATE_CLOCK: in_clk <= not in_clk after 1 ps;
in_writeEnable <= '1', '0' after 3 ps;
in_readEnable <= '0', '1' after 2 ps;
in_address <= X"0000_1234";
in_dataIn <= X"2345_BCDE";
UUT: RAM port map ( clk         =>  in_clk,
                    enable      => '1',
                    writeEnable =>  in_writeEnable,
                    readEnable  =>  in_readEnable,
                    address     =>  in_address,
                    dataIn      =>  in_dataIn,
                    dataOut     => out_dataOut);
end Behavioral;
