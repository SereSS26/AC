library verilog;
use verilog.vl_types.all;
entity reg_a is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        clr             : in     vl_logic;
        sh_r            : in     vl_logic;
        ld_sgn          : in     vl_logic;
        ld_obus         : in     vl_logic;
        ld_sum          : in     vl_logic;
        sh_i            : in     vl_logic;
        sgn             : in     vl_logic;
        sum             : in     vl_logic_vector(7 downto 0);
        obus            : out    vl_logic_vector(7 downto 0);
        q               : out    vl_logic_vector(7 downto 0)
    );
end reg_a;
