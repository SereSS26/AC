library verilog;
use verilog.vl_types.all;
entity fac is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        cin             : in     vl_logic;
        z               : out    vl_logic;
        cout            : out    vl_logic
    );
end fac;
