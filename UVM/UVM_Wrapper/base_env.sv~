////////////////////////////////////////////////env
class digi_base_env#(type ENV_CFG=digi_base_env_config) extends uvm_env;

  `uvm_component_param_utils(digi_base_env#(ENV_CFG))

 
  ENV_CFG env_cfg;
  typedef digi_base_sco#(virtual digi_if,digi_base_seq_item,ENV_CFG) SCO_t;
  SCO_t sco[];
  
  virtual digi_if vif;
  bit is_active;//signal drive to dut than agent active
  int is_agnt_active;
  int no_of_agents;
  int is_sco;
  
   typedef digi_base_agent#(virtual digi_if,digi_base_seq_item,digi_base_agent_config,digi_base_seqr#(virtual digi_if, digi_base_seq_item),
                            digi_base_drv#(virtual digi_if, digi_base_seq_item, digi_base_agent_config),
                           digi_base_mon#(virtual digi_if, digi_base_seq_item, digi_base_agent_config)) AGT_t;
  AGT_t agt[];
  function new(string name="digi_base_env", uvm_component parent=null);
    super.new(name, parent);
 
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_cfg = ENV_CFG::type_id::create("env_cfg");

          //////////////////interface
    if(!uvm_config_db #(virtual digi_if)::get(this,"","vif",vif))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
      
      //////////////is_active
     if (!uvm_config_db #(bit)::get(this, "", "is_active", is_active))
       `uvm_fatal (get_full_name, "Did not get a configuration object for env")
       

       ////////////////is_agnt_active
       if(!uvm_config_db #(int)::get(this,"","is_agnt_active",is_agnt_active))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
      
       //////////////no_of_agents
         if(!uvm_config_db #(int)::get(this,"","no_of_agents",no_of_agents))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
      
      /////////////////is_sco
           if(!uvm_config_db #(int)::get(this,"","is_sco",is_sco))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
    
    ///////////interface set
     //env_cfg.vif = vif;
    //uvm_config_db#(virtual digi_if)::set(this,"agt","vif",vif);
             
    agt = new[no_of_agents];
    sco = new[no_of_agents];
    
    //////////////////////agent object creation
   env_cfg.is_agnt_active = is_agnt_active;
   env_cfg.no_of_agents = no_of_agents;
//    if(env_cfg.is_agnt_active ==1 && env_cfg.no_of_agents==1)
     for(int i=0;i<no_of_agents; i++) 
       begin
         agt[i] = AGT_t::type_id::create($sformatf("agt[%0d]", i), this); 
         uvm_config_db#(bit)::set(this,$sformatf("agt[%0d]", i),"is_active",is_active);
       end
    //////////////////////////scoreboard object creation
   env_cfg.is_sco = is_sco;
   if(env_cfg.is_sco==1)
   for(int i=0;i<no_of_agents; i++)
     begin
       sco[i] = SCO_t::type_id::create($sformatf("sco[%0d]", i), this);
     end
    for(int i=0;i<no_of_agents; i++)
      begin
            uvm_config_db#(virtual digi_if)::set(this, $sformatf("agt[%0d]", i), "vif",vif);
     end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    env_cfg.vif = vif;
    if(env_cfg.is_agnt_active ==1 && env_cfg.no_of_agents==1 && env_cfg.is_sco==1) 
      begin
        
        for(int i=0;i<no_of_agents; i++)begin
          //agt[i].vif = vif;
        agt[i].mon.mon_analysis_port.connect(sco[i].req_item_port);
        agt[i].mon.mon_analysis_port.connect(sco[i].resp_item_port);
        end
      end
  endfunction

endclass
////////////////////////no of agents and no of scoreboard independent of each other

