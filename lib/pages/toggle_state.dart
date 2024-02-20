import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleState extends ChangeNotifier {
  final List<bool> toggleState = [false, false, false];

  void changeState() {
    for (int i = 0; i < toggleState.length; i++) {
      toggleState[i] = i == index;
    }
  }
}