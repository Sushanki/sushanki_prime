////////////////////////////////////////////////driver
class digi_base_drv#(type VIF=virtual digi_if, 
                     type SEQ_ITEM=digi_base_seq_item, 
                     type AGT_CFG=digi_base_agent_config) extends uvm_driver#(SEQ_ITEM);

  `uvm_component_param_utils(digi_base_drv)
    SEQ_ITEM se;
  function new(string name="digi_base_drv", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    //forever begin
      
//       seq_item_port.get_next_item(se);
//       send_to_dut();
//       seq_item_port.item_done();
    //end
  endtask

//   task send_to_dut();
//     // Add your logic here
//   endtask

endclass
