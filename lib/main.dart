import 'package:flutter/material.dart';
import 'package:streamchucknorris/view/chuck_categories_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChuckData Norris',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetChuckCategories(),
    );
  }
}
