library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity datapath is
port(
	-- Entradas de dados
	clk: in std_logic;
	SW: in std_logic_vector(17 downto 0);
	
	-- Entradas de controle
	R1, R2, E1, E2, E3, E4, E5: in std_logic;
	
	-- Saídas de dados
	hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7: out std_logic_vector(6 downto 0);
	ledr: out std_logic_vector(15 downto 0);
	
	-- Saídas de status
	end_game, end_time, end_round, end_FPGA: out std_logic
);
end entity;

architecture arc of datapath is
---------------------------SIGNALS-----------------------------------------------------------
--contadores
signal tempo, X: std_logic_vector(3 downto 0);
--FSM_clock
signal CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: std_logic;
--Logica combinacional
signal RESULT: std_logic_vector(7 downto 0);
--Registradores
signal SEL: std_logic_vector(3 downto 0);
signal USER: std_logic_vector(14 downto 0);
signal Bonus, Bonus_reg: std_logic_vector(3 downto 0);
--ROMs
signal CODE_aux: std_logic_vector(14 downto 0);
signal CODE: std_logic_vector(31 downto 0);
--COMP
signal erro: std_logic;
--NOR enables displays
signal E23, E25, E12: std_logic;

--signals implícitos--

--dec termometrico
signal stermoround, stermobonus, andtermo: std_logic_vector(15 downto 0);
--decoders HEX 7-0
signal sdecod7, sdec7, sdecod6, sdec6, sdecod5, sdecod4, sdec4, sdecod3, sdecod2, sdec2, sdecod1, sdecod0, sdec0: std_logic_vector(6 downto 0);
signal smuxhex7, smuxhex6, smuxhex5, smuxhex4, smuxhex3, smuxhex2, smuxhex1, smuxhex0: std_logic_vector(6 downto 0);
signal edec2, edec0: std_logic_vector(3 downto 0);
--saida ROMs
signal srom0, srom1, srom2, srom3: std_logic_vector(31 downto 0);
signal srom0a, srom1a, srom2a, srom3a: std_logic_vector(14 downto 0);
--FSM_clock
signal E2orE3: std_logic;

---------------------------COMPONENTS-----------------------------------------------------------
component counter_time is 
port(
	R, E, clock: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	tc: out std_logic
);
end component;

component counter_round is
port(
	R, E, clock: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	tc: out std_logic
);
end component;

component decoder_termometrico is
 port(
	X: in  std_logic_vector(3 downto 0);
	S: out std_logic_vector(15 downto 0)
);
end component;

--component FSM_clock_de2 is
--port(
--	reset, E: in std_logic;
--	clock: in std_logic;
--	CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
--);
--end component;

component FSM_clock_emu is
port(
	reset, E: in std_logic;
	clock: in std_logic;
	CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
);
end component;

component decod7seg is
port(
	C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
 );
end component;

component d_code is
port(
	C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
 );
end component;

component mux2x1_7bits is
port(
	E0, E1: in std_logic_vector(6 downto 0);
	sel: in std_logic;
	saida: out std_logic_vector(6 downto 0)
);
end component;

component mux2x1_16bits is
port(
	E0, E1: in std_logic_vector(15 downto 0);
	sel: in std_logic;
	saida: out std_logic_vector(15 downto 0)
);
end component;

component mux4x1_1bit is
port(
	E0, E1, E2, E3: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic
);
end component;

component mux4x1_15bits is
port(
	E0, E1, E2, E3: in std_logic_vector(14 downto 0);
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic_vector(14 downto 0)
);
end component;

component mux4x1_32bits is
port(
	E0, E1, E2, E3: in std_logic_vector(31 downto 0);
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic_vector(31 downto 0)
);
end component;

component registrador_sel is 
port(
	R, E, clock: in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0) 
);
end component;

component registrador_user is 
port(
	R, E, clock: in std_logic;
	D: in std_logic_vector(14 downto 0);
	Q: out std_logic_vector(14 downto 0) 
);
end component;

component registrador_bonus is 
port(
	S, E, clock: in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0) 
);
end component;

component COMP_erro is
port(
	E0, E1: in std_logic_vector(14 downto 0);
	diferente: out std_logic
);
end component;

component COMP_end is
port(
	E0: in std_logic_vector(3 downto 0);
	endgame: out std_logic
);
end component;

component subtracao is
port(
	E0: in std_logic_vector(3 downto 0);
	E1: in std_logic;
	resultado: out std_logic_vector(3 downto 0)
);
end component;

component logica is 
port(
	round, bonus: in std_logic_vector(3 downto 0);
	nivel: in std_logic_vector(1 downto 0);
	points: out std_logic_vector(7 downto 0)
);
end component;

component ROM0 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM1 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM2 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM3 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM0a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM1a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM2a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM3a is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

-- COMECO DO CODIGO ---------------------------------------------------------------------------------------

