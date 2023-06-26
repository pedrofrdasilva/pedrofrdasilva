library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM2 is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(31 downto 0)
);
end ROM2;

architecture arc_ROM2 of ROM2 is
begin

--         HEX7      HEX6     HEX5     HEX4     HEX3     HEX2     HEX1     HEX0               round

output <= "1111"	& "0110" & "0010" & "1111"	& "0001" & "1010" & "1101" & "1111" when address = "0000" else
--         des        6          2      des       1          A       D       des

          "0111"	& "1111" & "0100" & "1000"	& "1111" & "1010" & "1011" & "1111" when address = "0001" else
--          7        des       4          8      des       A          B       des

			 "0000"	& "1111" & "1111" & "1000"	& "0101" & "1111" & "1011" & "1100" when address = "0010" else
--            0       des      des       8          5      des       B        C

			 "1111"	& "0001" & "0111" & "1111"	& "0101" & "1011" & "1111" & "1110" when address = "0011" else
--         des          1       7       des       5          B      des       E

			 "1111"	& "1001" & "1000" & "1111"	& "1111" & "0001" & "1101" & "1110" when address = "0100" else
--         des        9       8        des      des       1          D        E

			 "0010"	& "0011" & "1111" & "1010"	& "1111" & "1110" & "1111" & "0000" when address = "0101" else
--          2           3      des      A           des       E       des       0

			 "1111"	& "0001" & "1001" & "1111"	& "0111" & "1111" & "0011" & "1100" when address = "0110" else
--         des        1          9      des         7      des       3        C			 
			 
			 "1100"	& "0010" & "1111" & "1010"	& "0011" & "0111" & "1111" & "1111" when address = "0111" else
--          C        2         des       A        3          7      des      des

			 "1111"	& "1001" & "1100" & "0110"	& "1111" & "1110" & "0010" & "1111" when address = "1000" else
--         des        9         C       6       des         E       2       des

			 "1111"	& "1010" & "1000" & "1111"	& "1111" & "0111" & "0001" & "1110" when address = "1001" else
--         des       A          8       des      des       7          1       E

			 "0001"	& "1111" & "1101" & "1011"	& "1111" & "1010" & "1111" & "0100" when address = "1010" else
--          1        des       D         B       des       A       des        4

			 "0111"	& "0011" & "1111" & "1001"	& "1011" & "1111" & "1100" & "1111" when address = "1011" else
--            7        3       des      9         B       des       C       des

			 "1111"	& "1000" & "1111" & "1101"	& "1100" & "0100" & "1111" & "0001" when address = "1100" else
--         des        8       des       D          C       4       des      1

			 "0101"	& "1110" & "1111" & "1111"	& "0000" & "1011" & "1111" & "0001" when address = "1101" else
--          5           E      des      des       0         B      des       1

			 "1001"	& "1111" & "0111" & "0100"	& "1111" & "1101" & "1110" & "1111" when address = "1110" else
--           9       des       7         4      des       D        E       des

			 "0111"	& "1011" & "1111" & "0100"	& "1111" & "1010" & "1111" & "0011";
--           7        B       des       4       des         A      des       3
			 
end arc_ROM2;