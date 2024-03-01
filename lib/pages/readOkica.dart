import 'package:bus_app/pages/okica.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class ReadOkica extends StatelessWidget {
  const ReadOkica({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void _startNFCReading() async {
      try {
        bool isAvailable = await NfcManager.instance.isAvailable();

        //We first check if NFC is available on the device.
        if (isAvailable) {
          //If NFC is available, start an NFC session and listen for NFC tags to be discovered.
          NfcManager.instance.startSession(
            onDiscovered: (NfcTag tag) async {
              // Process NFC tag, When an NFC tag is discovered, print its data to the console.
              debugPrint('NFC Tag Detected: ${tag.data}');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Okica()),
              );
            },
          );
        } else {
          debugPrint('NFC not available.');
        }
      } catch (e) {
        debugPrint('Error reading NFC: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Reader'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _startNFCReading(),
          child: const Text('Start NFC Reading'),
        ),
      ),
    );
  }
}
