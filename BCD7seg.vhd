library ieee;
use ieee.std_logic_1164.all;

Entity BCD7Seg is
	Port(ent: in std_logic_vector(3 downTo 0);
			en: in std_logic;
			sal: out std_logic_vector(6 downTo 0));
end BCD7Seg;

Architecture sol of BCD7Seg is
signal w : std_logic_vector(6 downTo 0);	
begin
with ent select
	w <= "0000110" when "0001",
		  "1011011" when "0010",
		  "1001111" when "0011",
		  "1100110" when "0100",
		  "1101101" when "0101",
		  "1111101" when "0110",
		  "0000111" when "0111",
		  "1111111" when "1000",
		  "1101111" when "1001",
		  "0111111" when others;
	sal <= w when en = '1' else "0000000";
end sol;