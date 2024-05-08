
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../model/book.dart';
import '../service/book_service.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({super.key});

  @override
  State<BooksListPage> createState() {
    return _CarsListPageState();
  }
}

class _CarsListPageState extends State<BooksListPage> {
  List<Book> _book = BooksService.instance.books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Livros'),
      ),
      body: ListView.builder(
        itemCount: _book.length,
        itemBuilder: (context, index) {
          Book currentBook = _book[index];
          return ListTile(
            title: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/form', arguments: currentBook)
                      .then((value) {
                    setState(() {
                      _book = BooksService.instance.books;
                    });
                  });
                },
                child: Text(currentBook.title)
            ),
            subtitle: Text(currentBook.author),
            trailing: GestureDetector(
              onTap: () {
                BooksService.instance.delete(currentBook);
                setState(() {
                  _book = BooksService.instance.books;
                });
              },
              child: const Icon(
                  FluentIcons.delete_12_filled,
                  color: Colors.red),
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
              _book = BooksService.instance.books;
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
