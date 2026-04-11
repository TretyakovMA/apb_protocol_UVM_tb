`ifndef WAIT_PREADY_CB
`define WAIT_PREADY_CB
class wait_pready_cb extends apb_m_driver_cb;
    `uvm_object_utils(wait_pready_cb)

    function new(string name = "wait_pready_cb");
        super.new(name);
    endfunction

    task delay_before_pready(virtual apb_master_if vif);
        repeat($urandom_range(1, 5)) @(posedge vif.pclk);
    endtask: delay_before_pready
    
endclass
`endif