import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class Alarm extends StatelessWidget {
  const Alarm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('アラーム');
  }
}

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('マップ');
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('検索結果');
  }
}

const List<Widget> routes = <Widget>[
  Text('ルート１'),
  Text('ルート２'),
  Text('ルート３')
];

const List<Widget> options = <Widget>[
  Text('アラーム'),
  Text('マップ')
];

final routeProvider = StateProvider<List<bool>>(
  (ref) => <bool>[true, false, false],
);

final optionProvider = StateProvider<List<bool>>(
  (ref) => <bool>[true, false]
);

class BusRegistration extends ConsumerWidget {
  BusRegistration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider);
    final option = ref.watch(optionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'バス登録',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              // for (int i = 0; i < route.length; i++) {
              //   route[i] = i == index;
              // }
              ref.read(routeProvider.notifier).state =
                  List.generate(route.length, (i) => i == index);
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
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      color: Colors.black38,
                      width: double.infinity,
                      height: 200,
                      child: SearchResult(),
                    ),
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        ref.read(optionProvider.notifier).state =
                            List.generate(option.length, (i) => i == index);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'バス到着アラーム',
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
                                children: [
                                  Row(
                                    children: [
                                      Switch(
                                        value: false,
                                        onChanged: (value) {
                                        },
                                      ),
                                      Text(
                                        '東風平中学校前',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.south),
                                  Row(
                                    children: [
                                      Switch(
                                        value: false,
                                        onChanged: (value) {
                                        },
                                      ),
                                      Text(
                                        '東風平中学校前',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.south),
                                  Row(
                                    children: [
                                      Switch(
                                        value: false,
                                        onChanged: (value) {
                                        },
                                      ),
                                      Text(
                                        '東風平中学校前',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.south),
                                  Row(
                                    children: [
                                      Switch(
                                        value: false,
                                        onChanged: (value) {
                                        },
                                      ),
                                      Text(
                                        '東風平中学校前',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.south),
                                  Row(
                                    children: [
                                      Switch(
                                        value: false,
                                        onChanged: (value) {
                                        },
                                      ),
                                      Text(
                                        '東風平中学校前',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.south),
                                  Row(
                                    children: [
                                      Switch(
                                        value: false,
                                        onChanged: (value) {
                                        },
                                      ),
                                      Text(
                                        '東風平中学校前',
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
