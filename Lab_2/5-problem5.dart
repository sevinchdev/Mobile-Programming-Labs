// Problem 5: annotate code elements using @deprecated and @override accompanied by explaining doc comments.

class Printer {
  
  void printText(String text) => print(text);

  @deprecated
  void oldPrint(String text) => print('OLD: $text');
}


class LoudPrinter extends Printer {
  
  @override
  void printText(String text) => print(text.toUpperCase());
}

void main() {
  Printer p = LoudPrinter();
  p.printText('hello dart');
  p.oldPrint('legacy call');
}
