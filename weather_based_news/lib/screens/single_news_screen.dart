import 'package:flutter/material.dart';
import 'package:weather_based_news/models/news_model.dart';
import 'package:weather_based_news/screens/news_web.dart';

class SingleNewsScreen extends StatelessWidget {
  const SingleNewsScreen({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              // borderRadius:
              //     const BorderRadius.vertical(top: Radius.circular(20)),
              child: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      // height: 170,
                    )
                  : Image.asset(
                      'assets/images/news.png',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      // height: 170,
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${article.publishedAtdate}  ${article.publishedAtTime}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Author name: ${article.author}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              article.description ??
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using , making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for "lorem ipsum" will uncover many web sites still in thei',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the desired page or perform your action here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsWebView(
                            url: article.url,
                          )),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: const Text(
                'Read More',
                style: TextStyle(
                                  fontSize: 18,

                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
