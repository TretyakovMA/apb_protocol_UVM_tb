`ifndef ENV_CONFIG
`define ENV_CONFIG
class env_config extends uvm_object;
	`uvm_object_utils(env_config)

	apb_m_agent_config apb_m_agent_config_h;

	bit has_master_agent;
	
	function new(string name = "env_config");
		super.new(name);
		
		apb_m_agent_config_h = apb_m_agent_config::type_id::create("apb_m_agent_config_h");
	endfunction: new
	
endclass
`endif

