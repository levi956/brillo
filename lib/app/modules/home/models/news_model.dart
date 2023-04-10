class NewsModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;

  NewsModel({
    this.author,
    this.description,
    this.title,
    this.url,
    this.urlToImage,
  });

  factory NewsModel.fromJson(Map<String, dynamic> key) {
    return NewsModel(
      author: key['author'] ?? '',
      title: key['title'] ?? '',
      description: key['description'] ?? '',
      url: key['url'] ?? '',
      urlToImage: key['urlToImage'] ??
          'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/breaking-news-poster-design-template-d020bd02f944a333be71e17e3a38db24_screen.jpg?ts=1605640286',
    );
  }
}
