`ifndef SINGLE_READ_SLAVE1_TEST
`define SINGLE_READ_SLAVE1_TEST
class single_read_slave1_test extends apb_m_base_test #(
    single_read_slave1_seq
);
    `uvm_component_utils(single_read_slave1_test)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass
`endif