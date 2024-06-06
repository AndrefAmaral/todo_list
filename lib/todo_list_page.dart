import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _textEditingController = TextEditingController();

  List<String> tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List',
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
                        setState(() {
                          tarefas.removeAt(index);
                        });
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
            onPressed: () {
              if (_textEditingController.text.isNotEmpty) {
                setState(() {
                  tarefas.add(_textEditingController.text);
                });
                _textEditingController.clear();
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
