import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Fibonacci'),
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
  List<BigInt> createFibonacci(int n) {
    List<BigInt> fib = [BigInt.zero, BigInt.one];
    for (int i = 2; i < n; i++) {
      fib.add(fib[i - 1] + fib[i - 2]);
    }
    return fib;
  }

  late ScrollController _scrollController;
  late final List<BigInt> fibList;

  @override
  void initState() {
    _scrollController = ScrollController();
    fibList = createFibonacci(100);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(widget.title),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 1200),
            curve: Curves.linear,
          );
        },
        child: const Icon(Icons.arrow_upward_rounded),
      ),
      body: ListView.separated(
        controller: _scrollController,
        itemCount: fibList.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.lightBlueAccent,
            leading: const Icon(Icons.check),
            title: Text('fibonacci ${index + 1} : ${fibList[index]}'),
            trailing: Text(
              'Even : ${fibList[index].isEven ? true : false}',
              style: const TextStyle(color: Color.fromARGB(255, 206, 61, 61)),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 30),
      ),
    );
  }
}
