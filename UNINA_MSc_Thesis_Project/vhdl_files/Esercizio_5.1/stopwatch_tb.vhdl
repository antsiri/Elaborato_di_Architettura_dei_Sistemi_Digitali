-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity stopwatch_tb is
end;

architecture bench of stopwatch_tb is

  component stopwatch
      port 
      (
          clk     :   in  std_logic;
          rst     :   in  std_logic;
          set     :   in  std_logic;
          en      :   in  std_logic;
          set_sec :   in  std_logic_vector(5 downto 0);
          set_min :   in  std_logic_vector(5 downto 0);
          set_hr  :   in  std_logic_vector(4 downto 0);
          seconds :   out std_logic_vector(5 downto 0);
          minutes :   out std_logic_vector(5 downto 0);
          hours   :   out std_logic_vector(4 downto 0)
      );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal set: std_logic;
  signal en: std_logic;
  signal set_sec: std_logic_vector(5 downto 0);
  signal set_min: std_logic_vector(5 downto 0);
  signal set_hr: std_logic_vector(4 downto 0);
  signal seconds: std_logic_vector(5 downto 0);
  signal minutes: std_logic_vector(5 downto 0);
  signal hours: std_logic_vector(4 downto 0) ;

begin

  uut: stopwatch port map ( clk     => clk,
                            rst     => rst,
                            set     => set,
                            en      => en,
                            set_sec => set_sec,
                            set_min => set_min,
                            set_hr  => set_hr,
                            seconds => seconds,
                            minutes => minutes,
                            hours   => hours );

    clock_process: process
        begin
        clk <= '0';
        while True loop
            wait for 5 ns; -- Periodo del clock (adattare a seconda delle esigenze)
            clk <= not clk;
        end loop;
    end process;

    -- Stimuli per il testbench
    stimulus: process
    begin
        -- Inizializzazione
        rst <= '1';  -- Reset iniziale
        wait for 10 ns;
        rst <= '0';

        -- Test case 1: Avvio del cronometro da zero
        en <= '1';
        wait for 1 ms;
        en <= '0';

        -- Verifica dei risultati (es. utilizzando asserzioni)

        -- Test case 2: Impostazione di un tempo iniziale e avvio
        set_sec <= "000111";   
        set_min <= "000011";
        set_hr  <= "00001";
        set <= '1';
        wait for 10 ns;
        set <= '0';
        en <= '1';
        wait for 500 ms;
        en <= '0';

        -- Verifica dei risultati

        -- ... Altri test case ...

        wait for 5 ns; 
    end process;
                          

end;