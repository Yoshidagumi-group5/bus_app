import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

Future<void> startSession({
  required BuildContext context,
  required Future<String?> Function(NfcTag) handleTag,
  String alertMessage = 'OKICAをスマートフォンにかざしてください',
}) async {
  if (!(await NfcManager.instance.isAvailable())) {
    return showDialog(
      context: context,
      builder: (context) => _UnavailableDialog(),
    );
  }

  if (Platform.isIOS) {
    return NfcManager.instance.startSession(
      alertMessage: alertMessage,
      onDiscovered: (tag) async {
        try {
          final result = await handleTag(tag);
          if (result == null) return;
          await NfcManager.instance.stopSession(alertMessage: "読取が成功しました");
        } catch (e) {
          await NfcManager.instance.stopSession(errorMessage: '読取に失敗しました');
        }
      },
    );
  }

  throw ('unsupported platform: ${Platform.operatingSystem}');
}

class _UnavailableDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('エラー'),
      content: const Text('お使いの端末がNFC機能に対応していない、またはNFC機能を有効にしていません'),
      actions: [
        TextButton(
          child: const Text('閉じる'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
