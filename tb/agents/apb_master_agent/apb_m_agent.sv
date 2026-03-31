`ifndef APB_M_AGENT
`define APB_M_AGENT
class apb_m_agent extends base_agent #(
    .INTERFACE_TYPE  (virtual apb_master_if),
    .TRANSACTION_TYPE(apb_m_transaction    ),
    .DRIVER_TYPE     (apb_m_driver         ),
    .MONITOR_TYPE    (apb_m_monitor        )
);
    `uvm_component_utils(apb_m_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function string set_sequencer_name();
        return "apb_m_sequencer";  
    endfunction: set_sequencer_name
endclass
`endif