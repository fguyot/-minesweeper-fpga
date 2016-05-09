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

entity top_grille_test is
    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				discover_bp : in  STD_LOGIC;
				value : in STD_LOGIC_VECTOR (3 downto 0);
				posx : in STD_LOGIC_VECTOR (3 downto 0);
				posy : in STD_LOGIC_VECTOR (3 downto 0);
				--en1 : in STD_LOGIC;
				
				LEDF : out STD_LOGIC_vector(5 downto 0);
				
				vga_hs : out  STD_LOGIC;
				vga_vs : out  STD_LOGIC;
				vga_red : out  STD_LOGIC_VECTOR (3 downto 0);
				vga_green : out  STD_LOGIC_VECTOR (3 downto 0);
				vga_blue : out  STD_LOGIC_VECTOR (3 downto 0);
				data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end top_grille_test;

architecture Behavioral of top_grille_test is


component VGA_bitmap_160x100 is

  generic(bit_per_pixel : integer range 1 to 12 := 3;    -- number of bits per pixel
          grayscale     : boolean := false);           -- should data be displayed in grayscale
  port(clk          : in  std_logic;
       reset        : in  std_logic;
		 
       VGA_hs       : out std_logic;   -- horisontal vga syncr.
       VGA_vs       : out std_logic;   -- vertical vga syncr.
       VGA_red      : out std_logic_vector(3 downto 0);   -- red output
       VGA_green    : out std_logic_vector(3 downto 0);   -- green output
       VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output

       ADDR         : in  std_logic_vector(13 downto 0);
       data_in      : in  std_logic_vector(bit_per_pixel - 1 downto 0);
       data_write   : in  std_logic;
       data_out     : out std_logic_vector(bit_per_pixel - 1 downto 0));
end component VGA_bitmap_160x100;



component vga_grille is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  en : in  STD_LOGIC;
			  line : in  STD_LOGIC_VECTOR (3 downto 0);
			  col : in  STD_LOGIC_VECTOR (3 downto 0);
			  --end_bloc : out STD_LOGIC;
           ADDR : out  STD_LOGIC_VECTOR (13 downto 0);
           data_in : out  STD_LOGIC_VECTOR (2 downto 0);
           data_write : out  STD_LOGIC);
			  
end component vga_grille;


component mux_vga is
    Port ( 	selection : in STD_LOGIC;
				input_data_in_1: in  STD_LOGIC_VECTOR (2 downto 0);
				input_data_in_2 : in  STD_LOGIC_VECTOR (2 downto 0);
				input_addr_1: in  STD_LOGIC_VECTOR (13 downto 0);
				input_addr_2 : in  STD_LOGIC_VECTOR (13 downto 0);
				input_write_1: in  STD_LOGIC;
				input_write_2 : in  STD_LOGIC;
				output_data_in : out  STD_LOGIC_VECTOR (2 downto 0);
				output_addr : out  STD_LOGIC_VECTOR (13 downto 0);
				output_write: out  STD_LOGIC);
end component mux_vga ;



component discover_graphic is
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
			  
end component discover_graphic;


component top_graph_mem is
    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				en : in  STD_LOGIC;
				line_chose : in STD_LOGIC_VECTOR (3 downto 0);
				value : in STD_LOGIC_VECTOR (3 downto 0);

				line_data_out : out STD_LOGIC_VECTOR (8 downto 0);
				color_data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end component top_graph_mem;




component states_machine_display is
    Port (	clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				cpt_line : in STD_LOGIC_VECTOR(3 downto 0);
				cpt_col : in STD_LOGIC_VECTOR(3 downto 0);
				discover_bp : in  STD_LOGIC;
						
				en_led_finish : out STD_LOGIC_vector(5 downto 0);
				en_discover_bloc : out  STD_LOGIC;
				en_graph_memo : out  STD_LOGIC;
				en_GRID : out STD_LOGIC;
				en_mux_aff :out STD_LOGIC;
				en_cpt_line: out  STD_LOGIC;
				rst_cpt_line : out  STD_LOGIC;
				en_cpt_col: out  STD_LOGIC;
				rst_cpt_col : out  STD_LOGIC);
				
end component states_machine_display;				


component counter9_STD is
    Port ( 	clk : in  STD_LOGIC;
				ce : in  STD_LOGIC;
				rst : in STD_LOGIC;
				counterOut : out  STD_LOGIC_VECTOR(3 downto 0));
end component counter9_STD;









