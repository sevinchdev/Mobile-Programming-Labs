// Problem 3: Count and display the number of command-line arguments.

void main(List<String> args){

  if (args.isEmpty){
    print("No Command Line Arguments.");
    return;
  }

  int count = 0;
  for (int i=0; i < args.length; i++){
    count ++;
  }

  print("The number of command-line arguments is $count");
}