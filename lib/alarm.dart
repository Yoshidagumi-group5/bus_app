import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> alarms = [
  'Clock-Alarm05-1(Mid)',
  'Clock-Alarm05-2(Low)',
  'Clock-Alarm05-3(Mid-Loop)',
  'Clock-Alarm05-4(Low-Loop)',
  'Clock-Alarm05-5(Toggle)',
  'Clock-Alarm05-6(Far-Mid)',
  'Clock-Alarm05-7(Far-Low)',
  'Clock-Alarm05-8(Far-Mid-Loop)',
  'Clock-Alarm05-9(Far-Low-Loop)',
];

class AlarmTest extends ConsumerWidget {
  const AlarmTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: alarms.map((alarmName) => Alarms(alarmPath: alarmName,)).toList(),
        ),
      ),
    );
  }
}

class Alarms extends ConsumerWidget {
  const Alarms({super.key, required this.alarmPath});

  final String alarmPath;

  Future<void> alarmSet() async {
    await Alarm.init();

    // アラームの設定を作成
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: DateTime.now().add(const Duration(seconds: 3)),
      assetAudioPath: 'assets/alarms/$alarmPath.mp3',
      loopAudio: false,
      vibrate: true,
      fadeDuration: 3.0,
      notificationTitle: 'This is the title',
      notificationBody: 'This is the body',
      enableNotificationOnKill: true,
    );

    // アラームを登録
    await Alarm.set(alarmSettings: alarmSettings);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      child: Text('$alarmPath'),
      onPressed: () {
        alarmSet();
      },
    );
  }
}