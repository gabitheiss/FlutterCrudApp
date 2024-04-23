import '../model/book.dart';

class BooksService {
  BooksService._();

  List<Book> _books = [];

  int _id = 0;

  static final instance = BooksService._();

  int nextID() {
    return _id++;
  }

  save(Book book) {
    var data = _books.where((element) => element.title == book.title);
    if (data.isEmpty) {
      _books.add(book);
    } else {
      _books = _books.map((element) {
        if (element.title == book.title) {
          return book;
        }
        return element;
      }).toList();
    }
  }

  delete(Book book) {
    var data = _books.where((element) => element.title == book.title);
    if (data.isNotEmpty) {
      _books.removeWhere((element) => element.title == book.title);
    }
  }

  List<Book> get books => _books;
}
