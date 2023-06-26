library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity COMP_erro is
port(
	E0, E1: in std_logic_vector(14 downto 0);
	diferente: out std_logic
);
end entity;

architecture bhv of COMP_erro is
begin
    process(E0, E1)
    begin
        if (E0 = E1) then
            diferente <= '0';
        else
            diferente <= '1';
        end if;
    end process;
end bhv;