----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Control Unit
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_CU is
end testbench_CU;

architecture Behavioral of testbench_CU is
component CU is
    Port ( flags         :  in std_logic_vector( 3 downto 0);
           func          :  in std_logic_vector( 3 downto 0);
           cond          :  in std_logic_vector( 3 downto 0);
           code          :  in std_logic_vector( 3 downto 0);
           IDU_en        : out std_logic;
           MEMU_en       : out std_logic;
           jump_ctrl     : out std_logic;
           regWr1        : out std_logic;
           regWr2        : out std_logic;
           regWr3        : out std_logic;
           regDst        : out std_logic;
           ALU_source    : out std_logic;
           mem_read      : out std_logic;
           mem_write     : out std_logic;
           mem_to_reg    : out std_logic;
           CPSR_write_en : out std_logic);
end component CU;
signal  in_flags : std_logic_vector( 3 downto 0);
signal  in_func  : std_logic_vector( 3 downto 0);
signal  in_code  : std_logic_vector( 3 downto 0);
signal  in_cond  : std_logic_vector( 3 downto 0);
signal out_IDU_en        : std_logic;
signal out_MEMU_en       : std_logic;
signal out_jump_ctrl     : std_logic;
signal out_regWr1        : std_logic;
signal out_regWr2        : std_logic;
signal out_regWr3        : std_logic;
signal out_regDst        : std_logic;
signal out_ALU_source    : std_logic;
signal out_mem_read      : std_logic;
signal out_mem_write     : std_logic;
signal out_mem_to_reg    : std_logic;
signal out_CPSR_write_en : std_logic;
begin
in_flags <= "1100",
            "0000" after 6 ps;
in_cond <= "1111",
           "1100" after 5 ps;
in_code <= "0000";
in_func <= "0100",
           "0000" after 5 ps;
UUT: CU port map ( flags         =>  in_flags, 
                   func          =>  in_func,   
                   cond          =>  in_cond,   
                   code          =>  in_code,   
                   IDU_en        => out_IDU_en,       
                   MEMU_en       => out_MEMU_en,      
                   jump_ctrl     => out_jump_ctrl,    
                   regWr1        => out_regWr1,       
                   regWr2        => out_regWr2,       
                   regWr3        => out_regWr3,       
                   regDst        => out_regDst,       
                   ALU_source    => out_ALU_source,   
                   mem_read      => out_mem_read,     
                   mem_write     => out_mem_write,    
                   mem_to_reg    => out_mem_to_reg,   
                   CPSR_write_en => out_CPSR_write_en);
end Behavioral;
