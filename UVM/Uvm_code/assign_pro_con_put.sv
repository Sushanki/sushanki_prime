// Code your testbench here
// or browse Examples
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "digi_pkg.sv"
/////////////////////////////classses


module tb_top;
  import digi_pkg::*;
  initial begin
    run_test("digi_test");
  end
endmodule

  class digi_seq_item extends uvm_sequence_item;
  rand bit [3:0] a;
    
  `uvm_object_utils_begin(digi_seq_item)
    `uvm_field_int(a,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "digi_seq_item");
    super.new(name);
  endfunction
    
    
    constraint c{a>1;}
endclass



class digi_producer extends uvm_component;
  uvm_put_port#(digi_seq_item) tlm_put;
 // uvm_get_port#(digi_seq_item) tlm_get;
  digi_seq_item se;
  `uvm_component_utils(digi_producer)

  function new(string name = "digi_producer", uvm_component parent = null);
    super.new(name, parent);
    tlm_put = new("tlm_put", this);
   // tlm_get = new("tlm_get", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    se = digi_seq_item::type_id::create("se");
    se.randomize();
    `uvm_info(get_type_name(), $sformatf("Send value = %0h", se.a), UVM_NONE);

    tlm_put.put(se);
    // tlm_get.get(se);

    se.randomize();
    `uvm_info(get_type_name(), $sformatf("For try_put: Send a = %0h", se.a), UVM_NONE);
     tlm_put.try_put(se);
     tlm_put.can_put();
  endtask
endclass


class digi_consumer extends uvm_component;
  
  uvm_put_imp #(digi_seq_item, digi_consumer) tlm_imp;
 // uvm_get_imp #(digi_seq_item, digi_consumer) tlm_imp;

  `uvm_component_utils(digi_consumer)
  
  function new(string name = "digi_consumer", uvm_component parent = null);
    super.new(name, parent);
    tlm_imp = new("tlm_imp", this);
  endfunction
  
//    virtual task get(digi_seq_item se);
//     #10;
//     `uvm_info(get_type_name(), $sformatf("Received value = %0h", se.a), UVM_NONE);
//   endtask
  
  virtual task put(digi_seq_item se);
    #10;
    `uvm_info(get_type_name(), $sformatf("Received value = %0h", se.a), UVM_NONE);
  endtask
  
  virtual function bit try_put(digi_seq_item se);
    `uvm_info(get_type_name(), $sformatf("Received try_put value = %0h", se.a), UVM_NONE);
    return 1;
  endfunction
  
  virtual function bit can_put();
    `uvm_info(get_type_name(), "inside can_put", UVM_NONE);
    return 1;
  endfunction
endclass


class digi_env extends uvm_env;
  digi_producer pro;
  digi_consumer con;
  
  `uvm_component_utils(digi_env)
  
  function new(string name = "digi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    pro = digi_producer::type_id::create("pro", this);
    con = digi_consumer::type_id::create("con", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    pro.tlm_put.connect(con.tlm_imp);
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
    #20;
    phase.drop_objection(this);
  endtask
endclass


package digi_pkg;

`include "digi_seq_item.sv"
`include "digi_producer.sv"
`include "digi_consumer.sv"
`include "digi_env.sv"
`include "digi_test.sv"

endpackage

