import 'dart:collection';
import 'dart:developer';

class MyLogger {
  static final MyLogger _instance = MyLogger._internal();
  factory MyLogger() => _instance;
  MyLogger._internal();

  static void w(String text) => _instance._w(text);
  static void l() => _instance._l();

  final _taskQueue = Queue<Future<void> Function()>();
  bool _isExecuting = false;

  void _l() {
    _addTask(() async {
      log("-" * 120);
    });
  }

  void _w(String text) {
    final timestamp = DateTime.now().toIso8601String();
    _addTask(() async {
      log('[$timestamp] $text');
    });
  }

  void _addTask(Future<void> Function() task) {
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
    if (_taskQueue.isNotEmpty) {
      await Future.delayed(Duration(milliseconds: 10));
      _nextTask();
    } else {
      _isExecuting = false;
    }
  }
}
