----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:42:31 03/10/2015 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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


--use UNISIM.VComponents.all;

entity mux_data_out is
   Port ( 	
		selection : in STD_LOGIC;
		input_data_mem_2bits: in  STD_LOGIC_VECTOR (3 downto 0);
		input_mem_grid: in  STD_LOGIC_VECTOR (3 downto 0);
		output_data_out : out  STD_LOGIC_VECTOR (3 downto 0));
		
end mux_data_out ;

architecture Behavioral of mux_data_out is




begin
	process(selection,input_data_mem_2bits,input_mem_grid)
	
		begin
		
		if selection = '1' then 	--first	register			
			output_data_out<= input_data_mem_2bits;


		else
			
			output_data_out<= input_mem_grid;

		end if;
		
	end process;



end Behavioral;

