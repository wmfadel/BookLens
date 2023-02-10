import 'package:book_lens/books_api_search_service.dart';
import 'package:flutter/material.dart';

import 'api_book.dart';

class ResultScreen extends StatefulWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final BooksAPISearchService _booksService = BooksAPISearchService();
  List<APIBook> _books = [];

  @override
  void initState() {
    super.initState();
    findBook();
  }

  findBook() async {
    String query = widget.text.replaceAll('\n', ' ');
    if (query.length > 100) {
      query = query.substring(0, 100);
    }
    _books = await _booksService.searchAPIBook(query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) {
            final book = _books[index];
            return Column(
              children: [
                Image.network(
                  book.thumbnail ?? '',
                  width: 200,
                  height: 300,
                ),
                const SizedBox(height: 20),
                Text(book.title ?? ''),
              ],
            );
          }));
}
