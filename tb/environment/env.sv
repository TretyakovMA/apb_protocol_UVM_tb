`ifndef ENV
`define ENV
class env extends uvm_env;
	`uvm_component_utils(env);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	env_config             env_config_h;

	apb_m_agent            apb_m_agent_h;

	apb_m_scoreboard       scoreboard_h;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		// Получение env_config от текущего теста
		if(!uvm_config_db #(env_config)::get(this, "", "env_config", env_config_h))
			`uvm_fatal(get_type_name(), "Faild to get env_config")
		
		scoreboard_h  = apb_m_scoreboard::type_id::create("scoreboard_h", this);
		
		uvm_config_db #(apb_m_agent_config)::set(this, "apb_m_agent_h", "agent_config", env_config_h.apb_m_agent_config_h);
		apb_m_agent_h = apb_m_agent::type_id::create("apb_m_agent_h", this);

	endfunction: build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		apb_m_agent_h.ap.connect(scoreboard_h.master_imp);
	endfunction: connect_phase
endclass
`endif