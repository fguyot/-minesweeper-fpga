
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;




entity wait100 is
    Port ( 	clock : in  STD_LOGIC;
				ce : in  STD_LOGIC;
				reset : in STD_LOGIC;
				end_wait : out  STD_LOGIC);
end wait100;

architecture Behavioral of wait100 is

signal outTmpSig : integer range 0 to 100 := 0;

begin

process(clock, reset)
begin
	if reset = '1' then
	
		outTmpSig<=0;
		end_wait<='0';

	elsif rising_edge (clock) then

			if ce='1' then

		
				if outTmpSig < 100 then
			
					outTmpSig <= outTmpSig + 1;
					end_wait<='0';
			
				else
			
					outTmpSig<=outTmpSig;
					end_wait<='1';
			
				end if;
			
			end if;
	
	
	end if;

end process;


end Behavioral;

