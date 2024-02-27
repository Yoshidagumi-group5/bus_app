import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bus_app/pages/SearchResult.dart';

final transColorProvider = StateProvider<bool>((ref) => false);

final futsuColorProvider = StateProvider<bool>((ref) => false);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'ホーム',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFBD2B2B),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: const Color(0xFFFFE8AE),
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/images/shisa_touka_trimming.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CheckButton(
                      text: '乗換あり',
                      provider: transColorProvider,
                      iconData: Icons.directions_bus_outlined,
                    )
                  ),
                  Expanded(
                    child: CheckButton(
                      text: '普通を外す',
                      provider: futsuColorProvider,
                      iconData: Icons.trending_up,
                    )
                  ),
                ],
              ),
              TextButton(
                text: 'じかん',
                textSize: 30,
                width: 200,
                height: 70,
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
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                          color: Color.fromARGB(255, 226, 165, 164), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: const Size(120, 50)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.north,
                          size: 30, color: Color.fromARGB(255, 189, 43, 43)),
                      Icon(Icons.south,
                          size: 30, color: Color.fromARGB(255, 189, 43, 43))
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    /** feature/searchResultとマージしたときにコメント外す */
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchResult()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFBD2B2A),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 226, 165, 164), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: const Size(200, 80)),
                  child: const Text(
                    'しらべる',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            backgroundColor: Colors.white,
            side: const BorderSide(
                color: Color.fromARGB(255, 226, 165, 164), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: Size(width, height)),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textSize,
            color: const Color(0xFFBD2B2A),
          ),
        ),
      ),
    );
  }
}

class CheckButton extends ConsumerWidget {
  const CheckButton({
    super.key,
    required this.text,
    required this.provider,
    required this.iconData
  });

  final String text;
  final StateProvider<bool> provider;
  final IconData iconData;

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
            backgroundColor: color ? const Color(0xFFBD2B2A) : Colors.white,
            side: const BorderSide(color: Color(0xFFE2A5A4), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: const Size(150, 80)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
              color: color ? Colors.white : const Color(0xFFBD2B2A),
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: color ? Colors.white : const Color(0xFFBD2B2A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}