----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:10:31 05/09/2016 
-- Design Name: 
-- Module Name:    mem_flag_2bits - Behavioral 
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

entity mem_flag_2bits is
    Port ( discover : in  STD_LOGIC;
           flag : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           adress : in  STD_LOGIC_VECTOR (6 downto 0);
           sel : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (3 downto 0));
			  
end mem_flag_2bits;

architecture Behavioral of mem_flag_2bits is



type tab is array(0 to 99) of std_logic_vector(1 downto 0);
signal tableau :tab :=(others=>"00");
signal data_out_tmp : std_logic_vector ( 3 downto 0);


signal sel_tmp : std_logic;


begin

process (clk,rst)

begin

if (rst='1') then

tableau(to_integer(unsigned(adress)))<="00";
		
elsif rising_edge(clk) then

	if discover ='1' then
		tableau(to_integer(unsigned(adress)))<=tableau(to_integer(unsigned(adress))) OR "10";
		sel_tmp <='1';
		data_out_tmp <="0000";


	elsif flag ='1' then
		tableau(to_integer(unsigned(adress)))<=tableau(to_integer(unsigned(adress))) OR "01";
		sel_tmp <='1';
		data_out_tmp <="1111";


	end if;
	
end if;
end process;

end Behavioral;

