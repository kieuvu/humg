class Article {
  String author;
  String title;
  String description;
  String content;
  String urlToImage;
  String publishedAt;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.content,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      author: map['author'],
      title: map['title'],
      description: map['description'],
      content: map['content'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
    );
  }
}
