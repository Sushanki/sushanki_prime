class name;

  int i;

  function new();
    i = 0;
  endfunction

  task threads();
    fork : main_fork
      for (i = 0; i < 5; i = i + 1) begin : thread_block
        fork : nested_fork
          begin : inner_block_start
            $display("Thread %0d started at time %0t", i, $time);
          end
          begin : inner_block_end
            #20;
            $display("Thread %0d finished at time %0t", i, $time);
          end
        join_any
      end
      
      begin : thread1
        #15;
        $display("Thread 1 executed at time %0t", $time);
      end
      begin : thread2
        #5;
        $display("Thread 2 executed at time %0t", $time);
      end
    join
    $display("All threads have finished execution at time %0t.", $time);
  endtask

endclass

module test;

  name tc = new();

  initial begin : main_block
    tc.threads();
  end

endmodule


