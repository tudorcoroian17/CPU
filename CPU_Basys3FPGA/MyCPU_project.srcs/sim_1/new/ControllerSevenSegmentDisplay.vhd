----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Seven Segment Display Controller
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControllerSevenSegmentDisplay is
    port ( clk     :  in STD_LOGIC;
           digits  :  in STD_LOGIC_VECTOR (15 downto 0);
           anode   : out STD_LOGIC_VECTOR ( 3 downto 0);
           cathode : out STD_LOGIC_VECTOR ( 7 downto 0));
end ControllerSevenSegmentDisplay;

architecture Behavioral of ControllerSevenSegmentDisplay is
signal counter : std_logic_vector(15 downto 0) := (others => '0');
signal decoder : std_logic_vector( 3 downto 0) := (others => '0');
begin
FREQ_DIVIDER: process (clk, counter)
begin
    if clk = '1' and clk'event then
        counter <= counter + 1;
    end if;
end process;
ANODE_SELECTOR: process (counter)
begin
    case counter(15 downto 14) is
        when "00"   => anode <= "1110"; -- first display
        when "01"   => anode <= "1101"; -- second display
        when "10"   => anode <= "1011"; -- third display
        when "11"   => anode <= "0111"; -- fourth display
        when others => anode <= "1111"; -- error
    end case;
end process;
DIGIT_SELECTOR: process (counter, digits)
begin
    case counter(15 downto 14) is 
        when "00"   => decoder <= digits( 3 downto  0); -- set first digit
        when "01"   => decoder <= digits( 7 downto  4); -- set second digit
        when "10"   => decoder <= digits(11 downto  8); -- set tirhd digit
        when "11"   => decoder <= digits(15 downto 12); -- set fourth digit
        when others => decoder <= "0000";               -- error
    end case;
end process;
CATHODE_SELECTOR: process(decoder)
begin
    case decoder is
        when "0000" => cathode <= "11000000"; -- 0
        when "0001" => cathode <= "11111001"; -- 1
        when "0010" => cathode <= "10100100"; -- 2
        when "0011" => cathode <= "10110000"; -- 3
        when "0100" => cathode <= "10011001"; -- 4
        when "0101" => cathode <= "10010010"; -- 5
        when "0110" => cathode <= "10000010"; -- 6
        when "0111" => cathode <= "11111000"; -- 7
        when "1000" => cathode <= "10000000"; -- 8   
        when "1001" => cathode <= "10010000"; -- 9
        when "1010" => cathode <= "10001000"; -- A
        when "1011" => cathode <= "10000011"; -- B
        when "1100" => cathode <= "11000110"; -- C
        when "1101" => cathode <= "10100001"; -- D
        when "1110" => cathode <= "10000110"; -- E
        when "1111" => cathode <= "10001110"; -- F
        when others => cathode <= "11111111"; -- segments off
    end case;
end process;
end Behavioral;
