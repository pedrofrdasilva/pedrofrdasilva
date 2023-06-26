library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity logica is
port(
	round, bonus: in std_logic_vector(3 downto 0);
	nivel: in std_logic_vector(1 downto 0);
	points: out std_logic_vector(7 downto 0)
);
end logica;

architecture behv of logica is
begin

points <= ('0' & (nivel & "00000")) + (("0" & (bonus(3 downto 1))) & "00") + ("00" & round(3 downto 2));

end behv;