import 'package:flutter/widgets.dart';

class ArticlePreview extends StatelessWidget {
  ArticlePreview({this.image, this.category, this.title, this.snippet});

  final Image image;
  final String category;
  final String title;
  final String snippet;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    if (size.width < size.height) {
      return Column(
        children: [
          image,
          Text(this.category),
          Text(this.title),
          Text(this.snippet),
        ],
      );
    }
  }
}