import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'MovieModel.dart';

Future<Moviemodel> fetchMovie() async {
  final response = await http.get(
    Uri.parse("http://127.0.0.1:8080/api/v3/movies"), 
  );

  if (response.statusCode == 200) {
    return Moviemodel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Loading Failed !!");
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie API Test")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black,
          child: ElevatedButton(
            onPressed: (){
              // fetchMovie().then(value){
              //   print(value.id);
              //   print(value.backdrops);
              //   print(value.genres);
              //   print(value.imdbId);
              //   print(value.poster);
              //   print(value.releaseDate);
              //   print(value.reviewIds);
              //   print(value.title);
              //   print(value.trailerLink);
              // }

              fetchMovie();


              

              
              

            },
            child: Text("API"),
          )
        ),
      ),
    );
  }
}