import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_based_news/models/news_model.dart';
import 'package:weather_based_news/providers/news_provider.dart';
import 'package:weather_based_news/services/news_services.dart';
import 'package:weather_based_news/widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  
  @override
  void initState() {
    super.initState();

    context.read<NewsScreenProvider>().getNews('');
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = context.watch<NewsScreenProvider>();

    return SafeArea(
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            newsProvider.selectedCategory,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            DropdownButton<String>(
              underline: Container(),
              value: newsProvider.selectedCategory,
              items: newsProvider.category.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  context.read<NewsScreenProvider>().updateCategory(newValue);
                      context.read<NewsScreenProvider>().getNews(newValue);

                }
              },
            ),
          ],
        ),
        body: Consumer<NewsScreenProvider>(
          builder: (context, newsScreenProvider, child) {
            if (newsScreenProvider.news == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return newsProvider.news!.articles.isEmpty?Center(child: Text(
            'No News in ${newsScreenProvider.selectedCategory}',
            style: Theme.of(context).textTheme.headlineSmall,
          )
              ,): Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: newsProvider.news!.articles.length,
                  itemBuilder: (context, index) {
                    final article = newsProvider.news!.articles[index];
                    return NewsCard(
                      news: article,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
