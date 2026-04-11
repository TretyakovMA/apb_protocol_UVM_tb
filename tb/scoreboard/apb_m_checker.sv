`ifndef APB_M_CHECKER
`define APB_M_CHECKER
class apb_m_checker extends uvm_object;

    `uvm_object_utils(apb_m_checker)

    function new(string name = "apb_m_checker");
        super.new(name);
    endfunction

    function apb_m_transaction calc_exp_tr(apb_m_transaction tr);
        apb_m_transaction exp_tr;

        exp_tr = tr.clone_me();

        foreach(exp_tr.op_q[i]) begin
            exp_tr.op_q[i].psel1   = ~exp_tr.op_q[i].addr[8];
            exp_tr.op_q[i].psel2   = exp_tr.op_q[i].addr[8];
            exp_tr.op_q[i].pwrite  = exp_tr.op_q[i].write;
            exp_tr.op_q[i].paddr   = exp_tr.op_q[i].addr;
            exp_tr.op_q[i].penable = 1; 
            
            if(exp_tr.op_q[i].write) begin
                exp_tr.op_q[i].pwdata            = exp_tr.op_q[i].apb_write_data;
            end
            else begin
                exp_tr.op_q[i].pwdata            = 'h00;
                exp_tr.op_q[i].apb_read_data_out = exp_tr.op_q[i].prdata;
            end
        end

        return exp_tr;
    endfunction: calc_exp_tr


    function bit check_transaction(apb_m_transaction transaction);
        apb_m_transaction tr;
        apb_m_transaction exp_tr;
        bit               correct = 1;

        tr     = transaction.clone_me();
        exp_tr = calc_exp_tr(tr);

        correct = exp_tr.compare(tr);

        if(!correct) begin
            `uvm_error(get_type_name(), {"Get transaction:\n", tr.convert2string(), "\n\nExpected transaction:\n", exp_tr.convert2string()})
        end
        return correct;
    endfunction: check_transaction

endclass
`endif