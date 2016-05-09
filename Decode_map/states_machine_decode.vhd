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

entity states_machine_decode is
    Port (	clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				CE : in  STD_LOGIC;
				cpt_col : in  integer;
				cpt_line : in  integer;
				
				cen_reg : out  STD_LOGIC;
				load_reg : out  STD_LOGIC;
				rst_reg : out STD_LOGIC;
				cen_inc_reg : out  STD_LOGIC;
				rst_inc_reg : out  STD_LOGIC;
				rst_cpt_col : out  STD_LOGIC;
				en_cpt_col : out  STD_LOGIC;
				rst_cpt_line : out  STD_LOGIC;
				en_cpt_line : out  STD_LOGIC;
				ce_add_conv : out  STD_LOGIC;
				rst_add_conv : out  STD_LOGIC;
				rst_decod: out  STD_LOGIC; 
				en_decod : out  STD_LOGIC;
				rw_memo : out  STD_LOGIC;
				cen_memo : out  STD_LOGIC;
				end_decode_state : out  STD_LOGIC);			  
			 
end states_machine_decode;

architecture Behavioral of states_machine_decode is

	type states is (init,first_reg_load, inc_reg, reg_load, decode, save, next_step, end_fms_decode);
	
	signal actual_state : states;
	signal next_state : states;
	
	begin
	
------------------------------------------------------
---------Process 1 : States machine ------------------
------------------------------------------------------

	process (actual_state)
	
	begin
	
	-----------------------------------------------------
	------We check the value of etat present-------------
	-----------------------------------------------------
	
		case actual_state is
		
-------------------Reset state------------------------------------------

			when init =>
				next_state<= first_reg_load;

			when first_reg_load =>
				next_state<= inc_reg;

			when inc_reg =>

				next_state<= reg_load;


			when reg_load =>
				next_state<= decode;

			when decode =>
				next_state<= save;

			when save =>
				next_state<= next_step;

			when next_step =>

				if( cpt_col=9) then --END OF A LINE
				
					if( cpt_line=9) then	--LAST LINE

						next_state<= end_fms_decode;
					
					else

						next_state<= inc_reg;

					end if;

				else

					next_state<= decode;

				end if;

			when end_fms_decode =>
				next_state<= end_fms_decode;


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

				cen_reg<='0';
				load_reg<='0';
				rst_reg<='1';
				cen_inc_reg<='0';
				rst_inc_reg<='1';
				rst_cpt_col<='1';
				en_cpt_col<='0';
				rst_cpt_line<='1';
				en_cpt_line<='0';
				ce_add_conv<='0';
				rst_add_conv<='1';
				rst_decod<='1';
				en_decod<='0';
				rw_memo<='0';
				cen_memo<='0';
				end_decode_state<='0';


			when first_reg_load => 
	
				cen_reg<='1';
				load_reg<='1';
				rst_reg<='0';
				cen_inc_reg<='0';
				rst_inc_reg<='0';
				rst_cpt_col<='0';
				en_cpt_col<='0';
				rst_cpt_line<='0';
				en_cpt_line<='0';
				ce_add_conv<='0';
				rst_add_conv<='0';
				rst_decod<='0';
				en_decod<='0';
				rw_memo<='0';
				cen_memo<='0';
				end_decode_state<='0';

				
			when inc_reg =>
			
				cen_reg<='0';
				load_reg<='0';
				rst_reg<='0';
				rst_inc_reg<='0';
				cen_inc_reg<='1';
				rst_cpt_col<='0';
				en_cpt_col<='0';
				rst_cpt_line<='0';
				en_cpt_line<='0';
				ce_add_conv<='0';
				rst_add_conv<='0';
				rst_decod<='0';
				en_decod<='0';
				rw_memo<='0';
				cen_memo<='0';
				end_decode_state<='0';


			when reg_load =>
			
				cen_reg<='1';
				load_reg<='1';
				rst_reg<='0';
				cen_inc_reg<='0';
				rst_inc_reg<='0';
				rst_cpt_col<='0';
				en_cpt_col<='0';
				rst_cpt_line<='0';
				en_cpt_line<='0';
				ce_add_conv<='0';
				rst_add_conv<='0';
				rst_decod<='0';
				en_decod<='0';
				rw_memo<='0';
				cen_memo<='0';
				end_decode_state<='0';

				
			when decode =>
			
				cen_reg<='0';
				load_reg<='0';
				rst_reg<='0';
				cen_inc_reg<='0';
				rst_inc_reg<='0';
				rst_cpt_col<='0';
				en_cpt_col<='0';
				rst_cpt_line<='0';
				en_cpt_line<='0';
				ce_add_conv<='1';
				rst_add_conv<='0';
				rst_decod<='0';
				en_decod<='1';
				rw_memo<='0';
				cen_memo<='0';
				end_decode_state<='0';
		
			 when save =>
			 
				cen_reg<='0';
				load_reg<='0';
				rst_reg<='0';
				cen_inc_reg<='0';
				rst_inc_reg<='0';
				rst_cpt_col<='0';
				en_cpt_col<='0';
				rst_cpt_line<='0';
				en_cpt_line<='0';
				ce_add_conv<='0';
				rst_add_conv<='0';
				rst_decod<='0';
				en_decod<='0';
				rw_memo<='1';
				cen_memo<='1';
				end_decode_state<='0';
			
			
			when next_step =>
			
				cen_reg<='0';
				load_reg<='0';
				rst_reg<='0';
				cen_inc_reg<='0';
				rst_inc_reg<='0';
				rst_cpt_line<='0';
				ce_add_conv<='0';
				rst_add_conv<='0';
				rst_decod<='0';
				en_decod<='0';
				rw_memo<='0';
				cen_memo<='0';

				if( cpt_col=9) then --END OF A LINE
				
					if( cpt_line=9) then	--LAST LINE

						en_cpt_col<='0';
						en_cpt_line<='0';
						end_decode_state<='1';
						rst_cpt_col<='0';
					
					else

						en_cpt_col<='0';
						en_cpt_line<='1';
						end_decode_state<='0';
						rst_cpt_col<='1';

					end if;

				else

					en_cpt_col<='1';
					en_cpt_line<='0';
					end_decode_state<='0';
					rst_cpt_col<='0';

				end if;

			when end_fms_decode =>

				cen_reg<='0';
				load_reg<='0';
				rst_reg<='0';
				cen_inc_reg<='0';
				rst_inc_reg<='0';
				rst_cpt_col<='0';
				en_cpt_col<='0';
				rst_cpt_line<='0';
				en_cpt_line<='0';
				ce_add_conv<='0';
				rst_add_conv<='0';
				rst_decod<='0';
				en_decod<='0';
				rw_memo<='0';
				cen_memo<='0';
				end_decode_state<='1';
			end case;
			
	 
	end process;



end Behavioral;

