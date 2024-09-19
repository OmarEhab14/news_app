import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/pages/article_view.dart';

class BlogTile extends StatelessWidget {
  final String? imageUrl, title, description, url;
  const BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.url,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (contex) => ArticleView(blogUrl: url ?? '')));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Material(
          color: const Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(15.0),
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        imageUrl ?? defaultImageUrl,
                        height: 120,
                        width: 150,
                        fit: BoxFit.cover,
                      )),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    // height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          title ?? 'title not found',
                          maxLines: 3,
                          style: GoogleFonts.merriweather(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          maxLines: 3,
                          description ?? '',
                          style: GoogleFonts.merriweather(
                            textStyle: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
