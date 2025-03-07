////////////////////////////////////////////////test

class digi_base_test extends uvm_test;
  
  virtual digi_if vif;
  virtual digi_if vif_test;
  bit is_active;
  int is_agnt_active;
  int no_of_agents;
  int is_sco;
  
`uvm_component_utils(digi_base_test)
  
  typedef digi_base_env#(digi_base_env_config) ENV;
  
  ENV env;
  
  function new(string name="digi_base_test" ,uvm_component parent);
	super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
       env = ENV::type_id::create("env", this);
    
    //////////////////interface
        if(!uvm_config_db #(virtual digi_if)::get(this,"","vif_test_h",vif))
          `uvm_fatal (get_full_name(), "Did not get interface from top")
          
    //////////////////is_active
    if(!uvm_config_db #(bit)::get(this,"","is_active",is_active))
      `uvm_fatal (get_full_name(), "Did not get a configuration object for test")
      
     ///////////////////is_agnt_active
      if(!uvm_config_db #(int)::get(this,"","is_agnt_active",is_agnt_active))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
         
     ///////////////////no_of_agents
        if(!uvm_config_db #(int)::get(this,"","no_of_agents",no_of_agents))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
       
      ////////////////is_sco
          if(!uvm_config_db #(int)::get(this,"","is_sco",is_sco))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
                   
      //////////////////////////////set for env for is_active
    uvm_config_db#(virtual digi_if)::set(this,"env","vif",vif);
    uvm_config_db#(bit)::set(this,"env","is_active",is_active);
    uvm_config_db#(int)::set(this,"env","is_agnt_active",is_agnt_active);
    uvm_config_db#(int)::set(this,"env","no_of_agents",no_of_agents);
    uvm_config_db#(int)::set(this,"env","is_sco",is_sco);
    endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    env.vif = vif_test;
  endfunction
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
    endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask

   virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase); 
  endfunction 
endclass

