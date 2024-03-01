import 'package:bus_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
