
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
		if (admin = '0') then		-- TRYB  ZWYKLY (NIE ADMINOWSKI)
			if in_openRequest = '1' then -- ktos z mieszkancow chce aby otworzyc drzwi
				door <='1';					-- drzwi otwarte
				out_flatNo <= "0000";	-- nikogo nie powiadamiamy
				out_isOpened <= '0';		-- nikogo nie powiadamiamy	
			else -- PROBA OTWORZENIA DRZWI SPOD BRAMY
				if code = "0000" then 	-- KTOS ZADZWONIL DO MIESZKANIA (BEZ KODU)
					door <= '0';				-- drzwi zamkniete
					out_flatNo <= flatNo;	-- przeslij dalej numer mieszkania do ktorego bedziemy dzwonic
					out_isOpened <= '0';		-- przeslij dalej ze nikt nie wchodzi, czyli bedziemy nawiazywac polaczenie glosowe
				else		-- KTOS WCHODZI DO BRAMY ZA POMOCA KODU 
					if (codes(to_integer(signed(flatNo))) = code) then	-- KOD PRAWIDLOWY
						door <= '1';				-- drzwi otwarte
						out_flatNo <= flatNo;	-- przesliij dalej numer mieszkania
						out_isOpened <='1';		-- przesliij dalej informacje, ze ktos wchodzi
					
					else 						--KOD NIE PRAWIDLOWY
						door <= '0'; 			-- drzwi zamkniete
						out_flatNo <= "0000";	--nikt nie wchodzil, nie przesylaj nic do domu
						out_isOpened <='0';		-- nic nie przesylamy
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
	end process X;
end Behavioral;