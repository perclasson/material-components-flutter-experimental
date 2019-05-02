import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FortnightlyAdaptive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyAdaptiveHome(),
    );
  }
}

class FortnightlyAdaptiveHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final Size size = constraints.biggest;
      final double aspectRatio = size.width / size.height;
      if (aspectRatio < 0.7)
      return Text('test', style: textTheme.headline,);
    });
  }
}

class ArticleData {
  ArticleData({this.imageUrl, this.category, this.title, this.snippet});

  final String imageUrl;
  final String category;
  final String title;
  final String snippet;
}

class ArticlePreview extends StatelessWidget {
  ArticlePreview({this.imageUrl, this.category, this.title, this.snippet, this.lead = false});

  final String imageUrl;
  final String category;
  final String title;
  final String snippet;
  final bool lead;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

//    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
//    }

    return Container(
      width: 224,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 12),
          Text(
            this.category,
            style: textTheme.subhead,
          ),
          SizedBox(height: 12),
          Text(
            this.title,
            style: textTheme.headline,
          ),
          SizedBox(height: 4),
          Text(
            this.snippet,
            style: textTheme.body1,
          ),
        ],
      ),
    );
  }
}

class StockItem extends StatelessWidget {
  StockItem({this.ticker, this.price, this.percent});

  final String ticker;
  final String price;
  final double percent;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(ticker, style: textTheme.caption),
          SizedBox(height: 2),
          Row(
            children: <Widget>[
              Text(price, style: textTheme.caption.copyWith(color: Colors.white.withOpacity(0.75))),
              Spacer(),
              Text(
                percent > 0 ? '+' : '-',
                style: textTheme.caption.copyWith(
                  fontSize: 12,
                  color: percent > 0 ? Color(0xff20CF63) : Color(0xff661FFF),
                ),
              ),
              SizedBox(width: 4),
              Text(
                percent.abs().toStringAsFixed(2) + '%',
                style: textTheme.caption.copyWith(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.75),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}



ThemeData buildTheme(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme.copyWith(
      // preview headlines
      headline: textTheme.headline.copyWith(
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w500,
        fontSize: 24
      ),
      // preview snippet
      body1: textTheme.body1.copyWith(
        fontFamily: 'Merriweather',
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
      // (caption 2), preview category, stock ticker
      subhead: textTheme.subhead.copyWith(
        fontFamily: 'Roboto Condensed',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      )));
}
