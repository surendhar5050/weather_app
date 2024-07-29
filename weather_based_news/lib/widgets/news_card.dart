import 'package:flutter/material.dart';
import 'package:weather_based_news/models/news_model.dart';
import 'package:weather_based_news/screens/news_web.dart';
import 'package:weather_based_news/screens/single_news_screen.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news,});
  final Article news;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>SingleNewsScreen(article:news ) ,));

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>NewsWebView(url:news.url ) ,));
      },
      child: Container(
        decoration: BoxDecoration(
            // color: const Color.fromARGB(255, 248, 229, 199),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          children: [
           
            ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child:news.urlToImage  != null
                    ? Image.network(
                        news.urlToImage!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 170,
                      )
                    : 
                    Image.asset(
                      'assets/images/news.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 170,
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
               news.title ,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Divider(thickness: 1, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}