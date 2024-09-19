import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_services.dart';

class ArticleListViewModel {
  List<ArticleModel> _articleList = [];
  List<ArticleModel> _articleListByCategory = [];
  fetchArticles() async {
    NewsApi news = NewsApi();
    _articleList = await news.fetchArticles();
  }
  fetchArticlesByCategory(String category) async {
    NewsApi news = NewsApi();
    _articleListByCategory = await news.fetchArticlesByCategory(category);
  }
  List<ArticleModel> get articleList => _articleList;
  List<ArticleModel> get articleListByCategory => _articleListByCategory;
}