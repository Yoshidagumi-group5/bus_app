import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bus_app/pages/original_alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> setup() async {
  tz.initializeTimeZones();
  var tokyo = tz.getLocation('Asia/Tokyo');
  tz.setLocalLocation(tokyo);
}

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
    final routeWidgets =
        routes.asMap().entries.map(
          (entry) => Route(routeNo: 'ルート${entry.key + 1}', busStops: entry.value)
        ).toList();

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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('assets/images/shisa_touka_trimming.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
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
                    isSelected: route,
                    children: routes.asMap().entries.map((entry) => Text('ルート${entry.key + 1}', style: const TextStyle(fontSize: 16))).toList(),
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
                  ToggleButtons(
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
  Alarm({super.key, required this.text, required this.busStops});

  final String text;
  final List<String> busStops;
  
  // インスタンス生成
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // ローカル通知をスケジュールする
  void _scheduleLocalNotification() async {
    tz.initializeTimeZones();
    var tokyo = tz.getLocation('Asia/Tokyo');
    tz.setLocalLocation(tokyo);
    
    // 初期化
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('app_icon'), // app_icon.pngを配置
        // iOS: IOSInitializationSettings()
      ),
    );
    // スケジュール設定する
    int id = (math.Random()).nextInt(10);
    flutterLocalNotificationsPlugin.zonedSchedule(
        id, // id
        'Local Notification Title $id', // title
        'Local Notification Body $id', // body
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), // 5秒後設定
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'my_channel_id', 'my_channel_name',
            channelDescription: 'my_channel_description',
            importance: Importance.max,
            priority: Priority.high
          ),
          // iOS: IOSNotificationDetails()
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarm = OriginalAlarm();

    final arrivalAlarm = ref.watch(busArrivalAlarmProvider);
    final wakeUpAlarm = ref.watch(wakeUpAlarmProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'バス到着アラーム',
              style: TextStyle(fontSize: 25),
            ),
            Switch(
              value: arrivalAlarm,
              onChanged: (bool value) async {
                ref.read(busArrivalAlarmProvider.notifier).state = value;
                if (value) {
                  debugPrint('setupまえ');
                  await setup();
                  debugPrint('setupあと');
                  await alarm.start(3);
                  debugPrint('アラームあと');
                  _scheduleLocalNotification();
                  debugPrint('通知あと');
                  if (context.mounted) {
                    debugPrint('ダイアログ表示まえ');
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("あと${5}分"),
                          content: const Text("バス到着まであと${5}分です"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                alarm.stop();
                                Navigator.pop(context);
                              },
                              child: const Text('ストップ'),
                            ),
                          ],
                        );
                      }
                    );
                    debugPrint('ダイアログ表示あと');
                  }
                }
              },
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFF4D9),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    '${10}',  // データベースから受け取った時間を入れる
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    '分',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Text(
                'バス現在地　${'どこどこ'}',  // データベースから受け取ったバス停を入れる
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
          decoration: const BoxDecoration(
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
                              Text(busStop, style: const TextStyle(fontSize: 20)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
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
    return Center(child: Text(text, style: const TextStyle(fontSize: 16)));
  }
}