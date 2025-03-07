import uvm_pkg::*;
`include "uvm_macros.svh"
`include "digi_if.sv"
`include "digi_base_pkg.sv"//file

module top;

 import digi_base_pkg::*;//class
  digi_if vif();


  initial 
    begin
    uvm_config_db#(virtual digi_if)::set(null,"uvm_test_top","vif_test_h",vif);
    uvm_config_db#(bit)::set(null,"uvm_test_top","is_active",1);
      uvm_config_db#(int)::set(null,"uvm_test_top","is_agnt_active",21);
      uvm_config_db#(int)::set(null,"uvm_test_top","no_of_agents",21);
      uvm_config_db#(int)::set(null,"uvm_test_top","is_sco",21);///////////////////////////no of agents and no of scoreboard independent of each other
  end
  
  initial begin 
    run_test("digi_base_test");
  end
  
  initial begin 
  
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #100 $finish();
  end
