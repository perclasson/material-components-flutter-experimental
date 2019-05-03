import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FortnightlyCounterClose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyCounterCloseHome(),
    );
  }
}

class FortnightlyCounterCloseHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget verticalDivider = Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      color: Colors.black.withOpacity(0.2),
      width: 1,
      height: 480,
    );
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
            child: Container(
          padding: EdgeInsets.only(left: 32),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset('assets/fortnightly_title.png'),
                  SizedBox(
                    width: 96,
                    height: 96,
                    child: Icon(Icons.search, size: 32,),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ArticlePreview(
                      imageUrl: 'assets/fortnightly_dining.png',
                      category: 'POLITICS',
                      title: 'Modern Dining Rituals For Singles',
                      snippet:
                          'From the chef\'s table to restaurants for singles, modern cusine gets creative',
                    ),
                    verticalDivider,
                    ArticlePreview(
                      imageUrl: 'assets/fortnightly_poverty.png',
                      category: 'US',
                      title: 'Poverty To Empowerment In Chicago',
                      snippet:
                          'How one woman is transforming the lives of underprivileged children',
                    ),
                    verticalDivider,
                    ArticlePreview(
                      imageUrl: 'assets/fortnightly_veterans.png',
                      category: 'POLITICS',
                      title: 'A Fight For Aging Veterans',
                      snippet: 'For those nearing retirement, benefits are not always guaranteed',
                    ),
                    verticalDivider,
                    Container(
                      width: 224,
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/fortnightly_chart_tv.png'),
                          StockItem(
                            ticker: 'DIJA',
                            price: '7,031.21',
                            percent: -0.48,
                          ),
                          StockItem(
                            ticker: 'SP',
                            price: '1,967.84',
                            percent: 0.00,
                          ),
                          StockItem(
                            ticker: 'Nasdaq',
                            price: '6,211.46',
                            percent: 0.52,
                          ),
                          StockItem(
                            ticker: 'Nikkei',
                            price: '5,891',
                            percent: 1.16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class ArticleData {
  ArticleData({this.imageUrl, this.category, this.title, this.snippet});

  final String imageUrl;
  final String category;
  final String title;
  final String snippet;
}


class ExpandedArticlePreview extends StatelessWidget   {
  ExpandedArticlePreview({this.data});

  final ArticleData data;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: 224,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Image.asset(
              data.imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 12),
          Text(
            data.category,
            style: textTheme.subhead,
          ),
          SizedBox(height: 12),
          Text(
            data.title,
            style: textTheme.headline,
          ),
          SizedBox(height: 4),
          Text(
            data.snippet,
            style: textTheme.body1,
          ),
        ],
      ),
    );
  }
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
          Text(ticker, style: textTheme.subhead),
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
