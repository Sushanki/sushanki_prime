////////////////////////////////timeout
module test;

  task infinite_task();
    forever begin : infinite_loop
      $display("Infinite task running at time %0t", $time);
      #10;
    end
  endtask

  task timeout();
    fork :main_fork
      begin :thread1
        infinite_task();
      end

      begin :thread2
        #50;
        $display("Timeout occurred at time %0t", $time);
        disable thread1;
      end
    join
  endtask

  initial begin :main_block
    timeout();
  end

endmodule

