library verilog;
use verilog.vl_types.all;
entity reg_m is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        ldibus          : in     vl_logic;
        ibus            : in     vl_logic_vector(7 downto 0);
        q               : out    vl_logic_vector(7 downto 0)
    );
end reg_m;
