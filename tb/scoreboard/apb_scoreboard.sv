`ifndef APB_SCOREBOARD
`define APB_SCOREBOARD
class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard)

    apb_m_checker m_checker_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    `uvm_analysis_imp_decl(_MASTER)
    uvm_analysis_imp_MASTER #(apb_m_transaction, apb_scoreboard) master_imp;


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        master_imp = new("master_imp", this);

        m_checker_h = apb_m_checker::type_id::create("m_checker_h");
    endfunction: build_phase


    function void write_MASTER(apb_m_transaction tr);

        if(!m_checker_h.check_transaction(tr)) begin
            `uvm_info(get_type_name(), `RES_FAILD_STR, UVM_LOW)
        end
        else begin
            `uvm_info(get_type_name(), `RES_SUC_STR, UVM_LOW)
        end

        `uvm_info(get_type_name(), `END_TEST_STR, UVM_LOW)
    endfunction: write_MASTER
    

endclass
`endif