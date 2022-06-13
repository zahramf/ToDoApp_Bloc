import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:to_do_app_bloc/home/model/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>("tasks");

    await _tasks.clear();
    await _tasks.add(Task("username1", "task1", true));
    await _tasks.add(Task("username2", "task122", false));
  }

  List<Task> getTask(final String username) {
    final tasks = _tasks.values.where((element) => element.user == username);

    return tasks.toList();
  }

  void addTask(final String task, final String username) {
    _tasks.add(
      Task(username, task, false),
    );
  }

  Future<void> removeTask(final String task, final String username) async {
    final taskToRemove = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String task, final String username,
      {final bool? completed}) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    final index = taskToEdit.key as int;
    await _tasks.put(
      index,
      Task(username, task, completed ?? taskToEdit.completed),
    );
  }
}
