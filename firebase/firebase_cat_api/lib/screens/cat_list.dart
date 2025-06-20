import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cat_api/models/cat_model.dart';
import 'package:firebase_cat_api/screens/login_screen.dart';
import 'package:firebase_cat_api/screens/user_details.dart';
import 'package:flutter/material.dart';

class CatList extends StatefulWidget {
  const CatList({super.key});

  @override
  State<CatList> createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  final List<CatModel> _cats = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (_isLoading) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dio = Dio();
      final String url = 'https://api.thecatapi.com/v1/images/search';
      final Response response = await dio.get(
        url,
        queryParameters: {'limit': 10},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Map<String, dynamic>> catList = data.cast<Map<String, dynamic>>();
        final newCats = catList.map((e) => CatModel.fromJson(e)).toList();

        setState(() {
          _cats.addAll(newCats);
        });
      } else {
        throw Exception('something went wrong');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('fetching api failed : $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cats')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _fetchData,
            child: const Text('Fetch', style: TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserDetails()),
              );
            },
            child: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: _cats.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (context, index) {
                final id = _cats[index].id;
                final imageUrl = _cats[index].url;
                return Container(
                  child: Column(
                    children: [
                      Text('id : $id'),
                      const SizedBox(height: 10),
                      Image.network(imageUrl),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _cats.length,
            ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.account_circle),
              label: const Text('Profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const UserDetails()),
                );
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
