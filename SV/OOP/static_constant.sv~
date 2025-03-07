/////////////////////////////////static and constant function
class first;
  static bit [3:0] a;
    function new();
      a=$random;
    endfunction 
endclass
  

class second;   /////////////////it will through the error <Right 'const' variable is either driven or connected to a non-const variable.
 // Variable 'a' declared as 'const' cannot be used in this context
const int a=45;
    function new();
      a=50;
    endfunction
endclass

module test();
 
  first f;
  second s;

  initial
    begin
      f=new();
      s=new();
      
      $display("f.a : %0d",f.a);
      $display("s.a : %0d",s.a);
      //f.a=1;
      //s.a=33;
      //$display("f.a : %0d",f.a);
      //$display("s.a : %0d",s.a);
    end
endmodule
