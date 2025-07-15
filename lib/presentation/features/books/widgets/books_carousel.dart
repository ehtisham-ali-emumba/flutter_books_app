import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/components/shared_widgets/base_carousel.dart';
import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/widgets/book_card.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';

class BooksCarousel extends StatelessWidget {
  final dynamic title;

  final List<Book> books;

  const BooksCarousel({super.key, this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                title,
                kind: TextKind.heading,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 23,
              ),
              Icon(
                Icons.book,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        BaseCarousel(
          options: CarouselOptions(
            enlargeCenterPage: false,
            autoPlay: false,
            height: 270,
            viewportFraction: 0.55,
            padEnds: false,
            enableInfiniteScroll: false,
          ),
          items: books.map((book) {
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
              child: BookCard(heroId: '${title}_${book.id}', book: book),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
