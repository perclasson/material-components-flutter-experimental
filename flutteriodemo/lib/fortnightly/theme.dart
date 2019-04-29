import 'package:flutter/material.dart';

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

ThemeData buildTvTheme(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
      ),
      textTheme: textTheme.copyWith(
        // preview headlines
        headline: textTheme.headline.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16,
        ),
        // preview snippet
        body1: textTheme.body1.copyWith(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w300,
          color: Colors.white.withOpacity(0.76),
          fontSize: 12,
        ),
        // caption 2, category subtitle
        subhead: textTheme.subhead.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Colors.white.withOpacity(0.50),
        ),
        // stock ticker
        caption: textTheme.caption.copyWith(
          fontFamily: 'Libre Franklin',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: Colors.white,
        ),
        // Top Highlights, Last Updated...
        title: textTheme.title.copyWith(
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          fontSize: 14,
          color: Colors.white,
        ),
      ));
}
