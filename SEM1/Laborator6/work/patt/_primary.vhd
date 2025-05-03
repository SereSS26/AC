library verilog;
use verilog.vl_types.all;
entity patt is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        i               : in     vl_logic;
        o               : out    vl_logic
    );
end patt;
