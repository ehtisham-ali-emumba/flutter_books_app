import 'package:books/components/shared_widgets/custom_snackbar.dart';
import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/views/home_screen/app_color_toggle.dart';
import 'package:flutter/material.dart';

import 'app_dark_mode_toggle.dart';
import 'books_carousel.dart';

final List<Book> booksData = [
  // Sample data, replace with actual book data
  Book(
    id: '1',
    title: 'Book One',
    author: 'Author A',
    coverImageUrl:
        'https://cdn.pixabay.com/photo/2015/05/29/07/47/stone-789012_960_720.jpg',
    description: 'Description of Book One',
    price: 123,
  ),
  Book(
    id: '2',
    title: 'Book One',
    author: 'Author A',
    coverImageUrl:
        'https://cdn.pixabay.com/photo/2015/05/29/07/47/stone-789012_960_720.jpg',
    description: 'Description of Book One',
    price: 123,
  ),
  Book(
    id: '3',
    title: 'Book One',
    author: 'Author A',
    coverImageUrl:
        'https://cdn.pixabay.com/photo/2015/05/29/07/47/stone-789012_960_720.jpg',
    description: 'Description of Book One',
    price: 123,
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            CustomSnackbar.show(context, "show drawer");
          },
        ),
        title: Text("Books Home"),
        centerTitle: true,
        actions: [AppDarkModeToggle(), AppColorToggle()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            BooksCarousel(title: "Popular Books", books: booksData),
            BooksCarousel(title: "Popular Books", books: booksData),
          ],
        ),
      ),
    );
  }
}
