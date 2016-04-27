
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;




entity counter9_STD is
    Port ( clk : in  STD_LOGIC;
           ce : in  STD_LOGIC;
	   rst : in STD_LOGIC;
           counterOut : out  STD_LOGIC_VECTOR(3 downto 0));
end counter9_STD;

architecture Behavioral of counter9_STD is

signal outTmpSig : unsigned (3 downto 0);

begin

	process(clk, rst)
		begin
		
			if (rst = '1') then

				outTmpSig<=(others => '0');
				
			elsif rising_edge(clk) then

				if ce='1' then
				
					outTmpSig <= outTmpSig + 1;
					
				else
				
					outTmpSig<=outTmpSig;
				end if;
			
			end if;
	end process;

counterOut <=  STD_LOGIC_VECTOR(outTmpSig);

end Behavioral;

