///////////////////////////////////inheritance
class car_model1 ;

	bit [2:0] doors;
	bit [2:0] taires;
	bit [1:0] mirrors;

	function void name();
		doors=4; mirrors=2;taires=4;
	endfunction

	function void print(string Sushanki);
		$display("%s",Sushanki);
		name();
		$display("doors=%d",doors);
		$display("taires=%d",taires);
		$display("mirrors=%d",mirrors);
	endfunction 

endclass


class model2 extends car_model1;
	bit airbag;

	function void print(string Sushanki);
		$display("%s",Sushanki);
		airbag=1;
		$display("airbag=%d",airbag);
	endfunction 

endclass



module top;

car_model1 m1;
model2 m2;
initial begin
      
	m2=new();
	m1=new();
	m1.print("model1");
	m2.print("model2");

end
endmodule

////////////////////////////////////////////using super keyword


class car_model1 ;

	bit [2:0] doors;
	bit [2:0] taires;
	bit [1:0] mirrors;

	function void name();
		doors=4; mirrors=2;taires=4;
	endfunction

	function void print();
		name();
		$display("doors=%d",doors);
		$display("taires=%d",taires);
		$display("mirrors=%d",mirrors);
	endfunction 

endclass


class model2 extends car_model1;
	bit airbag;

	function void print2();
        super.print();
         airbag=1;
	 $display("airbag=%d",airbag);
	endfunction 

endclass



module top;

car_model1 m1;
model2  m2;


initial begin
     
	m2=new();
	m1=new();
	m2.print2();

end
endmodule 
