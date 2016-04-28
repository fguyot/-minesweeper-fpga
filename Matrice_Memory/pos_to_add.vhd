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

entity pos_to_add is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           posX : in  STD_LOGIC_VECTOR(3 downto 0);
           posY : in  STD_LOGIC_VECTOR(3 downto 0);
           adress : out  STD_LOGIC_VECTOR (6 downto 0));
end pos_to_add;

architecture Behavioral of pos_to_add is

signal sig_out : integer range 0 to 100 := 0;
constant k: integer:= 9;

begin

process(clk)
	begin

	sig_out <= k*to_integer(unsigned(posY))+to_integer(unsigned(posX));
	
end process;

	adress<=std_logic_vector(to_unsigned(sig_out,7));

end Behavioral;

