import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'MY APP', home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum Action { increment, decrement }

class _HomeState extends State<Home> {
  int _count = 0;

  void setCount(action) {
    setState(() {
      switch (action) {
        case Action.increment:
          _count++;
          break;
        case Action.decrement:
          _count == 0 ? _count = 0 : _count--;
          break;
      }
    });
  }

  WidgetStateProperty<Color> changeBtnBgColor(
    Color normalColor,
    Color pressedColor,
  ) {
    return WidgetStateProperty.resolveWith((state) {
      return state.contains(WidgetState.pressed) ? pressedColor : normalColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color dyanmicColor =
        _count % 2 == 0
            ? Colors.yellowAccent
            : const Color.fromARGB(255, 228, 167, 187);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _count % 2 == 0 ? 'QUACK!' : 'MEOW!',
          style: const TextStyle(fontSize: 24, color: Colors.deepOrange),
        ),
        centerTitle: true,
        backgroundColor: dyanmicColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              _count % 2 == 0
                  ? 'https://cdn.displate.com/artwork/857x1200/2024-06-10/7954aa70da0f3f01f3460093d9b153ea_840742d0017aa7a836d830a60d7c4a9a.jpg'
                  : 'https://img.freepik.com/premium-vector/simple-flat-illustration-strange-cat-meme_766069-10.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed button this many times:',
              style: TextStyle(
                fontSize: 20,
                color: dyanmicColor,
                shadows: const [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text('$_count', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: changeBtnBgColor(
                      dyanmicColor,
                      Colors.lightBlue,
                    ),
                  ),
                  onPressed: () => setCount(Action.increment),
                  child: const Icon(Icons.thumb_up),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: changeBtnBgColor(
                      dyanmicColor,
                      Colors.lightBlue,
                    ),
                  ),
                  onPressed: () => setCount(Action.decrement),
                  child: const Icon(Icons.thumb_down),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
