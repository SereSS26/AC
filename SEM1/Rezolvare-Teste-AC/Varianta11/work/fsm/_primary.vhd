library verilog;
use verilog.vl_types.all;
entity fsm is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        clr             : in     vl_logic;
        c_up            : in     vl_logic;
        dclk            : out    vl_logic
    );
end fsm;
