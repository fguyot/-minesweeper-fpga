----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:53 02/11/2015 
-- Design Name: 
-- Module Name:    decod - decodeur 
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

entity transdecoder is
    Port ( data: in  STD_LOGIC_VECTOR (3 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0));
end transdecoder;

architecture decodeur of transdecoder is

begin

process (data)

 begin
										-- Convert the number in input in a 7bit data to display it

	if data = "0000" then 
		seg<= "0000001";			-- 0
		
	elsif data = "0001" then
		seg<= "1001111"; 			-- 1

	elsif data = "0010" then
		seg<= "0010010"; 			-- 2
		
	elsif data = "0011" then
		seg<= "0000110"; 			-- 3
		
	elsif data = "0100" then
		seg<= "1001100";			-- 4
		
	elsif data = "0101" then
		seg<= "0100100"; 			-- 5
		
	elsif data = "0110" then
		seg<= "0100000"; 			-- 6
		
	elsif data = "0111" then
		seg<= "0001111"; 			-- 7
		
	elsif data = "1000" then
		seg<= "0000000"; 			-- 8
		
	elsif data = "1001" then
		seg<= "0000100"; 			-- 9
	
	else
		seg<= "0100101"; 			-- Set the seven segments display to an position which not correponds with any number to debug
	

 end if;
end process;
	
end decodeur;

