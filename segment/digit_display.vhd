----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:41:10 02/22/2015 
-- Design Name: 
-- Module Name:    digit_display - Behavioral 
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

entity digit_display is
    Port ( 	clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				digit_load : in STD_LOGIC_VECTOR(1 downto 0);
				unit_flash : in STD_LOGIC;
				decade_flash : in STD_LOGIC;
				hundred_flash : in STD_LOGIC;
				flash_state : in STD_LOGIC;
				unit_display : out STD_LOGIC;
				decade_display :out STD_LOGIC;
				hundred_display : out STD_LOGIC);

end digit_display;

architecture Behavioral of digit_display is

begin

	process(clock,reset)

	begin

		if reset='1' then

			unit_display<='0';
			decade_display<='0';					
			hundred_display<='0';
	
		elsif rising_edge(clock) then

					if digit_load="00" then --unit load
						decade_display<='1';					
						hundred_display<='1';

						if flash_state='0' then	 -- flash display
							if unit_flash='0' then	--flash on unit
								unit_display<='0'; -- power on unit display
							else
								unit_display<='1'; -- power off unit display 
							end if;
						else
							unit_display<='0'; -- power on unit display
						end if;

					elsif digit_load="01" then -- decade load
						unit_display<='1';					
						hundred_display<='1';

						if flash_state='0' then	 -- flash display
							if decade_flash='0' then	--flash on unit
								decade_display<='0'; -- power on decade display
							else
								decade_display<='1'; -- power off decade display 
							end if;
						else
							decade_display<='0'; -- power on decade display
						end if;

					elsif digit_load="10" then --hundred load
						unit_display<='1';
						decade_display<='1';

						if flash_state='0' then	 -- flash display
							if hundred_flash='0' then	--flash on unit
								hundred_display<='0'; -- power on hundred display
							else
								hundred_display<='1'; -- power on hundred display 
							end if;
						else
							hundred_display<='0'; -- power on hundred display
						end if;	

					else -- wrong load digit
						unit_display<='1';
						decade_display<='1';					
						hundred_display<='1';				
						

					end if;
	
		end if;

	end process;

end Behavioral;

