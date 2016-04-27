----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:52:53 03/22/2015 
-- Design Name: 
-- Module Name:    anti_bounding - Behavioral 
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

entity anti_bounding is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           output : out  STD_LOGIC);
end anti_bounding;

architecture Behavioral of anti_bounding is

signal count : unsigned (24 downto 0);
signal ok : std_logic;

begin

process(clock, reset)
begin

	if reset = '1' then

		count<=(others => '0');
		ok<='0';
	
	elsif rising_edge (clock) then
	
		if enable ='1' then	--if button pressed

			if count < 500000 then	--wait 250ms
		
			
				count<=count + 1 ;
				ok<='1';
			
			else
				ok<='1';
				count<=(others => '0');
			
			end if;
		
		else 
			
			if count < 500000 then   -- not 5ms 
			
				if count = 0 then  --stop_pressing 
					count<=(others => '0');
					ok<='0';	
					
				else -- if button was press
					count<=count + 1 ;
					ok<='1';
					
				end if;
			
			else
				
				count<=(others => '0');
				ok<='0';			
			end if;
			
		end if;

	end if;

	
end process;

output<=ok;

end Behavioral;

