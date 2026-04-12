`ifndef APB_S_AGENT
`define APB_S_AGENT
class apb_s_agent extends base_agent #(
    .INTERFACE_TYPE  (virtual apb_slave_if),
    .TRANSACTION_TYPE(apb_s_transaction    ),
    .DRIVER_TYPE     (apb_s_driver         ),
    .MONITOR_TYPE    (apb_s_monitor        )
);
    `uvm_component_utils(apb_s_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function string set_sequencer_name();
        return "apb_s_sequencer";  
    endfunction: set_sequencer_name
endclass
`endif