import 'package:flutter/material.dart';
import 'package:todo_list/prefs.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _textEditingController = TextEditingController();

  List<String> tarefas = [];

  //Carregar a lista de tarefas inicial
  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await TodoManager.getTodos();
    setState(() {
      tarefas = todos;
    });
  }

  //Adicionar uma tarefa
  void _addNewTodo() async {
    if (_textEditingController.text.isNotEmpty) {
      await TodoManager.addTodo(_textEditingController.text);
      setState(() {
        tarefas.add(_textEditingController.text);
        _textEditingController.clear();
      });
    }
  }

  //Remover uma tarefa
  void _deleteTodo(int index) async {
    await TodoManager.removeTodo(tarefas[index]);
    setState(() {
      tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Digite sua tarefa'),
              controller: _textEditingController,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tarefas[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteTodo(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: _addNewTodo,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
