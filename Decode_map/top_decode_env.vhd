----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:10 03/21/2016 
-- Design Name: 
-- Module Name:    top_aff - Behavioral 
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

entity top_decode_env is
    Port ( 	clk : in  STD_LOGIC;
          	Ce : in  STD_LOGIC;
           	rst : in  STD_LOGIC;
           	line0 : in  STD_LOGIC_VECTOR (9 downto 0);
				line1 : in  STD_LOGIC_VECTOR (9 downto 0);
				line2 : in  STD_LOGIC_VECTOR (9 downto 0);
				line3 : in  STD_LOGIC_VECTOR (9 downto 0);
				line4 : in  STD_LOGIC_VECTOR (9 downto 0);
				line5 : in  STD_LOGIC_VECTOR (9 downto 0);
				line6 : in  STD_LOGIC_VECTOR (9 downto 0);
				line7 : in  STD_LOGIC_VECTOR (9 downto 0);
				line8 : in  STD_LOGIC_VECTOR (9 downto 0);
				line9 : in  STD_LOGIC_VECTOR (9 downto 0);

				add_memo: out  STD_LOGIC_VECTOR(6 downto 0);
				data_memo : out  STD_LOGIC_VECTOR(3 downto 0);
				en_memo : out  STD_LOGIC;
				read_write_memo : out  STD_LOGIC;
				end_process_decod: out  STD_LOGIC);
  
end top_decode_env;

architecture Behavioral of top_decode_env is

   component mux_reg_decod is
    Port ( 	selection : in STD_LOGIC_VECTOR(3 downto 0);
				input1: in  STD_LOGIC_VECTOR (9 downto 0);
				input2 : in  STD_LOGIC_VECTOR (9 downto 0);
				input3 : in  STD_LOGIC_VECTOR(9 downto 0);
				input4: in  STD_LOGIC_VECTOR (9 downto 0);
				input5 : in  STD_LOGIC_VECTOR (9 downto 0);
				input6 : in  STD_LOGIC_VECTOR(9 downto 0);
				input7: in  STD_LOGIC_VECTOR (9 downto 0);
				input8 : in  STD_LOGIC_VECTOR (9 downto 0);
				input9 : in  STD_LOGIC_VECTOR(9 downto 0);
				input10: in  STD_LOGIC_VECTOR (9 downto 0);
				output : out  STD_LOGIC_VECTOR (9 downto 0));
