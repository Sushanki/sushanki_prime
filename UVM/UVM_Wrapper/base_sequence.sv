////////////////////////////////////////////////sequence
class digi_base_seq#(type SEQ_ITEM=digi_seq_item) extends uvm_sequence(SEQ_ITEM);

`uvm_object_utils(digi_base_seq)

function new(string name="digi_base_seq");
	super.new(name);
endfunction

task body;
digi_seq_item se;
`uvm_do();

endtask

endclass

