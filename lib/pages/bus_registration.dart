import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class Test1 extends StatelessWidget {
  const Test1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('test1');
  }
}


const List<Widget> routes = <Widget>[
  Text('ルート１'),
  Text('ルート２'),
  Text('ルート３')
];

final routeProvider = StateProvider<List<bool>>(
  (ref) => <bool>[true, false, false],
);

class BusRegistration extends ConsumerWidget {
  BusRegistration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routeProvider);

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
              // for (int i = 0; i < route.length; i++) {
              //   route[i] = i == index;
              // }
              ref.read(routeProvider.notifier).state =
                  List.generate(route.length, (i) => i == index);
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
            isSelected: route,
            children: routes,
          ),
          Container(
            color: Colors.black38,
            width: double.infinity,
            height: 300,
            child: Test1(),
          ),
        ],
      ),
    );
  }
}
