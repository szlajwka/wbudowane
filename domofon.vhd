
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity domofon is
	port(	
			clk		: in std_logic;									-- in zegar
			admin		: in std_logic;									-- in sygnal administratora (gdy 1 to mozna zmieniac kody)
			flatNo	: in std_logic_vector(3 downto 0);		 	-- in numer mieszkania (z klawiatury domofonu)
			code		: in std_logic_vector(3 downto 0); 			-- in kod mieszkania (z klawiarury domofonu)			
			door		: out std_logic;									-- out sygnal do zamka: 1 - drzwi sa otwarte 0  - wpp
			
			out_flatNo 		: out std_logic_vector(3 downto 0);		-- out (przesylany dalej) numer mieszkania
			out_isOpened	: out std_logic;								-- out (przesylany dajej) czy kod zostal wpisany poprawnie (tzn ktos wchodzi)
			in_openRequest	: in std_logic;								-- in (przychodzi z innego urzadzenia) - jesli 1 to ktos z domu otwiera drzwi			
			
			talk_in			: in std_logic;	-- rozmowa (glos przychodzacy, z mieszkania) 
			talk_out			: out std_logic	-- rozmowa (glos wychodzacy, ktos kto chce wejsc)
			);
			
	type logic_vector_array is array (integer range <>) of std_logic_vector(3 downto 0);

end domofon;

architecture Behavioral of domofon is
 
begin

	X: process(clk)
	variable codes : logic_vector_array (0 to 15) := ("1001", "1010", "1011", "1011", "1100", others=>"0000");

	begin
	if rising_edge(clk) then
		if talk_in = '1' then -- ROZMOWA
			talk_out<='1';	--linia rozmowy
			door<='0';	--podczas rozmowy drzwi sa zamkniete
			out_isOpened <= '0';		-- nie powiadamiamy o otworzeniu drzwi
			out_flatNo <= "0000";	-- nie wysylamy nr mieszkania
		else	
			if (admin = '0') then		-- TRYB  ZWYKLY (NIE ADMINOWSKI)
				if in_openRequest = '1' then -- ktos z mieszkancow chce aby otworzyc drzwi
					talk_out<='0';
					door <='1';					-- drzwi otwarte
					out_isOpened <= '0';		-- nikogo nie powiadamiamy	o otworzeniu drzwi
					out_flatNo <= "0000";	-- nikogo nie powiadamiamy
				else -- PROBA OTWORZENIA DRZWI SPOD BRAMY
					if code = "0000" then 	-- KTOS ZADZWONIL DO MIESZKANIA (BEZ KODU)
						talk_out<='0';
						door <= '0';				-- drzwi zamkniete
						out_isOpened <= '0';		-- przeslij dalej ze nikt nie wchodzi, czyli bedziemy nawiazywac polaczenie glosow
						out_flatNo <= flatNo;	-- przeslij dalej numer mieszkania do ktorego bedziemy dzwonic
					else		-- KTOS WCHODZI DO BRAMY ZA POMOCA KODU 
						if (codes(to_integer(signed(flatNo))) = code) then	-- KOD PRAWIDLOWY
							talk_out<='0';
							door <= '1';				-- drzwi otwarte
							out_isOpened <='1';		-- przesliij dalej informacje, ze ktos wchodzi
							out_flatNo <= flatNo;	-- przesliij dalej numer mieszkania

						else 						--KOD NIE PRAWIDLOWY
							talk_out<='0';
							door <= '0'; 			-- drzwi zamkniete
							out_isOpened <='0';		-- nic nie przesylamy
							out_flatNo <= "0000";	--nikt nie wchodzil, nie przesylaj nic do domu
						end if;
					end if;
				end if;
			else	-- TRYB ADMINA
				codes(to_integer(signed(flatNo))) := code;	 -- przypisz do tabliy z kodami pod adresem mieszaknia nowy kod
				door <= '1'; 	-- administrator po wejscu do swojego trybu moze wejsc do bramy
				out_flatNo <= "0000";	-- nikogo nie powiadamiamy
				out_isOpened <= '0';		-- nikogo nie powiadamiamy	
			end if;
		end if;
	end if;	
	end process X;
end Behavioral;