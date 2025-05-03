library verilog;
use verilog.vl_types.all;
entity ctrl_u is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        bgn             : in     vl_logic;
        q0              : in     vl_logic;
        cnt_i           : in     vl_logic_vector(2 downto 0);
        c0              : out    vl_logic;
        c1              : out    vl_logic;
        c2              : out    vl_logic;
        c3              : out    vl_logic;
        c4              : out    vl_logic;
        c5              : out    vl_logic;
        c6              : out    vl_logic;
        fin             : out    vl_logic
    );
end ctrl_u;
