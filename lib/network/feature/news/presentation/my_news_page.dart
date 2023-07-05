import 'package:flutter/material.dart';
import 'package:news_app/network/feature/news/data/news_article.dart';
import 'package:news_app/network/feature/news/presentation/news_details_page.dart';

import '../../network/network_requests.dart';

class MyNewsPage extends StatelessWidget {
  const MyNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Page"),
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await NetworkRequest.fetchNewsData();
        },
        child: FutureBuilder<List<Articles>?>(
            future: NetworkRequest.fetchNewsData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final newsArticle = snapshot.data ?? [];
                return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: newsArticle.length,
                    itemBuilder: (context, index) {
                      final articles = newsArticle[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => NewsDetailsPage(
                                      news: articles,
                                      similarNews: newsArticle))));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    articles.title ?? "",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(articles.description ?? ' '),
                                  Image.network(articles.urlToImage ?? ''),
                                  Text(
                                    articles.content ?? ' ',
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
