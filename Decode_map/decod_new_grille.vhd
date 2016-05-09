----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:12:28 04/05/2016 
-- Design Name: 
-- Module Name:    decod_new_grille - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decod_new_grille is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           EN : in  STD_LOGIC;
			  
			  l_prev : in  STD_LOGIC_VECTOR (9 downto 0); --register with the previous line
           l_current : in  STD_LOGIC_VECTOR (9 downto 0); --register with the current line
           l_next : in  STD_LOGIC_VECTOR (9 downto 0);	--register with the next line
			  
			  cpt_col : in integer;	--counter col
			  cpt_line : in  integer;	--counter line
			  
			  
           value : out  STD_LOGIC_VECTOR (3 downto 0);	--value to save in the memory
	   raz_cpt_lin : out  STD_LOGIC;	-- reset for the col counter
           raz_cpt_col : out  STD_LOGIC);	-- reset for the col counter
			  
end decod_new_grille;


architecture Behavioral of decod_new_grille is

signal sig_val : unsigned(3 downto 0);

begin

process (clk, rst)

	begin

			if (rst = '1') then

				sig_val<="0000";
				raz_cpt_col<='0';
				raz_cpt_lin<='0';
			elsif rising_edge(clk) then
			
				if EN = '1' then
				
					if l_current(cpt_col)='1' then --if it is a mine
					
						sig_val<="1001";
						
						if cpt_col=9 then
							raz_cpt_col<='1';
			
							if cpt_line=9 then

								raz_cpt_lin<='1';
							else
								raz_cpt_lin<='0';
							
							end if;
						else
							raz_cpt_col<='0';
							
						end if;

					
					else
						---------------------- first line ----------------------
						if cpt_line=0 then		
						
							if cpt_col=0 then	--up and left corner
							
								sig_val<=("000"&l_current(9-cpt_col-1))+("000"&l_next(9-cpt_col-1))+("000"&l_next(9-cpt_col));
								raz_cpt_col<='0';
								raz_cpt_lin<='0';
							
							elsif cpt_col=9 then	--up and right corner
								sig_val<=("000"&l_current(9-cpt_col+1))+("000"&l_next(9-cpt_col))+("000"&l_next(9-cpt_col+1));
								raz_cpt_col<='1';
								raz_cpt_lin<='0';
							
							else	--up line
								sig_val<=("000"&l_current(cpt_col-1))+("000"&l_current(cpt_col+1))+("000"&l_next(cpt_col-1))+("000"&l_next(cpt_col))+("000"&l_next(cpt_col+1));
								raz_cpt_col<='0';
								raz_cpt_lin<='0';
							
							end if;
						
						---------------------- last line ----------------------
						elsif cpt_line=9 then
						
							if cpt_col=0 then	--down and left corner
								sig_val<=("000"&l_current(9-cpt_col-1))+("000"&l_prev(9-cpt_col-1))+("000"&l_prev(9-cpt_col));
								raz_cpt_col<='0';
								raz_cpt_lin<='0';
							
							elsif cpt_col=9 then	--down and right corner
							
								sig_val<=("000"&l_current(9-cpt_col+1))+("000"&l_prev(9-cpt_col))+("000"&l_prev(9-cpt_col+1));
								raz_cpt_col<='1';
								raz_cpt_lin<='1';
							
							else	--down line
								sig_val<=("000"&l_current(cpt_col-1))+("000"&l_current(cpt_col+1))+("000"&l_prev(cpt_col-1))+("000"&l_prev(cpt_col))+("000"&l_prev(cpt_col+1));
								raz_cpt_col<='0';
								raz_cpt_lin<='0';
							
							end if;
						
						--------------------- middle of the matrix ----------------------
						else
						
							if cpt_col=0 then	--left case
							
								sig_val<=("000"&l_current(9-cpt_col-1))+("000"&l_prev(9-cpt_col-1))+("000"&l_prev(9-cpt_col))+("000"&l_next(9-cpt_col-1))+("000"&l_next(9-cpt_col));
								raz_cpt_col<='0';
								raz_cpt_lin<='0';
							
						  elsif cpt_col=9 then	--right case
							
								sig_val<=("000"&l_current(9-cpt_col+1))+("000"&l_prev(9-cpt_col))+("000"&l_prev(9-cpt_col+1))+("000"&l_next(9-cpt_col))+("000"&l_next(9-cpt_col+1));
								raz_cpt_col<='1';
								raz_cpt_lin<='0';
							
							
							else
						
								sig_val<=("000"&l_current(cpt_col-1))+("000"&l_current(cpt_col+1))+("000"&l_prev(cpt_col-1))+("000"&l_prev(cpt_col))+("000"&l_prev(cpt_col+1))+("000"&l_next(cpt_col-1))+("000"&l_next(cpt_col))+("000"&l_next(cpt_col+1));
								raz_cpt_col<='0';
								raz_cpt_lin<='0';
							
							end if;
						
						
						end if;
					
					end if;
					
				end if;
				
			end if;	
			
	end process;
	
	value <= STD_LOGIC_VECTOR(sig_val);
	
end Behavioral;

