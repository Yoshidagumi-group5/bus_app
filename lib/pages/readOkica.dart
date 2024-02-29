import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

class ReadOkica extends StatelessWidget {
  const ReadOkica({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NFCReadPage(),
    );
  }
}

class NFCReadPage extends StatefulWidget {
  const NFCReadPage({Key? key}) : super(key: key);

  @override
  _NFCReadPage createState() => _NFCReadPage();
}

class _NFCReadPage extends State<NFCReadPage> {
  String msg = "plane";

  void changeMsg(String message) {
    setState(() {
      msg = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(msg),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _startNFCReading,
              child: const Text('Start NFC Reading'),
            ),
          ],
        ),
      ),
    );
  }

  void _startNFCReading() async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();

      //We first check if NFC is available on the device.
      if (isAvailable) {
        //If NFC is available, start an NFC session and listen for NFC tags to be discovered.
        NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            // Process NFC tag, When an NFC tag is discovered, print its data to the console.
            changeMsg('NFC Tag Detected: ${tag.data}');
          },
        );
      } else {
        changeMsg('NFC not available.');
      }
    } catch (e) {
      changeMsg('Error reading NFC: $e');
    }
  }
}
