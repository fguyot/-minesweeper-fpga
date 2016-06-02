----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:29:21 03/15/2016 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
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

entity UAL is
    Port ( sel_UAL : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (7 downto 0);
           accu : in  STD_LOGIC_VECTOR (7 downto 0);
           carry : out  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (7 downto 0));
end UAL;

architecture Behavioral of UAL is

signal sig_res : UNSIGNED (8 downto 0);



begin

process(sel_UAL,data,accu)

begin

	if  (sel_UAL='0') then
		sig_res <= (resize(unsigned(data),9) NOR resize(unsigned(accu),9));
		sig_res(8)<='0';
		
	else
		sig_res <= (resize(unsigned(data),9)+ resize(unsigned(accu),9));
		
	end if;
	
end process;

carry <= sig_res(8);
result <= STD_LOGIC_VECTOR( sig_res (7 downto 0));

end Behavioral;

