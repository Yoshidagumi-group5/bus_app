import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

enum PageType {
  home,
  grapth,
}

class PageNotifier extends StateNotifier<PageType> {
  PageNotifier() : super(PageType.home);

  void changePage(PageType pageType) {
    state = pageType;
  }
}

final pageProvider = StateNotifierProvider<PageNotifier, PageType>(
  (ref) => PageNotifier(),
);

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Green House Application")),
        ),
        /*
        body: currentPage == PageType.home
            ? const Center(child: NowInstance())
            : const Center(child: GreenGrapth()),
        */
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage == PageType.home ? 0 : 1,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.graphic_eq_outlined), label: "Grapth")
          ],
          onTap: (index) {
            final pageType = index == 0 ? PageType.home : PageType.grapth;
            ref.read(pageProvider.notifier).changePage(pageType);
          },
        ));
  }
}
