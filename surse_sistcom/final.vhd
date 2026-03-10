----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name: final - Behavioral
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

entity final is
    Port ( clk : in STD_LOGIC;
          -- btn : in STD_LOGIC;
           run : in STD_LOGIC;
           rst : in STD_LOGIC;
           mode : in STD_LOGIC_VECTOR (0 to 1);
           sm : out STD_LOGIC;
           ss : out STD_LOGIC;
           sc : out STD_LOGIC;
           led_final : out std_logic;
           introducere_mod: out std_logic);
           
end final;

architecture Behavioral of final is

component UNITATE_CONTROL is
  Port (   ldss : out STD_LOGIC; --semnale spre UE
           rstss : out STD_LOGIC;
           enss : out STD_LOGIC;
           ldsm : out STD_LOGIC; 
           rstsm : out STD_LOGIC;
           ensm : out STD_LOGIC;
           ldsc : out STD_LOGIC; 
           rstsc : out STD_LOGIC;
           ensc : out STD_LOGIC;
           nr_ss : out std_logic_vector(0 to 4);
           nr_sm : out std_logic_vector(0 to 4);
           nr_sc : out std_logic_vector(0 to 4);
           clk : in STD_LOGIC;
           --de la UE
           bit_1 : in std_logic_vector (0 to 1);
           verif_ss : in STD_LOGIC; --num ss a ajuns la final
           verif_sm : in STD_LOGIC;
           verif_sc : in STD_LOGIC;
           control : in STD_LOGIC; --aka cod start
           sc_calculat : in std_logic_vector (0 to 3);
           sc_original : in STD_LOGIC_VECTOR (0 to 3);
           val_fin : in STD_LOGIC_VECTOR(0 to 2);
           val_nr_ss: in STD_LOGIC_VECTOR(0 to 4);
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
end component UNITATE_CONTROL;

component UNITATE_EXECUTIE is
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
           bit_1 : out std_logic_vector(0 to 1);
           sc_original: out std_logic_vector (0 to 3);
           val_nr_ss: out std_logic_vector (0 to 4);
           val_nr_sm : out std_logic_vector (0 to 4);
           val_nr_sc : out std_logic_vector (0 to 4);
           registru: out std_logic_vector(0 to 15));
end component UNITATE_EXECUTIE;

component MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC);
end component MPG;

signal verif_ss : std_logic;
signal verif_sm : std_logic;
signal verif_sc : std_logic;
signal control: std_logic;
signal sc_calculat : std_logic_vector (0 to 3);
signal data : STD_LOGIC;
signal val_fin : STD_LOGIC_VECTOR(0 to 2);
signal ldss : STD_LOGIC;
signal rstss : STD_LOGIC;
signal enss : STD_LOGIC;
signal ldsm : STD_LOGIC; 
signal rstsm : STD_LOGIC;
signal ensm : STD_LOGIC;
signal rstsc : STD_LOGIC;
signal ensc : STD_LOGIC;
signal ldsc: std_logic;
signal nr_ss : std_logic_vector(0 to 4);
signal nr_sm : std_logic_vector(0 to 4);
signal nr_sc : std_logic_vector(0 to 4);
signal bit_1 : std_logic_vector(0 to 1);
signal sc_original : std_logic_vector(0 to 3);
signal val_nr_ss: std_logic_vector(0 to 4);
signal val_nr_sm: std_logic_vector(0 to 4);
signal val_nr_sc: std_logic_vector(0 to 4);

signal clk_divizat: std_logic;

signal shift_reg: std_logic_vector (0 to 15);

begin

--CLK1: MPG port map (btn => btn, clk => clk, en => clk_divizat);

UE: UNITATE_EXECUTIE port map
    (     
           --clk => clk_divizat,
           clk => clk,
           ld_ss => ldss,
           en_ss => enss,
           rst_ss => rstss,
           init_ss => nr_ss,
           final_ss => verif_ss,
           ld_sm => ldsm,
           en_sm => ensm,
           rst_sm => rstsm,
           init_sm => nr_sm,
           final_sm => verif_sm,
           ld_sc => ldsc,
           en_sc => ensc,
           rst_sc => rstsc,
           init_sc => nr_sc,
           final_sc => verif_sc,
           mode => mode,
           val_fin => val_fin,
           control => control,
           sc_calculat => sc_calculat,
           data => data,
           bit_1 => bit_1,
           sc_original => sc_original,
           val_nr_ss => val_nr_ss,
           val_nr_sm => val_nr_sm,
           val_nr_sc => val_nr_sc,
           registru => shift_reg
           );

UC: UNITATE_CONTROL Port map
       (   ldss => ldss,
           rstss => rstss,
           enss => enss,
           ldsm => ldsm,
           rstsm =>rstsm,
           ensm => ensm,
           ldsc => ldsc,
           rstsc => rstsc,
           ensc => ensc, 
           nr_ss => nr_ss,
           nr_sm => nr_sm,
           nr_sc => nr_sc,
          -- clk => clk_divizat,
          clk => clk,
           --de la UE
           bit_1 => bit_1,
           verif_ss => verif_ss,
           verif_sm => verif_sm,
           verif_sc => verif_sc,
           control => control,
           sc_calculat => sc_calculat,
           sc_original => sc_original,
           val_fin => val_fin,
           val_nr_ss => val_nr_ss,
           val_nr_sm => val_nr_sm,
           val_nr_sc => val_nr_sc,
           run => run,
           reset => rst,
           introducere_mod => introducere_mod,
           led_final => led_final,
           ss => ss,
           sm => sm,
           sc => sc
           );

end Behavioral;