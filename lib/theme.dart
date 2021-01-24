import 'package:flutter/material.dart';
import 'package:fiboeda/constants.dart';

ThemeData fiboTheme = ThemeData.dark().copyWith(
  accentColor: kFiboWhite,
  primaryColor: kFiboRed,
  appBarTheme: AppBarTheme(
    color: kFiboBlack,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: kFiboRed,
    ),
    backgroundColor: kFiboBlack,
  ),
);
