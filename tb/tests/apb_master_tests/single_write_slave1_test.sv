`ifndef SINGLE_WRITE_SLAVE1_TEST
`define SINGLE_WRITE_SLAVE1_TEST
class single_write_slave1_test extends apb_m_base_test #(
    single_write_slave1_seq
);
    `uvm_component_utils(single_write_slave1_test)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass
`endif