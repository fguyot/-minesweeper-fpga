----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:23:07 03/25/2016 
-- Design Name: 
-- Module Name:    top_grille - Behavioral 
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

entity top_graph_mem is
    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in  STD_LOGIC;
				line_chose : in STD_LOGIC_VECTOR (3 downto 0);
				value : in STD_LOGIC_VECTOR (5 downto 0);

				line_data_out : out STD_LOGIC_VECTOR (8 downto 0);
				color_data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end top_graph_mem;

architecture Behavioral of top_graph_mem is



component graph_mem_0 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_0;


component graph_mem_1 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_1;

component graph_mem_2 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_2;


component graph_mem_3 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_3;

component graph_mem_4 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_4;

component graph_mem_5 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_5;


component graph_mem_6 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_6;



component graph_mem_7 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_7;


component graph_mem_8 is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_8;


component graph_mem_flag is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_flag;


component graph_mem_mine is

    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				add : in STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (8 downto 0));
				
end component graph_mem_mine;



component mux_graph_mem is
    Port ( 	selection : in STD_LOGIC_VECTOR(5 downto 0);
		input0: in  STD_LOGIC_VECTOR (8 downto 0);
		input1: in  STD_LOGIC_VECTOR (8 downto 0);
		input2 : in  STD_LOGIC_VECTOR (8 downto 0);
		input3 : in  STD_LOGIC_VECTOR(8 downto 0);
		input4: in  STD_LOGIC_VECTOR (8 downto 0);
		input5 : in  STD_LOGIC_VECTOR (8 downto 0);
		input6 : in  STD_LOGIC_VECTOR(8 downto 0);
		input7: in  STD_LOGIC_VECTOR (8 downto 0);
		input8 : in  STD_LOGIC_VECTOR (8 downto 0);
		input9 : in  STD_LOGIC_VECTOR(8 downto 0);
		input10: in  STD_LOGIC_VECTOR (8 downto 0);

		output : out  STD_LOGIC_VECTOR (8 downto 0));
end component mux_graph_mem;

component graph_color is
    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in STD_LOGIC;
				value : in  STD_LOGIC_VECTOR (5 downto 0);
				output : out  STD_LOGIC_VECTOR (2 downto 0));
end component graph_color;







signal sig_graph_0,sig_graph_1,sig_graph_2, sig_graph_3, sig_graph_4, sig_graph_5, sig_graph_6, sig_graph_7, sig_graph_8, sig_graph_flag, sig_graph_mine : STD_LOGIC_VECTOR (8 downto 0);
signal sig_data_write: STD_LOGIC;
signal sig_ADDR : STD_LOGIC_VECTOR (13 downto 0);

signal sig_en_discover_bloc,sig_en_cpt_line : STD_LOGIC;
signal sig_cpt_col,sig_cpt_line : STD_LOGIC_VECTOR (3 downto 0);
signal sig_line_data : STD_LOGIC_VECTOR (8 downto 0);
--Fake sig for simulate

signal sig_fake_end_line,sig_fake_en_graph_memo,sig_en_cpt_col,sig_rst_cpt_col,sig_rst_cpt_line  : STD_LOGIC;


begin
													  
													 
			  
memo_graphic_zero : graph_mem_0  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_0);

memo_graphic_one : graph_mem_1  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_1);

memo_graphic_two : graph_mem_2  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_2);

memo_graphic_three : graph_mem_3  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_3);

memo_graphic_four : graph_mem_4  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_4);

memo_graphic_five : graph_mem_5  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_5);

memo_graphic_six : graph_mem_6  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_6);

memo_graphic_seven : graph_mem_7  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_7);

memo_graphic_eight : graph_mem_8  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_8);

memo_graphic_mine : graph_mem_mine  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_mine);

memo_graphic_flag : graph_mem_flag  port map( 	clk => clk,
															rst=>rst,
															en =>en,
															add => line_chose,
															output => sig_graph_flag);




															
Mux :   mux_graph_mem   port map(		selection => value,
						input0 => sig_graph_0,
						input1 => sig_graph_1,
						input2 => sig_graph_2,
						input3 => sig_graph_3,
						input4 => sig_graph_4,
						input5 => sig_graph_5,
						input6 => sig_graph_6,
						input7 => sig_graph_7,
						input8 => sig_graph_8,
						input9 => sig_graph_mine,
						input10 => sig_graph_flag,

						output => line_data_out);

color_choose : graph_color  port map( 	clk => clk,
				rst => rst,
				en => en,
				value => value,
				output =>color_data_out);




																	
			  

end Behavioral;

