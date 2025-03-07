////////////////////////////////////////////////env config
class digi_base_env_config extends digi_base_cfg;

  `uvm_object_utils(digi_base_env_config)
  
virtual digi_if vif;
  bit is_agnt_active;
  bit [3:0] no_of_agents;
  bit is_sco;
  //digi_base_agent_config b_agt_cfg;
  function new(string name="digi_base_env_config");
	super.new(name);
endfunction

endclass

