
class prime_number;
  rand bit [8:0] a[$],b[$];
  constraint abc {a.size==200; }
  constraint cba { foreach(a[i]
    if(i>1 )
     a[i]==prime(i);}
 
  function int prime( int g);
    for(int i=2;i<g;i++)
        if(g%i==0)
          return 2; //if it is not a prime number ,returning 2 which is one of prime
      prime=g;
    endfunction
  function void post_randomize();
    a=a.unique;
   for(int i=0;i<a.size;i++)
     if(a[i]%10==7)
       b.push_back(a[i]);  //in b queue you will find prime numbers with units place as 7.
 
  endfunction
endclass


module test;
prime_number pri;

initial
  begin
    pri=new;
    void'(pri.randomize);
    $display("%p",pri);
  end
endmodule
