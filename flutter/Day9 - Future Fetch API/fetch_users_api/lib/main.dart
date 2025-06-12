import 'package:flutter/material.dart';
import 'package:fetch_users_api/models/user_model.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  late Future<List<UserModel>> futureUsers;
  late List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  Future<void> refreshUsers() async {
    final newUsers = await fetchUsers();
    setState(() {
      users = newUsers;
    });
  }

  Future<List<UserModel>> fetchUsers() async {
    final dio = Dio();
    final String url = 'https://jsonplaceholder.typicode.com/users';
    Response response = await dio.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<Map<String, dynamic>> usersList = data.cast<Map<String, dynamic>>();
      return usersList.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: FutureBuilder<List<UserModel>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.network(
                  'https://media.tenor.com/EYX1u_zeHXYAAAAM/loading-progress-bar.gif',
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('error : ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('data not found'));
            } else {
              users = snapshot.data!;

              return RefreshIndicator(
                onRefresh: refreshUsers, // on refresh
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple.shade100,
                          child: Text(
                            user.id.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          user.email,
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: const Icon(
                          Icons.account_circle,
                          color: Colors.deepPurple,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                ),
              );
            }
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
