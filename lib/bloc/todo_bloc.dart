import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Box<Todo> todoBox;

  TodoBloc({required this.todoBox}) : super(TodoLoading()) {
    on<LoadTodos>((event, emit) {
      final todos = todoBox.values.toList();
      emit(TodoLoaded(todos: todos));
    });

    on<AddTodo>((event, emit) {
      todoBox.add(event.todo);
      final todos = todoBox.values.toList();
      emit(TodoLoaded(todos: todos));
    });

    on<UpdateTodo>((event, emit) {
      event.todo.save();
      final todos = todoBox.values.toList();
      emit(TodoLoaded(todos: todos));
    });

    on<DeleteTodo>((event, emit) {
      event.todo.delete();
      final todos = todoBox.values.toList();
      emit(TodoLoaded(todos: todos));
    });
  }
}
