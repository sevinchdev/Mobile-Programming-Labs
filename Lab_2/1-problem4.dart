//Problem 4: Take numeric arguments and print their average.

void main(List<String> items){

  if (items.isEmpty){
    print("List is empty!");
    return;
  }

  double sum = 0;
  int count = 0;

  for (var item in items){
    double ? n = double.tryParse(item);

    if (n == null){
      print("$n is not parsible!");
      continue;
    }else{
      count ++;
    }

    sum += n;
  }

  double average = sum/count;

  print("Average of numeric arguments is $average");
}