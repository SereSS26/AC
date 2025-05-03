library verilog;
use verilog.vl_types.all;
entity reg_parl is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        q               : out    vl_logic_vector(3 downto 0)
    );
end reg_parl;
