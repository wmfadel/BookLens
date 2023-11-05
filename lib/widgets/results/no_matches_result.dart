import 'package:flutter/material.dart';

class NoMatchesResult extends StatelessWidget {
  const NoMatchesResult({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No Matches Found for this book'));
  }
}
