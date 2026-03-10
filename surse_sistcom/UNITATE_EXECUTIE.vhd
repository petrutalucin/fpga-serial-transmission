----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name: UNITATE_EXECUTIE - Behavioral
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

entity UNITATE_EXECUTIE is
    Port (
           clk : in STD_LOGIC;
           ld_ss : in STD_LOGIC;
           en_ss : in STD_LOGIC;
           rst_ss: in STD_LOGIC;
           init_ss : in STD_LOGIC_VECTOR (0 to 4);
           final_ss: out STD_LOGIC;
           ld_sm : in STD_LOGIC;
           en_sm : in STD_LOGIC;
           rst_sm: in STD_LOGIC;
           init_sm : in STD_LOGIC_VECTOR (0 to 4);
           final_sm: out STD_LOGIC;
           ld_sc : in STD_LOGIC;
           en_sc : in STD_LOGIC;
           rst_sc: in STD_LOGIC;
           init_sc : in STD_LOGIC_VECTOR (0 to 4);
           final_sc: out STD_LOGIC;
           mode : in STD_LOGIC_VECTOR (0 to 1);
           val_fin: out STD_LOGIC_VECTOR (0 to 2);
           control: out STD_LOGIC;
           sc_calculat : out std_logic_vector(0 to 3);
           data: out STD_LOGIC;
           bit_1 : out std_logic_vector (0 to 1);
           sc_original: out std_logic_vector (0 to 3);
           val_nr_ss: out std_logic_vector (0 to 4);
           val_nr_sm : out std_logic_vector (0 to 4);
           val_nr_sc : out std_logic_vector (0 to 4);
           registru : out std_logic_vector (0 to 15));
end UNITATE_EXECUTIE;

architecture Behavioral of UNITATE_EXECUTIE is

component nr_ss is
    Port ( ld_ss : in STD_LOGIC;
           rst_ss : in STD_LOGIC;
           en_ss : in STD_LOGIC;
           num_in : in STD_LOGIC_VECTOR (0 to 4);
           num_out : out STD_LOGIC_VECTOR (0 to 4);
           clk : in STD_LOGIC;
           final_ss: out STD_LOGIC);
end component nr_ss;

component nr_sm is
    Port ( ld_sm : in STD_LOGIC;
           rst_sm : in STD_LOGIC;
           en_sm : in STD_LOGIC;
           num_in : in STD_LOGIC_VECTOR (0 to 4);
           num_out : inout STD_LOGIC_VECTOR (0 to 4);
           clk : in STD_LOGIC;
           final_sm: out STD_LOGIC);
end component nr_sm;

component nr_sc is
    Port ( ld_sc : in STD_LOGIC;
           rst_sc : in STD_LOGIC;
           en_sc : in STD_LOGIC;
           num_in : in STD_LOGIC_VECTOR (0 to 4);
           num_out : out STD_LOGIC_VECTOR (0 to 4);
           clk : in STD_LOGIC;
           final_sc: out STD_LOGIC);
end component nr_sc;

component ROM is
    Port ( mode : in STD_LOGIC_VECTOR (0 to 1);
           pachet: out STD_LOGIC_VECTOR (0 to 26);
           val_fin : out STD_LOGIC_VECTOR (0 to 2);
           cod_start: out STD_LOGIC_VECTOR (0 to 6);
           sc_original: out std_logic_vector (0 to 3));
end component ROM;

component date_serial is
    Port ( pachet : in STD_LOGIC_VECTOR (0 to 26);
           poz : in STD_LOGIC_VECTOR (0 to 4);
           enable : in STD_LOGIC;
           num: in STD_LOGIC_VECTOR (0 to 1);
           data: out STD_LOGIC);
end component date_serial;

