`ifndef APB_M_DRIVER_CB
`define APB_M_DRIVER_CB
class apb_m_driver_cb extends uvm_callback;
    `uvm_object_utils(apb_m_driver_cb)

    function new(string name = "apb_m_driver_cb");
        super.new(name);
    endfunction

    virtual task delay_before_pready(virtual apb_master_if vif);
        
    endtask: delay_before_pready

    virtual task delay_before_next_tr(virtual apb_master_if vif);
        
    endtask: delay_before_next_tr
endclass
`endif