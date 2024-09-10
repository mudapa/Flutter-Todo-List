import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'bloc/todo_bloc.dart';
import 'models/todo_model.dart';
import 'pages/todo_page.dart';
import 'utils/hive_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveUtils().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                TodoBloc(todoBox: Hive.box<Todo>('todos'))..add(LoadTodos())),
      ],
      child: MaterialApp(
        title: 'Flutter Todo List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodoPage(),
      ),
    );
  }
}
