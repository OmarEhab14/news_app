class ArticlesListModel {
  List<dynamic> articleList;
  
  ArticlesListModel({required this.articleList});

  factory ArticlesListModel.fromJson(Map<String, dynamic> jsonData) {
    return ArticlesListModel(articleList: jsonData['articles']);
  }

}