import 'package:flutter/material.dart';
import 'package:AwwWallpapers/views/home_page_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aww Wallpapers",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomeView(),
    );
  }
}
