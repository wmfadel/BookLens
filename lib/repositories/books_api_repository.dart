import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:book_lens/models/api_book.dart';

class BooksAPIRepository {
  final String _searchURL = 'https://www.googleapis.com/books/v1/volumes?q=';

  Future<List<APIBook>> searchAPIBook(String name) async {
    String url = _searchURL + name;
    http.Response response = await http.get(Uri.tryParse(url)!);
    var res = json.decode(response.body);

    if (res == null ||
        res is! Map ||
        res['items'] == null ||
        res['items'] is! List) {
      return [];
    }
    List<APIBook> books = [];
    for (var item in res['items']) {
      try {
        books.add(APIBook.fromJson(item));
      } catch (e) {
        // TODO: log error to logging service
      }
    }
    return books;
  }
}
