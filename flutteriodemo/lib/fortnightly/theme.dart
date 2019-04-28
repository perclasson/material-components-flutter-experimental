
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
        )
      )
  );
}