`ifndef APB_M_SCOREBOARD
`define APB_M_SCOREBOARD
class apb_m_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_m_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    `uvm_analysis_imp_decl(_MASTER)
    uvm_analysis_imp_MASTER #(apb_m_transaction, apb_m_scoreboard) master_imp;


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        master_imp = new("master_imp", this);
    endfunction: build_phase


    function void write_MASTER(apb_m_transaction tr);
        `uvm_info(get_type_name(), $sformatf("Received transaction:\n%s", tr.convert2string()), UVM_LOW)
    endfunction: write_MASTER

endclass
`endif