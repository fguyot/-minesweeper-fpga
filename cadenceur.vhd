----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:13:12 03/21/2016 
-- Design Name: 
-- Module Name:    cadenceur - Behavioral 
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


entity cadenceur is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
	   MuxAffEn : out  STD_LOGIC;
           CCEn : out  STD_LOGIC);
end cadenceur;

architecture Behavioral of cadenceur is

			  signal sig_CCEn : unsigned  (23 downto 0);
          		  signal sig_MuxAffEn : unsigned(17 downto 0);
			  
			  signal sig_en_CCEn : std_logic;
			  signal sig_en_MuxAffEn : std_logic;

begin

process(clk, rst)	

	begin

		if (rst = '1') then
		 sig_CCEn <= (others =>'0');
		 sig_MuxAffEn<= (others =>'0');

		 
		 sig_en_CCEn <= '0';
		sig_en_MuxAffEn<='0';

		 
		 
		elsif rising_edge(clk) then
		
				if sig_CCEn < 10000000 then		--for 100ms
				sig_CCEn <= sig_CCEn+1;
				sig_en_CCEn <= '0';
				else 
				sig_CCEn <= (others =>'0');
				sig_en_CCEn <= '1';
				end if;

				if sig_MuxAffEn < 250000 then		--for 25ms
				sig_MuxAffEn <= sig_MuxAffEn+1;
				sig_en_MuxAffEn <= '0';
				else 
				sig_MuxAffEn <= (others =>'0');
				sig_en_MuxAffEn <= '1';
				end if;

				
		end if;
	end process;
		
		CCEn <= sig_en_CCEn;
		MuxAffEn <= sig_en_MuxAffEn;
		
end Behavioral;
