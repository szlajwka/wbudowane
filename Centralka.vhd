library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 

entity Centralka is
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
			odpowiedz_M1:in std_logic;
			odpowiedz_M2:in std_logic
			);
end Centralka;

architecture Behavioral of Centralka is
type mieszkanie is (M1, M2,M0);
type dzwonek is (tak,nie);
signal aktualne_mieszkanie: mieszkanie;
signal czydzwon:dzwonek;	
begin
	A: process (numerM,odpowiedz_M1,odpowiedz_M2)
	variable popOdpM1,popOdpM2:std_logic;
	variable popNum:std_logic_vector(3 downto 0);
	variable zmNum,zmOdp1,zmOdp2:integer;
	begin
	if numerM=popNum then
		zmNum:=0;
	else
		zmNum:=1;
	end if;
	if popOdpM1=odpowiedz_M1 then
		zmOdp1:=0;
	else
		zmOdp1:=1;
	end if;
	if popOdpM2=odpowiedz_M2 then
		zmOdp2:=0;
	else
		zmOdp2:=1;
	end if;
   IF numerM="0001"THEN
		aktualne_mieszkanie<=M1;
		IF czyKod='1' THEN
			czyKod_M1<='1';
			czyKod_M1<='0' after 100 ns;
		ELSE
		
			IF zmOdp1=0 THEN
			dzwon_M1<='1';
			dzwon_M1<='0' after 200 ns;
			ELSE
			dzwon_M1<='0';
			END IF;
		END IF;

	ELSIF numerM="0010" THEN
		aktualne_mieszkanie<=M2;
		IF czyKod='1' THEN
			czyKod_M2<='1';
			czyKod_M2<='0' after 100 ns;
		ELSE	
			IF zmOdp2=0 THEN
			dzwon_M2<='1';
			dzwon_M1<='0' after 200 ns;
			ELSE
			dzwon_M2<='0';
			END IF;
		END IF;
	ELSE 
		aktualne_mieszkanie<=M0;
		popNum:=numerM;
		popOdpM1:=odpowiedz_M1;
		popOdpM2:=odpowiedz_M2;
	END IF;
	end process A;
	
	B: process (otworz_M1,otworz_M2)
	begin
		IF aktualne_mieszkanie=M1 THEN
			otworz<= otworz_M1;
		ELSIF aktualne_mieszkanie=M2 THEN 
			otworz<= otworz_M2;
		END IF;
	end process B;
	D: process (rozmowa_in_M2,rozmowa_in_M1)
	begin
		IF aktualne_mieszkanie=M1 THEN
		rozmowa_out_domofon<=rozmowa_in_M1;
		ELSIF aktualne_mieszkanie=M2 THEN
		rozmowa_out_domofon<=rozmowa_in_M2;
		END IF;
	end process D;
	F: process (rozmowa_in_domofon)
	begin
			IF aktualne_mieszkanie=M1 THEN
			rozmowa_out_M1<=rozmowa_in_domofon;
			ELSIF aktualne_mieszkanie=M2 THEN
			rozmowa_out_M2<=rozmowa_in_domofon;
			END IF;
		end process F;
end Behavioral;