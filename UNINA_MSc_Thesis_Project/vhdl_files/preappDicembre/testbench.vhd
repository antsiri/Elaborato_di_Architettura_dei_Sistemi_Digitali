LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_AplusB IS
END tb_AplusB;

ARCHITECTURE behavior OF tb_AplusB IS

    COMPONENT AplusB
    PORT(
        CLK_A : IN  STD_LOGIC;
        CLK_B : IN  STD_LOGIC;
        RST : IN  STD_LOGIC;
        START : IN  STD_LOGIC;
        stateA : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
        stateB : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
        count : OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
        result : OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    END COMPONENT;

    -- Signals to connect to UUT
    SIGNAL CLK_A : STD_LOGIC := '0';
    SIGNAL CLK_B : STD_LOGIC := '0';
    SIGNAL RST : STD_LOGIC := '0';
    SIGNAL START : STD_LOGIC := '0';
    SIGNAL stateA : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL stateB : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL count : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL result : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Clock periods
    CONSTANT CLK_A_PERIOD : TIME := 10 ns;
    CONSTANT CLK_B_PERIOD : TIME := 12 ns;

BEGIN

    uut: AplusB PORT MAP (
        CLK_A => CLK_A,
        CLK_B => CLK_B,
        RST => RST,
        START => START,
        stateA => stateA,
        stateB => stateB,
        count => count,
        result => result
    );

    -- Clock process for CLK_A
    CLK_A_process : PROCESS
    BEGIN
        CLK_A <= '0';
        WAIT FOR CLK_A_PERIOD/2;
        CLK_A <= '1';
        WAIT FOR CLK_A_PERIOD/2;
    END PROCESS;

    -- Clock process for CLK_B
    CLK_B_process : PROCESS
    BEGIN
        CLK_B <= '0';
        WAIT FOR CLK_B_PERIOD/2;
        CLK_B <= '1';
        WAIT FOR CLK_B_PERIOD/2;
    END PROCESS;

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- Reset the system
        RST <= '1';
        WAIT FOR 20 ns;
        RST <= '0';
        
        -- Start the operation
        START <= '1';
        WAIT FOR 50 ns;
        START <= '0';

        -- Wait and observe results
        WAIT FOR 200 ns;
        
        -- Stop simulation
        WAIT;
    END PROCESS;

END;
