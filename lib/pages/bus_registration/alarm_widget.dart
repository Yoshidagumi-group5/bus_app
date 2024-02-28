import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';

// バス到着アラーム
final busArrivalAlarmProvider = StateProvider<bool>(
  (ref) => false,
);
// 寝落ち防止アラーム
final wakeUpAlarmProvider = StateProvider<bool>(
  (ref) => false,
);

// 寝落ち防止アラームのon/offのウィジェット
final wakeUpAlarmWidgetProvider = StateProvider<Widget>(
  (ref) => WakeUpAlarmOff(),
);

// 各ルートのアラームウィジェット
class Alarm extends ConsumerStatefulWidget {
  // バス停の情報を取得するための引数を追加する
  const Alarm({super.key, required this.busStops, required this.busStopAlarmProvider});

  // final String text;
  final List<String> busStops;
  final List<StateProvider<bool>> busStopAlarmProvider;

  @override
  ConsumerState<Alarm> createState() => _AlarmState();
}

class _AlarmState extends ConsumerState<Alarm> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); // 追加

  @override
  void initState() {
    super.initState();

    _requestIOSPermission();  // iOSでの通知の許可
    _initializePlatformSpecifics(); // macOS(Darwin プラットフォーム)用の通知の初期化
    // _showNotification();
    // _scheduleNotification();

    // タイムゾーンデータベースの初期化
    tz.initializeTimeZones();
    // ローカルロケーションのタイムゾーンを東京に設定
    tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));
  }

  // iOSでの通知の許可
  void _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: false,
          badge: true,
          sound: false,
        );
  }

  // macOS(Darwin プラットフォーム)用の通知の初期化
  void _initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse res) {
      debugPrint('payload:${res.payload}');
    });
  }

  // 通知を表示させる
  Future<void> _showNotification(int id, String title, String body) async {
    var androidChannelSpecifics = const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iosChannelSpecifics = DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      id, // Notification ID
      title, // Notification Title
      body, // Notification Body, set as null to remove the body
      platformChannelSpecifics,
      payload: 'New Payload', // Notification Payload
    );
  }

  Future<void> _scheduleNotification(int id, String title, String body) async {
    // 5秒後
    var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 5));

    var androidChannelSpecifics = const AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      channelDescription: "CHANNEL_DESCRIPTION 1",
      icon: 'app_icon',
      //sound: RawResourceAndroidNotificationSound('my_sound'),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iosChannelSpecifics = DarwinNotificationDetails(
      //sound: 'my_sound.aiff',
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
      iOS: iosChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleNotificationDateTime, tz.local),// 5秒後に表示
      platformChannelSpecifics,
      payload: 'Test Payload',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {


    /** 実装するときは OriginalAlarm() を使う */
    // final alarm = OriginalAlarm();
    final alarm = TestAlarm();

    final bool arrivalAlarm = ref.watch(busArrivalAlarmProvider);
    final bool wakeUpAlarm = ref.watch(wakeUpAlarmProvider);
    final wakeUpAlarmWidget = ref.watch(wakeUpAlarmWidgetProvider);

    // 寝落ち防止アラームのon/offのウィジェット
    final wakeUpAlarmWidgets = [
      WakeUpAlarmOff(),
      WakeUpAlarmOn(
        busStops: widget.busStops,
        busStopAlarmProvider: widget.busStopAlarmProvider
      )
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'バス到着アラーム',
              style: TextStyle(fontSize: 25),
            ),
            Consumer(
              builder: (context, ref, child) {
                return Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Color(0xFFBD2B2A),
                  value: arrivalAlarm,
                  onChanged: (bool value) async {
                    ref.read(busArrivalAlarmProvider.notifier).state = value;
                    if (value) {
                      // await alarm.start(3);
                      /** バックエンドからもらった値を入れる */
                      _scheduleNotification(0, 'バス到着まであと${5}分です', 'バス停に向かいましょう');
                      
                      Vibration.vibrate();
                      // if (await Vibration.hasVibrator() ?? false) {
                      //   Vibration.vibrate();
                      // }
                      
                      // if (context.mounted) {
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: const Text("あと${5}分"),
                      //         content: const Text("バス到着まであと${5}分です"),
                      //         actions: [
                      //           ElevatedButton(
                      //             onPressed: () {
                      //               alarm.stop();
                      //               Vibration.cancel();
                      //               Navigator.pop(context);
                      //             },
                      //             child: const Text('ストップ'),
                      //           ),
                      //         ],
                      //       );
                      //     }
                      //   );
                      // }
                    }
                  },
                );
              }
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
              style: TextStyle(fontSize: 25),
            ),
            Switch(
              value: wakeUpAlarm,
              onChanged: (value) {
                ref.read(wakeUpAlarmProvider.notifier).state = value;
                ref.read(wakeUpAlarmWidgetProvider.notifier).state = wakeUpAlarmWidgets[value ? 1 : 0];
              },
            ),
          ],
        ),
        wakeUpAlarmWidget,
      ],
    );
  }
}

class WakeUpAlarmOn extends ConsumerWidget {
  const WakeUpAlarmOn({
    super.key,
    required this.busStops,
    required this.busStopAlarmProvider
  });

  final List<String> busStops;
  final List<StateProvider<bool>> busStopAlarmProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<bool> busStopAlarms = <bool>[
      for (int i = 0; i < busStopAlarmProvider.length; i++) ref.watch(busStopAlarmProvider[i])
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFF4D9),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 360,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < busStops.length - 1; i++) ... {
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Switch(
                              value: busStopAlarms[i],
                              onChanged: (value) {
                                ref.read(busStopAlarmProvider[i].notifier).state = value;

                                if (value) {
                                  // _scheduleNotification(i, 'title', 'body');
                                }

                              },
                            ),
                            Text(busStops[i], style: const TextStyle(fontSize: 20)),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Icon(Icons.south),
                        ),
                      ],
                    )
                  },
                  Row(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          return Switch(
                            value: busStopAlarms[busStopAlarms.length - 1],
                            onChanged: (value) {
                              ref.read(busStopAlarmProvider[busStops.length - 1].notifier).state = value;
                            },
                          );
                        }
                      ),
                      Text(busStops[busStops.length - 1], style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ]
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WakeUpAlarmOff extends ConsumerWidget {
  const WakeUpAlarmOff({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF4D9),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: 360,
      child: Center(
        child: Text('寝落ち防止アラームはオフです', style: TextStyle(fontSize: 20))
      ),
    );
  }
}

// 実装するときに使うクラス(分ごとで設定できる)
class OriginalAlarm {
  Future<dynamic> start(int minutes) async {
    await Future.delayed(Duration(minutes: minutes));
    FlutterRingtonePlayer.play(
      fromAsset: 'assets/alarms/Clock-Alarm05-3(Mid-Loop).mp3',
      asAlarm: true,
      looping: true
    );
  }

  Future<void> stop() async {
    FlutterRingtonePlayer.stop();
  }
}
// アラームを試すときにつ使うクラス(秒ごとで設定できる)
class TestAlarm {
  Future<dynamic> start(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    FlutterRingtonePlayer.play(
      fromAsset: 'assets/alarms/Clock-Alarm05-3(Mid-Loop).mp3',
      asAlarm: true,
      looping: true
    );
  }

  Future<void> stop() async {
    FlutterRingtonePlayer.stop();
  }
}
