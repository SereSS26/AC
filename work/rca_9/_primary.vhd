library verilog;
use verilog.vl_types.all;
entity rca_9 is
    port(
        A               : in     vl_logic_vector(8 downto 0);
        B               : in     vl_logic_vector(8 downto 0);
        Cin             : in     vl_logic;
        OVR             : out    vl_logic;
        Sum             : out    vl_logic_vector(8 downto 0);
        Cout            : out    vl_logic
    );
end rca_9;