begin
andtermo <= (stermoround and not (E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1));
E23 <= not (E2 or E3);
E25 <= not (E2 or E5);
E12 <= not (E1 or E2);
E2orE3 <= (E2 or E3);
    HEX7 <= (E25&E25&E25&E25&E25&E25&E25) or smuxhex7;
    HEX6 <= (E25&E25&E25&E25&E25&E25&E25) or smuxhex6;
    HEX5 <= (E23&E23&E23&E23&E23&E23&E23) or smuxhex5;
    HEX4 <= (E23&E23&E23&E23&E23&E23&E23) or smuxhex4;
    HEX3 <= (E12&E12&E12&E12&E12&E12&E12) or smuxhex3;
    HEX2 <= (E12&E12&E12&E12&E12&E12&E12) or smuxhex2;
    HEX1 <= (E12&E12&E12&E12&E12&E12&E12) or smuxhex1;
    HEX0 <= (E12&E12&E12&E12&E12&E12&E12) or smuxhex0;

CT0: Counter_time  port map(R1, E3, clk_1Hz, tempo, end_time);
CT1: Counter_round port map(R2, E4, clk, X, end_round);
DCT0: decoder_termometrico port map(Bonus_reg, stermobonus);
DCT1: decoder_termometrico port map(X, stermoround);
-- FCD: FSM_clock_de2 port map(R1, E2orE3, clk, CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz);
FCE: FSM_clock_emu port map(R1, E2orE3, clk, CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz);
D7H7: decod7seg  port map(RESULT(7 downto 4), sdec7);
D7H6: decod7seg  port map(RESULT(3 downto 0), sdec6);
D7H4: decod7seg  port map(tempo, sdec4);
edec2 <= "00" & SEL(3 downto 2);
edec0 <= "00" & SEL(1 downto 0);
D7H2: decod7seg  port map(edec2, sdec2);
D7H0: decod7seg  port map(edec0, sdec0);
COD7: d_code   port map(CODE(31 downto 28), sdecod7);
COD6: d_code   port map(CODE(27 downto 24), sdecod6);
COD5: d_code   port map(CODE(23 downto 20), sdecod5);
COD4: d_code   port map(CODE(19 downto 16), sdecod4);
COD3: d_code   port map(CODE(15 downto 12), sdecod3);
COD2: d_code   port map(CODE(11 downto 8), sdecod2);
COD1: d_code   port map(CODE(7 downto 4), sdecod1);
COD0: d_code   port map(CODE(3 downto 0), sdecod0);
M21_077: mux2x1_7bits   port map(sdecod7, sdec7, E5, smuxhex7);
M21_076: mux2x1_7bits   port map(sdecod6, sdec6, E5, smuxhex6);
M21_075: mux2x1_7bits   port map(sdecod5, "0000111", E3, smuxhex5);
M21_074: mux2x1_7bits   port map(sdecod4, sdec4, E3, smuxhex4);
M21_073: mux2x1_7bits   port map(sdecod3, "1000110", E1, smuxhex3);
M21_072: mux2x1_7bits   port map(sdecod2, sdec2, E1, smuxhex2);
M21_071: mux2x1_7bits   port map(sdecod1, "1000111", E1, smuxhex1);
M21_070: mux2x1_7bits   port map(sdecod0, sdec0, E1, smuxhex0);
M21_16: mux2x1_16bits   port map(andtermo, stermobonus, SW(17), LEDR);
M41_01: mux4x1_1bit     port map(CLK_025Hz, CLK_025Hz, CLK_033Hz, CLK_050Hz, SEL(1 downto 0), end_FPGA);
M41_15: mux4x1_15bits   port map(srom0a, srom1a, srom2a, srom3a, SEL(3 downto 2), CODE_aux);
M41_32: mux4x1_32bits   port map(srom0, srom1, srom2, srom3, SEL(3 downto 2), CODE);
REGS: registrador_sel   port map(R2, E1, CLK, SW(3 downto 0), SEL);
REGU: registrador_user  port map(R2, E3, CLK, SW(14 downto 0), USER);
REGB: registrador_bonus port map(R2, E4, CLK, Bonus, Bonus_reg);
CMPE: COMP_erro port map(CODE_aux, USER, erro);
CMPN: COMP_end  port map(Bonus_reg, end_game);
SUBT: subtracao port map(Bonus_reg, erro, Bonus);
LOG: logica port map(X, Bonus_reg, SEL(1 downto 0), RESULT);
RM0: ROM0   port map(X, srom0);
RM1: ROM1   port map(X, srom1);
RM2: ROM2   port map(X, srom2);
RM3: ROM3   port map(X, srom3);
R0a: ROM0a  port map(X, srom0a);
R1a: ROM1a  port map(X, srom1a);
R2a: ROM2a  port map(X, srom2a);
R3a: ROM3a  port map(X, srom3a);


--Conexoes e atribuicoes a partir daqui. Dica: usar os mesmos nomes e I/O ja declarados nos components. Todos os signals necessarios ja estao declarados.

end arc;