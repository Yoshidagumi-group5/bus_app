import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transColorProvider = StateProvider<bool>(
  (ref) => false
);

final futsuColorProvider = StateProvider<bool>(
  (ref) => false
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ホーム',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 229, 255),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined, size: 40),
            onPressed: () {
              // 画面遷移
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CheckButton(
                  text: '乗換あり',
                  provider: transColorProvider
                ),
                CheckButton(
                  text: '普通を外す',
                  provider: futsuColorProvider
                ),
              ],
            ),
            TextButton(
              text: 'じかん',
              textSize: 30,
              width: 300,
              height: 80,
              onPressed: () {
                // 画面遷移
              },
            ),
            TextButton(
              text: 'のるところ',
              textSize: 30,
              width: 300,
              height: 80,
              onPressed: () {
                // 画面遷移
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // 
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 241, 241, 241),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: const Size(120, 50)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.north, size: 30),
                    Icon(Icons.south, size: 30)
                  ],
                ),
              ),
            ),
            TextButton(
              text: 'おりるところ',
              textSize: 30,
              width: 300,
              height: 80,
              onPressed: () {
                // 画面遷移
              },
            ),
            TextButton(
              text: 'しらべる',
              textSize: 30,
              width: 200,
              height: 80,
              onPressed: () {
                // 画面遷移
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  const TextButton({
    super.key,
    required this.text,
    required this.textSize,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  final String text;
  final double textSize;
  final double width;
  final double height;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 241, 241, 241),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: Size(width, height)
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}

class CheckButton extends ConsumerWidget {
  const CheckButton({super.key, required this.text, required this.provider});

  final String text;
  final StateProvider<bool> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(provider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          ref.read(provider.notifier).state = !color;
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color ? Colors.blue : const Color.fromARGB(255, 241, 241, 241),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: const Size(150, 80)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_bus_outlined, size: 40),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}