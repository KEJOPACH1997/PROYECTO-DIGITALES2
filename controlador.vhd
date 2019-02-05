library ieee;
use ieee.std_logic_1164.all;

entity controlador is
	Port(
		Resetn, clock: in std_logic;
		Start, Monitorear, Consulta, Men5s, Up, Down, MayMax, MenMin, Salir: in std_logic;
		EnMax, EnMin, EnTemp, LdTemp, En5s, Ld5s: out std_logic;
		EnM, downTemp, SelRegMin, SelReg, EnMostT, EnMostS: out std_logic;
		SelMost: out std_logic_vector(1 downto 0);
		estado: out std_logic_vector(3 downto 0)
	);
end controlador;

Architecture sol of controlador is
	type est is (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15);
	signal y: est;

begin
--transiciones
Process(Resetn, clock)
BEGIN
	if Resetn = '0' then y <= T1;
	elsif clock'event and clock = '1' then
		case y is
			when T1 => if start = '1' then y<=T2; end if;
			when T2 => if start = '0' then y<=T3; end if;
			when T3 => if Monitorear = '1' then y<= T4;
							elsif Consulta = '1' then y<=T5;
							else y<= T3; end if;
			when T4 => if Monitorear = '0' then y<=T6; end if;
			when T5 => if Consulta = '0' then y<= T7; end if;
			when T6 => if Up = '1' then y<= T8; 
							elsif down = '1' then y<= T9; 
							elsif MayMax = '1' then y<= T10;
							elsif MenMin = '1' then y<= T11;
							elsif Salir = '1' then y<= T3;
							else y <= T6; end if;
			when T7 => if Men5s = '0' then y<= T12; end if;
			when T8 => if up = '0' then y<= T13; end if;
			when T9 => if down = '0' then y<= T14; end if;
			when T10 => y<= T6;
			when T11 => y <= T6;
			when T12 => y<= T15;
			when T13 => y<= T6;
			when T14 => y<= T6;
			when T15 => if Men5s ='0' then y<=T3; end if;
		end case;
	end if;
end process;

--salidas
Process(Resetn, clock)
begin
EnMax <= '0'; EnMin <= '0'; EnTemp <= '0'; LdTemp <= '0'; En5s <= '0'; Ld5s <= '0';
EnM <= '0'; downTemp <= '0'; SelRegMin <= '0'; SelReg <= '0'; EnMostT <= '0'; EnMostS <= '0';
SelMost <= "00";
estado <= "0000";

case y is
	when T1 => EnMax <= '1'; EnMin <= '1'; EnTemp <= '1'; LdTemp <= '1'; En5s <= '1'; Ld5s <= '1'; SelMost <= "11"; estado <= "0001";
	when T2 => SelMost <= "11"; estado <= "0010";
	when T3 => SelMost <= "11"; estado <= "0011";
	when T4 => SelMost <= "11"; estado <= "0100";
	when T5 => SelMost <= "11"; estado <= "0101";
	when T6 => EnM <= '1'; EnMostT <= '1'; EnMostS <= '1'; estado <= "0110";
	when T7 => SelMost <= "01"; En5s <= '1'; EnMostT <= '1'; estado <= "0111";
	when T8 => EnM <= '1'; estado <= "1000";
	when T9 => EnM <= '1'; estado <= "1001";
	when T10 => SelReg <= '1'; EnMax <= '1'; EnM <= '1'; estado <= "1010";
	when T11 => SelRegMin <= '1'; EnMin <= '1'; EnM <= '1'; estado <= "1011";
	when T12 => En5s <= '1'; Ld5s <= '1'; estado <= "1100";
	when T13 => EnTemp <= '1'; EnM <= '1'; estado <= "1101";
	when T14 => EnTemp <= '1'; DownTemp <= '1'; EnM <= '1'; estado <= "1110";
	when T15 => SelMost <= "10"; En5s <= '1'; EnMostT <='1'; estado <= "1111";
end case;
end process;
end sol;
