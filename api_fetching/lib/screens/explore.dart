import 'dart:convert';

import 'package:api_fetching/models/article.dart';
import 'package:api_fetching/screens/article_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final TextEditingController _keywordController = TextEditingController();
  String _currentKeyword = "";
  late Future<List<Article>> postsFuture = getPosts(null);

  void _updateKeyword() {
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      _currentKeyword = _keywordController.text;
      postsFuture = getPosts(_currentKeyword);
    });
  }

  static Future<List<Article>> getPosts(String? keyword) async {
    var url = "";
    if (keyword == null || keyword.isEmpty) {
      url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=31a4b02527bd4706b0e4a2a6b1867089";
    } else {
      url = "https://newsapi.org/v2/everything?q=$keyword&apiKey=31a4b02527bd4706b0e4a2a6b1867089";
    }
    var response = await http.get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body)["articles"];
    List<Article> articles = [];
    for (var item in body) {
      try {
        articles.add(Article.fromMap(item));
      } catch (e) {
        continue;
      }
    }
    return articles;
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('E, d\'${suffix(now.day)}\' MMMM y').format(now);
    return formattedDateTime;
  }

  String suffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Text(getCurrentDateTime()),
            const Text(
              "Explore",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _keywordController,
              onEditingComplete: () {
                _updateKeyword();
              },
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2, color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(width: 2, color: Colors.black),
                  ),
                  hintText: "Search for articles",
                  prefixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: postsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.black,
                    ),
                  );
                } else if (snapshot.hasData) {
                  final posts = snapshot.data!;
                  return buildPosts(posts);
                } else {
                  return const Center(
                    child: Text("No data available"),
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }

  Widget buildPosts(List<Article> posts) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetail(article: post),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 247, 247),
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(post.urlToImage),
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          post.author,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
