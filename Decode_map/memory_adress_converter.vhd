----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:44:51 04/07/2016 
-- Design Name: 
-- Module Name:    memory_adress_converter - Behavioral 
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

entity memory_adress_converter is
    Port ( clk : in  STD_LOGIC;
           c_en : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           line : in  integer;
           column : in  integer;
           adress : out  STD_LOGIC_VECTOR (6 downto 0));
end memory_adress_converter;

architecture Behavioral of memory_adress_converter is

signal sig_out : unsigned(7 downto 0);
constant k: integer:= 10;

begin

process (clk, rst)

	begin

			if (rst = '1') then
			
				sig_out<="00000000";
			elsif rising_edge(clk) then
			
				if (c_en = '1') then
				
					sig_out <=k*to_unsigned(line,4)+to_unsigned(column,4);
					
				else
			
					sig_out<=sig_out;
					
				end if;
			
			else
			
				sig_out<= sig_out;
			
			end if;


	end process;

adress<=std_logic_vector(sig_out(6 downto 0));

end Behavioral;

