----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2019 02:43:49 PM
-- Design Name: 
-- Module Name: afisor_7seg - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity afisor_7seg is
    Port ( input : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           ann : out STD_LOGIC_VECTOR (3 downto 0);
           catt : out STD_LOGIC_VECTOR (6 downto 0));
end afisor_7seg;

architecture Behavioral of afisor_7seg is
signal digit1:std_logic_vector(3 downto 0):="0000";
signal digit2:std_logic_vector(3 downto 0):="0000";
signal digit3:std_logic_vector(3 downto 0):="0000";
signal digit4:std_logic_vector(3 downto 0):="0000";
signal mux1_out:std_logic_vector(3 downto 0):="0000";
signal counter:std_logic_vector(15 downto 0):=(others=>'0');
signal s1:std_logic_vector(1 downto 0):="00";
signal s2:std_logic_vector(1 downto 0):="00";

begin

process(clk)
begin
if clk'event and clk='1' then
 counter<=counter+1;
 if counter="1111111111111111" then counter<=(others=>'0'); end if;
end if;
end process;

process(S1, digit1, digit2, digit3, digit4)
begin
 case S1 is
 when "00" => mux1_out <= digit1;
 when "01" => mux1_out <= digit2;
 when "10" => mux1_out <= digit3;
 when others => mux1_out <= digit4;
 end case;
end process; 

process(S2)
begin
 case S2 is
 when "00" => ann <= "1110";
 when "01" => ann <= "1101";
 when "10" => ann <= "1011";
 when others => ann <="0111";
 end case;
end process;
process (mux1_out)
begin
case mux1_out is
        when "0000"=> catt <="1000000";  -- '0'
        when "0001"=> catt <="1111001";  -- '1'
        when "0010"=> catt <="0100100";  -- '2'
        when "0011"=> catt <="0110000";  -- '3'
        when "0100"=> catt <="0011001";  -- '4' 
        when "0101"=> catt <="0010010";  -- '5'
        when "0110"=> catt <="0000010";  -- '6'
        when "0111"=> catt <="1111000";  -- '7'
        when "1000"=> catt <="0000000";  -- '8'
        when "1001"=> catt <="0010000";  -- '9'
        when "1010"=> catt <="0001000";  -- 'A'
        when "1011"=> catt <="0000011";  -- 'b'
        when "1100"=> catt <="1000110";  -- 'C'
        when "1101"=> catt <="0100001";  -- 'd'
        when "1110"=> catt <="0000110";  -- 'E'
        when "1111"=> catt <="0001110";  -- 'F'
        when others =>catt <="1000000";
  end case;
end process; 
digit1<=input(3 downto 0);
digit2<=input(7 downto 4);
digit3<=input(11 downto 8);
digit4<=input(15 downto 12);
s1<=counter(15 downto 14);
s2<=counter(15 downto 14);
end Behavioral;
