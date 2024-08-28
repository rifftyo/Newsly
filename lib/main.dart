import 'package:flutter/material.dart';
import 'package:news_app/provider/cnn_news_provider.dart';
import 'package:news_app/ui/home_page.dart';
import 'package:provider/provider.dart';
import 'package:news_app/data/api/api_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CnnNewsProvider(apiService: ApiService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newsly App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}