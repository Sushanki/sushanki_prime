# An array of integers from 1 to 10 
@list = (1..10);  
<<sus   
# Non-interpolated string 
$strng1 = 'Using Single quotes: @list';  
sus   
# Interpolated string 
$strng2 = "Using Double-quotes: @list"; 
print("$strng1\n$strng2");
