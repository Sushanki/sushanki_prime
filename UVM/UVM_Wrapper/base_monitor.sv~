////////////////////////////////////////////////monitor
class digi_base_mon#(type VIF=virtual digi_if,
                     type SEQ_ITEM=digi_base_seq_item,
                     type AGT_CFG=digi_base_agent_config) extends uvm_monitor;

  `uvm_component_param_utils(digi_base_mon)

  uvm_analysis_port #(SEQ_ITEM) mon_analysis_port;
  SEQ_ITEM seq_item;
  
  function new(string name="digi_base_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_analysis_port = new("mon_analysis_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    //forever begin
      mon_analysis_port.write(seq_item);
      $display("i am in monitor forever");
    //end
  endtask

endclass

