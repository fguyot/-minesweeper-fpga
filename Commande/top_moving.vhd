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

entity top_moving is
    Port ( 	clk : in  STD_LOGIC;
          	ce : in  STD_LOGIC;
           	rst : in  STD_LOGIC;
           	left : in  STD_LOGIC;
		right : in  STD_LOGIC;
		up : in  STD_LOGIC;
		down : in  STD_LOGIC;
		cpt_left_right: out  STD_LOGIC_VECTOR(3 downto 0);
		cpt_up_down : out  STD_LOGIC_VECTOR(3 downto 0));
  
end top_moving;

architecture Behavioral of top_moving is


component new_pos is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           inc : in  STD_LOGIC;
           dec : in  STD_LOGIC;
           Ce : in  STD_LOGIC;
           sens : out  STD_LOGIC;
           out_pulse : out  STD_LOGIC);
end component new_pos;


component cpt_pos is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           incdec_en : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           pos : out  STD_LOGIC_VECTOR (3 downto 0));
end component cpt_pos;


signal left_ab,right_ab,up_ab,down_ab,Ce_cc,sig_sens_left_right, sig_en_cpt_left_right,sig_sens_up_down,sig_en_cpt_up_down  : STD_LOGIC;

  
begin


new_pos_left_right : new_pos port map ( 	clk=>clk,
														rst=>rst,
														inc=>right,
														dec=>left,
														Ce=>ce,
														sens=>sig_sens_left_right,
														out_pulse=> sig_en_cpt_left_right);


new_pos_up_down : new_pos port map ( 		clk=>clk,
														rst=>rst,
														inc=>down,
														dec=>up,
														Ce=>ce,
														sens=>sig_sens_up_down,
														out_pulse=>sig_en_cpt_up_down);
								

inc_up_down : cpt_pos port map ( 	rst=>rst,
												clk=>clk,
												incdec_en=>sig_en_cpt_up_down,
												up_down=>sig_sens_up_down,
												pos=>cpt_up_down );	

inc_left_right : cpt_pos port map ( 	rst=>rst,
													clk=>clk,
													incdec_en=>sig_en_cpt_left_right,
													up_down=>sig_sens_left_right,
													pos=>cpt_left_right);				
												       


end Behavioral;

