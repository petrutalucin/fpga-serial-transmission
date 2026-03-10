----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name: UNITATE_CONTROL - Behavioral
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

entity UNITATE_CONTROL is
  Port (   ldss : out STD_LOGIC; --semnale spre UE
           rstss : out STD_LOGIC;
           enss : out STD_LOGIC;
           ldsm : out STD_LOGIC; 
           rstsm : out STD_LOGIC;
           ensm : out STD_LOGIC;
           ldsc : out STD_LOGIC; 
           rstsc : out STD_LOGIC;
           ensc : out STD_LOGIC;
           nr_ss : out std_logic_vector(0 to 4); -- init pt numaratoare
           nr_sm : out std_logic_vector(0 to 4);
           nr_sc : out std_logic_vector(0 to 4);
           clk : in STD_LOGIC;
           --de la UE
           bit_1 : in std_logic_vector (0 to 1); -- s-a indexat primul bit
           verif_ss : in STD_LOGIC; --num ss a ajuns la final
           verif_sm : in STD_LOGIC;
           verif_sc : in STD_LOGIC;
           control : in STD_LOGIC; --aka cod start
           sc_calculat : in std_logic_vector (0 to 3);
           sc_original : in STD_LOGIC_VECTOR (0 to 3);
           val_fin : in STD_LOGIC_VECTOR(0 to 2);
           val_nr_ss : in STD_LOGIC_VECTOR (0 to 4);
           val_nr_sm : in STD_LOGIC_VECTOR (0 to 4);
           val_nr_sc : in STD_LOGIC_VECTOR (0 to 4);
           run: in std_logic;--buton
           reset: in std_logic; --switch
           introducere_mod: out std_logic; --led
           led_final: out std_logic; --led
           ss: out std_logic; --led
           sm: out std_logic; --led
           sc: out std_logic --led 
                     );
end UNITATE_CONTROL;

architecture Behavioral of UNITATE_CONTROL is

type stare is(astept, intro_mod, preluare_date, segm_start, segm_date, sum_control, verif);
signal st, nxst: stare := astept; 
signal ss_sg, sm_sg, sc_sg : std_logic := '0';

begin

starea_actuala: process(clk, reset)
begin

if rising_edge(clk) then
    if reset = '1' then
        st <= astept;
    else
        st <= nxst;
    end if;
end if;  
end process;

tranzitii: process(st ,verif_ss, verif_sc, verif_sm, run, bit_1, control, sc_calculat, sc_original, val_fin, val_nr_ss, val_nr_sm, val_nr_sc)
begin

case st is
    when astept => nxst <= intro_mod;
                   introducere_mod <= '0';
                   led_final <= '0';
                   ss <= '0';
                   sm <= '0';
                   sc <= '0';
                   nr_ss <= "00000"; -- numara 0-6
                   nr_sm <= "00111"; -- numara 7-22
                   nr_sc <= "10111"; --numara 23-26
                   enss <= '0';
                   ldss <= '0';
                   rstss <= '1';
                   ensm <= '0';
                   ldsm <= '0';
                   rstsm <= '1';
                   ensc <= '0';
                   ldsc <= '0';
                   rstsc <= '1';
    when intro_mod =>
        introducere_mod <= '1'; -- trebe dat pe switch uri valoare pt mode
        nxst <= preluare_date;
    when preluare_date =>
        if run = '0' then 
            nxst <= astept;
        else
            introducere_mod <= '0';
            
            if bit_1 = "11" then --adica inca nu o primit nicio val numaratorul
                nxst <= preluare_date;
                enss <= '1';
                ldss <= '1';
                rstss <= '0';
            else
                if bit_1 = "01" then --adica s a facut load si trebe sa inceapa sa numere
                    nxst <= preluare_date;
                    ldss <= '0';
                else
                    if bit_1 = "10" then --inseamna ca o primit primul bit
                         nxst <= segm_start;
                         ss <= '1';
                         ss_sg <= '1';
                    end if;
                end if;
            end if;
        end if;
     when segm_start =>
    
        if verif_ss = '1' then
           nxst <= segm_date;
           enss <= '0';
           ldsm <= '1';
           ensm <= '1';
           rstsm <= '0';    
        else
            if control = '1' then
                   ss_sg <= '1';
                   ss <= '1';
                   nxst <= segm_start;
            else
                   ss <= '0';
                   ss_sg <= '0';
                   nxst <= astept;
            end if;
        end if; 
     when segm_date =>
        ldsm <= '0';
        
        sm <= '1';
        sm_sg <= '1'; 
        if verif_sm = '1' then
            nxst <= sum_control;
            ensm <= '0';
            ensc <= '1';
            ldsc <= '1';
            rstsc <= '0';
        else
            nxst <= segm_date;
        end if; 
            
     when sum_control =>
        
        if verif_sc = '1' then
            ensc <= '0';
            if sc_calculat = sc_original then
                sc <= '1';
                sc_sg <= '1';
            end if;
            nxst <= verif;
        else
            nxst <= sum_control;
            if val_nr_sc = "10111" then
                ldsc <= '0';
            end if;
        end if;  
     when verif =>
        if ss_sg = val_fin(0) and sm_sg = val_fin(1) and sc_sg = val_fin(2) then
            led_final <= '1';
            --nxst <= astept;   
        end if;   

end case;

end process;

end Behavioral;