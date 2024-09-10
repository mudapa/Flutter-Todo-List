import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../models/todo_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final todoController = TextEditingController();

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                      labelText: 'Add new todo',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final todo = Todo(
                      title: todoController.text,
                    );
                    context.read<TodoBloc>().add(AddTodo(todo: todo));
                    todoController.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoLoaded) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: Checkbox(
                          value: todo.isCompleted,
                          onChanged: (value) {
                            todo.isCompleted = value!;
                            context
                                .read<TodoBloc>()
                                .add(UpdateTodo(todo: todo));
                            setState(() {});
                          },
                        ),
                        onLongPress: () {
                          context.read<TodoBloc>().add(DeleteTodo(todo: todo));
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Something went wrong!'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
