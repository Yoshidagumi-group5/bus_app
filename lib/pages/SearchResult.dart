// import 'dart:html';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResult extends ConsumerWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[100],
          centerTitle: true,
          title: const Text(
            "検索結果の一覧",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black38,
                          ),
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
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black38,
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
                                      padding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0),
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
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black38,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.0, bottom: 2.0),
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
                                                "なし",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                padding:
                    const EdgeInsets.only(right: 8.0, left: 8.0, top: 16.0),
                child: LimitedBox(
                  maxHeight: 540,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      busSearchResult(77, 500, 30, 3, '14:30', '15:30',
                          '沖縄高専入口', '那覇バスターミナル'),
                      busSearchResult(77, 500, 30, 3, '14:30', '15:30',
                          '沖縄高専入口', '那覇バスターミナル'),
                      busSearchResult(77, 500, 30, 3, '14:30', '15:30',
                          '沖縄高専入口', '那覇バスターミナル'),
                      busSearchResult(77, 500, 30, 3, '14:30', '15:30',
                          '沖縄高専入口', '那覇バスターミナル'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget busSearchResult(
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
          borderRadius: BorderRadius.circular(10),
          color: Colors.black38,
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
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Text(
                        busNum.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 4.0),
                  child: Text(
                    startBusStop,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        cost.toString() + "円　" + time.toString() + "分",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "約" + delayTime.toString() + "分遅れ",
                      style: TextStyle(
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
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        startTime,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        startBusStop,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "(那覇行き)",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        endTime,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        endBusStop,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
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
