import 'package:flutter/material.dart';

class Cat extends StatelessWidget {
  final String image;
  const Cat({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(image, style: TextStyle(fontSize: 15))),
      body: Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
