
/////////////////////////////////////////////////////////////////////////top
import uvm_pkg::*;
`include "uvm_macros.svh"
 `include "digi_base_seq_item.sv"

module top;

  digi_my_sequence_item        seq_item1,seq_item2;
  int compare_result;
  bit                a [];
  string seq_item1_str;
  
  initial begin
    
    /////////////////////////////create
    seq_item1=digi_my_sequence_item::type_id::create("seq_item1");
    seq_item2=digi_my_sequence_item::type_id::create("seq_item2");
    
    //////////////////////////////////randomization
    seq_item1.randomize();
    
    ////////////////////////////////////print
    seq_item1.print();
    seq_item2.randomize();
    
    ///////////////////////////////////copy
    seq_item2.copy(seq_item1);
    seq_item2.print();
//     compare_result=seq_item2.compare(seq_item1);
//     $display("compare_result=%d",compare_result);
    
    ////////////////////////////////////compare
     if(seq_item2.compare(seq_item1)) begin
       $display( "Comparison matched");
    end
    else begin
      $display( "Comparison not matched");
    end
  end  

  initial begin

//     a =new[10];

    ////////////////////////////////////////pack
    seq_item1.pack(a);
    foreach(a[i]) begin
      $display("a[%0d]: %0d", i, a[i]);
    end
    
    ///////////////////////////////////////unpack
    seq_item2.unpack(a);
    foreach(a[i]) begin
      $display("a[%0d]: %0d", i, a[i]);
    end
 
    seq_item1_str = seq_item1.convert2string();
    $display("String representation: %s", seq_item1_str);
  end

  
  initial begin 
  
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #100 $finish();
  end

endmodule


/////////////////////////////////////////////////////////////////////////////////////seq_item

///////////////////////////base class sequence item
class digi_base_seq_item extends uvm_sequence_item;

function new(string name="digi_base_seq_item");
super.new(name);
endfunction

endclass

typedef enum {RED, GREEN, BLUE} color_t;
// Sub sequence item with five different type variables
class my_sub_sequence_item extends uvm_object;
  rand bit        sub_var1;
  rand int        sub_var2;
  real       sub_var4;
  string     sub_var45;
  rand color_t    sub_var5;
  
  `uvm_object_utils_begin(my_sub_sequence_item)
    `uvm_field_int(sub_var1,UVM_ALL_ON)
    `uvm_field_int(sub_var2,UVM_ALL_ON)
    `uvm_field_real(sub_var4,UVM_ALL_ON)
  `uvm_field_string(sub_var45,UVM_ALL_ON) 
    `uvm_field_enum(color_t,sub_var5,UVM_ALL_ON)
  `uvm_object_utils_end 
  
  function new(string name="my_sub_sequence_item");
    super.new(name);
  endfunction

endclass

/////////////////////////////////////////extends seq_item class

class digi_my_sequence_item extends digi_base_seq_item;
 
  rand bit                      var1;
  rand bit [3:0]                var2;
  rand bit [31:0]               var3;
  rand int                      var4;
  rand bit [5:0]                a [10];
  rand byte                     var5;
  string                        var6;
  real                          var7;
  rand color_t                  var8;    
  rand int                      que[$];
  rand int                      aa[int];
  rand my_sub_sequence_item          var9;
 
  `uvm_object_utils_begin(digi_my_sequence_item)
    `uvm_field_int(var1,UVM_ALL_ON)
    `uvm_field_int(var2,UVM_ALL_ON)
    `uvm_field_int(var3,UVM_ALL_ON)
    `uvm_field_int(var4,UVM_ALL_ON)
    `uvm_field_sarray_int(a,UVM_ALL_ON)
    `uvm_field_int(var5,UVM_ALL_ON)
    `uvm_field_string(var6,UVM_ALL_ON)
    `uvm_field_real(var7,UVM_ALL_ON)
    `uvm_field_enum(color_t,var8,UVM_ALL_ON)
    `uvm_field_queue_int(que,UVM_ALL_ON)
    `uvm_field_aa_int_int(aa,UVM_ALL_ON)
    `uvm_field_object(var9,UVM_ALL_ON)
  `uvm_object_utils_end 
  
function new(string name="digi_my_sequence_item");
super.new(name);
  var9=new();
endfunction
  


//   constraint default_constraint {
//     var1 inside {0, 1};
//     var2 inside {[0:15]};
//     var3 inside {[0:2**32-1]};
//     var4 inside {[-2147483648:2147483647]};
//     foreach (a[i]) a[i] inside {[0:63]};
//     var5 inside {[0:255]};
//     var6.len() >= 1;
//     var8 inside {RED, GREEN, BLUE};
//   }
endclass




