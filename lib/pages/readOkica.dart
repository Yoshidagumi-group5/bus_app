import 'dart:io';
import 'dart:typed_data';

import '../backgrounds/extensions.dart';
import '../backgrounds//form_row.dart';
import '../backgrounds/nfc_session.dart';
//import '../backgrounds/ndef_record.dart';
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
      if (tech is FeliCa) {
        final polling = await tech.polling(
          systemCode: tech.currentSystemCode,
          requestCode: FeliCaPollingRequestCode.noRequest,
          timeSlot: FeliCaPollingTimeSlot.max1,
        );
        additionalData!['manufacturerParameter'] =
            polling.manufacturerParameter;
      }
    }

    notifyListeners();
    return 'OKICAの読み取りが完了しました';
  }
}

class TagReadPage extends StatelessWidget {
  static Widget withDependency() => ChangeNotifierProvider<TagReadModel>(
        create: (context) => TagReadModel(),
        child: TagReadPage(),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TagReadModel>(
      create: (context) => TagReadModel(), // Provide TagReadModel here
      child: Scaffold(
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
            Consumer<TagReadModel>(builder: (context, model, _) {
              final tag = model.tag;
              final additionalData = model.additionalData;
              if (tag != null && additionalData != null)
                return _TagInfo(tag, additionalData);
              return SizedBox.shrink();
            }),
          ],
        ),
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
        final manufacturerParameter =
            additionalData['manufacturerParameter'] as Uint8List?;
        tagWidgets.add(FormRow(
          title: Text('Type'),
          subtitle: Text('FeliCa'),
        ));
        tagWidgets.add(FormRow(
          title: Text('Current IDm'),
          subtitle: Text('${tech.currentIDm.toHexString()}'),
        ));
        tagWidgets.add(FormRow(
          title: Text('Current System Code'),
          subtitle: Text('${tech.currentSystemCode.toHexString()}'),
        ));
        if (manufacturerParameter != null)
          tagWidgets.add(FormRow(
            title: Text('Manufacturer Parameter'),
            subtitle: Text('${manufacturerParameter.toHexString()}'),
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
