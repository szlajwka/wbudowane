--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:23:58 06/14/2014
-- Design Name:   
-- Module Name:   D:/Programowanie/SystemyWbudowane/test/domofon6/domofon_test.vhd
-- Project Name:  domofon6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: domofon
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY domofon_test IS
END domofon_test;
 
ARCHITECTURE behavior OF domofon_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT domofon
    PORT(
         clk : IN  std_logic;
         admin : IN  std_logic;
         flatNo : IN  std_logic_vector(3 downto 0);
         code : IN  std_logic_vector(3 downto 0);
         door : OUT  std_logic;
         out_flatNo : OUT  std_logic_vector(3 downto 0);
         out_isOpened : OUT  std_logic;
         in_openRequest : IN  std_logic;
         talk_in : IN  std_logic;
         talk_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal admin : std_logic := '0';
   signal flatNo : std_logic_vector(3 downto 0) := (others => '0');
   signal code : std_logic_vector(3 downto 0) := (others => '0');
   signal in_openRequest : std_logic := '0';
   signal talk_in : std_logic := '0';

 	--Outputs
   signal door : std_logic;
   signal out_flatNo : std_logic_vector(3 downto 0);
   signal out_isOpened : std_logic;
   signal talk_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: domofon PORT MAP (
          clk => clk,
          admin => admin,
          flatNo => flatNo,
          code => code,
          door => door,
          out_flatNo => out_flatNo,
          out_isOpened => out_isOpened,
          in_openRequest => in_openRequest,
          talk_in => talk_in,
          talk_out => talk_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		
		-- 1
		admin<='0';
		flatNo <= "0001";	
		code <= "1011"; -- zly kod miszkania pierwszego
		in_openRequest <='0';
		
		wait for clk_period*10;
		if door = '0' and out_flatNo = "0000" and out_isOpened ='0'  then
				assert true report "OK 1!";
		else
			assert false report "Blad 1!";
		end if;
		wait for clk_period*10;
		
		-- 2
		flatNo <= "0001";	
		code <= "1010"; -- dobry kod miszkania pierwszego	
		in_openRequest <='0';
		admin<='0';
		
		wait for clk_period*10;
		if door = '1' and out_flatNo = "0001" and out_isOpened ='1'  then
			assert true report "OK 2!";
		else
			assert false report "Blad 2!";
		end if;
		wait for clk_period*10;
		
		-- 3
		admin<='1'; -- wlaczamy tryb administratora
		flatNo <= "0001";	
		code <= "1111"; -- ustawiamy kod mieszkania 1 na 1111
		in_openRequest <='0';
		
		wait for clk_period*10;
		admin<='0'; -- wylaczamy tryb administratora
		wait for clk_period*10;
		
		-- 4
		flatNo <= "0001";	
		code <= "1010"; -- kod mieszkania ktory wczesniej byl dobry (teraz powinien  byc zly)
		in_openRequest <='0';
		admin<='0';
		
		wait for clk_period*10;
		if door = '0' and out_flatNo = "0000" and out_isOpened ='0'  then
				assert true report "OK 4!";
		else
			assert false report "Blad 4!";
		end if;
		wait for clk_period*10;
		
		--5
		flatNo <= "0001";	
		code <= "1111"; -- nowy kod do mieszkania
		in_openRequest <='0';
		admin<='0';
		
		wait for clk_period*10;
		if door = '1' and out_flatNo = "0001" and out_isOpened ='1'  then
			assert true report "OK 5!";
		else
			assert false report "Blad 5!";
		end if;
		wait for clk_period*10;
		
		-- 6 --ktos z gory otwiera dzwi na dole
		in_openRequest <="1";
		admin<='0'; --bez znaczenia
		flatNo <= "0110";	-- bez znaczenia 
		code <= "1000"; -- bez znaczenia
		wait for clk_period*10;
		if door = '1' and out_flatNo = "0000" and out_isOpened ='0'  then
			assert true report "OK 6!";
		else
			assert false report "Blad 6!";
		end if;
		wait for clk_period*10;
		
		-- 7 -- ktos dzwoni domofonem
		in_openRequest <='0';
		admin<='0';
		flatNo <= "0010";	
		code <= "0000";
		
		wait for clk_period*10;
		if door = '0' and out_flatNo = "0010" and out_isOpened ='0'  then
			assert true report "OK 6!";
		else
			assert false report "Blad 6!";
		end if;
		wait for clk_period*10;		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		


      wait;
   end process;

END;
