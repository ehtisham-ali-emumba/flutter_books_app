import 'package:books/core/utils/input_utils.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatefulWidget {
  final Function(String) onSearch;

  const SearchHeader({super.key, required this.onSearch});

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  final _controller = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 400);

  void setSearchText(String text) {
    _controller.text = text;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
    widget.onSearch(text);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          onChanged: (value) {
            _debouncer(value, widget.onSearch);
          },
          decoration: InputDecoration(
            hintText: "Enter book title or author",
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
              },
              icon: Icon(Icons.close),
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
