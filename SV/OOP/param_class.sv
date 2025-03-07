//////////////////////////class the prameterized
class name;
	int m;
	//int n;
endclass

class test #(type T = name, parameter size = 3);
  bit [size:0] a;
  T b;
  
 
  function T add_b(T c);
    return b + c;
  endfunction
  
  function bit [size:0] name();
    return a;
  endfunction
endclass


module tb;
  test #(int, 3) st;

  initial begin

    st = new();


    st.b = -456;
    st.a = 4; 
    
    
    $display("st.item = %0d", st.add_b(10));
    $display("st.name = %0d", st.name());
  end
endmodule

