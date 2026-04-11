`ifndef ENV
`define ENV
class env extends uvm_env;
	`uvm_component_utils(env);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	env_config             config_h;

	apb_m_agent            m_agent_h;

	apb_scoreboard         scoreboard_h;
	apb_m_coverage         m_coverage_h;

	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		// Получение env_config от текущего теста
		if(!uvm_config_db #(env_config)::get(this, "", "env_config", config_h))
			`uvm_fatal(get_type_name(), "Faild to get env_config")
		
		scoreboard_h  = apb_scoreboard::type_id::create("scoreboard_h", this);
		m_coverage_h  = apb_m_coverage::type_id::create("m_coverage_h", this);
		
		if(config_h.has_master_agent) begin
			uvm_config_db #(apb_m_agent_config)::set(this, "m_agent_h", "agent_config", config_h.apb_m_agent_config_h);
			m_agent_h = apb_m_agent::type_id::create("m_agent_h", this);
		end

	endfunction: build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(config_h.has_master_agent) begin
			m_agent_h.ap.connect(scoreboard_h.master_imp);
			m_agent_h.ap.connect(m_coverage_h.analysis_export);
		end

	endfunction: connect_phase
endclass
`endif