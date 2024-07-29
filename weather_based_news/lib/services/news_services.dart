import 'package:http/http.dart' as http;
import 'package:weather_based_news/models/news_model.dart';
import 'package:weather_based_news/utils/api_keys.dart';

class NewsRepository {
  Future<NewsData?> fetchHeadlineNews({String category = ''}) async {

    // print('https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${ApiKeys.newsApiKey}');
    // try {
      final respone = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${ApiKeys.newsApiKey}'));
      if (respone.statusCode == 200) {
        return newsDataFromJson(respone.body);
      } else {
        return null;
      }
    // } catch (e) {

    //   throw Exception(e.toString());
    // }
  }
}
