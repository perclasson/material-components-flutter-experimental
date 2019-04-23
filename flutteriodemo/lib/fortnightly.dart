import 'package:flutter/material.dart';
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
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.category),
              Text(this.title),
            ]
          ),
          AspectRatio(
            aspectRatio: 1,
            child: image,
          )
        ],
      );
    } else {
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

List<ArticlePreview> _buildArticles() {
  return [
    ArticlePreview(
      image: Image.asset('assets/bird1.jpg'),
      category: 'POLITICS',
      title: 'A Fight For Aging Veterans',
      snippet: 'For those nearing retirement, benefits are not always guaranteed',
    ),
    ArticlePreview(
      image: Image.asset('assets/bird2.jpg'),
      category: 'POLITICS',
      title: 'A Fight For Aging Veterans',
      snippet: 'For those nearing retirement, benefits are not always guaranteed',
    ),
    ArticlePreview(
      image: Image.asset('assets/bird3.jpg'),
      category: 'POLITICS',
      title: 'A Fight For Aging Veterans',
      snippet: 'For those nearing retirement, benefits are not always guaranteed',
    ),
    ArticlePreview(
      image: Image.asset('assets/bird4.jpg'),
      category: 'POLITICS',
      title: 'A Fight For Aging Veterans',
      snippet: 'For those nearing retirement, benefits are not always guaranteed',
    ),
  ];
}

class FortnightlyTabletLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Row(
        children: _buildArticles()
      ),
    );
  }
}

class FortnightlyPhonePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text('Fortnightly'),
      ),
      body: Column(
          children: _buildArticles().map((ArticlePreview p) => SizedBox(height: 80, child: p,)).toList(),
      ),
    );
  }
}