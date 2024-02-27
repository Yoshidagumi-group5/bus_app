import 'package:bus_app/pages/example.dart';
import 'package:bus_app/pages/example2.dart';
import 'package:bus_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/SearchResult.dart';

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
  example1,
  example2,
  SearchResult,
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

      case PageType.SearchResult:
        bodyWidget = const SearchResult();
        break;
    }

    return Scaffold(
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.expand, color: Colors.white),
            label: 'Example',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand, color: Colors.white),
            label: 'Example2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'SearchResult',
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
