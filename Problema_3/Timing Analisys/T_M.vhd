library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T_M is
  Port ( 
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        
        start   :   in  std_logic;  
        
        X       :   in  std_logic_vector(7 downto 0);
        Y       :   in  std_logic_vector(7 downto 0);

        res     :   out std_logic_vector(15 downto 0)
  );
end T_M;

architecture Behavioral of T_M is
component flip_flop_A
 Port ( 
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        
        start_in   :   in  std_logic;  
        
        X_in      :   in  std_logic_vector(7 downto 0);
        Y_in       :   in  std_logic_vector(7 downto 0);
        start_out   :  out  std_logic;  
        
        X_out      :   out  std_logic_vector(7 downto 0);
        Y_out       :  out  std_logic_vector(7 downto 0)
        );
end component;

component flip_flop_B
Port ( 
         clk     :   in  std_logic;
        rst     :   in  std_logic;
       res_in     :   in std_logic_vector(15 downto 0);
       res_out    :   out std_logic_vector(15 downto 0)
        );
end component;

component booth
 port
    (
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        
        start   :   in  std_logic;  
        
        X       :   in  std_logic_vector(7 downto 0);
        Y       :   in  std_logic_vector(7 downto 0);

        res     :   out std_logic_vector(15 downto 0)
    );
end component;
signal temp_start: STD_LOGIC;
signal temp_X, temp_Y: STD_LOGIC_VECTOR(7 downto 0);
signal temp_res: STD_LOGIC_VECTOR(15 downto 0);
begin

ff_A: flip_flop_A
    port map(
        clk,
        rst,
        start,
        X,
        Y,
        temp_start,
        temp_X,
        temp_Y
    );
    
booth_pm: booth
    port map(
        clk,
        rst,
        start,
        temp_X,
        temp_Y, 
        temp_res
    );
    
ff_B: flip_flop_B
    port map(
        clk,
        rst,
        temp_res,
        res
    );

end Behavioral;
