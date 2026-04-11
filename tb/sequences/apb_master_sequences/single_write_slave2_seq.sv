`ifndef SINGLE_WRITE_SLAVE2_SEQ
`define SINGLE_WRITE_SLAVE2_SEQ
class single_write_slave2_seq extends apb_m_base_seq;
    `uvm_object_utils(single_write_slave2_seq)

    function new(string name = "single_write_slave2_seq");
        super.new(name);
    endfunction

    function void apply_constraints(apb_m_transaction tr);
        assert(tr.randomize() with{
            tr.op_q.size()            == 1;
            tr.op_q[0].write          == 1;
            tr.op_q[0].addr[8]        == 1;

            tr.op_q[0].pslverr        == 0;
            tr.op_q[0].prdata         == 0;
        });
        
    endfunction: apply_constraints
endclass
`endif