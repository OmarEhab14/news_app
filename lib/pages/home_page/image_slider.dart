import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/pages/article_view.dart';

class BuildImage extends StatelessWidget {
  final String? urlToImage, title, url;
  const BuildImage({this.urlToImage, this.title, this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (contex) => ArticleView(blogUrl: url ?? '')));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        // height: 400.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  urlToImage ?? defaultImageUrl,
                  fit: BoxFit.cover,
                  // width: MediaQuery.of(context).size.width * 0.8,
                  // height: 400.0,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  // height: 70,
                  width: MediaQuery.of(context).size.width * 0.8, // Adjust width based on margin
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(1.0),
                      ],
                    ),
                  ),
                  child: Text(
                    title ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
