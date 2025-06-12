import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String image;
  final String menuName;
  final String chef;
  final String ingredients;
  const Detail({
    super.key,
    required this.image,
    required this.menuName,
    required this.chef,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียด'), centerTitle: true),
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
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuName,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'โดย $chef',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 105, 104, 104),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    ingredients,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 105, 104, 104),
                    ),
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
