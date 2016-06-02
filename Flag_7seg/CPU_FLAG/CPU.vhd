----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:46:58 03/18/2016 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
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

entity CPU is
    Port ( clk : in  STD_LOGIC;
           ce : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  ext_mem : in STD_LOGIC;
			  en_memory : in STD_LOGIC;
			  rw_memory : in STD_LOGIC;
			  adr : in  STD_LOGIC_VECTOR (5 downto 0);
           data_mem_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_mem_out : out  STD_LOGIC_VECTOR (7 downto 0));
end CPU;

architecture Behavioral of CPU is

  component control_unit is
     port ( clk : in  STD_LOGIC;
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
  end component control_unit ;
  
   component operative_unit is
     port ( clk : in  STD_LOGIC;
          	rst : in  STD_LOGIC;
				clock_enable : in  STD_LOGIC;
          	sel_UAL : in  STD_LOGIC;
				init_carry: in  STD_LOGIC;
				load_carry: in  STD_LOGIC;
				load_ACU: in  STD_LOGIC;
				load_reg_data: in  STD_LOGIC;
				RAM_out: in STD_LOGIC_VECTOR (7 downto 0);
				state_carry : out STD_LOGIC;
           	RAM_in : out  STD_LOGIC_VECTOR (7 downto 0));
  end component operative_unit ;
  
  component RAM64o is
     port (  	clk : in  STD_LOGIC;
					rst : in  STD_LOGIC;
					enable_memory : in  STD_LOGIC;
					read_write : in  STD_LOGIC;
					mem_add : in  STD_LOGIC_VECTOR (5 downto 0);
					data_in : in  STD_LOGIC_VECTOR (7 downto 0);
					data_out : out  STD_LOGIC_VECTOR (7 downto 0));
					
  end component RAM64o ;
  
  component Mux_bus is
    Port ( 	selection : in STD_LOGIC;
				inputA : in  STD_LOGIC_VECTOR (5 downto 0);
				inputAA : in  STD_LOGIC_VECTOR (7 downto 0);
				inputAAA : in STD_LOGIC;
				inputAAAA : in STD_LOGIC;
				inputB : in  STD_LOGIC_VECTOR (5 downto 0);
				inputBB : in  STD_LOGIC_VECTOR (7 downto 0);
				inputBBB : in STD_LOGIC;
				inputBBBB : in STD_LOGIC;
				output0 : out  STD_LOGIC_VECTOR (5 downto 0);
				output1 : out  STD_LOGIC_VECTOR (7 downto 0);
				output2 : out  STD_LOGIC;
				output3 : out  STD_LOGIC);
end component Mux_bus;
  
signal sig_data_in_ut,sig_data_out_ut,sig_data_in_mem : STD_LOGIC_VECTOR (7 downto 0);
signal sig_adress_mem ,sig_adress_uc: STD_LOGIC_VECTOR (5 downto 0);
signal sig_sel_UAL,sig_init_carry ,sig_load_carry ,sig_load_ACU,sig_load_reg_data,sig_RW_uc,sig_en_mem,sig_carry,sig_en_mem_int,sig_rw_mem : STD_LOGIC;
  
begin

RAM : RAM64o port map ( 	clk => clk,
									rst => reset,
									enable_memory => sig_en_mem,
									read_write => sig_rw_mem,
									mem_add => sig_adress_mem,
									data_in => sig_data_in_mem,
									data_out => sig_data_in_ut);
									
UC : control_unit port map ( 	clk => clk,
										rst => reset,
										clk_enable => ce,
										carry_in => sig_carry,
										reg_inst_in =>sig_data_in_ut,
										init_carry => sig_init_carry,
										sel_UAL => sig_sel_UAL,
										load_carry => sig_load_carry,
										load_ACU => sig_load_ACU,
										load_reg_data => sig_load_reg_data,
										enable_memory => sig_en_mem_int,
										read_write_memory => sig_RW_uc,
										mux_out =>sig_adress_uc );
										
UT : operative_unit port map ( 	clk => clk,
											rst => reset,
											clock_enable => ce,
											sel_UAL => sig_sel_UAL,
											init_carry => sig_init_carry,
											load_carry => sig_load_carry,
											load_ACU => sig_load_ACU,
											load_reg_data => sig_load_reg_data,
											RAM_out => sig_data_in_ut,
											state_carry => sig_carry,
											RAM_in => sig_data_out_ut);
											
bus_mux: Mux_bus port map ( 		selection => ext_mem,
											inputA => sig_adress_uc,
											inputAA => sig_data_out_ut,
											inputAAA => sig_RW_uc,
											inputAAAA => sig_en_mem_int,
											inputB => adr,
											inputBB => data_mem_in,
											inputBBB => rw_memory,
											inputBBBB => en_memory,
											output0 => sig_adress_mem,
											output1 => sig_data_in_mem,
											output2 => sig_rw_mem,
											output3 => sig_en_mem);
											

data_mem_out <= sig_data_in_ut;


end Behavioral;
