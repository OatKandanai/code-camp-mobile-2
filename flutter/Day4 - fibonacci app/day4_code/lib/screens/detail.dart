import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final Map<String, dynamic> user;
  const Detail({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 100),
            const SizedBox(height: 30),
            Text('Name : ${user['name']}', style: TextStyle(fontSize: 25)),
            const SizedBox(height: 15),
            Text('Age : ${user['age']}', style: TextStyle(fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
