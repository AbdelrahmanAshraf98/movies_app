import 'package:flutter/material.dart';

class MoviesApp extends StatefulWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  State<MoviesApp> createState() => _MoviesAppState();
}

class _MoviesAppState extends State<MoviesApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: const [Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.search),
        )],
      ),
      body: const Center(child: Text('Movies App' ,style: TextStyle(color:Colors.white),),
      ),
    );
  }
}
