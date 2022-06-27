import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

main() {
  runApp(Api());
}

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  ApiState createState() => ApiState();
}

class ApiState extends State<Api> {
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  late String fullName;
  fetchUser() async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200) {
      var items = json.decode(response.body)['data'];
      setState(() {
        users = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 165, 160, 160),
        title: const Text("API LIST"),
      ),
      body: getBody(),
    ));
  }

  Widget getBody() {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                users[index]['first_name'],
                style: const TextStyle(fontSize: 18, color: Colors.amber),
              ),
            ),
          );
        });
  }
}
