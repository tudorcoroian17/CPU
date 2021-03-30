----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Arithmetic Logic Unit Controller
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_misc.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_Controller is
    Port ( flags     :  in std_logic_vector( 3 downto 0);
           op_code   :  in std_logic_vector( 3 downto 0);
           func_code :  in std_logic_vector( 3 downto 0);
           operation : out std_logic_vector( 3 downto 0));
end ALU_Controller;

architecture Behavioral of ALU_Controller is
begin
GEN_OP: process ( op_code, func_code, flags )
begin
    case flags is
        when "1111" =>
            if op_code = "0000" then
                case func_code is 
                    when "0000" => operation <= "1000";
                    when "0001" => operation <= "1001";
                    when "0010" => operation <= "1010";
                    when "0011" => operation <= "1011";
                    when "0100" => operation <= "1100";
                    when "0101" => operation <= "1101";
                    when "0110" => operation <= "1110";
                    when "0111" => operation <= "1111";
                    when others => operation <= "0111";
                end case;
            end if;
        when others =>
            case op_code is
                when "0000" =>
                    case func_code is
                        when "0000" => operation <= "0000";
                        when "0001" => operation <= "0001";
                        when "0010" => operation <= "0010";
                        when "0011" => operation <= "0011";
                        when "0100" => operation <= "0100";
                        when others => operation <= "0111";
                    end case;
                when "0001" =>
                    case func_code is
                        when "0000" => operation <= "0101";
                        when "0001" => operation <= "0110";
                        when others => operation <= "0111";
                    end case;
                when "0010" => operation <= "0000";
                when "0011" => operation <= "0000";
                when "0101" => operation <= "0000";
                when others => operation <= "0111";
            end case;
    end case;
end process;
end Behavioral;
