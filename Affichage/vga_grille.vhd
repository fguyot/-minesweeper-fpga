----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:36:03 03/25/2016 
-- Design Name: 
-- Module Name:    vga_grille - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_grille is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  en : in  STD_LOGIC;
			  line : in  STD_LOGIC_VECTOR (3 downto 0);
			  col : in  STD_LOGIC_VECTOR (3 downto 0);
			  end_bloc : out STD_LOGIC;
           ADDR : out  STD_LOGIC_VECTOR (13 downto 0);
           data_in : out  STD_LOGIC_VECTOR (2 downto 0);
           data_write : out  STD_LOGIC);
			  
end vga_grille;

architecture Behavioral of vga_grille is




constant h: integer :=1310;
constant v: integer :=1600;
constant k: integer := 10;

signal sig_ADDR1 : STD_LOGIC_VECTOR (13 downto 0);
signal sig_ADDR2 : STD_LOGIC_VECTOR (13 downto 0);
signal sig_pos : integer;
signal sig_cpt1 : integer range 0 to 15999 := 0;
signal sig_cpt2 : integer range 0 to 15999 := 0;
signal sig_data_in1 : STD_LOGIC_VECTOR (2 downto 0) ;
signal sig_data_in2 : STD_LOGIC_VECTOR (2 downto 0);
signal sig_data_write1 : STD_LOGIC;
signal sig_data_write2 : STD_LOGIC;

begin

process(clk, rst)	

	begin
		if rst = '1' then				-- Init
			sig_data_in1 <= "000";
			sig_data_write1 <= '0';
			sig_ADDR1<= (others =>'0');
			sig_cpt1 <= 0;
			
		elsif rising_edge(clk) then
			if sig_cpt1 >= 15999 then -- Compteur parcourant tous les pixels
				sig_cpt1 <= 0;
			else
				sig_cpt1 <= sig_cpt1 + 1;
				
			end if;
			
		
-----------------Trace la grille------------
			
			if ( (sig_cpt1 >= 1470 AND sig_cpt1 <= 1570) OR (sig_cpt1 >= 3070 AND sig_cpt1 <= 3170) OR (sig_cpt1 >= 4670 AND sig_cpt1 <= 4770) OR (sig_cpt1 >= 6270 AND sig_cpt1 <= 6370)OR(sig_cpt1 >= 7870 AND sig_cpt1 <=7970)OR (sig_cpt1 >= 9470 AND sig_cpt1 <= 9570) OR (sig_cpt1 >= 11070 AND sig_cpt1 <= 11170) OR (sig_cpt1 >= 12670 AND sig_cpt1 <= 12770) OR  (sig_cpt1 >= 14270 AND sig_cpt1 <= 14370)  ) then
				sig_ADDR1 <= std_logic_vector(to_unsigned(sig_cpt1,14));-- trace les lignes
				sig_data_in1 <= "001"; -- bleu
				sig_data_write1 <= '1';
				
				
			elsif( (sig_cpt1 >= 30 AND sig_cpt1 <= 15869) AND (((sig_cpt1 MOD 160) = 30) OR ((sig_cpt1 MOD 160) = 40) OR ((sig_cpt1 MOD 160) = 50) OR ((sig_cpt1 MOD 160) = 60) OR ((sig_cpt1 MOD 160) = 70) OR ((sig_cpt1 MOD 160) = 80) OR ((sig_cpt1 MOD 160) = 90) OR ((sig_cpt1 MOD 160) = 100) OR ((sig_cpt1 MOD 160) = 110) OR ((sig_cpt1 MOD 160) = 120) OR ((sig_cpt1 MOD 160) = 130))) then 
				sig_ADDR1 <= std_logic_vector(to_unsigned(sig_cpt1,14));
				sig_data_in1 <= "001"; -- bleu
				sig_data_write1 <= '1';
			
			else 
			sig_ADDR1<=(others =>'0');
			sig_data_in1<="000";
			sig_data_write1<='0';

			
			end if;	

			
		end if;
		
	
	
end process;




process(clk, rst)	

	begin
		if rst = '1' then				-- Init
			sig_data_in2 <= "000";
			sig_data_write2 <= '0';
			sig_ADDR2 <= (others =>'0');
			sig_cpt2<=0;
			end_bloc <= '0';
			
		elsif rising_edge(clk) then
		
		sig_pos<= h  + to_integer(unsigned(col))*k + to_integer(unsigned(line)) * v + 1; 
		
		if sig_cpt2 >= 15999 then -- Compteur parcourant tous les pixels
				sig_cpt2 <= 0;
			else
				sig_cpt2 <= sig_cpt2 + 1;
				
			end if;
		

				if sig_pos=sig_cpt2 then
					
					end_bloc <= '0';
					sig_data_in2 <= "100"; --rouge
					sig_data_write2 <= '1';
					sig_ADDR2<=std_logic_vector(to_unsigned(sig_pos,14));
				
				elsif ((sig_cpt2 >= 30 AND sig_cpt2 <= 15869) AND (((sig_cpt2 MOD 1600) = 1311) OR ((sig_cpt2 MOD 1600) = 1321) OR ((sig_cpt2 MOD 1600) = 1331) OR ((sig_cpt2 MOD 1600) = 1341) OR ((sig_cpt2 MOD 1600) = 1351) OR ((sig_cpt2 MOD 1600) = 1361) OR ((sig_cpt2 MOD 1600) = 1371) OR ((sig_cpt2 MOD 1600) = 1381) OR ((sig_cpt2 MOD 1600) = 1391) OR ((sig_cpt2 MOD 1600) = 1401))) then
				sig_ADDR2 <= std_logic_vector(to_unsigned(sig_cpt2,14));-- trace les lignes
				sig_data_in2 <= "001"; -- bleu
				sig_data_write2 <= '1';
				
				else
					end_bloc <= '0';
					sig_data_in2 <= "000"; --noir
					sig_data_write2 <= '0';
					sig_ADDR2<=(others =>'0');
					
				end if;
				
			

			
end if;

end process;

--ADDR <= sig_ADDR1;
--data_in <= sig_data_in1;
--data_write <= sig_data_write1;

ADDR <= sig_ADDR1 OR sig_ADDR2;
data_in <= sig_data_in1 OR sig_data_in2;
data_write <= sig_data_write1 OR sig_data_write2;


		
end Behavioral;

