`ifndef SINGLE_READ_SLAVE1_SEQ
`define SINGLE_READ_SLAVE1_SEQ
class single_read_slave1_seq extends apb_m_base_seq;
    `uvm_object_utils(single_read_slave1_seq)

    function new(string name = "single_read_slave1_seq");
        super.new(name);
    endfunction

    function void apply_constraints(apb_m_transaction tr);
        assert(tr.randomize() with{
            tr.op_q.size()            == 1;
            tr.op_q[0].read           == 1;
            tr.op_q[0].addr[8]        == 0;
            tr.op_q[0].apb_write_data == 0;

            tr.op_q[0].pslverr        == 0;
        });
    endfunction: apply_constraints
endclass
`endif