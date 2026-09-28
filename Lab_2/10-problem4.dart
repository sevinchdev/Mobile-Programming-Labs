// Problem 4: parametric polymorphism using generic classes Repository<T>.

class Repository<T> {
  final List<T> _items = [];

  void add(T item) => _items.add(item);

  List<T> getAll() => List.unmodifiable(_items);

  int get count => _items.length;
}

void main() {
  var names = Repository<String>();
  names.add('Alice');
  names.add('Bob');

  var numbers = Repository<int>();
  numbers.add(10);
  numbers.add(20);

  print('Names: ${names.getAll()} (${names.count})');
  print('Numbers: ${numbers.getAll()} (${numbers.count})');
}
