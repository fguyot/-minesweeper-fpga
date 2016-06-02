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

entity compteur is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk_enable : in  STD_LOGIC;
           init_cpt : in  STD_LOGIC;
           load_cpt : in  STD_LOGIC;
           enable_cpt : in  STD_LOGIC;
           instruction : in  STD_LOGIC_VECTOR (5 downto 0);
           next_instruction : out  STD_LOGIC_VECTOR (5 downto 0));
end compteur;

architecture Behavioral of compteur is

signal sig_inst : unsigned(5 downto 0);

begin

process(clk,rst)

begin
	
	if (rst = '1') then
		sig_inst <= "000000";
		
	elsif (clk'event and clk = '1') then
		if(clk_enable = '1') then
		
			if (init_cpt='1') then
			sig_inst <= "000000";

			elsif(load_cpt= '1')then 
			sig_inst <= unsigned(instruction);
				
			elsif (enable_cpt='1') then
				if sig_inst ="111111"then
				sig_inst<="000000";
				else	
				sig_inst <= sig_inst+1;
				end if;
				

			
			end if;
		end if;
	end if;
end process;

next_instruction<=std_logic_vector(sig_inst);

end Behavioral;

