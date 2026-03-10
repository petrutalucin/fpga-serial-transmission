----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name: NUMARATOR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nr_ss is
    Port ( ld_ss : in STD_LOGIC;
           rst_ss : in STD_LOGIC;
           en_ss : in STD_LOGIC;
           num_in : in STD_LOGIC_VECTOR (0 to 4);
           num_out : out STD_LOGIC_VECTOR (0 to 4);
           clk : in STD_LOGIC;
           final_ss: out STD_LOGIC);
end nr_ss;

architecture Behavioral of nr_ss is

signal num :STD_LOGIC_VECTOR (0 to 4);

begin

process(clk, rst_ss, ld_ss, en_ss)
begin
if rst_ss = '1' then
    num <= (others => 'U');
else
    if clk'event and clk = '1' then
        if en_ss = '1' then
          if ld_ss = '1' then
            num <= num_in;
          else
            num <= num + 1;
          end if;
        end if;
     end if;
end if;
end process;

process(num)
begin

if num = "00110" then
    final_ss <= '1';
else
    final_ss <= '0';
end if;
end process;

num_out <= num;

end Behavioral;