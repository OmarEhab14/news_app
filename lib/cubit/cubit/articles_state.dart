part of 'articles_cubit.dart';

@immutable
sealed class ArticlesState {}

final class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final List<ArticleModel>? articles;
  ArticlesLoaded({this.articles});
}

class ArticlesFailed extends ArticlesState {
  final String message;
  ArticlesFailed({required this.message});
}