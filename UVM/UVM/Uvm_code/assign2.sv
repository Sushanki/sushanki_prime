// Code your design here
// ////////////////////////producer consumer
`include "uvm_macros.svh"
import uvm_pkg::*;

class digi_seq_item extends uvm_sequence_item;
  rand bit [3:0] value;
  `uvm_object_utils(digi_seq_item)
  
  function new(string name = "digi_seq_item");
    super.new(name);
  endfunction
endclass

class digi_producer extends uvm_component;
  uvm_put_port#(digi_seq_item) tlm_put;
  digi_seq_item se;
  `uvm_component_utils(digi_producer)
  
  function new(string name = "digi_producer", uvm_component parent = null);
    super.new(name, parent);
    tlm_put = new("tlm_put", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    se = digi_seq_item::type_id::create("se");
    assert(se.randomize());
    `uvm_info(get_type_name(), $sformatf("Send value = %0h", se.value), UVM_NONE);
    
    tlm_put.put(se);
    
    assert(se.randomize());
    `uvm_info(get_type_name(), $sformatf("For try_put: Send value = %0h", se.value), UVM_NONE);
    tlm_put.try_put(se);
    tlm_put.can_put();
  endtask
endclass

class digi_consumer extends uvm_component;
  uvm_put_imp #(digi_seq_item, digi_consumer) tlm_imp;
   
  `uvm_component_utils(digi_consumer)
  
  function new(string name = "digi_consumer", uvm_component parent = null);
    super.new(name, parent);
    tlm_imp = new("tlm_imp", this);
  endfunction
  
  virtual task put(digi_seq_item trans);
    #10;
    `uvm_info(get_type_name(), $sformatf("Received value = %0h", trans.value), UVM_NONE);
  endtask
  
  virtual function bit try_put(digi_seq_item trans);
    `uvm_info(get_type_name(), $sformatf("Received try_put value = %0h", trans.value), UVM_NONE);
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
  digi_env env_o;
  `uvm_component_utils(digi_test)
  
  function new(string name = "digi_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = digi_env::type_id::create("env_o", this);
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



//////////////////////////////////////////////////////////producer consumer
//3 analysis port


// Code your design here
`include "uvm_macros.svh"
import uvm_pkg::*;

