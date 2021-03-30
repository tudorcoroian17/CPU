----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Memory + Write Back Unit TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_MEMU is
end testbench_MEMU;

architecture Behavioral of testbench_MEMU is
component MEMU is
    port ( mem_read   :  in std_logic;
           mem_write  :  in std_logic;
           mem_to_reg :  in std_logic;
           clk        :  in std_logic;
           enable     :  in std_logic;
           res_ALU    :  in std_logic_vector(31 downto 0);
           regFile_rt :  in std_logic_vector(31 downto 0);
           write_back : out std_logic_vector(31 downto 0));
end component MEMU;
signal  in_mem_read   : std_logic;
signal  in_mem_write  : std_logic;
signal  in_mem_to_reg : std_logic;
signal  in_clk        : std_logic := '0';
signal  in_res_ALU    : std_logic_vector(31 downto 0);
signal  in_regFile_rt : std_logic_vector(31 downto 0);
signal out_write_back : std_logic_vector(31 downto 0);
begin
GEN_CLK: in_clk <= not in_clk after 1 ps;
in_mem_read <= '1';
in_mem_write <= '1';
in_mem_to_reg <= '0', '1' after 5 ps;
in_res_ALU <= X"1234_ABCD";
in_regFile_rt <= X"ABCD_5678";
UUT: MEMU port map ( mem_read   => in_mem_read,
                     mem_write  => in_mem_write,
                     mem_to_reg => in_mem_to_reg,
                     clk        => in_clk,
                     enable     => '1',
                     res_ALU    => in_res_ALU,
                     regFile_rt => in_regFile_rt,
                     write_back => out_write_back);
end Behavioral;
