----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Current Program State Register TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_CPSR is
end testbench_CPSR;

architecture Behavioral of testbench_CPSR is
component CPSR is
    Port ( clk      :  in std_logic;
           write_en :  in std_logic;
           data_in  :  in std_logic_vector( 3 downto 0);
           data_out : out std_logic_vector( 3 downto 0));
end component CPSR;
signal  in_clk      : std_logic := '0';
signal  in_read_en  : std_logic;
signal  in_write_en : std_logic;
signal  in_data_in  : std_logic_vector( 3 downto 0);
signal out_data_out : std_logic_vector( 3 downto 0);
begin
GEN_CLK: in_clk <= not in_clk after 1 ps;
in_write_en <= '1', '0' after 3 ps;
in_data_in <= "1010", "0000" after 3 ps;
UUT: CPSR port map ( clk      =>  in_clk,
                     write_en =>  in_write_en,
                     data_in  =>  in_data_in,
                     data_out => out_data_out);
end Behavioral;
