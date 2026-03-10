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

entity nr_sm is
    Port ( ld_sm : in STD_LOGIC;
           rst_sm : in STD_LOGIC;
           en_sm : in STD_LOGIC;
           num_in : in STD_LOGIC_VECTOR (0 to 4);
           num_out : out STD_LOGIC_VECTOR (0 to 4);
           clk : in STD_LOGIC;
           final_sm: out STD_LOGIC);
end nr_sm;

architecture Behavioral of nr_sm is

signal num :STD_LOGIC_VECTOR (0 to 4);

begin

process(clk, rst_sm, ld_sm, en_sm)
begin
if rst_sm = '1' then
    num <= (others => 'U');
else
    if clk'event and clk = '1' then
        if en_sm = '1' then
          if ld_sm = '1' then
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

if num = "10110" then
    final_sm <= '1';
else
    final_sm <= '0';
end if;
end process;

num_out <= num;

end Behavioral;