import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app_bloc/home/model/task.dart';
import 'package:to_do_app_bloc/home/services/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final List<Task> todos =
          _todoService.getTask(event.username) as List<Task>;
      emit(TodosLoadedState(todos));
    });
  }
}
