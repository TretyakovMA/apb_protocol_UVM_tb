`ifndef APB_M_BASE_TEST
`define APB_M_BASE_TEST
class apb_m_base_test #(
    type APB_M_SEQUENCE_TYPE
) extends sequence_base_test #(
    .SEQUENCE_TYPE      (APB_M_SEQUENCE_TYPE),
    .SEQUENCER_TYPE     (apb_m_sequencer   ),
    .IS_VIRTUAL_SEQUENCE(0                 ),
    .PARENT_TYPE        (base_test         )
);
    `uvm_component_param_utils(apb_m_base_test #(APB_M_SEQUENCE_TYPE));
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function string get_sequencer_name();
        return "apb_m_sequencer";
    endfunction: get_sequencer_name

    function void adjust_env_config;
		env_config_h.has_master_agent = 1;
    endfunction: adjust_env_config
endclass
`endif