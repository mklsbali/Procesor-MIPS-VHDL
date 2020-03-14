----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2019 03:17:06 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC is
    Port ( Instr : in STD_LOGIC_VECTOR (2 downto 0);
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           AluSrc : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC;
           AluOp : out STD_LOGIC_VECTOR (2 downto 0);
           MemWrite : out STD_LOGIC;
           MemToReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end UC;

architecture Behavioral of UC is


begin
process(Instr)
begin
    case(Instr) is
    when "000" =>RegDst<='1';ExtOp<='0';AluSrc<='0';Branch<='0';Jump<='0';AluOp<="000";MemWrite<='0';MemToReg<='0';RegWrite<='1';--reg
    when "001" =>RegDst<='1';ExtOp<='1';AluSrc<='1';Branch<='0';Jump<='0';AluOp<="000";MemWrite<='0';MemToReg<='0';RegWrite<='1';--
    when "010" =>RegDst<='1';ExtOp<='1';AluSrc<='1';Branch<='0';Jump<='0';AluOp<="000";MemWrite<='0';MemToReg<='1';RegWrite<='1';--
    when "011" =>RegDst<='1';ExtOp<='1';AluSrc<='1';Branch<='0';Jump<='0';AluOp<="000";MemWrite<='1';MemToReg<='0';RegWrite<='0';--
    when "100" =>RegDst<='0';ExtOp<='1';AluSrc<='1';Branch<='1';Jump<='0';AluOp<="000";MemWrite<='0';MemToReg<='0';RegWrite<='0';--
    when "101" =>RegDst<='0';ExtOp<='1';AluSrc<='1';Branch<='1';Jump<='0';AluOp<="000";MemWrite<='0';MemToReg<='0';RegWrite<='0';--
    when "110" =>RegDst<='1';ExtOp<='1';AluSrc<='1';Branch<='0';Jump<='0';AluOp<="000";MemWrite<='0';MemToReg<='0';RegWrite<='0';--     
    when others =>RegDst<='0';ExtOp<='0';AluSrc<='0';Branch<='0';Jump<='1';AluOp<="000";MemWrite<='0';MemToReg<='0';RegWrite<='0';--jump 
    end case;
end process;
end Behavioral;
