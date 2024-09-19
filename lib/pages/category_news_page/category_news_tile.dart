import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/pages/article_view.dart';

class CategoryNewsTile extends StatelessWidget {
  final String? urlToImage, title, description, url;
  const CategoryNewsTile(
      {this.urlToImage, this.title, this.description, this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (contex) => ArticleView(blogUrl: url ?? '')));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.grey, width: 1.0)),
        width: double.infinity,
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13.5),
                    topRight: Radius.circular(13.5)),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    urlToImage ?? defaultImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 130,
              child: Column(
                children: [
                  Text(
                            title ?? 'title not found',
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
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
          ],
        ),
      ),
    );
  }
}
