import 'package:dio/dio.dart';
import 'package:firebase_cat_api_2/model/cat_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CatModel> _cats = [];
  late ScrollController _scrollController;
  late bool _isLoading;
  late bool _isAtTop;
  // late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _isAtTop = _scrollController.offset <= 0;
      });
    });
    _isAtTop = true;
    // _selectedIndex = 0;
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

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
        List<CatModel> newCats = catList
            .map((e) => CatModel.fromJson(e))
            .toList();

        setState(() {
          _cats.addAll(newCats);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error : $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollToTopOrBottom() {
    if (_isAtTop) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _isLoading ? null : _fetchData,
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black,
                    ),
                  )
                : const Text('Fetch'),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _scrollToTopOrBottom,
            child: Icon(_isAtTop ? Icons.arrow_downward : Icons.arrow_upward),
          ),
        ],
      ),
      body: ListView.separated(
        controller: _scrollController,
        itemBuilder: (context, index) {
          final imageUrl = _cats[index].url;
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: _cats.length,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Profile',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blueAccent,
      //   onTap: (int index) async {
      //     switch (index) {
      //       case 0:
      //         context.go('/home');
      //         break;
      //       case 1:
      //         context.go('/profile');
      //         break;
      //       case 2:
      //         await FirebaseAuth.instance.signOut();
      //         context.go('/');
      //         break;
      //     }
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
    );
  }
}
