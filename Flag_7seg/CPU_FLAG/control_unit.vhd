----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:51:02 03/15/2016 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity control_unit is

    Port ( 	clk : in  STD_LOGIC;
          	rst : in  STD_LOGIC;
				clk_enable : in  STD_LOGIC;
          	carry_in : in  STD_LOGIC;
				reg_inst_in: in STD_LOGIC_VECTOR (7 downto 0);
				init_carry : out STD_LOGIC;
				sel_UAL : out STD_LOGIC;
				load_carry : out STD_LOGIC;
				load_ACU : out STD_LOGIC;
				load_reg_data : out STD_LOGIC;
				enable_memory : out STD_LOGIC;
				read_write_memory : out STD_LOGIC;
           	mux_out : out  STD_LOGIC_VECTOR (5 downto 0));
end control_unit;

architecture Behavioral of control_unit is

  component memory is
     port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
          	clock : in  STD_LOGIC;
				load : in STD_LOGIC;
         	enable : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
           	output : out  STD_LOGIC_VECTOR (7 downto 0));
  end component memory ;


 component compteur is
     port ( 	clk : in  STD_LOGIC;
					rst : in  STD_LOGIC;
					clk_enable : in  STD_LOGIC;
					init_cpt : in  STD_LOGIC;
					load_cpt : in  STD_LOGIC;
					enable_cpt : in  STD_LOGIC;
					instruction : in  STD_LOGIC_VECTOR (5 downto 0);
					next_instruction : out  STD_LOGIC_VECTOR (5 downto 0));
  end component compteur ;
  
   component states_machine is
     port ( 	clock : in  STD_LOGIC;
					reset : in  STD_LOGIC;
					CE : in  STD_LOGIC;
					carry : in  STD_LOGIC;
					operation_code : in  STD_LOGIC_VECTOR (1 downto 0);
					Init_cpt : out  STD_LOGIC;
					Enable_cpt : out  STD_LOGIC;
					Load_cpt : out  STD_LOGIC;
					Sel_mux : out  STD_LOGIC;
					Load_register_instruction : out  STD_LOGIC;
					Enable_memory : out  STD_LOGIC;
					Read_write : out  STD_LOGIC;
					Sel_UAL : out  STD_LOGIC;
					Init_carry : out  STD_LOGIC;
					Load_carry : out  STD_LOGIC;
					Load_ACU : out  STD_LOGIC;
					Load_register_data : out  STD_LOGIC);
  end component states_machine ;
  
  
   component mux is
     port ( selection : in STD_LOGIC;
				inputA : in  STD_LOGIC_VECTOR (5 downto 0);
				inputB : in  STD_LOGIC_VECTOR (5 downto 0);
				output : out  STD_LOGIC_VECTOR (5 downto 0));
  end component mux ;
				
  
signal sig_reg_inst_out : STD_LOGIC_VECTOR (7 downto 0);
signal sig_cpt_out : STD_LOGIC_VECTOR (5 downto 0);
signal sig_init_cpt, sig_enable_cpt, sig_load_cpt,sig_sel_mux,sig_load_inst : STD_LOGIC;
  
begin

FSM : states_machine port map ( 	clock => clk,
											reset => rst,
											CE => clk_enable,
											carry => carry_in,
											operation_code => sig_reg_inst_out(7 downto 6),
											Init_cpt => sig_init_cpt,
											Enable_cpt => sig_enable_cpt,
											Load_cpt => sig_load_cpt,
											Sel_mux => sig_sel_mux,
											Load_register_instruction => sig_load_inst,
											Enable_memory => enable_memory,
											Read_write => read_write_memory,
											Sel_UAL => sel_UAL,
											Init_carry => init_carry,
											Load_carry => load_carry,
											Load_ACU => load_ACU,
											Load_register_data => load_reg_data);
													
Reg_Inst : memory port map ( 	input => reg_inst_in,
										clock => clk,
										load => sig_load_inst,
										enable => clk_enable,
										reset => rst,
										output => sig_reg_inst_out);
										
counter : compteur port map ( 	clk => clk,
											rst => rst,
											clk_enable => clk_enable,
											init_cpt => sig_init_cpt,
											load_cpt => sig_load_cpt,
											enable_cpt => sig_enable_cpt,
											instruction => sig_reg_inst_out(5 downto 0),
											next_instruction =>sig_cpt_out );
											
										
multiplexer : mux port map (	selection => sig_sel_mux,
										inputA => sig_cpt_out,
										inputB => sig_reg_inst_out(5 downto 0),
										output => mux_out);

end Behavioral;

