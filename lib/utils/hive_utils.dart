import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo_model.dart';

class HiveUtils {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    await Hive.openBox<Todo>('todos');
  }
}
