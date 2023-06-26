library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4x1_15bits is
    port(
	E0, E1, E2, E3: in std_logic_vector(14 downto 0);
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic_vector(14 downto 0)
    );
end entity;

architecture arch of mux4x1_15bits is


begin
    saida <=
    E0 when sel= "00" else
    E1 when sel = "01" else
    E2 when sel = "10" else
    E3;
end arch;