`ifndef APB_PKG
`define APB_PKG

`include "interfaces/apb_master_if.sv"
`include "interfaces/apb_slave_if.sv"

package apb_pkg;
    timeunit      1ns;
	timeprecision 1ns;

    import uvm_pkg::*;
	`include "uvm_macros.svh"

    typedef struct {
        // Входные сигналы для мастера
        rand bit       read;              // Разрешение чтения
        rand bit       write;             // Разрешение записи
        rand bit [8:0] addr;              // Адрес для чтения или записи
        rand bit [7:0] apb_write_data;    // Данные для записи
        
        // Входные сигналы для мастера, выходные для ведомого
        rand bit       pready;            // Сигнал готовности от ведомого
        rand bit       pslverr;           // Сигнал ошибки от ведомого
        rand bit [7:0] prdata;            // Данные от ведомого при чтении

        // Выходные сигналы мастера
        rand bit       psel1;             // Сигнал выбора первого ведомого
        rand bit       psel2;             // Сигнал выбора второго ведомого
        rand bit [7:0] apb_read_data_out; // Выходные данные при чтении

        // Выходные сигналы для мастера, входные для ведомого
        rand bit       penable;           // Сигнал разрешения доступа
        rand bit       pwrite;            // Сигнал записи
        rand bit [8:0] paddr;             // Адрес
        rand bit [7:0] pwdata;            // Данные для записи
        
    } apb_op_t;
    
    // Base Classes
    `include "uvm_base_classes/base_classes_pkg.sv"

    // Agent configs
    typedef base_agent_config #(virtual apb_master_if) apb_m_agent_config;
    typedef base_agent_config #(virtual apb_slave_if)  apb_s_agent_config;

    // Callbacks
    `include "include/apb_master_callbacks_inc.svh"

    // Agents
    `include "include/apb_master_agent_inc.svh"
    `include "include/apb_slave_agent_inc.svh"

    // Scoreboard
    `include "include/scoreboard_inc.svh"

    // Coverage
    `include "include/coverage_inc.svh"

    // Enviroment
    `include "include/environment_inc.svh"

    // Sequences
    `include "include/apb_master_sequences_inc.svh"
    `include "include/apb_slave_sequences_inc.svh"

    // Tests
    `include "include/apb_master_tests_inc.svh"
    `include "include/apb_slave_tests_inc.svh"
endpackage
`endif