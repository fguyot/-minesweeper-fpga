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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_graph_mem is
    Port ( 	selection : in STD_LOGIC_VECTOR(3 downto 0);
		input0: in  STD_LOGIC_VECTOR (8 downto 0);
		input1: in  STD_LOGIC_VECTOR (8 downto 0);
		input2 : in  STD_LOGIC_VECTOR (8 downto 0);
		input3 : in  STD_LOGIC_VECTOR(8 downto 0);
		input4: in  STD_LOGIC_VECTOR (8 downto 0);
		input5 : in  STD_LOGIC_VECTOR (8 downto 0);
		input6 : in  STD_LOGIC_VECTOR(8 downto 0);
		input7: in  STD_LOGIC_VECTOR (8 downto 0);
		input8 : in  STD_LOGIC_VECTOR (8 downto 0);
		input9 : in  STD_LOGIC_VECTOR(8 downto 0);
		input10: in  STD_LOGIC_VECTOR (8 downto 0);

		output : out  STD_LOGIC_VECTOR (8 downto 0));
end mux_graph_mem;

architecture Behavioral of mux_graph_mem is

begin
	process(selection,input1,input2,input3,input4,input5,input6,input7,input8,input9,input10)
		begin 
		if selection = "0000" then 	--first	register			
			output<= input0;

		elsif selection = "0001" then	--2nd	register
			output<= input1; 

		elsif selection = "0010" then	--3th	register
			output<= input2; 


		elsif selection = "0011" then	--4th	register
			output<= input3; 


		elsif selection = "0100" then	--5th	register
			output<= input4; 

		elsif selection = "0101" then	--6th	register
			output<= input5; 

		elsif selection = "0110" then	--7th	register
			output<= input6; 


		elsif selection = "0111" then	--8nd	register
			output<= input7; 


		elsif selection = "1000" then	--9nd	register
			output<= input8; 

		elsif selection = "1001" then	--8nd	register
			output<= input9; 

		else 
			output <= input10;-- 10th register
		end if;
	end process;

end Behavioral;

