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

// バスのルート(仮)
const List<List<String>> routes = [
  ['東風平中学校前', '東風平', '伊覇公民館前', 'あああ', 'いいい', 'ううう', 'えええ', 'おおお'],
  ['豊原', '辺野古', '沖縄高専入口', 'かかか', 'ききき', 'くくく', 'けけけ', 'こここ'],
  ['豊見城平良', '豊見城郵便局前', '住宅前', 'さささ', 'ししし', 'すすす', 'せせせ', 'そそそ'],
  ['豊見城平良', '豊見城郵便局前', '住宅前', 'さささ', 'ししし', 'すすす', 'せせせ', 'そそそ'],
  ['豊見城平良', '豊見城郵便局前', '住宅前', 'さささ', 'ししし', 'すすす', 'せせせ', 'そそそ'],
  ['豊見城平良', '豊見城郵便局前', '住宅前', 'さささ', 'ししし', 'すすす', 'せせせ', 'そそそ'],
];


// 表示するルートを切り替えるためのToggleの状態を管理
final routeToggleProvider = StateProvider<List<bool>>(
  // (ref) => <bool>[true, false, false],
  (ref) {
    final boolList = [true];
    for (int i = 1; i < routes.length; i++) {
      boolList.add(false);
    }
    return boolList;
  }
);
// 表示するルートのウェイジェットの状態を管理
final routeWidgetProvider = StateProvider<Widget>(
  (ref) => Route(routeNo: 'ルート${1}', busStops: routes[0]),
);


const List<Widget> options = <Widget>[
  Text('アラーム', style: TextStyle(fontSize: 16)),
  Text('マップ', style: TextStyle(fontSize: 16))
];
// Toggleのアラームとマップのどっちを選択しているかの状態を管理
final optionProvider = StateProvider<List<bool>>(
  (ref) => <bool>[true, false],
);
// 各ルートでアラームとマップのどっちを表示させるかの状態を管理
final optionWidgetProvider = StateProvider<Widget>(
  (ref) => Alarm(text: ('ルート${1}'), busStops: routes[0]),
);

// バス登録ページのWidget
class BusRegistration extends ConsumerWidget {
  const BusRegistration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeWidgets = routes.asMap().entries.map((entry) => Route(routeNo: 'ルート${entry.key + 1}', busStops: entry.value)).toList();

    final route = ref.watch(routeToggleProvider);
    final routeWidget = ref.watch(routeWidgetProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'バス登録',
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
          color: Color(0xFFFFE8AE),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      ref.read(routeToggleProvider.notifier).state =
                          List.generate(route.length, (i) => i == index);
                      ref.read(routeWidgetProvider.notifier).state = routeWidgets[index];
                            
                      // ルートを切り替える時、optionWidgetはアラームを表示させる
                      ref.read(optionProvider.notifier).state = [true, false];
                      ref.read(optionWidgetProvider.notifier).state = Alarm(text: 'ルート${index + 1}', busStops: routes[index]);
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderColor: Color(0xFFE2A5A4),
                    selectedBorderColor: Color(0xFFE2A5A4),
                    borderWidth: 2,
                    selectedColor: Colors.black,
                    fillColor: Color(0xFFE2A5A4),
                    color: Colors.black,
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 80.0,
                    ),
                    isSelected: route,
                    children: routes.asMap().entries.map((entry) => Text('ルート${entry.key + 1}', style: TextStyle(fontSize: 16))).toList(),
                  ),
                ),
              ),
              routeWidget,
            ],
          ),
        ),
      ),
    );
  }
}

// 各ルートを表示するためのウィジェット
class Route extends ConsumerWidget {
  const Route({super.key, required this.routeNo, required this.busStops});

  final String routeNo;         // ルート番号
  final List<String> busStops;  // バスのルート(バス停のリスト)

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionWidgets = <Widget>[Alarm(text: routeNo, busStops: busStops), RouteMap(text: routeNo, busStops: busStops)];

    final option = ref.watch(optionProvider);
    final optionWidget = ref.watch(optionWidgetProvider);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 200,
              child: SearchResult(text: Text('検索結果')),  // SearchResult(仮)
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE2A5A4), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFE2A5A4), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        ref.read(optionProvider.notifier).state =
                            List.generate(option.length, (i) => i == index);
                        ref.read(optionWidgetProvider.notifier).state = optionWidgets[index];
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderColor: Color(0xFFE2A5A4),
                      selectedBorderColor: Color(0xFFE2A5A4),
                      borderWidth: 2,
                      selectedColor: Colors.black,
                      fillColor: Color(0xFFE2A5A4),
                      color: Colors.black,
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 80.0,
                      ),
                      isSelected: option,
                      children: options,
                    ),
                  ),
                  optionWidget,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// バス到着アラーム
final busArrivalAlarmProvider = StateProvider<bool>(
  (ref) => false,
);
// 寝落ち防止アラーム
final wakeUpAlarmProvider = StateProvider<bool>(
  (ref) => false,
);

// 各ルートのアラームウィジェット
class Alarm extends ConsumerWidget {
  // バス停の情報を取得するための引数を追加する
  const Alarm({super.key, required this.text, required this.busStops});

  final String text;
  final List<String> busStops;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arrivalAlarm = ref.watch(busArrivalAlarmProvider);
    final wakeUpAlarm = ref.watch(wakeUpAlarmProvider);

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
              value: arrivalAlarm,
              onChanged: (bool value) {
                ref.read(busArrivalAlarmProvider.notifier).state = value;
              },
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFF4D9),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // border: Border.all(color: Color(0xFFE2A5A4), width: 2),
          ),
          width: 360,
          child: const Column(
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
              value: wakeUpAlarm,
              onChanged: (value) {
                ref.read(wakeUpAlarmProvider.notifier).state = value;
              },
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFF4D9),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // border: Border.all(color: Color(0xFFE2A5A4), width: 2),
          ),
          width: 360,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: busStops.map((busStop) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Switch(
                                value: false,
                                onChanged: (value) {},
                              ),
                              Text(busStop, style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Icon(Icons.south),
                          ),                    
                        ],
                      );
                    }).toList(),
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
  const RouteMap({super.key, required this.text, required this.busStops});

  final String text;
  final List<String> busStops;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text(text, style: TextStyle(fontSize: 16)));
  }
}