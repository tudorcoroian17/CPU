----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Control Unit
-- Version: 1.2.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CU is
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
end CU;

architecture Behavioral of CU is
begin
GEN_CONTROL_SIGN: process (cond, code, func, flags)
begin
    if cond = "0000" then
        if code = "0000"then
            if func = "0100" then -- Multiply two numbers
                jump_ctrl <= '0';
                IDU_en <= '1';
                MEMU_en <= '0';
                regWr1 <= '1';
                regWr2 <= '0';
                regWr3 <= '1';
                regDst <= '0';
                ALU_source <= '0';
                mem_read <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                CPSR_write_en <= '1';
            else -- Any other AL-type op on 2 nb
                jump_ctrl <= '0';              
                IDU_en <= '1';                 
                MEMU_en <= '0';                
                regWr1 <= '0';                 
                regWr2 <= '1';                 
                regWr3 <= '0';                 
                regDst <= '0';                 
                ALU_source <= '0';             
                mem_read <= '0';               
                mem_write <= '0';              
                mem_to_reg <= '0';             
                CPSR_write_en <= '1';          
            end if;
        elsif code = "0001" then
            if func = "0000" then -- Any shift operation
                jump_ctrl <= '0';     
                IDU_en <= '1';        
                MEMU_en <= '0';       
                regWr1 <= '0';        
                regWr2 <= '1';        
                regWr3 <= '0';        
                regDst <= '0';        
                ALU_source <= '0';    
                mem_read <= '0';      
                mem_write <= '0';     
                mem_to_reg <= '0';    
                CPSR_write_en <= '0'; 
            else -- Compare two numbers
                jump_ctrl <= '0';
                IDU_en <= '1';
                MEMU_en <= '0';
                regWr1 <= '0';
                regWr2 <= '0';
                regWr3 <= '0';
                regDst <= '0';
                ALU_source <= '0';
                mem_read <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                CPSR_write_en <= '1';
            end if;
        elsif code = "0010" then -- Load operation
                jump_ctrl <= '0';
                IDU_en <= '1';
                MEMU_en <= '1';
                regWr1 <= '0';
                regWr2 <= '1';
                regWr3 <= '0';
                regDst <= '1';
                ALU_source <= '1';
                mem_read <= '1';
                mem_write <= '0';
                mem_to_reg <= '1';
                CPSR_write_en <= '0';
        elsif code = "0011" then -- Store operation
                jump_ctrl <= '0';
                IDU_en <= '1';
                MEMU_en <= '1';
                regWr1 <= '0';
                regWr2 <= '0';
                regWr3 <= '0';
                regDst <= '0';
                ALU_source <= '1';
                mem_read <= '0';
                mem_write <= '1';
                mem_to_reg <= '0';
                CPSR_write_en <= '0';
        elsif code = "0100" then -- Jump operation
                jump_ctrl <= '1';
                IDU_en <= '1';
                MEMU_en <= '0';
                regWr1 <= '1';
                regWr2 <= '0';
                regWr3 <= '0';
                regDst <= '0';
                ALU_source <= '0';
                mem_read <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                CPSR_write_en <= '0';
        elsif code = "0101" then -- Add immediate op
                jump_ctrl <= '0';
                IDU_en <= '1';
                MEMU_en <= '0';
                regWr1 <= '0';
                regWr2 <= '1';
                regWr3 <= '0';
                regDst <= '1';
                ALU_source <= '1';
                mem_read <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                CPSR_write_en <= '1';
        end if;
    elsif cond = "1111" then
        if code = "0000" then
            if func = "0100" then -- Multiply three numbers
                jump_ctrl <= '0';
                IDU_en <= '1';
                MEMU_en <= '0';
                regWr1 <= '1';
                regWr2 <= '1';
                regWr3 <= '1';
                regDst <= '0';
                ALU_source <= '0';
                mem_read <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                CPSR_write_en <= '1';
            else -- Any other AL-type op on 3 nb
                jump_ctrl <= '0';
                IDU_en <= '1';
                MEMU_en <= '0';
                regWr1 <= '0';
                regWr2 <= '1';
                regWr3 <= '0';
                regDst <= '0';
                ALU_source <= '0';
                mem_read <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                CPSR_write_en <= '1';
            end if;
        end if;
    else
        if cond = flags then
            if code = "0000" and func = "0000" then -- Add after checking flags
                jump_ctrl <= '0';
                IDU_en <= '1';
                MEMU_en <= '0';
                regWr1 <= '0';
                regWr2 <= '1';
                regWr3 <= '0';
                regDst <= '0';
                ALU_source <= '0';
                mem_read <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                CPSR_write_en <= '1';
            elsif code = "0100" then -- Conditional jump
                jump_ctrl <= '1';
                IDU_en <= '1';
                MEMU_en <= '0';
                regWr1 <= '1';
                regWr2 <= '0';
                regWr3 <= '0';
                regDst <= '0';
                ALU_source <= '0';
                mem_read <= '0';
                mem_write <= '0';
                mem_to_reg <= '0';
                CPSR_write_en <= '0';
            end if;
        else -- Error
            jump_ctrl <= '0';
            IDU_en <= '0';
            MEMU_en <= '0';
            regWr1 <= '0';
            regWr2 <= '0';
            regWr3 <= '0';
            regDst <= '0';
            ALU_source <= '0';
            mem_read <= '0';
            mem_write <= '0';
            mem_to_reg <= '0';
            CPSR_write_en <= '0';
        end if;
    end if;
end process;
end Behavioral;
