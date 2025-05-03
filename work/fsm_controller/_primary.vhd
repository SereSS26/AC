library verilog;
use verilog.vl_types.all;
entity fsm_controller is
    generic(
        LOAD_OP         : integer := 1;
        LOAD_1          : integer := 2;
        LOAD_2          : integer := 4;
        EXECUTE         : integer := 8
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        inbus           : in     vl_logic_vector(8 downto 0);
        outbus          : out    vl_logic_vector(8 downto 0)
    );
end fsm_controller;
