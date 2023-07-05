import 'package:flutter/material.dart';
import 'package:news_app/network/feature/news/presentation/my_news_page.dart';
//import 'package:news_app/network/my_news_page.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyNewsPage(),
    );
  }
}
