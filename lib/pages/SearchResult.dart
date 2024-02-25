// import 'dart:html';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> searchResult = [
  "a",
  "b",
  "c",
  "d",
];

final List<StateProvider<bool>> colorProviders = <StateProvider<bool>>[
  for (int i = 0; i < searchResult.length; i++) StateProvider((ref) => false)
];

/*final colorProviders = StateProvider<List<bool>>((ref) {
  List<bool> result = [];
  for (int i = 0; i < searchResult.length; i++) {
    result.add(false);
    //debugPrint(result[i].toString());
  }
  return result;
});*/

class SearchResult extends ConsumerWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE8AE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBD2B2B),
        centerTitle: true,
        title: const Text(
          "検索結果の一覧",
          style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 16.0),
        //     child: Icon(
        //       Icons.star,
        //       size: 30,
        //       color: Colors.white,
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2A5A4)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "2024/02/19",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "出発：13:40",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10.0, right: 10.0),
                        child: Container(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2A5A4)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.subdirectory_arrow_right,
                                  size: 30,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 2.0, bottom: 2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "国立沖縄工業高等専門学校",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "那覇空港第二バスターミナル",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2A5A4)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 2.0, bottom: 2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "検索条件",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "乗り換えなし",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 16.0),
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    SearchResultClass(0, 77, 500, 30, 3, '14:30', '15:30',
                        '沖縄高専入口', '那覇バスターミナル'),
                    SearchResultClass(1, 77, 500, 30, 3, '14:30', '15:30',
                        '沖縄高専入口', '那覇バスターミナル'),
                    SearchResultClass(2, 77, 500, 30, 3, '14:30', '15:30',
                        '沖縄高専入口', '那覇バスターミナル'),
                    SearchResultClass(3, 77, 500, 30, 3, '14:30', '15:30',
                        '沖縄高専入口', '那覇バスターミナル'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFFBD2B2B),
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(
            Icons.replay_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SearchResultClass extends ConsumerWidget {
  const SearchResultClass(
      this.resultNum,
      this.busNum,
      this.cost,
      this.time,
      this.delayTime,
      this.startTime,
      this.endTime,
      this.startBusStop,
      this.endBusStop,
      {super.key});
  final int resultNum; //表示される結果一覧の内、何番目の結果か示す番号、バス登録ボタンなどに使用
  final int busNum; //バスの番号：77番
  final int cost; //バスの値段：500円
  final int time; //バスの所要時間：30分
  final int delayTime; //バスの遅延時間：3分遅れ
  final String startTime; //バスの発車時刻,14:30
  final String endTime; //バスの到着時刻,15:30
  final String startBusStop; //乗るバス停の名前：沖縄高専入口
  final String endBusStop; //降りるバス停の名前：那覇バスターミナル
  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE2A5A4)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE2A5A4)),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Text(
                        busNum.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                  child: Text(
                    startBusStop,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                BusRegisterationButton(
                  providers: colorProviders[resultNum],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$cost円　$time分",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFF4D9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "約$delayTime分遅れ",
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        startTime,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        startBusStop,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        "(那覇行き)",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        endTime,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        endBusStop,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        "(那覇行き)",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*Widget busSearchResult(
  int resultNum, //表示される結果一覧の内、何番目の結果か示す番号、バス登録ボタンなどに使用
  int busNum, //バスの番号：77番
  int cost, //バスの値段：500円
  int time, //バスの所要時間：30分
  int delayTime, //バスの遅延時間：3分遅れ
  String startTime, //バスの発車時刻,14:30
  String endTime, //バスの到着時刻,15:30
  String startBusStop, //乗るバス停の名前：沖縄高専入口
  String endBusStop, //降りるバス停の名前：那覇バスターミナル
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2A5A4)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE2A5A4)),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Text(
                      busNum.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
                child: Text(
                  startBusStop,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              BusRegisterationButton(
                  providers: colorProviders, searchResultNum: resultNum),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$cost円　$time分",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFF4D9),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "約$delayTime分遅れ",
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      startTime,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      startBusStop,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const Text(
                      "(那覇行き)",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      endTime,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      endBusStop,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const Text(
                      "(那覇行き)",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}*/

class BusRegisterationButton extends ConsumerWidget {
  const BusRegisterationButton({super.key, required this.providers});

  final StateProvider<bool> providers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(providers);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFE2A5A4)),
        child: IconButton(
          onPressed: () {
            ref.read(providers.notifier).state = !color;
          },
          icon: Icon(
            Icons.directions_bus_filled_sharp,
            color: color ? Colors.black : Colors.black45,
          ),
        ),
      ),
    );
  }
}
