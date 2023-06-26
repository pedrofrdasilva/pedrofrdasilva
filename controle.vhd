library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity controle is
port(
-- Entradas de controle
	enter, reset, clock: in std_logic;
-- Entradas de status
	end_game, end_time, end_round, end_FPGA: in std_logic;
-- Saídas de comandos
	R1, R2, E1, E2, E3, E4, E5: out std_logic
	);
end controle;

architecture control of controle is
	type STATES is (init, set, play_fpga, play_user, count_round, check, waitt, result);
	signal EA, PE: STATES;
	begin
		P1: process(clock, reset)
			begin
			if reset= '1' then
				EA <= init;
			elsif (clock'event and clock= '1') then
            EA <= PE;
			end if;
		end process;
		P2: process(EA,end_game, end_time, end_round, end_FPGA, enter)
			begin
			case EA is
				when init => 	
					R1 <= '1';
					R2 <= '1';
					E1 <= '0';
					E2 <= '0';
					E3 <= '0';
					E4 <= '0';
					E5 <= '0';
					PE <= set;
				when set => 	
					R1 <= '0';
					R2 <= '0';
					E1 <= '1';
					E2 <= '0';
					E3 <= '0';
					E4 <= '0';
					E5 <= '0';
					if(enter = '1') then
						PE <= play_fpga;
					else
						PE <= set;
					end if;
				when play_fpga => 	
					R1 <= '0';
					R2 <= '0';
					E1 <= '0';
					E2 <= '1';
					E3 <= '0';
					E4 <= '0';
					E5 <= '0';
					if(end_FPGA = '1') then
						PE <= play_user;
					else
						PE <= play_fpga;
					end if;
				when play_user => 	
					R1 <= '0';
					R2 <= '0';
					E1 <= '0';
					E2 <= '0';
					E3 <= '1';
					E4 <= '0';
					E5 <= '0';
					if(enter = '1') then
						PE <= count_round;
					elsif((end_time) = '1') then
						PE <= result;
					else
						PE <= play_user;
					end if;
				when count_round =>
					R1 <= '0';
					R2 <= '0';
					E1 <= '0';
					E2 <= '0';
					E3 <= '0';
					E4 <= '1';
					E5 <= '0';
					PE <= check;
				when check => 	
					R1 <= '0';
					R2 <= '0';
					E1 <= '0';
					E2 <= '0';
					E3 <= '0';
					E4 <= '0';
					E5 <= '0';
					if ((end_round or end_game) = '1') then
						PE <= result;
					else
						PE <= waitt;
					end if;
				when waitt =>
					R1 <= '1';
					R2 <= '0';
					E1 <= '0';
					E2 <= '0';
					E3 <= '0';
					E4 <= '0';
					E5 <= '0';
					if (enter = '1') then
						PE <= play_fpga;
					else
						PE <= waitt;
					end if;
				when result => 
					R1 <= '0';
					R2 <= '0';
					E1 <= '0';
					E2 <= '0';
					E3 <= '0';
					E4 <= '0';
					E5 <= '1';
					if (enter = '1') then
						PE <= init;
					else
						PE <= result;
					end if;
				end case;
		end process;
end control;