class digi_seq_item extends uvm_sequence_item;
  rand bit [3:0] value;
  
  `uvm_object_utils(digi_seq_item)
  
  function new(string name = "digi_seq_item");
    super.new(name);
  endfunction
  
endclass

class digi_producer extends uvm_component;

    `uvm_component_utils(digi_producer)
   digi_seq_item se;
  uvm_analysis_port#(digi_seq_item) analysis_port_1;
  uvm_analysis_port#(digi_seq_item) analysis_port_2;
  uvm_analysis_port#(digi_seq_item) analysis_port_3;
 

  function new(string name = "digi_producer", uvm_component parent = null);
    super.new(name, parent);
    analysis_port_1 = new("analysis_port_1", this);
    analysis_port_2 = new("analysis_port_2", this);
    analysis_port_3 = new("analysis_port_3", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    se = digi_seq_item::type_id::create("se");
    se.randomize();
      `uvm_info(get_type_name(), $sformatf("analysis: Send value = %0h", se.value), UVM_NONE);
    analysis_port_1.write(se);
    analysis_port_2.write(se);
    analysis_port_3.write(se);
    
   
  
        endtask
endclass


class digi_consumer extends uvm_component;
  
  `uvm_component_utils(digi_consumer)
   digi_seq_item se;
  uvm_analysis_imp#(digi_seq_item,digi_consumer) analysis_imp_1;
  uvm_analysis_imp#(digi_seq_item,digi_consumer) analysis_imp_2;
  uvm_analysis_imp#(digi_seq_item,digi_consumer) analysis_imp_3;
  
  function new(string name = "digi_consumer", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp_1 = new("analysis_imp_1", this);
    analysis_imp_2 = new("analysis_imp_2", this);
    analysis_imp_3 = new("analysis_imp_3", this);
  endfunction

  virtual function void write(digi_seq_item se);
   
    `uvm_info(get_type_name(), $sformatf(" received value = %0h", se.value), UVM_NONE);
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
    pro.analysis_port_1.connect(con.analysis_imp_1);
    pro.analysis_port_2.connect(con.analysis_imp_2);
    pro.analysis_port_3.connect(con.analysis_imp_3);
  endfunction
endclass



class digi_test extends uvm_test;
  digi_env env_o;
  `uvm_component_utils(digi_test)

  function new(string name = "digi_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = digi_env::type_id::create("env_o", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #50;
    phase.drop_objection(this);
  endtask
  
   function void extract_data();
    `uvm_info(get_type_name(), "Extracting data from the environment and its components.", UVM_LOW);
  endfunction
  
endclass


module tb_top;
  initial begin
    run_test("digi_test");
  end
endmodule

/////////////////////////////2 producer and 1 consumer
`include "uvm_macros.svh"
import uvm_pkg::*;

class digi_seq_item extends uvm_sequence_item;
  rand bit [3:0] value;

  `uvm_object_utils(digi_seq_item)

  function new(string name = "digi_seq_item");
    super.new(name);
  endfunction

  constraint val_c { value > 0; }
endclass

class producer_1 extends uvm_component;
  digi_seq_item se;
  uvm_analysis_port #(digi_seq_item) a_put;

  `uvm_component_utils(producer_1)

  function new(string name = "producer_1", uvm_component parent = null);
    super.new(name, parent);
    a_put = new("a_put", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    se = digi_seq_item::type_id::create("se");
    se.randomize();
    `uvm_info(get_type_name(), $sformatf("Send value = %0h", se.value), UVM_NONE);
    a_put.write(se);
  endtask
endclass

class producer_2 extends uvm_component;
  digi_seq_item se;
  uvm_analysis_port #(digi_seq_item) a_put;

  `uvm_component_utils(producer_2)

  function new(string name = "producer_2", uvm_component parent = null);
    super.new(name, parent);
    a_put = new("a_put", this);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    se = digi_seq_item::type_id::create("se");
    se.randomize();
    `uvm_info(get_type_name(), $sformatf("Send value = %0h", se.value), UVM_NONE);
    a_put.write(se);
  endtask
endclass

class consumer extends uvm_component;
  digi_seq_item se;
  uvm_analysis_imp #(digi_seq_item, consumer) analysis_imp;

  `uvm_component_utils(consumer)

  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction

  virtual function void write(digi_seq_item se);
    `uvm_info(get_type_name(), $sformatf("Received value = %0h", se.value), UVM_NONE);
  endfunction
endclass

class env extends uvm_env;
  producer_1 pro1;
  producer_2 pro2;
  consumer con;
  `uvm_component_utils(env)

  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    pro1 = producer_1::type_id::create("pro1", this);
    pro2 = producer_2::type_id::create("pro2", this);
    con = consumer::type_id::create("con", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    pro1.a_put.connect(con.analysis_imp);
    pro2.a_put.connect(con.analysis_imp);
  endfunction
endclass

class test extends uvm_test;
  env env_o;
  `uvm_component_utils(test)

  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = env::type_id::create("env_o", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #50;
    phase.drop_objection(this);
  endtask
endclass

module tb_top;
  initial begin
    run_test("test");
  end
endmodule


///////////////////////////producer 3 consumer
`include "uvm_macros.svh"
import uvm_pkg::*;

class digi_seq_item extends uvm_sequence_item;
  rand bit [3:0] value;
  
  `uvm_object_utils(digi_seq_item)
  
  function new(string name = "digi_seq_item");
    super.new(name);
  endfunction
   constraint val_c {value > 0;}
endclass


class producer extends uvm_component;
  digi_seq_item se;
  uvm_analysis_port #(digi_seq_item) a_put;
  
  `uvm_component_utils(producer)
  
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
    a_put = new("a_put", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    se = digi_seq_item::type_id::create("se");
    se.randomize();
    `uvm_info(get_type_name(), $sformatf("Send value = %0h", se.value), UVM_NONE);
    a_put.write(se);
  endtask
endclass

class consumer_1 extends uvm_component;
  digi_seq_item se;
  uvm_analysis_imp #(digi_seq_item, consumer_1) analysis_imp_1;
  
  `uvm_component_utils(consumer_1)
  
  function new(string name = "consumer_1", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp_1 = new("analysis_imp_1", this);
  endfunction
  
  virtual function void write(digi_seq_item se);
    `uvm_info(get_type_name(), $sformatf("Received value = %0h", se.value), UVM_NONE);
  endfunction
endclass

class consumer_2 extends uvm_component;
  digi_seq_item se;
  uvm_analysis_imp #(digi_seq_item, consumer_2) analysis_imp_2;
  
  `uvm_component_utils(consumer_2)
  
  function new(string name = "consumer_2", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp_2 = new("analysis_imp_2", this);
  endfunction
  
  virtual function void write(digi_seq_item se);
    `uvm_info(get_type_name(), $sformatf("Received value = %0h", se.value), UVM_NONE);
  endfunction
endclass

class consumer_3 extends uvm_subscriber #(digi_seq_item);
  digi_seq_item se;
  `uvm_component_utils(consumer_3)
  
  function new(string name = "consumer_3", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void write (digi_seq_item t);
    se = t;
    `uvm_info(get_type_name(), $sformatf("Received value = %0h", se.value), UVM_NONE);
  endfunction
endclass

class env extends uvm_env;
  producer pro;
  consumer_1 con_1;
  consumer_2 con_2;
  consumer_3 con_3;
  `uvm_component_utils(env)
  
  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    pro = producer::type_id::create("pro", this);
    con_1 = consumer_1::type_id::create("con_1", this);
    con_2 = consumer_2::type_id::create("con_2", this);
    con_3 = consumer_3::type_id::create("con_3", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    pro.a_put.connect(con_1.analysis_imp_1);
    pro.a_put.connect(con_2.analysis_imp_2);
    pro.a_put.connect(con_3.analysis_export);
  endfunction
endclass
              
class test extends uvm_test;
  env env_o;
  `uvm_component_utils(test)
  
  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = env::type_id::create("env_o", this);
  endfunction
 
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #50;
    phase.drop_objection(this);
  endtask
endclass

module tb_top;
  initial begin
    run_test("test");
  end
endmodule



/////////////////////////////////////////////////////////////TLM FIFO
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
  uvm_blocking_put_port #(digi_seq_item) tlm_put;
  
  `uvm_component_utils(producer)
  
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
    tlm_put = new("tlm_put", this);
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    repeat(10) begin
      se = digi_seq_item::type_id::create("se");
      assert(se.randomize());
      tlm_put.put(se);
      `uvm_info(get_name(), $sformatf("Send a = %0h", se.a), UVM_NONE);
      #5;
    end
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
    
    repeat(10) begin
      #10;
      tlm_get.get(se);
      `uvm_info(get_name(), $sformatf("Received a = %0h", se.a), UVM_NONE);
    end
  endtask
endclass

class digi_env extends uvm_env;
  uvm_tlm_fifo #(digi_seq_item) tlm_fifo;
  producer pro;
  consumer con;
  `uvm_component_utils(digi_env)
  
  function new(string name = "digi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    tlm_fifo = new("tlm_fifo", this, 3);//3 depth of fifo
    pro = producer::type_id::create("pro", this);
    con = consumer::type_id::create("con", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    pro.tlm_put.connect(tlm_fifo.put_export);
    con.tlm_get.connect(tlm_fifo.get_export);
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
    
    fork begin
      while(1) begin
        if(env.tlm_fifo.is_empty) `uvm_info(get_name(), "FIFO is empty", UVM_LOW);
        if(env.tlm_fifo.is_full) `uvm_info(get_name(), "FIFO is full", UVM_LOW);
        `uvm_info(get_name(), $sformatf("FIFO size = %0d, used = %0d", env.tlm_fifo.size(), env.tlm_fifo.used()), UVM_LOW);
        #5;
      end
    end
    begin
      #30;
      if(env.tlm_fifo.is_full) begin
        `uvm_info(get_name(), $sformatf("Before flush: FIFO used = %0d, is_empty = %0d", env.tlm_fifo.used, env.tlm_fifo.is_empty), UVM_LOW);
        env.tlm_fifo.flush();
        `uvm_info(get_name(), $sformatf("After flush: FIFO used = %0d, is_empty = %0d", env.tlm_fifo.used, env.tlm_fifo.is_empty), UVM_LOW);
      end
    end
    join_any
    disable fork;
    phase.drop_objection(this);
  endtask
endclass

module tb_top;
  initial begin
    run_test("digi_test");
  end
endmodule
