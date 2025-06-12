import 'package:flutter/material.dart';
import 'package:mini_project/app/data/data.dart';
import 'package:mini_project/screens/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _textEditingController;
  late List<Map<String, dynamic>> foodsMenu = [];
  late List<Map<String, dynamic>> newfoodsMenu = [];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    foodsMenu = jsonData["thai_foods"];
    newfoodsMenu = List.from(foodsMenu);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, size: 20),
                hintText: 'ค้นหาอาหาร',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  newfoodsMenu = foodsMenu.where((item) {
                    return item['menu_name'].contains(value);
                  }).toList();
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  String chef = newfoodsMenu[index]['chef']['name'];
                  String menuName = newfoodsMenu[index]['menu_name'];
                  String image = newfoodsMenu[index]['image_url'];
                  String ingredients = newfoodsMenu[index]['ingredients'];

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => Detail(
                              image: image,
                              menuName: menuName,
                              chef: chef,
                              ingredients: ingredients,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 250,
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chef,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 93, 93, 93),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    menuName,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    ingredients,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 250,
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: newfoodsMenu.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
