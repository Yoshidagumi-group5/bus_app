import 'dart:html';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchResult extends ConsumerWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[100],
          centerTitle: true,
          leading: const Icon(
            Icons.clear_rounded,
            size: 30,
          ),
          title: const Text(
            "検索結果の一覧",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.star,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
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
              LimitedBox(
                maxHeight: 540,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.map),
                      title: Text('Map'),
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_album),
                      title: Text('Album'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
