----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Memory Unit
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEMU is
    port ( mem_read   :  in std_logic;
           mem_write  :  in std_logic;
           mem_to_reg :  in std_logic;
           clk        :  in std_logic;
           enable     :  in std_logic;
           res_ALU    :  in std_logic_vector(31 downto 0);
           regFile_rt :  in std_logic_vector(31 downto 0);
           write_back : out std_logic_vector(31 downto 0));
end MEMU;

architecture Behavioral of MEMU is
component RAM is
    port ( clk         :  in std_logic;
           enable      :  in std_logic;
           writeEnable :  in std_logic;
           readEnable  :  in std_logic;
           address     :  in std_logic_vector(31 downto 0);
           dataIn      :  in std_logic_vector(31 downto 0);
           dataOut     : out std_logic_vector(31 downto 0));
end component RAM;
signal out_dataOut : std_logic_vector(31 downto 0);
begin
TO_WRITE: process (mem_to_reg, res_ALU, out_dataOut)
begin
    if mem_to_reg = '0' then
        write_back <= res_ALU;
    elsif mem_to_reg = '1' then
        write_back <= out_dataOut;
    end if;
end process;
CRAM: RAM port map ( clk => clk,
                     enable => enable,
                     writeEnable => mem_write,
                     readEnable => mem_read,
                     address => res_ALU,
                     dataIn => regFile_rt,
                     dataOut => out_dataOut);
end Behavioral;
