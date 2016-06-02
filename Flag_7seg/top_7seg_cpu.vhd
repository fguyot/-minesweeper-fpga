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
entity top_7seg_cpu is


    Port ( 	clk 				: in  STD_LOGIC;
				rst 				: in  STD_LOGIC;
				EN					: in STD_LOGIC;
				Ce_mux			: in STD_LOGIC;
				operation		: in STD_LOGIC;
				signe				: in STD_LOGIC;
				
				EN_display		: out	STD_LOGIC_VECTOR(3 downto 0);
				value_7seg		: out	STD_LOGIC_VECTOR( 6 downto 0));
end top_7seg_cpu;

architecture Behavioral of top_7seg_cpu is


component top_falg_seg is
    Port ( clk : in  STD_LOGIC;
           Ce_mux : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  number_in : IN STD_LOGIC_VECTOR(7 downto 0);
			  EN_display : out STD_LOGIC_VECTOR(3 downto 0);
           Def_7Seg : out  STD_LOGIC_VECTOR (6 downto 0));
end component top_falg_seg;

component bp_pulse is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           bp : in  STD_LOGIC;
           output : out  STD_LOGIC);
			  
end component bp_pulse;


component CPU is
    Port ( clk : in  STD_LOGIC;
           ce : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  ext_mem : in STD_LOGIC;
			  en_memory : in STD_LOGIC;
			  rw_memory : in STD_LOGIC;
			  adr : in  STD_LOGIC_VECTOR (5 downto 0);
           data_mem_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_mem_out : out  STD_LOGIC_VECTOR (7 downto 0));
end component CPU;


component states_machine_cpu is
    Port (	clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				CE : in  STD_LOGIC;
				bp_operation : in  STD_LOGIC;
				signe : in  STD_LOGIC;
				cpt : in  STD_LOGIC;
				
				rst_CPU : out  STD_LOGIC;
				EN_CPU : out  STD_LOGIC;
				EN_ext : out STD_LOGIC;
				adress_memory : out  STD_LOGIC_VECTOR (5 downto 0);
				data_in_memory : out  STD_LOGIC_VECTOR (7 downto 0);
				rw_memory : out  STD_LOGIC;
				en_memory : out STD_LOGIC;
				EN_cpt : out  STD_LOGIC;
				rst_cpt : out  STD_LOGIC );	

			 
end component states_machine_cpu;


component wait100 is
    Port ( 	clock : in  STD_LOGIC;
				ce : in  STD_LOGIC;
				reset : in STD_LOGIC;
				end_wait : out  STD_LOGIC);
end component wait100;


signal sig_bp_ope : STD_LOGIC;
signal sig_rst_cpt,sig_en_cpt,sig_EN_CPU,sig_rst_CPU,sig_rw_memory,sig_EN_ext,sig_en_memory,sig_end_cpt : STD_LOGIC;
signal sig_number_display, sig_data_in_CPU : STD_LOGIC_VECTOR( 7 downto 0);
signal sig_add_CPU :  STD_LOGIC_VECTOR( 5 downto 0);


begin
														

Seg7_flag_bloc : top_falg_seg port map (  	  clk => clk,
															  Ce_mux => Ce_mux,
															  rst => rst ,
															  number_in => sig_number_display,
															  EN_display => EN_display,
															  Def_7Seg => value_7seg );
															  
															  
														  
CPU_flag : CPU port map (    clk => clk,
									  ce => sig_EN_CPU,
									  reset => sig_rst_CPU,
									  ext_mem => sig_EN_ext,
									  en_memory => sig_en_memory,
									  rw_memory => sig_rw_memory,
									  adr  => sig_add_CPU,
									  data_mem_in => sig_data_in_CPU,
									  data_mem_out => sig_number_display);
									  
									  
pulse_bp : bp_pulse port map (  clock => clk,
										  reset => rst,
										  bp => operation,
										  output => sig_bp_ope );
										  
										  
fsm_cpu : states_machine_cpu port map (  	clock => clk,
														reset => rst,
														CE => EN,
														bp_operation => sig_bp_ope,
														signe => signe,
														cpt => sig_end_cpt,
														
														rst_CPU => sig_rst_CPU,
														EN_CPU => sig_EN_CPU,
														EN_ext => sig_EN_ext,
														adress_memory => sig_add_CPU,
														data_in_memory => sig_data_in_CPU,
														rw_memory => sig_rw_memory,
														en_memory =>sig_en_memory,
														EN_cpt => sig_en_cpt,
														rst_cpt => sig_rst_cpt);	
														
														
cpt_wait : wait100 port map (    clock => clk,
											ce => sig_en_cpt,
											reset => sig_rst_cpt,
											end_wait =>  sig_end_cpt);
									  



end Behavioral;

