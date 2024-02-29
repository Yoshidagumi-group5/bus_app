/*
実行例
00 8B
I/flutter (32087): 00 00 00 00 00 00 00 00 32 00 00 B2 29 00 2E B1
09 0F
I/flutter (32087): 16 01 00 17 2D 64 8F 43 D9 52 B2 29 00 2E B1 A0
I/flutter (32087): 16 01 00 02 2D 64 FA B3 FA BE D4 2A 00 2E AF A0
I/flutter (32087): 1A 06 00 0E 2D 64 D9 52 D9 52 EC 2B 00 2E AD A0
I/flutter (32087): C8 46 00 00 2D 63 5C 84 01 35 EC 2B 00 2E AB 00
I/flutter (32087): C8 46 00 00 2D 62 A9 04 01 35 F4 2D 00 2E AA 00
I/flutter (32087): 16 01 00 17 2D 62 8F 43 D9 52 FC 2F 00 2E A9 A0
I/flutter (32087): 16 01 00 17 2D 62 D9 52 8F 43 1E 31 00 2E A7 A0
I/flutter (32087): 16 01 00 17 2D 61 8F 43 D9 52 40 32 00 2E A5 A0
I/flutter (32087): 16 01 00 17 2D 61 D9 52 8F 43 62 33 00 2E A3 A0
I/flutter (32087): 16 01 00 17 2D 5F 8F 43 D9 52 84 34 00 2E A1 A0
I/flutter (32087): 16 01 00 17 2D 5F D9 52 8F 43 A6 35 00 2E 9F A0
I/flutter (32087): 08 02 00 00 2D 5E FA B3 00 00 C8 36 00 2E 9D 80
*/

import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

class ReadOkica extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<ReadOkica> {
  String _message = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
            body: SafeArea(
          child: Stack(children: myWidgets()),
        )));
  }

  List<Widget> myWidgets() {
    return <Widget>[
      Positioned(
        bottom: 60.0,
        left: 0.0,
        right: 0,
        child: IconButton(
          icon: Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
          onPressed: () => onStart(),
        ),
      ),
      Positioned(
          left: 30,
          right: 30,
          top: 50,
          bottom: 120,
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(_message, style: TextStyle(fontSize: 20)),
          )),
    ];
  }

  /// onStart
  Future onStart() async {
    await NfcManager.instance.startSession(
      alertMessage: "ICカードをかざしてください",
      onDiscovered: (tag) async {
        try {
          final card = FeliCa.from(tag);
          if (card == null) {
            throw Exception("未サポートのICカードです");
          }
          // TODO: この辺で履歴とか読み取る
          setState(() {
            // TODO: 履歴をstateに反映する
          });
        } catch (e, st) {
          print(e);
          print(st);
          NfcManager.instance.stopSession(errorMessage: "読み取りに失敗しました");
        }
        NfcManager.instance.stopSession(alertMessage: "読み取り成功しました");
      },
    );
  }
}
