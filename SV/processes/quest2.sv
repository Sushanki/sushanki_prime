////////////////////always_ff

module counter(
  input logic clk,
  input logic rst_n,
  output logic [3:0] count
);

  always_ff @(posedge clk or negedge rst_n) begin :always_ff_l
    if (!rst_n) begin
      count <= 4'b0000;
    end else begin
      count <= count + 1;
    end
  end

endmodule

////////////////////////////////always_comb

module mux_2to1(
  input logic       sel,
  input logic [3:0] in0,
  input logic [3:0] in1,
  output logic [3:0] out
);

  always_comb begin :always_comb_l
    if (sel) begin
      out = in1;
    end else begin
      out = in0;
    end
  end

endmodule

///////////////////////////////////////////always_latch

module latch(
  input logic      enable,
  input logic [3:0] data_in,
  output logic [3:0] data_out
);

  always_latch begin :alawys_latch_l
    if (enable) begin
      data_out = data_in;
    end
  end

endmodule


/////////////////////////////////////////////always
module d_flip_flop (
  input logic clk,
  input logic rst,
  input logic d,
  output logic q
);

  always @(posedge clk or posedge rst) begin :always_l
    if (rst) begin
      q <= 0;
    end else begin
      q <= d;
    end
  end

endmodule

