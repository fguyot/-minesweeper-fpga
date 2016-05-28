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

entity top_aff is
    Port ( clk : in  STD_LOGIC;
           Ce_mux : in  STD_LOGIC;
           Ce_cli : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           unit : in  STD_LOGIC_VECTOR (3 downto 0);
           decade : in  STD_LOGIC_VECTOR (3 downto 0);
           hundred : in  STD_LOGIC_VECTOR (3 downto 0);
           hundred_flash : in  STD_LOGIC;
           decade_flash : in  STD_LOGIC;
           unit_flash : in  STD_LOGIC;
           en_hundred : out  STD_LOGIC;
           en_decade : out  STD_LOGIC;
           en_unit : out  STD_LOGIC;
           Def_7Seg : out  STD_LOGIC_VECTOR (6 downto 0));
end top_aff;

architecture Behavioral of top_aff is

  component counter2 is
     port ( clk : in  STD_LOGIC;
       	   c_enable : in  STD_LOGIC;
				rst : in STD_LOGIC;
           	output : out  STD_LOGIC_VECTOR (1 downto 0));
  end component counter2 ;
  
  component digit_display is
     port ( clock : in  STD_LOGIC;
           	reset : in  STD_LOGIC;
				digit_load : in STD_LOGIC_VECTOR(1 downto 0);
				unit_flash : in STD_LOGIC;
				decade_flash : in STD_LOGIC;
				hundred_flash : in STD_LOGIC;
				flash_state : in STD_LOGIC;
				unit_display : out STD_LOGIC;
				decade_display :out STD_LOGIC;
				hundred_display : out STD_LOGIC);
  end component digit_display ;
 
  component mux_aff is
     port ( selection : in STD_LOGIC_VECTOR(1 downto 0);
				inputA : in  STD_LOGIC_VECTOR (3 downto 0);
				inputB : in  STD_LOGIC_VECTOR (3 downto 0);
				inputC : in  STD_LOGIC_VECTOR(3 downto 0);
				output : out  STD_LOGIC_VECTOR (3 downto 0));
  end component mux_aff ;
  
  component transdecoder is
     port ( data: in  STD_LOGIC_VECTOR (3 downto 0);
				seg : out  STD_LOGIC_VECTOR (6 downto 0));
  end component transdecoder ;
  
  component clignotement is
     port ( clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				h_cli : in  STD_LOGIC;
				EtatClignotement : out  STD_LOGIC);
  end component clignotement ;



signal sig_data_trascoder : STD_LOGIC_VECTOR (3 downto 0);
signal sig_number_choose : STD_LOGIC_VECTOR (1 downto 0);
signal sig_flash_state :  STD_LOGIC;
  
begin

counter_aff : counter2 port map ( 	clk => clk,
												c_enable => Ce_mux,
												rst =>  rst,
												output =>  sig_number_choose);
						
						
digit_gestion : digit_display port map ( 	clock => clk,
														reset => rst,
														digit_load =>sig_number_choose ,
														unit_flash => unit_flash ,
														decade_flash => decade_flash ,
														hundred_flash =>  hundred_flash,
														flash_state =>  sig_flash_state,
														unit_display =>  en_unit,
														decade_display => en_decade ,
														hundred_display =>  en_hundred);
	

mux : mux_aff port map ( 	selection =>sig_number_choose ,
									inputA =>  unit,
									inputB =>  decade,
									inputC =>  hundred,
									output => sig_data_trascoder);

transcoder : transdecoder port map ( 	data => sig_data_trascoder ,
													seg =>  Def_7Seg);
													
													
flash_generator : clignotement port map ( 	clk => clk ,
															rst => rst ,
															h_cli => Ce_cli ,
															EtatClignotement => sig_flash_state );


end Behavioral;

