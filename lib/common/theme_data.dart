import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class MyThemeData{
  static  ThemeData themeData = ThemeData(
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light,statusBarColor: AppColors.mainColor),
        color: AppColors.mainColor,
        titleTextStyle: TextStyle(color: Colors.white),
        elevation: 0
    ),
    scaffoldBackgroundColor: AppColors.mainColor,
    iconTheme: const IconThemeData(color: Colors.white),
    primarySwatch: Colors.blue,
  );
}