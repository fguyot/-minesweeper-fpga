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

entity bp_pulse is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           bp : in  STD_LOGIC;
           output : out  STD_LOGIC);
end bp_pulse;

architecture Behavioral of bp_pulse is

signal count : unsigned (18 downto 0);
signal lock : std_logic;

begin

process(clock, reset)
begin

	if reset = '1' then

		count<=(others => '0');
		lock<='0';
		output<='0';
	
	elsif rising_edge (clock) then
	
		if bp ='1' AND lock='0' then	--if button pressed

			if count < 500000 then	--wait to avoid bounding
		
				count<=count+1;
				lock<='0';
				output<='0';
			else
				count<=count;
				lock<='1';
				output<='1';
			
			end if;
		
		elsif bp='0' AND lock='1' then
			
				count<=(others => '0');
				lock<='0';
				output<='0';
			
		else

				count<=count;
				lock<=lock;
				output<='0';
				
		end if;

	end if;

	
end process;

end Behavioral;

