import 'package:flutter/material.dart';
import 'package:movie_api_flutter/homepage.dart';
import 'package:movie_api_flutter/login_page.dart';

void main(){
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}