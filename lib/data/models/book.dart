class Book {
  final String id;
  final String title;
  final String author;
  final int coverImageUrlId;
  final int publishYear;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverImageUrlId,
    required this.publishYear,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['key'],
      title: json['title'],
      author: json['authors'] != null
          ? (json['authors'] as List).map((a) => a['name']).join(', ')
          : 'Unknown',
      coverImageUrlId: json['cover_id'] != null ? json['cover_id'] as int : 0,
      publishYear: json['first_publish_year'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_id': coverImageUrlId,
      'first_publish_year': publishYear,
    };
  }
}
