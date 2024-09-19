import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit/articles_cubit.dart';
import 'package:news_app/pages/category_news_page/category_news_tile.dart';

extension StringExtensions on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}

class CategoryNews extends StatefulWidget {
  final String? category;
  const CategoryNews({required this.category, super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  void initState() {
    final articlesCubit = BlocProvider.of<ArticlesCubit>(context);
    articlesCubit.fetchArticles(category: widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category ?? 'all'.capitalize()),
          elevation: 0.0,
        ),
        body: BlocBuilder<ArticlesCubit, ArticlesState>(
            builder: (context, state) {
          if (state is ArticlesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ArticlesLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                String? title = state.articles![index].title;
                String? description = state.articles![index].description;
                String? urlToImage = state.articles![index].urlToImage;
                String? url = state.articles![index].url;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CategoryNewsTile(title: title, description: description, urlToImage: urlToImage, url: url,),
                );
              },
              itemCount: state.articles!.length,
            );
          } else if(state is ArticlesFailed) {
            return Center(child: Text(state.message),);
          } else {
            return const Center(child: Text('Unknown Error'),);
          }
        }));
  }
}
