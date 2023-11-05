import 'package:book_lens/controllers/search_cubit.dart';
import 'package:book_lens/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Text Recognition',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider<SearchCubit>(
        create: (context) => SearchCubit()..initCamera(),
        child: const SearchPage(),
      ),
    );
  }
}
