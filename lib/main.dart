import 'package:flutter/material.dart';

import 'pages/page_main.dart';
import 'pages/page_general.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cute Shrew',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MainPage(),
        routes: {
          // '/': (context) => MainPage(),
          '/general': (context) => GeneralPage()
        });
  }
}
