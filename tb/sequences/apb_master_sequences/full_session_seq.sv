`ifndef FULL_SESSION_SEQ
`define FULL_SESSION_SEQ
class full_session_seq extends apb_m_base_seq #(100);
    `uvm_object_utils(full_session_seq)

    function new(string name = "full_session_seq");
        super.new(name);
    endfunction

    function void apply_constraints(apb_m_transaction tr);
        assert(tr.randomize() with{

            foreach(tr.op_q[i]) {
                (tr.op_q[i].read  == 1) -> (tr.op_q[i].apb_write_data == 0);
                (tr.op_q[i].write == 1) -> (tr.op_q[i].prdata         == 0);
                
                tr.op_q[i].pslverr == 0;
            }
            
        });
    endfunction: apply_constraints
endclass
`endif