import 'package:flutter/material.dart';
import 'package:movies_app/providers/people_view_model.dart';
import 'package:movies_app/services/dependency_injection_service.dart';
import 'package:movies_app/views/people_view.dart';
import 'package:provider/provider.dart';
import 'common/theme_data.dart';

void main() {
  DependencyInjection().setup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => PeopleViewModel(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.themeData,
      home: const PeopleScreen(),
    );
  }
}
