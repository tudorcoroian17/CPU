----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Execution Unit
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EXU is
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
end EXU;

architecture Behavioral of EXU is
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
component ALU_Controller is
    Port ( flags     :  in std_logic_vector( 3 downto 0);
           op_code   :  in std_logic_vector( 3 downto 0);
           func_code :  in std_logic_vector( 3 downto 0);
           operation : out std_logic_vector( 3 downto 0));
end component ALU_Controller;
signal ALU_term2 : std_logic_vector(31 downto 0);
signal ALU_op    : std_logic_vector( 3 downto 0);
begin
TERM2: process (ALUSrc, B, immediate)
begin
    if ALUSrc = '0' then 
        ALU_term2 <= B;
    else 
        ALU_term2 <= immediate;
    end if;
end process;
ALUC: ALU_Controller port map ( flags     =>  in_flags,
                                op_code   =>  in_op_code,
                                func_code =>  in_func_code,
                                operation => ALU_op);
ALUI: ALU port map ( term1       => A,
                     term2       => ALU_term2,
                     term3       => C,
                     operation   => ALU_op,
                     result_high => out_resh,
                     result      => out_resm,
                     result_low  => out_resl,
                     flags_out   => out_flags,
                     shift_am    => in_shift_am,
                     shift_dir   => in_shift_dir);
end Behavioral;
