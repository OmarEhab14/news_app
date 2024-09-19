import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit/articles_cubit.dart';
import 'package:news_app/pages/category_news_page/category_news.dart';
// import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/home_page/blog_tile.dart';
import 'package:news_app/pages/home_page/category_tile.dart';
import 'package:news_app/pages/home_page/image_slider.dart';
// import 'package:news_app/services/categories_data.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/services/categories_data.dart';
// import 'package:news_app/services/news_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Initializing the categories list
  List<CategoryModel> categories = [];
  // List<ArticleModel> articles = [];
  int activeIndex = 0;
  // bool _loading = true;
  late final articlesCubit;
  @override
  void initState() {
    articlesCubit = BlocProvider.of<ArticlesCubit>(context);
    articlesCubit.fetchArticles();
    categories = getCategories();
    super.initState();
  }

  // getNews() async {
  //   NewsApi newsApi = NewsApi();
  //   articles = await newsApi.fetchArticles();
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/app_logo.png',
          width: 150,
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: //_loading
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     :

          BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ArticlesLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 70.0,
                    child: ListView.separated(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CategoryNews(
                                        category: categories[index]
                                            .categoryName))).then((_) {
                              articlesCubit.fetchArticles();
                            });
                          },
                          child: CategoryTile(
                            categoryName: categories[index].categoryName,
                            image: categories[index].image,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                            width: 10.0); // Space between each tile
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Breaking News!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (contex) =>
                                    const CategoryNews(category: null,)));
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, realIndex) {
                      if (state.articles![index].urlToImage == null) {}
                      return BuildImage(
                        urlToImage: state.articles![index].urlToImage,
                        title: state.articles![index].title,
                        url: state.articles![index].url,
                      );
                    },
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildIndicator(),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Trending News!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18.0),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (contex) =>
                                    const CategoryNews(category: null,)));
                          },
                          child: const Text(
                            'View All',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  //trending news cards
                  SizedBox(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.articles!.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imageUrl: state.articles![index].urlToImage,
                            title: state.articles![index].title,
                            description: state.articles![index].description,
                            url: state.articles![index].url,
                          );
                        }),
                  )
                ],
              ),
            );
          } else if (state is ArticlesFailed) {
            return Center(child: Text(state.message));
          } else {
            return const Center(
              child: Text('Unknown Error'),
            );
          }
        },
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const ScrollingDotsEffect(
          dotWidth: 8.0,
          dotHeight: 8.0,
          activeDotColor: Colors.red,
          // fixedCenter: true,
        ),
      );
}
