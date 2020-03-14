----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2019 04:48:32 PM
-- Design Name: 
-- Module Name: mpg - mpg_ar
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



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--entitatea lui ppg
entity mpg is
port(clk:in std_logic;
input:in std_logic;
enable:out std_logic);
end mpg;
--arhitectura mpg
architecture mpg_ar of mpg is
--semnale declarate
signal count_int:std_logic_vector(31 downto 0):=x"00000000";
signal Q1:std_logic;
signal Q2:std_logic;
signal Q3:std_logic;

begin

--numaratorul
process (clk)
begin
    if clk'event and clk='1' then 
        count_int<=count_int+1;
    end if;
end process;
--poarta si de 15 intrari
process (clk)
begin
    if clk'event and clk='1' then
        if count_int(15 downto 0)="111111111111111" then
            Q1<=input;
        end if;
    end if;
end process;
--iesirile registrelor
process (clk)
begin
    if clk'event and clk='1' then
        Q2 <= Q1;
        Q3 <= Q2;
    end if;
end process;
--iesirea
enable<=Q2 and (not Q3);
end mpg_ar;