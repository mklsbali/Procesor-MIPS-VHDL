----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2019 03:12:48 PM
-- Design Name: 
-- Module Name: Registry_block - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registry_block is
    Port ( clk : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (2 downto 0);
           RA2 : in STD_LOGIC_VECTOR (2 downto 0);
           WA : in STD_LOGIC_VECTOR (2 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           REG_WR:in std_logic);
end Registry_block;

architecture Behavioral of Registry_block is
type matrix is array(0 to 7) of std_logic_vector(15 downto 0);
signal memory_block: matrix:=(
"0000000000000000",
"0000000100000000",
"0000000000000000",
"0000001101000001",
others=>"0000000000000000");

begin

process (clk)
begin
 if rising_edge(clk) then
  if REG_WR='1' then
    memory_block(conv_integer(WA))<=WD;
  end if;
 end if;
 end process;
 RD1<=memory_block(conv_integer(RA1));
 RD2<=memory_block(conv_integer(RA2));

end Behavioral;