end component mux_reg_decod;

   component reg_decal_10bit is
    Port ( 	input : in  STD_LOGIC_VECTOR (9 downto 0);          
				clock : in  STD_LOGIC;
				load : in STD_LOGIC;
				ce : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				output_n1 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_n2 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_n3 : out  STD_LOGIC_VECTOR (9 downto 0));
   end component reg_decal_10bit;


    component counter9 is
		Port (	clk : in  STD_LOGIC;
					ce : in  STD_LOGIC;
					rst : in STD_LOGIC;
					counterOut : out  integer);
    end component counter9;

	component inc_reg is
		Port ( 	clk : in  STD_LOGIC;
					ce : in  STD_LOGIC;
					rst : in STD_LOGIC;
					mux_sel : out  STD_LOGIC_VECTOR(3 downto 0));
	end component inc_reg;

	component memory_adress_converter is
	    Port ( 	clk : in  STD_LOGIC;
					c_en : in  STD_LOGIC;
					rst : in  STD_LOGIC;
					line : in  integer;
					column : in  integer;
					adress : out  STD_LOGIC_VECTOR (6 downto 0));
	end component memory_adress_converter;


	component decod_new_grille is
	    Port ( 	clk : in  STD_LOGIC;
					rst : in  STD_LOGIC;
					EN : in  STD_LOGIC;
					l_prev : in  STD_LOGIC_VECTOR (9 downto 0); --register with the previous line
					l_current : in  STD_LOGIC_VECTOR (9 downto 0); --register with the current line
					l_next : in  STD_LOGIC_VECTOR (9 downto 0);	--register with the next line 
					cpt_col : in integer;	--counter col
					cpt_line : in  integer;	--counter line
					value : out  STD_LOGIC_VECTOR (3 downto 0);	--value to save in the memory
					--raz_cpt_line : out  STD_LOGIC;	-- reset for the col counter
					raz_cpt_col : out  STD_LOGIC);	-- reset for the col counter
	end component decod_new_grille;

	component states_machine_decode is
		 Port (	clock : in  STD_LOGIC;
					reset : in  STD_LOGIC;
					CE : in  STD_LOGIC;
					cpt_col : in  integer;
					cpt_line : in  integer;
					cen_reg : out  STD_LOGIC;
					load_reg : out  STD_LOGIC;
					rst_reg : out  STD_LOGIC;
					cen_inc_reg : out  STD_LOGIC;
					rst_inc_reg : out STD_LOGIC;
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
	end component states_machine_decode;



signal sig_in_reg_dec, sig_prev_line, sig_current_line, sig_next_line : STD_LOGIC_VECTOR (9 downto 0);
signal sig_sel_mux : STD_LOGIC_VECTOR (3 downto 0);
signal sig_cpt_line, sig_cpt_col :  integer;
signal sig_load_reg,sig_en_reg, sig_rst_reg, sig_cen_inc, sig_rst_inc, sig_rst_cpt_col, sig_en_cpt_col, sig_rst_cpt_line, sig_en_cpt_line, sig_ce_add_conv, sig_rst_add_conv,sig_ce_decode,sig_rst_decode, sig_raz_cpt_line, sig_raz_cpt_col : STD_LOGIC;

  
begin

mux_reg : mux_reg_decod port map ( 	selection => sig_sel_mux ,
												input1 => line0,
												input2 => line1,
												input3 =>  line2,
												input4 =>  line3,
												input5 =>  line4,
												input6 =>  line5,
												input7 =>  line6,
												input8 =>  line7,
												input9 =>  line8,
												input10 =>  line9,
												output => sig_in_reg_dec );
												
												

reg_dec : reg_decal_10bit port map ( 	input => sig_in_reg_dec ,          
													clock => clk ,
													load => sig_load_reg ,
													ce => sig_en_reg ,
													reset => sig_rst_reg ,
													output_n1 => sig_next_line  ,
													output_n2 => sig_current_line ,
													output_n3 => sig_prev_line );
													
inc_register : inc_reg port map ( 	clk => clk ,
												ce =>  sig_cen_inc,
												rst =>  sig_rst_inc,
												mux_sel => sig_sel_mux );
										
										
										
count_line : counter9 port map ( 	clk => clk ,
												ce => sig_en_cpt_line ,
												rst => sig_rst_cpt_line,
												counterOut => sig_cpt_line );
											

count_column : counter9 port map ( 	clk => clk ,
												ce => sig_en_cpt_col ,
												rst => sig_rst_cpt_col ,
												counterOut => sig_cpt_col );
												
												
add_conv : memory_adress_converter port map ( 	clk => clk ,
																c_en => sig_ce_add_conv ,
																rst =>  sig_rst_add_conv,
																line => sig_cpt_line ,
																column =>  sig_cpt_col,
																adress => add_memo );

decode_block : decod_new_grille port map ( 	clk => clk ,
															rst => sig_rst_decode,
															EN =>sig_ce_decode,
															l_prev => sig_prev_line ,
															l_current => sig_current_line ,
															l_next => sig_next_line ,
															cpt_col =>  sig_cpt_col,
															cpt_line => sig_cpt_line,
															value => data_memo,
															--raz_cpt_line => sig_raz_cpt_line ,
															raz_cpt_col => sig_raz_cpt_col );
															
															
FSM_decode : states_machine_decode port map ( 	clock  =>  clk,
																reset  => rst ,
																CE  =>  Ce,
																
																cpt_col =>sig_cpt_col ,
																cpt_line =>sig_cpt_line ,
																--raz_cpt_col  => sig_raz_cpt_col ,
																--raz_cpt_line => sig_raz_cpt_line ,
																cen_reg  => sig_en_reg ,
																load_reg  => sig_load_reg ,
																rst_reg => sig_rst_reg ,
																cen_inc_reg  => sig_cen_inc ,
																rst_inc_reg=> sig_rst_inc,
																rst_cpt_col => sig_rst_cpt_col ,
																en_cpt_col  => sig_en_cpt_col ,
																rst_cpt_line  => sig_rst_cpt_line ,
																en_cpt_line => sig_en_cpt_line ,
																ce_add_conv  =>  sig_ce_add_conv,
																rst_add_conv  =>  sig_rst_add_conv,
																rst_decod =>  sig_rst_decode, 
																en_decod  =>  sig_ce_decode,
																rw_memo  => read_write_memo ,
																cen_memo  => en_memo ,
																end_decode_state  => end_process_decod );
					


end Behavioral;

