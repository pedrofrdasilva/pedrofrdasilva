library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM3a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM3a;

architecture arc_ROM3a of ROM3a is
begin

--           switches 0 a 14
--           EDCBA9876543210                 round
output   <= "010010101000110" when address = "0000" else--ROM3 possui os valores 8, 6, 2, 1, A e D no round 0.
		    "000110110010010" when address = "0001" else--ROM3 possui os valores 7, 4, 8, 1, A e B no round 1.
			"101100100100001" when address = "0010" else--ROM3 possui os valores 0, E, 8, 5 ,B e C no round 2.
			"100110010100010" when address = "0011" else--ROM3 possui os valores A, 1, 7, 5 ,B e E no round 3.
			"110011100000010" when address = "0100" else--ROM3 possui os valores 9, 8, A, 1, D e E no round 4.
			"100110000001101" when address = "0101" else--ROM3 possui os valores 2, 3, A, E, B e 0 no round 5.
			"011001010001010" when address = "0110" else--ROM3 possui os valores D, 1, 9, 7, 3 e C no round 6.
			"001110010001100" when address = "0111" else--ROM3 possui os valores C, 2, A, 3, 7 e B no round 7.
			"101101001000100" when address = "1000" else--ROM3 possui os valores 9, C, 6, E, 2 e B no round 8.
			"100110110000010" when address = "1001" else--ROM3 possui os valores B, A, 8, 7, 1 e E no round 9.
			"010110010010010" when address = "1010" else--ROM3 possui os valores 1, 7, D, B, A e 4 no round 10.
			"001111010001000" when address = "1011" else--ROM3 possui os valores 7, 3, 9, B, C e A no round 11.
			"011100100010010" when address = "1100" else--ROM3 possui os valores B, 8, D, C, 4 e 1 no round 12.
			"100101000100011" when address = "1101" else--ROM3 possui os valores 5, E, 9, 0, B e 1 no round 13.
			"110011010010000" when address = "1110" else--ROM3 possui os valores 9, 7, 4, D, E e A no round 14.
			"000110110011000";--ROM3 possui os valores 7, B, 4, 8, A e 3 no round 15.
			 
end arc_ROM3a;