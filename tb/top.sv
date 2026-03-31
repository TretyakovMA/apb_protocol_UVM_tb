module top;
    timeunit      1ns;
	timeprecision 100ps;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

    import apb_master_pkg::*;

    logic pclk;
    logic presetn;

    apb_master_if apb_m_if (pclk, presetn);


`ifdef APB_MASTER_DUT
    apb_master dut (
        .presetn          (presetn),
        .pclk             (pclk),

        .transfer         (apb_m_if.transfer),
        .read             (apb_m_if.read),
        .write            (apb_m_if.write),
        .apb_write_paddr  (apb_m_if.apb_write_paddr),
        .apb_write_data   (apb_m_if.apb_write_data),
        .apb_read_paddr   (apb_m_if.apb_read_paddr),
        .pready           (apb_m_if.pready),
        .pslverr          (apb_m_if.pslverr),
        .prdata           (apb_m_if.prdata),

        .psel1            (apb_m_if.psel1),
        .psel2            (apb_m_if.psel2),
        .penable          (apb_m_if.penable),
        .pwrite           (apb_m_if.pwrite),
        .paddr            (apb_m_if.paddr),
        .pwdata           (apb_m_if.pwdata),
        .apb_read_data_out(apb_m_if.apb_read_data_out)
    );
`else 
    initial begin
        `uvm_fatal("TOP", "APB_DUT is not defined. Please define it to include the DUT in the simulation.")
    end
`endif

    initial begin
        pclk = 0;
        forever #5 pclk = ~pclk;
    end

    initial begin
        presetn = 0;
        #20 presetn = 1;
    end


    initial begin
        $timeformat(-9, 0, " ns", 5);
        uvm_config_db #(virtual interface apb_master_if)::set(null, "*", "apb_m_vif", apb_m_if);
        run_test();
    end


endmodule