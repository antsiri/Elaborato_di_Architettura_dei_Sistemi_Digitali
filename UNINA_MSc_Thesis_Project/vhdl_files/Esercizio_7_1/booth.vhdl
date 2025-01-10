library ieee;
use     ieee.std_logic_1164.all;

entity booth is
    port
    (
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        
        start   :   in  std_logic;  
        
        X       :   in  std_logic_vector(7 downto 0);
        Y       :   in  std_logic_vector(7 downto 0);

        res     :   out std_logic_vector(15 downto 0)
    );
end booth;

architecture structural of booth is
    component shift_register is
        port
        (
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            en_wrt      :   in  std_logic;
            en_shf      :   in  std_logic;
            value_rst   :   in  std_logic_vector(7 downto 0);
            value_in    :   in  std_logic_vector(7 downto 0);
            bit_in      :   in  std_logic;
            value_out   :   out std_logic_vector(7 downto 0);
            bit_out     :   out std_logic
        );
    end component;

    component counter_mod_8 is
        port 
        (
            clk     :   in  std_logic;
            en      :   in  std_logic;
            rst     :   in  std_logic;
            counter :   out std_logic_vector(2 downto 0)
        );
    end component;

    component ffD is
        port 
        (
            clk         :   in  std_logic;
            en          :   in  std_logic;
            rst         :   in  std_logic;
            preset      :   in  std_logic;
            input       :   in  std_logic;
            output      :   out std_logic;
            not_output  :   out std_logic
        );
    end component;

    component carry_look_ahead is
        port
        (
            X   :   in  std_logic_vector(7 downto 0);
            Y   :   in  std_logic_vector(7 downto 0);
            Cin :   in  std_logic;
            Sum :   out std_logic_vector(7 downto 0);
            Cout:   out std_logic
        );
    end component;

    component cu is
        port
        (
            clk         :   in  std_logic;
            rst         :   in  std_logic;
            start       :   in  std_logic;
            Q0          :   in  std_logic;
            Q_1         :   in  std_logic;
            cnt         :   in  std_logic_vector(2 downto 0);
            inizialize  :   out std_logic;
            sub_val     :   out std_logic;
            en_wr       :   out std_logic;
            en_sh       :   out std_logic;
            en_cnt      :   out std_logic
        );
    end component;

    signal  rst_iniz    :   std_logic;

    signal  en_wr_temp  :   std_logic;
    signal  en_sh_temp  :   std_logic;

    signal  A_value_in  :   std_logic_vector(7 downto 0);
    signal  A_bit_in    :   std_logic;
    signal  A_value_out :   std_logic_vector(7 downto 0);
    signal  A_bit_out   :   std_logic;

    signal  Q_bit_in    :   std_logic;
    signal  Q_value_out :   std_logic_vector(7 downto 0);
    signal  Q_bit_out   :   std_logic;

    signal  Q_1_bit_in  :   std_logic;
    signal  Q_1_bit_out :   std_logic;

    signal  M_value_out :   std_logic_vector(7 downto 0);

    signal  subst       :   std_logic;

    signal  en_cnt_temp :   std_logic;
    signal  count_value :   std_logic_vector(2 downto 0);

    signal  inizialize  :   std_logic;

begin
    rst_iniz     <=  inizialize;

    A_reg: shift_register
    port map (clk, rst_iniz, en_wr_temp, en_sh_temp, (others => '0'), A_value_in, A_value_out(7), A_value_out, A_bit_out);

    Q_bit_in    <=  A_bit_out;
    A_bit_in    <=  A_value_out(7);

    Q_reg: shift_register
    port map (clk, rst_iniz, '0', en_sh_temp, X, (others=>'0'), A_bit_out, Q_value_out, Q_bit_out);

    Q_minus_one: ffD
    port map(clk, en_sh_temp, rst_iniz, '0', Q_bit_out, Q_1_bit_out);

    M: shift_register
    port map (clk, rst_iniz, '0', '0', Y, (others => '0'), '0', M_value_out);

    adder: carry_look_ahead
    port map (A_value_out, M_value_out, subst, A_value_in);

    count: counter_mod_8
    port map(clk, en_cnt_temp, rst_iniz, count_value);

    control_unit: cu 
    port map(clk, rst, start, Q_bit_out, Q_1_bit_out, count_value, inizialize, subst, en_wr_temp, en_sh_temp, en_cnt_temp);

    res <=  A_value_out & Q_value_out;

end structural;