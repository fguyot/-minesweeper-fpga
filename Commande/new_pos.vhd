----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:04 03/23/2016 
-- Design Name: 
-- Module Name:    modiv_val - Behavioral 
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

entity new_pos is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           inc : in  STD_LOGIC;
           dec : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           sens : out  STD_LOGIC;
           out_pulse : out  STD_LOGIC);
end new_pos;

architecture Behavioral of new_pos is

begin

	process(clk, rst)
	begin

	if rst = '1' then
	
		sens<='0';
		out_pulse<='0';

	elsif rising_edge(clk) then

			if ce='1' then

				if inc='1' then		-- if we detect a increment
					sens<='0';
					out_pulse<='1';
				
				elsif dec='1' then	-- if we detect a decrement
					sens<='1';
					out_pulse<='1';
				else
					sens<='0';
					out_pulse<='0';
				end if;
		
			else
				sens<='0';
				out_pulse<='0';
		
			end if;	
	
	end if;

	end process;
end Behavioral;

