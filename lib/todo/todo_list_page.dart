import 'package:aula_flutter_app/todo/todo.dart';
import 'package:aula_flutter_app/todo/todo_service.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() {
    return _TodoListPageState();
  }
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> _todos = TodoService.instance.todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          Todo currentTodo = _todos[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/form', arguments: currentTodo)
                  .then((value) {
                setState(() {
                  _todos = TodoService.instance.todos;
                });
              });
            },
            child: ListTile(
              title: Text(currentTodo.title),
              subtitle: Text(currentTodo.description),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed("/form").then((value) {
            setState(() {
              _todos = TodoService.instance.todos;
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
