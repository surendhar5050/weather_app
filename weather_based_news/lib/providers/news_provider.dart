import 'package:flutter/material.dart';
import 'package:weather_based_news/models/news_model.dart';
import 'package:weather_based_news/services/news_services.dart';

class NewsScreenProvider extends ChangeNotifier {
  String _selectedCategory = 'Headlines';

  NewsData? news;
  final List<String> _category = [
    'Headlines',
    'Entertainment',
    'General',
    'health',
    'Science',
    'sports',
    'Technology '
  ];

  String get selectedCategory => _selectedCategory;
  List<String> get category => _category;

  void updateCategory(String newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }

  getNews(String category) async {
    news = null;
    final newsHeadlines =
        await NewsRepository().fetchHeadlineNews(category: category);

    news = newsHeadlines;

    notifyListeners();
  }
}
