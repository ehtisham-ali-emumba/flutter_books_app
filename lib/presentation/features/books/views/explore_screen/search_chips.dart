// book_search_chips.dart

import 'package:flutter/material.dart';

class SearchChips extends StatelessWidget {
  final void Function(String) onTap;
  const SearchChips({super.key, required this.onTap});

  final List<String> topics = const [
    'History',
    'Science Fiction',
    'Fantasy',
    'Love',
    'Adventure',
    'Mystery',
    'Biography',
    'Children',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: topics
          .map((t) => ActionChip(label: Text(t), onPressed: () => onTap(t)))
          .toList(),
    );
  }
}
