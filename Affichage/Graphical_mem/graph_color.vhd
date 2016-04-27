library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity graph_color is
    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				value : in  STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (2 downto 0));
end graph_color;

architecture Behavioral of graph_color is


signal output_tmp : std_logic_vector(2 downto 0);

begin

	process(clk, rst)
		begin
		
			if (rst = '1') then

				output_tmp<="111";
				
			elsif rising_edge(clk) then
				
				if en='1' then

					if value="0000" then
						output_tmp<="001";
					elsif value="0001" then
						output_tmp<="010";
					elsif value="0010" then
						output_tmp<="011";
					elsif value="0011" then
						output_tmp<="100";
					elsif value="0100" then
						output_tmp<="101";
					elsif value="0101" then
						output_tmp<="110";
					elsif value="0110" then
						output_tmp<="001";
					elsif value="0111" then
						output_tmp<="010";
					elsif value="1000" then
						output_tmp<="011";
					else
						output_tmp<="010";

					end if;
				else

					output_tmp<=output_tmp;

				end if;
				
			end if;
	
	end process;

output<=output_tmp;

end Behavioral;

