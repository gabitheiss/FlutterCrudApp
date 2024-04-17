import 'package:aula_flutter_app/todo/todo.dart';

class TodoService {
  TodoService._();

  List<Todo> _todos = [
    Todo(
        id: 1,
        title: 'Primeira tarefa',
        description: 'Descrição da tarefa',
        completed: false),
    Todo(
        id: 2,
        title: 'Segunda tarefa',
        description: 'Descrição da tarefa',
        completed: false),
  ];

  int _ID = 3;

  static final instance = TodoService._();

  int nextID() {
    return _ID++;
  }

  save(Todo todo) {
    var data = _todos.where((element) => element.id == todo.id);
    if (data.isEmpty) {
      _todos.add(todo);
    } else {
      _todos = _todos.map((element) {
        if (element.id == todo.id) {
          return todo;
        }
        return element;
      }).toList();
    }
  }

  List<Todo> get todos => _todos;
}
