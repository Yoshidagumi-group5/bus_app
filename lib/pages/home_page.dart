import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// マップ(のるところ/おりるところ)(仮)
class TestMap extends ConsumerWidget {
  const TestMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, '沖縄高専入口');
          },
          child: Text('ホームに戻る'),
        ),
      ),
    );
  }
}

// 「乗換あり」ボタンと「普通を外す」ボタンの状態管理
final transColorProvider = StateProvider<bool>((ref) => false);
final futsuColorProvider = StateProvider<bool>((ref) => false);

// 「じかん」ボタンの時間の管理
final selectedDateTimeProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

//「のるところ」「おりるところ」のテキストの管理
final leaveBusstopProvider = StateProvider<String>(
  (ref) => 'のるところ',
);
final arriveBusstopProvider = StateProvider<String>(
  (ref) => 'おりるところ',
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Future<DateTime> _selectDateTime(
      BuildContext context, DateTime selectedDateTime) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDateTime) {
      TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDateTime),
          initialEntryMode: TimePickerEntryMode.input);

      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }

    return selectedDateTime;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String leaveBusstop = ref.watch(leaveBusstopProvider);
    final String arriveBusstop = ref.watch(arriveBusstopProvider);
    final DateTime selectedDateTime = ref.watch(selectedDateTimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'ホーム',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFBD2B2B),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/shisa_touka_trimming.png',
                fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: CheckButton(
                      text: '乗換あり',
                      provider: transColorProvider,
                      iconData: Icons.directions_bus_outlined,
                    )),
                    Expanded(
                        child: CheckButton(
                      text: '高速バス',
                      provider: futsuColorProvider,
                      iconData: Icons.trending_up,
                    )),
                  ],
                ),
                TextButton(
                  text: 'じかん',
                  textSize: 30,
                  width: 200,
                  height: 70,
                  onPressed: () async {
                    ref.read(selectedDateTimeProvider.notifier).state =
                        await _selectDateTime(context, selectedDateTime);
                  },
                ),
                TextButton(
                  text: leaveBusstop,
                  textSize: 30,
                  width: 300,
                  height: 80,
                  onPressed: () async {
                    /** マップ(のるところ/おりるところ)とくっつけたらコメント外す
                     * 
                     * 画面遷移先で以下を実行する
                     *  Navigator.pop(context, "バス停の名前");
                     */
                    // ref.read(leaveBusstopProvider.notifier).state = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => TestMap()),
                    // );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // 「のるところ」と「おりるところ」の入れ替え
                      if (!(leaveBusstop == 'のるところ' ||
                          arriveBusstop == 'おりるところ')) {
                        String tmp = leaveBusstop;
                        ref.read(leaveBusstopProvider.notifier).state =
                            arriveBusstop;
                        ref.read(arriveBusstopProvider.notifier).state = tmp;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color.fromARGB(255, 226, 165, 164),
                            width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: const Size(120, 50)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.north,
                            size: 30, color: Color.fromARGB(255, 189, 43, 43)),
                        Icon(Icons.south,
                            size: 30, color: Color.fromARGB(255, 189, 43, 43))
                      ],
                    ),
                  ),
                ),
                TextButton(
                  text: arriveBusstop,
                  textSize: 30,
                  width: 300,
                  height: 80,
                  onPressed: () async {
                    /** 
                     * マップ(のるところ/おりるところ)とくっつけたらコメント外す
                     * 
                     * 画面遷移先で以下を実行する
                     *  Navigator.pop(context, "バス停の名前");
                     */
                    // ref.read(arriveBusstopProvider.notifier).state = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => TestMap()),
                    // );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      /** 
                       * feature/searchResultとマージしたときにコメント外す
                       */
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const SearchResult(selectedDateTime, leaveBusstop, arriveBusstop)),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFBD2B2A),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 226, 165, 164),
                            width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: const Size(200, 80)),
                    child: const Text(
                      'しらべる',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  const TextButton({
    super.key,
    required this.text,
    required this.textSize,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  final String text;
  final double textSize;
  final double width;
  final double height;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            side: const BorderSide(
                color: Color.fromARGB(255, 226, 165, 164), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: Size(width, height)),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textSize,
            color: const Color(0xFFBD2B2A),
          ),
        ),
      ),
    );
  }
}

class CheckButton extends ConsumerWidget {
  const CheckButton(
      {super.key,
      required this.text,
      required this.provider,
      required this.iconData});

  final String text;
  final StateProvider<bool> provider;
  final IconData iconData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(provider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer(builder: (context, WidgetRef ref, child) {
        return ElevatedButton(
          onPressed: () {
            ref.read(provider.notifier).state = !color;
          },
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: color ? const Color(0xFFBD2B2A) : Colors.white,
              side: const BorderSide(color: Color(0xFFE2A5A4), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fixedSize: const Size(150, 80)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 40,
                color: color ? Colors.white : const Color(0xFFBD2B2A),
              ),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color ? Colors.white : const Color(0xFFBD2B2A),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
