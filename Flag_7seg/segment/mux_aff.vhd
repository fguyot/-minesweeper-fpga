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

entity mux_aff is
    Port ( 	selection : in STD_LOGIC_VECTOR (1 downto 0);
		inputA : in  STD_LOGIC_VECTOR (3 downto 0);
		inputB : in  STD_LOGIC_VECTOR (3 downto 0);
		inputC : in  STD_LOGIC_VECTOR (3 downto 0);
		inputD : in  STD_LOGIC_VECTOR (3 downto 0);
		output : out  STD_LOGIC_VECTOR (3 downto 0));
end mux_aff;

architecture Behavioral of mux_aff is

begin
	process(selection,inputA,inputB)
		begin 
		if selection = "00" then 	--unit in output				
			output<= inputA;
		elsif selection = "01" then 	--decade in output				
			output<= inputB;
		elsif selection = "10" then 	--hundred in output				
			output<= inputC;
		else 
			output <= inputD;-- thousand in output
		end if;
	end process;

end Behavioral;

