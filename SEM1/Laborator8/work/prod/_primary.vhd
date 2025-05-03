library verilog;
use verilog.vl_types.all;
entity prod is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        val             : out    vl_logic;
        data            : out    vl_logic_vector(7 downto 0)
    );
end prod;
