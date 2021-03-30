----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Instruction Fetch Unit
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IDU is
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
end IDU;

architecture Behavioral of IDU is
component RegisterFile is
    port ( clk           :  in std_logic;
           enable        :  in std_logic;
           registerWrite1:  in std_logic; 
           registerWrite2:  in std_logic; 
           registerWrite3:  in std_logic; 
           readAdr1      :  in std_logic_vector ( 4 downto 0);
           readAdr2      :  in std_logic_vector ( 4 downto 0);
           readAdr3      :  in std_logic_vector ( 4 downto 0);
           writeAdr1     :  in std_logic_vector ( 4 downto 0);
           writeAdr2     :  in std_logic_vector ( 4 downto 0);
           writeAdr3     :  in std_logic_vector ( 4 downto 0);
           writeData1    :  in std_logic_vector (31 downto 0);
           writeData2    :  in std_logic_vector (31 downto 0);
           writeData3    :  in std_logic_vector (31 downto 0);
           readData1     : out std_logic_vector (31 downto 0);
           readData2     : out std_logic_vector (31 downto 0);
           readData3     : out std_logic_vector (31 downto 0));
end component RegisterFile;
signal rs1 : std_logic_vector( 4 downto 0) := (others => '0');
signal rs2 : std_logic_vector( 4 downto 0) := (others => '0');
signal rt  : std_logic_vector( 4 downto 0) := (others => '0');
signal rd  : std_logic_vector( 4 downto 0) := (others => '0');
signal write_address1 : std_logic_vector( 4 downto 0) := (others => '0');
signal write_data_1    : std_logic_vector(31 downto 0) := (others => '0');
signal write_address2 : std_logic_vector( 4 downto 0) := (others => '0');
begin
CHOOSE_DEST_N_DATA: process(instruction, write_data1)
begin
    if instruction(27) = '1' and instruction( 3 downto 0) = "0100" then
        write_address1 <= "00000";
        write_data_1 <= link_adr;
    else
        write_address1 <= "00001";
        write_data_1 <= write_data1;
    end if;
end process;
CHOOSE_DEST2: process(register_destination)
begin
    if register_destination = '0' then write_address2 <= instruction(17 downto 13);
    else write_address2 <= instruction(22 downto 18);
    end if;
end process;
GET_FUNCTION : instruction_function <= instruction( 7 downto  4);
GET_CODE     : instruction_code     <= instruction( 3 downto  0);
GET_SHIFT_AM : instruction_shift_am <= instruction(11 downto  8);
GET_FLAGS    : instruction_flags    <= instruction(31 downto 28);
GET_SHIFT_DIR: instruction_shift_dir<= instruction(13 downto 12);
RF: RegisterFile port map (clk => clk, 
                           enable => enable,
                           registerWrite1 => register_write1,
                           registerWrite2 => register_write2, 
                           registerWrite3 => register_write3,  
                           readAdr1   => instruction(27 downto 23), --rs1
                           readAdr2   => instruction(22 downto 18), --rt
                           readAdr3   => instruction(12 downto  8), --rs2
                           writeAdr1  => write_address1,
                           writeAdr2  => write_address2,
                           writeAdr3  => "00010",
                           writeData1 => write_data_1,
                           writeData2 => write_data2,
                           writeData3 => write_data3,
                           readData1  => read_data1,
                           readData2  => read_data2,
                           readData3  => read_data3);
GET_IMM : ext_imm <= "000000000000000000" & instruction(17 downto 4);
GET_JMPA: jump_address <= "000000000" & instruction(26 downto 4);
end Behavioral;
