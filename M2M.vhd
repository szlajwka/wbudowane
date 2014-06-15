library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 

entity M2M is
	
	port(	clk		: in std_logic;
			numerM   : in std_logic_vector(3 downto 0);
			dzwon_M1 : out std_logic;
			dzwon_M2 : out std_logic;
			rozmowa_out_M1 : out std_logic;
			rozmowa_in_M1 : in std_logic;
			rozmowa_out_M2 : out std_logic;
			rozmowa_in_M2 : in std_logic;
			odp : in std_logic;
			odp_M1: out std_logic;
			koniec_M1:in std_logic;
			koniec_M2:in std_logic;
			odp_M2: out std_logic
			);
end M2M;

architecture Behavioral of M2M is
type mieszkanie is (M1, M2,M0);
type lacze is (wolne,zajete);
signal stanLacza:lacze;
signal numer: mieszkanie;
begin
		A:process(numerM)
		begin
			if numerM="0001" then
				numer<=M1;
				dzwon_M1<='1';
				dzwon_M1<='0' after 50 ns;
			elsif numerM="0010" then
				numer<=M2;
				dzwon_M2<='1';
				dzwon_M2<='0' after 50 ns;
			else 
				numer<=M0;
			end if;
				end process A;
		
		B:process(odp,koniec_M1,koniec_M2)
		variable popOdp:std_logic;
		variable popKM1,popKM2:std_logic;
	   variable zmOdp,zmKM1,zmKM2:integer;	
		begin
			if popOdp=odp then
				zmOdp:=0;
			else
				zmOdp:=1;
			end if;
			if popKM1=koniec_M1 then
				zmKM1:=0;
			else
				zmKM1:=1;
			end if;
			if popKM2=koniec_M2 then
				zmKM2:=0;
			else
				zmKM2:=1;
			end if;
			if zmOdp=1 then
				if numer=M1 then
					odp_M1<='1';
					odp_M1<='0' after 200 ns;
					stanLacza<=zajete;
				elsif numer=M2 then
					odp_M2<='1';
					odp_M2<='0' after 200 ns;
					stanLacza<=zajete;
				end if;
			elsif zmKM2 = 1 then
					stanLacza<=wolne;
			elsif zmKM1 = 1 then
					stanLacza<=wolne;	
			end if;
			popKM1:=koniec_M1;
			popKM2:=koniec_M2;
			popOdp:=odp;
		end process B;
		C: process(clk,rozmowa_in_M2,rozmowa_in_M1)
		begin
			if stanLacza=zajete then
				rozmowa_out_M1<=rozmowa_in_M2;
				rozmowa_out_M2<=rozmowa_in_M1;
			else
				rozmowa_out_M1<='0';
				rozmowa_out_M2<='0';
			end if;
		end process C;
end Behavioral;