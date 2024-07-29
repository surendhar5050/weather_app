import 'dart:convert';

import 'package:weather_based_news/utils/time_stamp_convertion.dart';

NewsData newsDataFromJson(String str) => NewsData.fromJson(json.decode(str));

class NewsData {
  String status;
  int totalResults;
  List<Article> articles;

  NewsData({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );
}

class Article {
  String author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  String publishedAtdate;
  String publishedAtTime;
  String? content;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAtdate,
    required this.publishedAtTime,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"] ?? 'Author Name',
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAtTime: TimeStampConvertion.getNewstime(json["publishedAt"]),
        publishedAtdate: TimeStampConvertion.getNewsdate(json["publishedAt"]),
        content: json["content"],
      );
}
