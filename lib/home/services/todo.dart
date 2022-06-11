import 'package:hive/hive.dart';
import 'package:to_do_app_bloc/home/model/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>("tasks");
  }

  Future<List<Task>> getTask(final String username) async {
    final tasks = _tasks.values.where((element) => element.user == username);

    return tasks.toList();
  }
}
