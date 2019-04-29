import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../theme.dart';

class FortnightlyTv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTvTheme(context),
      home: FortnightlyTvHome(),
    );
  }
}

class FortnightlyTvHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            padding: EdgeInsets.only(left: 32),
            color: Colors.black,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/fortnightly_title_white.png'),
                ),
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text('Top Highlights', style: textTheme.title),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
//                    scrollDirection: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ArticlePreview(
                              imageUrl: 'assets/fortnightly_dining.png',
                              category: 'POLITICS',
                              title: 'Modern Dining Rituals For Singles',
                              snippet:
                                  'From the chef\'s table to restaurants for singles, modern cusine gets creative',
                            ),
                            SizedBox(width: 20),
                            ArticlePreview(
                              imageUrl: 'assets/fortnightly_poverty.png',
                              category: 'US',
                              title: 'Poverty To Empowerment In Chicago',
                              snippet:
                                  'How one woman is transforming the lives of underprivileged children',
                            ),
                            SizedBox(width: 20),
                            ArticlePreview(
                              imageUrl: 'assets/fortnightly_veterans.png',
                              category: 'POLITICS',
                              title: 'A Fight For Aging Veterans',
                              snippet:
                                  'For those nearing retirement, benefits are not always guaranteed',
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 130,
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                      'assets/fortnightly_chart_tv.png'),
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
                            SizedBox(width: 20),
                            ArticlePreview(
                              imageUrl: 'assets/fortnightly_dining.png',
                              category: 'POLITICS',
                              title: 'Modern Dining Rituals For Singles',
                              snippet:
                                  'From the chef\'s table to restaurants for singles, modern cusine gets creative',
                            ),
                            SizedBox(width: 20),
                            ArticlePreview(
                              imageUrl: 'assets/fortnightly_poverty.png',
                              category: 'US',
                              title: 'Poverty To Empowerment In Chicago',
                              snippet:
                                  'How one woman is transforming the lives of underprivileged children',
                            ),
                            SizedBox(width: 20),
                            ArticlePreview(
                              imageUrl: 'assets/fortnightly_veterans.png',
                              category: 'POLITICS',
                              title: 'A Fight For Aging Veterans',
                              snippet:
                                  'For those nearing retirement, benefits are not always guaranteed',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text('Last Updated', style: textTheme.title),
                      ),
                      Opacity(
                        opacity: 0.70,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
//                    scrollDirection: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ArticlePreview(
                                imageUrl: 'assets/fortnightly_dining.png',
                                category: 'POLITICS',
                                title: 'Modern Dining Rituals For Singles',
                                snippet:
                                    'From the chef\'s table to restaurants for singles, modern cusine gets creative',
                              ),
                              SizedBox(width: 20),
                              ArticlePreview(
                                imageUrl: 'assets/fortnightly_poverty.png',
                                category: 'US',
                                title: 'Poverty To Empowerment In Chicago',
                                snippet:
                                    'How one woman is transforming the lives of underprivileged children',
                              ),
                              SizedBox(width: 20),
                              ArticlePreview(
                                imageUrl: 'assets/fortnightly_veterans.png',
                                category: 'POLITICS',
                                title: 'A Fight For Aging Veterans',
                                snippet:
                                    'For those nearing retirement, benefits are not always guaranteed',
                              ),
                              SizedBox(width: 20),
                              Container(
                                width: 132,
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                        'assets/fortnightly_chart_tv.png'),
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
                              SizedBox(width: 20),
                              ArticlePreview(
                                imageUrl: 'assets/fortnightly_dining.png',
                                category: 'POLITICS',
                                title: 'Modern Dining Rituals For Singles',
                                snippet:
                                    'From the chef\'s table to restaurants for singles, modern cusine gets creative',
                              ),
                              SizedBox(width: 20),
                              ArticlePreview(
                                imageUrl: 'assets/fortnightly_poverty.png',
                                category: 'US',
                                title: 'Poverty To Empowerment In Chicago',
                                snippet:
                                    'How one woman is transforming the lives of underprivileged children',
                              ),
                              SizedBox(width: 20),
                              ArticlePreview(
                                imageUrl: 'assets/fortnightly_veterans.png',
                                category: 'POLITICS',
                                title: 'A Fight For Aging Veterans',
                                snippet:
                                    'For those nearing retirement, benefits are not always guaranteed',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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

class ArticlePreview extends StatelessWidget {
  ArticlePreview(
      {this.imageUrl,
      this.category,
      this.title,
      this.snippet,
      this.lead = false});

  final String imageUrl;
  final String category;
  final String title;
  final String snippet;
  final bool lead;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: 132,
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
              Text(price,
                  style: textTheme.caption
                      .copyWith(color: Colors.white.withOpacity(0.75))),
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
