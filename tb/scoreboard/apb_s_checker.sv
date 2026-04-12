`ifndef APB_S_CHECKER
`define APB_S_CHECKER
class apb_s_checker extends uvm_object;
    `uvm_object_utils(apb_s_checker)

    function new(string name = "apb_s_checker");
        super.new(name);
    endfunction: new

    function bit check_transaction(apb_s_transaction transaction);
        apb_s_transaction tr;
        bit               correct = 1;

        tr = transaction.clone_me();

        `uvm_info(get_type_name(), {"Get transaction:\n", tr.convert2string()}, UVM_LOW)

        
        return correct;
    endfunction: check_transaction
endclass
`endif