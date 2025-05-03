library verilog;
use verilog.vl_types.all;
entity lfsr is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        q               : out    vl_logic_vector(5 downto 0)
    );
end lfsr;
