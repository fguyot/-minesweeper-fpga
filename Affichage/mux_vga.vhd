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

entity mux_vga is
    Port ( 	selection : in STD_LOGIC;
		input_data_in_1: in  STD_LOGIC_VECTOR (2 downto 0);
		input_data_in_2 : in  STD_LOGIC_VECTOR (2 downto 0);
		input_addr_1: in  STD_LOGIC_VECTOR (13 downto 0);
		input_addr_2 : in  STD_LOGIC_VECTOR (13 downto 0);
		input_write_1: in  STD_LOGIC;
		input_write_2 : in  STD_LOGIC;
		
		output_data_in : out  STD_LOGIC_VECTOR (2 downto 0);
		output_addr : out  STD_LOGIC_VECTOR (13 downto 0);
		output_write: out  STD_LOGIC);
end mux_vga ;

architecture Behavioral of mux_vga is

begin
	process(selection,input_data_in_1,input_data_in_2,input_addr_1,input_addr_2,input_write_1,input_write_2)
		begin 
		if selection = '0' then 	--first	register			
			output_data_in<= input_data_in_1;
			output_addr <=input_addr_1;
			output_write<=input_write_1;

		else
			output_data_in<= input_data_in_2;
			output_addr <=input_addr_2;
			output_write<=input_write_2;

		end if;
	end process;

end Behavioral;

