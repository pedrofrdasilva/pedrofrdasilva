library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM2a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM2a;

architecture arc_ROM2a of ROM2a is
begin

--           switches 0 a 14
--           EDCBA9876543210                 round
output   <= "010010001000110" when address = "0000" else--ROM2 possui os valores 6, 2, 1, A e D no round 0.
		    "000110110010000" when address = "0001" else--ROM2 possui os valores 7, 4, 8, A e B no round 1.
			"001100100100001" when address = "0010" else--ROM2 possui os valores 0, 8, 5 ,B e C no round 2.
			"100100010100010" when address = "0011" else--ROM2 possui os valores 1, 7, 5 ,B e E no round 3.
			"110001100000010" when address = "0100" else--ROM2 possui os valores 9, 8 ,1, D e E no round 4.
			"100010000001101" when address = "0101" else--ROM2 possui os valores 2, 3, A, E e 0 no round 5.
			"001001010001010" when address = "0110" else--ROM2 possui os valores 1, 9, 7, 3 e C no round 6.
			"001010010001100" when address = "0111" else--ROM2 possui os valores C, 2, A, 3 e 7 no round 7.
			"101001001000100" when address = "1000" else--ROM2 possui os valores 9, C, 6, E e 2 no round 8.
			"100010110000010" when address = "1001" else--ROM2 possui os valores A, 8, 7, 1 e E no round 9.
			"010110000010010" when address = "1010" else--ROM2 possui os valores 1, D, B, A e 4 no round 10.
			"001101010001000" when address = "1011" else--ROM2 possui os valores 7, 3, 9, B e C no round 11.
			"011000100010010" when address = "1100" else--ROM2 possui os valores 8, D, C, 4 e 1 no round 12.
			"100100000100011" when address = "1101" else--ROM2 possui os valores 5, E, 0, B e 1 no round 13.
			"110001010010000" when address = "1110" else--ROM2 possui os valores 9, 7, 4, D e E no round 14.
			"000110010011000";--ROM2 possui os valores 7, B, 4, A e 3 no round 15.
			 
end arc_ROM2a;