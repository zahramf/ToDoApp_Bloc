import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do_app_bloc/home/model/task.dart';
import 'package:to_do_app_bloc/home/services/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>(
      (event, emit) {
        final todos = _todoService.getTask(event.username);
        emit(TodosLoadedState(todos, event.username));
      },
    );

    on<AddTodoEvent>(
      (event, emit) async {
        final currentState = state as TodosLoadedState;
        _todoService.addTask(event.todoText, currentState.username);
        add(
          LoadTodosEvent(currentState.username),
        );
      },
    );
  }
}
