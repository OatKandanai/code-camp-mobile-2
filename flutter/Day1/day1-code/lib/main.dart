import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Counter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Action { increment, decrement }

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _setCount(action) {
    setState(() {
      switch (action) {
        case Action.increment:
          _counter++;
          break;
        case Action.decrement:
          _counter <= 0 ? 0 : _counter--;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Count', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Text(
              '$_counter',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((state) {
                      if (state.contains(WidgetState.pressed)) {
                        return Colors.white;
                      } else {
                        return Colors.lightBlueAccent;
                      }
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((state) {
                      if (state.contains(WidgetState.pressed)) {
                        return Colors.lightBlueAccent;
                      } else {
                        return Colors.white;
                      }
                    }),
                  ),
                  onPressed: () {
                    _setCount(Action.increment);
                  },
                  child: const Icon(Icons.thumb_up, size: 20),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((state) {
                      if (state.contains(WidgetState.pressed)) {
                        return Colors.white;
                      } else {
                        return Colors.redAccent;
                      }
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((state) {
                      if (state.contains(WidgetState.pressed)) {
                        return Colors.redAccent;
                      } else {
                        return Colors.white;
                      }
                    }),
                  ),
                  onPressed: () {
                    _setCount(Action.decrement);
                  },
                  child: const Icon(Icons.thumb_down, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
