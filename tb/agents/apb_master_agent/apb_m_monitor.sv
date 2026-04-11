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
		@(posedge vif.pclk iff vif.presetn);
	endtask: _wait_for_reset_deassert_

    task _wait_for_reset_assert_();
		@(negedge vif.presetn);
	endtask: _wait_for_reset_assert_



    task _wait_for_sampling_event_(); 
        @(posedge vif.pclk iff vif.transfer);
    endtask: _wait_for_sampling_event_
   
    task _collect_transaction_data_(apb_m_transaction tr);

        apb_op_t op;

        `uvm_info(get_type_name(), "Starting burst collection...", UVM_HIGH)
        @(posedge vif.pclk);

        while(vif.transfer == 1) begin
            
            // === Input signals ===
            op.read           = vif.read;
            op.write          = vif.write;
            op.apb_write_data = vif.apb_write_data;

            if(vif.write)
                op.addr       = vif.apb_write_paddr;
            else
                op.addr       = vif.apb_read_paddr;

            // === Output signals ===
            op.psel1   = vif.psel1;
            op.psel2   = vif.psel2;
            op.pwrite  = vif.pwrite;
            op.paddr   = vif.paddr;
            op.pwdata  = vif.pwdata;

            // response phase
            @(posedge vif.pclk iff vif.pready === 1);
            op.penable           = vif.penable;
            op.pslverr           = vif.pslverr;
            op.prdata            = vif.prdata;
            op.apb_read_data_out = vif.apb_read_data_out;

            tr.op_q.push_back(op);

            @(posedge vif.pclk);

            `uvm_info(get_type_name(), $sformatf(
                "Collected beat #%0d (transfer still %b)\nread = %0b, write = %0b, addr = %0h, apb_write_data = %0h\npsel1 = %0b, psel2 = %0b, penable = %0b, pwrite = %0b, paddr = %0h, pwdata = %0h\npslverr = %0b, prdata = %0h, apb_read_data_out = %0h", 
                tr.op_q.size()-1, vif.transfer, 
                op.read, op.write, op.addr, op.apb_write_data,
                op.psel1, op.psel2, op.penable, op.pwrite, op.paddr, op.pwdata,
                op.pslverr, op.prdata, op.apb_read_data_out
            ), UVM_HIGH)
        end
        

        `uvm_info(get_type_name(), 
            $sformatf("Burst finished: %0d operations collected", tr.op_q.size()), 
            UVM_HIGH)

    endtask: _collect_transaction_data_
endclass
`endif