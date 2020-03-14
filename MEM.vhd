----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2019 03:08:18 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
    Port ( clk : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           Adress : in STD_LOGIC_VECTOR (7 downto 0);
           WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           ReadData : out STD_LOGIC_VECTOR (15 downto 0));
end MEM;

architecture Behavioral of MEM is
type mem_type is array(0 to 7) of std_logic_vector(15 downto 0);
signal memorie:mem_type:=(
"0000000000000001",
"0000000000001011",
others=>"0000000000000000");
begin
ReadData<=memorie(conv_integer(Adress));
process (clk)
begin
    if rising_edge(clk)then
        if (MemWrite='1') then
            memorie(conv_integer(Adress))<=WriteData;
        end if;
    end if;
end process;


end Behavioral;