signal xor4 : std_logic := '0';
signal num_ss: STD_LOGIC_VECTOR (0 to 4);
signal num_sm: STD_LOGIC_VECTOR (0 to 4);
signal num_sc: STD_LOGIC_VECTOR (0 to 4);
signal en1 : STD_LOGIC;
signal en2 : STD_LOGIC;
signal en3 : STD_LOGIC;
signal ss_actual: STD_LOGIC_VECTOR (0 to 4);
signal sm_actual : STD_LOGIC_VECTOR (0 to 4);
signal sc_actual : STD_LOGIC_VECTOR (0 to 4);
signal pachet: STD_LOGIC_VECTOR (0 to 26);
signal cod_start: STD_LOGIC_VECTOR(0 to 6);

signal data1 : std_logic;
signal data2 : std_logic;
signal data3 : std_logic;

signal shift_reg : std_logic_vector (0 to 15) := (others => '0');
signal aux : std_logic_vector (0 to 3) := "0000";
signal bit_1_aux: std_logic_vector (0 to 1) := "11";

begin

ROM_1 : ROM port map(mode , pachet, val_fin, cod_start, sc_original); --se ia pachetul de date complet
numarator_ss: nr_ss port map(ld_ss, rst_ss, en_ss, init_ss, ss_actual, clk, final_ss);
numarator_sm: nr_sm port map(ld_sm, rst_sm, en_sm, init_sm, sm_actual, clk, final_sm);
numarator_sc: nr_sc port map(ld_sc, rst_sc, en_sc, init_sc, sc_actual, clk, final_sc);

num_ss <= ss_actual;
num_sm <= sm_actual;
num_sc <= sc_actual;

en1 <= en_ss;
en2 <= en_sm;
en3 <= en_sc;

preluare_ss: date_serial port map(pachet => pachet, poz => num_ss, enable=> en1, num => "01",  data => data1);
preluare_sm: date_serial port map(pachet => pachet , poz => num_sm, enable => en2, num => "10", data => data2);
preluare_sc: date_serial port map(pachet => pachet, poz => num_sc, enable => en3, num => "11", data=> data3);

process(en1, en2, en3, data1, data2, data3, ss_actual, clk)

variable val: integer := 0;

begin

if rising_edge(clk) then

val_nr_ss <= ss_actual;

if en1 = '1' then
    data <= data1;
    val := conv_integer(ss_actual);
    if data1 = cod_start(val) then
        control <= '1';
    else
        control <= '0';
    end if;
else
    if en2 = '1' then
        data <= data2;
    else
        if en3 = '1' then
            data <= data3;
        else
            data <= '0';
        end if;
    end if;
end if;
end if;
            
end process;


process(sm_actual, clk)
begin

if rising_edge(clk) then
    val_nr_sm <= sm_actual;
end if;

end process;

process(num_sm)
begin

if num_sm >= "00111" then
    shift_reg <= shift_reg(1 to 15) & pachet(conv_integer(num_sm)); 
end if;

end process;

process (num_sm, shift_reg)
begin

if num_sm = "01010" then
     aux(0) <= shift_reg(15) xor shift_reg(14) xor shift_reg(13) xor shift_reg(12);
else
    if num_sm = "01110" then
      aux(1) <= shift_reg(15) xor shift_reg(14) xor shift_reg(13) xor shift_reg(12);
    else
        if num_sm = "10010" then
           aux(2) <= shift_reg(15) xor shift_reg(14) xor shift_reg(13) xor shift_reg(12);
        else
            if num_sm = "10110" then
                 aux(3) <= shift_reg(15) xor shift_reg(14) xor shift_reg(13) xor shift_reg(12);
            end if;
        end if;
    end if;
end if;

end process;

sc_calculat <= aux;
registru <= shift_reg;

process (ss_actual, clk)
begin 

if rising_edge(clk) then
if ss_actual = "00000" then
    bit_1_aux <= "01";
else
    if ss_actual = "00001" then
        bit_1_aux <= "10";
    else
        if ss_actual > "00001" then
            bit_1_aux <= "00";
        else
            bit_1_aux <= "11";
       end if;
    end if;
end if;
end if;
end process;

bit_1 <= bit_1_aux;

process (num_sc, clk)
begin

if rising_edge(clk) then
    val_nr_sc <= num_sc;
end if;

end process;

end Behavioral;