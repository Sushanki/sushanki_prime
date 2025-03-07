//////////////////////////////////passing argument with function 
class sus;
  bit [31:0] in1;
  int in2;
  
  function new (bit [31:0] in3);
    $display("function");
    in1 = in3;
  endfunction
endclass

module top;
  initial begin
    sus s = new(10);
    $display("Value of data = %0h", s.in1);
  end
endmodule


////////////////////////////////////without argument
class sus;
  bit [31:0] in1;
 
  function new ();
    $display("function");
    in1=5;
  endfunction
endclass

module top;
  initial begin
    sus s = new();
    $display("Value of data = %0d", s.in1);
  end
endmodule
