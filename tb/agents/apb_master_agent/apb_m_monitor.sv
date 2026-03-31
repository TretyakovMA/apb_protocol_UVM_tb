`ifndef APB_M_MONITOR
`define APB_M_MONITOR
class apb_m_monitor extends base_monitor #(
    .INTERFACE_TYPE  (virtual apb_master_if),
    .TRANSACTION_TYPE(apb_m_transaction    )
);
    `uvm_component_utils(apb_m_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction



    task _wait_for_reset_deassert_();
		@(posedge vif.pclk iff vif.presetn == 1);
	endtask: _wait_for_reset_deassert_

    task _wait_for_reset_assert_();
		@(negedge vif.presetn);
	endtask: _wait_for_reset_assert_



    task _wait_for_sampling_event_(); 
        @(posedge vif.pclk iff vif.transfer == 1);
    endtask: _wait_for_sampling_event_

    task _collect_transaction_data_(apb_m_transaction tr);
    
        tr.read            = vif.read;
        tr.write           = vif.write;
        tr.apb_write_paddr = vif.apb_write_paddr;
        tr.apb_write_data  = vif.apb_write_data;
        tr.apb_read_paddr  = vif.apb_read_paddr;
        @(posedge vif.pclk);
        
        tr.psel1           = vif.psel1;
        tr.psel2           = vif.psel2;
        tr.pwrite          = vif.pwrite;
        tr.paddr           = vif.paddr;
        tr.pwdata          = vif.pwdata;
        @(posedge vif.pclk);

        tr.penable         = vif.penable;
    endtask: _collect_transaction_data_
endclass
`endif