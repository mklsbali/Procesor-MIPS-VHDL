----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2019 02:19:07 PM
-- Design Name: 
-- Module Name: InstructionFatch - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IeEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionFatch is
    Port ( clk : in STD_LOGIC;
           EN : in STD_LOGIC;
           RST : in STD_LOGIC;
           BR_select : in STD_LOGIC;
           BR_Adr:in STD_LOGIC_VECTOR (15 downto 0);
           J_adr:in STD_LOGIC_VECTOR (15 downto 0);
           J_Select : in STD_LOGIC;
           PC_1 : out STD_LOGIC_VECTOR (15 downto 0);
           Instr : out STD_LOGIC_VECTOR (15 downto 0));
end InstructionFatch;

architecture Behavioral of InstructionFatch is
signal D:std_logic_vector(15 downto 0):=(others=>'0');
signal mux1_out:std_logic_vector(15 downto 0):=(others=>'0');
signal pc:std_logic_vector(15 downto 0):=(others=>'0');
signal sum_op:std_logic_vector(15 downto 0):=(others=>'0');
type vector_array is array(0 to 255) of std_logic_vector(15 downto 0);
signal rom: vector_array:=(
"0000100110010000",--add 0990
"0000110010100001",--sub 06A1
"0000000101001010",--sll 014A
"0000001101111011",--srl 047B
"0000111010010100",--and 0E94
"0001001000110101",--or  1235
"0001111101010110",--xor 1F56
"0000101100010111",--sllv 0B17

x"150F", --addi
x"5607", --lw
x"7088", --sw
x"1614", --beq
x"AF09", --ori
x"BD01", --slti

x"E000", --jump
others => "0000000000000000" );

begin
process(clk,RST,EN)
begin
if RST='1' then
    D<=(others=>'0');
else if  (clk'event and clk='1') then
    if (EN='1') then     
        D<=pc;
    end if;
end if;
end if;
end process;

mux1_out<=sum_op when Br_select='0' else Br_adr;

pc<=mux1_out when J_select='0' else J_adr;

Instr<=rom(conv_integer(D(7 downto 0)));

pc_1<=D+1;


end Behavioral;
