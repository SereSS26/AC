library verilog;
use verilog.vl_types.all;
entity minimization is
    port(
        i3              : in     vl_logic;
        i2              : in     vl_logic;
        i1              : in     vl_logic;
        i0              : in     vl_logic;
        o2              : out    vl_logic;
        o1              : out    vl_logic;
        o0              : out    vl_logic
    );
end minimization;
