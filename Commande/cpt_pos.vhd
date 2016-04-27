----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:33:50 03/16/2016 
-- Design Name: 
-- Module Name:    Compteur_unit - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpt_pos is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           incdec_en : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           pos : out  STD_LOGIC_VECTOR (3 downto 0));
end cpt_pos;

architecture Behavioral of cpt_pos is

signal sig_in : unsigned(3 downto 0);

begin

process(clk, rst)	

	begin

		if (rst = '1') then
		sig_in <= "0000";
		
		elsif rising_edge(clk) then
		
				if (incdec_en = '1') then	-- if we have a signal on the button
					
					if (up_down='0') then	-- if it is a increment
						if (sig_in = "1001") then	--if we are at 9 
						sig_in <= "0000";		--go back to 0
						else
						sig_in <= sig_in + 1;
					
					end if;
					
					elsif (up_down='1') then	-- if it is an decrement
					
						if (sig_in = "0000") then	-- if we are at 0
						sig_in <= "1001";		-- go back to 9
						else
						sig_in <= sig_in - 1;
						end if;
					end if;
				end if;
		end if;
		
end process;
		
	pos <= std_logic_vector (sig_in);
	
end Behavioral;
		
		
