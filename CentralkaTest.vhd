--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:48:38 06/14/2014
-- Design Name:   
-- Module Name:   D:/wbudowane/Centralka/CentralkaTest.vhd
-- Project Name:  Centralka
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Centralka
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
 
ENTITY CentralkaTest IS
END CentralkaTest;
 
ARCHITECTURE behavior OF CentralkaTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Centralka
    PORT(
         clk : IN  std_logic;
         numerM : IN  std_logic_vector(3 downto 0);
         rozmowa_out_domofon : OUT  std_logic;
         rozmowa_in_domofon : IN  std_logic;
         otworz : OUT  std_logic_vector(0 downto 0);
         dzwon_M1 : OUT  std_logic;
         rozmowa_out_M1 : OUT  std_logic;
         rozmowa_in_M1 : IN  std_logic;
         otworz_M1 : IN  std_logic_vector(0 downto 0);
         czyKod : IN  std_logic;
         czyKod_M1 : OUT  std_logic;
         rozmowa_out_M2 : OUT  std_logic;
         rozmowa_in_M2 : IN  std_logic;
         otworz_M2 : IN  std_logic_vector(0 downto 0);
         czyKod_M2 : OUT  std_logic;
         dzwon_M2 : OUT  std_logic;
         odpowiedz_M1 : IN  std_logic;
         odpowiedz_M2 : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal numerM : std_logic_vector(3 downto 0) := (others => '0');
   signal rozmowa_in_domofon : std_logic := '0';
   signal rozmowa_in_M1 : std_logic := '0';
   signal otworz_M1 : std_logic_vector(0 downto 0) := (others => '0');
   signal czyKod : std_logic := '0';
   signal rozmowa_in_M2 : std_logic := '0';
   signal otworz_M2 : std_logic_vector(0 downto 0) := (others => '0');
   signal odpowiedz_M1 : std_logic := '0';
   signal odpowiedz_M2 : std_logic := '0';

 	--Outputs
   signal rozmowa_out_domofon : std_logic;
   signal otworz : std_logic_vector(0 downto 0);
   signal dzwon_M1 : std_logic;
   signal rozmowa_out_M1 : std_logic;
   signal czyKod_M1 : std_logic;
   signal rozmowa_out_M2 : std_logic;
   signal czyKod_M2 : std_logic;
   signal dzwon_M2 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Centralka PORT MAP (
          clk => clk,
          numerM => numerM,
          rozmowa_out_domofon => rozmowa_out_domofon,
          rozmowa_in_domofon => rozmowa_in_domofon,
          otworz => otworz,
          dzwon_M1 => dzwon_M1,
          rozmowa_out_M1 => rozmowa_out_M1,
          rozmowa_in_M1 => rozmowa_in_M1,
          otworz_M1 => otworz_M1,
          czyKod => czyKod,
          czyKod_M1 => czyKod_M1,
          rozmowa_out_M2 => rozmowa_out_M2,
          rozmowa_in_M2 => rozmowa_in_M2,
          otworz_M2 => otworz_M2,
          czyKod_M2 => czyKod_M2,
          dzwon_M2 => dzwon_M2,
          odpowiedz_M1 => odpowiedz_M1,
          odpowiedz_M2 => odpowiedz_M2
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

      czyKod<='0';
		numerM<="0010";
		wait for 100 ns;
		odpowiedz_M2<='1';
		wait for 100 ns;
		czyKod<='0';
		numerM<="0001";
		wait for 100 ns;
		otworz_M2<="1";
		wait for 100 ns;
		rozmowa_in_M1<='1';
		wait for 100 ns;
		rozmowa_in_domofon<='1';
      wait;
   end process;

END;
