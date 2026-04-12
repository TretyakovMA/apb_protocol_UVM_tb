`ifndef APB_SLAVE_IF
`define APB_SLAVE_IF
interface apb_slave_if(input logic pclk, input logic presetn);
    logic       psel;
    logic       penable;
    logic       pwrite;
    logic [7:0] paddr;
    logic [7:0] pwdata;

    logic [7:0] prdata;
    logic       pready;
    logic       pslverr;
endinterface
`endif