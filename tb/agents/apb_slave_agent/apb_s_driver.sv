`ifndef APB_S_DRIVER
`define APB_S_DRIVER
class apb_s_driver extends base_driver #(
    .INTERFACE_TYPE  (virtual apb_slave_if),
    .TRANSACTION_TYPE(apb_s_transaction    )
);
    `uvm_component_utils(apb_s_driver)
    //`uvm_register_cb(apb_s_driver, apb_s_driver_cb)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction



    task _wait_for_reset_deassert_();
		@(posedge vif.pclk iff vif.presetn == 1);
	endtask: _wait_for_reset_deassert_

    task _wait_for_reset_assert_();
		@(negedge vif.presetn);
	endtask: _wait_for_reset_assert_



    virtual task _reset_();
        vif.psel            <= 0;
        vif.penable         <= 0;
        vif.pwrite          <= 0;
        vif.paddr           <= 0;
        vif.pwdata          <= 0;
    endtask: _reset_

    virtual task _drive_transaction_(apb_s_transaction tr);
        vif.psel    <= 1;

        vif.pwrite  <= tr.op.pwrite;
        vif.paddr   <= tr.op.paddr;
        vif.pwdata  <= tr.op.pwdata;

        @(posedge vif.pclk) 
        vif.penable <= 1;
        `uvm_info(get_type_name(), {"Send transaction:\n", tr.convert2string()}, UVM_MEDIUM)
        
        @(posedge vif.pclk);
        _reset_();
        

    endtask: _drive_transaction_
endclass
`endif