LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
PACKAGE STRUCT is
TYPE key IS(one,two,three,four,five,six,seven,eight,nine,zero,enter,del,choose,add,modify,recording,nothing);    --������Ӧ����
TYPE all_state IS (MENU,CHOOSE_USER,ADD_CIPHER,CHANGE_CIPHER,INPUT_CIPHER,SHOW_RECORD);                  --״̬��
TYPE moment is RECORD                                                                                    --��¼ʱ��
  hour: INTEGER RANGE 0 TO 1;
  minu: INTEGER RANGE 0 TO 59;
  seco: INTEGER RANGE 0 TO 59;
END RECORD;
TYPE cipher_six is ARRAY(1 TO 6)OF INTEGER RANGE 0 TO 9;                                                              --�����λ����
TYPE smg_eight is ARRAY(1 TO 8)OF INTEGER RANGE 0 TO 12;                                                        --�˸�����ܵ���ʾ
TYPE four_cipher_six is array (1 TO 4) of cipher_six;                                                    --10���û���6λ����
TYPE four_cipher_len is array (1 TO 4) of INTEGER RANGE 0 TO 6;                                                       --10���û���6λ����
TYPE three_moment is ARRAY(1 TO 3) OF moment;                                                             --10��ʱ���¼
FUNCTION return_keyvalue(k:std_logic_vector(4 downto 0)) RETURN key;                                 --���밴������������
END STRUCT;

PACKAGE BODY STRUCT is
FUNCTION return_keyvalue(k:std_logic_vector(4 downto 0)) RETURN key IS                                   --���밴������������
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