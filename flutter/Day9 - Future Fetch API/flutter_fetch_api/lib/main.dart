import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_fetch_api/screens/cat.dart';

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
  Future<List<Map<String, dynamic>>> fetchData() async {
    final dio = Dio();
    final String url = 'https://api.thecatapi.com/v1/images/search';
    final Response res = await dio.get(url, queryParameters: {'limit': 10});

    if (res.statusCode == 200) {
      // res.data is a List<dynamic>.
      // (res.data as List) ensures the cast to List happens first.
      return (res.data as List).cast<Map<String, dynamic>>();
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error:${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Data not found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final cat = snapshot.data!;
                  final image = cat[index]['url'];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => Cat(image: image)),
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
