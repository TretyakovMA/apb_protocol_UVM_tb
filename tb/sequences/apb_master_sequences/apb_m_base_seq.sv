`ifndef APB_M_BASE_SEQ
`define APB_M_BASE_SEQ
class apb_m_base_seq #(
    int NUMBER_OF_REPETITIONS = 1
) extends uvm_sequence #(apb_m_transaction);
    `uvm_object_param_utils(apb_m_base_seq #(NUMBER_OF_REPETITIONS))

    function new(string name = "apb_m_base_seq");
        super.new(name);
    endfunction

    apb_m_transaction tr;

    virtual function void apply_constraints(apb_m_transaction tr);
        assert(tr.randomize());
    endfunction: apply_constraints

    task body();
        repeat(NUMBER_OF_REPETITIONS) begin
            tr = apb_m_transaction::type_id::create("tr");
            start_item(tr);
            `uvm_info(get_type_name(), "Start sequence", UVM_FULL)

            apply_constraints(tr);

            `uvm_info(get_type_name(), `START_TEST_STR, UVM_LOW)
			finish_item(tr);
        end
    endtask: body

endclass
`endif