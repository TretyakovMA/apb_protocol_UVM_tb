`ifndef APB_M_TRANSACTION
`define APB_M_TRANSACTION
class apb_m_transaction extends uvm_sequence_item;

    `uvm_object_utils(apb_m_transaction)

    // Входные сигналы
    rand bit        transfer;          // Инициирование транзакции
    rand bit        read;              // Разрешение чтения
    rand bit        write;             // Разрешение записи
    rand bit [8:0]  apb_write_paddr;   // Адрес для записи
    rand bit [7:0]  apb_write_data;    // Данные для записи
    rand bit [8:0]  apb_read_paddr;    // Адрес для чтения

    rand bit        pready;            // Сигнал готовности от ведомого             
    rand bit        pslverr;           // Сигнал ошибки от ведомого              
    rand bit [7:0]  prdata;            // Данные от ведомого при чтении

    // Выходные сигналы
    bit             psel1;             // Сигнал выбора первого ведомого
    bit             psel2;             // Сигнал выбора второго ведомого
    bit             penable;           // Сигнал разрешения доступа
    bit             pwrite;            // Сигнал записи
    bit [8:0]       paddr;             // Адрес
    bit [7:0]       pwdata;            // Данные для записи
    bit [7:0]       apb_read_data_out; // Выходные данные при чтении

    

    function new(string name = "apb_m_transaction");
        super.new(name);
    endfunction


    function string convert2string();
        string s = "-------------------- Input -------------------\n";

        s = {s, $sformatf("read = %0b; write = %0b\n", read, write)};
        s = {s, $sformatf("apb_write_paddr = %0h; apb_write_data = %0h; apb_read_paddr = %0h\n", apb_write_paddr, apb_write_data, apb_read_paddr)};
        s = {s, $sformatf("pready = %0b; pslverr = %0b; prdata = %0h\n", pready, pslverr, prdata)};
        
        s = {s, "-------------------- Output ------------------\n"};
        s = {s, $sformatf("psel1 = %0b; psel2 = %0b; penable = %0b; pwrite = %0b\n", psel1, psel2, penable, pwrite)};
        s = {s, $sformatf("paddr = %0h; pwdata = %0h\n", paddr, pwdata)};

        return s;
    endfunction: convert2string
endclass
`endif