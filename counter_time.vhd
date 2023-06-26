
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity counter_time is port (
    R, E, clock: in std_logic;
    Q: out std_logic_vector(3 downto 0);
    tc: out std_logic);
end counter_time;

architecture arqdtp of counter_time is
    signal tot: std_logic_vector(3 downto 0);
begin
    -- Registrador e Somador:
    process(clock, R, E)
    begin
        if (R = '1') then
            tot <= "1010";
        elsif(tot <= "0000") then
        tc <= '1';
        elsif (clock'event AND clock = '1') then
            if (E = '1') then
                tot <= tot - 1;
            end if;
        end if;
    end process;
    Q <= tot;
end arqdtp;