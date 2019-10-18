LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
PACKAGE STRUCT is
TYPE key IS(one,two,three,four,five,six,seven,eight,nine,zero,enter,del,choose,add,modify,recording,nothing);    --按键对应名称
TYPE all_state IS (MENU,CHOOSE_USER,ADD_CIPHER,CHANGE_CIPHER,INPUT_CIPHER,SHOW_RECORD,ADMIN);                    --状态机
TYPE moment is RECORD                                                                                            --记录时间
  hour: INTEGER RANGE 0 TO 9;                                 --考虑到资源和验收时长 没有设置24小时
  minu: INTEGER RANGE 0 TO 59;
  seco: INTEGER RANGE 0 TO 59;
END RECORD;
TYPE cipher_six is ARRAY(1 TO 6)OF INTEGER RANGE 0 TO 9;                                                         --最多六位密码
TYPE smg_eight is ARRAY(1 TO 8)OF INTEGER RANGE 0 TO 12;                                                         --八个数码管的显示
TYPE four_cipher_six is array (1 TO 4) of cipher_six;                                                            --4个用户的6位密码
TYPE four_cipher_len is array (1 TO 4) of INTEGER RANGE 0 TO 6;                                                  --4个用户的密码长度
TYPE three_moment is ARRAY(1 TO 5) OF moment;                                                                    --5个时间记录
FUNCTION return_keyvalue(k:std_logic_vector(4 downto 0)) RETURN key;                                             --翻译按键到按键名称
END STRUCT;

PACKAGE BODY STRUCT is
FUNCTION return_keyvalue(k:std_logic_vector(4 downto 0)) RETURN key IS                                   --翻译按键到按键名称
BEGIN
	CASE k IS
	WHEN"00000" => RETURN one;
	WHEN"00001" => RETURN two;
	WHEN"00010" => RETURN three;
	WHEN"00011" => RETURN choose;
	WHEN"00100" => RETURN four;
	WHEN"00101" => RETURN five;
	WHEN"00110" => RETURN six;
	WHEN"00111" => RETURN add;
	WHEN"01000" => RETURN seven;
	WHEN"01001" => RETURN eight;
	WHEN"01010" => RETURN nine;
	WHEN"01011" => RETURN modify;
	WHEN"01100" => RETURN enter;
	WHEN"01101" => RETURN zero;
	WHEN"01110" => RETURN del;
	WHEN"01111" => RETURN recording;
	WHEN OTHERS => RETURN nothing;
	END CASE;
END return_keyvalue;
END ;