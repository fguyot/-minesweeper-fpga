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
				value				: in STD_LOGIC_VECTOR (3 downto 0);
				LEDF 				: out STD_LOGIC_VECTOR (5 downto 0);
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
						en1				: in STD_LOGIC;
						LEDF : out STD_LOGIC_VECTOR (5 downto 0);
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




signal sig_pos_lr, sig_pos_ud : STD_LOGIC_VECTOR (3 downto 0);
signal sig_ce_bp,sig_dis_bp : STD_LOGIC;

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
																discover_bp =>  sig_dis_bp,
																value => value,
																posx =>  sig_pos_lr,
																posy =>  sig_pos_ud,
																en1 => en1,
																LEDF => LEDF,
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
									


end Behavioral;
