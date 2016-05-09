
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top_create_grid is
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
end top_create_grid;

architecture Behavioral of top_create_grid is


  component register_10bit_stat is
  
    Port ( 			input : in  STD_LOGIC_VECTOR (9 downto 0);          
				clock : in  STD_LOGIC;
				--load : in STD_LOGIC;
				--ce : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				output : out  STD_LOGIC_VECTOR (9 downto 0));
			  
  end component register_10bit_stat ;


constant l0_cst : std_logic_vector(9 downto 0) :="0000000001";
constant l1_cst : std_logic_vector(9 downto 0) :="0000001100";
constant l2_cst : std_logic_vector(9 downto 0) :="0000000000";
constant l3_cst : std_logic_vector(9 downto 0) :="0000010000";
constant l4_cst : std_logic_vector(9 downto 0) :="0000000000";
constant l5_cst : std_logic_vector(9 downto 0) :="0001000000";
constant l6_cst : std_logic_vector(9 downto 0) :="0000000000";
constant l7_cst : std_logic_vector(9 downto 0) :="0000010000";
constant l8_cst : std_logic_vector(9 downto 0) :="0000000000";
constant l9_cst : std_logic_vector(9 downto 0) :="1000000001";

  
begin

registre0: register_10bit_stat     Port map (	input => l0_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l0);

registre1: register_10bit_stat     Port map (	input => l1_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l1);

registre2: register_10bit_stat     Port map (	input => l2_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l2);


registre3: register_10bit_stat     Port map (	input => l3_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l3);

registre4: register_10bit_stat     Port map (	input => l4_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l4);

registre5: register_10bit_stat     Port map (	input => l5_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l5);

registre6: register_10bit_stat     Port map (	input => l6_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l6);


registre7: register_10bit_stat     Port map (	input => l7_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l7);

registre8: register_10bit_stat     Port map (	input => l8_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l8);


registre9: register_10bit_stat     Port map (	input => l9_cst ,          
						clock => clock ,  
						--load => load ,  
						--ce => ce ,  
						reset => reset ,  
						output =>  output_l9);




end Behavioral;

