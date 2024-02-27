import 'package:bus_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/okica.dart';
import 'pages/readOkica.dart';

Future<void> main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 232, 174),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

// page追加時にはここに追加
enum PageType {
  homePage,
  okica,
  readOkica,
}

class BottomNavigationNotifier extends Notifier<PageType> {
  @override
  build() {
    return PageType.homePage;
  }

  void changePage(PageType pageType) {
    state = pageType;
  }
}

final pageProvider = NotifierProvider<BottomNavigationNotifier, PageType>(
  BottomNavigationNotifier.new,
);

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageProvider);

    Widget bodyWidget;
    switch (currentPage) {
      case PageType.homePage:
        bodyWidget = const HomePage();
        break;
      case PageType.okica:
        bodyWidget = const Okica();
        break;

      case PageType.readOkica:
        bodyWidget = const ReadOkica();
        break;
    }

    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFFBD2B2A),
        currentIndex: PageType.values.indexOf(currentPage),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand_circle_down),
            label: 'okica',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand_circle_down),
            label: 'readOkica',
          ),
        ],
        onTap: (index) {
          final pageType = PageType.values[index];
          ref.read(pageProvider.notifier).changePage(pageType);
        },
      ),
    );
  }
}
