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

entity mux_flag is
   Port ( 	clk				: in STD_LOGIC;
				rst				: in STD_LOGIC;
				bp_discover		: in  STD_LOGIC;
				bp_flag			: in  STD_LOGIC;
				value_decod 	: in  STD_LOGIC_VECTOR(3 downto 0);
				end_disp			: in STD_LOGIC;	
				value_display	: out  STD_LOGIC_VECTOR(3 downto 0);
				en_discover 	: out STD_LOGIC);
end mux_flag ;

architecture Behavioral of mux_flag is

signal pos_tmp, en_discover_tmp : STD_LOGIC;
signal sig_posX, sig_posY,value_display_tmp : STD_LOGIC_VECTOR (3 downto 0);


begin
	
	process(rst,clk)
		begin 
		
		if rst='1' then
			en_discover_tmp<='0';
			value_display_tmp<="0000";
		
		elsif (clk'event and clk = '1') then
			
			if bp_discover ='1' then	--bp discover
			
				value_display_tmp	<=value_decod;
				en_discover_tmp	<='1';

			elsif bp_flag ='1' then		--bp flag discover
				value_display_tmp	<="1010";
				en_discover_tmp 	<='1';

			else
				if end_disp<='0' then --verify if the position change
					value_display_tmp	<=value_display_tmp;
					en_discover_tmp 	<=en_discover_tmp;
				else
					value_display_tmp	<="0000";
					en_discover_tmp 	<='0';
					
				end if;

			end if;
			
		end if;
			

			
	end process;
	
value_display<=value_display_tmp;
en_discover <= en_discover_tmp;

end Behavioral;

