
`uvm_analysis_imp_decl(_req_item)
`uvm_analysis_imp_decl(_resp_item)

class digi_base_sco#(type VIF=virtual digi_if,
                     type SEQ_ITEM=digi_base_seq_item,
                     type ENV_CFG=digi_base_env_config) extends uvm_scoreboard;
  
  typedef digi_base_sco#(VIF,SEQ_ITEM,ENV_CFG) digi_base_sco_t;
  `uvm_component_param_utils(digi_base_sco_t)
  
  SEQ_ITEM req_item,resp_item;

  uvm_analysis_imp_req_item# (SEQ_ITEM, digi_base_sco_t) req_item_port;
  uvm_analysis_imp_resp_item#(SEQ_ITEM, digi_base_sco_t) resp_item_port;
  
  function new(string name="digi_base_sco",uvm_component parent=null);
    super.new(name,parent);
    req_item_port = new("req_item_port", this);
    resp_item_port = new("resp_item_port", this);
  endfunction
  
  function void write_req_item( SEQ_ITEM req_s );

  endfunction

  function void write_resp_item( SEQ_ITEM resp_s);

  endfunction
  
endclass
