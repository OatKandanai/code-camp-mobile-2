import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project_foodmenu/app/models/menu_model.dart';
import 'package:mini_project_foodmenu/app/ui/details.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  bool atTop = true;

  late Future<List<Menu>> menu;

  Future<List<Menu>> loadData(String searchInput) async {
    final String jsonString = await rootBundle.loadString('assets/menu.json');
    final List<dynamic> rawList = jsonDecode(jsonString);
    final List<Map<String, dynamic>> menuList =
        rawList.cast<Map<String, dynamic>>();
    return menuList
        .map((e) => Menu.fromJson(e))
        .toList()
        .where((item) => item.menuName.contains(searchInput))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    menu = loadData('');

    // addListener will track the scroll bar position
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset <= 50) {
          atTop = true;
        } else {
          atTop = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // search menu by name
  void search({required String searchInput}) {
    setState(() {
      menu = loadData(searchInput);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            // press the btn to scroll to top or bottom of screen
            if (atTop) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            } else {
              _scrollController.animateTo(
                0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            }
          },
          child: Icon(
            atTop ? Icons.arrow_downward : Icons.arrow_upward,
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'ค้นหาอาหาร',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade500),
                  ),
                ),
                onChanged: (value) {
                  search(searchInput: value);
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Menu>>(
                future: menu,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (asyncSnapshot.hasError) {
                    return Center(child: Text('Error: ${asyncSnapshot.error}'));
                  } else if (!asyncSnapshot.hasData ||
                      asyncSnapshot.data!.isEmpty) {
                    return Center(child: Text('Data not found'));
                  } else {
                    final loadedMenu = asyncSnapshot.data!;
                    return Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          String chefName = loadedMenu[index].chef;
                          String menuName = loadedMenu[index].menuName;
                          String ingredients = loadedMenu[index].ingredients;
                          String foodImage = loadedMenu[index].image;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (ctx) => Details(
                                        image: foodImage,
                                        menuName: menuName,
                                        chef: chefName,
                                        ingredients: ingredients,
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              height: 250,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chefName,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: const Color.fromARGB(
                                                255,
                                                152,
                                                159,
                                                163,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            menuName,
                                            style: TextStyle(fontSize: 28),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            ingredients,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: const Color.fromARGB(
                                                255,
                                                152,
                                                159,
                                                163,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CachedNetworkImage(
                                      height: 250,
                                      fit: BoxFit.cover,
                                      imageUrl: foodImage,
                                      placeholder:
                                          (context, url) =>
                                              CircularProgressIndicator(),
                                      errorWidget:
                                          (context, url, error) =>
                                              Icon(Icons.error),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder:
                            (context, index) => SizedBox(height: 20),
                        itemCount: asyncSnapshot.data!.length,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
