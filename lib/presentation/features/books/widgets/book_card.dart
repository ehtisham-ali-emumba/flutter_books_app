import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/core/constants/app_strings.dart';
import 'package:books/core/utils/image_utils.dart';
import 'package:books/data/models/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final String heroId; // Optional hero ID for custom animations

  const BookCard({super.key, required this.book, required this.heroId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
          context.push(
            '/book/${book.id}',
            extra: {"book": book, "heroId": heroId},
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Book Poster - Hero Widget (will animate to small poster in details)
              Hero(
                tag: heroId ?? book.id, // Same tag as details screen
                child: Image.network(
                  ImageUtils.getBookCoverImagePath(book.coverImageUrlId),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: Icon(Icons.movie, size: 50, color: Colors.white),
                    );
                  },
                ),
              ),

              // Dark overlay for text readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(1)],
                  ),
                ),
              ),

              // Book Info at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        book.title,
                        kind: TextKind.heading,
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 15),
                      AppText(
                        '${AppStrings.by} ${book.author}',
                        kind: TextKind.caption,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      SizedBox(height: 5),
                      AppText(
                        '${AppStrings.year} ${book.publishYear}',
                        kind: TextKind.caption,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
