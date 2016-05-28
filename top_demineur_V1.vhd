----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:02:11 04/19/2016 
-- Design Name: 
-- Module Name:    top_demineur_V1 - Behavioral 
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
entity top_demineur_V1 is


    Port ( 	clk 				: in  STD_LOGIC;
				rst 				: in  STD_LOGIC;
				left 				: in  STD_LOGIC;
				right 			: in  STD_LOGIC;
				up 				: in  STD_LOGIC;
				down 				: in  STD_LOGIC;
				discover_bp 	: in  STD_LOGIC;
				en1				: in STD_LOGIC;
				flag_sw			: in STD_LOGIC;
				CE_env			: in STD_LOGIC;
				--value				: in STD_LOGIC_VECTOR (3 downto 0);
				LEDF 				: out STD_LOGIC_VECTOR (6 downto 0);
				led_env 				: out STD_LOGIC;
				vga_hs 			: out  STD_LOGIC;
				vga_vs 			: out  STD_LOGIC;
				vga_red 			: out  STD_LOGIC_VECTOR (3 downto 0);
				vga_green 		: out  STD_LOGIC_VECTOR (3 downto 0);
				vga_blue 		: out  STD_LOGIC_VECTOR (3 downto 0);
				data_out 		: out  STD_LOGIC_VECTOR (2 downto 0));
end top_demineur_V1;

architecture Behavioral of top_demineur_V1 is

component top_moving is
    Port ( 	clk : in  STD_LOGIC;
          	ce : in  STD_LOGIC;
           	rst : in  STD_LOGIC;
           	left : in  STD_LOGIC;
				right : in  STD_LOGIC;
				up : in  STD_LOGIC;
				down : in  STD_LOGIC;
				cpt_left_right: out  STD_LOGIC_VECTOR(3 downto 0);
				cpt_up_down : out  STD_LOGIC_VECTOR(3 downto 0));
  
end component top_moving;


component top_grille_test is
			 Port ( 	clk : in  STD_LOGIC;
						rst : in  STD_LOGIC;
						discover_bp : in  STD_LOGIC;
						value : in STD_LOGIC_VECTOR (3 downto 0);
						posx : in STD_LOGIC_VECTOR (3 downto 0);
						posy : in STD_LOGIC_VECTOR (3 downto 0);
						--en1				: in STD_LOGIC;
						--LEDF : out STD_LOGIC_VECTOR (5 downto 0);
						vga_hs : out  STD_LOGIC;
						vga_vs : out  STD_LOGIC;
						vga_red : out  STD_LOGIC_VECTOR (3 downto 0);
						vga_green : out  STD_LOGIC_VECTOR (3 downto 0);
						vga_blue : out  STD_LOGIC_VECTOR (3 downto 0);
						data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end component top_grille_test;


component cadenceur is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           CCEn : out  STD_LOGIC);
end component cadenceur;

component anti_bounding is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           output : out  STD_LOGIC);
end component anti_bounding;

component top_create_grid is
    Port ( 			--input : in  STD_LOGIC_VECTOR (9 downto 0);          
				clock : in  STD_LOGIC;
				--load : in STD_LOGIC;
				--ce : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				output_l0 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l1 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l2 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l3 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l4 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l5 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l6 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l7 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l8 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_l9 : out  STD_LOGIC_VECTOR (9 downto 0));
end component top_create_grid;


component top_decode_env is
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
				LEDF : out STD_LOGIC_VECTOR (6 downto 0);
				add_memo: out  STD_LOGIC_VECTOR(6 downto 0);
				data_memo : out  STD_LOGIC_VECTOR(3 downto 0);
				en_memo : out  STD_LOGIC;
				read_write_memo : out  STD_LOGIC;
				end_process_decod: out  STD_LOGIC);
  
end component top_decode_env;

component top_memory_grid_100 is
    Port ( 	clk : in  STD_LOGIC;
           	rst : in  STD_LOGIC;
				sel : in STD_LOGIC;
				--flag : in STD_LOGIC;
           	posX : in  STD_LOGIC_VECtOR(3 downto 0);
				posY : in  STD_LOGIC_VECtOR(3 downto 0);
				--discover_button : in STD_LOGIC;
				--discov_out : out STD_LOGIC;


				addr_decode : in  STD_LOGIC_VECTOR (6 downto 0);
				data_in_decode : in  STD_LOGIC_VECTOR (3 downto 0);
				write_decode : in  STD_LOGIC;
				enable_memory_decode : in  STD_LOGIC;

				--data_out : out  STD_LOGIC_VECTOR (5 downto 0));
				data_out : out  STD_LOGIC_VECTOR (3 downto 0));
  
