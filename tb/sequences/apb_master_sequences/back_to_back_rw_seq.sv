`ifndef BACK_TO_BACK_RW_SEQ
`define BACK_TO_BACK_RW_SEQ
class back_to_back_rw_seq extends apb_m_base_seq;
    `uvm_object_utils(back_to_back_rw_seq)

    function new(string name = "back_to_back_rw_seq");
        super.new(name);
    endfunction

    function void apply_constraints(apb_m_transaction tr);
        assert(tr.randomize() with{
            tr.op_q.size() > 1;

            foreach(tr.op_q[i]) {
                (tr.op_q[i].read == 1) -> (tr.op_q[i].apb_write_data == 0);
                (tr.op_q[i].write == 1) -> (tr.op_q[i].prdata == 0);
                
                tr.op_q[i].pslverr == 0;
            }
        });
    endfunction: apply_constraints
endclass
`endif