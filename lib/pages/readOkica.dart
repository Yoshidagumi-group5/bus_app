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

  msg(String s) {
    print(s);
    setState(() {
      _message = s;
    });
  }

  /// onStart
  Future onStart() async {
    if (NfcManager.instance.isAvailable() == false) {
      msg('NFC is not available');
      return;
    }
    msg('Please touch Okica');
    try {
      await NfcManager.instance.startSession(
        alertMessage: "Please touch Suica",
        onDiscovered: (tag) async {
          try {
            await onDiscoveredForIos(tag);
          } catch (e) {
            msg('Error\n${e.toString()}');
            NfcManager.instance
                .stopSession(errorMessage: 'Error ${e.toString()}');
          }
          print('stopSession');
          NfcManager.instance.stopSession();
        },
      );
    } catch (e) {
      msg('Error\n${e.toString()}');
    }
  }

  /// iOS向け
  Future onDiscoveredForIos(NfcTag tag) async {
    final felica = FeliCa.from(tag);
    if (felica == null) {
      msg("Unsupported card for type FeliCa");
      return;
    }

    // 属性情報(008B)から残高を取得
    final res = await felica.readWithoutEncryption(
      serviceCodeList: [
        Uint8List.fromList([0x8b, 0x00])
      ],
      blockList: [
        Uint8List.fromList([0x80, 0])
      ],
    );
    // 残高[11][12]
    int balance = -1;
    if (res.blockData.length > 0) {
      balance = res.blockData[0][12] * 256 + res.blockData[0][11];
    }

    // 利用履歴(090F)から履歴20件を取得 ※一度に12件まで
    final list1 = [
      for (int i = 0; i < 12; i++) Uint8List.fromList([0x80, i])
    ];
    final res1 = await felica.readWithoutEncryption(
      serviceCodeList: [
        Uint8List.fromList([0x0f, 0x09])
      ],
      blockList: list1,
    );
    final list2 = [
      for (int i = 12; i < 20; i++) Uint8List.fromList([0x80, i])
    ];
    final res2 = await felica.readWithoutEncryption(
      serviceCodeList: [
        Uint8List.fromList([0x0f, 0x09])
      ],
      blockList: list2,
    );
    final blocklist = [...res1.blockData, ...res2.blockData];

    String histories = '';
    for (List<int> b in blocklist) {
      // 年月日[4][5](7bit 4bit 5bit)
      int idate = b[4] * 256 + b[5];
      String y = ((idate & 0xFE00) >> 9).toString();
      String m = ((idate & 0x01E0) >> 5).toString().padLeft(2, '0');
      String d = ((idate & 0x001F) >> 0).toString().padLeft(2, '0');
      histories += '${y}-${m}-${d}';
      // 残高[10][11]
      histories +=
          '  ' + (b[11] * 256 + b[10]).toString().padLeft(5, ' ') + ' yen';
      histories += '\n';
    }

    String s = '';
    s += 'IDm ${intlist_to_string(felica.currentIDm)}\n';
    s += 'SystemCode ${intlist_to_string(felica.currentSystemCode)}\n';
    s += 'Balance ${balance} yen\n';
    s += histories;
    msg(s);

    NfcManager.instance.stopSession(alertMessage: 'Succeeded');
  }

  /// Uint8Listを16進数の文字列に変換（デバッグ用）
  String intlist_to_string(List<int> list) {
    String s = '';
    for (int i in list) {
      s += i.toRadixString(16).toUpperCase().padLeft(2, '0') + ' ';
    }
    return s;
  }
}
