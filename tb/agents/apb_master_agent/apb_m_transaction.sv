`ifndef APB_M_TRANSACTION
`define APB_M_TRANSACTION
class apb_m_transaction extends uvm_sequence_item;

    `uvm_object_utils(apb_m_transaction)


    rand apb_op_t op_q[$];
    `define MAX_OP_Q_SIZE 10


    constraint valid_op {
        op_q.size() inside {[1:`MAX_OP_Q_SIZE]};
        foreach(op_q[i]) {
            op_q[i].read ^ op_q[i].write;
            op_q[i].addr[7:0] < 256;
        }
    }

    


    function new(string name = "apb_m_transaction");
        super.new(name);
    endfunction
    


    virtual function string convert2string();
        string s = $sformatf("Burst of %0d operations:\n", op_q.size());
        foreach (op_q[i]) begin
            s = {s, $sformatf("  [%2d] r=%b w=%b addr=%3h wdata=%2h | psel1=%b psel2=%b penable=%b pwrite=%b paddr=%3h pwdata=%2h prdata_out=%2h\n",
                i, op_q[i].read, op_q[i].write, op_q[i].addr, op_q[i].apb_write_data,
                op_q[i].psel1, op_q[i].psel2, op_q[i].penable, op_q[i].pwrite, op_q[i].paddr,
                op_q[i].pwdata, op_q[i].apb_read_data_out
            )};
        end
        return s;
    endfunction

    

    virtual function void do_copy(uvm_object rhs);
        apb_m_transaction copied;
        if (!$cast(copied, rhs)) `uvm_fatal(get_type_name(), "cast failed")
        super.do_copy(rhs);
        this.op_q = copied.op_q;
    endfunction: do_copy



    function apb_m_transaction clone_me();
        apb_m_transaction clone;
        uvm_object tmp;
		
		tmp = this.clone();
		$cast(clone, tmp);
		return clone;
    endfunction: clone_me



    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        apb_m_transaction compared;
        bit same = 1;

        if (rhs == null) `uvm_fatal(get_type_name(), "rhs is null")
        if (!$cast(compared, rhs)) begin
            `uvm_error(get_type_name(), "type mismatch")
            return 0;
        end

        if (this.op_q.size() != compared.op_q.size()) begin
            `uvm_error(get_type_name(), 
                $sformatf("burst length mismatch: exp=%0d, act=%0d", 
                          this.op_q.size(), compared.op_q.size()))
            return 0;
        end

        foreach (this.op_q[i]) begin
            if (this.op_q[i] != compared.op_q[i]) begin   
                same = 0;
                `uvm_error(get_type_name(), 
                    $sformatf("beat[%0d] mismatch:\nexp=%p\nact=%p", 
                              i, this.op_q[i], compared.op_q[i]))
            end 
            else begin
                `uvm_info(get_type_name(), $sformatf("beat[%0d] OK", i), UVM_HIGH)
            end
        end

        return same;
    endfunction: do_compare
endclass
`endif