import 'package:bus_app/pages/example.dart';
import 'package:bus_app/pages/example2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_app/pages/google_map_from_navi.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  example1,
  example2,
  maps,
}

class BottomNavigationNotifier extends Notifier<PageType> {
  @override
  build() {
    return PageType.example1;
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
      case PageType.example1:
        bodyWidget = const ExamplePage1();
        break;
      case PageType.example2:
        bodyWidget = const ExamplePage2();
        break;
      case PageType.maps:
        bodyWidget = const GoogleMapsNavi();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Bus App")),
      ),
      body: bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: PageType.values.indexOf(currentPage),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.expand),
            label: 'Example',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand_circle_down),
            label: 'Example2',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Maps")
        ],
        onTap: (index) {
          final pageType = PageType.values[index];
          ref.read(pageProvider.notifier).changePage(pageType);
        },
      ),
    );
  }
}
