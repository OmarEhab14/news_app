import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_services.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {

  ArticlesCubit() : super(ArticlesInitial());

  Future<void> fetchArticles({String? category}) async {
    List<ArticleModel> articles = [];
    NewsApi newsApi = NewsApi();
    try {
      emit(ArticlesLoading());
      articles = await newsApi.fetchArticles(category: category);
      emit(ArticlesLoaded(articles: articles));
    } on DioException catch (e) {
      switch(e.type) {
        case DioExceptionType.badResponse:
          emit(ArticlesFailed(message: 'Bad Response.'));
        case DioExceptionType.connectionTimeout:
          emit(ArticlesFailed(message: 'Connection Timeout.'));
        case DioExceptionType.sendTimeout:
          emit(ArticlesFailed(message: 'Send Timeout.'));
        case DioExceptionType.receiveTimeout:
          emit(ArticlesFailed(message: 'Receive Timeout.'));
        case DioExceptionType.badCertificate:
          emit(ArticlesFailed(message: 'Bad Certificate.'));
        case DioExceptionType.cancel:
          emit(ArticlesFailed(message: 'Cancelled.'));
        case DioExceptionType.connectionError:
          emit(ArticlesFailed(message: 'Connection Error.'));
        case DioExceptionType.unknown:
          emit(ArticlesFailed(message: 'Unknown Error.'));
        default:
          emit(ArticlesFailed(message: 'Unknown Error.'));
      }
      if(e.response!.statusCode == 404) {
        emit(ArticlesFailed(message: 'Error 404'));
      }
    } catch (e) {
      emit(ArticlesFailed(message: 'Unknown Error.'));
    }
  }
}
