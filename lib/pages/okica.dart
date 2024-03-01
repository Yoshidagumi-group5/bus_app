import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

class Okica extends StatefulWidget {
  const Okica({Key? key}) : super(key: key);

  @override
  State<Okica> createState() => _OkicaState();
}

class _OkicaState extends State<Okica> {
  @override
  void initState() {
    super.initState();
    const NfcReadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE8AE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBD2B2B),
        centerTitle: true,
        title: const Text(
          "現在の残高",
          style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, right: 40.0, left: 40.0),
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFE2A5A4), width: 3),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 30.0,
                          ),
                          child: Text(
                            "1000",
                            style: TextStyle(
                                fontSize: 80, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                            ),
                            const Text(
                              "円",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '利用履歴',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10),
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFE2A5A4), width: 3),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        History("2024/04/01", "沖縄高専前", "名護十字路"),
                        History("2024/05/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        History("2024/06/01", "沖縄高専前", "名護十字路"),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  const History(this.date, this.startBusStop, this.endBusStop, {super.key});

  final String date;
  final String startBusStop;
  final String endBusStop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        right: 15.0,
        left: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFFFF4D9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 16.0),
                  child: Text(
                    date,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 6.0,
                left: 6.0,
                bottom: 20.0,
                top: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            startBusStop,
                          )),
                    ),
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        endBusStop,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NfcReadPage extends StatefulWidget {
  const NfcReadPage({Key? key}) : super(key: key);

  @override
  State<NfcReadPage> createState() => _NfcReadPageState();
}

class _NfcReadPageState extends State<NfcReadPage> {
  int balance = 0;

  @override
  void initState() {
    super.initState();
    _initializeNfcSession();
  }

  void _initializeNfcSession() {
    NfcManager.instance.startSession(
      onDiscovered: (tag) async {
        final systemCode = [0x8F, 0xC1];
        final serviceCode = [0x50, 0xD7];
        final pollingRes = await polling(tag, systemCode: systemCode);
        final idm = pollingRes.sublist(2, 10);
        final requestServiceRes = await requestService(
          tag,
          idm: idm,
          serviceCode: serviceCode,
        );
        // Check if data exists and retrieve balance information
        if (requestServiceRes[11] == 00 && requestServiceRes[12] == 0) {
          final readWithoutEncryptionRes = await readWithoutEncryption(
            tag,
            idm: idm,
            serviceCode: serviceCode,
            blockCount: 1,
          );
          final balance = parse(readWithoutEncryptionRes);
          setState(() {
            this.balance = balance;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build UI based on current balance
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$balance 円'),
              ElevatedButton(
                onPressed: () {
                  // You can trigger the NFC session again here if needed
                },
                child: const Text('読み込む'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Polling
Future<Uint8List> polling(
  NfcTag tag, {
  required List<int> systemCode,
}) async {
  final List<int> packet = [];
  if (Platform.isAndroid) {
    packet.add(0x06);
  }
  packet.add(0x00);
  packet.addAll(systemCode.reversed);
  packet.add(0x01);
  packet.add(0x0F);

  final command = Uint8List.fromList(packet);

  late final Uint8List? res;

  if (NfcF.from(tag) != null) {
    final nfcf = NfcF.from(tag);
    res = await nfcf?.transceive(data: command);
  } else if (FeliCa.from(tag) != null) {
    final felica = FeliCa.from(tag);
    res = await felica?.sendFeliCaCommand(command);
  }
  if (res == null) {
    throw Exception();
  }
  return res;
}

/// RequestService
Future<Uint8List> requestService(
  NfcTag tag, {
  required Uint8List idm,
  required List<int> serviceCode,
}) async {
  final nodeCodeList = Uint8List.fromList(serviceCode);
  final List<int> packet = [];
  if (Platform.isAndroid) {
    packet.add(0x06);
  }
  packet.add(0x02);
  packet.addAll(idm);
  packet.add(nodeCodeList.elementSizeInBytes);
  packet.addAll(serviceCode.reversed);

  final command = Uint8List.fromList(packet);

  late final Uint8List? res;

  if (NfcF.from(tag) != null) {
    final nfcf = NfcF.from(tag);
    res = await nfcf?.transceive(data: command);
  } else if (FeliCa.from(tag) != null) {
    final felica = FeliCa.from(tag);
    res = await felica?.sendFeliCaCommand(command);
  }
  if (res == null) {
    throw Exception();
  }
  return res;
}

/// ReadWithoutEncryption
Future<Uint8List> readWithoutEncryption(
  NfcTag tag, {
  required Uint8List idm,
  required List<int> serviceCode,
  required int blockCount,
}) async {
  final List<int> packet = [];
  if (Platform.isAndroid) {
    packet.add(0);
  }
  packet.add(0x06);
  packet.addAll(idm);
  packet.add(serviceCode.length ~/ 2);
  packet.addAll(serviceCode.reversed);
  packet.add(blockCount);

  for (int i = 0; i < blockCount; i++) {
    packet.add(0x80);
    packet.add(i);
  }
  if (Platform.isAndroid) {
    packet[0] = packet.length;
  }

  final command = Uint8List.fromList(packet);

  late final Uint8List? res;

  if (NfcF.from(tag) != null) {
    final nfcf = NfcF.from(tag);
    res = await nfcf?.transceive(data: command);
  } else if (FeliCa.from(tag) != null) {
    final felica = FeliCa.from(tag);
    res = await felica?.sendFeliCaCommand(command);
  }
  if (res == null) {
    throw Exception();
  }
  return res;
}

/// バイトデータの変換
int parse(Uint8List rweRes) {
  if (rweRes[10] != 0x00) {
    throw Exception();
  }
  final blockSize = rweRes[12];
  const blockLength = 16;
  final data = List.generate(blockSize,
      (index) => Uint8List.fromList(List.generate(blockLength, (index) => 0)));
  for (int i = 0; i < blockSize; i++) {
    final offset = 13 + i * blockLength;
    final tmp = rweRes.sublist(offset, offset + blockLength);
    data[i] = tmp;
  }
  final balanceData =
      Uint8List.fromList(data[0].sublist(0, 4).reversed.toList());
  return balanceData.buffer.asByteData().getInt32(0);
}
