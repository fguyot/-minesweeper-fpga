----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:33:10 02/11/2015 
-- Design Name: 
-- Module Name:    converter_bit_into_unit_decade - Behavioral 
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
use ieee.std_logic_unsigned.all ; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity converter_vector_into_digit is

    Port ( number_in : in  STD_LOGIC_VECTOR (5 downto 0);
           unit : out  STD_LOGIC_VECTOR (3 downto 0);
           decade : out  STD_LOGIC_VECTOR (3 downto 0);
				hundred : out STD_LOGIC_VECTOR (3 downto 0);
				thousand : out STD_LOGIC_VECTOR (3 downto 0));
			  
end converter_vector_into_digit;

architecture Behavioral of converter_vector_into_digit is

signal unit_tmp : std_logic_vector(7 downto 0);	--signal before cast

begin

process(number_in)
	
	begin


	if number_in<"00001010" then	-- inferior to 10
--		unit<= '0'&number_in(2) & number_in(1) & number_in(0

			unit_tmp<=number_in; -- in - 10
		decade<="0000";
	elsif number_in< "00010100" then -- inferior to 20
		
			unit_tmp<=number_in - "00001010"; -- in - 10
			decade<="0001";
			
	elsif number_in<"00011110" then -- inferior to 30
		
			unit_tmp<=number_in - "00010100";	-- in - 20
			decade<="0010";
		
	elsif number_in<"00101000" then -- inferior to 40
			
			unit_tmp<=number_in - "00101000";-- in - 30
			decade<="0011";
		

	elsif number_in<"00110010" then -- inferior to 50
			
			unit_tmp<=number_in - "011110";-- in - 30
			decade<="0100";


	elsif number_in<"00111100" then -- inferior to 60
			
			unit_tmp<=number_in - "00110010";-- in - 50
			decade<="00101";

	elsif number_in<"01000110" then -- inferior to 70
			
			unit_tmp<=number_in - "00111100";-- in - 60
			decade<="0110";

	elsif number_in<"01010000" then -- inferior to 80
			
			unit_tmp<=number_in - "01000110";-- in - 70
			decade<="0111";

	elsif number_in<"01011010" then -- inferior to 90
			
			unit_tmp<=number_in - "01010000";-- in - 80
			decade<="1000";


	else-- supperior to 90
		
		unit_tmp<=number_in-"01011010";	-- in - 90
		decade<="1001";
		
	end if;

					

end process;

unit <= unit_tmp(3 downto 0);
hundred <= "0000";
thousand<="0000";

end Behavioral;

