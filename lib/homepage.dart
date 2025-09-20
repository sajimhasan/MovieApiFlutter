import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_api_flutter/player.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> movies = [];

  Future<void> fetchMovie() async {
    final url = Uri.parse("http://192.168.100.6:8080/api/v3/movies");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("API works perfectly");
      final jsondata = jsonDecode(response.body);
      final movieslist = jsondata as List;

      setState(() {
        movies = movieslist;
      });
    } else {
      print("Failed to fetch movies");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal Netflix"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Movies Available: ${movies.length}'),

            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.black),
                        child: InkWell(
                          onTap: () {
                            final backdrops = movies[index]["backdrops"];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VideoPlayerPage(
                                  trailerUrl: movies[index]["trailerLink"],
                                  backdrop: backdrops != null
                                      ? List<String>.from(backdrops)
                                      : [],
                                ),
                              ),
                            );
                          },
                          child: Image.network(movies[index]["poster"]),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movies[index]["title"] ?? "NO title",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Tags: ${movies[index]["genres"]}"),
                            Text(
                              "Relase Date: ${movies[index]["releaseDate"]}",
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
