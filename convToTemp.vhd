library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity convToTemp is
	port(
		ent : in std_logic_vector(11 downTo 0);
		sal : out std_logic_vector(7 downTo 0)
	);
end convToTemp;

architecture comp of convToTemp is
   signal int256 : std_logic_vector(19 downTo 0);
	signal int64 : std_logic_vector(17 downTo 0);
	signal int8 : std_logic_vector(14 downTo 0);
	signal int2 : std_logic_vector(12 downTo 0);
	signal sum : std_logic_vector(19 downTo 0); 
begin
	int256(19 downTo 8) <= ent;
	int256(7 downTo 0) <= "00000000";
	int64(17 downTo 6) <= ent;
	int64(5 downTo 0) <= "000000";
	int8(14 downTo 3) <= ent;
	int8(2 downTo 0) <= "000";
	int2(12 downTo 1) <= ent;
	int2(0) <= '0';
	sum <= int256 + int64 + int8 + int2;
	sal <= sum(19 downTo 12) + '1';
end comp;
