module test();
  process pr, pc,ps;

  initial begin : main
    fork : fork_main
      begin : Process1
        pr = process::self(); 
        $display("%0t Status of pr is %0s", $time, pr.status.name());
        #2  $display("%0t Process 1-a finished", $time);
        #10 $display("%0t Process 1-b finished", $time);
      end
      
      begin : Process2 
        pc = process::self(); 
        $display("%0t Status of pc is %0s", $time, pc.status.name());
        #20 $display("%0t Process 2 finished", $time);
      end
      
       begin : Process3 
        ps= process::self(); 
         $display("%0t Status of ps is %0s", $time, ps.status.name());
         #30 $display("%0t Process 3 finished", $time);
      end
    join_none

    #1;
    $display("%0t Status of pr is %0s", $time, pr.status.name());
    $display("%0t Status of pc is %0s", $time, pc.status.name());
    $display("%0t Status of ps is %0s", $time, ps.status.name());

      
    #1;

   
    pr.suspend();
    $display("\n%0t Suspended the process pr:", $time);
    $display("%0t Status of pr is %0s", $time, pr.status.name());
    $display("%0t Status of pc is %0s", $time, pc.status.name());
   

    
    #30;
    pr.resume();
    $display("\n%0t Resumed the process pr:", $time);
    $display("%0t Status of pr is %0s", $time, pr.status.name());
    $display("%0t Status of pc is %0s", $time, pc.status.name());


    
    #30;
    ps.kill();
    $display("\n%0t kill process ps:", $time);
    $display("%0t Status of ps is %0s", $time, ps.status.name());


    #30;
    $display("%0t Status of pr is %0s", $time, pr.status.name());
    $display("%0t Status of pc is %0s", $time, pc.status.name());
 
  end
endmodule

