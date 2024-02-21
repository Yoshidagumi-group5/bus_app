import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<Widget> fruits = <Widget>[
  Text('Apple'),
  Text('Banana'),
  Text('Orange')
];

final fruitProvider = StateProvider<List<bool>>(
  (ref) => <bool>[true, false, false],
);

class BusRegistration extends ConsumerWidget {
  BusRegistration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fruit = ref.watch(fruitProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'バス登録',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) {
              // for (int i = 0; i < fruit.length; i++) {
              //   fruit[i] = i == index;
              // }
              ref.read(fruitProvider.notifier).state =
                  List.generate(fruit.length, (i) => i == index);
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            // selectedBorderColor: Colors.blue,
            selectedColor: Colors.black,
            fillColor: Colors.blue[300],
            color: Colors.black,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: fruit,
            children: fruits,
          ),
        ],
      ),
    );
  }
}
