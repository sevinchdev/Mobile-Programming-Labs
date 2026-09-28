//Problem 5: Validate that exactly two arguments were given, otherwise print a usage warning.

void main(List<String> names){
  if (names.isEmpty){
    print("List is empty!");
  }

  int count = names.length;
  if (count != 2){
    print("Not exactly two arguments!");
  }
  
}