----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:28:40 03/15/2016 
-- Design Name: 
-- Module Name:    compteur - Behavioral 
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

entity wait_and_refresh is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
	   add : out STD_LOGIC_VECTOR(5 downto 0);
           EN_CPU : out  STD_LOGIC;
           rst_CPU : out  STD_LOGIC;
           EN_ext : out  STD_LOGIC);
end wait_and_refresh;

architecture Behavioral of wait_and_refresh is

signal sig_cpt : integer;

begin

process(clk,rst)

begin
	
	if (rst = '1') then
		sig_cpt <= 0;
		rst_CPU <='1';
		EN_CPU<='0';
		EN_ext<='0';
		add<="000000";
		
	elsif (clk'event and clk = '1') then
			
		
			if (sig_cpt<100) then
				sig_cpt <= sig_cpt+1;
				rst_CPU <='0';
				EN_CPU<='1';
				EN_ext<='0';
				add<="000000";

			else
				sig_cpt<=sig_cpt;
				rst_CPU <='0';
				EN_CPU<='0';
				EN_ext<='1';
				add<="000111";
			
			end if;
	end if;
end process;

end Behavioral;

