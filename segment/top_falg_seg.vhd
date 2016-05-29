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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_falg_seg is
    Port ( clk : in  STD_LOGIC;
           Ce_mux : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  number_in : IN STD_LOGIC_VECTOR(7 downto 0);
			  EN_display : out STD_LOGIC_VECTOR(3 downto 0);
           Def_7Seg : out  STD_LOGIC_VECTOR (6 downto 0));
end top_falg_seg;

architecture Behavioral of top_falg_seg is

  component counter is
     port ( clk : in  STD_LOGIC;
       	   c_enable : in  STD_LOGIC;
				rst : in STD_LOGIC;
           	output : out  STD_LOGIC_VECTOR(1 downto 0));
  end component counter ;
  
  component digit_display is
     port ( clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				digit_load : in STD_LOGIC_VECTOR( 1 downto 0);
				EN_display : out STD_LOGIC_VECTOR(3 downto 0));
  end component digit_display ;
 
  component mux_aff is
     port ( selection : in STD_LOGIC_VECTOR(1 downto 0);
				inputA : in  STD_LOGIC_VECTOR (3 downto 0);
				inputB : in  STD_LOGIC_VECTOR (3 downto 0);
				inputC : in  STD_LOGIC_VECTOR (3 downto 0);
				inputD : in  STD_LOGIC_VECTOR (3 downto 0);
				output : out  STD_LOGIC_VECTOR (3 downto 0));
  end component mux_aff ;
  
  component transdecoder is
     port ( data: in  STD_LOGIC_VECTOR (3 downto 0);
				seg : out  STD_LOGIC_VECTOR (6 downto 0));
  end component transdecoder ;
  
  component converter_vector_into_digit is

    Port ( number_in : in  STD_LOGIC_VECTOR (7 downto 0);
           unit : out  STD_LOGIC_VECTOR (3 downto 0);
           decade : out  STD_LOGIC_VECTOR (3 downto 0);
			  hundred : out STD_LOGIC_VECTOR (3 downto 0);
			  thousand : out STD_LOGIC_VECTOR (3 downto 0));
			  
	end component converter_vector_into_digit;
  
  



signal sig_unit,sig_decade,sig_hundred,sig_thousand,sig_data_trascoder : STD_LOGIC_VECTOR (3 downto 0);
signal sig_number_choose : STD_LOGIC_VECTOR(1 downto 0);
signal sig_flash_state :  STD_LOGIC;
  
begin

counter_aff : counter port map ( 	clk => clk,
												c_enable => Ce_mux,
												rst =>  rst,
												output =>  sig_number_choose);
						
						
digit_gestion : digit_display port map ( 	clock => clk,
														reset => rst,
														digit_load =>sig_number_choose ,
														EN_display => EN_display);
	

mux : mux_aff port map ( 	selection =>sig_number_choose ,
									inputA =>  sig_unit,
									inputB =>  sig_decade,
									inputC =>  sig_hundred,
									inputD =>  sig_thousand,
									output => sig_data_trascoder);

transcoder : transdecoder port map ( 	data => sig_data_trascoder ,
													seg =>  Def_7Seg);
													
converter : converter_vector_into_digit port map ( 	number_in =>number_in ,
																  unit =>sig_unit ,
																  decade =>sig_decade ,
																  hundred =>sig_hundred ,
																  thousand =>sig_thousand);

												

end Behavioral;

