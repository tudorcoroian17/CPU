----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Arithmetic Logic Unit
-- Version: 4.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_misc.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( term1       :  in STD_LOGIC_VECTOR (31 downto 0);
           term2       :  in STD_LOGIC_VECTOR (31 downto 0);
           term3       :  in STD_LOGIC_VECTOR (31 downto 0);
           operation   :  in STD_LOGIC_VECTOR ( 3 downto 0);
           result_high : out STD_LOGIC_VECTOR (31 downto 0);
           result      : out STD_LOGIC_VECTOR (31 downto 0);
           result_low  : out STD_LOGIC_VECTOR (31 downto 0);
           flags_out   : out STD_LOGIC_VECTOR ( 3 downto 0);
        -- flags_out(3) = Z (zero)
        -- flags_out(2) = V (overflow)
        -- flags_out(1) = C (carry)
        -- flags_out(0) = N (negative)
           shift_am    :  in STD_LOGIC_VECTOR ( 3 downto 0);
           shift_dir   :  in STD_LOGIC_VECTOR ( 1 downto 0));
end ALU;

architecture Behavioral of ALU is
signal Z_flag    : std_logic := '0';
signal V_flag    : std_logic := '0';
signal C_flag    : std_logic := '0';
signal N_flag    : std_logic := '0';
signal pad_left  : std_logic_vector(14 downto 0) := (others => '0');
signal pad_right : std_logic_vector(14 downto 0) := (others => '0');
begin
COMPUTE: process(operation, term1, term2, term3, shift_am, shift_dir)
    variable v_add_2 : UNSIGNED(32 downto 0);
    variable v_add_3 : UNSIGNED(33 downto 0);
    variable v_mul_2 : UNSIGNED(63 downto 0);
    variable v_mul_3 : UNSIGNED(95 downto 0);
    variable v_res_u : UNSIGNED(31 downto 0);
