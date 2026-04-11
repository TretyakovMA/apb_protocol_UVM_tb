`ifndef RW_WITH_WAIT_STATES_SEQ
`define RW_WITH_WAIT_STATES_SEQ
class rw_with_wait_states_seq extends apb_m_base_seq;
    `uvm_object_utils(rw_with_wait_states_seq)

    function new(string name = "rw_with_wait_states_seq");
        super.new(name);
    endfunction

    function void apply_constraints(apb_m_transaction tr);
        assert(tr.randomize() with{
            tr.op_q.size() == 1;
            
            (tr.op_q[0].read  == 1) -> (tr.op_q[0].apb_write_data == 0);
            (tr.op_q[0].write == 1) -> (tr.op_q[0].prdata         == 0);
                
            tr.op_q[0].pslverr == 0;
            
        });
    endfunction: apply_constraints
endclass
`endif