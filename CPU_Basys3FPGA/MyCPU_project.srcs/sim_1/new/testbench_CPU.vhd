----------------------------------------------------------------------------------
-- Author: Tudor Coroian
-- Group: 30433
-- Module Name: Central Processing Unit TESTBENCH
-- Version: 1.0.0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_CPU is
end testbench_CPU;

architecture Behavioral of testbench_CPU is
component CPU is
    Port( clk : in std_logic;
          resh : out std_logic_vector(31 downto 0);
          resm : out std_logic_vector(31 downto 0);
          resl : out std_logic_vector(31 downto 0);
          RD1 : out std_logic_vector(31 downto 0);
          RD2 : out std_logic_vector(31 downto 0);
          RD3 : out std_logic_vector(31 downto 0);
          WB : out std_logic_vector(31 downto 0));
end component CPU;
signal  in_clk  : std_logic := '0';
signal out_resl : std_logic_vector(31 downto 0);
signal out_resm : std_logic_vector(31 downto 0);
signal out_resh : std_logic_vector(31 downto 0);
signal out_RD1 : std_logic_vector(31 downto 0);
signal out_RD2 : std_logic_vector(31 downto 0);
signal out_RD3 : std_logic_vector(31 downto 0);
signal out_WB  : std_logic_vector(31 downto 0); 
begin
GEN_CLOCK: in_clk <= not in_clk after 100 ps;
UUT: CPU port map ( clk  =>  in_clk,
                    resh => out_resh,
                    resm => out_resm,
                    resl => out_resl,
                    RD1 => out_RD1,
                    RD2 => out_RD2,
                    RD3 => out_RD3,
                    WB => out_WB);
end Behavioral;
