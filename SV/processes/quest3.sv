///////////////////////////////////////////////////
module tb;

  event e;

  initial begin
    ->e;
    $display ("[%0t] Thread1: triggered ", $time);
  end

  initial begin
    $display ("[%0t] Thread2: waiting for trigger ", $time);
   #5 @(e);
    $display ("[%0t] Thread2: receive ", $time);
  end

  initial begin
    $display ("[%0t] Thread3: waiting for trigger ", $time);
    wait(e.triggered);
    $display ("[%0t] Thread3: received ", $time);
  end
endmodule


////////////////////////////////////////event
//
module event_example(
  input logic clk,
  input logic rst,
  output logic [3:0] counter,
  event e1, e2, e3
);

initial begin : trigger_events
    #10 -> e1; 
    #20 -> e2;
    #30 -> e3;
end

always @(posedge clk) begin : wait_block
    if (rst) begin
      counter <= 4'b0000;
    end else begin
      counter <= counter + 1;
      if (counter == 4'b1010) begin 
        wait (clk === 1);
        $display("Time: %0t | Wait completed at counter = %0d", $time, counter);
      end
    end
end

always @(posedge clk) begin : wait_order_block
    if (rst) begin
      counter <= 4'b0000;
    end else begin
      counter <= counter + 1;
      if (counter == 4'b1011) begin 
        wait_order(e1, e2, e3) begin
          $display("Time: %0t | Event e1, e2, e3 occurred in order", $time);
        end
      end
    end
 end

endmodule


