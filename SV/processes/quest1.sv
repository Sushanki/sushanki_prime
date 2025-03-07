module test;

  reg clk;
  reg rst;
  reg [3:0] a;
  reg [3:0] b;
 

module testbench;
  bit clk, rst;
  bit [3:0] a, b;

  initial begin : init_1
    clk = 0;
    forever #5 clk = ~clk; 
    rst = 0;
    #5 rst = 1;
    a = 0;
    #5 a = 4'b1010;
    b = 0;
    #5 b = 4'b1100;
  end

  initial begin : init_2
    bit [3:0] c;
    c = 4'b0011;
    #10;
    $display("Initial value of c = %0b", c);
    if (c == 4'b0011) begin
      $display("Condition met: c is 3");
    end else begin
      $display("Condition not met");
    end
  end

  initial begin : init_3
    #50;
    $finish;
  end

  initial begin : init_4
    $monitor("At time %0t: clk = %b, rst = %b, a = %0b, b = %0b", $time, clk, rst, a, b);
  end
endmodule



  // Always blocks with different sensitivity lists///Always Blocks with Non-Blocking Assignments NBA region
  always @(posedge clk) begin : always_posedge_clk
    if (!rst) begin
      a <= 0;
    end else begin
      a <= a + 1;
    end
  end

  always @(negedge clk) begin : always_negedge_clk
    if (!rst) begin
      b <= 0;
    end else begin
      b <= b + 1;
    end
  end

  always @(posedge rst or posedge clk) begin : always_posedge_rst_n_clk
    if (rst) begin
      a <= 4'b0001;
    end else begin
      a <= 0;
    end
  end

  always @(*) begin : always_c ////Always Blocks with Combinational Logic  reactive region
    if (a > b) begin
      $display("pass");
    end else begin
      $display("fail");
    end
  end

  always @(a or b) begin : always_signal_a_b
    if (a == b) begin
      $display("equal: %b",a);
    end
  end

  // Final blocks
  final begin : final_1 ///Postponed: Final blocks
  if (a == b) begin
      $display("equal: %b",a);
    end
    $display("Simulation finished.");
  end

  final begin : final_2
    $display("Final values - a: %b, b: %b", a, b);
  end
  initial #100 $finish;

endmodule

