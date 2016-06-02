----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:41:10 02/22/2015 
-- Design Name: 
-- Module Name:    flipflop - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flipflop is
    Port ( 	input : in  STD_LOGIC;
		init : in STD_LOGIC;
	        clock : in  STD_LOGIC;
		load : in STD_LOGIC;
           	enable : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
           	output : out  STD_LOGIC);
end flipflop;

architecture Behavioral of flipflop is

signal out_tmp : std_logic;

begin

	process(clock,reset)

	begin

		if reset='1' then

			out_tmp<='0';					-- Reset the data on the D latch to '0'
	
		else

			if rising_edge(clock) then
			
				if enable='1' then

					if init='1' then
						out_tmp<='0';	

					elsif load='1' then
		
						out_tmp<=input;					-- When enabled the date is saved on the intern signal which is affected to the output after
		
					end if;
				end if;

			end if;
	
		end if;

	end process;

output<=out_tmp;

end Behavioral;

