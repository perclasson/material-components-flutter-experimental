import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Tested on Pixel 2
class FortnightlyPhonePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      home: FortnightlyPhonePortraitHome(),
    );
  }
}

class FortnightlyPhonePortraitHomeContent extends StatelessWidget {
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

    return ListView(
      children: <Widget>[
        SizedBox(
          height: 32,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 16),
              Center(
                  child: Text(
                    '#TechDesign',
                    style: textTheme.subtitle,
                  )),
              verticalDivider,
              Center(
                  child: Text(
                    '#Reform',
                    style: textTheme.subtitle,
                  )),
              verticalDivider,
              Center(
                  child: Text(
                    '#HealthcareRevolution',
                    style: textTheme.subtitle,
                  )),
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
        ArticlePreview(
          imageUrl: 'assets/fortnightly_healthcare.png',
          category: 'WORLD',
          title: 'The Quiet, Yet Powerful Healthcare Revolution',
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
    );
  }

}

class FortnightlyPhonePortraitHome extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context)),
                  Image.asset('assets/fortnightly_title.png'),
                ],
              ),
              SizedBox(height: 32),
              MenuItem('Front Page', header: true,),
              MenuItem('World'),
              MenuItem('US'),
              MenuItem('Politics'),
              MenuItem('Business'),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          SizedBox(width: 48, child: Icon(Icons.search)),
        ],
        title: Image.asset('assets/fortnightly_title.png'),
      ),
      body: FortnightlyPhonePortraitHomeContent(),
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
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
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
      // Section header
      title: textTheme.title.copyWith(
        fontFamily: 'Merriweather',
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
      // (title 2), hashtags
      subtitle: textTheme.subtitle.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      // (headline 3) preview headlines
      headline: textTheme.headline.copyWith(
        fontFamily: 'Libre Franklin',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      // (caption 2), category, stock ticker
      subhead: textTheme.subhead.copyWith(
        fontFamily: 'Roboto Condensed',
        fontWeight: FontWeight.w700,
        fontSize: 14,
      )));
}