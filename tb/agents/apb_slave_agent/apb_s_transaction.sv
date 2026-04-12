`ifndef APB_S_TRANSACTION
`define APB_S_TRANSACTION
class apb_s_transaction extends uvm_sequence_item;

    `uvm_object_utils(apb_s_transaction)

    function new(string name = "apb_s_transaction");
        super.new(name);
    endfunction
    

    rand apb_op_t op;
    

    constraint valid_op {
        op.read              == 0;
        op.write             == 0;
        op.addr              == 0;
        op.apb_write_data    == 0;

        op.pready            == 0;
        op.pslverr           == 0;
        op.prdata            == 0;

        op.psel1             == 0;
        op.psel2             == 0;
        op.apb_read_data_out == 0;
    }



    function string convert2string();
        string s;
        s = $sformatf("Slave Transaction:\npwrite=%b addr=%2h wdata=%2h | prdata=%2h pready=%b pslverr=%b",
            op.pwrite, op.paddr, op.pwdata, op.prdata, op.pready, op.pslverr
        );
        return s;
    endfunction: convert2string

    virtual function void do_copy(uvm_object rhs);
        apb_s_transaction copied;
        if (!$cast(copied, rhs)) `uvm_fatal(get_type_name(), "cast failed")
        super.do_copy(rhs);
        this.op = copied.op;
    endfunction: do_copy

    function apb_s_transaction clone_me();
        apb_s_transaction clone;
        uvm_object tmp;
		
		tmp = this.clone();
		$cast(clone, tmp);
		return clone;
    endfunction: clone_me

    
endclass
`endif