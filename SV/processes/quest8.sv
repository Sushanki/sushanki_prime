class name;

  int i;

  function new();
    i = 0;
  endfunction

  task run_threads();
    fork :main_fork
      for (i = 0; i < 5; i = i + 1) begin :thread_block
        fork :nested_fork
          begin :inner_block_start
            $display("Thread %0d started at time %0t", i, $time);
          end
          begin :inner_block_end
            #10;
            $display("Thread %0d finished at time %0t", i, $time);
          end
          fork :inside_fork
            begin :inner_block_fork
              #5;
              $display("Thread %0d inside fork at time %0t", i, $time);
            end
          join_any
          disable inside_fork; 
        join_any
        disable nested_fork;
      end
      
      begin :thread1
        #15;
        $display("Additional Thread 1 executed at time %0t", $time);
      end
      begin :thread2
        #25;
        $display("Additional Thread 2 executed at time %0t", $time);
      end
    join
    $display("All threads have finished execution at time %0t.", $time);
  endtask

endclass

module test;

  name tc = new();

  initial begin :main_block
    tc.threads();
  end

endmodule

