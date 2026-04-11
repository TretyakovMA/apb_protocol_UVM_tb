`ifndef BACK_TO_BACK_WRITE_TEST
`define BACK_TO_BACK_WRITE_TEST
class back_to_back_write_test extends apb_m_base_test #(
    back_to_back_write_seq
);
    `uvm_component_utils(back_to_back_write_test)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass
`endif