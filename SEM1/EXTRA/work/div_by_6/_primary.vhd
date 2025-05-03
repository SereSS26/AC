library verilog;
use verilog.vl_types.all;
entity div_by_6 is
    port(
        clr             : in     vl_logic;
        c_up            : in     vl_logic;
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        dclk            : out    vl_logic
    );
end div_by_6;
