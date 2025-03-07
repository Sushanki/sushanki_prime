// Code your design here
module d_FF(input clk,input rst,input d_in,output reg q_out);
  
  always@(posedge clk or negedge rst)
    begin 
      if(rst)
        q_out<=0;
      else
        q_out<=d_in;
     end
  
endmodule

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "d_ff_if.sv"
`include "d_ff_pkg.sv"

module top;
import d_ff_pkg::*;//class
 
bit clk=0;
bit rst;
  
d_ff_if vif(clk,rst);

always #5 clk=~clk;

  d_FF dut(.clk(vif.clk),.rst(vif.rst),.d_in(vif.d_in),.q_out(vif.q_out));
  
  initial begin
    
    rst=1;
     #5;
     rst=0;
  
    $display("d_in=%d,q_out=%d",vif.d_in,vif.q_out);
  end
initial begin
       
  uvm_config_db#(virtual d_ff_if)::set(null, "uvm_test_top.env.agt.drv","vif",vif);
  
  run_test("d_ff_test");
    #100 $finish;  
  end
  
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
endmodule



class d_ff_seq_item extends uvm_sequence_item;
  
  rand logic d_in;
  logic q_out;

  
  `uvm_object_utils_begin(d_ff_seq_item)

  `uvm_field_int(d_in,UVM_DEFAULT);
  `uvm_field_int(q_out,UVM_DEFAULT);
  `uvm_object_utils_end
  
  function new(string name="d_ff_seq_item");
    super.new(name);
  endfunction
  
endclass



interface d_ff_if(input logic clk,rst);
  logic d_in;
  logic q_out;
endinterface


//`uvm_declare_p_sequencer(d_ff_seqr)
typedef enum {HIGH_PRIORITY = 500, MED_PRIORITY = 200, LOW_PRIORITY = 50} seq_priority;
class d_ff_seq#(type SEQ_ITEM=d_ff_seq_item) extends uvm_sequence#(SEQ_ITEM);
  
  `uvm_object_param_utils(d_ff_seq)
  SEQ_ITEM se;
  
  //seq_priority se_pri;  
  function new(string name="d_ff_seq");
    super.new(name);
  endfunction
  
  
  task body;

    //repeat(5)begin
    //////////////////////method one
  // `uvm_do(se);
   //it will create and randomize constraint
  // `uvm_do_with(se, {d_in==1;}); 
    
    ////////////////////create//rand//send
    
//     `uvm_create(se);
//     assert(se.randomize());
//     `uvm_send(se);
    
    /////////////////////creat rand send together
//     `uvm_create(se);
//     `uvm_rand_send(se);
    
        /////////////////////creat rand send together
     `uvm_create(se);
     `uvm_rand_send_with(se, {d_in==1;}); 
    //////////////////////start&finish
//     se= SEQ_ITEM::type_id::create("se");
//     start_item(se);
//     assert(se.randomize());
//     finish_item(se);
    
////////////////////////////////used when virual seq or seqr
//     se_pri=HIGH_PRIORITY;
//     `uvm_do_pri(se,se_pri);
//     se_pri=MED_PRIORITY;
//     `uvm_do_with_pri(se,se_pri,{d_in==1;d_in==0;});
    
//     //////////////////////sepecific seqr
 //   `uvm_do_on(se,seqr);//it will create and randomize;
//     `uvm_do_on_with(se,seqr,{d_in==1;d_in==0;});
//       se_pri=LOW_PRIORITY;
//     `uvm_do_on_pri(se,seqr,se_pri);
//      se_pri=MED_PRIORITY;
//     `uvm_do_on_pri_with(se,seqr,se_pri,{d_in==1;d_in==0;});
   // `uvm_info ("BASE_SEQ", $sformatf ("Sequence %s is over", this.get_name()), UVM_MEDIUM)
   // end
  endtask
 
  
endclass



class d_ff_seqr#(type VIF=virtual d_ff_if,
                 type SEQ_ITEM=d_ff_seq_item) extends uvm_sequencer#(SEQ_ITEM);

`uvm_component_param_utils(d_ff_seqr)

  function new(string name="d_ff_seqr" ,uvm_component parent=null);
	super.new(name,parent);
endfunction

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  
endclass


class d_ff_drv#(type VIF=virtual d_ff_if, 
                     type SEQ_ITEM=d_ff_seq_item 
                    ) extends uvm_driver#(SEQ_ITEM);
   

  `uvm_component_param_utils(d_ff_drv)
  VIF vif;
  SEQ_ITEM se;
  function new(string name="d_ff_drv", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    se = SEQ_ITEM::type_id::create("se");
          //////////////////interface
    if(!uvm_config_db #(virtual d_ff_if)::get(this,"","vif",vif))
      `uvm_fatal ("build_phase", "Did not get a configuration object for test")
      
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
   forever begin
  
    seq_item_port.get_next_item(se);
     @(posedge vif.clk)
      vif.d_in <= se.d_in;
      se.q_out <= vif.q_out;
     $display("vif.q_out=%0d",vif.q_out);
     
      seq_item_port.item_done();
      #10;
      `uvm_info("DRV",$sformatf("d_in = %0d , q_out = %0d , @%0t",se.d_in,se.q_out,$time),UVM_NONE);
    end

  endtask


endclass



class d_ff_agent#(
  type VIF=virtual d_ff_if,
  type SEQ_ITEM=d_ff_seq_item,
  type SEQR=d_ff_seqr#(VIF, SEQ_ITEM),
  type DRV=d_ff_drv#(VIF, SEQ_ITEM)
) extends uvm_agent;

  `uvm_component_param_utils(d_ff_agent)
  VIF vif;
  SEQR sqr;    // Sequencer Handle
  DRV drv;     // Driver handle

  
  function new(string name="d_ff_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
      sqr = SEQR::type_id::create("sqr", this);
      drv = DRV::type_id::create("drv", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
      drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction

endclass


class d_ff_env extends uvm_env;

  `uvm_component_utils(d_ff_env)

  typedef d_ff_agent#(virtual d_ff_if,d_ff_seq_item,d_ff_seqr#(virtual d_ff_if, d_ff_seq_item),d_ff_drv#(virtual d_ff_if, d_ff_seq_item)) AGT_t;
  AGT_t agt;
  
  function new(string name="d_ff_env", uvm_component parent=null);
    super.new(name, parent);
 
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
     agt = AGT_t::type_id::create("agt", this); 
    
  endfunction

endclass



class d_ff_test extends uvm_test;
  
  `uvm_component_utils(d_ff_test)
  
  typedef d_ff_seq#(d_ff_seq_item) seq_t;
  seq_t seq;
  d_ff_env env;
  
  function new(string name="d_if_test" ,uvm_component parent);
	super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   seq=seq_t::type_id::create("seq");
    env = d_ff_env::type_id::create("env", this);
    endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
    endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    repeat(10)begin
     seq=seq_t::type_id::create("seq");
    seq.start(env.agt.sqr);
    #10;
    end
    phase.drop_objection(this);
  endtask

   virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase); 
  endfunction 

endclass

package d_ff_pkg;

`include "d_ff_seq_item.sv"
`include "d_ff_seq.sv"
`include "d_ff_seqr.sv"
`include "d_ff_drv.sv"
`include "d_ff_agent.sv"
`include "d_ff_env.sv"
`include "d_ff_test.sv"

endpackage

