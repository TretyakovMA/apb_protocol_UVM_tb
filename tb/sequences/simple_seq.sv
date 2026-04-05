`ifndef SIMPLE_SEQ
`define SIMPLE_SEQ
class simple_seq extends uvm_sequence #(apb_m_transaction);
    `uvm_object_utils(simple_seq)

    function new(string name = "simple_seq");
        super.new(name);
    endfunction

    task body();
        apb_m_transaction tr;
        tr = apb_m_transaction::type_id::create("tr");
        start_item(tr);

        tr.transfer        = 1;
        tr.write           = 1;
        tr.read            = 0;
        tr.apb_write_paddr = 8'hA5;
        tr.apb_write_data  = 8'h5A;

        tr.pready          = 1;
        
        finish_item(tr);
    endtask
endclass
`endif