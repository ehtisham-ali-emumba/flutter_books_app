class ReviewBook {
  final String id;
  final String bookId;
  final String userName;
  final String comment;
  final double rating;
  final DateTime datePosted;
  final String imageFilePath;

  ReviewBook({
    required this.id,
    required this.bookId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.datePosted,
    required this.imageFilePath,
  });

  factory ReviewBook.fromJson(Map<String, dynamic> json) => ReviewBook(
    id: json['id'],
    bookId: json['bookId'],
    userName: json['userName'],
    comment: json['comment'],
    rating: json['rating'],
    datePosted: DateTime.parse(json['datePosted']),
    imageFilePath: json['imageFilePath'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bookId': bookId,
    'userName': userName,
    'comment': comment,
    'rating': rating,
    'datePosted': datePosted.toIso8601String(),
    'imageFilePath': imageFilePath,
  };
}
