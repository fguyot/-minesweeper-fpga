----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:34:17 04/11/2016 
-- Design Name: 
-- Module Name:    affichage_position - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity discover_graphic is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           en : in  STD_LOGIC;
			  pos_x : in  STD_LOGIC_VECTOR (3 downto 0);
			  pos_y: in  STD_LOGIC_VECTOR (3 downto 0);
			  cpt_col_graph : in  STD_LOGIC_VECTOR (3 downto 0);
			  cpt_line_graph : in  STD_LOGIC_VECTOR (3 downto 0);
			  line_data : in STD_LOGIC_VECTOR (8 downto 0);
			  color_data : in STD_LOGIC_VECTOR (2 downto 0);
			  
			 
           ADDR : out  STD_LOGIC_VECTOR (13 downto 0);
           data_in : out  STD_LOGIC_VECTOR (2 downto 0);
           data_write : out  STD_LOGIC);
			  
end discover_graphic;

architecture Behavioral of discover_graphic is

constant h: integer :=31;
constant vv: integer :=1600;
constant v: integer :=160;
constant k: integer := 10;

signal line_cpt : unsigned (3 downto 0);

signal sig_ADDR : integer range 0 to 15999 := 0;
signal sig_calcul_pos : integer range 0 to 15999 :=0;
signal sig_end_col,sig_end_line,sig_data_write : STD_LOGIC;
signal sig_data_in : STD_LOGIC_VECTOR(2 downto 0);

signal sig_line_bit_val : integer range 0 to 9 := 0;


begin

process(clk, rst)	

	begin
	
		if rst = '1' then				-- Init
		
		     sig_ADDR <= 0;
           sig_data_in <="000";
           sig_data_write <='1';
			  sig_calcul_pos<=0;
		
			
		elsif rising_edge(clk) then
		
			sig_line_bit_val<=(to_integer(unsigned(cpt_col_graph)));
			if en='1' then
			
				sig_calcul_pos <= to_integer(unsigned(cpt_col_graph))+ v * to_integer(unsigned(cpt_line_graph)) + k * to_integer(unsigned(pos_x))+ vv * to_integer(unsigned(pos_y));
				sig_ADDR <= sig_calcul_pos + h;
				--sig_ADDR <= h + cpt_in + to_integer(unsigned(col))*k + to_integer(unsigned(line)) * v + 1; 
				sig_data_write <='1';
				
				if line_data(sig_line_bit_val)='1' then
					sig_data_in <=color_data;
				else
					sig_data_in <="111";
				end if;
					
				

			else

			  sig_ADDR <= 0;
           sig_data_in <="000";
           sig_data_write <='0';
			
			

			end if;
			
		end if;

end process;

ADDR <= std_logic_vector(to_unsigned(sig_ADDR,14));
data_in<=sig_data_in;
data_write<=sig_data_write;

end Behavioral;

