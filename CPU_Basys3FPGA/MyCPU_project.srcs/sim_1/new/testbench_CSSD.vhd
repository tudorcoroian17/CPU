----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Seven Segment Display Controller TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_CSSD is
end testbench_CSSD;

architecture Behavioral of testbench_CSSD is
component ControllerSevenSegmentDisplay is
    port ( clk     :  in STD_LOGIC;
           digits  :  in STD_LOGIC_VECTOR (15 downto 0);
           anode   : out STD_LOGIC_VECTOR ( 3 downto 0);
           cathode : out STD_LOGIC_VECTOR ( 7 downto 0));
end component ControllerSevenSegmentDisplay;
signal  in_clk : std_logic := '0';
signal  in_digits  : std_logic_vector(15 downto 0);
signal out_anode   : std_logic_vector( 3 downto 0);
signal out_cathode : std_logic_vector( 7 downto 0); 
begin
GEN_CLK: in_clk <= not in_clk after 1 ps;
in_digits <= X"ABCD",
             X"1234" after 1 ns;
UUT: ControllerSevenSegmentDisplay port map ( clk     =>  in_clk,
                                              digits  =>  in_digits,
                                              anode   => out_anode,
                                              cathode => out_cathode );
end Behavioral;
