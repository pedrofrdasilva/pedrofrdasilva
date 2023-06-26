library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM1a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM1a;

architecture arc_ROM1a of ROM1a is
begin

--           switches 0 a 14
--           EDCBA9876543210                 round
output <=   "010000001000110" when address = "0000" else--ROM1 possui os valores 6, 2, 1 e D no round 0.
		    "000010110010000" when address = "0001" else--ROM1 possui os valores 7, 4, 8 e A no round 1.
			"001100100100000" when address = "0010" else--ROM1 possui os valores 8, 5 ,B e C no round 2.
			"100100010100000" when address = "0011" else--ROM1 possui os valores 7, 5 ,B e E no round 3.
			"010001100000010" when address = "0100" else--ROM1 possui os valores 9, 8 ,1 e D no round 4.
			"100000000001101" when address = "0101" else--ROM1 possui os valores 2, 3, E e 0 no round 5.
			"001001000001010" when address = "0110" else--ROM1 possui os valores 1, 9, 3 e C no round 6.
			"001010010001000" when address = "0111" else--ROM1 possui os valores C, A, 3 e 7 no round 7.
			"100001001000100" when address = "1000" else--ROM1 possui os valores 9, 6, E e 2 no round 8.
			"100000110000010" when address = "1001" else--ROM1 possui os valores 8, 7, 1 e E no round 9.
			"000110000010010" when address = "1010" else--ROM1 possui os valores 1, B, A e 4 no round 10.
			"001100010001000" when address = "1011" else--ROM1 possui os valores 7, 3, B e C no round 11.
			"011000100010000" when address = "1100" else--ROM1 possui os valores 8, D, C e 4 no round 12.
			"100000000100011" when address = "1101" else--ROM1 possui os valores 5, E, 0 e 1 no round 13.
			"110000010010000" when address = "1110" else--ROM1 possui os valores 7, 4, D e E no round 14.
			"000110000011000";--ROM1 possui os valores B, 4, A e 3 no round 15.
			 
end arc_ROM1a;