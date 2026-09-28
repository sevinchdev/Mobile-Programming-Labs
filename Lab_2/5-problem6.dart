// Problem 6: fully documented API class structure ready for generation via the dart doc command.

/// A single task in a to-do list.
class Task {
  /// Creates a task with the given [title].
  ///
  /// The task starts as not completed.
  Task(this.title);

  /// The short description of the task.
  final String title;

  /// Whether the task has been completed.
  bool isDone = false;

  @override
  String toString() => '${isDone ? '[x]' : '[ ]'} $title';
}

/// Manages a collection of [Task] objects.
class TodoList {
  final List<Task> _tasks = [];

  /// The number of tasks currently in the list.
  int get length => _tasks.length;

  /// Adds a new task with the given [title] and returns it.
  ///
  /// Throws an [ArgumentError] if [title] is empty.
  Task add(String title) {
    if (title.isEmpty) {
      throw ArgumentError('Title must not be empty');
    }
    final task = Task(title);
    _tasks.add(task);
    return task;
  }

  /// Marks the task at [index] as completed.
  ///
  /// Throws a [RangeError] if [index] is out of bounds.
  void complete(int index) {
    _tasks[index].isDone = true;
  }

  /// Returns all tasks that are not completed yet.
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
