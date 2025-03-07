class name;
  int value;
  static int a;
  function new(int val = 0);
    value = val;
    a++;
  endfunction

  function void display();
    $display("Object value = %0d", value);
  endfunction
endclass


module top;
  // Define 2D dynamic array of MyObject
  name arr[][];
  
  initial begin
    arr = new[3];
    
    foreach(arr[i])
      arr[i] = new[2];
    
    foreach(arr[i,j]) begin
      arr[i][j] = new($random);
      
    end
    
      
    
    
    foreach(arr[i,j])
      begin
        
         $display("arr[%0p][%0p] = %0p",i,j, arr[i][j]);
      end
    $display("size of array  size= %0d  dimension %d", arr.size(),$dimensions(arr));

    
    
    arr.delete();
   $display("size of array after deleting = %0d", arr.size());
    $display("size full [0][0] = %0d", arr[0][0].a);
  
    
  end
endmodule

