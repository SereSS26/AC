library verilog;
use verilog.vl_types.all;
entity switch is
    port(
        x               : in     vl_logic_vector(5 downto 0);
        y               : in     vl_logic_vector(5 downto 0);
        o               : out    vl_logic_vector(2 downto 0)
    );
end switch;
