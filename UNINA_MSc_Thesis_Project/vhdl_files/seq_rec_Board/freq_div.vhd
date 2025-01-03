library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity frequency_divider is
    Port (
        clock_in : in STD_LOGIC;  -- Clock di ingresso
        reset : in STD_LOGIC;     -- Segnale di reset
        clock_out : out STD_LOGIC -- Clock di uscita, divisore di frequenza
    );
end frequency_divider;

architecture Behavioral of frequency_divider is

    -- Definire il valore massimo del contatore in base alla divisione desiderata
    -- clock di ingresso di 100 MHz, si vuole ottenere una frequenza di uscita di 1 Hz:
    constant CLOCK_FREQ : integer := 100_000_000; -- Frequenza del clock di ingresso (100 MHz)
    constant DIVISOR : integer := 100_000_000;    -- Divisione desiderata (1 Hz: 100 MHz / 100_000_000)
    constant COUNT_MAX : integer := DIVISOR / 2 - 1; -- Calcola il massimo valore del contatore (per ottenere un periodo completo)

    signal counter : integer range 0 to COUNT_MAX := 0; -- Contatore per dividere la frequenza
    signal clock_signal : STD_LOGIC := '0'; -- Segnale di clock di uscita

begin

    -- Processo che divide la frequenza
    process(clock_in)
    begin
        if rising_edge(clock_in) then
            if reset = '1' then
                counter <= 0; -- Reset del contatore
                clock_signal <= '0'; -- Reset del segnale di clock di uscita
            else
                if counter = COUNT_MAX then
                    counter <= 0; -- Reset del contatore al raggiungimento del massimo
                    clock_signal <= not clock_signal; -- Si inverte il segnale di clock di uscita
                else
                    counter <= counter + 1; -- Incrementa il contatore
                end if;
            end if;
        end if;
    end process;

    -- Collega il segnale di uscita al segnale di clock
    clock_out <= clock_signal;

end Behavioral;
