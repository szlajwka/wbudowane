library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 

entity Centralka is
	generic(
	mieszkanie : integer:=0;
	polaczenie : boolean:=false
	);
	port(	clk		: in std_logic;
			numerM   : in std_logic_vector(3 downto 0);
			rozmowa_out_domofon: out std_logic;
			rozmowa_in_domofon: in std_logic;
			otworz : out std_logic_vector(0 downto 0);
			dzwon_M1 : out std_logic; 
			rozmowa_out_M1 : out std_logic;
			rozmowa_in_M1 : in std_logic;
			otworz_M1 : in std_logic_vector(0 downto 0);
			czyKod : in std_logic;
			czyKod_M1: out std_logic;
			rozmowa_out_M2 : out std_logic;
			rozmowa_in_M2 : in std_logic;
			otworz_M2 : in std_logic_vector(0 downto 0);
			czyKod_M2: out std_logic;
			dzwon_M2 : out std_logic;
			);
end Centralka;

architecture Behavioral of Centralka is
begin
	A: process (numerM)
	begin
	IF numerM="0001"THEN
		mieszkanie<=1;
		IF czyKod='1' THEN
			czyKod_M1<='1';
		ELSE
			dzwon_M1<='1';
		END IF;
		
	ELSIF numerM="0010" THEN
		mieszkanie<=2;
		IF czyKod='1' THEN
			czyKod_M2<='1';
		ELSE
			dzwon_M2<='1';
		END IF;
	END IF;
	end process A;
	
	B: process (otworz_M1)
	begin
		otworz<= otworz_M1;
		polaczenie<=false;
	end process B;
	
	C: process (otworz_M2)
	begin
		otworz<= otworz_M2;
		polaczenie<=false;
	end process C;
	D: process (rozmowa_in_M2)
	begin 
		polaczenie <=true;
		rozmowa_out_domofon<=rozmowa_in_M2;
	end process D;
	E: process (rozmowa_in_M1)
	begin
		polaczenie <=true;
		rozmowa_out_domofon<=rozmowa_in_M1;
	end process E;
	F: process (rozmowa_in_domofon)
	begin
		IF polaczenie=true THEN
			IF mieszkanie=1 THEN
			rozmowa_out_M1<=rozmowa_in_domofon;
			ELSE
			rozmowa_out_M2<=rozmowa_in_domofon;
			END IF
		END IF
	end process F;
end Behavioral;