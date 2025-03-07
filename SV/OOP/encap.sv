/////////////Encapsulation (properties,methods and constraint putting into signle enity)
class name;

	bit [3:0] a;
	bit [3:0] b

	function void print();
		$display("a=%d",a);
		$display("b=%d",b);
	endfunction 

endclass

module top;

name n;

initial begin 
	n=new();
        n.print();
end

endmodule



//////////////////////////////////with value
class name;

	bit [3:0] a;
	bit [3:0] b;

	function void print();
		$display("a=%d",a);
		$display("b=%d",b);
	endfunction 
endclass

module top;

name n;

initial begin 
      n=new();
      n.a=5;
      n.b=6;
      n.print();
end

endmodule


/////////////////////////////////////////////////////////local and protected
class name;
  bit [31:0] data;
  local int id;
  protected int a;

  function void display();
    $display("data = %0d and id = %0d", data, id);
  endfunction
  
 local function void dis();
    $display("data = %0d and id = %0d", data, id);
  endfunction
  
  
  protected function void print();
    $display("data = %0d and id = %0d", data, id);
  endfunction
endclass

class name1;
  name n;
  
  function new();
    n=new();
  
  endfunction
  
  function print();
    n.display();
    //n.dis();//////////////
    //n.print();///////////local and protected give error
  endfunction
endclass

module top;
  name1 n1;
  
  initial begin
    n1 = new();
    n1.print();
    
  end
endmodule


//////////////////////////////////////////////////////////////////////////
class name;
  bit [31:0] data;
  local int id;
  protected int a;

  function new();
    data = 32;
    id = 1;
    a = 2;
  endfunction

  /*function void display();
    $display("data = %0d and id = %0d", data, id);
  endfunction*/
  
  local function void dis();
    $display("data = %0d and id = %0d", data, id);
  endfunction
  
  protected function void print();
    $display("data = %0d and id = %0d", data, id);
  endfunction
endclass

class name1 extends name;

  function new();
    super.new(); 
  endfunction

  function void print();
    //super.display();  
    //super.dis();     
    super.print();    
  endfunction
endclass

module top;
  name1 n1;
  
  initial begin
    n1 = new();
    n1.print();
  end
endmodule


///////////////////////////////////////////////////error if we call local and
	//proteced function
class name;
  bit [31:0] data;
  local int id;
  protected int a;

  function void display();
    $display("data = %0d and id = %0d", data, id);
  endfunction
  
 local function void dis();
    $display("data = %0d and id = %0d", data, id);
  endfunction
  
 extern protected function void print(); 
 
endclass

 protected function void name::print();
    $display("data = %0d and id = %0d", data, id);
  endfunction

class name1;
  name n;
  
  function new();
    n=new();
    
  endfunction
  
  function print();
    n.display();
    //n.dis();
    //n.print();
  endfunction
endclass

module top;
  name1 n1;
  
  initial begin
    n1 = new();
    n1.print();
    
  end
endmodule


///////////////////////////////////////////////////////use of local and protected function
class name;
  bit [31:0] data;
  local int id;
  protected int a;

  
 extern   function void display();
 extern local function void dis();
 extern protected function void print(); 
 
endclass
   
   
  function void name::display();
    $display("data = %0d and id = %0d", data, id);
  endfunction
    
  function void name::dis();
    $display("data = %0d and id = %0d", data, id);
  endfunction

 function void name::print();
    $display("data = %0d and id = %0d", data, id);
  endfunction
 

class name1;
  name n;
  
  function new();
    n=new();
    
  endfunction
  
  function print();
    n.display();
    //n.dis();
    //n.print();
  endfunction
endclass
   
module top;
  name1 n1;
  
  initial begin
    n1 = new();
    n1.print();
    
  end
endmodule

