import 'package:bus_app/pages/bus_registration/alarm_widget.dart';
import 'package:bus_app/pages/bus_registration/map_widget_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// SearchResult(仮)
class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.text});

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Center(child: text);
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

// 各ルートの各バス停でのアラーム
final List<List<StateProvider<bool>>> busStopAlarmProviders = [
  for (int i = 0; i < routes.length; i++) ... {[
    for (int j = 0; j < routes[i].length; j++) StateProvider<bool>((ref) => false),
  ]},
];

// 表示するルートを切り替えるためのToggleの状態を管理
final routeToggleProvider = StateProvider<List<bool>>(  
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
  (ref) => Route(routeNo: 'ルート${1}', busStops: routes[0], busStopAlarmProvider: busStopAlarmProviders[0]),
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
  (ref) => Alarm(busStops: routes[0], busStopAlarmProvider: busStopAlarmProviders[0]),
);


// バス登録ページのWidget
class BusRegistration extends ConsumerWidget {
  const BusRegistration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<Widget> routeWidgets = <Widget>[
      for (int i = 0; i < routes.length; i++) Route(routeNo: 'ルート${i + 1}', busStops: routes[i], busStopAlarmProvider: busStopAlarmProviders[i])
    ];    

    final route = ref.watch(routeToggleProvider);
    final routeWidget = ref.watch(routeWidgetProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFE8AE),
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/shisa_touka_trimming.png', fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return ToggleButtons(
                            direction: Axis.horizontal,
                            onPressed: (int index) {
                              ref.read(routeToggleProvider.notifier).state =
                                  List.generate(route.length, (i) => i == index);
                              ref.read(routeWidgetProvider.notifier).state = routeWidgets[index];
                                    
                              // ルートを切り替える時、optionWidgetはアラームを表示させる
                              ref.read(optionProvider.notifier).state = [true, false];
                              ref.read(optionWidgetProvider.notifier).state = 
                                  Alarm(busStops: routes[index], busStopAlarmProvider: busStopAlarmProviders[index],);
                            },
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderColor: Color(0xFFE2A5A4),
                            selectedBorderColor: Color(0xFFE2A5A4),
                            borderWidth: 2,
                            selectedColor: Colors.black,
                            fillColor: Color(0xFFE2A5A4),
                            color: Colors.black,
                            constraints: BoxConstraints(
                              minHeight: 40.0,
                              minWidth: 80.0,
                            ),
                            isSelected: route,
                            children: routes.asMap().entries.map((entry) => Text('ルート${entry.key + 1}', style: const TextStyle(fontSize: 16))).toList(),
                          );
                        }
                      ),
                    ),
                  ),
                  routeWidget,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 各ルートを表示するためのウィジェット
class Route extends ConsumerWidget {
  const Route({super.key, required this.routeNo, required this.busStops, required this.busStopAlarmProvider});


  /** routeMapができあがったらrouteNoは消す */
  final String routeNo;         // ルート番号
  final List<String> busStops;  // バスのルート(バス停のリスト)
  final List<StateProvider<bool>> busStopAlarmProvider; // 各バス停のアラームのon/off

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionWidgets = <Widget>[
      Alarm(busStops: busStops, busStopAlarmProvider: busStopAlarmProvider),
      RouteMap(text: routeNo, busStops: busStops)
    ];

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
                border: Border.all(color: const Color(0xFFE2A5A4), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE2A5A4), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      return ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          ref.read(optionProvider.notifier).state =
                              List.generate(option.length, (i) => i == index);
                          ref.read(optionWidgetProvider.notifier).state = optionWidgets[index];
                        },
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        borderColor: const Color(0xFFE2A5A4),
                        selectedBorderColor: const Color(0xFFE2A5A4),
                        borderWidth: 2,
                        selectedColor: Colors.black,
                        fillColor: const Color(0xFFE2A5A4),
                        color: Colors.black,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: option,
                        children: options,
                      );
                    }
                  ),
                  optionWidget
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
