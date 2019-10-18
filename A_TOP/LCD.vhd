LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.STRUCT.moment;

ENTITY LCD IS
PORT(
        clk_lcd_1khz,clear:in std_logic;
        onoff:in std_logic;
        t1,t2:in moment;
        RW,E,RS:out std_logic;      
        data:out std_logic_vector(7 downto 0)
    ); 
END LCD;

architecture a of LCD IS

signal ti:moment;
signal ti0:moment;

BEGIN
ti<=t1;
ti0<=t2;
RW<='0';
E<=clk_lcd_1khz;
process(clk_lcd_1khz,clear)

VARIABLE CNT:integer range 0 to 32;
--VARIABLE h1:integer range 0 to 2;
VARIABLE h2:integer range 0 to 9;
VARIABLE m1:integer range 0 to 5;
VARIABLE m2:integer range 0 to 9;
VARIABLE s1:integer range 0 to 5;
VARIABLE s2:integer range 0 to 9;
--VARIABLE h01:integer range 0 to 2;
VARIABLE h02:integer range 0 to 9;
VARIABLE m01:integer range 0 to 5;
VARIABLE m02:integer range 0 to 9;
VARIABLE s01:integer range 0 to 5;
VARIABLE s02:integer range 0 to 9;



begin
if clk_lcd_1khz'event and clk_lcd_1khz='1'  then
    if clear='1' then RS<='0';data<="00000000"; 
    else
	--h1:=ti.hour/10;
	--h2:=ti.hour-h1*10;
	h2:=ti.hour;
	m1:=ti.minu/10;
	m2:=ti.minu-m1*10;
	s1:=ti.seco/10;
	s2:=ti.seco-s1*10;
	--h01:=ti0.hour/10;
	--h02:=ti0.hour-h01*10;
	h02:=ti0.hour;
	m01:=ti0.minu/10;
	m02:=ti0.minu-m01*10;
	s01:=ti0.seco/10;
	s02:=ti0.seco-s01*10;
		CNT:=CNT+1;
        if CNT=32 then     --循环扫描
            CNT:=0;
        end if;
    CASE CNT IS
when 0 =>RS<='0';data<=x"38";  --功能设定指令：8位数据接口，两行显示，5×8点阵
when 1 =>RS<='0';data<=x"0C";  --显示开关控制指令： 显示开，不显示光标，光标不闪烁
when 2 =>RS<='0';data<=x"06";  --设置模式：写入新数据后光标后移，显示不移动
when 3 =>RS<='0';data<=x"80";  --设定显示的位置在第一行开头 
when 4 =>RS<='1';data<=conv_std_logic_vector(78,8);     --N
when 5 =>RS<='1';data<=conv_std_logic_vector(79,8);     --O              :58     0-9    48-57 KG 20
when 6 =>RS<='1';data<=conv_std_logic_vector(87,8);    --W
when 7 =>RS<='1';data<=conv_std_logic_vector(20,8);    --
when 8 =>RS<='1';data<=conv_std_logic_vector(0+48,8);    --         
when 9 =>RS<='1';data<=conv_std_logic_vector(h2+48,8);    -- 
when 10 =>RS<='1';data<=conv_std_logic_vector(58,8);    --:
when 11=>RS<='1';data<=conv_std_logic_vector(m1+48,8);    --E 
when 12=>RS<='1';data<=conv_std_logic_vector(m2+48,8);    --W 
when 13=>RS<='1';data<=conv_std_logic_vector(58,8);     --:
when 14=>RS<='1';data<=conv_std_logic_vector(s1+48,8);     --Y 
when 15=>RS<='1';data<=conv_std_logic_vector(s2+48,8);     --E 
when 16=>RS<='1';data<=conv_std_logic_vector(20,8);    --A 
when 17=>RS<='1';data<=conv_std_logic_vector(20,8);    --R 
when others=> null;
     END CASE;   
     if onoff='1' then     
     CASE CNT IS
when 18 =>RS<='0';data<=x"C0";   --设定显示的位置在第二行开头
when 19 =>RS<='1';data<=conv_std_logic_vector(20,8);     --N
when 20 =>RS<='1';data<=conv_std_logic_vector(20,8);     --O              :58     0-9    48-57 KG 20
when 21 =>RS<='1';data<=conv_std_logic_vector(h02+48,8);    --W              
when 22 =>RS<='1';data<=conv_std_logic_vector(20,8);    --
when 23 =>RS<='1';data<=conv_std_logic_vector(0+48,8);    --         
when 24 =>RS<='1';data<=conv_std_logic_vector(0+48,8);    -- 
when 25 =>RS<='1';data<=conv_std_logic_vector(58,8);    --:
when 26 =>RS<='1';data<=conv_std_logic_vector(m01+48,8);    --E 
when 27 =>RS<='1';data<=conv_std_logic_vector(m02+48,8);    --W 
when 28 =>RS<='1';data<=conv_std_logic_vector(58,8);     --:
when 29 =>RS<='1';data<=conv_std_logic_vector(s01+48,8);     --Y 
when 30 =>RS<='1';data<=conv_std_logic_vector(s02+48,8);     --E 
when 31 =>RS<='1';data<=conv_std_logic_vector(20,8);    --A 
when 32 =>RS<='1';data<=conv_std_logic_vector(20,8);    --R 
when others=> null;
END CASE;
	end if;
END IF;
END IF;


end process;
END A;