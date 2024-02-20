import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<Widget> fruits = <Widget>[
  Text('Apple'),
  Text('Banana'),
  Text('Orange')
];

class ToggleButtonsSample extends StatefulWidget {
  const ToggleButtonsSample({super.key, required this.title});

  final String title;

  @override
  State<ToggleButtonsSample> createState() => _ToggleButtonsSample();
}

class _ToggleButtonsSample extends State<ToggleButtonsSample> {
  // const _BusRegistration({super.key});

  final List<bool> _selectedFruits = <bool>[true, false, false];
  // bool vertical = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'バス登録',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            // The button that is tapped is set to true, and the others to false.
            for (int i = 0; i < _selectedFruits.length; i++) {
              _selectedFruits[i] = i == index;
            }
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        selectedBorderColor: Colors.red[700],
        selectedColor: Colors.white,
        fillColor: Colors.red[200],
        color: Colors.red[400],
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        isSelected: _selectedFruits,
        children: fruits,
      ),
    );
  }
}