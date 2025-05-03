library verilog;
use verilog.vl_types.all;
entity decoder_1to4 is
    port(
        addr            : in     vl_logic_vector(1 downto 0);
        enable          : in     vl_logic;
        \out\           : out    vl_logic_vector(3 downto 0)
    );
end decoder_1to4;
