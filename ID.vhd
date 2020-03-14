----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2019 02:32:06 PM
-- Design Name: 
-- Module Name: ID - Behavioral
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

entity ID is
    Port ( clk: in std_logic;
           RegWrite : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           sa : out STD_LOGIC);
           
end ID;
architecture Behavioral of ID is
component Registry_block is
    Port ( clk : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (2 downto 0);
           RA2 : in STD_LOGIC_VECTOR (2 downto 0);
           WA : in STD_LOGIC_VECTOR (2 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           REG_WR:in std_logic);
end component;
signal wradr: std_logic_vector(2 downto 0):="000";

begin

wradr<=Instr(12 downto 10) when RegDst='0' else Instr(9 downto 7);
func<=Instr(2 downto 0);
sa<=instr(3);
A1:Registry_block port map(clk,Instr(15 downto 13),Instr(12 downto 10),wradr,WD,RD1,RD2,RegWrite);
process (ExtOp)
begin
if (ExtOp='0') then
--fara semn
    Ext_imm<="000000000" & Instr(6 downto 0);
else
--cu semn
    if (Instr(6)='1') then
        Ext_imm<="111111111" & Instr(6 downto 0);
    else 
        Ext_imm<="000000000" & Instr(6 downto 0);
    end if;
end if;
end process;


end Behavioral;
