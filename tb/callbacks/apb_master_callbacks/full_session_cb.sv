`ifndef FULL_SESSION_CB
`define FULL_SESSION_CB
class full_session_cb extends apb_m_driver_cb;
    `uvm_object_utils(full_session_cb)

    function new(string name = "full_session_cb");
        super.new(name);
    endfunction

    task delay_before_pready(virtual apb_master_if vif);
        repeat($urandom_range(5)) @(posedge vif.pclk);
    endtask: delay_before_pready

    // Задержка должна быть больше такта, иначе несколько групп слипаются в одну
    virtual task delay_before_next_tr(virtual apb_master_if vif);
        repeat($urandom_range(1, 10)) @(posedge vif.pclk);
    endtask: delay_before_next_tr
    
endclass
`endif