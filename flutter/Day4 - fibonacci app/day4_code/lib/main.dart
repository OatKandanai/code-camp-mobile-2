import 'package:day4_code/screens/detail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> newData = [];
  late List<bool> isTaps = [];

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    data = [
      {'name': 'Jojo', 'age': 40},
      {'name': 'Jotaro', 'age': 30},
      {'name': 'Josuke', 'age': 16},
      {'name': 'Joseph', 'age': 60},
      {'name': 'Giorno', 'age': 19},
      {'name': 'Jolyne', 'age': 20},
      {'name': 'Johnny', 'age': 23},
      {'name': 'Jonathan', 'age': 35},
      {'name': 'Dio', 'age': 100},
      {'name': 'Pucci', 'age': 45},
    ];
    newData = List.from(data);
    isTaps = List<bool>.generate(data.length, (_) => false);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('my app', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward_outlined),
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: Duration(seconds: 1),
            curve: Curves.linear,
          );
        },
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              label: const Text('Name'),
              prefixIcon: Icon(Icons.search),
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                newData = data.where((item) {
                  return item['name'].toLowerCase().contains(
                    value.toLowerCase(),
                  );
                }).toList();
              });
            },
          ),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: newData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  leading: const Icon(Icons.catching_pokemon),
                  tileColor: const Color.fromARGB(255, 239, 239, 240),
                  title: Text(
                    newData[index]['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: const Text('Person'),
                  trailing: Icon(
                    Icons.favorite,
                    color: isTaps[index] ? Colors.redAccent : Colors.black,
                  ),
                  onTap: () {
                    setState(() {
                      isTaps[index] = !isTaps[index];
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => Detail(user: newData[index]),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  Container(color: Colors.black, height: 2),
            ),
          ),
        ],
      ),
    );
  }
}
