----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name: ROM - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port ( mode : in STD_LOGIC_VECTOR (0 to 1);
           pachet: out STD_LOGIC_VECTOR (0 to 26);
           val_fin : out STD_LOGIC_VECTOR (0 to 2);
           cod_start: out STD_LOGIC_VECTOR (0 to 6);
           sc_original : out std_logic_vector(0 to 3)
           );
end ROM;

architecture Behavioral of ROM is

type ss_type is array(0 to 1) of std_logic_vector(0 to 6);
signal ss_data : ss_type := ("0101100", "0001100");

type sm_type is array(0 to 1) of std_logic_vector(0 to 15);
signal sm_data : sm_type := ("0000000100100011", "0100010101101111");

--xor intre bitii fiecarui cuvant (ex: 0 xor 0 xor 0 xor 0; 0 xor 0 xor 0 xor 1; ...)
type sc_type is array(0 to 2) of std_logic_vector(0 to 3);
signal sc_data : sc_type := ("0111", "1000" ,"0000");

type sc_original_type is array (0 to 1) of std_logic_vector(0 to 3);
signal sc_original_data : sc_original_type := ("0110", "1000");

type val_type is array(0 to 3) of std_logic_vector(0 to 2);
signal val_data : val_type := ("111", "111", "011", "111");

begin

process (mode, ss_data, sm_data, sc_data, val_data, sc_original_data)
begin
case mode is 
    when "00" => for i in 0 to 6 loop
                    pachet(i) <= ss_data(0)(i);
                    --if i <= 5 then
                        cod_start(i) <= ss_data(0)(i);
                   -- end if;
                 end loop;
                 for i in 7 to 22 loop
                    pachet(i) <= sm_data(0)(i-7);
                 end loop;
                 for i in 23 to 26 loop
                    pachet(i) <= sc_data(0)(i-23);
                 end loop;
                 val_fin <= val_data(0);
                 sc_original <= sc_original_data(0);
                 
    when "01" => for i in 0 to 6 loop
                    pachet(i) <= ss_data(0)(i);
                    --if i <= 5 then
                        cod_start(i) <= ss_data(0)(i);
                    --end if;
                 end loop;
                 for i in 7 to 22 loop
                    pachet(i) <= sm_data(1)(i-7);
                 end loop;
                 for i in 23 to 26 loop
                    pachet(i) <= sc_data(1)(i-23);
                 end loop;
                 val_fin <= val_data(1);
                 sc_original <= sc_original_data(1);

    when "10" => for i in 0 to 6 loop
                    pachet(i) <= ss_data(1)(i);
                 end loop;
                 for i in 7 to 22 loop
                    pachet(i) <= sm_data(1)(i-7);
                 end loop;
                 for i in 23 to 26 loop
                    pachet(i) <= sc_data(1)(i-23);
                 end loop;
                 val_fin <= val_data(1);
                 sc_original <= sc_original_data(1);
                 cod_start <= "0000000";
    
    when "11" => for i in 0 to 6 loop
                    pachet(i) <= ss_data(0)(i);
                    --if i <= 5 then 
                        cod_start(i) <= ss_data(0)(i);
                    --end if;
                 end loop;
                 for i in 7 to 22 loop
                    pachet(i) <= sm_data(1)(i-7);
                 end loop;
                 for i in 23 to 26 loop
                    pachet(i) <= sc_data(0)(i-23);
                 end loop;
                 val_fin <= val_data(1);
                 sc_original <= sc_original_data(0);
                 
      when others => pachet <= "000000000000000000000000000";
end case;

end process;

end Behavioral;