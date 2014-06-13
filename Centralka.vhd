library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 

entity Centralka is
	generic(width	: integer:=8);
	port(	clk		: in std_logic;
			numerM   : in std_logic_vector(3 downto 0);
			rozmowa_out_domofon: out std_logic;
			rozmowa_in_domofon: in std_logic;
			otworz : out std_logic;
			dzwon_M1 : out std_logic; 
			rozmowa_out_M1 : out std_logic;
			rozmowa_in_M1 : in std_logic;
			otworz_M1 : in std_logic;
			czyKod : in std_logic;
			czyKod_M1: out std_logic;
			rozmowa_out_M2 : out std_logic;
			rozmowa_in_M2 : in std_logic;
			otworz_M2 : in std_logic;
			czyKod_M2: out std_logic;
			dzwon_M2 : out std_logic;
			);
end Centralka;

architecture Behavioral of Centralka is
begin
	A: process (clk,numerM)
	begin
	IF numerM='0001'THEN
		IF czyKod='1' THEN
			czyKod_M1<='1';
		ELSE
			dzwon_M1<='1';
		END IF;
	ELSIF numerM='0010' THEN 
		IF czyKod='1' THEN
			czyKod_M2<='1';
		ELSE
			dzwon_M2<='1';
		END IF;
	END IF;
	end process A;
end Behavioral;