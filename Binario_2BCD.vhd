library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Binario_2BCD is
Port(ent : in std_logic_vector(7 downTo 0);
		D, U: out std_logic_vector(3 downTo 0));
end Binario_2BCD;

Architecture sol of Binario_2BCD is
Begin
	process(ent)
        variable z: STD_LOGIC_VECTOR(15 downto 0);
    begin
        -- Inicialización de datos en cero.
        z := (others => '0');
        -- Se realizan los primeros tres corrimientos.
        z(10 downto 3) := ent;
        for i in 0 to 4	 loop
            -- Unidades (4 bits).
            if z(11 downto 8) > 4 then
                z(11 downto 8) := z(11 downto 8) + 3;
            end if;
            -- Decenas (4 bits).
            if z(15 downto 12) > 4 then
                z(15 downto 12) := z(15 downto 12) + 3;
            end if;
            -- Corrimiento a la izquierda.
            z(15 downto 1) := z(14 downto 0);
        end loop;
        -- Pasando datos de variable Z, correspondiente a BCD.
        U <= z(11 downto 8);
		  D <= z(15 downto 12);
    end process;
end sol;
