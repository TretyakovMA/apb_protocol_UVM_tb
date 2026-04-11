`ifndef BACK_TO_BACK_READ_TEST
`define BACK_TO_BACK_READ_TEST
class back_to_back_read_test extends apb_m_base_test #(
    back_to_back_read_seq
);
    `uvm_component_utils(back_to_back_read_test)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass
`endif