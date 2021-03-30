----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Central Processing Unit
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU is
    Port( clk : in std_logic;
          resh : out std_logic_vector(31 downto 0);
          resm : out std_logic_vector(31 downto 0);
          resl : out std_logic_vector(31 downto 0);
          RD1 : out std_logic_vector(31 downto 0);
          RD2 : out std_logic_vector(31 downto 0);
          RD3 : out std_logic_vector(31 downto 0);
          WB : out std_logic_vector(31 downto 0)
          );
end CPU;

architecture Behavioral of CPU is
component IFU is
    Port ( clk          :  in std_logic;
           reset        :  in std_logic;
           enable       :  in std_logic;
           jump_address :  in std_logic_vector(31 downto 0);
           jump_ctrl    :  in std_logic;
           instruction  : out std_logic_vector(31 downto 0);
           next_address : out std_logic_vector(31 downto 0));
end component IFU;
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
component MEMU is
    port ( mem_read   :  in std_logic;
           mem_write  :  in std_logic;
           mem_to_reg :  in std_logic;
           clk        :  in std_logic;
           enable     :  in std_logic;
           res_ALU    :  in std_logic_vector(31 downto 0);
           regFile_rt :  in std_logic_vector(31 downto 0);
           write_back : out std_logic_vector(31 downto 0));
end component MEMU;
component CPSR is
    Port ( clk      :  in std_logic;
           write_en :  in std_logic;
           data_in  :  in std_logic_vector( 3 downto 0);
           data_out : out std_logic_vector( 3 downto 0));
end component CPSR;
signal out_instruction  : std_logic_vector(31 downto 0);
signal out_next_address : std_logic_vector(31 downto 0);
signal out_read_data1            : std_logic_vector(31 downto 0);
signal out_read_data2            : std_logic_vector(31 downto 0);
signal out_read_data3            : std_logic_vector(31 downto 0);
signal out_ext_imm               : std_logic_vector(31 downto 0);
signal out_jump_address          : std_logic_vector(31 downto 0);
signal out_instruction_flags     : std_logic_vector( 3 downto 0);
signal out_instruction_code      : std_logic_vector( 3 downto 0);
signal out_instruction_function  : std_logic_vector( 3 downto 0);
signal out_instruction_shift_am  : std_logic_vector( 3 downto 0);
signal out_instruction_shift_dir : std_logic_vector( 1 downto 0);
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
signal out_out_resh  : std_logic_vector(31 downto 0);   
signal out_out_resm  : std_logic_vector(31 downto 0);   
signal out_out_resl  : std_logic_vector(31 downto 0);   
signal out_out_flags : std_logic_vector( 3 downto 0); 
signal out_write_back : std_logic_vector(31 downto 0); 
signal out_data_out : std_logic_vector( 3 downto 0); 
begin
resh <= out_out_resh;
resm <= out_out_resm;
resl <= out_out_resl;
RD1 <= out_read_data1;
RD2 <= out_read_data2;
RD3 <= out_read_data3;
WB <= out_write_back;
Fetchy : IFU port map ( clk          => clk,
                        reset        => '0',
                        enable       => '1',
                        jump_address => out_jump_address,
                        jump_ctrl    => out_jump_ctrl,
                        instruction  => out_instruction,
                        next_address => out_next_address);
Decody : IDU port map ( instruction           => out_instruction,
                        clk                   => clk,
                        enable                => out_IDU_en,
                        register_write1       => out_regWr1,
                        register_write2       => out_regWr2,
                        register_write3       => out_regWr3,
                        register_destination  => out_regDst,
                        write_data1           => out_out_resh,
                        write_data2           => out_write_back,
                        write_data3           => out_out_resl,
                        link_adr              => out_next_address,
                        read_data1            => out_read_data1,
                        read_data2            => out_read_data2,
                        read_data3            => out_read_data3,
                        ext_imm               => out_ext_imm,
                        jump_address          => out_jump_address,
                        instruction_flags     => out_instruction_flags,
                        instruction_code      => out_instruction_code,
                        instruction_function  => out_instruction_function,
                        instruction_shift_am  => out_instruction_shift_am,
                        instruction_shift_dir => out_instruction_shift_dir);
Controly : CU port map ( flags         => out_data_out,
                         func          => out_instruction_function,
                         cond          => out_instruction_flags,
                         code          => out_instruction_code,
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
Executy : EXU port map ( A            => out_read_data1,
                         B            => out_read_data2,
                         C            => out_read_data3,
                         in_shift_am  => out_instruction_shift_am,
                         in_shift_dir => out_instruction_shift_dir,
                         in_flags     => out_instruction_flags,
                         in_op_code   => out_instruction_code,
                         in_func_code => out_instruction_function,
                         immediate    => out_ext_imm,
                         out_resh     => out_out_resh,
                         out_resm     => out_out_resm,
                         out_resl     => out_out_resl,
                         out_flags    => out_out_flags,
                         ALUSrc       => out_ALU_source);
Memory : MEMU port map ( mem_read   => out_mem_read,
                         mem_write  => out_mem_write,
                         mem_to_reg => out_mem_to_reg,
                         clk        => clk,
                         enable     => out_MEMU_en,
                         res_ALU    => out_out_resm,
                         regFile_rt => out_read_data2,
                         write_back => out_write_back);
end Behavioral;
