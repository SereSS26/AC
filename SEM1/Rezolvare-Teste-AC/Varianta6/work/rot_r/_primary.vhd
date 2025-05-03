library verilog;
use verilog.vl_types.all;
entity rot_r is
    port(
        a               : in     vl_logic_vector(5 downto 0);
        b               : out    vl_logic_vector(5 downto 0)
    );
end rot_r;
