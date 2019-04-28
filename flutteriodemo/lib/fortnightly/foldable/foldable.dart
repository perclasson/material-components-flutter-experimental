import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_flutter_io19/fortnightly/phone_portrait/phone_portrait.dart';

import '../theme.dart';

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
      color: Colors.black.withOpacity(0.2),
      height: 1,
    );
    Widget verticalDivider = Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      color: Colors.black.withOpacity(0.2),
      width: 1,
    );
    TextTheme textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
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
                            price: '7,031.211',
                            percent: -0.48,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(ticker, style: textTheme.subhead.copyWith(fontSize: 14)),
        Row(
          children: <Widget>[
            Text(price),
            Spacer(),
            Text(
              percent > 0 ? '+' : '-',
              style: textTheme.body2.copyWith(color: percent > 0 ? Colors.greenAccent : Colors.red),
            ),
            SizedBox(width: 8),
            Text(percent.abs().toStringAsFixed(2)),
          ],
        )
      ],
    );
  }

}
