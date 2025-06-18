import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String image;
  final String menuName;
  final String chef;
  final String ingredients;
  const Details({
    super.key,
    required this.image,
    required this.menuName,
    required this.chef,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียด'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              image,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.error_outline),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(menuName, style: TextStyle(fontSize: 30)),
                  Text(
                    'โดย $chef',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 167, 167, 167),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    ingredients,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
