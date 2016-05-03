----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:43:28 03/18/2016 
-- Design Name: 
-- Module Name:    RAM64o - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_grid100 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           enable_memory : in  STD_LOGIC;
           read_write : in  STD_LOGIC;
           mem_add : in  STD_LOGIC_VECTOR (6 downto 0);
           data_in : in  STD_LOGIC_VECTOR (5 downto 0);
           --data_out : out  STD_LOGIC_VECTOR (5 downto 0));
			  data_out : out  STD_LOGIC_VECTOR (3 downto 0));
end memory_grid100;

architecture Behavioral of memory_grid100 is

type tab is array(0 to 99) of std_logic_vector(3 downto 0);
signal tableau :tab :=("1001","0010","0011","0100","0101","0110","0111","1000",others=>"1001");
signal data_out_tmp : std_logic_vector ( 3 downto 0);

--init tab




begin

	process (clk,rst)
	
	begin
	
	if rst='1' then
		
		data_out_tmp <= "0000";
		
	elsif falling_edge(clk) then

		
--			if enable_memory='1' then
				data_out_tmp <= tableau(to_integer(unsigned(mem_add)));
--				if read_write='0' then --reading
--	
--					data_out_tmp <= tableau(to_integer(unsigned(mem_add)));
--					
--					
--				else --writting
--					
--					tableau(to_integer(unsigned(mem_add)))<= data_in;
--					data_out_tmp <= tableau(to_integer(unsigned(mem_add)));
--				
--				end if;	
--				
--			else
--				data_out_tmp<=data_out_tmp;
--				
--			end if;
	end if;

	end process;
data_out<=data_out_tmp;

end Behavioral;

