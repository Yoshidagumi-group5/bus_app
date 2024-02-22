import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// SearchResult(仮)
class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.text});

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return text;
  }
}

const List<Widget> routes = <Widget>[
  Text('ルート１'),
  Text('ルート２'),
  Text('ルート３')
];

final routeProvider = StateProvider<List<bool>>(
  (ref) => <bool>[true, false, false],
);
final routeWidgetProvider = StateProvider<Widget>(
  (ref) => Route(route: routes[0]),
);


const List<Widget> options = <Widget>[
  Text('アラーム'),
  Text('マップ')
];

final optionProvider = StateProvider<List<bool>>(
  (ref) => <bool>[true, false],
);

final optionWidgetProvider = StateProvider<Widget>(
  (ref) => Alarm(text: routes[0]),
);


class BusRegistration extends ConsumerWidget {
  const BusRegistration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeWidgets = routes.map((route) => Route(route: route)).toList();

    final route = ref.watch(routeProvider);
    final routeWidget = ref.watch(routeWidgetProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'バス登録',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                ref.read(routeProvider.notifier).state =
                    List.generate(route.length, (i) => i == index);
                ref.read(routeWidgetProvider.notifier).state = routeWidgets[index];

                // ルートを切り替える時、optionWidgetはアラームを表示させる
                ref.read(optionProvider.notifier).state = [true, false];
                ref.read(optionWidgetProvider.notifier).state = Alarm(text: routes[index]);
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              // selectedBorderColor: Colors.blue,
              selectedColor: Colors.black,
              fillColor: Colors.blue[300],
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: route,
              children: routes,
            ),
            routeWidget,
          ],
        ),
      ),
    );
  }
}

// 各ルートを表示するためのウィジェット
class Route extends ConsumerWidget {
  const Route({super.key, required this.route});

  final Widget route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionWidgets = <Widget>[Alarm(text: route), RouteMap(text: route)];

    // final optionWidgetProvider = StateProvider<Widget>(
    //   (ref) => optionWidgets[0],
    // );

    final option = ref.watch(optionProvider);
    final optionWidget = ref.watch(optionWidgetProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            color: Colors.black38,
            width: double.infinity,
            height: 200,
            child: SearchResult(text: Text('検索結果')),  // SearchResult(仮)
          ),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              ref.read(optionProvider.notifier).state =
                  List.generate(option.length, (i) => i == index);
              ref.read(optionWidgetProvider.notifier).state = optionWidgets[index];
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedColor: Colors.black,
            fillColor: Colors.blue[300],
            color: Colors.black,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: option,
            children: options,
          ),
          optionWidget,
          // RouteMap(text: route),
        ],
      ),
    );
  }
}


final alarmToggleProvider = StateProvider(
  (ref) => false,
);

// 各ルートのアラームウィジェット
class Alarm extends ConsumerWidget {
  // バス停の情報を取得するための引数を追加する
  const Alarm({super.key, required this.text});

  final Widget text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmToggle = ref.watch(alarmToggleProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'バス到着アラーム',
              style: const TextStyle(fontSize: 25),
            ),
            Switch(
              value: alarmToggle,
              onChanged: (bool value) {
                ref.read(alarmToggleProvider.notifier).state = value;
              },
            ),
          ],
        ),
        Container(
          color: Colors.black38,
          width: 360,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'バス到着まで　あと',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '10',
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    '分',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Text(
                'バス現在地　どこどこ',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '寝落ち防止アラーム',
              style: const TextStyle(fontSize: 25),
            ),
            Switch(
              value: false,
              onChanged: (value) {
              },
            ),
          ],
        ),
        Container(
          color: Colors.black38,
          width: 360,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                          text,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(Icons.south),
                      ),
                      Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                          text,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(Icons.south),
                      ),
                      Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                          text,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(Icons.south),
                      ),
                      Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                          text,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(Icons.south),
                      ),
                      Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                          text,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(Icons.south),
                      ),
                      Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                          text,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Icon(Icons.south),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 各ルートのマップウィジェット
class RouteMap extends ConsumerWidget {
  // バスのルートを取得する引数を追加する
  const RouteMap({super.key, required this.text});

  final Widget text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: text);
  }
}