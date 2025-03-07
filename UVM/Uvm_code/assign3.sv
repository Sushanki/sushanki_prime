
///////////////////////////////////////////////////type and instance override

class A extends uvm_component;
  `uvm_component_utils(A)
  function new(string name="A",uvm_component parent);
     super.new(name,parent);
  endfunction
 
endclass

class B extends A;
  `uvm_component_utils(B)
  function new(string name="B",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

class C extends B;
  `uvm_component_utils(C)
  function new(string name="C",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

class D extends B;
  `uvm_component_utils(D)
  function new(string name="D",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

class E extends C;
  `uvm_component_utils(E)
  function new(string name="E",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

class F extends C;
  `uvm_component_utils(F)
  function new(string name="F",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

class G extends C;
  `uvm_component_utils(G)
  function new(string name="G",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

class H extends C;
  `uvm_component_utils(H)
  function new(string name="H",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

class test extends uvm_test;
  A A1;
  B B1;
  C C1;
  D D1;
  `uvm_component_utils(test)
  function new(string name="test",uvm_component parent);
     super.new(name,parent);
   endfunction
  
  function void build_phase(uvm_phase phase);
    uvm_factory factory = uvm_factory::get();
    super.build_phase(phase);
    ///////////////////////type override using type and name
   // set_type_override_by_type(C::get_type(), H::get_type());
   //factory.set_type_override_by_name("A", "C");
    
//     ///////////////////////inst override using type and name
    set_inst_override_by_type("*", C::get_type(), H::get_type());
     //factory.set_inst_override_by_name("A", "B", "*");
    
//     /////////////////////////type and inst override
//     A::type_id::set_type_override(B::get_type());
//     A::type_id::set_inst_override(B::get_type(), "*");
    
   //     A1 = A::type_id::create("A1", this);
   // B1 = B::type_id::create("B1", this);
    C1 = C::type_id::create("C1", this);
 //   D1 = D::type_id::create("D1", this);
    
    factory.print();
  endfunction
   
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  

endclass

module top;
  initial begin
    run_test("test");
  end
endmodule



////////////////////////////////////////////////////////////////////
// Code your testbench here
// or browse Examples
typedef class A;
typedef class B;
typedef class C;
typedef class D;
typedef class E;
typedef class F;
class A extends uvm_component;
  `uvm_component_utils(A)
  
  B s1;
  E s2;
  F s7;
  function new(string name="A",uvm_component parent);
     super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s1 = B::type_id::create("s1", this);
    s2 = E::type_id::create("s2", this);
    s7 = F::type_id::create("s7", this);
  endfunction
 
endclass

class B extends uvm_component;
  `uvm_component_utils(B)
  C s3;
  D s4;
  function new(string name="B",uvm_component parent);
     super.new(name,parent);

   endfunction
endclass

class C extends uvm_component;
  `uvm_component_utils(C)
  
  function new(string name="C",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass


class D extends uvm_component;
  `uvm_component_utils(D)
  function new(string name="D",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass

class E extends uvm_component;
  `uvm_component_utils(E)
  C s5;
  D s6;
  function new(string name="E",uvm_component parent);
     super.new(name,parent);

   endfunction
endclass

class F extends uvm_component;
  `uvm_component_utils(F)
  C s8;
  D s9;
  function new(string name="F",uvm_component parent);
     super.new(name,parent);

   endfunction
endclass

class c1 extends C;
  `uvm_component_utils(c1)

  function new(string name="c1",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass  

class c2 extends C;
  `uvm_component_utils(c2)

  function new(string name="c2",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass  

class d1 extends D;
  `uvm_component_utils(d1)

  function new(string name="d1",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass  

class d2 extends D;
  `uvm_component_utils(d2)

  function new(string name="d2",uvm_component parent);
     super.new(name,parent);
   endfunction
endclass  

class test extends uvm_test;
  A A_o;
  B B_o;
  C C_o;
  D D_o;
  E E_o;
  F F_o;
  c1 c1_o;
  c2 c2_o;
  d1 d1_o;
  d2 d2_o;
  
  `uvm_component_utils(test)
  function new(string name="test",uvm_component parent);
     super.new(name,parent);
   endfunction
  
  function void build_phase(uvm_phase phase);
    uvm_factory factory = uvm_factory::get();
    super.build_phase(phase);
    ///////////////////////type override using type and name
   // set_type_override_by_type(C::get_type(), H::get_type());
//    factory.set_type_override_by_name("A", "C");
    
//     ///////////////////////inst override using type and name
  //  set_inst_override_by_type("*", A::get_type(), c2::get_type());
    factory.set_inst_override_by_name("B", "c1", "C");
    
//     /////////////////////////type and inst override
    C::type_id::set_type_override(c1::get_type());
    E::type_id::set_inst_override(d2::get_type(), "D");
    
//     A_o = A::type_id::create("A_o", this);
      B_o = B::type_id::create("B_o", this);
      C_o = C::type_id::create("C_o", this);
      D_o = D::type_id::create("D_o", this);
    E_o = E::type_id::create("E_o", this);
// //       F_o = F::type_id::create("F_o", this);
//     //       c1_o =c1::type_id::create("c1_o", this);
//       c2_o= c2::type_id::create("c2_o", this);
// //       d1_o = d1::type_id::create("d1_o", this);
// //       d2_o = d2::type_id::create("d2_o", this);
    
   factory.print();
  endfunction
   
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  

endclass

module top;
  initial begin
    run_test("test");
  end
endmodule
