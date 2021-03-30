----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Arithmetic Logic Unit TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_ALU is
end testbench_ALU;

architecture Behavioral of testbench_ALU is
component ALU is
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
end component ALU;
signal in_term1 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal in_term2 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal in_term3 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal in_operation : STD_LOGIC_VECTOR( 3 downto 0);
signal in_shift_am  : STD_LOGIC_VECTOR( 3 downto 0) := (others => '0');
signal in_shift_dir : STD_LOGIC_VECTOR( 1 downto 0) := (others => '0');
signal out_flags : STD_LOGIC_VECTOR( 3 downto 0) := (others => '0');
signal out_reshi : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal out_resmi : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal out_reslo : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
in_shift_am <= X"4";
in_shift_dir <= "00" after  5 ps,
                "01" after  6 ps,
                "10" after  7 ps,
                "11" after  8 ps;
in_operation <= X"0", 
                X"1" after  1 ps, 
                X"2" after  2 ps, 
                X"3" after  3 ps, 
                X"4" after  4 ps, 
                X"5" after  5 ps, 
                X"6" after  9 ps, 
                X"8" after 10 ps, 
                X"9" after 11 ps, 
                X"A" after 12 ps, 
                X"B" after 13 ps, 
                X"C" after 14 ps, 
                X"D" after 15 ps, 
                X"E" after 16 ps, 
                X"F" after 17 ps;
in_term1 <= X"1111_2222", 
            X"0000_0088" after  1 ps, 
            X"FFFF_FFFF" after  2 ps, 
            X"2345_2345" after  3 ps, 
            X"4" after  4 ps,
            X"2345_2345" after 10 ps;
in_term2 <= X"2222_3333", 
            X"0000_00BB" after  1 ps, 
            X"0000_0002" after  2 ps, 
            X"2345_2345" after  3 ps, 
            X"3" after  4 ps,
            X"CCCC_CCCC" after 10 ps;
in_term3 <= X"2222_3333" after 10 ps, 
            X"2345_2345" after 11 ps, 
            X"0000_0002" after 12 ps, 
            X"2345_2345" after 13 ps, 
            X"1111_2222" after 14 ps;
UUT: ALU port map ( term1       => in_term1,
                    term2       => in_term2,
                    term3       => in_term3,
                    operation   => in_operation,
                    shift_am    => in_shift_am,
                    shift_dir   => in_shift_dir,
                    result_high => out_reshi,
                    result      => out_resmi,
                    result_low  => out_reslo,
                    flags_out   => out_flags);
end Behavioral;
