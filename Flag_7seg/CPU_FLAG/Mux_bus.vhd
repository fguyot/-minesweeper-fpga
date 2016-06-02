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

entity Mux_bus is
    Port ( 	selection : in STD_LOGIC;
				inputA : in  STD_LOGIC_VECTOR (5 downto 0);
				inputAA : in  STD_LOGIC_VECTOR (7 downto 0);
				inputAAA : in STD_LOGIC;
				inputAAAA : in STD_LOGIC;
				inputB : in  STD_LOGIC_VECTOR (5 downto 0);
				inputBB : in  STD_LOGIC_VECTOR (7 downto 0);
				inputBBB : in STD_LOGIC;
				inputBBBB : in STD_LOGIC;
				output0 : out  STD_LOGIC_VECTOR (5 downto 0);
				output1 : out  STD_LOGIC_VECTOR (7 downto 0);
				output2 : out  STD_LOGIC;
				output3 : out  STD_LOGIC);
end Mux_bus;

architecture Behavioral of Mux_bus is

begin
process(selection,inputA, inputAA,inputB,inputBB)
	begin 
	if selection = '0' then 					
		output0<= inputA;
		output1<= inputAA;
		output2<= inputAAA;
		output3<= inputAAAA;
		
		
	else
		output0 <= inputB;
		output1<= inputBB;
		output2<=inputBBB;
		output3<= inputBBBB;
	end if;
	end process;

end Behavioral;

