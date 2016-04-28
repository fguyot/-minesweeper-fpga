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

entity mux_memory is
   Port ( 	selection : in STD_LOGIC;
		input_data_in_decode: in  STD_LOGIC_VECTOR (6 downto 0);
		
		input_addr_pos: in  STD_LOGIC_VECTOR (5 downto 0);
		input_addr_decode : in  STD_LOGIC_VECTOR (5 downto 0);

		input_write_decode : in  STD_LOGIC;
		input_enable_memory_decode : in  STD_LOGIC;
		
		output_data_in : out  STD_LOGIC_VECTOR (6 downto 0);
		output_addr : out  STD_LOGIC_VECTOR (5 downto 0);
		output_write: out  STD_LOGIC;
		output_enable_memory: out STD_LOGIC);
end mux_memory ;

architecture Behavioral of mux_memory is

signal output_data_tmp : STD_LOGIC_VECTOR(6 downto 0);
signal output_addr_tmp : STD_LOGIC_VECTOR(5 downto 0);
signal output_write_tmp, output_enable_memory_tmp : STD_LOGIC;

begin
	process(selection,input_data_in_decode,input_addr_decode,input_write_decode,input_enable_memory_decode,input_addr_decode)
		begin 
		if selection = '0' then 	--first	register			
			output_data_tmp <= input_data_in_decode;
			output_addr_tmp <=input_addr_decode;
			output_write_tmp <=input_write_decode;
			output_enable_memory_tmp <=input_enable_memory_decode ;

		else
			output_data_tmp <= "0000000";
			output_addr_tmp <=input_addr_decode;
			output_write_tmp <='0';
			output_enable_memory_tmp <='1';

		end if;
	end process;

	output_data_in <= output_data_tmp;
	output_addr <= output_addr_tmp;
	output_write <= output_write_tmp;
	output_enable_memory <= output_enable_memory_tmp;

end Behavioral;

