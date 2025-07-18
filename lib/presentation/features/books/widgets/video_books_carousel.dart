import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/components/shared_widgets/base_carousel.dart';
import 'package:books/core/responsive/index.dart';
import 'package:books/data/models/book.dart';
import 'package:books/presentation/features/books/widgets/book_card.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';

class VideoBooksCarousel extends StatefulWidget {
  final dynamic title;
  final List<Book> books;

  const VideoBooksCarousel({super.key, this.title, required this.books});

  @override
  State<VideoBooksCarousel> createState() => _VideoBooksCarouselState();
}

class _VideoBooksCarouselState extends State<VideoBooksCarousel> {
  List<GlobalKey<BookCardState>> _bookCardKeys = [];

  @override
  void initState() {
    super.initState();
    // Create keys for each book
    _bookCardKeys = widget.books
        .map((book) => GlobalKey<BookCardState>())
        .toList();

    // Start first video after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      if (_bookCardKeys.isNotEmpty) {
        _bookCardKeys[0].currentState?.enableVideoMode();
      }
    });
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) async {
    _stopAllVideos();
    if (index < _bookCardKeys.length) {
      /**/
      _bookCardKeys[index].currentState?.enableVideoMode();
    }
  }

  void _stopAllVideos() {
    var i = 0;
    for (var key in _bookCardKeys) {
      key.currentState?.disableVideoMode(index: i);
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Sz.w(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                widget.title,
                kind: TextKind.heading,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
                fontSize: R.value(mobile: 19, tablet: 10),
              ),
              Icon(
                Icons.book,
                size: R.value(mobile: 22, tablet: 10),
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        BaseCarousel(
          options: CarouselOptions(
            enlargeCenterPage: false,
            autoPlay: false,
            height: R.valueH(mobile: 270, tablet: 320),
            viewportFraction: R.value(mobile: 0.55, tablet: 0.12),
            padEnds: false,
            enableInfiniteScroll: false,
            onPageChanged: _onPageChanged,
          ),
          items: widget.books.asMap().entries.map((entry) {
            int index = entry.key;
            Book book = entry.value;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: BookCard(
                key: _bookCardKeys[index],
                heroId: '${widget.title}_${book.id}',
                book: book,
                globalKey: _bookCardKeys[index],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