signal sig_data_in,sig_data_in_grille, sig_data_in_dis, sig_color_data : STD_LOGIC_VECTOR (2 downto 0);
signal sig_data_write, sig_data_write_grille, sig_data_write_dis : STD_LOGIC;
signal sig_ADDR,sig_ADDR_grille, sig_ADDR_dis : STD_LOGIC_VECTOR (13 downto 0);

signal sig_en_discover_bloc,sig_en_cpt_line : STD_LOGIC;
signal sig_cpt_col,sig_cpt_line : STD_LOGIC_VECTOR (3 downto 0);
signal sig_line_data : STD_LOGIC_VECTOR (8 downto 0);

signal sig_en_graph_memo,sig_en_cpt_col,sig_rst_cpt_col,sig_rst_cpt_line,sig_en_GRID,sig_en_mux_aff  : STD_LOGIC;


begin



gestion_affichage : VGA_bitmap_160x100 port map (  clk 			=> clk,       
																	reset  		=> rst,    
																	VGA_hs   	=> vga_hs,  
																	VGA_vs   	=> vga_vs,  
																	VGA_red  	=> vga_red,  
																	VGA_green	=> vga_green,  
																	VGA_blue 	=> vga_blue,  
																	
																	ADDR       	=> sig_ADDR, 
																	data_in    	=> sig_data_in,
																	data_write 	=> sig_data_write,
																	data_out   	=> data_out);
														

mux_mem_vga : mux_vga port map ( --selection =>  en1,
											selection =>  sig_en_mux_aff,
											input_data_in_1 => sig_data_in_grille ,
											input_data_in_2  => sig_data_in_dis ,
											input_addr_1  => sig_ADDR_grille ,
											input_addr_2  =>  sig_ADDR_dis,
											input_write_1  => sig_data_write_grille ,
											input_write_2  =>  sig_data_write_dis,
											
											output_data_in  => sig_data_in ,
											output_addr  =>  sig_ADDR,
											output_write => sig_data_write);
											
											
affichage_grille : vga_grille port map (  			clk 			=> clk,       
																	rst  			=> rst, 
																	en		 		=>	sig_en_GRID,
																	line			=> posy,
																	col 			=> posx,
																	--end_bloc		=> sig_end_bloc_unuseful,
																	ADDR       	=> sig_ADDR_grille, 
																	data_in    	=> sig_data_in_grille,
																	data_write 	=> sig_data_write_grille);
																	
																	
																	
																													


										
														

position : discover_graphic  port map(   clk => clk,
													  rst => rst,
													  en => sig_en_discover_bloc,
													  pos_x => posx,
													  pos_y => posy,
													  cpt_col_graph=>sig_cpt_col,
													  cpt_line_graph=>sig_cpt_line,
													  line_data =>sig_line_data,
													  color_data=> sig_color_data,
													  

													  ADDR => sig_ADDR_dis,
													  data_in => sig_data_in_dis,
													  data_write => sig_data_write_dis);
													  
													 
			  
															
															
memo_graphic: top_graph_mem  port map( 	clk => clk,
															rst => rst,
															en => sig_en_graph_memo,
															line_chose =>sig_cpt_line,
															value => value,

															line_data_out => sig_line_data,
															color_data_out =>sig_color_data);
															



Counter_col :   counter9_STD   port map(		clk => clk,
															ce => sig_en_cpt_col,
															rst =>  sig_rst_cpt_col,
															counterOut => sig_cpt_col);
															
Counter_line :   counter9_STD   port map(		clk => clk,
															ce => sig_en_cpt_line,
															rst =>  sig_rst_cpt_line,
															counterOut => sig_cpt_line);

FMS_Graphic :   states_machine_display   port map(		clock => clk,
																		reset => rst,
																		cpt_line =>sig_cpt_line,
																		cpt_col =>sig_cpt_col,
																		discover_bp =>discover_bp,
																		
																		en_led_finish =>LEDF,
																		en_discover_bloc=> sig_en_discover_bloc,
																		en_graph_memo => sig_en_graph_memo ,
																		en_GRID => sig_en_GRID,
																		en_mux_aff =>sig_en_mux_aff ,
																		en_cpt_line=> sig_en_cpt_line,
																		rst_cpt_line =>sig_rst_cpt_line,
																		en_cpt_col => sig_en_cpt_col,
																		rst_cpt_col => sig_rst_cpt_col );




--sig_end_bloc_unuseful<='1';																	
			  

end Behavioral;

