----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Arithmetic Logic Unit Controller TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_ALUC is
end testbench_ALUC;

architecture Behavioral of testbench_ALUC is
component ALU_Controller is
    Port ( flags     :  in std_logic_vector( 3 downto 0);
           op_code   :  in std_logic_vector( 3 downto 0);
           func_code :  in std_logic_vector( 3 downto 0);
           operation : out std_logic_vector( 3 downto 0));
end component ALU_Controller;
signal  in_flags     : std_logic_vector( 3 downto 0);
signal  in_op_code   : std_logic_vector( 3 downto 0);
signal  in_func_code : std_logic_vector( 3 downto 0);
signal out_operation : std_logic_vector( 3 downto 0);
begin
in_flags <= "1111",
            "0000" after 3 ps;
in_op_code <= "0000",
              "0001" after 3 ps,
              "0010" after 5 ps,
              "0011" after 6 ps,
              "0101" after 7 ps;
in_func_code <= "0000",
                "0001" after 1 ps,
                "0010" after 2 ps,
                "0000" after 3 ps,
                "0001" after 4 ps;
UUT: ALU_Controller port map ( flags     =>  in_flags,
                               op_code   =>  in_op_code,
                               func_code =>  in_func_code,
                               operation => out_operation );
end Behavioral;
