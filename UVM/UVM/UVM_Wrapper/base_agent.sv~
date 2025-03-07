////////////////////////////////////////////////agent
class digi_base_agent#(
  type VIF=virtual digi_if,
  type SEQ_ITEM=digi_base_seq_item,
  type AGT_CFG=digi_base_agent_config,
  type SEQR=digi_base_seqr#(VIF, SEQ_ITEM,AGT_CFG),
  type DRV=digi_base_drv#(VIF, SEQ_ITEM, AGT_CFG),
  type MON=digi_base_mon#(VIF, SEQ_ITEM, AGT_CFG)
) extends uvm_agent;

  `uvm_component_param_utils(digi_base_agent)
  VIF vif;
  AGT_CFG agt_cfg;
  SEQR sqr;    // Sequencer Handle
  DRV drv;     // Driver handle
  MON mon;     // Monitor handle
bit is_active;
  
  function new(string name="digi_base_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
           //////////////////interface
    if(!uvm_config_db #(virtual digi_if)::get(this,"","vif",vif))
      `uvm_fatal (get_full_name(), "not getting from the TESTBENCH")

      ///////////////////is_active
    if (!uvm_config_db #(bit)::get(this, "", "is_active", is_active))
      `uvm_fatal (get_full_name, "Did not get a configuration object for agent")


    
    agt_cfg = AGT_CFG::type_id::create("agt_cfg");
    agt_cfg.is_active = is_active;
    
    
    mon = MON::type_id::create("mon", this);
    if (agt_cfg.is_active)
    begin
      sqr = SEQR::type_id::create("sqr", this);
      drv = DRV::type_id::create("drv", this);
    end

  
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    if (agt_cfg.is_active)
      drv.seq_item_port.connect(sqr.seq_item_export);
    agt_cfg.vif = vif;
  endfunction

endclass

