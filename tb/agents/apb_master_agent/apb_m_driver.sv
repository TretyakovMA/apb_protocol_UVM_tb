`ifndef APB_M_DRIVER
`define APB_M_DRIVER
class apb_m_driver extends base_driver #(
    .INTERFACE_TYPE  (virtual apb_master_if),
    .TRANSACTION_TYPE(apb_m_transaction    )
);
    `uvm_component_utils(apb_m_driver)

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
        vif.transfer        <= 0;
        vif.read            <= 0;
        vif.write           <= 0;
        vif.apb_write_paddr <= 0;
        vif.apb_write_data  <= 0;
        vif.apb_read_paddr  <= 0;
        vif.pready          <= 0;
        vif.pslverr         <= 0;
        vif.prdata          <= 0;
    endtask: _reset_

    virtual task _drive_transaction_(apb_m_transaction tr);
        vif.transfer        <= tr.transfer;
        vif.read            <= tr.read;
        vif.write           <= tr.write;
        vif.apb_write_paddr <= tr.apb_write_paddr;
        vif.apb_write_data  <= tr.apb_write_data;
        vif.apb_read_paddr  <= tr.apb_read_paddr;

        repeat(1) @(posedge vif.pclk);
        vif.pready          <= tr.pready;

        repeat(1) @(posedge vif.pclk);
        _reset_();
        
        repeat(1) @(posedge vif.pclk);
    endtask: _drive_transaction_

endclass
`endif