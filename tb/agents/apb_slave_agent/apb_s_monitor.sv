`ifndef APB_S_MONITOR
`define APB_S_MONITOR
class apb_s_monitor extends base_monitor #(
    .INTERFACE_TYPE  (virtual apb_slave_if),
    .TRANSACTION_TYPE(apb_s_transaction    )
);
    `uvm_component_utils(apb_s_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction



    task _wait_for_reset_deassert_();
		@(posedge vif.pclk iff vif.presetn);
	endtask: _wait_for_reset_deassert_

    task _wait_for_reset_assert_();
		@(negedge vif.presetn);
	endtask: _wait_for_reset_assert_


    task _wait_for_sampling_event_(); 
        @(posedge vif.pclk iff vif.psel);
    endtask: _wait_for_sampling_event_

    task _collect_transaction_data_(apb_s_transaction tr);
        `uvm_info(get_type_name(), "Collecting transaction data...", UVM_HIGH)

        tr.op.pwrite  = vif.pwrite;
        tr.op.paddr   = vif.paddr;
        tr.op.pwdata  = vif.pwdata;

        @(posedge vif.pclk iff vif.penable);
        @(posedge vif.pclk);

        tr.op.pready  = vif.pready;
        tr.op.prdata  = vif.prdata;
        tr.op.pslverr = vif.pslverr;

    endtask: _collect_transaction_data_
endclass
`endif