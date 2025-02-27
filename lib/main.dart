import 'dart:ui';

import 'package:buddiesgram/pages/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuddiesGram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.black,
        // dialogBackgroundColor: Colors.black,
        // primarySwatch: Colors.grey,
        // cardColor: Colors.white70,
        // accentColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        primarySwatch: Colors.grey,
        cardColor: Colors.white70,
        accentColor: Color(0xffff7a65),
      ),
      home: HomePage(),
    );
  }
}
