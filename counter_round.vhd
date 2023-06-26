library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter_round is port (
    R, E, clock: in std_logic;
    Q: out std_logic_vector(3 downto 0);
    tc: out std_logic);
end counter_round;

architecture arqdtp of counter_round is
    signal tot: std_logic_vector(4 downto 0);
begin
    -- Registrador e Somador:
    process(clock, R, E)
    begin
        if (R = '1') then
            tot <= "00000";
        elsif(tot = "10000") then
        tc <= '1';
        elsif (clock'event AND clock = '1') then
            if (E = '1') then
                tot <= tot + 1;
            end if;
        end if;
    end process;
    Q <= tot(3 downto 0);
end arqdtp;