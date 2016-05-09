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

entity top_memory_grid_100 is
    Port ( 	clk : in  STD_LOGIC;
           	rst : in  STD_LOGIC;
				sel : in STD_LOGIC;
				flag: in STD_LOGIC;
           	posX : in  STD_LOGIC_VECtOR(3 downto 0);
				posY : in  STD_LOGIC_VECtOR(3 downto 0);


				addr_decode : in  STD_LOGIC_VECTOR (6 downto 0);
				data_in_decode : in  STD_LOGIC_VECTOR (5 downto 0);
				write_decode : in  STD_LOGIC;
				enable_memory_decode : in  STD_LOGIC;

				sel_out : out  STD_LOGIC;
				data_out : out  STD_LOGIC_VECTOR (3 downto 0));
  
end top_memory_grid_100;

architecture Behavioral of top_memory_grid_100 is



component memory_grid100 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           enable_memory : in  STD_LOGIC;
           read_write : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (5 downto 0);
           mem_add : in  STD_LOGIC_VECTOR (6 downto 0);
           --sel_out : out  STD_LOGIC;
			  data_out : out  STD_LOGIC_VECTOR (3 downto 0));

end component memory_grid100;

component pos_to_add is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           posX : in  STD_LOGIC_VECTOR(3 downto 0);
           posY : in  STD_LOGIC_VECTOR(3 downto 0);
           adress : out  STD_LOGIC_VECTOR (6 downto 0));
end component pos_to_add;

component mux_memory is
    Port ( 	selection : in STD_LOGIC;
		input_data_in_decode: in  STD_LOGIC_VECTOR (5 downto 0);
		
		input_addr_pos: in  STD_LOGIC_VECTOR (6 downto 0);
		input_addr_decode : in  STD_LOGIC_VECTOR (6 downto 0);

		input_write_decode : in  STD_LOGIC;
		input_enable_memory_decode : in  STD_LOGIC;
		
		output_data_in : out  STD_LOGIC_VECTOR (5 downto 0);
		output_addr : out  STD_LOGIC_VECTOR (6 downto 0);
		output_write: out  STD_LOGIC;
		output_enable_memory: out STD_LOGIC);
end component mux_memory ;



component mux_data_out is

  Port (	selection : in STD_LOGIC;
			input_data_mem_2bits: in  STD_LOGIC_VECTOR (3 downto 0);
			input_mem_grid: in  STD_LOGIC_VECTOR (3 downto 0);
			output_data_out : out  STD_LOGIC_VECTOR (3 downto 0));
		
end component mux_data_out ;



component mem_flag_2bits is

    Port ( discover : in  STD_LOGIC;
           flag : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           adress : in  STD_LOGIC_VECTOR (6 downto 0);
           sel : out  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (3 downto 0));
			  
end component mem_flag_2bits;




signal sig_data_in : STD_LOGIC_VECTOR(5 downto 0);
signal sig_add_in,sig_add_pos : STD_LOGIC_VECTOR(6 downto 0);
signal sig_mem_write,sig_enable_memory,sig_sel_out: STD_LOGIC;
signal sig_input_data_mem_2bits,sig_input_mem_grid:STD_LOGIC_VECTOR(3 downto 0);

  
begin


Memory : memory_grid100 port map ( 	clk => clk,
												rst => rst,
												enable_memory => sig_enable_memory,
												read_write => sig_mem_write,
												mem_add => sig_add_in,
												data_in => sig_data_in,
												data_out => sig_input_mem_grid);

Converter : pos_to_add port map ( 	   clk => clk,
													rst => rst,
													posX => posX,
													posY => posY,
													adress => sig_add_pos);

Mux : mux_memory port map ( 	selection => sel,
										input_data_in_decode => data_in_decode,
								
										input_addr_pos => sig_add_pos,
										input_addr_decode => addr_decode,

										input_write_decode => write_decode,
										input_enable_memory_decode => enable_memory_decode,
								
										output_data_in => sig_data_in,
										output_addr => sig_add_in,
										output_write => sig_mem_write,
										output_enable_memory=> sig_enable_memory);		


Mem_flag : mem_flag_2bits port map ( 	discover => sel,
													flag =>flag,
													clk =>clk,
													rst =>rst,
													adress => sig_add_pos,
													sel =>sig_sel_out,
													data_out =>sig_input_data_mem_2bits);


Mux_data :	mux_data_out  Port map (	selection => sig_sel_out,
													input_data_mem_2bits => sig_input_data_mem_2bits,
													input_mem_grid => sig_input_mem_grid,
													output_data_out => data_out);									
															       

sel_out <= sig_sel_out;
end Behavioral;

