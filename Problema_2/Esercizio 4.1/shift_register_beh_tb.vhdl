library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity shift_registrer_beh_tb is
end;

architecture bench of shift_registrer_beh_tb is

  component shift_registrer_beh 
      generic ( N: integer := 8 );
      port
      (
          clk     : in  std_logic;
          rst     : in  std_logic;
          en      : in  std_logic;
          y       : in  std_logic_vector(1 downto 0);
          data_in : in  std_logic_vector(1 downto 0);
          data_out: out std_logic_vector(N-1 downto 0)
      );
  end component;

  -- Signal declarations
  signal clk     : std_logic := '0';
  signal rst     : std_logic := '0';
  signal en      : std_logic := '0';
  signal y       : std_logic_vector(1 downto 0) := "00";
  signal data_in : std_logic_vector(1 downto 0) := "00";
  signal data_out: std_logic_vector(7 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean := false;

begin

  -- Instanziazione del componente sotto test
  uut: shift_registrer_beh
    generic map ( N => 8 )  -- Dimensione del registro
    port map (
      clk      => clk,
      rst      => rst,
      en       => en,
      y        => y,
      data_in  => data_in,
      data_out => data_out
    );

  -- Stimoli
  stimulus: process
  begin
    -- Reset iniziale
    rst <= '1';
    wait for clock_period;
    rst <= '0';
    wait for clock_period;

    -- Abilitazione e shift a sinistra di 1
    en <= '1';
    y <= "00";
    data_in <= "01";  -- Input dati
    wait for clock_period;

    -- Shift a sinistra di 2
    y <= "01";
    data_in <= "10";
    wait for clock_period;

    -- Shift a destra di 1
    y <= "10";
    data_in <= "11";
    wait for clock_period;

    -- Shift a destra di 2
    y <= "11";
    data_in <= "01";
    wait for clock_period;

    -- Disabilitazione
    en <= '0';
    data_in <= "00";
    wait for clock_period;

    -- Concludi la simulazione
    stop_the_clock <= true;
    wait;
  end process;

  -- Processo di generazione del clock
  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
