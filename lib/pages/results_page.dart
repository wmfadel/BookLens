import 'package:book_lens/widgets/results/no_matches_result.dart';
import 'package:flutter/material.dart';

import 'package:book_lens/models/api_book.dart';

class ResultScreen extends StatefulWidget {
  final List<APIBook> books;

  const ResultScreen({super.key, required this.books});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<APIBook> get books => widget.books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Lens')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: books.isEmpty
                    ? const NoMatchesResult()
                    : Column(
                        children: [
                          Text(
                            books[0].title ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                              child: Image.network(
                                books[0].thumbnail ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )),
            if (widget.books.length > 1) ...[
              const SizedBox(height: 32),
              const Text('Other Matches'),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    itemCount: books.length - 1,
                    itemBuilder: (context, index) {
                      final book = books[index + 1];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Image.network(
                          book.thumbnail ?? '',
                          width: 150,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 64),
            ],
          ],
        ),
      ),
    );
  }
}
