import 'package:flutter/material.dart';

import '../model/book.dart';
import '../service/book_service.dart';

class BookFormPage extends StatefulWidget {
  const BookFormPage({super.key});

  @override
  State<BookFormPage> createState() {
    return _BookFormPageState();
  }
}

class _BookFormPageState extends State<BookFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  int _id = BooksService.instance.nextID();
  Book? book;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context) != null &&
          ModalRoute.of(context)!.settings.arguments != null) {
        book = ModalRoute.of(context)!.settings.arguments as Book;
        setState(() {
          _titleController.text = book!.title;
          _authorController.text = book!.author;
          _id = book!.id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(book != null ? book!.title : "Cadastro de Livros"),
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
                          return 'Informe o título do livro';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _authorController,
                      decoration: const InputDecoration(labelText: "Autor"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o autor do livro';
                        }
                        return null;
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (book != null)
                          Flexible(
                            flex: 1,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                              ),
                              onPressed: () {
                                BooksService.instance.delete(book!);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Deletar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        Flexible(
                          flex: 1,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Book book = Book(
                                    id: _id,
                                    title: _titleController.text,
                                    author: _authorController.text);
                                BooksService.instance.save(book);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text(
                              "Salvar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
