import 'package:books/components/shared_widgets/app_text.dart';
import 'package:books/data/models/book.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final String heroId; // Optional hero ID for custom animations

  const BookCard({super.key, required this.book, required this.heroId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              // Book Poster - Hero Widget (will animate to small poster in details)
              Hero(
                tag: heroId ?? book.id, // Same tag as details screen
                child: Image.network(
                  book.coverImageUrl,
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
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
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
                        fontSize: 19,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            book.author,
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '${book.price}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
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
