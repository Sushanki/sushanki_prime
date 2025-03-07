///////////////////////////////////////////////////////deep copy with different function
class abc;
  int a;
  int b;

  function void name();
    a = 20;
    b = 9;
    $display("a %d b %d", a, b);
  endfunction
endclass

class abcd;
  int c;
  int d;

  function integer name1();
    c = 20;
    d = 9;
    $display("c %d d %d", c, d);
  endfunction
endclass

class abcde;
  int e;

  function new();
    e = 1;
    $display("e %d", e);
  endfunction
endclass

class abcdef;
  int f;

  function void copy(abc m);
    f = 7;
    m.name();
    $display("f %d", f);
  endfunction
endclass


module top;
  abc m;
  abcd n;
  abcde o;
  abcdef p;

  initial begin
    m = new();
    p = new();

    p.copy(m);

  end
endmodule

