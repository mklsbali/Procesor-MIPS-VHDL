----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2019 02:21:13 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is
signal enable_out: std_logic;
signal enable_out2: std_logic;
signal counter:std_logic_vector(15 downto 0):="0000000000000000";
signal SSD_input:std_logic_vector(15 downto 0):=(others=>'0');
signal INSTR:std_logic_vector(15 downto 0):=(others=>'0');
signal PC_1:std_logic_vector(15 downto 0):=(others=>'0');
--signal rd1:std_logic_vector(15 downto 0):="0000000000000000";
--signal rd2:std_logic_vector(15 downto 0):="0000000000000000";
--signal sum:std_logic_vector(15 downto 0):="0000000000000000";
--signal do_sig:std_logic_vector(15 downto 0):="0000000000000000";
--signal di_sig:std_logic_vector(15 downto 0):="0000000000000000";
--type vector_array is array(0 to 255) of std_logic_vector(15 downto 0);
--signal rom: vector_array:=(
--"0000100110010000",--add 0990
--"0000110010100001",--sub 06A1
--"0000000101001010",--sll 014A
--"0000001101111011",--srl 047B
--"0000111010010100",--and 0E94
--"0001001000110101",--or  1235
--"0001111101010110",--xor 1F56
--"0000101100010111",--sllv 0B17

--x"150F", --addi
--x"5607", --lw
--x"7088", --sw
--x"1614", --beq
--x"AF09", --ori
--x"BD01", --slti

--x"E000", --jump
--others => "0000000000000000" );
--signal DO:std_logic_vector(15 downto 0):=(others=>'0');




component mpg 
    port(input:in std_logic;
    clk:in std_logic;
    enable:out std_logic);
end component;
component afisor_7seg 
    Port ( input : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           ann : out STD_LOGIC_VECTOR (3 downto 0);
           catt : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component Registry_block 
    Port ( clk : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (3 downto 0);
           RA2 : in STD_LOGIC_VECTOR (3 downto 0);
           WA : in STD_LOGIC_VECTOR (3 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           REG_WR:in std_logic);
end component;
component RAM is
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (7 downto 0);
           di : in STD_LOGIC_VECTOR (15 downto 0);
           do : out STD_LOGIC_VECTOR (15 downto 0));
end component;


signal Badr:std_logic_vector(15 downto 0):="0000000000000001";
signal Jadr:std_logic_vector(15 downto 0):="0000000000001111";
component UC  
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
end component;
signal rg_dst: std_logic:='0';
signal ext_op:std_logic:='0';
signal alusrc: std_logic:='0';
signal branch: std_logic:='0';
signal jump: std_logic:='0';
signal aluop: std_logic_vector(2 downto 0):="000";
signal memwrite: std_logic:='0';
signal memtoreg: std_logic:='0';
signal regwrite: std_logic:='0';
component InstructionFatch 
    Port ( clk : in STD_LOGIC;
           EN : in STD_LOGIC;
           RST : in STD_LOGIC;
           BR_select : in STD_LOGIC;
           BR_Adr:in STD_LOGIC_VECTOR (15 downto 0);
           J_adr:in STD_LOGIC_VECTOR (15 downto 0);
           J_Select : in STD_LOGIC;
           PC_1 : out STD_LOGIC_VECTOR (15 downto 0);
           Instr : out STD_LOGIC_VECTOR (15 downto 0));
end component;
component ID 
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
           
end component;
signal reg_wr:std_logic;
signal rd1:std_logic_vector(15 downto 0):=(others=>'0');
signal rd2:std_logic_vector(15 downto 0):=(others=>'0');
signal sum:std_logic_vector(15 downto 0):=(others=>'0');
signal extimm:std_logic_vector(15 downto 0):=(others=>'0');
signal saa:std_logic:='0';
signal func:std_logic_vector(2 downto 0):="000";
component ALU 
    Port ( RD1 : in STD_LOGIC_VECTOR (15 downto 0);
           ALUSrc : in STD_LOGIC;
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           func : in STD_LOGIC_VECTOR (2 downto 0);
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0);
           Zero : out STD_LOGIC;
           ALURes : out STD_LOGIC_VECTOR (15 downto 0));
end component;
signal zero:std_logic:='0';
signal alu_res:std_logic_vector(15 downto 0):="0000000000000000";
signal mem_data:std_logic_vector(15 downto 0):="0000000000000000";
component MEM 
    Port ( clk : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           Adress : in STD_LOGIC_VECTOR (7 downto 0);
           WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           ReadData : out STD_LOGIC_VECTOR (15 downto 0));
end component;
begin
reg_wr<=regwrite and btn(0);
sum<=rd1+rd2;
led(5 downto 3)<=func;
--DO<=rom(conv_integer(counter(7 downto 0)));
A1:mpg port map(btn(0),clk,enable_out);
A2:mpg port map(btn(1),clk,enable_out2);
A3:UC port map(instr(15 downto 13),rg_dst,ext_op,alusrc,branch,jump,aluop,memwrite,memtoreg,regwrite);
I:InstructionFatch port map(clk,btn(0),btn(1),branch,"0000000000000110","0000000011000000",jump,pc_1,instr);
I2:ID port map(clk,reg_wr,instr,rg_dst,ext_op,rd1,rd2,sum,extimm,func,saa);
c:ALU port map(rd1,alusrc,rd2,extimm,saa,func,aluop,zero,alu_res);
d:MEM port map(clk,memwrite,alu_res(7 downto 0),rd2,mem_data);
A4:afisor_7seg port map(ssd_input,clk,an,cat);
--process(sw(7),Instr,pc_1)
--begin
--if (sw(7)='0') then
  --  ssd_input<=Instr;
--else
  --  ssd_input<=pc_1;
--end if;
--end process;
process(sum,rd2,rd1,pc_1,instr,sw(7 downto 5))
begin
case sw(2 downto 0) is
    when "000" => ssd_input<=instr;
    when "001" => ssd_input<=pc_1;
    when "010" => ssd_input<=rd1;
    when "011" =>ssd_input<=rd2;
    when "100" => ssd_input<=extimm;
    when "101"=>ssd_input<=alu_res;
    when "110"=>ssd_input<=mem_data;
    when others =>ssd_input<=sum;
end case;
end process;

--A3:Registry_block port map(clk,counter(3 downto 0),counter(3 downto 0),counter(3 downto 0),sum,rd1,rd2,btn(1));
--sum<=rd1+rd2;
--A4:afisor_7seg port map(sum,clk,an,cat);
--A5:RAM port map(clk,sw(1),'1',counter(7 downto 0),di_sig,do_sig);
--di_sig(15 downto 0)<=do_sig(13 downto 0)&"00";
--A4:afisor_7seg port map(DO,clk,an,cat);
process(clk, enable_out)
begin
 if clk'event and clk='1' then
  if enable_out='1' then
   if sw(0)='1' then
    counter<=counter+1;
   else 
    counter<=counter-1; 
   end if;
  end if;
 end if;   
end process;

led(15 downto 6)<=counter(15 downto 6);
--an<=btn(3 downto 0);
--cat<=(others=>'0');



end Behavioral;

 