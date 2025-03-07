class car;
	int a;
	int b;
virtual function void print(string name);
$display("a %b ,b %b",a,b);
endclass

class car1 extends car;
	int c;

	function void print(string name);
		super.print(name);
		$display("c %b",c);
	endfunction

endclass

module top;
car c;
car c1;
initial begin
	c=new();
	c1=new();
	c.print("c");
	c1.print("c1");
end
endclass



/////////////////////////////////////////////////////
class car;
  int a;
  int b;
  
  virtual function void print(string name);
    this.a=1;this.b=2;
    $display("%s: a = %0d, b = %0d", name, a, b);
  endfunction
endclass

class car1 extends car;
  int c;

  function void print(string name);
    super.print(name);
    c=22;
    $display("%s: c = %0d", name, c);
  endfunction
endclass

module top;
  car c1;
  car1 c2;
   
  initial begin
    c2 = new();
    c2.c=1;
    c1=c2;
    c1.print("c1");
    end
endmodule






//////////////////////////////////////casting
class car;
  bit[31:0] a;
  bit [31:0] b;
  
  virtual function void print(string name);
    this.a = 1;
    this.b = 2;
    $display("%s: a = %0d, b = %0d", name, a, b);
  endfunction
endclass

class car1 extends car;
  int c;

  function void print(string name);
    super.print(name);
    c = 22;
    $display("%s: c = %0d", name, c);
  endfunction
  
endclass

module top;
  car c1;
  car1 c2;
   
  initial begin
    c2 = new();
    c1=new();
    //c2.c = 1;
    if ($cast(c1,c2 )) // c1=c2;
      begin
      $display("value used ");
    end else begin
      $display("A: Dynamic casting failed");
    end
    //c1 = c2;
    c1.print("c1");
  end
endmodule

