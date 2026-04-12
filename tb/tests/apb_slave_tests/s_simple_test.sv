`ifndef S_SIMPLE_TEST
`define S_SIMPLE_TEST
class s_simple_test extends sequence_base_test #(
    .SEQUENCE_TYPE(s_simple_seq),
    .SEQUENCER_TYPE(apb_s_sequencer),
    .IS_VIRTUAL_SEQUENCE(0),
    .PARENT_TYPE(base_test)
);
    `uvm_component_utils(s_simple_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function string get_sequencer_name();
        return "apb_s_sequencer";
    endfunction: get_sequencer_name

    function void adjust_env_config();
		env_config_h.has_slave_agent = 1;
    endfunction: adjust_env_config
endclass
`endif