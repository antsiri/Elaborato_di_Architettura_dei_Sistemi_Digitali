library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Rom_M_MEM is
end tb_Rom_M_MEM;

architecture behavior of tb_Rom_M_MEM is

    -- Dichiarazione dei segnali per il testbench
    signal START : std_logic := '0';
    signal RST : std_logic := '0';
    signal CLK : std_logic := '0';
    signal Y : std_logic_vector(3 downto 0);

    -- Unità sotto test (UUT)
    component Rom_M_MEM
        Port (
            START : in std_logic;
            RST : in std_logic;
            CLK : in std_logic;
            Y : out std_logic_vector(3 downto 0)
        );
    end component;

begin

    -- Istanza del modulo Rom_M_MEM
    uut: Rom_M_MEM
        Port map (
            START => START,
            RST => RST,
            CLK => CLK,
            Y => Y
        );

    -- Generazione del clock
    CLK_process :process
    begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
    end process;

    -- Stimoli di test
    stim_proc: process
    begin
        -- Test di reset
        RST <= '1';
        START <= '0';
        wait for 20 ns;
        
        RST <= '0';
        START <= '1';  -- Iniziamo l'operazione
        wait for 20 ns;
        
        -- Simuliamo l'attivazione della macchina a vari intervalli
        wait for 20 ns;
        START <= '0'; -- Fermiamo l'operazione
        wait for 100 ns;
       
        -- Continuiamo con il ciclo di operazioni
        wait for 500 ns;
        
        -- Fine simulazione
        wait;
    end process;

end behavior;
