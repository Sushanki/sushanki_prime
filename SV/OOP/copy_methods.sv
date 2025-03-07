/////////////////////////////shallow copy and deep copy
class pkt;
rand bit [3:0]a;
rand bit [3:0] b;
  function void print(string name);
    $display("name=%s",name);
    $display("a=%d",a);

    $display("b=%d",b);
endfunction
endclass
         
module top;
pkt p1;
pkt p2;
initial begin 
  p1=new;
  p1.a=2;p1.b=9;
  p1.print("p1 print method");
  p2=p1;
  p2.print("p2 print method");
  p1.a=3;
  p1.print("p1 print method");
  p2.a=5;
  p2.print("p2 print method");
end 
endmodule

////////////////////////////////shallow copy
//
class pkt;
rand bit [3:0]a;
rand bit [3:0] b;
  function void print(string name);
    $display("name=%s",name);
    $display("a=%d",a);

    $display("b=%d",b);
endfunction
endclass
         
module top;
pkt p1;
pkt p2;
initial begin 
  p1=new;
  p1.a=2;p1.b=9;
  p1.print("p1 print method");
  p2=new p1;
  p2.print("p2 print method");
  p1.a=3;
  p1.print("p1 print method");
   p2.print("p2 print method");
  p2.a=5;
   p1.print("p1 print method");
  p2.print("p2 print method");
end 
endmodule

///////////////////////////////////////////////shallow copy with two class
class pkt;
 bit [3:0]a;
  bit [3:0] b;
endclass

class mypkt;
 bit [3:0]c;
 bit [3:0]d;
  
  pkt p;
  
  function new();
    p=new();
  endfunction
  
  function void print(string name);
    $display("name=%s",name);
    //c=3;
    $display("c=%d",c);
    d=5;
    $display("d=%d",d);
    p.a=2;
    $display("a=%d",p.a);
    p.b=9;
    $display("b=%d",p.b);
endfunction
endclass

         
module top;
mypkt p1,p2;
initial begin 
  p1=new;
  p1.print("p1 print method");
  p2=new p1;
  p2.print("p2 print method");
  p2.c=8;
  p2.print("p2 print method");
  p1.print("p1 print method");

end 
endmodule


//////////////////////////////////////////////////////////////////deep copy
class pkt;
  bit [3:0] a;
  bit [3:0] b;
endclass

class mypkt;
  bit [3:0] c;
  bit [3:0] d;
  
  pkt p;
  
  function new();
    p = new();
  endfunction
  
  function void print(string name);
    $display("name=%s", name);
    $display("c=%d", c);
    $display("d=%d", d);
    $display("a=%d", p.a);
    $display("b=%d", p.b);
  endfunction
  
  function void copy(output pkt p2);
    p2 = new();
    p2.a = p.a;
    p2.b = p.b;
  endfunction
endclass

module top;
  mypkt p1;
  pkt p2;

  initial begin 
    p1 = new();
    p1.print("p1 print method");
    p1.copy(p2);
    p1.print("After copy to p2");

   
    $display("p2 values after copy:");
    $display("a=%d, b=%d", p2.a, p2.b);

   
    p2.a = 7;
    p2.b = 11;
    $display("p2 modified values:");
    $display("a=%d, b=%d", p2.a, p2.b);

   
    p1.print("p1 values after modifying p2");
  end 
endmodule


/////////////////////////////////////////////////////////////4 level
class pkt;
  bit [3:0] a;
  bit [3:0] b;
endclass

class pkt1;
  bit [2:0] c;
  bit [2:0] d;
  pkt p;
  function new();
    p = new();
  endfunction
 
endclass

class pkt2;
  bit [2:0] e;
  bit [2:0] f;
  pkt1 p1;

  function new();
    p1 = new();
  endfunction


endclass

class mypkt;
  bit [3:0] g;
  bit [3:0] h;
  
  pkt2 p2;
  function new();
    p2 = new();
  endfunction
  
  function void print(string name);
    $display("name=%s", name);
    $display("c=%d", g);
    $display("d=%d", h);
    $display("a=%d", p.a);
    $display("b=%d", p.b);
    $display("a=%d", p1.c);
    $display("b=%d", p1.d);
    $display("a=%d", p2.e);
    $display("b=%d", p2.f);
  endfunction
  
  function void copy(output pkt2 pp);
    pp = new();
    pp.a = p.a;
    pp.b = p.b;
    pp.c = p1.b;
    pp.d = p1.b;
    pp.e = p2.b;
    pp.f = p2.b;
  endfunction
endclass

module top;
  mypkt ptt;
  pkt2 pp;

  initial begin 
    ptt = new();
    ptt.print("p1 print method");
    pp.copy(ptt);
    ptt.print("After copy to p2"); 
    ptt.a = 7;
    ptt.b = 11;
    $display("ptt modified values:");
    $display("a=%d, b=%d", ptt.a, ptt.b);

   
    ptt.print("pp values after modifying ptt");
  end 
endmodule
