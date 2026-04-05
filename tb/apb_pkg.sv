`ifndef APB_PKG
`define APB_PKG

`include "interfaces/apb_master_if.sv"

package apb_pkg;
    timeunit      1ns;
	timeprecision 100ps;

    import uvm_pkg::*;
	`include "uvm_macros.svh"
    
    // Base Classes
    `include "uvm_base_classes/base_classes_pkg.sv"
    //`include "base_classes/base_pkg.sv"

    // Agent configs
    typedef base_agent_config #(virtual apb_master_if) apb_m_agent_config;

    // Agents
    `include "agents/included_files/apb_master_agent_inc.svh"

    // Verification components
    `include "verification_classes/apb_m_scoreboard.sv"

    // Enviroment
    `include "environment/environment_inc.svh"

    // Sequences
    `include "sequences/simple_seq.sv"

    // Tests
    `include "tests/simple_test.sv"
endpackage
`endif