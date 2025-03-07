# Opening the file 
open(file, "ABC.txt");
while(<file>){
if($_=~m{^Sushanki\W 28})
{
print "success\n";
}
else
{
print "failure \n";
}
}
close(file);