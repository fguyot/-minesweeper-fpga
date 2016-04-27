----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:07:18 03/19/2015 
-- Design Name: 
-- Module Name:    states_machine - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity states_machine_display is
    Port (	clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				cpt_line : in STD_LOGIC_VECTOR(3 downto 0);
				cpt_col : in STD_LOGIC_VECTOR(3 downto 0);
				discover_bp : in  STD_LOGIC;
				en_mux_aff : out STD_LOGIC;
				en_led_finish : out STD_LOGIC_vector (5 downto 0);
				en_discover_bloc : out  STD_LOGIC;
				en_graph_memo : out  STD_LOGIC;
				en_GRID : out STD_LOGIC;
				en_cpt_line: out  STD_LOGIC;
				rst_cpt_line : out  STD_LOGIC;
				en_cpt_col: out  STD_LOGIC;
				rst_cpt_col : out  STD_LOGIC);			  
			 
end states_machine_display;

architecture Behavioral of states_machine_display is

	type states is (init,grid, init_cpt, load_line, display_line, inc_line,inc_col);
	
	signal actual_state : states;
	signal next_state : states;
	
	begin
	
------------------------------------------------------
---------Process 1 : States machine ------------------
------------------------------------------------------

	process (actual_state)
	
	begin
	
	-----------------------------------------------------
	------We check the value of actual state-------------
	-----------------------------------------------------
	
		case actual_state is

			when init =>
				next_state<= grid;

			when grid =>
				if (discover_bp='1') then
					next_state<= init_cpt;
				else
					next_state<= grid;
				end if;

			when init_cpt =>

				next_state<= load_line;


			when load_line =>
				
				next_state<= display_line;

			when display_line =>

				if cpt_col<"1000"  then
				
					next_state<= inc_col;

				else
				
					if cpt_line<"1000" then
						next_state<= inc_line;
					else
						next_state<= init;
					end if;
					
				end if;

			when inc_line =>
				next_state<= load_line;
				
			when inc_col =>
				next_state<= display_line;


			end case;
	 
	end process;






------------------------------------------------------
---------Process 2 : Check new state -----------------
------------------------------------------------------

process (clock, reset)

begin
	if reset='1' then
		
		actual_state<=init;
		
	elsif rising_edge(clock) then

		actual_state <= next_state;

	end if;
	
	
end process;

------------------------------------------------------
---------Process 3 : Output value -----------------
------------------------------------------------------


process (actual_state)
	
	begin
	
		case actual_state is
		
			 when init => --all output is initilized

				en_discover_bloc<='0';
				en_graph_memo<='0';
				en_GRID <='0';
				en_mux_aff<='1';
				en_cpt_line<='0';
				rst_cpt_line <='1';
				en_cpt_col<='0';
				rst_cpt_col <='1';
				en_led_finish<="000011";

			when grid =>

				en_discover_bloc<='0';
				en_graph_memo<='0';
				en_GRID <='0';
				en_mux_aff<='0'; --afd
				en_cpt_line<='0';
				rst_cpt_line <='0';
				en_cpt_col<='0';
				rst_cpt_col <='0';
				en_led_finish<="000001";


			when init_cpt =>

				en_discover_bloc<='0';
				en_graph_memo<='0';
				en_GRID <='0';
				en_mux_aff<='1'; 
				en_cpt_line<='0';
				rst_cpt_line <='1';
				en_cpt_col<='0';
				rst_cpt_col <='1';
				en_led_finish<="000010";


			when load_line =>
				en_discover_bloc<='0';
				en_graph_memo<='1';
				en_GRID <='0';
				en_mux_aff<='1';
				en_cpt_line<='0';
				rst_cpt_line <='0';
				en_cpt_col<='0';
				rst_cpt_col <='0';
				en_led_finish<="000100";

			when display_line =>

				en_discover_bloc<='1';
				en_graph_memo<='0';
				en_GRID <='0';
				en_mux_aff<='1';
				en_cpt_line<='0';
				rst_cpt_line <='0';
				en_cpt_col<='0';
				rst_cpt_col <='0';
				en_led_finish<="001000";

			when inc_line =>
				en_discover_bloc<='0';
				en_graph_memo<='0';
				en_GRID <='0';
				en_mux_aff<='1';
				en_cpt_line<='1';
				rst_cpt_line <='0';
				en_cpt_col<='0';
				rst_cpt_col <='1';
				en_led_finish<="010000";
				
			when inc_col =>
				en_discover_bloc<='0';
				en_discover_bloc<='0';
				en_graph_memo<='0';
				en_GRID <='0';
				en_mux_aff<='1';
				en_cpt_line<='0';
				rst_cpt_line <='0';
				en_cpt_col<='1';
				rst_cpt_col <='0';
				en_led_finish<="100000";


			end case;
			
	 
	end process;



end Behavioral;