begin
    pad_left  <= (others => term1( 0));
    pad_right <= (others => term1(31));
    Z_flag <= '0';
    V_flag <= '0';
    C_flag <= '0';
    N_flag <= '0';
    v_add_2 := resize(UNSIGNED(term1), 33) + UNSIGNED(term2);
    v_add_3 := resize(UNSIGNED(term1), 34) + UNSIGNED(term2) + UNSIGNED(term3);
    v_mul_2 := UNSIGNED(term1) * UNSIGNED(term2);
    v_mul_3 := UNSIGNED(term1) * UNSIGNED(term2) * UNSIGNED(term3);
    case operation is
        when "0000" => result <= std_logic_vector(v_add_2(31 downto 0));--add
                       V_flag <= std_logic(v_add_2(32));
                       C_flag <= std_logic(v_add_2(32));
                       if conv_integer(std_logic_vector(v_add_2(31 downto 0))) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when "0001" => result <= term1 - term2;--sub
                       v_res_u := UNSIGNED(term1) - UNSIGNED(term2);
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
                       if to_integer(UNSIGNED(term1)) < to_integer(UNSIGNED(term2)) then
                           V_flag <= '1';
                           N_flag <= '1';
                       else V_flag <= '0';
                            N_flag <= '0';
                       end if;
        when "0010" => result <= term1 xor term2;--xor
                       v_res_u := UNSIGNED(term1) xor UNSIGNED(term2);
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when "0011" => result <= term1 and term2;--and
                       v_res_u := UNSIGNED(term1) and UNSIGNED(term2);
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when "0100" => result_high <= std_logic_vector(v_mul_2(63 downto 32));--mul
                       result <= (others => '0');
                       result_low  <= std_logic_vector(v_mul_2(31 downto  0));
                       if conv_integer(std_logic_vector(v_mul_2(63 downto 32))) = 0 then
                           V_flag <= '0';
                       else V_flag <= '1';
                       end if;
        when "0101" => --shift
            case shift_dir is
                when "00" => --sll
                    case shift_am is
                        when "0000" => result <= (others => '0');
                        when "0001" => result <= term1(30 downto 0) & "0";
                        when "0010" => result <= term1(29 downto 0) & "00";
                        when "0011" => result <= term1(28 downto 0) & "000";
                        when "0100" => result <= term1(27 downto 0) & "0000";
                        when "0101" => result <= term1(26 downto 0) & "00000";
                        when "0110" => result <= term1(25 downto 0) & "000000";
                        when "0111" => result <= term1(24 downto 0) & "0000000";
                        when "1000" => result <= term1(23 downto 0) & "00000000";
                        when "1001" => result <= term1(22 downto 0) & "000000000";
                        when "1010" => result <= term1(21 downto 0) & "0000000000";
                        when "1011" => result <= term1(20 downto 0) & "00000000000";
                        when "1100" => result <= term1(19 downto 0) & "000000000000";
                        when "1101" => result <= term1(18 downto 0) & "0000000000000";
                        when "1110" => result <= term1(17 downto 0) & "00000000000000";
                        when "1111" => result <= term1(16 downto 0) & "000000000000000";
                        when others => result <= X"FFFF_FFFF";
                    end case;
                when "01" => --srl
                    case shift_am is
                        when "0000" => result <= (others => '0');
                        when "0001" => result <= "0" & term1(31 downto 1);
                        when "0010" => result <= "00" & term1(31 downto 2);
                        when "0011" => result <= "000" & term1(31 downto 3);
                        when "0100" => result <= "0000" & term1(31 downto 4);
                        when "0101" => result <= "00000" & term1(31 downto 5);
                        when "0110" => result <= "000000" & term1(31 downto 6);
                        when "0111" => result <= "0000000" & term1(31 downto 7);
                        when "1000" => result <= "00000000" & term1(31 downto 8);
                        when "1001" => result <= "000000000" & term1(31 downto 9);
                        when "1010" => result <= "0000000000" & term1(31 downto 10);
                        when "1011" => result <= "00000000000" & term1(31 downto 11);
                        when "1100" => result <= "000000000000" & term1(31 downto 12);
                        when "1101" => result <= "0000000000000" & term1(31 downto 13);
                        when "1110" => result <= "00000000000000" & term1(31 downto 14);
                        when "1111" => result <= "000000000000000" & term1(31 downto 15);
                        when others => result <= X"FFFF_FFFF";
                    end case;
                when "10" => --sla
                    case shift_am is
                        when "0000" => result <= (others => '0');
                        when "0001" => result <= term1(30 downto 0) & pad_left(0);
                        when "0010" => result <= term1(29 downto 0) & pad_left( 1 downto 0);
                        when "0011" => result <= term1(28 downto 0) & pad_left( 2 downto 0);
                        when "0100" => result <= term1(27 downto 0) & pad_left( 3 downto 0);
                        when "0101" => result <= term1(26 downto 0) & pad_left( 4 downto 0);
                        when "0110" => result <= term1(25 downto 0) & pad_left( 5 downto 0);
                        when "0111" => result <= term1(24 downto 0) & pad_left( 6 downto 0);
                        when "1000" => result <= term1(23 downto 0) & pad_left( 7 downto 0);
                        when "1001" => result <= term1(22 downto 0) & pad_left( 8 downto 0);
                        when "1010" => result <= term1(21 downto 0) & pad_left( 9 downto 0);
                        when "1011" => result <= term1(20 downto 0) & pad_left(10 downto 0);
                        when "1100" => result <= term1(19 downto 0) & pad_left(11 downto 0);
                        when "1101" => result <= term1(18 downto 0) & pad_left(12 downto 0);
                        when "1110" => result <= term1(17 downto 0) & pad_left(13 downto 0);
                        when "1111" => result <= term1(16 downto 0) & pad_left(14 downto 0);
                        when others => result <= X"FFFF_FFFF";
                    end case;
                when "11" => --sra
                    case shift_am is
                        when "0000" => result <= (others => '0');
                        when "0001" => result <= pad_right(0) & term1(31 downto 1);
                        when "0010" => result <= pad_right( 1 downto 0) & term1(31 downto  2);
                        when "0011" => result <= pad_right( 2 downto 0) & term1(31 downto  3);
                        when "0100" => result <= pad_right( 3 downto 0) & term1(31 downto  4);
                        when "0101" => result <= pad_right( 4 downto 0) & term1(31 downto  5);
                        when "0110" => result <= pad_right( 5 downto 0) & term1(31 downto  6);
                        when "0111" => result <= pad_right( 6 downto 0) & term1(31 downto  7);
                        when "1000" => result <= pad_right( 7 downto 0) & term1(31 downto  8);
                        when "1001" => result <= pad_right( 8 downto 0) & term1(31 downto  9);
                        when "1010" => result <= pad_right( 9 downto 0) & term1(31 downto 10);
                        when "1011" => result <= pad_right(10 downto 0) & term1(31 downto 11);
                        when "1100" => result <= pad_right(11 downto 0) & term1(31 downto 12);
                        when "1101" => result <= pad_right(12 downto 0) & term1(31 downto 13);
                        when "1110" => result <= pad_right(13 downto 0) & term1(31 downto 14);
                        when "1111" => result <= pad_right(14 downto 0) & term1(31 downto 15);
                        when others => result <= X"FFFF_FFFF";
                    end case;
                when others => result <= X"FFFF_FFFF";
            end case;
        when "0110" => v_res_u := UNSIGNED(term1) - UNSIGNED(term2);
                       if to_integer(UNSIGNED(term1)) > to_integer(UNSIGNED(term2)) then--cmp
                           N_flag <= V_flag;
                       elsif to_integer(UNSIGNED(term1)) < to_integer(UNSIGNED(term2)) then
                           N_flag <= not V_flag;
                       else
                           Z_flag <= '1';
                       end if;
        when "0111" => result <= X"FFFF_FFFF";
        when "1000" => result <= std_logic_vector(v_add_3(31 downto 0)); --addt
                       V_flag <= std_logic(v_add_3(33)) or std_logic(v_add_3(32));
                       C_flag <= std_logic(v_add_3(33)) or std_logic(v_add_3(32));
                       if conv_integer(std_logic_vector(v_add_3(31 downto 0))) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when "1001" => result <= term1 - term2 - term3;--subt
                       v_res_u := UNSIGNED(term1) - UNSIGNED(term2) - UNSIGNED(term3);
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
                       if to_integer(v_res_u) < 0 then
                           V_flag <= '1';
                           N_flag <= '1';
                       else V_flag <= '0';
                            N_flag <= '0';
                       end if;
        when "1010" => result <= term1 xor term2 xor term3;--xort
                       v_res_u := UNSIGNED(term1) xor UNSIGNED(term2) xor UNSIGNED(term3);
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when "1011" => result <= term1 and term2 and term3;--andt
                       v_res_u := UNSIGNED(term1) and UNSIGNED(term2) and UNSIGNED(term3);
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when "1100" => result_high <= std_logic_vector(v_mul_3(95 downto 64));--mult
                       result      <= std_logic_vector(v_mul_3(63 downto 32));
                       result_low  <= std_logic_vector(v_mul_3(31 downto  0));
                       if conv_integer(std_logic_vector(v_mul_3(95 downto 64))) = 0 
                        and conv_integer(std_logic_vector(v_mul_3(63 downto 32))) = 0 then
                           V_flag <= '0';
                       else V_flag <= '1';
                       end if;
        when "1101" => result <= term1 or term2 or term3;--ort
                       v_res_u := UNSIGNED(term1) or UNSIGNED(term2) or UNSIGNED(term3);
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when "1110" => result <= not(term1 or term2 or term3);--nort
                       v_res_u := not(UNSIGNED(term1) or UNSIGNED(term2) or UNSIGNED(term3));
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when "1111" => result <= not(term1 and term2 and term3);--nandt
                       v_res_u := not(UNSIGNED(term1) and UNSIGNED(term2) and UNSIGNED(term3));
                       if conv_integer(std_logic_vector(v_res_u)) = 0 then
                           Z_flag <= '1';
                       else Z_flag <= '0';
                       end if;
        when others => result <= X"FFFF_FFFF";
    end case;
end process;
GET_FLAGREG: flags_out   <= Z_flag & V_flag & C_flag & N_flag;
end Behavioral;
