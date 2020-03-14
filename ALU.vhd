----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2019 02:20:54 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( RD1 : in STD_LOGIC_VECTOR (15 downto 0);
           ALUSrc : in STD_LOGIC;
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           func : in STD_LOGIC_VECTOR (2 downto 0);
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0);
           Zero : out STD_LOGIC;
           ALURes : out STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is
signal ALUCtrl: std_logic_vector(2 downto 0):=(others=>'0');
signal mux_out: std_logic_vector(15 downto 0):=(others=>'0');
signal res:std_logic_vector(15 downto 0):=(others=>'0');
begin
mux_out<=RD2 when ALUSrc='0'else Ext_Imm;

process(ALUOp, func)
begin
case ALUop is
    when "000" => ALUCtrl<=func;
    when "001" => ALUCtrl<="000"; --addi
    when "010" => ALUCtrl<="001"; --subi
    when "011" => ALUCtrl<="101"; --ori
    when "100" => ALUCtrl<="111"; --slti
    when others => null; 
end case;
end process;
process(RD1,mux_out,sa, func, ALUOp)
begin

case (ALUCtrl) is
    when "000" => res<=RD1+mux_out;
    when "001" => res<=RD1-mux_out;
    when "010" => 
        if sa='1' then res<=RD1(14 downto 0) & "0"; end if;
    when "011" =>
        if sa='1' then res<="0" & RD1(15 downto 1);end if;
    when "100" => res<=RD1 and mux_out;
    when "101" => res<=RD1 or mux_out;
    when "110" => res<=RD1 xor mux_out;
    when others => if RD1<ext_imm then res<=x"1111"; else res<= x"0000"; end if;
end case;
end process;
ALURes<=res;
zero<='1' when res="0000000000000000" else '0';
end Behavioral;
