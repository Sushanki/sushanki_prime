////////////////////////////////////////in order and out of order phases

class digi_base_test extends uvm_test;
  
  virtual digi_if vif;
 // virtual digi_if vif_test;
  bit is_active;
  //int is_agnt_active;
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
//       if(!uvm_config_db #(int)::get(this,"","is_agnt_active",is_agnt_active))
//       `uvm_fatal ("build_phase", "Did not get a configuration object for test")
         
     ///////////////////no_of_agents
        if(!uvm_config_db #(int)::get(this,"","no_of_agents",no_of_agents))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
       
      ////////////////is_sco
          if(!uvm_config_db #(int)::get(this,"","is_sco",is_sco))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
                   
      //////////////////////////////set for env for is_active
    uvm_config_db#(virtual digi_if)::set(this,"env","vif",vif);
    uvm_config_db#(bit)::set(this,"env","is_active",is_active);
   // uvm_config_db#(int)::set(this,"env","is_agnt_active",is_agnt_active);
    uvm_config_db#(int)::set(this,"env","no_of_agents",no_of_agents);
    uvm_config_db#(int)::set(this,"env","is_sco",is_sco);
    endfunction
 



  



  
  //     virtual function void start_of_simulation_phase(uvm_phase phase);
//         `uvm_info(get_type_name(), "start_of_simulation_phase", UVM_LOW)
//       super.start_of_simulation_phase(phase);
//       uvm_top.print_topology();
//     endfunction
  

  virtual function void connect_phase(uvm_phase phase);
      `uvm_info(get_type_name(), "connect_phase", UVM_LOW)
    super.connect_phase(phase);
    env.vif = vif;
  endfunction
  
    virtual function void end_of_elaboration_phase(uvm_phase phase);
         `uvm_info(get_type_name(), "end_of_elaboration_phase", UVM_LOW)
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
    endfunction
  
          virtual task run_phase(uvm_phase phase);
     `uvm_info(get_type_name(), "run_phase", UVM_LOW)
    super.run_phase(phase);
  endtask
  
    
       virtual function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "report_phase", UVM_LOW)
    super.report_phase(phase); 
  endfunction

endclass
//////////////////////////////////////////////////////////////put get
`include "uvm_macros.svh"
`include "uvm_pkg.sv"

class producer extends uvm_component;
  `uvm_component_utils(producer)

  uvm_blocking_put_port #(int) put_port;
  int data;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    put_port = new("put_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    for (int i = 0; i < 10; i++) begin
      data = i;
      `uvm_info("PRODUCER", $sformatf("Producing data: %0d", data), UVM_MEDIUM)
      put_port.put(data);
    end
    phase.drop_objection(this);
  endtask
endclass

class consumer extends uvm_component;
  `uvm_component_utils(consumer)

  uvm_blocking_get_port #(int) get_port;
  int data;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction


  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    forever begin
      get_port.get(data);
      `uvm_info("CONSUMER", $sformatf("Consuming data: %0d", data), UVM_MEDIUM)
    end
    phase.drop_objection(this);
  endtask
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    get_port = new("get_port", this);
  endfunction
endclass

class env extends uvm_env;
  `uvm_component_utils(env)

  producer prod;
  consumer cons;
  uvm_tlm_fifo #(int) fifo;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    prod = producer::type_id::create("prod", this);
    cons = consumer::type_id::create("cons", this);
    fifo = new("fifo", this, 8);
  endfunction

  function void connect_phase(uvm_phase phase);
    prod.put_port.connect(fifo.put_export);
    cons.get_port.connect(fifo.get_export);
  endfunction
endclass

class test extends uvm_test;
  `uvm_component_utils(test)

  env test_env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    test_env = env::type_id::create("test_env", this);
  endfunction
endclass

module top;
  initial begin
    
    run_test("test");
  end
endmodule



////////////////////////////////////////////////////////////run_phase

// Code your design here
import uvm_pkg::*;
`include "uvm_macros.svh"


class A extends uvm_component;
  `uvm_component_utils(A)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task pre_reset_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "pre_reset phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask


    task reset_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "reset phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask

    task post_reset_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "post_reset phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask

    task pre_configure_phase(uvm_phase phase);
      
    `uvm_info(get_type_name(), "pre_config phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask
endclass

class B extends uvm_component;
  `uvm_component_utils(B)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

    task config_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "config phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask

    task post_config_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "post_config phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask

    task pre_main_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "pre_main phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask

    task main_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "main phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask
endclass

class C extends uvm_component;

  `uvm_component_utils(C)

  
  function new(string name, uvm_component parent);
    super.new(name, parent);

  endfunction

    task post_main_phase(uvm_phase phase);
   
    `uvm_info(get_type_name(), "post_main phase", UVM_LOW)

  endtask

    task pre_shutdown_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "pre_shutdown phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask

    task shutdown_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "shutdown phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask

    task post_shutdown_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "post_shutdown phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask
endclass

class D extends uvm_component;

  `uvm_component_utils(D)

  function new(string name, uvm_component parent);
    super.new(name, parent);

  endfunction

    task run_phase(uvm_phase phase);
      `uvm_info(get_type_name(), "run phase", UVM_LOW)
    phase.raise_objection(this);
    #5;
    phase.drop_objection(this);
  endtask
endclass
    

class test extends uvm_test;
  A A_o;
  B B_o;
  C C_o;
  D D_o;

  `uvm_component_utils(test)

  function new(string name="test",uvm_component parent);
     super.new(name,parent);
   endfunction
  
    function void build_phase(uvm_phase phase);
       super.build_phase(phase);

    
      A_o = A::type_id::create("A_o", this);
      B_o = B::type_id::create("B_o", this);
      C_o = C::type_id::create("C_o", this);
      D_o = D::type_id::create("D_o", this);

 endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

endclass

module top;
  initial begin
    run_test("test");
  end
endmodule







///////////////////////////////////////////drain time
//All pending transactions are processed.

//Monitors and scoreboards capture the final outputs.

//The simulation ends cleanly without missing any critical events.
//
//
//
`include "uvm_macros.svh"
`include "uvm_pkg.sv"


class test extends uvm_test;
  `uvm_component_utils(test)



  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  
  task run_phase(uvm_phase phase);
    time drain_time;
    phase.raise_objection(this);
        
    phase.phase_done.set_drain_time(this, 100ns);
 


       
    drain_time = phase.phase_done.get_drain_time(this);//get the drain time value @zero simulation time
       `uvm_info("MY_TEST", $sformatf("Current drain time: %0t", drain_time), UVM_LOW)
 
    `uvm_info("MY_TEST", "Starting tasks...", UVM_LOW)
    #200ns; 

    `uvm_info("MY_TEST", "Completing tasks...", UVM_LOW)
    phase.drop_objection(this);
  endtask
  
endclass

module top;
  initial begin
    
    run_test("test");
  end
endmodule

