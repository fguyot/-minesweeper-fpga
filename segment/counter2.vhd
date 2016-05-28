----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:10:08 02/04/2015 
-- Design Name: 
-- Module Name:    counter2 - Behavioral 
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

entity counter2 is
    Port ( 	clk : in  STD_LOGIC;
       	   	c_enable : in  STD_LOGIC;
		rst : in STD_LOGIC;
           	output : out  STD_LOGIC_VECTOR (1 downto 0));
end counter2;

architecture Behavioral of counter2 is

signal outTmpSig : unsigned (1 downto 0);

begin

	process(clk, rst)
	begin

	if rst = '1' then
	
		outTmpSig<="00";

	else

		if rising_edge(clk) then

			if c_enable='1' then

				if outTmpSig < 2 then
			
					outTmpSig <= outTmpSig + 1;
			
				else
			
					outTmpSig<="00"; -- Reset when Counter overflow 2
			
				end if;
		
			else
		
				outTmpSig <= outTmpSig ;
		
			end if;
		
		end if;
	
	
	end if;

	end process;

output <= STD_LOGIC_VECTOR(outTmpSig);

end Behavioral;

