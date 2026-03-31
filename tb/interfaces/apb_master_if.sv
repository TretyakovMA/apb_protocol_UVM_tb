`ifndef APB_MASTER_IF
`define APB_MASTER_IF
interface apb_master_if (input logic pclk, input logic presetn);
    logic        transfer;
    logic        read;
    logic        write;
    logic [8:0]  apb_write_paddr;
    logic [7:0]  apb_write_data;
    logic [8:0]  apb_read_paddr;
    
    logic        pready;              
    logic        pslverr;               
    logic [7:0]  prdata; 

    logic        psel1;
    logic        psel2;
    logic        penable;
    logic        pwrite; 
    logic [8:0]  paddr; 
    logic [7:0]  pwdata;
    logic [7:0]  apb_read_data_out;
endinterface
`endif