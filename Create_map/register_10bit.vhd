library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_10bit_stat is
    Port ( input : in  STD_LOGIC_VECTOR (9 downto 0);          
           clock : in  STD_LOGIC;
		--load : in STD_LOGIC;
           --ce : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (9 downto 0));
end register_10bit_stat;

architecture Behavioral of register_10bit_stat is

signal out_tmp : std_logic_vector ( 9 downto 0);

begin

	process(clock,reset)

	begin

		if reset='1' then	-- Reset the data

			out_tmp<="0000000000";				
	
		elsif rising_edge(clock) then

					
			out_tmp<=input;			-- When we want to load the data

		end if;

	end process;

output<=out_tmp;

end Behavioral;

