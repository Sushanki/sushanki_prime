//////////////////////////////////////////////////////////////get method

`include "uvm_macros.svh"
import uvm_pkg::*;


class digi_seq_item extends uvm_sequence_item;
  rand bit [3:0] a;
  `uvm_object_utils(digi_seq_item)
  
  function new(string name = "digi_seq_item");
    super.new(name);
  endfunction
endclass

class producer extends uvm_component;
  digi_seq_item se;
  uvm_blocking_get_imp #(digi_seq_item, producer) tlm_imp;
  
  `uvm_component_utils(producer)
  
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
    tlm_imp = new("tlm_imp", this);
  endfunction
  
  virtual task get(output digi_seq_item se);
    se = digi_seq_item::type_id::create("se");
    se.randomize();
    `uvm_info(get_type_name(), $sformatf("Send a = %0h", se.a), UVM_NONE);
  endtask
endclass

class consumer extends uvm_component;
  digi_seq_item se;
  uvm_blocking_get_port #(digi_seq_item) tlm_get;
  
  `uvm_component_utils(consumer)
  
  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
    tlm_get = new("tlm_get", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    tlm_get.get(se);
    `uvm_info(get_type_name(), $sformatf("Received a = %0h", se.a), UVM_NONE);
  endtask
  
endclass

class digi_env extends uvm_env;
  producer pro;
  consumer con;
  `uvm_component_utils(digi_env)
  
  function new(string name = "digi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    pro = producer::type_id::create("pro", this);
    con = consumer::type_id::create("con", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    con.tlm_get.connect(pro.tlm_imp);
  endfunction
endclass
              
class digi_test extends uvm_test;
  digi_env env;
  `uvm_component_utils(digi_test)
  
  function new(string name = "digi_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = digi_env::type_id::create("env", this);
  endfunction
 
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #50;
    phase.drop_objection(this);
  endtask
endclass

module tb_top;
  initial begin
    run_test("digi_test");
  end
endmodule



