import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

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
