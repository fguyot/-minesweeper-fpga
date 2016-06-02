----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:35:56 03/15/2016 
-- Design Name: 
-- Module Name:    operative_unit - Behavioral 
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



entity operative_unit is
    Port ( 	clk : in  STD_LOGIC;
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
end operative_unit; 

architecture Behavioral of operative_unit is

  component memory is
     port ( input : in  STD_LOGIC_VECTOR (7 downto 0);
          	clock : in  STD_LOGIC;
				load : in STD_LOGIC;
         	enable : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
           	output : out  STD_LOGIC_VECTOR (7 downto 0));
  end component memory ;



 component flipflop is
     port ( 	input : in  STD_LOGIC;
					init : in STD_LOGIC;
					clock : in  STD_LOGIC;
					load : in STD_LOGIC;
					enable : in  STD_LOGIC;
					reset : in  STD_LOGIC;
					output : out  STD_LOGIC);
  end component flipflop ;

  
  component UAL is
     port ( 	sel_UAL : in  STD_LOGIC;
					data : in  STD_LOGIC_VECTOR (7 downto 0);
					accu : in  STD_LOGIC_VECTOR (7 downto 0);
					carry : out  STD_LOGIC;
					result : out  STD_LOGIC_VECTOR (7 downto 0));
  end component UAL ;

signal sig_out_reg_data,sig_out_reg_ACU,sig_out_UAL : STD_LOGIC_VECTOR (7 downto 0);
signal sig_carry_in : STD_LOGIC;


begin

Aritmetic_logic_unit : UAL port map ( 	sel_UAL =>sel_UAL,
													data => sig_out_reg_data,
													accu => sig_out_reg_ACU,
													carry=>sig_carry_in,
													result => sig_out_UAL);
					
Reg_data : memory port map ( 	input => RAM_out,
										clock => clk,
										load => load_reg_data,
										enable => clock_enable,
										reset => rst,
										output => sig_out_reg_data);
										
Reg_ACU : memory port map ( 	input => sig_out_UAL,
										clock => clk,
										load => load_ACU,
										enable => clock_enable,
										reset => rst,
										output => sig_out_reg_ACU);

carrry : flipflop port map ( 	input => sig_carry_in,
										init => init_carry,
										clock => clk,
										load => load_carry,
										enable => clock_enable,
										reset => rst,
										output => state_carry);
											
RAM_in<= sig_out_reg_ACU;
										 
end Behavioral;



