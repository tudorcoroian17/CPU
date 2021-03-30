----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Instruction Decode TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_IDU is
end testbench_IDU;

architecture Behavioral of testbench_IDU is
component IDU is
    Port ( instruction          :  in std_logic_vector(31 downto 0);
           clk                  :  in std_logic;
           enable               :  in std_logic;
           register_write1      :  in std_logic;
           register_write2      :  in std_logic;
           register_write3      :  in std_logic;
           register_destination :  in std_logic;
           write_data1          :  in std_logic_vector(31 downto 0);
           write_data2          :  in std_logic_vector(31 downto 0);
           write_data3          :  in std_logic_vector(31 downto 0);
           link_adr             :  in std_logic_vector(31 downto 0);
           read_data1           : out std_logic_vector(31 downto 0);
           read_data2           : out std_logic_vector(31 downto 0);
           read_data3           : out std_logic_vector(31 downto 0);
           ext_imm              : out std_logic_vector(31 downto 0);
           jump_address         : out std_logic_vector(31 downto 0);
           instruction_flags    : out std_logic_vector( 3 downto 0);
           instruction_code     : out std_logic_vector( 3 downto 0);
           instruction_function : out std_logic_vector( 3 downto 0);
           instruction_shift_am : out std_logic_vector( 3 downto 0);
           instruction_shift_dir: out std_logic_vector( 1 downto 0));
end component IDU;
signal  in_clk : std_logic := '0';
signal  in_rw1 : std_logic := '0';
signal  in_rw2 : std_logic := '0';
signal  in_rw3 : std_logic := '0';
signal  in_instruction : std_logic_vector(31 downto 0);
signal  in_rgd : std_logic := '0';
signal  in_write_data1 : std_logic_vector(31 downto 0);
signal  in_write_data2 : std_logic_vector(31 downto 0);
signal  in_write_data3 : std_logic_vector(31 downto 0);
signal out_read_data1  : std_logic_vector(31 downto 0);
signal out_read_data2  : std_logic_vector(31 downto 0);
signal out_read_data3  : std_logic_vector(31 downto 0);
signal out_ext_imm     : std_logic_vector(31 downto 0);
signal out_jmp_adr     : std_logic_vector(31 downto 0);
signal out_flags       : std_logic_vector( 3 downto 0);
signal out_code        : std_logic_vector( 3 downto 0);
signal out_function    : std_logic_vector( 3 downto 0);
signal out_shift_am    : std_logic_vector( 3 downto 0);
signal out_shift_dir   : std_logic_vector( 1 downto 0);
signal  in_link_adr    : std_logic_vector(31 downto 0);
begin
GENERATE_CLOCK: in_clk <= not in_clk after 1 ps;
in_instruction <= B"0000_00001_00010_00000_00000_0011_0000",
                  B"0000_00010_00011_0000_10_1101_0000_0001" after 5 ps,
                  B"0000_00001_00010_10101010101010_0010" after 9 ps,
                  B"0000_1_00000000000001111110111_0100" after 13 ps,
                  B"1111_00011_00000_00010_00001_0110_0000" after 17 ps,
                  B"1011_00001_00010_00011_00000_0000_0000" after 21 ps;
                  
UUT: IDU port map ( instruction          =>  in_instruction,
                    clk                  =>  in_clk,
                    enable               =>  '1',
                    register_write1      =>  in_rw1,
                    register_write2      =>  in_rw2,
                    register_write3      =>  in_rw3,
                    register_destination =>  in_rgd,
                    write_data1          =>  in_write_data1,
                    write_data2          =>  in_write_data2,
                    write_data3          =>  in_write_data3,
                    link_adr             =>  in_link_adr,
                    read_data1           => out_read_data1,
                    read_data2           => out_read_data2,
                    read_data3           => out_read_data3,
                    ext_imm              => out_ext_imm,
                    jump_address         => out_jmp_adr,
                    instruction_flags    => out_flags,
                    instruction_code     => out_code,
                    instruction_function => out_function,
                    instruction_shift_am => out_shift_am,
                    instruction_shift_dir=> out_shift_dir);
end Behavioral;
