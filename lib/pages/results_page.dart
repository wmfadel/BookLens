// import 'package:book_lens/services/books_service.dart';
// import 'package:book_lens/widgets/no_matches_result.dart';
// import 'package:flutter/material.dart';
//
// import '../models/api_book.dart';
//
// class ResultScreen extends StatefulWidget {
//   final String text;
//
//   const ResultScreen({super.key, required this.text});
//
//   @override
//   State<ResultScreen> createState() => _ResultScreenState();
// }
//
// class _ResultScreenState extends State<ResultScreen> {
//   final BooksAPISearchService _booksService = BooksAPISearchService();
//   List<APIBook> _books = [];
//
//   @override
//   void initState() {
//     super.initState();
//     findBook();
//   }
//
//   findBook() async {
//     String query = widget.text.replaceAll('\n', ' ');
//
//     _books = await _booksService.searchAPIBook(query);
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Book Lens')),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//                 child: _books.isEmpty
//                     ? const NoMatchesResult()
//                     : Column(
//                         children: [
//                           Text(
//                             _books[0].title ?? '',
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 24),
//                           ),
//                           const SizedBox(height: 10),
//                           Expanded(
//                             child: Image.network(
//                               _books[0].thumbnail ?? '',
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ],
//                       )),
//             if (_books.length > 1) ...[
//               const SizedBox(height: 10),
//               const Text('Other Matches'),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 250,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.all(16),
//                     itemCount: _books.length - 1,
//                     itemBuilder: (context, index) {
//                       final book = _books[index + 1];
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 16),
//                         child: Image.network(
//                           book.thumbnail ?? '',
//                           width: 150,
//                           height: 200,
//                           fit: BoxFit.cover,
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
