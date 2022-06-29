import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/common/app_colors.dart';
import 'package:movies_app/my_app.dart';
import 'package:movies_app/repositories/people_repo.dart';
import 'package:movies_app/services/dependency_injection_service.dart';

import 'common/theme_data.dart';

void main() {
  DependencyInjection().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PeopleRepository().getPopularPeople();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.themeData,
      home: const MoviesApp(),
    );
  }
}
