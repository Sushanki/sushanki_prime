///////////////////////////////////////intra assignment delay
module test;
  int a;
  int b;
  int c;
  int d;
  int e;
  int f;
  reg clk=0;
    always #5clk=~clk;
  initial 
    begin
  b=3;
  a=#5 b;
    $display("t %t a %0d b %0d",$time,a,b);
   d=5;
    c=@(posedge clk) d;
    $display("t %t c %0d d %0d",$time,c,d);
   f=10;
    e=repeat(3) @(posedge clk) f;
    $display("t %t e %0d f %0d",$time,e,f);
  end  
 
endmodule


/////////////////////////////////////////inter assignment delay

module test;
  int a;
  int b;
  int c;
  int d;
  int e;
  int f;
  reg clk=0;
    always #5clk=~clk;
  initial 
    begin :thread1
      b=3;
      #5 a=b;
      $display("t %0t a %0d b %0d",$time,a,b);
      begin:thread2
      d=5;
      @(posedge clk) c=d;
      $display("t %0t c %0d d %0d",$time,c,d);
      end
      begin :thread3
      f=10;
      repeat(3) @(posedge clk) e=f;
      $display("t %0t e %0d f %0d",$time,e,f);
      end
  end
  
  
endmodule
