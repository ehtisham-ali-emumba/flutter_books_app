class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImageUrl;
  final double price;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImageUrl,
    required this.price,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'].toString(),
      title: json['title'],
      author: json['author'],
      description: json['description'],
      coverImageUrl: json['cover_image_url'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'cover_image_url': coverImageUrl,
      'price': price,
    };
  }
}
