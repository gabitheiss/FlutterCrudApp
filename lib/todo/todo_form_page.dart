import 'package:aula_flutter_app/todo/todo.dart';
import 'package:aula_flutter_app/todo/todo_service.dart';
import 'package:flutter/material.dart';

class TodoFormPage extends StatefulWidget {
  const TodoFormPage({super.key});

  @override
  State<TodoFormPage> createState() {
    return _TodoFormPageState();
  }
}

class _TodoFormPageState extends State<TodoFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _id = TodoService.instance.nextID();
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.arguments != null) {
        Todo todo = ModalRoute.of(context)!.settings.arguments as Todo;
        setState(() {
          _titleController.text = todo.title;
          _descriptionController.text = todo.description;
          _completed = todo.completed;
          _id = todo.id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro de tarefas"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: "Título"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'O Campo título é obrigatório';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: "Descrição"),
                  ),
                  CheckboxListTile(
                      activeColor: Colors.black,
                      title: const Text('Completa'),
                      value: _completed,
                      onChanged: (bool? value) {
                        setState(() {
                          _completed = value!;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Todo todo = Todo(
                                id: _id,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                completed: _completed);
                            TodoService.instance.save(todo);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // flutter pub add dio

}
