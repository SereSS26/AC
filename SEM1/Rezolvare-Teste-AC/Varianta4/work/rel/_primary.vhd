library verilog;
use verilog.vl_types.all;
entity rel is
    port(
        x               : in     vl_logic;
        y               : in     vl_logic;
        eq              : out    vl_logic;
        lt              : out    vl_logic;
        gt              : out    vl_logic
    );
end rel;
