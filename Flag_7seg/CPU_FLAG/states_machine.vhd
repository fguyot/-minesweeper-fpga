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

entity states_machine is
    Port (	clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				CE : in  STD_LOGIC;
				carry : in  STD_LOGIC;
           	operation_code : in  STD_LOGIC_VECTOR (1 downto 0);

           	Init_cpt : out  STD_LOGIC;
           	Enable_cpt : out  STD_LOGIC;
           	Load_cpt : out  STD_LOGIC;
           	Sel_mux : out  STD_LOGIC;
           	Load_register_instruction : out  STD_LOGIC;
           	Enable_memory : out  STD_LOGIC;
           	Read_write : out  STD_LOGIC;
           	Sel_UAL : out  STD_LOGIC;
           	Init_carry : out  STD_LOGIC;
           	Load_carry : out  STD_LOGIC;
           	Load_ACU : out  STD_LOGIC;
           	Load_register_data : out  STD_LOGIC);
			  
			 
end states_machine;

architecture Behavioral of states_machine is

	type states is (init,fetch_instruction, decode, fetch_operands, execute_operands, execute_JCC, store);
	
	signal actual_state : states;
	signal next_state : states;
	
	begin
	
------------------------------------------------------
---------Process 1 : States machine ------------------
------------------------------------------------------

	process (actual_state,operation_code,carry)
	
	begin
	
	-----------------------------------------------------
	------We check the value of etat present-------------
	-----------------------------------------------------
	
		case actual_state is
		
-------------------Reset state------------------------------------------

			when init =>
				next_state<= fetch_instruction;

			when fetch_instruction =>
				next_state<= decode;

			when decode =>
				if operation_code="10" then
					next_state<= store;

				elsif operation_code ="11" then
					next_state<= execute_JCC;

				else
					next_state<= fetch_operands;

				end if;

			when fetch_operands =>
				next_state<= execute_operands;

			when execute_operands =>
				next_state<= fetch_instruction;

			when execute_JCC =>
				next_state<= fetch_instruction;

			when store =>
				next_state<= fetch_instruction;

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

		if CE='1' then
	
			actual_state <= next_state;
		end if;
	end if;
	
	
end process;

------------------------------------------------------
---------Process 3 : Output value -----------------
------------------------------------------------------


process (actual_state,operation_code,carry)
	
	begin
	
		case actual_state is
		
			 when init => --all output is initilized

				Init_cpt<='1';
				Enable_cpt<='0';
				Load_cpt<='0';
				Sel_mux<='0';
				Load_register_instruction<='0';
				Enable_memory<='0';
				Read_write<='0';
				Sel_UAL<='0';
				Init_carry<='1';
				Load_carry<='0';
				Load_ACU<='0';
				Load_register_data<='0';


			when fetch_instruction => 
			
				Init_cpt<='0';
				Enable_cpt<='1';
				Load_cpt<='0';
				Sel_mux<='0';
				Load_register_instruction<='1';
				Enable_memory<='1';
				Read_write<='0';
				Sel_UAL<='0';
				Init_carry<='0';
				Load_carry<='0';
				Load_ACU<='0';
				Load_register_data<='0';

				
			when decode =>
			
				Init_cpt<='0';
				Enable_cpt<='0';
				Load_cpt<='0';
				Sel_mux<='1';
				Load_register_instruction<='0';
				Enable_memory<='0';
				Read_write<='0';
				Sel_UAL<='0';
				Init_carry<='0';
				Load_carry<='0';
				Load_ACU<='0';
				Load_register_data<='0';


			when fetch_operands =>
			
				Init_cpt<='0';
				Enable_cpt<='0';
				Load_cpt<='0';
				Sel_mux<='1';
				Load_register_instruction<='0';
				Enable_memory<='1';
				Read_write<='0';
				Init_carry<='0';
				Load_carry<='0';
				Load_ACU<='0';
				Load_register_data<='1';



				
			when execute_operands =>
			
				Init_cpt<='0';
				Enable_cpt<='0';
				Load_cpt<='0';
				Sel_mux<='1';
				Load_register_instruction<='0';
				Enable_memory<='0';
				Read_write<='0';
				Sel_UAL<='0';
				Init_carry<='0';
				Load_ACU<='1';
				Load_register_data<='0';

				if operation_code="01" then
					Load_carry<='1';
					Sel_UAL<='1';--ADD

				else
					Load_carry<='0';
					Sel_UAL<='0';--NOR
				end if;

		
			 when execute_JCC =>
			 
				Init_cpt<='0';
				Enable_cpt<='0';
				Load_cpt<=not(carry);
				Sel_mux<='1';
				Load_register_instruction<='0';
				Enable_memory<='0';
				Read_write<='0';
				Sel_UAL<='0';
				Init_carry<=carry;
				Load_carry<='0';
				Load_ACU<='0';
				Load_register_data<='0';
			
			
			when store =>
			
				Init_cpt<='0';
				Enable_cpt<='0';
				Load_cpt<='0';
				Sel_mux<='1';
				Load_register_instruction<='0';
				Enable_memory<='1';
				Read_write<='1';
				Sel_UAL<='0';
				Init_carry<='0';
				Load_carry<='0';
				Load_ACU<='0';
				Load_register_data<='0';

			end case;
			
	 
	end process;



end Behavioral;

