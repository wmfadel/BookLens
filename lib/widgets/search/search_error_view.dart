import 'package:flutter/material.dart';

class SearchErrorView extends StatelessWidget {
  final String? errorMessage;

  const SearchErrorView({this.errorMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(errorMessage ?? 'Something went wrong');
  }
}
