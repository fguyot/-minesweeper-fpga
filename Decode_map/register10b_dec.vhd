
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity reg_decal_10bit is
    Port ( 	input : in  STD_LOGIC_VECTOR (9 downto 0);          
				clock : in  STD_LOGIC;
				load : in STD_LOGIC;
				ce : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				output_n1 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_n2 : out  STD_LOGIC_VECTOR (9 downto 0);
				output_n3 : out  STD_LOGIC_VECTOR (9 downto 0));
end reg_decal_10bit;

architecture Behavioral of reg_decal_10bit is


  component register_10bit is
  
    Port ( 	input : in  STD_LOGIC_VECTOR (9 downto 0);          
				clock : in  STD_LOGIC;
				load : in STD_LOGIC;
				ce : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				output : out  STD_LOGIC_VECTOR (9 downto 0));
			  
  end component register_10bit ;

signal out_n1,out_n2,out_n3: STD_LOGIC_VECTOR (9 downto 0);

  
begin

registre0: register_10bit     Port map (	input => input ,          
														clock => clock ,  
														load => load ,  
														ce => ce ,  
														reset => reset ,  
														output =>  out_n1);

registre1 : register_10bit     Port map (		input => out_n1 ,          
														clock => clock ,  
														load => load ,  
														ce => ce ,  
														reset => reset ,  
														output => out_n2 );
												
												
registre2 : register_10bit     Port map (	input => out_n2 ,          
														clock => clock ,  
														load => load ,  
														ce => ce ,  
														reset => reset ,  
														output => out_n3 );							
				
output_n1 <=out_n1 ;	
output_n2 <= out_n2 ;	
output_n3 <= out_n3 ;					


end Behavioral;

