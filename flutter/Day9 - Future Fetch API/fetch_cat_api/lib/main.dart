import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_fetch_api/models/cat_model.dart';
import 'package:flutter_fetch_api/screens/cat_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<CatModel>> fetchData() async {
    final dio = Dio();
    final String url = 'https://api.thecatapi.com/v1/images/search';
    final Response res = await dio.get(url, queryParameters: {'limit': 10});

    if (res.statusCode == 200) {
      List<dynamic> data = res.data;
      List<Map<String, dynamic>> catList = data.cast<Map<String, dynamic>>();
      return catList.map((e) => CatModel.fromJson(e)).toList();
    } else {
      throw Exception('Something went wrong');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FutureBuilder<List<CatModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error:${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Data not found'));
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final cat = snapshot.data!;
                  final image = cat[index].url;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CatDetails(image: image),
                        ),
                      );
                    },
                    child: Image.network(image),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
