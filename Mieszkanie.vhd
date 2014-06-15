library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mieszkanie is
port(	
	clk:		in std_logic;
	czyKod: in std_logic;
	rozmowa_out : out std_logic;
	rozmowa_in : in std_logic;
	otworz:	out std_logic;
	dzwon: out std_logic;
	przychodzace :in std_logic;
	odpowiedz: out std_logic;
	sluchawka: in std_logic;
	glosnik : out std_logic;
	mikrofon: in std_logic;
	przycisk: in std_logic;
	
	
	drugieMieszkanie: in std_logic;
	odpowiedzDoM : out std_logic;
	numer:   in std_logic_vector(3 downto 0);
	numerMieszkania: out std_logic_vector(3 downto 0);
	rozmowaCentralka_in :in std_logic;
	koniec :out std_logic;
	rozmowaCentralka_out:out std_logic
	);
end Mieszkanie;

architecture Behavioral of Mieszkanie is
type czymogerozmawiac is (tak,nie);
signal rozm :czymogerozmawiac;
signal pol : czymogerozmawiac;
signal rozmowazdrugiM:czymogerozmawiac;
begin
	A: process (czyKod,przychodzace,drugieMieszkanie)
		variable czyKod_pop,przychodzace_pop,drugie:std_logic;
		variable zm1,zm2,zm3:integer;
	begin	
		if czyKod_pop=czyKod then
			zm1:=0;
		else 
			zm1:=1;
		end if;
		if przychodzace_pop=przychodzace then
			zm2:=0;
		else 
			zm2:=1;
		end if;
		if drugieMieszkanie=drugie then
			zm3:=0;
		else 
			zm3:=1;
		end if;
		if zm1=1 then
			dzwon <= czyKod;
		elsif zm2=1 then
			if przychodzace='1' then
				pol<=tak;
			elsif przychodzace='0' then
				pol<=nie;
			end if;
			dzwon<= przychodzace;
			
		elsif zm3=1 then
			rozmowazdrugimM<=tak;
			dzwon<=drugieMieszkanie;
		end if;
		czyKod_pop:=czyKod;
		przychodzace_pop:=przychodzace;
		drugie:=drugieMieszkanie;
		end process A;
	C: process(przycisk)
	begin
		if rozm=tak then 
		otworz<=przycisk;
		otworz<='0' after 50 ns;
		end if;
	end process C;
	D: process(sluchawka)
		begin
		if pol=tak then
		if(sluchawka='1') then
			rozm<=tak;
			odpowiedz<='1';
			odpowiedz<='0' after 100 ns;
			elsif sluchawka='0' then
			rozm<=nie;
		end if;
		end if;
		if polaczeniezdtugimM=tak then
			if sluchawka='1' then
				odpowiedzDoM<='1';
			elsif sluchawka='0' then
				koniec<='1';
			end if;
		end if;
		if sluchawka='0' then
			rozm<=nie;
			rozmowazdrugiM<=nie;
		end if;

	end process D;
	E:process(clk,rozmowa_in)
	begin
		if rozm=tak then
			glosnik<=rozmowa_in;
		else
			glosnik<='0';
		end if;
	end process E;
	G:process(mikrofon)
	begin
		if rozm=tak then
			rozmowa_out<=mikrofon;
		elsif polaczeniezdtugimM=tak then
			rozmowa_Centralka_out<=mikrofon;
		end if;
	end process G;
	
	F:process(numer)
	begin
	numermieszkania<=numer;
	
	end process F;
end Behavioral;
