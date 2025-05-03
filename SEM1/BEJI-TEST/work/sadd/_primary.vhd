library verilog;
use verilog.vl_types.all;
entity sadd is
    port(
        x               : in     vl_logic;
        y               : in     vl_logic;
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        s               : out    vl_logic
    );
end sadd;
