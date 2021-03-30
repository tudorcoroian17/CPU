----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Execution Unit TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_EXU is
end testbench_EXU;

architecture Behavioral of testbench_EXU is
component EXU is
    Port ( A, B, C      :  in std_logic_vector(31 downto 0);
           in_shift_am  :  in std_logic_vector( 3 downto 0);
           in_shift_dir :  in std_logic_vector( 1 downto 0);
           in_flags     :  in std_logic_vector( 3 downto 0);
           in_op_code   :  in std_logic_vector( 3 downto 0);
           in_func_code :  in std_logic_vector( 3 downto 0);
           immediate    :  in std_logic_vector(31 downto 0);
           out_resh     : out std_logic_vector(31 downto 0);
           out_resm     : out std_logic_vector(31 downto 0);
           out_resl     : out std_logic_vector(31 downto 0);
           out_flags    : out std_logic_vector( 3 downto 0);
           ALUSrc       :  in std_logic);
end component EXU;
signal  in_in_shift_am  : std_logic_vector( 3 downto 0);
signal  in_in_shift_dir : std_logic_vector( 1 downto 0);
signal  in_term1        : std_logic_vector(31 downto 0);
signal  in_term2        : std_logic_vector(31 downto 0);
signal  in_term3        : std_logic_vector(31 downto 0);
signal  in_in_flags     : std_logic_vector( 3 downto 0);
signal  in_in_op_code   : std_logic_vector( 3 downto 0);
signal  in_in_func_code : std_logic_vector( 3 downto 0);
signal  in_immediate    : std_logic_vector(31 downto 0);
signal  in_ALUSrc       : std_logic;
signal out_out_resh     : std_logic_vector(31 downto 0);
signal out_out_resm     : std_logic_vector(31 downto 0);
signal out_out_resl     : std_logic_vector(31 downto 0);
signal out_out_flags    : std_logic_vector( 3 downto 0);
begin
in_in_flags <= "0000";
in_in_op_code <= "0000";
in_in_func_code <= "0000";
in_term1 <= X"1234_1234";
in_term2 <= X"1234_1234";
in_immediate <= X"ABCD_ABCD";
in_ALUSrc <= '0', '1' after 5 ps;
UUT: EXU port map ( A            =>  in_term1,
                    B            =>  in_term2,
                    C            =>  in_term3,
                    in_shift_am  =>  in_in_shift_am,
                    in_shift_dir =>  in_in_shift_dir,
                    in_flags     =>  in_in_flags,
                    in_op_code   =>  in_in_op_code,
                    in_func_code =>  in_in_func_code,
                    immediate    =>  in_immediate,
                    out_resh     => out_out_resh,
                    out_resm     => out_out_resm,
                    out_resl     => out_out_resl,
                    out_flags    => out_out_flags,
                    ALUSrc       =>  in_ALUSrc);
end Behavioral;
