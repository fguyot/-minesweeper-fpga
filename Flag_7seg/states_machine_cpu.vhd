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

entity states_machine_cpu is
    Port (	clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				CE : in  STD_LOGIC;
				bp_operation : in  STD_LOGIC;
				signe : in  STD_LOGIC;
				cpt : in  STD_LOGIC ;
				
				rst_CPU : out  STD_LOGIC;
				EN_CPU : out  STD_LOGIC;
				EN_ext : out STD_LOGIC;
				adress_memory : out  STD_LOGIC_VECTOR (5 downto 0);
				data_in_memory : out  STD_LOGIC_VECTOR (7 downto 0);
				rw_memory : out  STD_LOGIC;
				en_memory : out STD_LOGIC;
				EN_cpt : out  STD_LOGIC;
				rst_cpt : out  STD_LOGIC );			  
			 
end states_machine_cpu;

architecture Behavioral of states_machine_cpu is

	type states is (init,init_value,new_operation, write_operator, wait_end_cpu, read_value);
	
	signal actual_state : states;
	signal next_state : states;
	
	begin
	
------------------------------------------------------
---------Process 1 : States machine ------------------
------------------------------------------------------

	process (actual_state,cpt)
	
	begin
	
	-----------------------------------------------------
	------We check the value of etat present-------------
	-----------------------------------------------------
	
		case actual_state is
		
-------------------Reset state------------------------------------------

			when init =>
				next_state<= init_value;

			when init_value =>
				next_state<= new_operation;

			when read_value =>		--read value on the CPU memory

				if bp_operation='0' then	--if no refresh needed
					next_state<=read_value ;
				else
					next_state<= new_operation; -- new operation

				end if;

			when new_operation =>		--reset CPU et compter
				
				next_state<= write_operator;

			when write_operator =>		--write on memory instruction to choose between addition or soustraction

				next_state<= wait_end_cpu;


			when wait_end_cpu =>		--cpt for waiting the end of CPU instructions

				if cpt='0' then
					next_state<=wait_end_cpu ;
				else
					next_state<= read_value;

				end if;

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


process (actual_state)
	
	begin
	
		case actual_state is
		
			 when init => --all output is initilized

				rst_CPU<='1';
				EN_CPU<='0';
				EN_ext<='0';
				adress_memory<="000000";
				data_in_memory <="00000000";
				rw_memory <='0';
				en_memory <='0';
				EN_cpt <='0';
				rst_cpt <='1';

			when init_value => 
	
				rst_CPU<='0';
				EN_CPU<='0';
				EN_ext<='1';
				adress_memory<="001111"; 	--Adress of value in CPU memory (14)
				data_in_memory <="00001111";	-- initial value =15
				en_memory<='1';
				rw_memory <='1';
				EN_cpt <='0';
				rst_cpt <='0';
				
			when read_value =>
			 
				rst_CPU<='0';
				EN_CPU<='0';
				EN_ext<='1';
				adress_memory<="001110"; --adress of the value
				data_in_memory <="00000000";
				rw_memory <='0';
				en_memory<='1';
				EN_cpt <='0';
				rst_cpt <='0';

				
			when new_operation =>
			
				rst_CPU<='1';
				EN_CPU<='0';
				EN_ext<='0';
				adress_memory<="000000";
				data_in_memory <="00000000";
				rw_memory <='0';
				en_memory<='0';
				EN_cpt <='0';
				rst_cpt <='1';
				

			when write_operator =>
			
				rst_CPU<='0';
				EN_CPU<='0';
				EN_ext<='1';
				adress_memory<="000001"; --adress of the JCC instruction to change
				rw_memory <='1';
				en_memory<='1';
				EN_cpt <='0';
				rst_cpt <='0';

				if signe='0' then
					data_in_memory <="11000110"; --value to create a soustraction
				else
					data_in_memory <="11000010"; --value to create a addition

				end if;

				
			when wait_end_cpu =>
			
				rst_CPU<='0';
				EN_CPU<='1';
				EN_ext<='0';
				adress_memory<="000000";
				data_in_memory <="00000000";
				rw_memory <='0';
				EN_cpt <='1';
				rst_cpt <='0';
				
			end case;

			
	 
	end process;



end Behavioral;

