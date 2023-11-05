import 'package:book_lens/models/api_book.dart';
import 'package:book_lens/repositories/books_api_repository.dart';
import 'package:flutter/cupertino.dart';

class BooksService {
  BooksService({
    @visibleForTesting BooksAPIRepository? booksAPIRepository,
  }) : _booksAPIRepository = booksAPIRepository ?? BooksAPIRepository();

  final BooksAPIRepository _booksAPIRepository;

  Future<List<APIBook>> searchAPIBook(String name) async {
    return await _booksAPIRepository.searchAPIBook(name);
  }
}
