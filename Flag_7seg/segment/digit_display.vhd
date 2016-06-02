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
				digit_load : in STD_LOGIC_VECTOR( 1 downto 0);
				EN_display : out STD_LOGIC_VECTOR(3 downto 0));

end digit_display;

architecture Behavioral of digit_display is

begin

	process(clock,reset)

	begin

		if reset='1' then

			EN_display<="0000";					
	
		elsif rising_edge(clock) then

					if digit_load="00" then --unit load
						EN_display<="1110";	--display unit

					elsif digit_load="01" then--decade load
						EN_display<="1101";	--display decade

					elsif digit_load="10" then--hundred load
						EN_display<="1111";	--display no number (no hundred)

					else --thousand load
						EN_display<="1111";	--display no number (no hundred)						
					end if;
	
		end if;

	end process;

end Behavioral;

