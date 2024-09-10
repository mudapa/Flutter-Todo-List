part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded({
    required this.todos,
  });

  @override
  List<Object> get props => [todos];
}

class TodoError extends TodoState {
  final String error;

  const TodoError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
