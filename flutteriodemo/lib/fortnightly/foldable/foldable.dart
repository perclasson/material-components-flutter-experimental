import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FortnightlyFoldable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyFoldableHome(),
    );
  }
}

class FortnightlyFoldableHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget horizontalDivider = Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      color: Colors.black.withOpacity(0.1),
      height: 1,
    );
    Widget verticalDivider = Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      color: Colors.black.withOpacity(0.1),
      width: 1,
    );
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 16),
                      child: Image.asset(
                        'assets/fortnightly_title.png',
                        scale: 1.33,
                      ),
                    ),
                    fit: FlexFit.tight,
                  ),
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      height: 32,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          SizedBox(width: 16),
                          Center(
                            child: Text(
                              '#TechDesign',
                              style: textTheme.subtitle,
                            ),
                          ),
                          verticalDivider,
                          Center(
                            child: Text(
                              '#Reform',
                              style: textTheme.subtitle,
                            ),
                          ),
                          verticalDivider,
                          Center(
                            child: Text(
                              '#HealthcareRevolution',
                              style: textTheme.subtitle,
                            ),
                          ),
                          verticalDivider,
                          Center(
                              child: Text(
                            '#GreenArmy',
                            style: textTheme.subtitle,
                          )),
                          verticalDivider,
                          Center(
                              child: Text(
                            '#Stocks',
                            style: textTheme.subtitle,
                          )),
                          verticalDivider,
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 16),
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 32),
                        MenuItem(
                          'Front Page',
                          header: true,
                        ),
                        MenuItem('World'),
                        MenuItem('US'),
                        MenuItem('Politics'),
                        MenuItem('Business'),
                        MenuItem('Tech'),
                        MenuItem('Sciene'),
                        MenuItem('Sports'),
                        MenuItem('Travel'),
                        MenuItem('Culture'),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 2,
                      child: ListView(
                        children: <Widget>[
                          ArticlePreview(
                            imageUrl: 'assets/fortnightly_healthcare.png',
                            category: 'WORLD',
                            title:
                                'The Quiet, Yet Powerful Healthcare Revolution',
                            lead: true,
                          ),
                          horizontalDivider,
                          ArticlePreview(
                            imageUrl: 'assets/fortnightly_war.png',
                            category: 'POLITICS',
                            title: 'Divided American Lives During War',
                          ),
                          horizontalDivider,
                          ArticlePreview(
                            imageUrl: 'assets/fortnightly_gas.png',
                            category: 'TECH',
                            title: 'The Future of Gasoline',
                          ),
                        ],
                      )),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/fortnightly_chart.png'),
                        StockItem(
                          ticker: 'DIJA',
                          price: '7,031.21',
                          percent: -0.48,
                        ),
                        Image.asset('assets/fortnightly_dotted_divider.png'),
                        StockItem(
                          ticker: 'SP',
                          price: '1,967.84',
                          percent: 0.00,
                        ),
                        Image.asset('assets/fortnightly_dotted_divider.png'),
                        StockItem(
                          ticker: 'Nasdaq',
                          price: '6,211.46',
                          percent: 0.52,
                        ),
                        Image.asset('assets/fortnightly_dotted_divider.png'),
                        StockItem(
                          ticker: 'Nikkei',
                          price: '5,891',
                          percent: 1.16,
                        ),
                        Image.asset('assets/fortnightly_dotted_divider.png'),
                        StockItem(
                          ticker: 'DJ Total',
                          price: '89.02',
                          percent: 0.80,
                        ),
                        Image.asset('assets/fortnightly_dotted_divider.png'),
                      ],
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

class MenuItem extends StatelessWidget {
  MenuItem(this.title, {this.header = false});

  final String title;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 64,
            child: header ? null : Icon(Icons.arrow_drop_down),
          ),
          Text(title,
              style: Theme.of(context).textTheme.subhead.copyWith(
                    fontWeight: header ? FontWeight.w900 : FontWeight.w600,
                    fontSize: 18,
                  )),
        ],
      ),
    );
  }
}

class ArticlePreview extends StatelessWidget {
  ArticlePreview({this.imageUrl, this.category, this.title, this.lead = false});

  final String imageUrl;
  final String category;
  final String title;
  final bool lead;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    if (lead) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
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
              style: textTheme.headline.copyWith(fontSize: 20),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                this.category,
                style: textTheme.subhead,
              ),
              SizedBox(height: 12),
              Text(
                this.title,
                style: textTheme.headline.copyWith(fontSize: 16),
              ),
            ]),
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );
    }
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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(ticker, style: textTheme.subhead.copyWith(fontSize: 14)),
          Row(
            children: <Widget>[
              Text(price, style: textTheme.body2.copyWith(color: Colors.black45)),
              Spacer(),
              Text(
                percent > 0 ? '+' : '-',
                style: textTheme.body2.copyWith(
                    color: percent > 0 ? Color(0xff20CF63) : Color(0xff661FFF),
                ),
              ),
              SizedBox(width: 4),
              Text(percent.abs().toStringAsFixed(2) + '%'),
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
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
    ),
    textTheme: textTheme.copyWith(
      // title 2, hashtags
      subtitle: textTheme.subtitle.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      // preview headlines
      headline: textTheme.headline.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w500,
      ),
      // caption 2, category subtitle, stock ticker
      subhead: textTheme.subhead.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w700,
        fontSize: 11,
      )));
}