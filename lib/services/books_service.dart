import 'package:book_lens/models/api_book.dart';
import 'package:book_lens/repositories/books_api_repository.dart';
import 'package:flutter/cupertino.dart';

class BooksService {
  BooksService({
    @visibleForTesting BooksAPIRepository? booksAPIRepository,
  }) : _booksAPIRepository = booksAPIRepository ?? BooksAPIRepository();

  final BooksAPIRepository _booksAPIRepository;
  List<APIBook> _results = [];

  List<APIBook> get results => [..._results];

  Future<List<APIBook>> searchAPIBook(String name) async {
    _results = await _booksAPIRepository.searchAPIBook(name);
    return results;
  }
}
