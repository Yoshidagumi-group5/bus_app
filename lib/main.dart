import 'package:bus_app/pages/example.dart';
import 'package:bus_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/example2.dart';
import 'pages/okica.dart';

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
  example1,
  example2,
  okica,
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
      case PageType.example1:
        bodyWidget = const ExamplePage1();
        break;
      case PageType.example2:
        bodyWidget = const ExamplePage2();
        break;

      case PageType.okica:
        bodyWidget = const Okica();
        break;
    }

    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: PageType.values.indexOf(currentPage),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand),
            label: 'Example',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand),
            label: 'Example2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand_circle_down),
            label: 'okica',
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
