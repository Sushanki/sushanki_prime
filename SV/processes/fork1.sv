module test_fork;
  int i;

  initial begin
   
    fork
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
          $display("Thread %0d started at time %0t", i, $time);
          #10;
          $display("Thread %0d finished at time %0t", i, $time);
        join
      end
    join

    $display("All threads have finished execution.");
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////
module top;
  
  int a;
  int b;
  int c;
  int d;
  int n;
  
  
  initial begin
    
    fork
     
      a=9;
      #5 $display("a %d [%0t]",a,$time);
     
      b=8;
      #5 $display("b %d [%0t]",b,$time);
    
      c=9;
       
      #5 $display("c %d [%0t]",c,$time);
      
      d=8;
      #3 $display("d %d [%0t]",d,$time);
      
    
 
     
      begin
         #5;
      c=9;
       
        $display("c %d",c,$time);
        #3;
      d=8;
        $display("d %d",d,$time);
      end
      
   join
      
      $display("outside the fork");
    
  end
  
  
endmodule


//////////////////////////////////////////////////////////////#3; #5; behave //like thread in given code they execute like a thread 
//**********************************************************************
module top;
  
  int a;
  int b;
  int c;
  int d;
  int n;
  
  
  initial begin
    
    fork
      #5;
      a=9;
      $display("a %d [%0t]",a,$time);
     
      b=8;
      #5 ;
      $display("b %d [%0t]",b,$time);
    
      c=9;
       
      #5 ;
      $display("c %d [%0t]",c,$time);
      
      d=8;
      #3 ;
      $display("d %d [%0t]",d,$time);
      
    
 
     
      begin
         #5;
      c=9;
       
        $display("c %d",c,$time);
        #3;
      d=8;
        $display("d %d",d,$time);
      end
      
   join
      
      $display("outside the fork");
    
  end
  
  
endmodule





// Code your testbench here
// or browse Examples
module top;
  
  int a;
  int b;
  int c;
  int d;
  int n;
  
  
  initial begin
    
    fork
      
      for (int i = 0; i < 5; i = i + 1) begin
        a[i]=i;
        $display("a %d",a,$time);
      
      end

     
      a=9;
      #5 $display("a %d [%0t]",a,$time);
     
      b=8;
      #5 $display("b %d [%0t]",b,$time);
    
      c=9;
       
      #5 $display("c %d [%0t]",c,$time);
      
      d=8;
      #3 $display("d %d [%0t]",d,$time);
      
    
 
     
      begin
         #5;
      c=9;
       
        $display("c %d",c,$time);
        #3;
      d=8;
        $display("d %d",d,$time);
      end
      
   join
      
      $display("outside the fork");
    
  end
  
  
endmodule

///////////////////////////////////////////////delay behave different inside
//fork thread
module test_fork;
  int i;

  initial begin
   
    fork
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
          $display("Thread %0d started at time %0t", i, $time);
          #10 $display("Thread %0d finished at time %0t", i, $time);
        join_any
      end
    join

    $display("All threads have finished execution.");
  end
endmodule

///////////////////////////////////
module test_fork;
  int i;

  initial begin
   
    fork
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
          $display("Thread %0d started at time %0t", i, $time);
          #10;
	  $display("Thread %0d finished at time %0t", i, $time);
        join_any
      end
    join

    $display("All threads have finished execution.");
  end
endmodule


/////////////////////////////////////fork join_any
module test_fork;
  int i;

  initial begin
   
    fork
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
          $display("Thread %0d started at time %0t", i, $time);
          begin
          #10 ; 
          $display("Thread %0d finished at time %0t", i, $time);
          end
        join_any
      end
    join

    $display("All threads have finished execution.");
  end
endmodule


/////////////////////////////////////fork join_none
module test_fork;
  int i;

  initial begin
   
    fork
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
          $display("Thread %0d started at time %0t", i, $time);
          begin
          #10 ; 
          $display("Thread %0d finished at time %0t", i, $time);
          end
        join_any
      end
    join

    $display("All threads have finished execution.");
  end
endmodule


/////////////////////////////////////////disable fork
module test_fork;
  int i;

  initial begin
   
    fork
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
          $display("Thread %0d started at time %0t", i, $time);
          begin
          #10 ; 
          $display("Thread %0d finished at time %0t", i, $time);
          end
        join_any
        disable fork;
      end
    join

    $display("All threads have finished execution.");
  end
endmodule

////////////////////////////////////////////wait fork
module test_fork;
  int i;

  initial begin
   
    fork
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
          $display("Thread %0d started at time %0t", i, $time);
          begin
          #10 ; 
          $display("Thread %0d finished at time %0t", i, $time);
          end
        join_any
        wait fork;
      end
    join

    $display("All threads have finished execution.");
  end
endmodule


/////////////////////////////////////////////////////////with for loop observation in case of for loop these three condition of fork join fork join_any fork join_none
//result is same
module test_fork;
  int i;

  initial begin
   
    
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
         
         // begin
             $display("Thread %0d started at time %0t", i, $time);
            
         //end
        join;
        
     
      end
    

    $display("All threads have finished execution.");
  end
endmodule

module test_fork;
  int i;

  initial begin
   
    
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
         
         // begin
             $display("Thread %0d started at time %0t", i, $time);
            
         //end
        join_any;
        
   
      end
    

    $display("All threads have finished execution.");
  end
endmodule
module test_fork;
  int i;

  initial begin
   
    
      for (i = 0; i < 5; i = i + 1) begin
      
        fork
         
         // begin
             $display("Thread %0d started at time %0t", i, $time);
            
         //end
        join_none;
        
       wait fork;
      end
    

    $display("All threads have finished execution.");
  end
endmodule

////////////////////////////////////////////////////////////////////////////////disable fork on particular thread
module test_fork;
  int i;

  initial begin : main_block
    fork : main_fork
      for (i = 0; i < 5; i = i + 1) begin : thread_block
        #5;
        fork : nested_fork
          begin : inner_block_start
            $display("Thread %0d started at time %0t", i, $time);
          end
          begin : inner_block_end
            #10;
            $display("Thread %0d finished at time %0t", i, $time);
          end
        join_any
        disable nested_fork;
      end
    join
    $display("All threads have finished execution at time %0t.", $time);
  end
endmodule











////////////////////////////////////////////quest ask
module top;

  int total_thread = 25;
  int out_thread = 20;

  initial begin
  
    fork
      for (int i = 0; i < total_thread; i++) begin
        if (i < out_thread) begin
          my_task(i);
        end
      end
    join

    $display("Fork-join block has completed at time %0t", $time);
  end
  
  task automatic my_task(input int thread_id);
    begin
      $display("Thread %0d  time %0t", thread_id, $time);
      #10;  
      $display("Thread %0d  time %0t", thread_id, $time);
    end
  endtask
endmodule

/////////////////////////////////////////////////////

