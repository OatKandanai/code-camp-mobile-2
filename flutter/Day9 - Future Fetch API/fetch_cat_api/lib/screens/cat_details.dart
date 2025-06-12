import 'package:flutter/material.dart';

class CatDetails extends StatelessWidget {
  final String image;
  const CatDetails({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(image, style: TextStyle(fontSize: 15))),
      body: InteractiveViewer(
        panEnabled: true,
        minScale: 0.5,
        maxScale: 4,
        child: Image.network(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
