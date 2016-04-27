
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;




entity counter100 is
    Port ( clock : in  STD_LOGIC;
           ce : in  STD_LOGIC;
	   load : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           counterOut : out  STD_LOGIC_VECTOR (6 downto 0));
end counter100;

architecture Behavioral of counter100 is

signal outTmpSig : unsigned (6 downto 0);

begin

process(clock, reset)
begin

if rising_edge (clock) then

	if reset = '1' then
	
	outTmpSig<=(others => '0');
	
	else

		if ce='1' then

			if load='1' then
		
				if outTmpSig < 100 then
			
					outTmpSig <= outTmpSig + 1;
			
				else
			
					outTmpSig<=outTmpSig;
			
				end if;
			else
		
				outTmpSig <= outTmpSig ;
		
			end if;
		
		else
		
			outTmpSig <= outTmpSig ;
		
		end if;
		
	end if;
	
	
end if;

end process;

counterOut <= STD_LOGIC_VECTOR(outTmpSig);

end Behavioral;

