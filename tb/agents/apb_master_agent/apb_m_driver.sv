`ifndef APB_M_DRIVER
`define APB_M_DRIVER
class apb_m_driver extends base_driver #(
    .INTERFACE_TYPE  (virtual apb_master_if),
    .TRANSACTION_TYPE(apb_m_transaction    )
);
    `uvm_component_utils(apb_m_driver)
    `uvm_register_cb(apb_m_driver, apb_m_driver_cb)

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
        
        vif.transfer        <= 1;
        @(posedge vif.pclk);

        foreach (tr.op_q[i]) begin
            vif.read            <= tr.op_q[i].read;
            vif.write           <= tr.op_q[i].write;
            if(tr.op_q[i].write) begin
                vif.apb_write_paddr <= tr.op_q[i].addr;  
                vif.apb_write_data  <= tr.op_q[i].apb_write_data;
            end 
            else begin
                vif.apb_read_paddr  <= tr.op_q[i].addr;
            end

            repeat(1) @(posedge vif.pclk);
            `uvm_do_callbacks(apb_m_driver, apb_m_driver_cb, delay_before_pready(vif))
            vif.pready  <= 1;
            vif.pslverr <= tr.op_q[i].pslverr;
            vif.prdata  <= tr.op_q[i].prdata;

            `uvm_info(get_type_name(), $sformatf(
                "Drive: r=%0b, w=%0b, addr=%3h, apb_write_data=%2h, pslverr = %0b, prdata = %0h",
                tr.op_q[i].read, tr.op_q[i].write, tr.op_q[i].addr, tr.op_q[i].apb_write_data, tr.op_q[i].pslverr, tr.op_q[i].prdata
                ), UVM_HIGH
            )

            @(posedge vif.pclk);
            vif.read            <= 0;
            vif.write           <= 0;
            vif.apb_write_paddr <= 0;
            vif.apb_write_data  <= 0;
            vif.apb_read_paddr  <= 0;
            vif.pready          <= 0;
            vif.pslverr         <= 0;
            vif.prdata          <= 0;
        end

        `uvm_info(get_type_name(), {"Send transaction:\n", tr.convert2string()}, UVM_MEDIUM)
        
        _reset_(); 
        `uvm_do_callbacks(apb_m_driver, apb_m_driver_cb, delay_before_next_tr(vif))
    endtask: _drive_transaction_

endclass
`endif