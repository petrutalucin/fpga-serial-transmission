----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: date_serial - Behavioral
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

entity date_serial is
    Port ( pachet : in STD_LOGIC_VECTOR (0 to 26);
           poz : in STD_LOGIC_VECTOR (0 to 4);
           enable: in std_logic;
           num: in std_logic_vector(0 to 1);
           data: out STD_LOGIC);
end date_serial;

architecture Behavioral of date_serial is 

begin

process(enable, poz, pachet, num)

begin
    if enable = '1' and num = "01" then
        data <= pachet(conv_integer(poz));
    else
        if enable = '1' and num = "10" then
            data <= pachet(conv_integer(poz));
        else
           if enable = '1' and num = "11" then
                    data <= pachet(conv_integer(poz));
           else
                 data <= '0';
           end if;
        end if;
    end if;
end process;
end Behavioral;
