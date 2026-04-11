`ifndef APB_M_COVERAGE
`define APB_M_COVERAGE

class apb_m_coverage extends uvm_subscriber #(apb_m_transaction);

    `uvm_component_utils(apb_m_coverage)

    // =============================================
    // Покрытие уровня всей пачки (burst)
    // =============================================
    covergroup burst_cg with function sample(int burst_len);
        option.name = "burst_cg";
        option.per_instance = 1;

        // Размер пачки операций
        cp_burst_len : coverpoint burst_len {
            bins len[] = {[1:10]};
        }
    endgroup

    // =============================================
    // Покрытие отдельной операции (op)
    // =============================================
    covergroup op_cg with function sample(apb_op_t op);
        option.name = "op_cg";
        option.per_instance = 1;

        // Тип операции: read или write (по constraint read ^ write)
        cp_rw : coverpoint {op.read, op.write} {
            bins read_op  = {2'b10};
            bins write_op = {2'b01};
            illegal_bins invalid = default;
        }

        // Выбор slave (psel1 / psel2) — выходы мастера
        cp_psel : coverpoint {op.psel1, op.psel2} {
            bins slave1 = {2'b10};
            bins slave2 = {2'b01};
        }

        // Адрес (9 бит). Разбиваем на осмысленные диапазоны
        cp_addr : coverpoint op.addr[8:0] {
            bins addr_low   = {[9'h000 : 9'h07F]};  // 0-127
            bins addr_mid   = {[9'h080 : 9'h0FF]};  // 128-255
            bins addr_high  = {[9'h100 : 9'h1FF]};  // 256-511
        }

        // Данные для записи (только для write)
        cp_wdata : coverpoint op.pwdata {
            bins all_zero  = {8'h00};
            bins all_one   = {8'hFF};
            bins data_low  = {[8'h00 : 8'h3F]};  // 0-63
            bins data_mid  = {[8'h40 : 8'h7F]};  // 64-127
            bins data_high = {[8'h80 : 8'hFF]};  // 128-255
            bins others   = default;
        }

        // Данные, прочитанные мастером (apb_read_data_out)
        cp_rdata_out : coverpoint op.apb_read_data_out {
            bins all_zero = {8'h00};
            bins all_one  = {8'hFF};
            bins data_low  = {[8'h00 : 8'h3F]};  // 0-63
            bins data_mid  = {[8'h40 : 8'h7F]};  // 64-127
            bins data_high = {[8'h80 : 8'hFF]};  // 128-255
            bins others   = default;
        }

        // Ошибка от слейва (pslverr)
        cp_pslverr : coverpoint op.pslverr {
            bins no_error = {0};
            bins error    = {1};
        }

        


        // =============================================
        // Кросс-покрытие 
        // =============================================
        // Тип операции × выбор slave
        cr_rw_psel : cross cp_rw, cp_psel;

        

    endgroup

    // =============================================
    // Конструктор
    // =============================================
    function new(string name = "apb_master_coverage", uvm_component parent = null);
        super.new(name, parent);
        burst_cg = new();
        op_cg   = new();
    endfunction

    // =============================================
    // Основной метод: вызывается из analysis port
    // =============================================
    virtual function void write(apb_m_transaction t);
        if (t == null) begin
            `uvm_error(get_type_name(), "получен null-транзакция")
            return;
        end

        // Покрываем всю пачку один раз
        burst_cg.sample(t.op_q.size());

        // Покрываем каждую операцию внутри пачки
        foreach (t.op_q[i]) begin
            op_cg.sample(t.op_q[i]);
            `uvm_info(get_type_name(),
                $sformatf("sampled op[%0d] of burst (len=%0d)", i, t.op_q.size()),
                UVM_HIGH)
        end
    endfunction

endclass

`endif