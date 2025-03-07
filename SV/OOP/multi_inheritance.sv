/////////////////////////////multi inheritance

////////base class
class A;
bit [7:0]s1;
bit [7:0]s2;

  function name;
	  s1=2;
	  s2=9;
	  $display("s1=%0d,s1=%0d",s1,s2);
  endfunction
endclass

/////child class
class B extends A;
bit [3:0]s3;
	function name1();
         super.name1()
         s3=2;
	endfunction
endclass

class D extends B;
bit [3:0]s4;
       function name2();
	super.name2();
	s4=9;
       endfunction
endclass

class E extends B;
	bit [3:0]s5;
       function name3();
	super.name3();
	s5=90;
       endfunction

endclass

class C extends A;
	bit [3:0]s6;
       function name4();
	super.name4();
	s6=91;
       endfunction

endclass

class F extends C;
	bit [3:0]s7;
       function name5();
	super.name5();
	s7=19;
       endfunction

endclass

class G extends F;
	bit [3:0]s8;
       function name6();
	super.name6();
	s8=9;
       endfunction

endclass



module top;


initial begin

end


endmodule
