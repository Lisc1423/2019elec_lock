library ieee;
use ieee.std_logic_1164.all;

entity KEY is 
	port(
	inclk:in std_logic;                               --1M
	inrow:in std_logic_vector(3 downto 0);--3dao0,从上到下
	incol:out std_logic_vector(3 downto 0);--3dao0,从左向右
	outshumaguan:out std_logic_vector(4 downto 0)
	);
end ;

architecture a of KEY is 
signal cnt:integer range 0 to 4;
signal coltmp:std_logic_vector(3 downto 0);
signal keykey:std_logic_vector(4 downto 0);

begin 
	p1:process(inclk)
	begin
		if inclk'event and inclk='1' then
			if cnt=4 then
				cnt<=0;
			else cnt<=cnt+1;
			end if;
		end if;
	end process p1;
	p2:process(cnt)
	begin
		case cnt is
			when 0=> coltmp<="0111";--从左向右第一列
			when 1=> coltmp<="1011";--第二列
			when 2=> coltmp<="1101";--第三列
			when 3=> coltmp<="1110";--第四列
			when 4=> coltmp<="0000";--判断是否有按键按下
		end case;
		incol<=coltmp;--给列写值，判断行信号
	end process p2;
	p3:process(coltmp)
	begin
		if inclk'event and inclk='1' then 
			case coltmp is
				when "1110" => --从左向右第一列
					case inrow is
						when "0111" => keykey<="00000";--从上到下第一行
						when "1011" => keykey<="00100";--从上到下第二行
						when "1101" => keykey<="01000";--从上到下第三行
						when "1110" => keykey<="01100";--从上到下第四行
						when others => null;--keykey<="11111";
					end case;
				when "1101" => --从左向右第二列		
					case inrow is
						when "0111" => keykey<="00001";--从上到下第一行
						when "1011" => keykey<="00101";--从上到下第二行
						when "1101" => keykey<="01001";--从上到下第三行
						when "1110" => keykey<="01101";--从上到下第四行
						when others => null;--keykey<="11111";
					end case;
				when "1011" => --从左向右第三列
					case inrow is
						when "0111" => keykey<="00010";--从上到下第一行
						when "1011" => keykey<="00110";--从上到下第二行
						when "1101" => keykey<="01010";--从上到下第三行
						when "1110" => keykey<="01110";--从上到下第四行
						when others => null;--keykey<="11111";
					end case;
				when "0111" => --从左向右第四列
					case inrow is
						when "0111" => keykey<="00011";--从上到下第一行
						when "1011" => keykey<="00111";--从上到下第二行
						when "1101" => keykey<="01011";--从上到下第三行
						when "1110" => keykey<="01111";--从上到下第四行
						when others => null;--keykey<="11111";
					end case;
				when "0000" => --从左向右第四列
					if inrow ="1111" then
						keykey<="11111";
					end if;
				when others => null;--keykey<="11111";
			end case;
		end if;			
	end process p3;	
	
	p4:process(inclk,keykey)
	variable c:integer range 0 to 1 :=0;
	variable b:integer range 0 to 1000 :=0;

	variable lastkey:std_logic_vector(4 downto 0):="11111";

	begin
		if inclk'event and inclk='1' then
			if c=0 then
				c:=1;
				outshumaguan<="11111";
			end if;

			if lastkey /=keykey  then
				outshumaguan <=keykey;
				c:=0;
			else 
				outshumaguan<="11111";
			end if;
			lastkey:=keykey;
		end if;
	end process p4;

end;