class Article {
  String? author;
  String? title;
  String? description;
  String? content;
  String? urlToImage;
  String? publishedAt;

  Article.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
  }
}
