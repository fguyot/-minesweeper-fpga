library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity graph_mem_0 is
    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in  STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
end graph_mem_0;

architecture Behavioral of graph_mem_0 is

constant line1_cst: std_logic_vector ( 8 downto 0):= "000000000";
constant line2_cst: std_logic_vector ( 8 downto 0):= "000000000";
constant line3_cst: std_logic_vector ( 8 downto 0):= "000000000";
constant line4_cst: std_logic_vector ( 8 downto 0):= "000000000";
constant line5_cst: std_logic_vector ( 8 downto 0):= "000000000";
constant line6_cst: std_logic_vector ( 8 downto 0):= "000000000";
constant line7_cst: std_logic_vector ( 8 downto 0):= "000000000";
constant line8_cst: std_logic_vector ( 8 downto 0):= "000000000";
constant line9_cst: std_logic_vector ( 8 downto 0):= "000000000";

signal output_tmp : std_logic_vector(8 downto 0);

begin

	process(clk, rst)
		begin
		
			if (rst = '1') then
				output_tmp<=(others => '0');
				
			elsif rising_edge(clk) then
				
				if en='1' then

					if add="0000" then
						output_tmp<=line1_cst;
					elsif add="0001" then
						output_tmp<=line2_cst;
					elsif add="0010" then
						output_tmp<=line3_cst;
					elsif add="0011" then
						output_tmp<=line4_cst;
					elsif add="0100" then
						output_tmp<=line5_cst;
					elsif add="0101" then
						output_tmp<=line6_cst;
					elsif add="0110" then
						output_tmp<=line7_cst;
					elsif add="0111" then
						output_tmp<=line8_cst;
					elsif add="1000" then
						output_tmp<=line9_cst;
					else
						output_tmp<=(others => '0');

					end if;
				else

					output_tmp<=output_tmp;

				end if;
				
			end if;
	
	end process;

output<=output_tmp;

end Behavioral;

