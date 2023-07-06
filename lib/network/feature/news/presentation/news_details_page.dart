import 'package:flutter/material.dart';
import 'package:news_app/network/feature/news/data/news_article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsPage extends StatelessWidget {
  final Articles news;
  final List<Articles> similarNews;

  const NewsDetailsPage({required this.news, required this.similarNews});
  @override
  Widget build(BuildContext context) {
    final remainingNews =
        similarNews.where((element) => element.title != news.title).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          news.title ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                news.title ?? "",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(news.description ?? ' '),
              const SizedBox(
                height: 16,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(news.urlToImage ?? '')),
              const SizedBox(
                height: 16,
              ),
              Text(
                news.content ?? ' ',
                maxLines: 10,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Check Full News at",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {
                    _launchUrl(news.url ?? '');
                  },
                  child: Text(news.url ?? '')),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text(
                    "Similar News",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: (Colors.red)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: remainingNews.length,
                  itemBuilder: (context, index) {
                    final similarArticles = remainingNews[index];
                    return Column(
                      children: [
                        Text(
                          similarArticles.title ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(similarArticles.description ?? ' '),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
