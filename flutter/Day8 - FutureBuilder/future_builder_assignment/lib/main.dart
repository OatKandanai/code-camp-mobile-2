import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_builder_assignment/models/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Users List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<User>> users;

  Future<List<User>> loadAsset() async {
    await Future.delayed(Duration(seconds: 5));
    final String jsonString = await rootBundle.loadString('assets/users.json');
    final List<dynamic> rawList = jsonDecode(jsonString);
    final List<Map<String, dynamic>> usersList = rawList
        .cast<Map<String, dynamic>>();
    return usersList.map((e) => User.fromJson(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    users = loadAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: users,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.network(
                  'https://miro.medium.com/v2/resize:fit:1400/0*4Gzjgh9Y7Gu8KEtZ.gif',
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error : ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Users not found'));
            } else {
              final usersList = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    key: ValueKey(index),
                    leading: Text('${usersList[index].id}'),
                    title: Text(usersList[index].name),
                    subtitle: Text(usersList[index].email),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh, color: Colors.black),
      ),
    );
  }
}
