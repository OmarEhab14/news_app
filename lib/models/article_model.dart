class ArticleModel {
  String? title;
  String? description;
  String? url;
  String? urlToImage;

  ArticleModel({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> jsonData) {
    return ArticleModel(
      title: jsonData['title'],
      description: jsonData['description'],
      url: jsonData['url'],
      urlToImage: jsonData['urlToImage'],
    );
  }
}
