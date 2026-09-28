// Problem 6: fully documented API class structure ready for generation via the dart doc command.

class Task {
  
  Task(this.title);

  final String title;

  bool isDone = false;

  @override
  String toString() => '${isDone ? '[x]' : '[ ]'} $title';
}

class TodoList {
  final List<Task> _tasks = [];

  int get length => _tasks.length;

  Task add(String title) {
    if (title.isEmpty) {
      throw ArgumentError('Title must not be empty');
    }
    final task = Task(title);
    _tasks.add(task);
    return task;
  }

  void complete(int index) {
    _tasks[index].isDone = true;
  }

 
  List<Task> pending() => _tasks.where((t) => !t.isDone).toList();
}

void main() {
  var list = TodoList();
  list.add('Finish Dart lab');
  list.add('Push to GitHub');
  list.complete(0);
  print('Total: ${list.length}');
  print('Pending: ${list.pending()}');
}
