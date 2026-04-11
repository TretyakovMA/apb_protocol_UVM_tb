`ifndef RW_WITH_WAIT_STATES_TEST
`define RW_WITH_WAIT_STATES_TEST
class rw_with_wait_states_test extends apb_m_base_test #(
    rw_with_wait_states_seq
);
    `uvm_component_utils(rw_with_wait_states_test)

    function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

    function void create_callbacks(); 
        apb_m_driver   driver_h;
        wait_pready_cb cb;

        if(!uvm_config_db#(apb_m_driver)::get(this, "", "apb_m_driver", driver_h)) begin
            `uvm_fatal(get_type_name(), "Failed to get apb_m_driver from config_db")
        end

        cb = wait_pready_cb::type_id::create("cb");

        uvm_callbacks #(apb_m_driver, apb_m_driver_cb)::add(driver_h, cb);
	endfunction: create_callbacks

endclass
`endif