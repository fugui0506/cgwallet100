import 'dart:collection';

class MyTaskQueue {
  final _taskQueue = Queue<Future<void> Function()>();
  bool _isExecuting = false;

  void addTask(Future<void> Function() task) {
    _taskQueue.add(task);
    if (!_isExecuting) {
      _nextTask();
    }
  }

  Future<void> _nextTask() async {
    if (_taskQueue.isEmpty) {
      _isExecuting = false;
      return;
    }

    _isExecuting = true;
    final task = _taskQueue.removeFirst();
    await task();
    _nextTask();
  }
}