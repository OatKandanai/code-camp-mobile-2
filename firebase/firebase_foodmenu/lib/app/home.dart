import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/app/add_menu.dart';
import 'package:flutter_firebase/app/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // collection users
  late CollectionReference<Map<String, dynamic>> menu;
  late Stream<QuerySnapshot> menuStream;

  @override
  void initState() {
    super.initState();
    menu = FirebaseFirestore.instance.collection('menu');
    menuStream = getMenu(); // Default: full list
  }

  // อ่านข้อมูล
  Stream<QuerySnapshot> getMenu() {
    return menu.snapshots();
  }

  // ลบข้อมูล
  Future<void> deleteMenu(String docId) {
    return menu.doc(docId).delete();
  }

  Stream<QuerySnapshot> handleSearch({required String searchInput}) {
    if (searchInput.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('menu')
          .where('menu_name', isGreaterThanOrEqualTo: searchInput)
          .where('menu_name', isLessThan: searchInput + 'ฮ')
          .snapshots();
    }
    return FirebaseFirestore.instance.collection('menu').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Food Menu apply with Firestore")),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Column(
          children: [
            TextField(
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
                setState(() {
                  menuStream = handleSearch(searchInput: value);
                });
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: menuStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                // return ListView.builder(
                //   itemCount: docs.length,
                //   itemBuilder: (context, index) {
                //     final data = docs[index].data() as Map<String, dynamic>;
                //     return ListTile(
                //       leading: CircleAvatar(child: Text("${data['age']}")),
                //       title: Text(data['name']),
                //       subtitle: Text("${data['email']}"),
                //       trailing: IconButton(
                //         onPressed: () => deleteMenu(docs[index].id),
                //         icon: Icon(Icons.delete),
                //       ),
                //     );
                //   },
                // );

                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      String chefName = data['chef']['name'];
                      String menuName = data['menu_name'];
                      String ingredients = data['ingredients'];
                      String foodImage = data['image_url'];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => Details(
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
                                child: SizedBox(
                                  height: 250,
                                  child: Image.network(
                                    foodImage,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child:
                                                const CircularProgressIndicator(),
                                          );
                                        },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error_outline),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: docs.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (_) => AddUserScreen(users: users)),
      //     );
      //   },
      // ),
    );
  }
}
