import 'dart:convert';

import 'package:api_fetching/models/article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Layout(),
    );
  }
}

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  Future<List<Article>> postsFuture = getPosts();

  static Future<List<Article>> getPosts() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/everything?q=Apple&from=2024-02-29&sortBy=popularity&apiKey=31a4b02527bd4706b0e4a2a6b1867089");

    var response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body)["articles"];
    return body.where((element) => element.urlToImage != null).map((e) => Article.fromJson(e)).toList();
  }

  int _selectedIndex = 0;
  static TextStyle optionStyle = const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _tab = <Widget>[
    Center(
        child: Text(
      'Implementing',
      style: optionStyle,
    )),
    const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Mon, 5th September 2022"),
        Text(
          "Explore",
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          decoration: InputDecoration(
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
      ],
    ),
    Center(
        child: Text(
      'Implementing',
      style: optionStyle,
    )),
    Center(
        child: Text(
      'Implementing',
      style: optionStyle,
    )),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildPosts(List<Article> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          color: const Color.fromARGB(255, 236, 236, 236),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Image.network(post.urlToImage ??
                      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Fpng%2F21432993-blocked-rubber-stamp&psig=AOvVaw2UhhzP3nt9cEvTl2FQTBxv&ust=1711210536006000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPCp_ZKiiIUDFQAAAAAdAAAAABAE")),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title ?? "",
                      style: const TextStyle(
                        fontSize: 16, // Adjust font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5), // Add some space between title and author
                    Text(
                      'Author: ${post.author ?? ""}',
                      style: const TextStyle(
                        fontSize: 14, // Adjust font size as needed
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: SafeArea(
            child: _selectedIndex == 1
                ? FutureBuilder(
                    future: postsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        final posts = snapshot.data!;
                        return buildPosts(posts);
                      } else {
                        return const Text("No data available");
                      }
                    },
                  )
                : _tab.elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper_sharp), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Personal"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[300],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        onTap: _onItemTapped,
      ),
    );
  }
}
