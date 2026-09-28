// Problem 4: nullable and non-nullable variables with the default fallback operator (??).

void main() {
  String name = 'Alice';
  String? nickname;

  String display = nickname ?? 'No nickname';
  print('$name / $display');

  nickname ??= 'Ali';
  print('After ??=: $nickname');
  print('Length of nickname: ${nickname.length}');
}
