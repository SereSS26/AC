library verilog;
use verilog.vl_types.all;
entity mux_2s is
    generic(
        w               : integer := 4
    );
    port(
        d0              : in     vl_logic_vector;
        d1              : in     vl_logic_vector;
        d2              : in     vl_logic_vector;
        d3              : in     vl_logic_vector;
        s               : in     vl_logic_vector(1 downto 0);
        o               : out    vl_logic_vector
    );
end mux_2s;
