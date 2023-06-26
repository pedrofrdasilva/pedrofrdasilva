library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity COMP_end is
port(
	E0: in std_logic_vector(3 downto 0);
	endgame: out std_logic
);
end entity;

architecture bhv of COMP_end is
begin
    process(E0)
    begin
        if (E0 = "0000") then
            endgame <= '1';
        else
            endgame <= '0';
        end if;
    end process;
end bhv;