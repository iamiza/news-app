import 'package:dio/dio.dart';
import 'package:news_app/network/feature/news/data/news_article.dart';

class NetworkRequest {
  static Future<List<Articles>?> fetchNewsData() async {
    const apiKey = 'a54cbe3ae3444efd9733a4bac98c4262';
    const url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";
    final dio = Dio();
    final response = await dio.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return NewsArticle.fromJson(response.data).articles ?? [];
      // final jsonData = response.data;
      // final articles = jsonData["articles"];
      // return articles;
    } else {
      return [];
    }
  }
}
