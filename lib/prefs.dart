import 'package:shared_preferences/shared_preferences.dart';

class TodoManager {
  static const String _todoListKey = 'todo_list';

  static Future<void> addTodo(String todo) async {
    final prefs = await SharedPreferences.getInstance();
    final todoList = await getTodos();
    todoList.add(todo);
    await prefs.setStringList(_todoListKey, todoList);
  }

  static Future<List<String>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_todoListKey) ?? [];
  }

  static Future<void> removeTodo(String todo) async {
    final prefs = await SharedPreferences.getInstance();
    final todoList = await getTodos();
    todoList.remove(todo);
    await prefs.setStringList(_todoListKey, todoList);
  }
}



/* 
1- Adicionar a dependência do Shared Preferences
2- Criar um gerenciador de tarefas com Shared Preferences
3- Integrar o TodoManager no app
*/