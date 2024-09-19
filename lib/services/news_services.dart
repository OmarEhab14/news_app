import 'package:dio/dio.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/articles_list_model.dart';

class NewsApi {
  final Dio dio = Dio();
  Future<List<ArticleModel>> fetchArticles({String? category}) async {
    try {
      Response response = await dio.get('$baseUrl/v2/top-headlines?country=us${category==null?'':'&category=$category'}&apiKey=$apiKey');
        var data = response.data;
        ArticlesListModel articles = ArticlesListModel.fromJson(data);
        List<ArticleModel> articleList = articles.articleList.map((e) => ArticleModel.fromJson(e)).toList();
        return articleList;
      
    } catch (e) {
      // if(e.response != null) {
      //   if (e.response!.statusCode == 404) {
      //     log('Error 404');
      //   }
      // }
      // switch (e.type) {
      //   case DioExceptionType.connectionError:
      //     log('connection error');
      //     break;
      //   case DioExceptionType.badResponse:
      //     log('Bad response');
      //     break;
      //   default:
      //     String errMsg = e.response?.data['message'] ?? 'Null message';
      //     log(errMsg);
      // }
      // throw Exception(e);
      rethrow;
    }
  }

  Future<List<ArticleModel>> fetchArticlesByCategory(String category) async {
    try {
      Response response = await dio.get('$baseUrl/v2/top-headlines?country=us&category=$category&apiKey=$apiKey');
      if (response.statusCode == 200) {
        var data = response.data;
        ArticlesListModel articles = ArticlesListModel.fromJson(data);
        List<ArticleModel> articleList = articles.articleList.map((e) => ArticleModel.fromJson(e)).toList();
        return articleList;
      } else {
        print('Status code: ${response.statusCode}');
        return [];
      }
    } catch (ex) {
      print(ex);
      return [];
    }
  }
}
