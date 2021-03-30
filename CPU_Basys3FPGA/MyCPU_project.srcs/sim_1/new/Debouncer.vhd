----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Debouncer
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Debouncer is
    port ( clk      :  in std_logic; -- Clock signal from the board at 100MHz
           button   :  in std_logic_vector(4 downto 0); -- Signals from all the buttons of the board
           dbButton : out std_logic_vector(4 downto 0)  -- Debounced signals for all the buttons
          );
end Debouncer;

architecture Behavioral of Debouncer is
-- signals -----------------------------------------------------------------------
signal q1: std_logic_vector(4 downto 0) := (others => '0');
signal q2: std_logic_vector(4 downto 0) := (others => '0');
signal q3: std_logic_vector(4 downto 0) := (others => '0');
signal counter: std_logic_vector(16 downto 0) := (others => '0');
----------------------------------------------------------------------------------
begin

FREQ_DIVIDER: process (clk, counter)
begin
    if clk = '1' and clk'event then
        counter <= counter + 1;
    end if;
end process;

LATCHES: process (clk, counter)
begin
    if clk = '1' and clk'event then
        if counter(16) = '1' then
            q1 <= button;
            q2 <= q1;
            q3 <= q2;
        end if;
    end if;
end process;

T_AND: dbButton <= q1 and q2 and (not q3);

end Behavioral;
