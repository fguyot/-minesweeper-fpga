----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:59:12 03/21/2016 
-- Design Name: 
-- Module Name:    clignotement - Behavioral 
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

entity clignotement is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           h_cli : in  STD_LOGIC;
           EtatClignotement : out  STD_LOGIC);
end clignotement;

architecture Behavioral of clignotement is

signal sig_in : unsigned(1 downto 0);
signal sig_EtatClignotement : std_logic;

begin

process(clk, rst)	

	begin

		if (rst = '1') then
		sig_in <= "00";
		sig_EtatClignotement<='0';
	
	elsif rising_edge(clk) then
	
	if (h_cli='1') then
		

				if (sig_in="11") then		-- if counter is at 3
				sig_in <= "00";
				sig_EtatClignotement<='0';	--put at zero
				
				else				-- counter of 3 clock enable
				sig_in <= sig_in + 1;
				sig_EtatClignotement<='1';	-- put at one to light
	
				end if;
	else
	sig_EtatClignotement<=sig_EtatClignotement;
	sig_in<=sig_in;
			end if;
		end if;
		
end process;

EtatClignotement <= sig_EtatClignotement;

end Behavioral;

