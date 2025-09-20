import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_api_flutter/homepage.dart';
import 'package:movie_api_flutter/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  Future<void> _login() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final url = Uri.parse("http://localhost:8081/api/auth/signin");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "username": usernameController.text,
          "password": passwordController.text,
        }),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Homepage()),
        );
      } else {
        setState(() {
          errorMessage = "Invalid username or password.";
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to connect to the server.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Back"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Username",
                filled: true,
                fillColor: Colors.yellow,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration:  InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.yellow,
              ),
            ),
            

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> SignUpPage() ));

            }, child: Text("Go to the rasigter page")),
             SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading)
              ElevatedButton(
                onPressed: _login,
                child: const Text("Submit"),
              ),
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ]
          ],
        ),
      ),
    );
  }
}