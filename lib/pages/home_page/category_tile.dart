import 'package:flutter/material.dart';
class CategoryTile extends StatelessWidget {
  final String? image, categoryName;
  const CategoryTile({this.image, this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: Stack(
        children: [
          Image.asset(
            image ?? 'images/default_image.jpg',
            width: 150,
            height: 70,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Container(
                color: const Color(0xFF000000),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                categoryName ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}