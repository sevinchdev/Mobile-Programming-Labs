// Problem 4: higher-order function accepting a list of integers and a transformer callback function.

List<int> transformAll(List<int> numbers, int Function(int) transformer) {
  return [for (final n in numbers) transformer(n)];
}

void main() {
  List<int> nums = [1, 2, 3, 4];
  print('Squared: ${transformAll(nums, (x) => x * x)}');
  print('Doubled: ${transformAll(nums, (x) => x * 2)}');
}
