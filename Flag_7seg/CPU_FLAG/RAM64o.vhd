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

entity RAM64o is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           enable_memory : in  STD_LOGIC;
           read_write : in  STD_LOGIC;
           mem_add : in  STD_LOGIC_VECTOR (5 downto 0);
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end RAM64o;

architecture Behavioral of RAM64o is

type tab is array(0 to 63) of std_logic_vector(7 downto 0);
signal tableau :tab :=(x"0C",x"C6",x"4D",x"4E",x"8E",x"CA",x"4C",x"4E",x"8E",x"CA",x"CA",x"00",x"FF",x"01",x"0F",others=>"00000000");
signal data_out_tmp : std_logic_vector ( 7 downto 0);

--init tab




begin

	process (clk,rst)
	
	begin
	
	if rst='1' then
		
		data_out_tmp <= "00000000";
		
	elsif falling_edge(clk) then
		
			if enable_memory='1' then
	
				if read_write='0' then --reading
	
					data_out_tmp <= tableau(to_integer(unsigned(mem_add)));
					
				else --writting
					
					tableau(to_integer(unsigned(mem_add)))<= data_in;
					data_out_tmp <= tableau(to_integer(unsigned(mem_add)));
				
				end if;	
				
			else
				data_out_tmp<=data_out_tmp;
				
			end if;
			
	end if;

	end process;
data_out<=data_out_tmp;

end Behavioral;

