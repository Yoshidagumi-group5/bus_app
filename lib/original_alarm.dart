import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

// List<String> alarms = [
//   'Clock-Alarm05-1(Mid)',
//   'Clock-Alarm05-2(Low)',
//   'Clock-Alarm05-3(Mid-Loop)',
//   'Clock-Alarm05-4(Low-Loop)',
//   'Clock-Alarm05-5(Toggle)',
//   'Clock-Alarm05-6(Far-Mid)',
//   'Clock-Alarm05-7(Far-Low)',
//   'Clock-Alarm05-8(Far-Mid-Loop)',
//   'Clock-Alarm05-9(Far-Low-Loop)',
// ];

class OriginalAlarm {
  Future<void> start(int seconds) async {
    await Future.delayed(Duration(minutes: 0, seconds: seconds));
    FlutterRingtonePlayer.play(
      fromAsset: 'assets/alarms/Clock-Alarm05-3(Mid-Loop).mp3',
      asAlarm: true,
      looping: false
    );
  }

  Future<void> stop() async {
    FlutterRingtonePlayer.stop();
  }
}

// class AlarmTest extends ConsumerWidget {
//   const AlarmTest({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final alarm = OriginalAlarm();

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text(alarms[2]),
//               onPressed: () async {
//                 await alarm.start(3);
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text("あと${5}分"),
//                       content: Text("バス到着まであと${5}分です"),
//                       actions: [
//                         ElevatedButton(
//                           onPressed: () {
//                             alarm.stop();
//                             Navigator.pop(context);
//                           },
//                           child: Text('ストップ'),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
