/////////////////////////////////////////////////////////////////////////sequence_item
class digi_seq_item extends uvm_sequence_item;

`uvm_object_utils_begin(digi_seq_item);
`uvm_field_int(a,UVM_ALL_ON);
`uvm_object_utils_end

function new(string name="digi_seq_item");
super.new(name);
endfunction


endclass


