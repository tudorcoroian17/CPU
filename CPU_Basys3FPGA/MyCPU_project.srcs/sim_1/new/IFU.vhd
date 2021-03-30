----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Instruction Fetch Unit
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IFU is
    Port ( clk          :  in std_logic;
           reset        :  in std_logic;
           enable       :  in std_logic;
           jump_address :  in std_logic_vector(31 downto 0);
           jump_ctrl    :  in std_logic;
           instruction  : out std_logic_vector(31 downto 0);
           next_address : out std_logic_vector(31 downto 0));
end IFU;

architecture Behavioral of IFU is
component ROM is
    port ( address :  in std_logic_vector(31 downto 0);
           data    : out std_logic_vector(31 downto 0));
end component ROM;
signal counter  : std_logic_vector(31 downto 0) := (others => '0');
signal ROM_data : std_logic_vector(31 downto 0) := (others => '0');
begin
PROGRAM_COUNTER: process (clk, reset, enable)
begin
    if clk = '1' and clk'event then
        if reset = '1' then counter <= (others => '0');
        elsif enable = '1' then counter <= counter + 1;
        end if;
        if jump_ctrl = '1' then counter <= jump_address;
        end if;
    end if;
end process;
GET_INSTRUCTION: instruction <= ROM_data;
GET_NEXT_ADDRSS: next_address <= counter + 1;
ROM_COMP: ROM port map (address => counter, data => ROM_data);
end Behavioral;
