class example_yarray;

    int a[];
    int b[int];
    int c[$];
      
        
      function void base::dynamic();
        a=new[$urandom%56];
      foreach(a[i])
        begin
          a[i]=$urandom%432;
        end
      endfunction
      
      function void base::queue();
        for(int j=0; j<=$urandom%100; j++)
        begin
          q[j]=$urandom%45;
        end
      endfunction
      
      function void base::assoc();
        for(int j=0; j<=$urandom%45; j++)
        begin
          aa[(string'($urandom_range(97,122)))]=$urandom%45;
      end
      endfunction
      
      function void base:: dis();
        $display("dynamic array a: %0p \n queue q: %0p \n associative aa: %0p",a,q,aa);
      endfunction
      
      function void base::queue_operation();
        int r[$];
        $display("\n \n my QUEUE before any operaion : %0p \n \n ",q);
        $display("the value of q.pop_back is %0d  \n queue is : %0p:",q.pop_back,q);
        q.insert(3,5);
        $display("the value after q.insert($urandom,5) %0p:",q);
        $display("the value of q.pop_front is %0d  \n queue is : %0p:",q.pop_front,q);
        q.push_back($urandom%45);
        $display("the value after q.push_back is : %0p",q);
        q.push_front($urandom%34);
        $display("the value after q.push_front %0p",q);
        
      endfunction
      
      function void base::dynamic_operation();
        int k;
        $display("\ dynamic opraion is called \n");
        $display("sum of the all element is %0d:",a.sum);
        $display("logical and of the all element is %0d:",a.and);
        $display("logical OR of the all element is %0d:",a.or);
        $display("logical xor all element is %0d:",a.xor);
        $display("minimum vlaue of the array is %0p:",a.min());
        $display("maximum value if the array is  %0p:",a.max());
        $display("unique element of the array is %0p:",a.unique);
        a.shuffle();
        $display("shuffle the element of the array is %0p:",a);    
      endfunction
      
      function void base::associative_operaton();
        foreach(aa[i])
          begin
            $display(" called by key is a[%0s] :%0d",i,aa[i]);
          end
      endfunction

 endclass
     
  module test();
        
  
  base d[];
  base q[$];
  base a[string];
  string keys[];
  initial
    begin
/*       $display("\n the data type of d is %0s",$typename(d));
//       $display("\n the data type of q is %0s",$typename(q));
//       $display("\n the data type of a is %0s",$typename(a));
      d=new[$urandom%90];
      foreach(d[i])
        begin
          d[i]=new();
        end
      //d[0].dis();
      d[0].dynamic();
      //d[0].dynamic_operation();
      d[0].queue();
      //d[0].queue_operation();
      d[0].assoc();
      //d[0].associative_operaton();
      $display("size : %0d",d.size());
      d=new[10] (d);
      $display("size : %0d",d.size());
      d[9]=new();
      $display("%0p",d[9]);
      
      foreach(d[i])
        begin
          d[i].dynamic();
          d[i].queue();
          d[i].assoc();
        end
        
        foreach(d[i])
        begin
          d[i].queue_operation();
          d[i].associative_operaton();
          d[i].dynamic_operation();
        end
      
      */
     // queue object operation ...
      for(int j=0; j<=$urandom%100; j++)
        begin
          q[j]=new();
        end
      foreach(q[i])
        begin
          q[i].dynamic();
          q[i].queue();
          q[i].assoc();
        end
      q[4]=d[0];
      foreach(q[i])
        begin
          $display("a[%0d] : %0p",i,q[i]);
        end
      q.pop_front();
      $display("\n");
      foreach(q[i])
        begin
          $display("a[%0d] : %0p",i,q[i]);
        end
      $display("the size of the queue is :%0d",q.size);
      q.insert(1,q[0]);
      $display("the size of the queue is :%0d",q.size);
      q.push_back(q[9]);
      $display("the size of the queue is :%0d",q.size);
      foreach(q[i])
        begin
          q[i].queue_operation();
          q[i].associative_operaton();
          q[i].dynamic_operation();
        end
      
      //$display("\n element inside the array q is %0p",q);
      //$display("\n the data type of q is %0s",$typename(q));
      //$display("the size of the array is %0d",q.size());
    
/*      // associative aaray operaion...
      for(int i=0; i<=$urandom%656; i++)
        begin
          a[string'($urandom_range(97,123))]=new();
        end
        foreach(a[i])
        begin
          a[i].dynamic();
          a[i].queue();
          a[i].assoc();
        end
        foreach(a[i])
        begin
          a[i].queue_operation();
          a[i].associative_operaton();
          a[i].dynamic_operation();
        end
      foreach(a[i])
        begin
          $display("content in each object is a[%0s]: %0p ",i,a[i] );
        end
      //a["i"]=q[0]; // handle assignment
      a["i"].dynamic();
      a["i"].queue();
      a["i"].assoc();
      a["i"].queue_operation;
      a["i"].dynamic_operation;
      a["i"].associative_operaton;
     */ 
    end
endmodule
