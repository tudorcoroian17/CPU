----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Instruction Fetch Unit TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_IFU is
end testbench_IFU;

architecture Behavioral of testbench_IFU is
component IFU is
    Port ( clk          :  in std_logic;
           reset        :  in std_logic;
           enable       :  in std_logic;
           jump_address :  in std_logic_vector(31 downto 0);
           jump_ctrl    :  in std_logic;
           instruction  : out std_logic_vector(31 downto 0);
           next_address : out std_logic_vector(31 downto 0));
end component IFU;
signal in_clk           : std_logic := '0';
signal in_reset         : std_logic := '0';
signal in_enable        : std_logic := '0';
signal in_jump_address  : std_logic_vector(31 downto 0);
signal in_jump_ctrl     : std_logic := '0';
signal out_instruction  : std_logic_vector(31 downto 0);
signal out_next_address : std_logic_vector(31 downto 0);
begin
GENERATE_CLOCK : in_clk <= not in_clk after 1 ps;
GENERATE_BUTTON: in_enable <= '1',
                              '0' after 15 ps,
                              '1' after 21 ps;
GENERATE_RESET : in_reset <= '0',
                             '1' after 5 ps,
                             '0' after 7 ps,
                             '1' after 13 ps,
                             '0' after 15 ps;
GENERATE_JUMP_A: in_jump_address <= X"0000_000A";
GENERATE_JUMP_C: in_jump_ctrl <= '0',
                                 '1' after 23 ps,
                                 '0' after 25 ps;
UUT: IFU port map ( clk          => in_clk,
                    reset        => in_reset,
                    enable       => in_enable,
                    jump_address => in_jump_address,
                    jump_ctrl    => in_jump_ctrl,
                    instruction  => out_instruction,
                    next_address => out_next_address);
end Behavioral;
