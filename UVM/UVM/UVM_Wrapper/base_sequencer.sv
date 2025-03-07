////////////////////////////////////////////////sequencer

class digi_base_seqr#(type VIF=virtual digi_if,
                      type SEQ_ITEM=digi_base_seq_item,
                     type AGT_CFG=digi_base_agent_config) extends uvm_sequencer#(SEQ_ITEM);


`uvm_component_param_utils(digi_base_seqr)

  function new(string name="digi_base_seqr" ,uvm_component parent=null);
	super.new(name,parent);
endfunction

endclass
