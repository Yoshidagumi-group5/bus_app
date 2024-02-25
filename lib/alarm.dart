import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

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
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint('テスト');
                FlutterRingtonePlayer.play(
                  fromAsset: 'assets/alarms/${alarms[2]}.mp3',
                  asAlarm: true,
                  looping: false,
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("タイトル"),
                      content: Text("メッセージ内容"),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(alarms[2]),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterRingtonePlayer.stop();
              },
              child: Text('ストップ'),
            ),
          ],
        ),
      ),
    );
  }
}
