import 'dart:io';
import 'dart:typed_data';

import '../backgrounds/extensions.dart';
import '../backgrounds/form_row.dart';
import '../backgrounds/nfc_session.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:provider/provider.dart';

class TagReadModel with ChangeNotifier {
  NfcTag? tag;

  Map<String, dynamic>? additionalData;

  Future<String?> handleTag(NfcTag tag) async {
    this.tag = tag;
    additionalData = {};
    Object? tech;

    // todo: more additional data
    if (Platform.isIOS) {
      tech = FeliCa.from(tag);
      final moneyServiceCode = Uint8List.fromList([0x50, 0xD7]);
      final serviceNotFound = Uint8List.fromList([0xff, 0xff]);
      final moneyBite = [
        for (int i = 0; i < 12; i++) Uint8List.fromList([0x80, i]),
      ];

      if (tech is FeliCa) {
        final polling = await tech.polling(
          systemCode: tech.currentSystemCode,
          requestCode: FeliCaPollingRequestCode.noRequest,
          timeSlot: FeliCaPollingTimeSlot.max1,
        );

        final requestServiceRes =
            await tech.requestService(nodeCodeList: [moneyServiceCode]);

        if (requestServiceRes == serviceNotFound) {
          additionalData!['Success'] = false;
        } else {
          additionalData!['Success'] = true;
        }

        final moneyRes = await tech.readWithoutEncryption(
            serviceCodeList: [moneyServiceCode], blockList: moneyBite);

        additionalData!['Money'] = moneyRes;
      }
    }

    notifyListeners();
    return '[Tag - Read] is completed.';
  }

  int parse(Uint8List rweRes) {
    if (rweRes[10] != 0x00) {
      throw Exception();
    }
    final blockSize = rweRes[12];
    const blockLength = 16;
    final data = List.generate(
        blockSize,
        (index) =>
            Uint8List.fromList(List.generate(blockLength, (index) => 0)));
    for (int i = 0; i < blockSize; i++) {
      final offset = 13 + i * blockLength;
      final tmp = rweRes.sublist(offset, offset + blockLength);
      data[i] = tmp;
    }
    final balanceData =
        Uint8List.fromList(data[0].sublist(0, 4).reversed.toList());
    return balanceData.buffer.asByteData().getInt32(0);
  }
}

class TagReadPage extends StatelessWidget {
  static Widget withDependency() => ChangeNotifierProvider<TagReadModel>(
        create: (context) => TagReadModel(),
        child: TagReadPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tag - Read'),
      ),
      body: ListView(
        padding: EdgeInsets.all(2),
        children: [
          FormSection(
            children: [
              FormRow(
                title: Text('Start Session',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                onTap: () => startSession(
                  context: context,
                  handleTag: Provider.of<TagReadModel>(context, listen: false)
                      .handleTag,
                ),
              ),
            ],
          ),
          // consider: Selector<Tuple<{TAG}, {ADDITIONAL_DATA}>>
          Consumer<TagReadModel>(builder: (context, model, _) {
            final tag = model.tag;
            final additionalData = model.additionalData;
            if (tag != null && additionalData != null)
              return _TagInfo(tag, additionalData);
            return SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

class _TagInfo extends StatelessWidget {
  _TagInfo(this.tag, this.additionalData);

  final NfcTag tag;

  final Map<String, dynamic> additionalData;

  @override
  Widget build(BuildContext context) {
    final tagWidgets = <Widget>[];
    final ndefWidgets = <Widget>[];

    Object? tech;

    if (Platform.isIOS) {
      tech = FeliCa.from(tag);
      if (tech is FeliCa) {
        tagWidgets.add(FormRow(
          title: Text('Credit'),
          subtitle: Text(additionalData["Money"].toString() + "円"),
        ));
        tagWidgets.add(FormRow(
          title: Text('Current IDm'),
          subtitle: Text('${tech.currentIDm.toHexString()}'),
        ));
        tagWidgets.add(FormRow(
          title: Text('Current System Code'),
          subtitle: Text('${tech.currentSystemCode.toHexString()}'),
        ));
      }
    }

    return Column(
      children: [
        FormSection(
          header: Text('TAG'),
          children: tagWidgets,
        ),
        if (ndefWidgets.isNotEmpty)
          FormSection(
            header: Text('NDEF'),
            children: ndefWidgets,
          ),
      ],
    );
  }
}
