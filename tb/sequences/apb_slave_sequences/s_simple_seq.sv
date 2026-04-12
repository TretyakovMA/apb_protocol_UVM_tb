`ifndef S_SIMPLE_SEQ
`define S_SIMPLE_SEQ
class s_simple_seq extends uvm_sequence #(apb_s_transaction);
    `uvm_object_utils(s_simple_seq)

    function new(string name = "s_simple_seq");
        super.new(name);
    endfunction

    task body();
        apb_s_transaction tr;
        tr = apb_s_transaction::type_id::create("tr");
        start_item(tr);

        tr.op.pwrite          = 1;
        tr.op.paddr           = 8'hFF;
        tr.op.pwdata          = 8'h5A;

        //assert(tr.randomize());

        //tr.transfer        = 1;
        /*tr.write           = 1;
        tr.read            = 0;
        tr.apb_write_paddr = 9'h085;
        tr.apb_write_data  = 8'h5A;*/

        //tr.pready          = 1;
        
        finish_item(tr);
    endtask
endclass
`endif