end  component top_memory_grid_100;





signal sig_pos_lr, sig_pos_ud,sig_data_out_mem : STD_LOGIC_VECTOR (3 downto 0);
signal sig_ce_bp,sig_dis_bp : STD_LOGIC;

signal sig_add_mem_matrice_in : STD_LOGIC_VECTOR (6 downto 0);
--signal sig_data_mem_matrice_in,sig_data_out_mem : STD_LOGIC_VECTOR (5 downto 0);
signal sig_data_mem_matrice_in: STD_LOGIC_VECTOR (3 downto 0);
signal sig_en_mem_matrice_in : STD_LOGIC;
signal sig_rw_mem_matrice_in, sig_discov_out : STD_LOGIC;

signal sig_mem_l0,sig_mem_l1,sig_mem_l2,sig_mem_l3,sig_mem_l4,sig_mem_l5,sig_mem_l6,sig_mem_l7,sig_mem_l8,sig_mem_l9 : STD_LOGIC_VECTOR (9 downto 0);

begin




direction_control : top_moving port map (  	clk => clk ,
															ce =>  sig_ce_bp,
															rst => rst ,
															left => left ,
															right => right ,
															up => up ,
															down => down ,
															cpt_left_right=>  sig_pos_lr,
															cpt_up_down=>  sig_pos_ud);	


display_control : top_grille_test port map (  	clk => clk ,
																rst =>  rst,
																discover_bp =>  discover_bp,
																value => sig_data_out_mem,
																posx =>  sig_pos_lr,
																posy =>  sig_pos_ud,
																--en1 => en1,
																--LEDF => LEDF,
																vga_hs =>  vga_hs,
																vga_vs => vga_vs ,
																vga_red =>  vga_red,
																vga_green => vga_green ,
																vga_blue => vga_blue ,
																data_out => data_out );
															
cadence : cadenceur port map (  	clk => clk ,
											rst =>  rst,
											CCEn =>  sig_ce_bp);			


ab_disc : anti_bounding port map (  	clock => clk ,
													reset =>  rst,
													enable =>  discover_bp,
													output =>  sig_dis_bp);	
													
Create_grid : top_create_grid port map (  	--input : in  STD_LOGIC_VECTOR (9 downto 0);          
															clock => clk ,
															--load : in STD_LOGIC;
															--ce : in  STD_LOGIC;
															reset =>  rst,
															output_l0 =>  sig_mem_l0,
															output_l1 =>  sig_mem_l1,
															output_l2 =>  sig_mem_l2,
															output_l3 =>  sig_mem_l3,
															output_l4 =>  sig_mem_l4,
															output_l5 =>  sig_mem_l5,
															output_l6 =>  sig_mem_l6,
															output_l7 =>  sig_mem_l7,
															output_l8 =>  sig_mem_l8,
															output_l9 =>  sig_mem_l9);
															

Decode_grid : top_decode_env port map (  	clk => clk ,
														Ce => CE_env , -- a changer
														rst =>  rst,
														line0 =>  sig_mem_l0,
														line1 =>  sig_mem_l1,
														line2 =>  sig_mem_l2,
														line3 =>  sig_mem_l3,
														line4 =>  sig_mem_l4,
														line5 =>  sig_mem_l5,
														line6 =>  sig_mem_l6,
														line7 =>  sig_mem_l7,
														line8 =>  sig_mem_l8,
														line9 =>  sig_mem_l9,
														LEDF=>    LEDF,
														add_memo => sig_add_mem_matrice_in,
														data_memo => sig_data_mem_matrice_in,
														en_memo => sig_en_mem_matrice_in,
														read_write_memo => sig_rw_mem_matrice_in,
														end_process_decod => led_env); -- a changer

Memory_bloc : top_memory_grid_100 port map (  	clk => clk ,
																rst => rst ,
																sel => CE_env,
																posX => sig_pos_lr,
																posY =>  sig_pos_ud,
																--flag => flag_sw,
																--discover_button => discover_bp,
																--discov_out => sig_discov_out,

																data_in_decode => sig_data_mem_matrice_in,
																addr_decode => sig_add_mem_matrice_in,
																write_decode => sig_rw_mem_matrice_in,
																enable_memory_decode => sig_en_mem_matrice_in,

																data_out => sig_data_out_mem);
														



end Behavioral;

