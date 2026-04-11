`ifndef SINGLE_WRITE_SLAVE2_TEST
`define SINGLE_WRITE_SLAVE2_TEST
class single_write_slave2_test extends apb_m_base_test #(
    single_write_slave2_seq
);
    `uvm_component_utils(single_write_slave2_test)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass
`endif