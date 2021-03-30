----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Random Access Memory
-- Version: 2.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    port ( clk         :  in std_logic;
           enable      :  in std_logic;
           writeEnable :  in std_logic;
           readEnable  :  in std_logic;
           address     :  in std_logic_vector(31 downto 0);
           dataIn      :  in std_logic_vector(31 downto 0);
           dataOut     : out std_logic_vector(31 downto 0));
end RAM;

architecture Behavioral of RAM is
type RAM_t is array ( 0 to 65535) of std_logic_vector(31 downto 0);
signal RAM1 : RAM_t := (others => X"0000_0000");
signal RAM2 : RAM_t := (others => X"0000_0000");
begin
WRITE: process (clk)
begin
    if enable = '1' then
        if conv_integer(address(31 downto 16)) = 0 then
            if clk = '1' and clk'event then
                if writeEnable = '1' then
                    RAM1(conv_integer(address(15 downto 0))) <= dataIn;
                end if;
            end if;
        else
            if clk = '1' and clk'event then
                if writeEnable = '1' then
                    RAM2(conv_integer(address(15 downto 0))) <= dataIn;
                end if;
            end if;
        end if;
    end if;
end process;
READ: process (clk)
begin
    if enable = '1' then
        if conv_integer(address(31 downto 16)) = 0 then
            if clk = '0' and clk'event then
                if readEnable = '1' then
                    dataOut <= RAM1(conv_integer(address(15 downto 0)));
                end if;
            end if;
        else
            if clk = '0' and clk'event then
                if readEnable = '1' then
                    dataOut <= RAM2(conv_integer(address(15 downto 0)));
                end if;
            end if;
        end if;
    end if;
end process;
end Behavioral;
