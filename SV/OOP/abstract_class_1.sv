/////////////////////////abstract class

virtual class BasePacket;
      pure virtual function integer send(bit[31:0] data); 
      
endclass
        
class EtherPacket extends BasePacket;
    virtual function integer send(bit[31:0] data);
      $display("data %0d",data);
     endfunction
endclass


module top;
EtherPacket e;
BasePacket t;

initial begin
  e=new();
  //e.send(123);
  t=e;
  //t=new();
  t.send(234);
end

endmodule
